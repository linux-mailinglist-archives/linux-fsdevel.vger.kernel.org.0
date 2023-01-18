Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC9672B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjARW2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjARW2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:28:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB847EF4;
        Wed, 18 Jan 2023 14:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=APHnihkvh6akIJoj4c5GkeVGlAwab1fmi7yS7P0+eVE=; b=OBnZcUmXTTO10NSukCkw8X+SvB
        LfNQMY3RQ0VWJHpreSNm3NjMABxMz9VXfPjhN92XoyIAl+24oZ3jNQijW8vm77+gsuwktPSjsMRq6
        IYVUZEnd4i3cWegq5edOuLS6FV1Q2igAw/Douzt66Zqk76E0tUgPiHFj69cDlY43UxNEA2rULRF+q
        GLoeI9Cb0klfiQZjyvDMHiZzRHc6hFLjudz+y65ZyHzw/XxFn/Grpe2nAb2U29AChtNHdX3QG9Jar
        FzBeJcd9cQ1wEr3maNN4dbCFSXA2DY7mBoFjLWcU+u37osN9R4zLCrIfFxouR9AYOeKIL3QHNWU2V
        H3jVbE9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIGuz-002d7w-05;
        Wed, 18 Jan 2023 22:28:29 +0000
Date:   Wed, 18 Jan 2023 22:28:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/34] iov_iter: Use the direction in the iterator
 functions
Message-ID: <Y8hyjEw94LIZ84xo@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
 <Y8ZVGEvbVsf4eDNU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZVGEvbVsf4eDNU@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_ABUSE_SURBL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:58:16PM -0800, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 11:08:44PM +0000, David Howells wrote:
> > Use the direction in the iterator functions rather than READ/WRITE.
> 
> I don't think we need the direction at all as nothing uses it any more.

... except for checks in copy_from_iter() et.al.
