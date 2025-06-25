Return-Path: <linux-fsdevel+bounces-52928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC589AE8884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EFA6819D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA932BCF4A;
	Wed, 25 Jun 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z50hfS5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF2289361;
	Wed, 25 Jun 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866305; cv=none; b=Lf4uwm84k7bldU9sx8H2GZ3RJnhG/QFdsNzFsx+1kFEn3Jm9wp7+LIV/yGZxDRxo8pCBmagbwGQ48eyF0IBNTQCJgopHm1n2xtcM4ciXGQrac86UbqNWgI5izGAdc0S70y5NJ85P2ehQBize2/8KF3qOLnOCs4iAWaAHNlJS11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866305; c=relaxed/simple;
	bh=hW/6m1/IVovvjQyrM0zoK+5rKyQCDSNy64NWdJi1Z+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNcU5RByRR5XpT4StYkJSv+FQ+5pwNDjrc6WuLyM0VPh65EkD/LynJdxmrxxeMdYpvxld0XllNOim9z2lpkF9lr34OpIfmBB9XueHNOf73rZgCGj1GkxqNKp499y/tKDPlx5KsEpfwv4oEjawQppMrdc+0RKFJCOj/gTqc80SRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z50hfS5E; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade30256175so7455566b.1;
        Wed, 25 Jun 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750866302; x=1751471102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iocf3xZEV33qVQt+76WbLL52e+K++YTQHmhfnQovIf0=;
        b=Z50hfS5EdRCkDDmY6czmPHgN84U7Fe49vVJPF5/UT/q/6fIhfVxSTTO9oRF7EvCCXR
         Oq7qv8Hm7VD1a0bJvWneguDXPJBJLsc1Hkzo1tsnAK3qsOzDWFsmjHU/3pP8254VamPS
         GjcJGI1/Ed8rjLasdv5JuDYUIX3prd1tq6I8xiSuJ1fOiSkby21iHnwPqIdzZ14n/ivp
         IDNuHbzQ8lUmsL4+Xe+7+Ti9RpCuLl1xBZwoiNKayAXGSsMfGh8D6IpabhNywCc21VAp
         bIxqN5435Bw0XW/g1pfW2rPiJVXyhJJQvJFAzuB4fLJp9q4xBtX+rqTUOSFJhxPOuzUc
         W1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866302; x=1751471102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iocf3xZEV33qVQt+76WbLL52e+K++YTQHmhfnQovIf0=;
        b=cuTnHdIzS0CRUNTvtOaNlPwT8d/O2odlxr61MdWKmU2d3rbwLqiyC0vgvvdZiNPqPY
         z4EyIPPNUJ2zNdaFeT0qsQuvCY1R1XuI0GiImuO8oElWcq+Gg1mOemkjjpPk4I/Da19M
         MVlEZranrIPa0HeCl6KBOIFEiGdfEA+/oE4+ZSrGHmeNEc5mxKt7Zw2NQMhiBkBiA2iL
         jMEUxBFiRP3c1p3Z4GuAbL3Y6sx1zBvfGbIBIk9QafWZ6BjLWbEfEYwGoXDDF89LEhRv
         q530dxMkdZ913nyoL6ulRn7kti1DcaduwNufBdXXoBA5bIJHTQ5vJXkGHliDx5OB00lq
         CjNg==
X-Forwarded-Encrypted: i=1; AJvYcCUcmYCXD8o9s9O1saykXzSP1uuwEI7G7ZZ1Jm5zfaX8GZTuypUG7PX7B86xTsi9DBAYqEmAw2IvTG2G@vger.kernel.org, AJvYcCWPLzO9HN8i7/ndH3/TBDI3ATkZMTl0+EFd0yOUJHn3PCLlVGFuOY/zxrwvsTiO6inTocUzrkDHzr2KeW0j@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/Nv0utSAukSEiKn4020f1XCng/0J09XEECxwSliw/tdPNYPF
	2KzfUgLzhBaKCMk4awWoyyEsgb0IuKWhygYfajRRnzoC1ylH+ShIYuxnULFKOSUc1lNrlMI06aJ
	8t62HlnGRBglAdLiyybqE0kdgsgc911I=
X-Gm-Gg: ASbGnctO3ehi/VU79PHYvKhepIr4vckEV3uUiXCrmdaxezgYVHb0WSW5bnIBRi2bg61
	jI47Cq40jFP31JAb0/kA4eE9Fjr+GCf6CWmh2y03LykW6QGKN49eU6MsRhk4R3Y+q2Q8kdBPIJB
	iLOYr/AB3tvo0nthTey4rjod+zswUbkuM0C5focPlmMVB1
X-Google-Smtp-Source: AGHT+IFs+V/EDFHaGKcJwU9/xkWCRRHAYQqa7LBSGKtKl48ykcDE4Nb840e4+FWhpIDCiq8jKWE842faRWDZOh7ThxM=
X-Received: by 2002:a17:907:97cd:b0:ad8:8529:4f9b with SMTP id
 a640c23a62f3a-ae0bed82d81mr354973966b.38.1750866301696; Wed, 25 Jun 2025
 08:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
In-Reply-To: <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 25 Jun 2025 21:14:51 +0530
X-Gm-Features: Ac12FXz-WfD7KDK7gS4t-j71iOt-puRRwIJfu8WaOkNNWXA_hJ1q0mugrvCoDS0
Message-ID: <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, willy@infradead.org, 
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com, amir73il@gmail.com, 
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com, djwong@kernel.org, 
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"

>
> Makes sense.  It would be good to test this on a non-SMP machine, if
> you can find one ;)
>

Tested with kernel cmdline with maxcpus=1. The parallel writeback falls
back to 1 thread behavior, showing nochange in BW.

  - On PMEM:
    Base XFS        : 70.7 MiB/s
    Parallel Writeback XFS    : 70.5 MiB/s
    Base EXT4        : 137 MiB/s
    Parallel Writeback EXT4    : 138 MiB/s

  - On NVMe:
    Base XFS        : 45.2 MiB/s
    Parallel Writeback XFS    : 44.5 MiB/s
    Base EXT4        : 81.2 MiB/s
    Parallel Writeback EXT4    : 80.1 MiB/s

>
> Please test the performance on spinning disks, and with more filesystems?
>

On a spinning disk, random IO bandwidth remains unchanged, while sequential
IO performance declines. However, setting nr_wb_ctx = 1 via configurable
writeback(planned in next version) eliminates the decline.

echo 1 > /sys/class/bdi/8:16/nwritebacks

We can fetch the device queue's rotational property and allocate BDI with
nr_wb_ctx = 1 for rotational disks. Hope this is a viable solution for
spinning disks?

  - Random IO
    Base XFS        : 22.6 MiB/s
    Parallel Writeback XFS    : 22.9 MiB/s
    Base EXT4        : 22.5 MiB/s
    Parallel Writeback EXT4    : 20.9 MiB/s

  - Sequential IO
    Base XFS        : 156 MiB/s
    Parallel Writeback XFS    : 133 MiB/s (-14.7%)
    Base EXT4        : 147 MiB/s
    Parallel Writeback EXT4    : 124 MiB/s (-15.6%)

-Kundan

