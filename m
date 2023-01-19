Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C39673F58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjASQwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 11:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjASQwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:52:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373098C90B;
        Thu, 19 Jan 2023 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6baCIjpxFWqtburgiU9owFRWWB+OsgVl9mMP/UXy3Fs=; b=ON5gWcaPIXHKSUs8dzkEuU5BPU
        E2GWyQaoM8UfBF+ZUDUdpuHhHlruqqIPtXHXqmt+mgvZT1sfp/Dh0QYYtv2EUSpmtbOvQZLPRuJDO
        5rWOkb7+GjTsosErJw2uBcDWrKvIzPiVH3/m+o520DwKyYx5EVdHyAupcLIbnC8ax1bfl4/LCZOE/
        GNuUEi9vWjW7bG0yw/aC4oKTIOCFNi6C6xwYQFFB+at8qozQ4lMz0zQ0PKxqVsnII/NJuzbkxRvV+
        OkCSI8sUeM/EFMa85/AeOdvJSQbuHiWCZcTkuDZgOl+X1ZeqLuTwmm/2beh/7wE1bCpVozxEBUane
        //PIDckA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIY8t-0066Rw-Pc; Thu, 19 Jan 2023 16:51:59 +0000
Date:   Thu, 19 Jan 2023 08:51:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/34] 9p: Pin pages rather than ref'ing if appropriate
Message-ID: <Y8l1L9B48prS2o9c@infradead.org>
References: <Y8iwXJ2gMcCyXzm4@ZenIV>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391063242.2311931.3275290816918213423.stgit@warthog.procyon.org.uk>
 <3030212.1674146654@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3030212.1674146654@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:44:14PM +0000, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> You're right.  I wonder if I should handle ITER_KVEC in
> iov_iter_extract_pages(), though I'm sure I've been told that a kvec might
> point to data that doesn't have a matching page struct.  Or maybe it's that
> the refcount shouldn't be changed on it.

They could in theory contain non-page backed memory, even if I don't
think we currently have that in tree.  The worst case is probably
vmalloc()ed memory.  Many instance will have no good way to deal with
something that isn't page backed.  That's one reason why I'd relaly
love to see ITER_KVEC go away - for most use cases ITER_BVEC is the
right thing, and the others are probably broken for various combinations
already, but that's going to be a fair amount of work.  For now just
failing the I/O if the instance can't deal with it is probably the
right thing.
