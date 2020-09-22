Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5566E274478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVOmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVOmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:42:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FBC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:42:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so9653152qvb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d1qBGSKO9ATTg+f/hu81D/+Ogeb5+q29w+qcULru148=;
        b=nvs5BRy23crgSS41CONEZl9lNAoYTJ49XKXHHgFLUXlFoZWkbE02kUtBSmYyL0AG+B
         Te4pyRH3kRFBlVQ4JOI50wgls5tp4QS0qRZ/5qLuL8Z3SFWjIFPsgXxeVyNOal62J/4H
         ntilpkK5Fd/Lbsir2yZNVC61SVTCLQ4E4HGxxVHtYCH/WNITD+3HTgpkSKViUwjuDbsl
         skvMBJniNb5WL8quJHh9VZhFlFCcNgYd8DBPZzSpz1MKNXhQrrr9ptstVUf2KgUsJMIz
         tHKd9LNKp7wnyVLogldyz6fqVaXuqH/MHokhu/lQflex9Uo4ijnqI2QPajgH02xWm2fX
         ekcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1qBGSKO9ATTg+f/hu81D/+Ogeb5+q29w+qcULru148=;
        b=Deb/qRztOzEkpLOGpjFs1asJwbGu92H4fxHObg6uV9kjl1DXXtgO4MTu1WMrVaBiOb
         9Pia1Pj5g3W/n3Z/dT/ZlZ8II0MZs9qoC+qjPUFlEx8r3zbLaU6Y6nSMWqsNsPEmBg5C
         5iR2oJjwtCUm4aahigCyGZALaeTR86Rz0d26E8A+mjytif3tplO460SfBPN60WQ+EZig
         4QRw6OpTIfQ+5RweTxt17JQNERiDefdHUjeXJDnkJ94kMdoFb9s7q7tTPQn+zAZOzR2D
         8X4P0NYpdsktCbhSCx5/iF25fR/zlAsL+9AdbDij2YYvo+O0JJyVauMlIYXHUZKhUJZj
         N6Mg==
X-Gm-Message-State: AOAM5331MMLUXOj6vc7hvUOaKYmpw12e/ZntzSnmKLi8OTvF45IiKy0d
        nAPT65LvNGzqou6MgBnkTaJsPw==
X-Google-Smtp-Source: ABdhPJwigwK3l7zbqg1gn2HtaF8rE/bmH3MH3vxRgirqPS5yzxb6fpk63hptbpUW4OqOK6eYGbk4kg==
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr6429297qvj.14.1600785728932;
        Tue, 22 Sep 2020 07:42:08 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p205sm11530078qke.2.2020.09.22.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:42:08 -0700 (PDT)
Subject: Re: [PATCH 08/15] btrfs: Introduce btrfs_write_check()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-9-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5628b9ec-0dfa-4618-fa31-4f3357a47cda@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:42:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-9-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_write_check() checks for all parameters in one place before
> beginning a write. This does away with inode_unlock() after every check.
> In the later patches, it will help push inode_lock/unlock() in buffered
> and direct write functions respectively.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/btrfs/file.c | 159 ++++++++++++++++++++++++------------------------
>   1 file changed, 81 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index ca374cb5ffc9..0f961ce1fa98 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1615,6 +1615,85 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
>   	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>   }
>   
> +static void update_time_for_write(struct inode *inode)
> +{
> +	struct timespec64 now;
> +
> +	if (IS_NOCMTIME(inode))
> +		return;
> +
> +	now = current_time(inode);
> +	if (!timespec64_equal(&inode->i_mtime, &now))
> +		inode->i_mtime = now;
> +
> +	if (!timespec64_equal(&inode->i_ctime, &now))
> +		inode->i_ctime = now;
> +
> +	if (IS_I_VERSION(inode))
> +		inode_inc_iversion(inode);
> +}
> +
> +static size_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	loff_t pos = iocb->ki_pos;
> +	size_t count = iov_iter_count(from);
> +	int err;
> +	loff_t oldsize;
> +	loff_t start_pos;
> +
> +	err = generic_write_checks(iocb, from);
> +	if (err <= 0)
> +		return err;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		size_t nocow_bytes = count;
> +
> +		/*
> +		 * We will allocate space in case nodatacow is not set,
> +		 * so bail
> +		 */
> +		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes)
> +		    <= 0)
> +			return -EAGAIN;
> +		/*
> +		 * There are holes in the range or parts of the range that must
> +		 * be COWed (shared extents, RO block groups, etc), so just bail
> +		 * out.
> +		 */
> +		if (nocow_bytes < count)
> +			return -EAGAIN;
> +	}
> +
> +	current->backing_dev_info = inode_to_bdi(inode);
> +	err = file_remove_privs(file);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * We reserve space for updating the inode when we reserve space for the
> +	 * extent we are going to write, so we will enospc out there.  We don't
> +	 * need to start yet another transaction to update the inode as we will
> +	 * update the inode when we finish writing whatever data we write.
> +	 */
> +	update_time_for_write(inode);
> +
> +	start_pos = round_down(pos, fs_info->sectorsize);
> +	oldsize = i_size_read(inode);
> +	if (start_pos > oldsize) {
> +		/* Expand hole size to cover write data, preventing empty gap */
> +		loff_t end_pos = round_up(pos + count,
> +					  fs_info->sectorsize);
> +		err = btrfs_cont_expand(inode, oldsize, end_pos);
> +		if (err)
> +			return err;

In this case we're not re-setting current->backing_dev_info to NULL.  Thanks,

Josef
