Return-Path: <linux-fsdevel+bounces-17795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1288B23B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AE5281D62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5FB14A083;
	Thu, 25 Apr 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j5G5/Iju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2D149E09;
	Thu, 25 Apr 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054628; cv=none; b=oexd3a8i4zzGIWdXDjfhBk0UwPJCfsfGkiY+ryzc/Z4l2JRZeSEObq2oL/Y7l/lSxshci4+iqxeKdIxIDfH0yAvC2II4k3pIUz9C4DBO8+0w9WbaH1Y6Kdyx7CoF2acqUSbCvpnBkCHK9dvcsWSZgmIH/LPfQBY0k9q4uemijyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054628; c=relaxed/simple;
	bh=WIh+5+w60Ve2eTfEPbceFfPj75tcQRJXzxJYrzzcGlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcvdDMxub7zfUzo3G0pZvVTibLw1Lys0WN2AbXlZWNv2ZwvDv/SEsIHshn6cmgN+YIBVlFn2RHn1xS0tatHAkuRVKZJ1YV0bWqUt3LkSGvvkTy+4MGmVGzvSCct3ukw+LzBes+jlJQc7LaiAKZTZT1V+xeOjx2SlgwAkU1MqEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j5G5/Iju; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7t2rt4hOIW26jsBvBQJ76isBVw52l+x7mN9o20mi2qg=; b=j5G5/IjuClTCbnkjwouWfvSkDK
	RG92JAoxM+nanJJX4xMNGuQSmnHkRf0/xK7xeswkt/sv6Fmre97crTGHa0jsDhRRriQw7I/WdfItd
	seJ0d55t9UYhnXKpdGjRfsabjf10Pt2rEBAOzCAURxK9huWjztwuqnMTbNEb8+M6bEc1JoI7R5vic
	fgia30aFHf+nGNGz4ty+goWIf6Il7yGJOKqhr5jeQZIOY6mjpdqsX7vZu0DZ1Sw33VgJQK7+Dl28b
	YaxWVrskyj2GLfh216ZsuadvZvc3zzrv32g7yuHzoGvzeOEvdO2rhUmkIXxkeZ9hgkdrEkHiJ98RP
	eTjpaSxA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzuK-00000003BJe-473Z;
	Thu, 25 Apr 2024 14:17:05 +0000
Date: Thu, 25 Apr 2024 15:17:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: brauner@kernel.org, jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Message-ID: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
References: <ZipSO4ITxuy2faKx@casper.infradead.org>
 <20240425141038.47054-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425141038.47054-1-aha310510@gmail.com>

On Thu, Apr 25, 2024 at 11:10:38PM +0900, Jeongjun Park wrote:
> Matthew Wilcox wrote:
> > If that's the problem then the correct place to detect & reject this is
> > during mount, not at inode free time.
> 
> I fixed the patch as you said. If you patch in this way, the 
> file system will not be affected by the vulnerability at all 
> due to the code structure.

It should be checked earlier than this.  There's this code in
dbMount().  Why isn't this catching it?

        bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
        if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
            bmp->db_agl2size < 0) {
                err = -EINVAL;
                goto err_release_metapage;
        }

        if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
                err = -EINVAL;
                goto err_release_metapage;
        }


> Thanks.
> 
> ---
>  fs/jfs/jfs_imap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 2ec35889ad24..ba0aa2f145cc 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -290,7 +290,7 @@ int diSync(struct inode *ipimap)
>  int diRead(struct inode *ip)
>  {
>  	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
> -	int iagno, ino, extno, rc;
> +	int iagno, ino, extno, rc, agno;
>  	struct inode *ipimap;
>  	struct dinode *dp;
>  	struct iag *iagp;
> @@ -339,6 +339,9 @@ int diRead(struct inode *ip)
>  
>  	/* get the ag for the iag */
>  	agstart = le64_to_cpu(iagp->agstart);
> +	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
> +	if(agno >= MAXAG || agno < 0)
> +		return -EIO;
>  
>  	release_metapage(mp);
>  
> -- 
> 2.34.1

