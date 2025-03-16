Return-Path: <linux-fsdevel+bounces-44130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D2A6336F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A833B2147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6B13632B;
	Sun, 16 Mar 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTjYF3dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA627706;
	Sun, 16 Mar 2025 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742095905; cv=none; b=hzOhd1tXCRpqXiIZA43R/ZISuC0CBg5PxWwW7Nu0YWwYZthCnRG/84xhkpwS2cG2vW4pS64RIZV3qbaqXQ1riX9d5LL/xt+3jBI6SGR57YPEulNYLhpmW6FUnb04MpdsMTHKOONhcadZDINMnjNP85UrWnmap2qLQK40/7X+JAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742095905; c=relaxed/simple;
	bh=pD1Yck7ydAIpMEylqYKXsYLm81BbZCKaQWMdqrtkrqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJcdq8+7LAM7TvC78wjN3ZsgBFtfGf/R15LEF6U69v3VzJ259w+zsE093F+PeoBFGkwQeBke8ORph+rPYoMDIxejR3xWGXMI93woPVRLDmAmFN9HBSaG7miK9hLOM67RN5BMGwK/mWqvGffZVcVVmcNhBt6EvfIdIucES0aR6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTjYF3dt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225b5448519so59405905ad.0;
        Sat, 15 Mar 2025 20:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742095903; x=1742700703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pD1Yck7ydAIpMEylqYKXsYLm81BbZCKaQWMdqrtkrqU=;
        b=hTjYF3dtxaVVwFXyCkgr7I56U43r0UAfcG3MVDRSRl4dra7WL7CnUVhwdklYfKC9rQ
         AwOMruzyWl4BAgPvI7KRIxP7Ym6kHPMDmDiUhMjByQFu2aqUSf+cG2PcGJPdMjUP9MKp
         8rwbvjnKL/lGrQqJu3DYxuGuUMLh8EJScw2EojQOeOFUl95Q7ZscSLOqebkbA5hlwBbK
         r+tQRLOvtocFw7/i3TFJPqZUlfo5qiOmS/BElBZDKv2Lfju5PWAOV9aJFnzRs7Eb6x/5
         cw0cmqegD6065U2RCt5UjR0KFsC7KE0Hcj31IeIwlMmgtt2zseFtzOEE4hkE9Seq0uCT
         SplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742095903; x=1742700703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD1Yck7ydAIpMEylqYKXsYLm81BbZCKaQWMdqrtkrqU=;
        b=SPPb9bSBCPzUgkywhujctS6lN/1Xy6Lu3WgI+dXNjn4iCmDUqM092Q11PFJ0PVxRgg
         V0HdOsGyYxS04JJs2cH1+lWKZ384cSz3GewJZVByqNdDx+hDlVhHMkKH1sgub9lcMaDr
         0I8hyu1Sv/zIrNiRny/QcohA3pot9gkAirgOvCmo1muSSRMt14eVlNwHmr6L1sNku8ZV
         6FXG4deW05q/+vqmhUhUF55HpbdgvqfVxUTEAg5hRLdvrfY7T8o95B3sfQ3U4UYVP4hK
         U4xfYqO4LlIF9q7g4gOjLNlv2X0qJLdle1srNsiYGWTGVg+R38/RJlpMJcwOTwfyB6mC
         /OZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXOJPmELYIa0Pml+d70G1oDejDtbpg6euhS+TpbUzwKKJXiGEtMJMu3jJbGj3TX3jCtskpYEjtWWJM62wh@vger.kernel.org, AJvYcCXbEOZwYX3kKtMWoytSrZNwXxWTAvUf5AI97drU7VfwVS27iPkLzhRsppAJMn93+kn4na+soLXS/ONAao5E@vger.kernel.org
X-Gm-Message-State: AOJu0YyIszDBdcKHb1bnD5Tg6AYMCElHsaOEGv7h5/V2AvHOWGlY7MQ3
	z7LV/MJvh2kJyn1PQccsm/uzoFDu2hs8LodjI/AS9HcxzWoTI5Mi
X-Gm-Gg: ASbGncvoKtMcuxYLppQtM1fHGmMlY7M0Nml+PkNAtBi1aPNfdPWw4tSzV48NI6RVK4F
	d+v0BvQA/m1QoN98zz+kCGfcf8CmOjC9gEMXfUbU1xSGcq5S7S23LLPAmSxhw9EqPdOSCY1+SnV
	a62GKXRA46ZuuP/BQr6umKF4F2QqgVTT6OB+YV7ZVfPk9oKhklJI3cY59nSL7cR/AbU5+SO+ZpW
	O5A/pIuko9wXuvsK5Sx389VwS++OiTUhFDQ7SZtJe4YZHtqaG1aNL9pJwlacPketgYrucxeAfib
	DPoNsuik5LJnzDadzCkPDV4WgM4Y2pnjWmaqkZG3jxOl2qRfxb9rCTnYMOOtaHG7
X-Google-Smtp-Source: AGHT+IGpbDM3YcgmMRmMt+HOj3GJEp13IU+ynAj5/Sp7d74TkBgUMj23JdRZJfWsImx58hn63y8Ijg==
X-Received: by 2002:a17:902:e884:b0:223:67ac:8929 with SMTP id d9443c01a7336-225e085b857mr107024325ad.0.1742095902790;
        Sat, 15 Mar 2025 20:31:42 -0700 (PDT)
Received: from eaf ([2802:8010:d581:4700:c99b:1600:cbda:3005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfb5asm51134575ad.209.2025.03.15.20.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 20:31:42 -0700 (PDT)
Date: Sun, 16 Mar 2025 00:31:33 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu,
	dan.carpenter@linaro.org, sven@svenpeter.dev, ernesto@corellium.com,
	gargaditya08@live.com, willy@infradead.org, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/8] staging: apfs: init APFS module
Message-ID: <20250316033133.GA4963@eaf>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>

Hi Ethan,

I'm happy to see your enthusiasm for my driver but, if you want to help, I
think you should simply send the changes you have in mind to the out-of-tree
repo. That way you'll start learning the codebase while I can review your
work and run xfstests for you. Filesystems are very dangerous things; I've
probably done a lot of damage myself back in the day trying to help out with
the hfs drivers.

As for upstreaming, the driver still has a few rough edges, but I don't
think that's the real reason I never tried to submit. I'm just no longer
confident that filesystem compatibility is a reasonable goal, and I don't
expect much interest from reviewers. There are too many risks, and too many
hardware restrictions these days; regular users have much easier (even if
slower) ways to move their files around. Other uses exist of course (like
Aditya can explain), but they are a bit esoteric. Of course if upstream
people disagree, and they do want the apfs support, I will be glad to
prepare a patch series.

Ernesto

