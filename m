Return-Path: <linux-fsdevel+bounces-47128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68854A9990A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947117A4E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427D257AD4;
	Wed, 23 Apr 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ts2gYgC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BD1FC10E
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438307; cv=none; b=JNK5hpcqSFN6ggDkZfwiWf49tahHWPdqqtAFs0bLjajF+YIj6PylX2y0b6yHueTz3EGoDQ+Zi5qvVkAeJLz0cCsg6GG+qwb7f5oW0+1hbvBs09igyNAbnAk5DlNMAo7RzRSOl0dMN2ADfQSmTd8de2G0eQkxUj5aIYU+ChVPGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438307; c=relaxed/simple;
	bh=sABJ0zDjI+HdAYjK6q+W6i4zhTPiFN5NjWMMBT+eTh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mF7t6IB+0Q9Qx2PaH96/31yGdSTMuHawkqjjl5x4yALEVGV588Q8zzCsoK5vDkiMRMAbjXRFB+clpFrJfMwT9MjxXs3SZkCkIcGIA1QLnIWUsHSSZ3cYoe7GuxFad+M4cCBGjo4p/Lm/kt2XIeIrqh1mryCulBKvuj4O6gVsbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ts2gYgC7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d5e68418b5so2156185ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745438304; x=1746043104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j5LjmU56b5qAgJCmFZDj31NsIm7pWmTfna1PU4IFm8=;
        b=Ts2gYgC7nfnC0WsxXQFgF6BZ9YN9hd1ccmdVEi6RTerUyu8PFoWyG7nhKy7a9AsYNp
         6bf1rHf8xvdODrEoF/3aJiUzgficfHfx9sUGCkOhXlPoFmRk2BFG1Er3fzERcJ2CuaAc
         hJePFjC9sqTqLcOU8xGH6ZZ6X0EPUXxIpn17FwPdolr/bqu+prehcfn5iEUquq0HW/Ou
         9pU3hcG1oX85Agg6VoU1+Xh3cAtjmRE0z2aK/+2Zu3Fp3sgbNh7rTSoCCmfpxuLvKwCf
         f4WcVmbeV8cgiImtCWFvQGn1pmAfKvOujlInYK5+Lf0XDA4AiW5JQ17UqJSFASXYUh2U
         g/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745438304; x=1746043104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j5LjmU56b5qAgJCmFZDj31NsIm7pWmTfna1PU4IFm8=;
        b=o90oyZmpxyk3OXGtO+hYxft5eLWMaFHMl7pfGkhczNrH/nAyD0pE85C9jCGmNFKyxw
         MMQgY+WsUoUFPMqVHj5TEJbtCKabag2ae+jp6OfqwZljviN2kIvx4oImwt7O47DBLV64
         xQr/L5HNptMLJ59KAAfcKByx8TFOyOM50YEZe1Z4GCOr6b6TgO50aO+IoRt1LWdAWzbL
         DOjsxlPXlXe3hJcc4IduZf/msjWadMZDbWxeAHr5815FKeN7gsdYeBJQu2v61i/hcGYz
         wOPSX1XbQkx4n+8xIB7XzbMsAUwOeUIXr4Hs6X+FKFkwovoVe69gHb0fPSEA+dvXab0Z
         Vc5g==
X-Forwarded-Encrypted: i=1; AJvYcCW9k35zf82XRvQ91zCEL9sUAW4z6EOriJrMuEUWv+r85NoSo6CySb4QiX1Fz6S9/UCnRQZmYBqmRFsbgR2S@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0SNYU0X251xmcZT9tvX4VQs+TDABaZsJKw7kRR8ttxj5TWMe
	Zr0UfLmvqMyPNTE24NqptovUhRKvDLTEjJPLS2cl7xXc79GVXvCNx3SmUQzPZm10f6gDjVkcQxF
	W
X-Gm-Gg: ASbGnctcgYEfvoCiBD5itoEzVlEEENErjlxERyhvcgqGik2Gs7kQjIpZiDaK9BWwb8j
	1l0202FFyq2e7GKzPvBiGe0QDxr8ziUhfUAPP6O9lWdfSxJvdPFZtHGJmtvtnSTOeWlJ8lxzUsA
	Q+ARMEO4jGc2RqCJxXgbahWGK2weIislo1jsl86kndTUKwy05loVQQFmp2bl7O/3mDxs/Wh5FuM
	lke75eb3W0Edx41WcmpsKZA96dj89vhnWFhCg3iePb/x8VllVxAN556ddO475Y2+4/9azHGlJ2/
	6HaqHVeq3duiWpq8RI5F7JAQQUAVdtE=
X-Google-Smtp-Source: AGHT+IEMJ0bRGRXiRlKdRhkAgWX19pwillKCdqIlVb4cy4gK+d8U2A8s+2kwKh/p2ao3kPhQzF0MkQ==
X-Received: by 2002:a05:6e02:b21:b0:3d3:d823:5402 with SMTP id e9e14a558f8ab-3d92ea8af22mr11668365ab.7.1745438304290;
        Wed, 23 Apr 2025 12:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a39335casm2960256173.84.2025.04.23.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:58:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: cem@kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, mcgrof@kernel.org, shinichiro.kawasaki@wdc.com, 
 hch@infradead.org, willy@infradead.org, linux-xfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
 linux-block@vger.kernel.org, mcgrof@kernel.org
In-Reply-To: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
References: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
Subject: Re: (subset) [PATCHSET V4] block/xfs: bdev page cache bug fixes
 for 6.15
Message-Id: <174543830334.539678.13336981984894472656.b4-ty@kernel.dk>
Date: Wed, 23 Apr 2025 13:58:23 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 23 Apr 2025 12:53:36 -0700, Darrick J. Wong wrote:
> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> between set_blocksize and block device pagecache manipulation; the rest
> removes XFS' usage of set_blocksize since it's unnecessary.  I think this
> is ready for merging now.
> 
> v1: clean up into something reviewable
> v2: split block and xfs patches, add reviews
> v3: rebase to 6.15-rc3, no other dependencies
> v4: add more tags
> 
> [...]

Applied, thanks!

[1/3] block: fix race between set_blocksize and read paths
      commit: c0e473a0d226479e8e925d5ba93f751d8df628e9
[2/3] block: hoist block size validation code to a separate function
      commit: e03463d247ddac66e71143468373df3d74a3a6bd

Best regards,
-- 
Jens Axboe




