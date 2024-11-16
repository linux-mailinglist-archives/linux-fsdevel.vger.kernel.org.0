Return-Path: <linux-fsdevel+bounces-35013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E69CFED4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068B7B235E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97D198A05;
	Sat, 16 Nov 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF+ie1JF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75517E44A;
	Sat, 16 Nov 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731760469; cv=none; b=WRzBXsyC4RYVw2h/99WdbEE9EnCLs0o1wYPFcaB7EQS3g12EEMBGMVLd5ES3QVs2N7XO0Y72te8BgPxtLEyuDNyzC5xPyEKnZnpNLJwn9rmK+z5U2J/a3er41VXVaWJ9eJNDZ3Yg6SWPVjtM15FjCLP53VrEA+cN8t2/plDJEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731760469; c=relaxed/simple;
	bh=GHUEOYJoLV8zdUhoqYwejQdeNblBrkuxKUGJYzFtDLg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OWxYsDSQnXgeoXUWJoWsFf/ZtfPy1pUYuyg6uteshdQfmb+B5n6KO8yjFcJ7V4gs3iWMTSAHQZUmucO14YSFIol3oMetP0J5ofL9vrNWqelM+IZaAREnup77dk+vGzEAk+6qlCrQzUcGFF2p/x8+ONrrFOewtr8oCfy0Bd/yjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF+ie1JF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbcd71012so4716705ad.3;
        Sat, 16 Nov 2024 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731760467; x=1732365267; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fEtJp9SSOayGK+bhR6rbytlyGbW7N5dlpS26wnCneKg=;
        b=CF+ie1JF63uUMhOddfq0b4/e7j1cHtT0p9vwcviwY42wVFlz/oxeniLD02mJJ1pR2w
         4dMv+UA0GfpJGFzXGDe0hP2FC4GKM/CI/ltVOuY+zwnOxx354KF9ctzTgERyrkiG6a/H
         okts1jj44C5Vu21TIRazIgfOBWILOxJwYhsfQL421SPIT1XCtD0mK+1rArF95/DOCoJ+
         2g/Po49hw3Q13UcTg6UQRZ0Ut0F1y9K0Tywe7VnrLRTBG9tGvO8lPxQJ6DGGgBNmkkDI
         i8gdAVNUCqKZc/h34K96xf71jlcUZw86owuAy8DsshXRTvDYjZdZpRaJrBmhVQpJv0R7
         i1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731760467; x=1732365267;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEtJp9SSOayGK+bhR6rbytlyGbW7N5dlpS26wnCneKg=;
        b=X5TfsFqoEEqckX4iHJtmP1sa30U2WCxymKpiuwRm4gdwblNpzRfbgIkxja/pRZxhVF
         xUOSyzqV6t1h0Jo0aocnq0eh8TfQjK9Gg1T9r9nTZIQYgCqSDltx7cJyu6GQXE7XGSZJ
         irqLXM7M9MNHOZwLfYaf+ILtHSyjP8E3CPXzKqGfkeR06H8AtYZ+ckptsj9H2hmUgtNK
         7x09DVXfGKp0TBRr/JN4iIsXXWL/gVQ73K4dhJOYdz63zWjU4nwZ7i6NARogMfEENJpX
         WoOZJGz+VpRgNmUoKRXWL9K5J5ZEmIyaw85OrWTx/7r0GcppzhVbXPnsrrqMyBKsk9uy
         Q7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU6awTg4jPS9vlZGyA+0GJn93JraVm7tNg3CgLKjeAWBrgUkIvSKhPUu0Zc70BCBFEjQ0XIJZ4mmeIGtTEP@vger.kernel.org, AJvYcCVLK0JBvUeW0xQIeRVHc/kdsv9lHRGYKGxkJ5Dd8NHOqxgygAfVMDgDiLsMNDFWVg9wpvqcFnQ66QNvXwQe@vger.kernel.org, AJvYcCVvjbdStpIuCHzLunCkR/GXOKq9c+3EME8V3gxL5baXl021pULfcf9CJgfUubT6X78xC33wpgFwGu4rVqGAU9l7@vger.kernel.org
