Return-Path: <linux-fsdevel+bounces-36216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F19DF768
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 00:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF9E162A3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941231D90DF;
	Sun,  1 Dec 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M0hQ45iS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C61D8A08
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Dec 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733094775; cv=none; b=adx6u5i8iM/BEiKdgv5fg1lDhUSTZRHP4mkd/Bc+7bvOApjoOKdNZwhhd9uFCcTnaDB0mfSsZbCeGacgvl2lU+3k9kB6xV34zkesXMe0B7hpQs7Bq/mDD2pk0Uz05xvufk/9lISsMkZ7z6DsGlPsib0OxZmYM1Rz4XFNra0RiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733094775; c=relaxed/simple;
	bh=J8VkV+WotHTbc+qzAicULfwz+kWFtfOFEM2EEedBVEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bklAf9B/KzoSVbnYmKfjGqTuAyaPSBaxohFo/etUJNoG/eT2shjwPdOfbcjbGpqgziazaLfqh00XHa2Gg9+Ui3zag/CrP6tcBglLntA5l+QZ/5g3f+3dpoYBGl2qvSTmx2yPP3I0YPk28ahIHqrwJCK7b8Hh+r9hXgCosL4XVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M0hQ45iS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-214f6ed9f17so31249385ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733094773; x=1733699573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ud96SwjzR69msh47uFT8pcG4a0oGcZjdWqXyciAzX0=;
        b=M0hQ45iSdWpm1DXmRMKFQ/1LEHoqgHcqWTJ8GJSudpfsggHQ45cDLWfUJcehe98ViI
         tjtpguWs6OrXqy+3PjwSMPCPUp14OJbgn2bVyDzG8cCXoZ4TEl/JbSrVaO+tsTniYb1O
         GZv1X8rNmraQyutdF9+7iU48oUXb0PcUb3nkR9slzz0HHT8mLxAb3ITOFPT1Yl98OHPo
         LywM08Wg2IvHyFaQATUwmW3VEDzpdi3GqwvlO1oz92+VVxJbgdaWMJ8XJUk2nYrGJX7r
         O7XTKc2Tvpkn49EPiKYK/Xpma+dLE5In2I11u7uCrfMMlXJlNFF+WvXAmrhggtdRAEw4
         SsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733094773; x=1733699573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ud96SwjzR69msh47uFT8pcG4a0oGcZjdWqXyciAzX0=;
        b=sijizO+dpP2NOuW91gx7NHbVUUa1wY0js3zlSDsWEqciuRVVtDZVVWQokR0ttpyj+M
         vXzOzCbAJBMoBR40+olyFg5+omWRR3SJ2as7KLmGFZA/4cpc847U/PNiORneVeaa2oiw
         yj2fexQVgZ1RydwEf9Ve6y16m5vtc/ixtHZBNKEOvMnFm/VzLyuz0UrzUwqxAk5CzZ8l
         aoSOn9EcJ19nej1rKudL41lK9rYIELk/ki8OZvmC4whOvCx0U+jERiM7sa70NjThkHsz
         xyQ685BLvuO923wc50/KBAk6RT4OH3PynaAwmuWdKPq6/LixLrxv37yhJBoUPXiFrt1f
         5ROw==
X-Forwarded-Encrypted: i=1; AJvYcCWFugHf90cKG/3WAhPM+HaslxSZoDqS6ZbXSWSwQKbPBhsqji3ngVu6/BkVvJvAounWaC9P5eze1NfJLIfc@vger.kernel.org
X-Gm-Message-State: AOJu0YwSh2fRje15H2JXwzjRruudhM64tDYYyZVv+DVevFfWGUESehhY
	RR50c63QrOVSudZ1zCFIfMTGYJ1lYrpq/hr0OQX1VXyDk0nwiYnoCQv7pRSu9PlTE5mMbnOPVIn
	3
X-Gm-Gg: ASbGncu/6l34azRYjU/NC1hdPvBsdQ+Wpq5ipIrt6ku/ecne1gosjQzA+xJE1DztwTU
	+93roAq5ryAUs5y3qZc6/7KJUOrqhiALjn2XV1ruRIa+Y1USbKSV6z8H6MqUXWa1/36T9A+VDGi
	JtgYrlTdMLwPSWBoABpRfPx1rl/+lcI8XbsHWEwSgpo1PUZbVtgRGBHeWym9M3+Zl/ekdF9Lwdp
	cLCzTRG6tqL/JMMgYMveQ3WUHaThM4FGOySx6gEnjvii+4i7CJ5hsPlzR9ysmstd5JbYrz+BUaB
	mGJp6AAWf5UwXp8=
X-Google-Smtp-Source: AGHT+IEUf9nhYkqjXOeOh/hMs/OkzEv2HFGTg4ODqnBWxYi0eowzsqMTlMTjPtPpo9vv1WTTH6CBiQ==
X-Received: by 2002:a17:902:cf03:b0:215:854c:a71a with SMTP id d9443c01a7336-215854caec5mr43450445ad.34.1733094772815;
        Sun, 01 Dec 2024 15:12:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159d48d97esm1318865ad.239.2024.12.01.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 15:12:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tHt7R-00000005V7I-2Ilj;
	Mon, 02 Dec 2024 10:12:49 +1100
Date: Mon, 2 Dec 2024 10:12:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH 1/4] exportfs: add flag to indicate local file handles
Message-ID: <Z0ztcToKjCY05xq9@dread.disaster.area>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201-work-exportfs-v1-1-b850dda4502a@kernel.org>

On Sun, Dec 01, 2024 at 02:12:25PM +0100, Christian Brauner wrote:
> Some filesystems like kernfs and pidfs support file handles as a
> convenience to use name_to_handle_at(2) and open_by_handle_at(2) but
> don't want to and cannot be reliably exported. Add a flag that allows
> them to mark their export operations accordingly.
> 
> Fixes: aa8188253474 ("kernfs: add exportfs operations")
> Cc: stable <stable@kernel.org> # >= 4.14
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/nfsd/export.c         | 8 +++++++-
>  include/linux/exportfs.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index eacafe46e3b673cb306bd3c7caabd3283a1e54b1..786551595cc1c2043e8c195c00ca72ef93c769d6 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
>  static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  {
>  	struct inode *inode = d_inode(path->dentry);
> +	const struct export_operations *nop;
>  
>  	/*
>  	 * We currently export only dirs, regular files, and (for v4
> @@ -449,11 +450,16 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  
> -	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +	if (!exportfs_can_decode_fh(nop)) {

Where is nop initialised?

>  		dprintk("exp_export: export of invalid fs type.\n");
>  		return -EINVAL;
>  	}
>  
> +	if (nop && nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE) {

Also, please use () around & operations so we can understand that
this is not an accidental typo. i.e:

	if (nop && (nop->flags & EXPORT_OP_LOCAL_FILE_HANDLE)) {

clearly expresses the intent of the code, and now it is obviously
correct at a glance.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

