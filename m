Return-Path: <linux-fsdevel+bounces-29396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A577C9794EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 09:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5731F21B5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F9C1CF93;
	Sun, 15 Sep 2024 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gLpgA12c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC91C32;
	Sun, 15 Sep 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383952; cv=none; b=T+hUzm4e0hvphZA2okOmlmA1x1QHbspy4dg/GN+XMnoJNb9dBaflFxKkV6srqwD3tb9f0fJqqSv/Xnmyq6qLyJGM8lzqMGXWdcOTLvD2MVWhlePcA0v+mu5VwWPr18G+zM5E+fXYIW1isXawaaYnmFkl9rIsMaF/Un76URmDXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383952; c=relaxed/simple;
	bh=BCpW3FL3ObgSdc8xUJBM+CvF4qGFi6TFsA9dNJ/nDO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW4rB/gHYbQbPb91Db3TeEW1lybiLUS+jBfPaIuU24+Tcylzs091/cGJVwEqUTkfkJsJAb8LzeAKccQPty+ghEsym+NAJa3Xa//JqloDXL1f8Ar0yvGqiV3SkBrnJuAQwbU2msqwiw/d6NZd1ES63u0hjLpk3FM99IT/kjZ1bCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gLpgA12c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fvWAWtTHygul7ymfGTDYchhp2R61y/v6Tz+FNotitns=; b=gLpgA12cLHuHPnGCfb5KEhZvI2
	xF3qxf2TkHGMKR6gibFT4XUP/D6ZaDArH82tq9qFBpg0h7Gd9Ru3fkJmfrSPIbzM5HgZP92r3WKSv
	6XnHvF2ZaBZ1NxsQpZoCVBwvZmH2e+URMzbYks636WQ2jsVRuNG7kIsk1kyALoSDC8ek0LhC/xKdi
	GofJ3izyqYM5vwZOpn2erdqXk4uC+wBJ7hxJ8SzKlhbcttjvJ2zdw9xAad8jgpDsDvGqeo5dP1+a5
	bTPYav2hvxLMl66pyvGmdGtUN4Z9RbqlusQ5j422qJ21dcqsoDW+LMDwljxR/mCgMcGw9AZG4WpkU
	1hzLvDKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spjKM-0000000Ccbm-2O5r;
	Sun, 15 Sep 2024 07:05:46 +0000
Date: Sun, 15 Sep 2024 08:05:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/exfat: resolve memory leak from
 exfat_create_upcase_table()
Message-ID: <20240915070546.GE2825852@ZenIV>
References: <20240915064404.221474-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915064404.221474-1-danielyangkang@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 14, 2024 at 11:44:03PM -0700, Daniel Yang wrote:
>     If exfat_load_upcase_table reaches end and returns -EINVAL,
>     allocated memory doesn't get freed and while
>     exfat_load_default_upcase_table allocates more memory, leading to a    
>     memory leak.
>     
>     Here's link to syzkaller crash report illustrating this issue:
>     https://syzkaller.appspot.com/text?tag=CrashReport&x=1406c201980000
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
> ---
>  fs/exfat/nls.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index afdf13c34..ec69477d0 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -699,6 +699,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
>  
>  	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
>  		  index, chksum, utbl_checksum);
> +	exfat_free_upcase_table(sbi);
>  	return -EINVAL;
>  }

	Interesting...  How does the mainline manage to avoid the
call of exfat_kill_sb(), which should call_rcu() delayed_free(), which
calls exfat_free_upcase_table()?

	Could you verify that your reproducer does *NOT* hit that
callchain?  AFAICS, the only caller of exfat_load_upcase_table()
is exfat_create_upcase_table(), called by __exfat_fill_super(),
called by exfat_fill_super(), passed as callback to get_tree_bdev().
And if that's the case, ->kill_sb() should be called on failure and
with non-NULL ->s_fs_info...

	Something odd is going on there.

