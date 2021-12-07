Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A050B46C742
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 23:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhLGWOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 17:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhLGWOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:14:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0662C061574;
        Tue,  7 Dec 2021 14:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5eP5vOQ1P3JvudUXZY7DFlh1VDLNjPKtQ49BEbZn8E=; b=dst3soVAB6KUIuWUBD06zYDCpG
        B/BTN5wQeM6rV7QamtSqHy0hov+0APYekHbyiiz3DGG5/LKegtVq1BALyKfFyyDz8xVOxi0jsmIHT
        OtVt6Y2l6Rc9qoa0dGvS7AnDMBkmXjW2DfVU2b5X/fty82HCdV+thf22+M6HUcbe/eiPzUgVtsFDs
        KtMAbCYHrr6jZOPcNsqju9jnv7+V8kU+p/+SoseGsUuuYR+gH8GO9263oUpiuQPiN8cTXyb97l34U
        f8kGabRTJPDEUhY2ojT2tCSX3MgF8tK1aEsjkkD1OvGsEbGesCZq8Yh44qanddSHsSoD1XpZ9QAFZ
        bW/JHcPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muig4-007p8N-5s; Tue, 07 Dec 2021 22:11:12 +0000
Date:   Tue, 7 Dec 2021 22:11:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     cgel.zte@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs/dcache: prevent repeated locking
Message-ID: <Ya/cAOtx/EoAgWOi@casper.infradead.org>
References: <20211207101646.401982-1-lv.ruyi@zte.com.cn>
 <Ya9e9XlMPUyQUvxp@casper.infradead.org>
 <Ya/RPpR3AdGAFtqX@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya/RPpR3AdGAFtqX@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:25:18PM -0800, Eric Biggers wrote:
> On Tue, Dec 07, 2021 at 01:17:41PM +0000, Matthew Wilcox wrote:
> > On Tue, Dec 07, 2021 at 10:16:46AM +0000, cgel.zte@gmail.com wrote:
> > > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> > > 
> > > Move the spin_lock above the restart to prevent to lock twice 
> > > when the code goto restart.
> > 
> > This is madness.
> > 
> > void d_prune_aliases(struct inode *inode)
> >         spin_lock(&inode->i_lock);
> >                         if (likely(!dentry->d_lockref.count)) {
> >                                 __dentry_kill(dentry);
> >                                 goto restart;
> > ...
> > static void __dentry_kill(struct dentry *dentry)
> >         if (dentry->d_inode)
> >                 dentry_unlink_inode(dentry);
> > ...
> > static void dentry_unlink_inode(struct dentry * dentry)
> >         spin_unlock(&inode->i_lock);
> > 
> > Did you even test this patch?
> 
> This same wrong patch has been sent several times before.  I think it's fair to
> say that this code could use a comment, e.g.:
> 
> 	/* i_lock was dropped */
> 	goto restart;

Not sure that'll do much good.  It seems to be fools running some script
that they haven't the wit to understand.
