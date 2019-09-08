Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB36AD136
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfIHXch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:32:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43950 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbfIHXch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:32:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so5711784pld.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KoyYGshPbu7H+19Wzp6J10yLMx5CfhFe6SBzBxWMUi4=;
        b=CkMkh3ZtJxYBhqXLnP53HTx+1n6EpuRkDYCz6o0VLQ/zphkKzcz6IF6o2nrSUnhQCC
         CSjgbAMK0Xf6/FSYqcMVMcwnSw7zQdMyPOD76rgG55MpamzaO4pGaCFPDP9DJOPBwNw9
         QxsUjPbIu7+VN7SOfoCmP0oNuEzDdT18+tsW0Ld+3R1MWhbid10z/EENMXzMnlAzsMlx
         YzSCiw2pBQ9PCHmtzH8S9TeVpOSotmZYpXA9LnzI/9G1/MSD/W6XsyzmFYa4/TvbwKlP
         zFAbg2LrMnwzPWOXSuKDbiQ/WQc6RdEeNN/xku9ibLJbRoOvE91TfpReyFzeeAojKBOx
         wgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KoyYGshPbu7H+19Wzp6J10yLMx5CfhFe6SBzBxWMUi4=;
        b=b1og64/NgCC/JW1GykE47a7ydTUQaCo8GKEXd/i+ye8TZlxTBXlnVXLu3iKhcDtfBl
         hTdyj9sL7WDh7KPdINQqY6s5gMIV1slj9AbXp8fLmzZXAgmMvu9zg5K3kEW3pRqvPqcm
         C0CfNxfAt8z+E+cqWeVI1z49V9653KHiLdJPIDjfKpnljK7aIwMejnLjm8z4xehwK5tH
         NywvOgxhPCO0DJLdrsjkCYzSFngtw+L05tFyw4z173ULu6jkuLjnHCmStPJtiMmHlfa/
         hvxAyE44o2PY0uaxXOE55mTK4K0G0CR5kLETNZZDrd0P9kt09tAClGjizF2ARb+kuDBC
         FbsQ==
X-Gm-Message-State: APjAAAWlzYv/TYLUMpR3fQ8ieSU80jKx1a7N0IgjzWv39BkY2PuZWPYP
        rIvgOHpwoEyXrFe4nAhT9OFF
X-Google-Smtp-Source: APXvYqyectGBobIc2q4A/osq2opYW6jzkVSOqplh+cqieLLNYnfXLTHLj5ySVuZZT9+UVwCcQ6OxTA==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr12694107pls.28.1567985556290;
        Sun, 08 Sep 2019 16:32:36 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id d10sm14422587pfh.8.2019.09.08.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:32:35 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:32:29 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iomap: modify ->end_io() calling convention
Message-ID: <20190908233229.GA19283@bobrowski>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <8368d2ea5f2e80fed7fbba3685b0d3c1e5ff742a.1567978633.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8368d2ea5f2e80fed7fbba3685b0d3c1e5ff742a.1567978633.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ CC: linux-xfs@vger.kernel.org

On Mon, Sep 09, 2019 at 09:19:31AM +1000, Matthew Bobrowski wrote:
> This patch modifies the calling convention for the iomap ->end_io()
> callback. Rather than passing either dio->error or dio->size as the
> 'size' argument, we instead pass both dio->error and dio->size values
> separately.
> 
> In the instance that an error occurred during a write, we currently
> cannot determine whether any blocks have been allocated beyond the
> current EOF and data has subsequently been written to these blocks
> within the ->end_io() callback. As a result, we cannot judge whether
> we should take the truncate failed write path. Having both dio->error
> and dio->size will allow us to perform such checks within this
> callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Please note, this patch is now part of the recent end_io improvements
posted through by Christoph, and can be found here:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=iomap-5.4-merge&id=db10bd824bc0353702231f1294b58903cb66bac7.

> ---
>  fs/iomap/direct-io.c  | 9 +++------
>  fs/xfs/xfs_file.c     | 8 +++++---
>  include/linux/iomap.h | 4 ++--
>  3 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 10517cea9682..2ccf1c6460d4 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -77,13 +77,10 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	loff_t offset = iocb->ki_pos;
>  	ssize_t ret;
>  
> -	if (dio->end_io) {
> -		ret = dio->end_io(iocb,
> -				dio->error ? dio->error : dio->size,
> -				dio->flags);
> -	} else {
> +	if (dio->end_io)
> +		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
> +	else
>  		ret = dio->error;
> -	}
>  
>  	if (likely(!ret)) {
>  		ret = dio->size;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 28101bbc0b78..d49759008c54 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -369,21 +369,23 @@ static int
>  xfs_dio_write_end_io(
>  	struct kiocb		*iocb,
>  	ssize_t			size,
> +	int                     error,
>  	unsigned		flags)
>  {
>  	struct inode		*inode = file_inode(iocb->ki_filp);
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	loff_t			offset = iocb->ki_pos;
>  	unsigned int		nofs_flag;
> -	int			error = 0;
>  
>  	trace_xfs_end_io_direct_write(ip, offset, size);
>  
>  	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
>  		return -EIO;
>  
> -	if (size <= 0)
> -		return size;
> +	if (error)
> +		return error;
> +	if (!size)
> +		return 0;
>  
>  	/*
>  	 * Capture amount written on completion as we can't reliably account
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index bc499ceae392..d983cdcf2e72 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -188,8 +188,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>   */
>  #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
>  #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
> -typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
> -		unsigned flags);
> +typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size,
> +				 int error, unsigned int flags);
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
> -- 
> 2.20.1
> 
