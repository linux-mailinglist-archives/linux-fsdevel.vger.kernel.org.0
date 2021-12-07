Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2589746C6AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 22:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbhLGV2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 16:28:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbhLGV2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:28:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60761B81E83;
        Tue,  7 Dec 2021 21:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB1C341C1;
        Tue,  7 Dec 2021 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638912320;
        bh=9u8b771+gociR8Vobc7BF18nD9jpBOsReNVrS5XDPZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csU9W7xFlFDm8p39xEn7B9Q5MtgYCssE0yYhbHz8yDCgl5YKGWdm4au8xVw9CwRxQ
         7Ul/M0DpczivcS/Dx7mNwW/ZTanh86rO2zdUlQLQzEOCoZa1y9hyYD9w8d9MfFaGKz
         Qd2XOCWKrHc+Tn97svqsXNEN8FxJWGmBe2S+5DeqfEi6IFylN2bYF9YE4CmohCAkv1
         +z8czScsbyfFXToTWb9/enrRIGaV1oJY7q4ITt+IYdfPdVyBe9bCXV4iwFP/g2WPlv
         RhjacA/svJGLetnofedJwXQxTaWUFasMBxSO3STVrmuR1lLt/R2sFz1pHrKWN5iT44
         UQ9kHfuxm4bzg==
Date:   Tue, 7 Dec 2021 13:25:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgel.zte@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs/dcache: prevent repeated locking
Message-ID: <Ya/RPpR3AdGAFtqX@sol.localdomain>
References: <20211207101646.401982-1-lv.ruyi@zte.com.cn>
 <Ya9e9XlMPUyQUvxp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya9e9XlMPUyQUvxp@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:17:41PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 07, 2021 at 10:16:46AM +0000, cgel.zte@gmail.com wrote:
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> > 
> > Move the spin_lock above the restart to prevent to lock twice 
> > when the code goto restart.
> 
> This is madness.
> 
> void d_prune_aliases(struct inode *inode)
>         spin_lock(&inode->i_lock);
>                         if (likely(!dentry->d_lockref.count)) {
>                                 __dentry_kill(dentry);
>                                 goto restart;
> ...
> static void __dentry_kill(struct dentry *dentry)
>         if (dentry->d_inode)
>                 dentry_unlink_inode(dentry);
> ...
> static void dentry_unlink_inode(struct dentry * dentry)
>         spin_unlock(&inode->i_lock);
> 
> Did you even test this patch?

This same wrong patch has been sent several times before.  I think it's fair to
say that this code could use a comment, e.g.:

	/* i_lock was dropped */
	goto restart;

- Eric
