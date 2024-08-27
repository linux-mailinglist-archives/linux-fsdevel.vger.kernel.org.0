Return-Path: <linux-fsdevel+bounces-27352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EBA960811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17486B2198A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36755193088;
	Tue, 27 Aug 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XoIUTGio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CB19DF97
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756407; cv=none; b=Bek0ufUMQZ3i0ICDFSbPKkaqVO9M1kMYyqA5RKW23vKfR4AVGDAvz6F/0ZWUfGbNusOtjA/AZMr7pMpNu5Qkx7L7A7zmz/gx1N+V4FJxjhgWxgV32gGcLMLi9LrPjNZOLlA1y20akAtiw+mPl4RUhUNFxfveo9NZl3b8OIyEqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756407; c=relaxed/simple;
	bh=Z+/nOjlTMo++MCBkZXaip416vdNwPvVi07iBUNzR9UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/+J1FWAuE+jrmW8YsTNwoQpGYCVWnnneeAJXnhaxfRGVo6zQzpgg/5B2NdiACeITOA/ZTZEuDePvM2p0UZyen2cq1pTSDBHzBKK2crHfIkbuWRUgqYtVxEecCW6toI4P5/VefYytQcjWiGEs5F/TS2ytAaXSjJCCxm4DN1QaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XoIUTGio; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a35eff1d06so356440885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724756405; x=1725361205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SKv2e4GHMwLuOw+8ltJVGID61f5ISR1uTBMJPvFuBE=;
        b=XoIUTGioYCGC0FEAjbR6L9ZPMQAx9ukgz8kpIitLdeJJps40npB3X8oFEzNn67VZb7
         Qo+9g/F10+87y7RXZpFseJ8DeKxzS3liu+EvabEIYjxBcKGBH8KUmmHFmDR3e2EN392g
         SOBLlZn7LOc4kdW2JlgSWZMUWgBpJ4yBb/V16XWAyt0Btz9FLyq5rKVQrjATsKsr+IR9
         If3dDBus3DT09SB15hCaZhC0wBX0TvjoIpmRgTYfGOKf1djNpeIfLoyIltsayQwgl6Ie
         CRQBUg8eiAVfcb21W5348HNCmWAplFIH6dsEmfM0BmvNPEk/Sx91SXvhCFxLcKeOi4nv
         YsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756405; x=1725361205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SKv2e4GHMwLuOw+8ltJVGID61f5ISR1uTBMJPvFuBE=;
        b=Yd5+dV6U+JurGsS3/EEbxrjUURNQ1vM3eD58+3xaZ6tBE0+O0vqBn2t2KQiTCNGHrx
         0qOWviiaazJkgKsnX60zND1Rm7ZpbUZsACOVf2pYnur3ARR8wcf+OHLefgn0jdQrr5pv
         OWoLoxyEAtRy02xmQO7xOT1H8bonykf5bzUISAkv+XCpuESoYSAIzbuvgdbiIzxUkZce
         9q8Hw7FB4zWWASB78cCNHsdoPl1z3JPzHZJWazGIfDPzT4u+NXNioczd73YfYFMwW4HU
         bYGGsaZM/mcivtN7k9MBkggd/Dhbo26WE0JM7hHr3w/1Kg2YluPYZvhkNRJ5zzMDiUJj
         TEyg==
X-Forwarded-Encrypted: i=1; AJvYcCUXbi/xrVx80dIxQRrxEJYS/iTp2ii//qG22S2DdbXB5B9Y4J3KTPRxVLlMLlv6lRlJhvC2Me7ccAaTHfvq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Ry7KC/qXwIEkKZ2mtu/fmj4uoQuWfRd5LF7CNh/5ocZop7nv
	xPk+9LK5ilrEACNJ48NikFBETaBftNwTrHADp7v2LqHVq93X3H0KXiaZsdrsIDEbbT5qEWmd/VC
	C
X-Google-Smtp-Source: AGHT+IHBaTd6815bm3NN1wtqTB5TXa/U1hE3BPk1cGfilWuuHcJp1vWgr+3HmCv+kLy5IQwKCKvROw==
X-Received: by 2002:a05:620a:4590:b0:79f:67b:4ffc with SMTP id af79cd13be357-7a6896d1903mr1591488085a.5.1724756404960;
        Tue, 27 Aug 2024 04:00:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f35be80sm539896885a.61.2024.08.27.04.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:00:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 07:00:03 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/7] fuse: writeback clean up / refactoring
Message-ID: <20240827110003.GB2466167@perftesting>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>

On Mon, Aug 26, 2024 at 02:19:01PM -0700, Joanne Koong wrote:
> This patchset contains some minor clean up / refactoring for the fuse
> writeback code.
> 
> As a sanity check, I ran fio to check against crashes -
> ./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o
> source=~/fstests ~/tmp_mount
> fio --name=test --ioengine=psync --iodepth=1 --rw=randwrite --bs=1M --direct=0
> --size=2G --numjobs=2 --directory=/home/user/tmp_mount
> 
> and (suggested by Miklos) fsx test -
> sudo HOST_OPTIONS=fuse.config ./check -fuse generic/616
> generic/616 (soak buffered fsx test) without the -U (io_uring) flag
> (verified this uses the fuse_writepages_fill path)
> 
> v3:
> https://lore.kernel.org/linux-fsdevel/20240823162730.521499-1-joannelkoong@gmail.com/
> Changes from v3 -> v4:
> * Merge v3's 4/9 and 5/9 into 1 patch (Josef)
> * Merge v3's 7/9 and 9/9 into 1 patch
> 
> v2:
> https://lore.kernel.org/linux-fsdevel/20240821232241.3573997-1-joannelkoong@gmail.com/
> Changes from v2 -> v3:
> * Drop v2 9/9 (Miklos)
> * Split v2 8/9 into 2 patches (v3 8/9 and 9/9) to make review easier
> * Change error pattern usage (Miklos)
> 
> v1:
> https://lore.kernel.org/linux-fsdevel/20240819182417.504672-1-joannelkoong@gmail.com/
> Changes from v1 -> v2:
> * Added patches 2 and 4-9
> * Add commit message to patch 1 (Jingbo)

This is good, I've based my folio conversion patches ontop of this series as
well,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks for this,

Josef

