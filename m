Return-Path: <linux-fsdevel+bounces-69001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0952CC6B09F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3C4934F685
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD9349AE6;
	Tue, 18 Nov 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hNDh5Csr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125320C488;
	Tue, 18 Nov 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487609; cv=none; b=vDTbGYmx3PngaMWYvCkjjaRZk34os739RaKl20Q8DhBBiK8wuXrJE12LLupt3W8313gaFiEOqq0mYhQEaQqB/Ll+rDYrH5fv/vuXPyIh8bvM2kNjX595DxldrcKmuJKlkv/q97PlqKpmTNERBLc5qCFbqgDi1nPEdgq7b/1+rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487609; c=relaxed/simple;
	bh=1q1etgJN40RUnwwpwCI47diO3ILxUsBbFSCF0n9NLjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZhBU3czqP6YTAcpZfg/m6vYGgWGPUAzaXkdRYTVJRje8npHNibryQoN4Leckark2XGhE+H1cmATAd0eSlLv5nBYwTDRrAOW3AVxkV+VjChr/E+iLOFciDyqYwIIJnAwCjcGqoc/65yOEcQTT/tcQsfLkwqCLaTPHAgnmBB1xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hNDh5Csr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yqb7N0H4JGGBYJ84ZI4yNhHyWkJXbpKpv+8rNSsx5Ng=; b=hNDh5CsrtAFot4np8VyoX7ziwg
	VWbZhzuVD1wJdM1yiwM5rTqSpZidVbaEjIZJjXL0NPR0o6XnntZCSd4bsjZ8q7oyqXK4YFD7SkdUc
	AnQSMoMgnRNkCUjLNd8MupDZ35YVMp52NFLZw0u3fBn+dMkrBDIbi59SOAimr9mo0NVZWoPolhZPp
	y3FqaD+kSeQ22yFUzahHPlNsUyirxeQE4TOULofT2h/3nZ9GyqtCSWWdAzxNP7FmptP2Zx+LOsUBL
	uAU0t+3OrR8RlI+OkdaC8lUjtL5wO5ersRzRCsuaKh2mscuFw7SRdpCNan7m+OY+5W8guSLiRcR2W
	IgmsUJzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLPgR-0000000C9SY-3QSx;
	Tue, 18 Nov 2025 17:40:03 +0000
Date: Tue, 18 Nov 2025 17:40:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com,
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Subject: Re:
Message-ID: <20251118174003.GH2441659@ZenIV>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
 <20251118182710.51972-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118182710.51972-1-mehdi.benhadjkhelifa@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 18, 2025 at 07:27:06PM +0100, Mehdi Ben Hadj Khelifa wrote:
> #syz test
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 47f50fa555a4..46cdff89fb00 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -431,10 +431,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
>  	return 0;
>  }
>  
> +static void hfs_kill_sb(struct super_block *sb)
> +{
> +	generic_shutdown_super(sb);
> +	hfs_mdb_put(sb);
> +	if (sb->s_bdev) {
> +		sync_blockdev(sb->s_bdev);
> +		bdev_fput(sb->s_bdev_file);
> +	}
> +
> +}
> +
>  static struct file_system_type hfs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "hfs",
> -	.kill_sb	= kill_block_super,
> +	.kill_sb	= hfs_kill_sb,
>  	.fs_flags	= FS_REQUIRES_DEV,
>  	.init_fs_context = hfs_init_fs_context,
>  };

Remove the calls of hfs_mdb_put() from hfs_fill_super() and
hfs_put_super() in addition to that.

