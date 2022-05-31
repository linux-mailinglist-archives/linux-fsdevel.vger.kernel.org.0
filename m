Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8E538BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbiEaHYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 03:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiEaHYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 03:24:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C492D09;
        Tue, 31 May 2022 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nNgd/AJP2N1cOO4nuKxP7gM1kDhTHQ+2uxx2/aBNcQ8=; b=x3gtBWfRVs9mW7pjrV+bxU+FIb
        5yKqW+YXwxpFyHCY4szbOlt4MRKlMmjCTEs4Q8jG3e2jUdUgSooHy2WZ4qwonLP96mO5m0xp0Y5Yp
        Vv6sJpTbyBl8bRe6uvkzy+hUb8HHpXacm8UZryhQ5BVRYTQCmHgvQkFK3Y4DF9/pIXYozTgmHi4cP
        qTr2ei3YtH8gvyONFdwq162ySFtHFoiapSqVLqdD/OzOVQ0SSXJEvjjOD9zM5k+tdst0taLaNmPYp
        L37KBHe/w/LKwVLCssQ/Xk7AP6orT4Uf9bGFrz6ryVUnuZZyPhW+Yhdw2sjsT9+TmNOHH0+E6dfEB
        mA7gD0eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvwF5-009h80-8C; Tue, 31 May 2022 07:24:39 +0000
Date:   Tue, 31 May 2022 00:24:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs/super: function to prevent super re-use
Message-ID: <YpXCt14eL2edq6IB@infradead.org>
References: <20220530013958.577941-1-dlunev@chromium.org>
 <20220530113953.v3.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530113953.v3.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022 at 11:39:57AM +1000, Daniil Lunev wrote:
> +void retire_super(struct super_block *sb)
> +{
> +	down_write(&sb->s_umount);
> +	if (sb->s_bdi != &noop_backing_dev_info) {
> +		if (sb->s_iflags & SB_I_PERSB_BDI && !(sb->s_iflags & SB_I_RETIRED))

SB_I_PERSB_BDI can't be set for noop_backing_dev_info, so that check
should not be needed.  Which also conveniently fixes the overly long
line.

Also this should clear SB_I_PERSB_BDI as the only place that checks
it is the unregistration.

>  	spin_lock(&sb_lock);
> -	/* should be initialized for __put_super_and_need_restart() */

This is a completely unrelated change.  While the function is gone
it might be worth to check what it got renamed to or folded in, or
if the initialization is still needed.  But all that is for a separate
patch.

>  	up_write(&sb->s_umount);
>  	if (sb->s_bdi != &noop_backing_dev_info) {
> -		if (sb->s_iflags & SB_I_PERSB_BDI)
> +		/* retire should have already unregistered bdi */
> +		if (sb->s_iflags & SB_I_PERSB_BDI && !(sb->s_iflags & SB_I_RETIRED))
>  			bdi_unregister(sb->s_bdi);
>  		bdi_put(sb->s_bdi);

And once SB_I_PERSB_BDI is dropped when retiring we don't need this
change.
