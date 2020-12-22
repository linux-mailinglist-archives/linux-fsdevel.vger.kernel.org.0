Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5A2E0D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLVQVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 11:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgLVQVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:21:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCFC0613D3;
        Tue, 22 Dec 2020 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bmiJUuE3elrojnPzvTQfgWJNXDypdX6aMf0bUhQi8/I=; b=vojOpjv8r5W2anVf+CyXq2Ke33
        q0Zf+ZdtH/ednPVUbwj8AGfXtJqX2ZSVSDDq30I2vUg82lSOag8TWFVml1+gIUzoydHyys+89+bhq
        15tgsYSFCoI6B+woT6nshIH/58kTzu60v0KLcu8Mmyd4Xg+V2uLLj0PpuzU6tYYDenL3QGQu+G0v+
        S63xO0su3T1e1n2XnTur8v8Q9PSTGr2sAozvfe2KwcdoQdd9ZTjF5a/5Wyfu+4ndMPVoM8a08PyPk
        5f/Ej1OF29j+NgXpLjKFRTPX5vS78ve1nfvY/m5mTxGSFv20oTgQtRucQ3GF+T9MuSdZ7TkirmCUC
        TXA+ZLAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krkOh-0004ed-AE; Tue, 22 Dec 2020 16:20:27 +0000
Date:   Tue, 22 Dec 2020 16:20:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201222162027.GJ874@casper.infradead.org>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221195055.35295-4-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> +{
> +	struct ovl_fs *ofs = sb->s_fs_info;
> +	struct super_block *upper_sb;
> +	int ret;
> +
> +	if (!ovl_upper_mnt(ofs))
> +		return 0;
> +
> +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> +
> +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> +		return 0;
> +
> +	/* Something changed, must use slow path */
> +	spin_lock(&file->f_lock);
> +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> +	spin_unlock(&file->f_lock);

Why are you microoptimising syncfs()?  Are there really applications which
call syncfs() in a massively parallel manner on the same file descriptor?
