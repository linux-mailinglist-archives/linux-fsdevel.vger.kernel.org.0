Return-Path: <linux-fsdevel+bounces-9856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EB84555B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731C21C2406F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455515B961;
	Thu,  1 Feb 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpXtck/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322244DA06
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783433; cv=none; b=WrWCkqLzrSwnDAcYDa5s/pUpyor82thBhK3irpVtWlz94MwbuVgVPSMaZquUdTqguoVen3Pzdx4Oe8Iy0M7/ntlUdwF3GqTlXIcH42KyaCMAOpXiQH/caSIsnUEcJ4fMfeDMG8DRgC/HDdQv4VtHpYE5ytAWSgQ6x5GoC5pfLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783433; c=relaxed/simple;
	bh=s0+1Lc+SDqINIcddYDVfB5HrppfGTp9XJkMyG4k5SpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgWcRb+KK9+t1Zu2OsjKrOkX/NAi3lPI7Zy2AJGPfrjs58BRxzHgYMjfCzzIQybixDLq+CrX3EAswcVPkB5eZab25ThW6AHh1xqROisXA+/DwmfmhWSx4fsrmZkzoEsMxQb0J0ZIADlTd9Vh4Gs2Lh4jyc5NMXGKNgcdBCJZgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpXtck/e; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78405c9a152so55618985a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706783431; x=1707388231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0+1Lc+SDqINIcddYDVfB5HrppfGTp9XJkMyG4k5SpQ=;
        b=gpXtck/eWHV0P6Os3jF/C/ZcXfuyqORZcTSdJoLFf95AERa5CUODoFr3A2Yfo0o5gV
         2Ncl6UFhcWvHab4DrN8v/Kf1XuIwM/Ob9jkrOL+KA06vPJUZCBshpumpZhiKdmPvI7Ev
         3/YQzoRl8cXu2btuosXEW0MWj6+n4vtZFkPJIKRfff2lRSkOOH0AX1smt82UZM5Dl3Cs
         Q/MnMUX2v42g8xSZ2nahMR/6XiEk+T45h1a8BG8KF3xRx7KUSK47LAZqqdH+NseBMiIM
         bolb0VYRQqSnH1Ti7kSBPhSxQfuNnJFDwphQnYywiD4CDEGiO6Nv7J6xUjamGC525Csm
         ydgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706783431; x=1707388231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0+1Lc+SDqINIcddYDVfB5HrppfGTp9XJkMyG4k5SpQ=;
        b=uNSonnI5zrGiYTM/KVf4UmMtW9GuLO6W/QDBjYBF13On2U6P14cXjPT3IGg8QDyYgP
         6jaErWUWOolWFQawCqU3awhcpUGidUtbR5UUyUIY3jjIFfIRqxZURB586xTxwJz64EnH
         y9IdAybez5I5znsn4VKRr0bGfxKmMCyFZERsF8oJsyG7qiH9MGnJf0B913tQiKUIeN81
         kZNVLvWgRf6PfKI4htgyvBkSRjEB9nCkpvk1ytl2mbwd3s2OVk68VgkrPJ5dROmlqpUG
         Bc8MXu34ulUO0XQSHqd8J/GpEJEGmcMYCafCWvpAryaUBVMVV1YtVJACuHlb9M7trN2I
         flXA==
X-Gm-Message-State: AOJu0Yz4rIukjI33lcAvoh8JGRiWFN5W4rja4mBhQKAZNCau669rHktf
	DIwXopbhCdbf/fVKFrTwo0QUh1oplnWLyv7yqNj7Halj3ZCvAPY8EEcJu/9m9lfrylSnWleuJnX
	3eej9i+3VFD9VaR0AyUPPUXwCqxpHBLzgFHI=
X-Google-Smtp-Source: AGHT+IF2rONY3e0TTmCkHU5bri4vv7SWeybRODfCZHC+JcdRnt0MS00F7Sb5hO6RLlJ1LjAqhwg5ar8a/xgzfuLtc0o=
X-Received: by 2002:a05:6214:29ed:b0:68c:71d7:2926 with SMTP id
 jv13-20020a05621429ed00b0068c71d72926mr3581265qvb.50.1706783430981; Thu, 01
 Feb 2024 02:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com>
In-Reply-To: <20240131230827.207552-1-bschubert@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 12:30:19 +0200
Message-ID: <CAOQ4uxi_SqKq_sdaL1nFgjqonh2_b910XOgMbzeY4aP1tj-qGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fuse: inode IO modes and mmap
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, dsingh@ddn.com, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:08=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> This series is mostly about mmap, direct-IO and inode IO modes.
> (new in this series is FOPEN_CACHE_IO).
> It brings back the shared lock for FOPEN_DIRECT_IO when
> FUSE_DIRECT_IO_ALLOW_MMAP is set and is also preparation
> work for Amirs work on fuse-passthrough and also for

For the interested:
https://github.com/amir73il/linux/commits/fuse-backing-fd-010224/

Bernd,

Can you push this series to your v2 branch so that I can rebase
my branch on top of it?

> shared lock O_DIRECT and direct-IO code consolidation I have
> patches for.
>
> Patch 1/5 was already posted before
> https://patchwork.kernel.org/project/linux-fsdevel/patch/20231213150703.6=
262-1-bschubert@ddn.com/
> but is included here again, as especially patch 5/5 has a
> dependency on it. Amir has also spotted a typo in the commit message
> of the initial patch, which is corrected here.
>
> Patches 2/5 and 3/5 add helper functions, which are needed by the
> main patch (5/5) in this series and are be also needed by another
> fuse direct-IO series. That series needs the helper functions in
> fuse_cache_write_iter, thus, these new helpers are above that
> function.
>
> Patch 4/5 allows to fail fuse_finish_open and is a preparation
> to handle conflicting IO modes from the server side and will also be
> needed for fuse passthrough.
>
> Patch 5/5 is the main patch in the series, which adds inode
> IO modes, which is needed to re-enable shared DIO writes locks
> when FUSE_DIRECT_IO_ALLOW_MMAP is set. Furthermore, these IO modes
> are also needed by Amirs WIP fuse passthrough work.
>
> The conflict of FUSE_DIRECT_IO_ALLOW_MMAP and
> FOPEN_PARALLEL_DIRECT_WRITES was detected by xfstest generic/095.
> This patch series was tested by running a loop of that test
> and also by multiple runs of the complete xfstest suite.
> For testing with libfuse a version is needed that includes this
> pull request
> https://github.com/libfuse/libfuse/pull/870

Heh, this is already merged :)

For the record, I understand that you ran this test with passthrough_hp.
In which configurations --direct-io? --nocache? only default?

Thanks for pushing this through!

Amir.

