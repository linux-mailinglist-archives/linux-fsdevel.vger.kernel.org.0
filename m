Return-Path: <linux-fsdevel+bounces-10677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8D84D57D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4FB1C20F31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEAC1384B7;
	Wed,  7 Feb 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0EmOxfKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D412EBFE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342028; cv=none; b=ovOmUqON5W2eJdjX4FfS6bS2+KjEclxzq0QioGdWy7YMVA7hRef4aJ6Z83g2Qq25taPsMAG0KAE0GYf7HJD5U90Dv9+UaUPLtvWpUn8b/atW6UXjcOg7pYVX2K9dWm1LmQd2vH1+UNWx5GosF0asrHwN56k95dR40KlxhfbOKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342028; c=relaxed/simple;
	bh=kYd1mmx1LG2P25DFZ5zat9y2SNk0Q8EF32/QN1mN6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxndpirkoJ/pJiK/LzgbeviLyWoWIVrm5vn69owBFFGND08YdE2vwnHwCDiSsIXn8Lee4JoZfJVRGYvHNFUV2/XcCEexzqx3XWsKYZYnUktVHo6XYgG2ZaYgQBHCSu8eduizEAzfWlb6VezY0YQiTydz+SJiCNVo8IT3RV7tSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0EmOxfKg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7881b1843so11297525ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 13:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707342025; x=1707946825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=96rGgaEcRdl2WXKk1MdOnJgP7U6p8RcWNuFw6GhUBjk=;
        b=0EmOxfKgX0IAPDlJXWHQNRy7VWoRFrn81KvHh27rsmTWiFe8ZV7C3ZewX52pCO5VTq
         MT0W2o7sqgQEsBVSL3P9xQWmHkR40IcNb3zXOLYPCi4g6jYZ7xHJQhTMqGyPDdFoqakC
         dJLMnadzshTVZlbOTrPag4JzxHq5txAN/G6RdF2HXPj5ExCrVu4hUImxfQKZRR4G4n+Y
         /9DEyUloego2HiSb33qc1dcxlcg9DZP+WLF9HiuWQFPkRLdryfyKUxmIcZ/oiawS9Pjt
         /bO3YTc5OiF3hHSU/CK5FMJcD1ge5b9Eq6dsmeaxTj3W2zVI4/YKq8kcJhiOHEy2hM/3
         HHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342025; x=1707946825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96rGgaEcRdl2WXKk1MdOnJgP7U6p8RcWNuFw6GhUBjk=;
        b=vphP/x2rzJ3UWsTG4JryaG8KkVs/CXyfxZCd1cbI8XrctOvvjJUfIgSN+gr6tqP3gZ
         XlXiZ/FQiU+i90b+8pJ1OSQBna6JlSWQagfHWVAAHOuncT1j+Bra9XaoOLRPJVyu4yhZ
         FZBztTbAbJOPcAHcSlvsbOC2oMluasASlM69vyVbFmTL3UPOFDPrQbmxKWFt19+pAl3L
         sPgpYcWPGIIoWyahd37wjUOB7EwbEffrKC60bAY9eYEekpxqQH2dPVwsuBEd23xZqBwK
         IqCo7iCxD+Phrolg64je9bJEUPW4qwLHhUnzZ+XiEp329cbS92thbnojkZ9t4fML6/SX
         R1XA==
X-Forwarded-Encrypted: i=1; AJvYcCX9SJPMKTaFPLMa8omK06/JeZEFAyMp7e08Q0zcF83YL2uxK6FvVXnxy2N74xDU3tDniLSoFEBy+qTCcN0qtEVlupwb+A6vW4FqUXoSew==
X-Gm-Message-State: AOJu0YxDn/LiZy6YoQRMPrPFNvviGJ85AsLZ09AprraDHavqgcBRUPjg
	4bCsYXzTD5cdKARq/VZLOJuR4XSZV25Nt3hHuDkOOjH2/s3NjW2wfbIJrzjCXEkQjqwPHzrvvLI
	6
X-Google-Smtp-Source: AGHT+IGAkszL9cvRwIHXpytGOEaOiqHw0w+SMBFFKUsCPXyUTEtd2f1TjheNu4ZZuSwEFByCPD+FcA==
X-Received: by 2002:a17:902:d512:b0:1d9:b0fc:6e70 with SMTP id b18-20020a170902d51200b001d9b0fc6e70mr7326923plg.58.1707342025418;
        Wed, 07 Feb 2024 13:40:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEu1qaurcBewC3kjiTVwoXnHkTeKv7FsKvl0sxa1e0ra5FJBJu6wGeklaodmdgWNELSkwlUDB/dgw2ClYRBfAPcNLD8M/2czMNhewcfwtuKhuTiVa9gRzh85v7LSXNpNJNAlX3Vh/jDPsRMHlHw9PJyd+w/qmI/LI=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902c74b00b001d9ef367c85sm1821136plq.104.2024.02.07.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXpeY-003RdD-1q;
	Thu, 08 Feb 2024 08:40:22 +1100
Date: Thu, 8 Feb 2024 08:40:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Timur Tabi <ttabi@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] debufgs: debugfs_create_blob can set the file size
Message-ID: <ZcP4xsiohW7jOe78@dread.disaster.area>
References: <20240207200619.3354549-1-ttabi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207200619.3354549-1-ttabi@nvidia.com>

On Wed, Feb 07, 2024 at 02:06:19PM -0600, Timur Tabi wrote:
> debugfs_create_blob() is given the size of the blob, so use it to
> also set the size of the dentry.  For example, efi=debug previously
> showed
> 
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_code0
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_code1
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data0
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data1
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data2
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data3
> -r-------- 1 root root 0 Feb  7 13:30 boot_services_data4
> 
> but with this patch it shows
> 
> -r-------- 1 root root  12783616 Feb  7 13:26 boot_services_code0
> -r-------- 1 root root    262144 Feb  7 13:26 boot_services_code1
> -r-------- 1 root root  41705472 Feb  7 13:26 boot_services_data0
> -r-------- 1 root root  23187456 Feb  7 13:26 boot_services_data1
> -r-------- 1 root root 110645248 Feb  7 13:26 boot_services_data2
> -r-------- 1 root root   1048576 Feb  7 13:26 boot_services_data3
> -r-------- 1 root root      4096 Feb  7 13:26 boot_services_data4
> 
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>
> ---
>  fs/debugfs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index c6f4a9a98b85..d97800603a8f 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -1152,7 +1152,14 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>  				   struct dentry *parent,
>  				   struct debugfs_blob_wrapper *blob)
>  {
> -	return debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> +	struct dentry *dentry;
> +
> +	dentry = debugfs_create_file_unsafe(name, mode & 0644, parent, blob, &fops_blob);
> +	if (!IS_ERR(dentry))
> +		d_inode(dentry)->i_size = blob->size;

i_size_write()?

And why doesn't debugfs_create_file_unsafe() do this already when it
attaches the blob to the inode? 

-Dave.
-- 
Dave Chinner
david@fromorbit.com

