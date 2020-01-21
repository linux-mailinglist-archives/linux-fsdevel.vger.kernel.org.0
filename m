Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240D214355E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 02:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUBt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 20:49:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57968 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUBt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:49:27 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itifU-00CNBW-Pd; Tue, 21 Jan 2020 01:49:25 +0000
Date:   Tue, 21 Jan 2020 01:49:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com
Subject: Re: [PATCH v12 02/13] exfat: add super block operations
Message-ID: <20200121014924.GI8904@ZenIV.linux.org.uk>
References: <20200120124428.17863-1-linkinjeon@gmail.com>
 <20200120124428.17863-3-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120124428.17863-3-linkinjeon@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 09:44:17PM +0900, Namjae Jeon wrote:

> +static void exfat_put_super(struct super_block *sb)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	mutex_lock(&sbi->s_lock);
> +	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state))
> +		sync_blockdev(sb->s_bdev);
> +	exfat_set_vol_flags(sb, VOL_CLEAN);
> +	exfat_free_upcase_table(sb);
> +	exfat_free_bitmap(sb);
> +	mutex_unlock(&sbi->s_lock);
> +
> +	if (sbi->nls_io) {
> +		unload_nls(sbi->nls_io);
> +		sbi->nls_io = NULL;
> +	}
> +	exfat_free_iocharset(sbi);
> +	sb->s_fs_info = NULL;
> +	kfree(sbi);
> +}

You need to RCU-delay freeing sbi and zeroing ->nls_io.  *Everything* 
used by ->d_compare() and ->d_hash() needs that treatment.  RCU-mode
pathwalk can stray into a filesystem that has already been lazy-umounted
and is just one close() away from shutdown.  It's OK, as long as you
make sure that all structures used in methods that could be called
in RCU mode (->d_compare(), ->d_hash(), rcu-case ->d_revalidate(),
rcu-case ->permission()) have destruction RCU-delayed.  Look at
what VFAT is doing; that's precisely the reason for that delayed_free()
thing in there.

> +static void exfat_destroy_inode(struct inode *inode)
> +{
> +	kmem_cache_free(exfat_inode_cachep, EXFAT_I(inode));
> +}

No.  Again, that MUST be RCU-delayed; either put an explicit
call_rcu() here, or leave as-is, but make that ->free_inode().

> +static void __exit exit_exfat_fs(void)
> +{
> +	kmem_cache_destroy(exfat_inode_cachep);
> +	unregister_filesystem(&exfat_fs_type);

... and add rcu_barrier() here.

> +	exfat_cache_shutdown();
