Return-Path: <linux-fsdevel+bounces-57899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC407B268D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7411F1CE3899
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88231F00F;
	Thu, 14 Aug 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PD74QZiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7031EFE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179955; cv=none; b=S9KNdBYBRGZXbhjDJlCizqZFA8nEI/UKJBZ0XTrbbr0goMJ13OSieCZCCla2aqfgN70214H2qf2ocv0wnX6dWfzha0BDizKD7PSnCA5IJqvZc9ny/j5Sk25Tdmtsx0lIsgMds9bUfrAWyLIpqPtt+35w3mvxniJfN9sjMWiA6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179955; c=relaxed/simple;
	bh=4ExxKGDx0fgiOXw8CTywAcBsJ8ogwJcpwNnL1i5YNn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAvKVS8BgMRSwBYviRVKlSHoPb5Sapk9Yr9Gn15zE9cMr9vBm4dOmwKfQKw4CaKmfpL1Q2UtTBmneJUzyEC5Yo5C6kKxW+9EA18qDo57/GspVXNnnhpqYF5gpOyhxyq+Mnhq/ey1HaDJ5YkoxvE5SPpcN+B2Np5WdJWM9J9ALWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PD74QZiL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8706491ecso128378185a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755179952; x=1755784752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZZu0s3S5A8+/SIi2GUbQjh84N2xIaZ27oBHRZEOGZ0=;
        b=PD74QZiLTGXzEMQk/BdYF+yhFLbKmUCr94Ea+ZAUkleeb7z71h6BJVBuCR1Til6/SS
         LtdRWqoM699QvbLRgDJTyFjwY3f3SdtwgP8PIbTglDlx8O611Bcbhni2IWU6XK/GppK9
         Ax4gNFboxlhdDcZ7AUatUkQbq19TzeOZECLnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179952; x=1755784752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZZu0s3S5A8+/SIi2GUbQjh84N2xIaZ27oBHRZEOGZ0=;
        b=asLZJlyIFiOMhLWyOwi91YlPyPfjbJgrlzCy6A1da5zR5Aml4mxymt9K7mAzykWXzL
         BZiLqsgNQgpiv1kk3N3az5qC5HhqBloiYvnXJhq9AQY64hbvjf+hSur+JfBRLgVsW5pO
         J9LUmxXibH2ZYk5hWceVJMpTV5MLyF+P0kYbLfNtHC6JaPt+xtrTqXyDP+0+CbI13clF
         RQvSpSd9pwu9YMQ0ma7r/z0ajqrPtXixVLnfCCwVOr7uOyRDiouJW6vyQ8Ut+oCuOyBW
         Az7/m3rLrtNQxxPYnWQgrjHyVbG2YmxbBWQy6vAG8z1MfKnQ98BrQw2P2qY+QhIpJ5vb
         0uSg==
X-Forwarded-Encrypted: i=1; AJvYcCUMZWw3fTVVWsQzTQGbdj4TdHLeCgLQ4JpuoDmcIKahNZ5hBmi+f6UEGIxh+rCSlDPLhMmprUlaFH736pTK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyn1tf3FljRDE7lgBa4TQXLELs7WIPJ72KPEiyv4NA+PiSKC9K
	xvkHnag6zMlOhx/1adGJaWJ54a8s+w8R+TbXUpi3I7fYCn1jMs5PJ06mjnb1tAZ6b3/32OXBKp5
	nD+VkKDWmSBy1mpxX2BqWRyxY1SCs39bBFTPdRwMkLg==
X-Gm-Gg: ASbGnctt1UprpP3SwYmMztWyaD7K04/D6TsL8/d86h8dA6obIloe54wMrakY7UACLTR
	ZmRp/3f7IgJ8kUViIp5R+2aJ0lDtEad9ar5zKHKGNwjKKQtUAkJ6bq6+0+tFKtyqZLU7nEiJHnJ
	G/BISQmx4k19axAxe4BTpNLa+2J7Pfhw1E74f52J3PpcvmPd/2kqlxce7wPYiQoq3w6T5drwNfI
	+nE
X-Google-Smtp-Source: AGHT+IHDCZisldsHFROueT1mDv+N2w5BriAS/91vOctNmeG6Etw7NNZmRk8u6yHZ87xrdPA7iktx621LgwaHh85teV4=
X-Received: by 2002:a05:620a:e0a:b0:7e6:8545:5505 with SMTP id
 af79cd13be357-7e8705a2a88mr419769985a.55.1755179950579; Thu, 14 Aug 2025
 06:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
In-Reply-To: <20250703185032.46568-15-john@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 15:58:58 +0200
X-Gm-Features: Ac12FXxPrNeYbLt2gO4V6U2nB86--yn65EeQtUloUgMUUdsnzFSb_AaNjXQhYqI
Message-ID: <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
>
> * The new GET_DAXDEV message/response is enabled
> * The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_dable yet.

This is rather convoluted, the server *should know* which dax devices
it has registered, hence it shouldn't need to be explicitly asked.

And there's already an API for registering file descriptors:
FUSE_DEV_IOC_BACKING_OPEN.  Is there a reason that interface couldn't
be used by famfs?

Thanks,
Miklos

