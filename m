Return-Path: <linux-fsdevel+bounces-15858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76286894F23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 11:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D94B223D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15F58AC1;
	Tue,  2 Apr 2024 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8/hmy+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4C5731E
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051524; cv=none; b=jBfqq1iBy3vZ5oNXWDjftgpyrFd5tI0+elVvM2Tb9BRY6jljaD0XrafKcfunkUqV2Pm/9PnD/+NG83+xqC0v3DERIMJL877UqI+DMcxnR8s3C7PJ0feLU5Ig2koSbcUNoSuKBwveJCC7k1iJVT+SmTNDVVBrl8wFunwnvU/R/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051524; c=relaxed/simple;
	bh=BuLeAglhQb+OLxYbcXbn2earzV76rOgrs3rntBWRzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmH3m6+JONSV0G7NxlQWoLPrKlVltTMDTHvvI7GeguuXJQAYeKsliZjGKiq4SIrj4WDWCubHu/2Cb1lrcGeudYwGawqzM2uNsLQREux8uFHM0Sd0l1Y62GsE6/Rmhwi0zh5X2a5YPcFNI0xs2fgJs0HGNvkqUMzQ9Qtkfy8D7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8/hmy+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712051522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xE74JKyaieEZ865fOLwKIWnIcIp4KmBPIzJgotjw5B0=;
	b=d8/hmy+sCyqG9BzUSQdzz8NgMad+u23Z7R3M6aDrcTlSFLeDh+EOfBQjwhRJbWkyITHRkx
	t+PvrS7LOtUcz+OCcApgUABRO/Vn01pKy2P2SNAtIxj7wFV4MCzRuU+vQ+g2piRO84e/99
	/jDGiBw+Z8cTxuQP68DANJ7sQwtXNFs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-eiJau8ApO6emQWxetG7QhA-1; Tue, 02 Apr 2024 05:51:59 -0400
X-MC-Unique: eiJau8ApO6emQWxetG7QhA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-515afa25560so3731436e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 02:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051518; x=1712656318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE74JKyaieEZ865fOLwKIWnIcIp4KmBPIzJgotjw5B0=;
        b=kSWxBu/eB8lpwbVt/7jtw40o04gLNyanlbmSLIB7J7JcQUnVL/HR4nFzcUNdaNnzFW
         k64ALpZDQupY8hoGaUJzIWIVs39bMohngrB06zC812Fbzve1fePP7wtaFdRNgSnYmnLI
         AZ4lPEq2aPM5h91P784TY9ONOe8eLZppbWrY+qLIUEGlRp46j2gS7+xieF4llBW1+Ux9
         4n7ERzsEIEJN1XLwmIUWqfQ9dmelNiHDx3ybrynyRDBPgi+U4qjAhx00delLmJuqEZSx
         Z2piQgRbUrTFm8fM+PjfMJDSDsw/20HsvNx9YAMfRw/We9B2jdQSPVAY+KDnFpv58Mcf
         fJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXgLp43iGVHRxqMmG8lkyzo1fW8T/DgbdrPU23cCmokC2nuDTvowF/y9mqC7FekspP/07UeSLgwVXBnrK2udoC9iutRA81lfR7khwHOXQ==
X-Gm-Message-State: AOJu0Ywv+NaTEE6jNSdBJW1CPvhRiVbHM76YWlruLQ+oSfi+WyZ6Pj2r
	NgvP8656CSXx8GNruQ/va30OyUOap8uMPm2FWZlIrmHrUqu0zkS7bLVD3wi1sl4DS5ZkKdAd/l2
	Ca8xyHsk3UjIdn4/Gzfbz7z31gSZ1doMLxWFcjCl5+tjs0ERKOoDfm4NZcF/+gw==
X-Received: by 2002:ac2:5dc3:0:b0:515:d4bc:c63e with SMTP id x3-20020ac25dc3000000b00515d4bcc63emr6164316lfq.63.1712051517736;
        Tue, 02 Apr 2024 02:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgP8+1XbBJ5ff68r07k1FqXNHSiMuetoQuLpbDHs4hLQfzFExtQKN0mhpH/OIqMg/05NwZRQ==
X-Received: by 2002:ac2:5dc3:0:b0:515:d4bc:c63e with SMTP id x3-20020ac25dc3000000b00515d4bcc63emr6164300lfq.63.1712051517095;
        Tue, 02 Apr 2024 02:51:57 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709060e5100b00a4623030893sm6228283eji.126.2024.04.02.02.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:51:56 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:51:55 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 01/29] xfs: use unsigned ints for non-negative quantities
 in xfs_attr_remote.c
Message-ID: <nx4hkurupibsk7fgxeh3qhdpeheyewazgay3whw5r55immgbia@6s253r4inkxn>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868577.1988170.1326765772903298581.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868577.1988170.1326765772903298581.stgit@frogsfrogsfrogs>

On 2024-03-29 17:36:19, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In the next few patches we're going to refactor the attr remote code so
> that we can support headerless remote xattr values for storing merkle
> tree blocks.  For now, let's change the code to use unsigned int to
> describe quantities of bytes and blocks that cannot be negative.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_attr_remote.c |   54 ++++++++++++++++++++-------------------
>  fs/xfs/libxfs/xfs_attr_remote.h |    2 +
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
> index a8de9dc1e998a..c778a3a51792e 100644
> --- a/fs/xfs/libxfs/xfs_attr_remote.c
> +++ b/fs/xfs/libxfs/xfs_attr_remote.c
> @@ -47,13 +47,13 @@
>   * Each contiguous block has a header, so it is not just a simple attribute
>   * length to FSB conversion.
>   */
> -int
> +unsigned int
>  xfs_attr3_rmt_blocks(
> -	struct xfs_mount *mp,
> -	int		attrlen)
> +	struct xfs_mount	*mp,
> +	unsigned int		attrlen)
>  {
>  	if (xfs_has_crc(mp)) {
> -		int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
> +		unsigned int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
>  		return (attrlen + buflen - 1) / buflen;
>  	}
>  	return XFS_B_TO_FSB(mp, attrlen);
> @@ -122,9 +122,9 @@ __xfs_attr3_rmt_read_verify(

fsbsize in xfs_attr3_rmt_verify()?

Otherwise, looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


