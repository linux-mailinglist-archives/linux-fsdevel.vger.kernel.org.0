Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA66E42BD71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhJMKpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 06:45:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32852 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhJMKpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:45:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F96E2233F;
        Wed, 13 Oct 2021 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634121823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91hISCii4Or1ILPgadTSW2G7i/WxLx55yWUH14ngMGo=;
        b=urePYUhd5OF9+eOS15sOdNKf/9CEfoiJF0sOJ+CUtOdrV78ouAHrD22Jwd1x7RDJ1X7NXU
        38K6W/8xGxP7iJLbOT3v2KEmBRctpIhbWooGrkxGTpdozRprjw2uPy1C7rv4VVv0/JqU+P
        /z6fu4NATPhJE4NTFVWUnjzU7Jcj6qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634121823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91hISCii4Or1ILPgadTSW2G7i/WxLx55yWUH14ngMGo=;
        b=iV9JFoqqPxqNVUQiZzwRblLXbUXiC4lcfVm33k6YuJt29JfUmlOuSAxx4ULbDL3QwDFt/o
        bWYhIgn68fkyB0Bw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7DF06A3B81;
        Wed, 13 Oct 2021 10:43:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 27DE61E11B6; Wed, 13 Oct 2021 12:43:43 +0200 (CEST)
Date:   Wed, 13 Oct 2021 12:43:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 21/29] reiserfs: use bdev_nr_sectors instead of open
 coding it
Message-ID: <20211013104343.GF19200@quack2.suse.cz>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-22-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-10-21 07:10:34, Christoph Hellwig wrote:
> Use the proper helper to read the block device size and remove two
> cargo culted checks that can't be false.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 58481f8d63d5b..6c9681e2809f0 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1986,8 +1986,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
>  	 * smaller than the filesystem. If the check fails then abort and
>  	 * scream, because bad stuff will happen otherwise.
>  	 */
> -	if (s->s_bdev && s->s_bdev->bd_inode
> -	    && i_size_read(s->s_bdev->bd_inode) <
> +	if ((bdev_nr_sectors(s->s_bdev) << SECTOR_SHIFT) <
>  	    sb_block_count(rs) * sb_blocksize(rs)) {
>  		SWARN(silent, s, "", "Filesystem cannot be "
>  		      "mounted because it is bigger than the device");
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
