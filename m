Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4566D88C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjAQIrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjAQIqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:46:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96692193C4;
        Tue, 17 Jan 2023 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8H+PHMNzo2HTcMqyv+E+gLhkOMic9ckrnZ4L2irIROs=; b=ewKhMhzGcG3aOo3RcHc5EN27n7
        mkq1oCd9tNjMBxLrAfxEARYjoKMBXRSsG3rDqFLCGrJvsxstT0AL+hbnqARczQ5t94xOwglkIc4BI
        QjkuTNg61vfQTWPjX8/aWGN8QhzwXoQT/ecQemS2zPGLa9m8s68PFFiTv2axFeDchjYzX+q81+y3N
        z3Ysh053KfiqdPVs50cBKUxO0AR7L2fAfYaFClIL9byP54CYpnSD9KatAM3KJ5R+eXNAcwWc9AOdz
        ILHTly/1a+9IHP/Ovy4rPdbuIb/n9cSTSLyjQ3Yv3jTdWnz484sYPS8tpAfOaoDYUw3zkCadHw2Pa
        ZpG2sz+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHhbv-00DN6U-Hb; Tue, 17 Jan 2023 08:46:27 +0000
Date:   Tue, 17 Jan 2023 00:46:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Message-ID: <Y8ZgYwkLKPTcp5vn@infradead.org>
References: <Y8ZU1Jjx5VSetvOn@infradead.org>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <2331410.1673945056@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2331410.1673945056@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:44:16AM +0000, David Howells wrote:
> Also, I don't want it to be FOLL_WRITE or 0.  I want it to be written
> explicitly in both cases.  If you're going to insist on using FOLL_WRITE, then
> there should be a FOLL_READ to go with it, even if it's #defined to 0.

Well, that's not how FOLL_* works.  And another new flag that is defined
to 0 but only used by some I/O callers is really confusing.