X-Gm-Message-State: AOJu0YwoD/OnFzCtrPef1uvFayFE+QFCWg7mg8/mbUy+AG4RFdBSy3sw
	JglvUe+XQPHM5MDR2qAaFS45qcqUR51GJCD/rhWQ7L2MyGqU54OMVliBnpCD
X-Google-Smtp-Source: AGHT+IGMIdd0MVq9ycS0BwfPAQWlm2CmDCHtZs+52Ag/FtZcI3X0AMiqJ588rNWYIzfyalFel19UQw==
X-Received: by 2002:a17:902:d50a:b0:20c:8331:cb6e with SMTP id d9443c01a7336-211d0d818c6mr91611965ad.19.1731760466885;
        Sat, 16 Nov 2024 04:34:26 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34903sm27031255ad.158.2024.11.16.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 04:34:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, brauner@kernel.org
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels
In-Reply-To: <20241115134114.1219555-1-mpe@ellerman.id.au>
Date: Sat, 16 Nov 2024 17:12:34 +0530
Message-ID: <87o72fcslx.fsf@gmail.com>
References: <20241115134114.1219555-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Currently the mount_setattr_test fails on machines with a 64K PAGE_SIZE,
> with errors such as:
>
>   #  RUN           mount_setattr_idmapped.invalid_fd_negative ...
>   mkfs.ext4: No space left on device while writing out and closing file system
>   # mount_setattr_test.c:1055:invalid_fd_negative:Expected system("mkfs.ext4 -q /mnt/C/ext4.img") (256) == 0 (0)
>   # invalid_fd_negative: Test terminated by assertion
>   #          FAIL  mount_setattr_idmapped.invalid_fd_negative
>   not ok 12 mount_setattr_idmapped.invalid_fd_negative
>
> The code creates a 100,000 byte tmpfs:
>
> 	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
> 			"size=100000,mode=700"), 0);
>
> And then a little later creates a 2MB ext4 filesystem in that tmpfs:
>
> 	ASSERT_EQ(ftruncate(img_fd, 1024 * 2048), 0);
> 	ASSERT_EQ(system("mkfs.ext4 -q /mnt/C/ext4.img"), 0);
>
> At first glance it seems like that should never work, after all 2MB is
> larger than 100,000 bytes. However the filesystem image doesn't actually
> occupy 2MB on "disk" (actually RAM, due to tmpfs). On 4K kernels the
> ext4.img uses ~84KB of actual space (according to du), which just fits.
>
> However on 64K PAGE_SIZE kernels the ext4.img takes at least 256KB,
> which is too large to fit in the tmpfs, hence the errors.

Even though ext4 will use by default 4k blocksize on both kernels but
the backing file here belongs to tmpfs (RAM) which operates at 64k page.
Hence the difference in the size of the image between 4k and 64k kernels
looks expected.

# 64k kernel
du -sh /run/ext4
256K    /run/ext4

# 4k kernel
du -sh /run/ext4
84K     /run/ext4

>
> It seems fraught to rely on the ext4.img taking less space on disk than
> the allocated size, so instead create the tmpfs with a size of 2MB. With
> that all 21 tests pass on 64K PAGE_SIZE kernels.

That looks like the right thing to do here. 

Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Fixes: 01eadc8dd96d ("tests: add mount_setattr() selftests")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 68801e1a9ec2..70f65eb320a7 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -1026,7 +1026,7 @@ FIXTURE_SETUP(mount_setattr_idmapped)
>  			"size=100000,mode=700"), 0);
>  
>  	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
> -			"size=100000,mode=700"), 0);
> +			"size=2m,mode=700"), 0);
>  
>  	ASSERT_EQ(mkdir("/mnt/A", 0777), 0);
>  
> -- 
> 2.47.0

