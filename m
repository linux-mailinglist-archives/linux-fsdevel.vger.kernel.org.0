Return-Path: <linux-fsdevel+bounces-48271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4CAACB95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B3C4A26D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F728935F;
	Tue,  6 May 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwP3vnqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B41288CAB;
	Tue,  6 May 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550129; cv=none; b=XR4Dqr549Kk7NQV7qVa0vdVOwAOW4JzUBBiDh6Id9lz4Gucs6GnLzhhisOfQcZf7MYETZApJerhw/P+RDB3nsBLjxzZcVkBI6PAwdKJp9uvtSf8e7mLDt98AfXiJfTM4pHjAN9iw1FeKViOTnBfVhZYMlaAtwjFLXlgoZka2Z4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550129; c=relaxed/simple;
	bh=Lx2SNbqeZIFvMKNyW6zdHJldKWDUxIt5L1FLqPcWM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfNIV9iP61LmQ/wKqcOV2oApC2XpHyolKbeYOZXX1PsIjXwTS+cnfdh8aE9p4qOVc781vV0PeGtxJsv7YM1t7CZIiLfNI8pb8Yj87kehWjcIjCQCXsIdKxQ2yN1LvT4O0zjrn2m3h9oW8NX7ZrDY3OHnVoEAG8yByQpuVPbC5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwP3vnqS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54e816aeca6so7640446e87.2;
        Tue, 06 May 2025 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746550125; x=1747154925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NujfFxyUhedge2eaij1lB5IcnfRq7XQMmNxKskmy48k=;
        b=DwP3vnqSq73nPwrOBHQTMhEexM9iDMZ5OlbMiGJwj8VdQy8zx8Iio+UJlta0Bmzp7x
         4DMfGWRZNuupkKTKnUIonsKw5CBRqskqjrZX8ZrwbSIIo+J4vHjThVTnaD3ZTY3Ia9S9
         u1vHZgFoyKSGGrjk/cWFj7tqpD6HuS6tw4zB8iu+LO4zFg/M1m8VilfJjdMmbV6ZhZbG
         8WpxIGP5JVeBeMa30gB6Jj2473Qu3a4sABqFvHIxn3U5Fb/JESiVsfkUhMs2u5iV59lH
         K2mAGQZMjkS2q+sQyupOMCxn9mFPCkUmirNMRwDGdVdzghVNPALPTU4dJYtp5zSnFLML
         edvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550125; x=1747154925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NujfFxyUhedge2eaij1lB5IcnfRq7XQMmNxKskmy48k=;
        b=wT8eNXBerc+IoxmTMOvwd/6fdm9edW/iZSJQ0znq3I4QA92eIHmLW8G6aM1SZCJJVe
         NDqxpS5dHPOfEJp+nvrju3UeHtnEVVwfrJko78ykqDXaZh/Xwhydn4PyJDl6zZvvqH5N
         8YJJlmZ7gpjjJl14LdmjFkIKqLCx0jowqb/6xZzxWLeMnjmJG02pPXpxfi9NRRgFMTnf
         lB2i4RIsUDEhTCnlIyuKMKiAjEuACgiECtqbaB7KWVyI2Tclknn9OWBOMeL/4qxDGYhQ
         2Om6zxN6MI3jemB3tmL0wMTASApx9lf2lSyCw0PMABFqYKyoLCvB3RxViCW/jOnMzczO
         GYaA==
X-Forwarded-Encrypted: i=1; AJvYcCUb63KkLstORichA1NRiZBgTJfQ6fQvnGRugBekPMpi1S5o6ML6XcW7apSA5OHKH/G3xgKG72SuRsyeQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJd0a5LL26YOl4cLMk4QUnV/DqQFK2SlMGCZ6dEZuNcbWdQd2s
	t6RJBSiAizkfuK5NSnM0Oxa1k8L767r/I5oM3pKBmTYireR765sE1nPpmA==
X-Gm-Gg: ASbGncsZe/D1w4x81wx2l8ihD6yGGuNDSm+6XLA8rp/ha8y1zGdj+DtuBXzR+pw2wvm
	f68EBLu8rQDFudPttTSxkSw6TbYzGz3MrfJ8Qfltuv6PMnQzK4XYz61wE5rlAVKnaM8ySN314wU
	y3PqgvZTuh48t5SWa56KzJwpwhonS/JG6SKMlxYqCyHmKObDYujLUvUvcwBUdblGUOJnT+lCzJU
	AF/w5UPBU1jgQlkSzOBdox3i7Bv3FtFQqzsmdEKhulCNK4j1tvPxbZYAX5c6EnzEY/mzGekkCla
	WN3PFN62SkrNBorxJ2gojnyiQmRVjqoX98zmLnpCcRG1KNPAYBoTL6I=
X-Google-Smtp-Source: AGHT+IHViw6JBz2dslVdFj13siGHF5+V46iDlGTbSl72nNtjD7R7OmBt2yWu4LUmIj/TF4nfmy6r1w==
X-Received: by 2002:a05:6512:1256:b0:545:5d:a5ea with SMTP id 2adb3069b0e04-54fb928ef2emr110377e87.3.1746550125019;
        Tue, 06 May 2025 09:48:45 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-54ea94f6969sm2072908e87.248.2025.05.06.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:48:44 -0700 (PDT)
Date: Tue, 6 May 2025 18:48:44 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <ssczpx3oap3ask6lckb5mseq246vizxbpk7ogoja3w3js35kax@echyx4jeopv5>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506164310.GM2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506164310.GM2023217@ZenIV>

On 2025-05-06 17:43:10 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 03:36:03PM +0200, Klara Modin wrote:
> > Hi,
> > 
> > On 2025-05-05 04:03:45 +0100, Al Viro wrote:
> > > it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> > > no need to mess with ->s_umount.
> > > 
> > > Objections?
> > >     
> > 
> > I hit an oops on today's next-20250506 which seems to point here, and
> > reverting makes it go away.
> > 
> > Let me know if there's anything else you need.
> 
> .config and toolchain information would be useful...

The .config should already be attached (config.gz), though it's possible
there's an issue with my email setup. It seems to be on lore at least.

I'm using gcc 15.1 and binutils 2.44.

