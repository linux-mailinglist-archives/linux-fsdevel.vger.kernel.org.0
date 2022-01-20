Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09FE494981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359269AbiATIa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbiATIaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:30:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12BC06175A;
        Thu, 20 Jan 2022 00:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4YLv12vaH5SBxgO/VH+IFNLxgK8TDHDUDIGloGpzq0o=; b=Q3dHqDRR7It61x+wYLIdNp05S/
        u6VPSwFrw0IY2CI7N3H2ifaUZ68axyBfGF181H5kwwOhrafeJWImtn1gRt+0d0IBDN99yIfge1PJG
        hP9BReWxiFQ3g/pJxQ+RMonEZ0AjNLRvDSKEXm1JMv2oKnyCo1oU5TnOZAmkQQ0dQbhJeODMJJSov
        Jh1B1T+BW+K3aI5Oxe7eJZnwq95ZaW94LU/r4X7TmJNogOB+WlE3woZv0Oiko+7qp6E/nli6pMZFI
        vMTM9Wn0SwZIO73GEuuNAmtZiXw0BILywxroF0GSo4m8pPMgSas9xV2RAeoAbgk8cQ3qeOPcLohCa
        1cV9RIUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nASpr-009lmb-O7; Thu, 20 Jan 2022 08:30:23 +0000
Date:   Thu, 20 Jan 2022 00:30:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YekdnxpeunTGfXqX@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120071215.123274-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:12:10PM -0800, Eric Biggers wrote:
> 
> Given the above, as far as I know the only remaining objection to this
> patchset would be that DIO constraints aren't sufficiently discoverable
> by userspace.  Now, to put this in context, this is a longstanding issue
> with all Linux filesystems, except XFS which has XFS_IOC_DIOINFO.  It's
> not specific to this feature, and it doesn't actually seem to be too
> important in practice; many other filesystem features place constraints
> on DIO, and f2fs even *only* allows fully FS block size aligned DIO.
> (And for better or worse, many systems using fscrypt already have
> out-of-tree patches that enable DIO support, and people don't seem to
> have trouble with the FS block size alignment requirement.)

It might make sense to use this as an opportunity to implement
XFS_IOC_DIOINFO for ext4 and f2fs.

> I plan to propose a new generic ioctl to address the issue of DIO
> constraints being insufficiently discoverable.  But until then, I'm
> wondering if people are willing to consider this patchset again, or
> whether it is considered blocked by this issue alone.  (And if this
> patchset is still unacceptable, would it be acceptable with f2fs support
> only, given that f2fs *already* only allows FS block size aligned DIO?)

I think the patchset looks fine, but I'd really love to have a way for
the alignment restrictions to be discoverable from the start.
