Return-Path: <linux-fsdevel+bounces-61255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F61B56954
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD017D90D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A518FDBE;
	Sun, 14 Sep 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKFwQaXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEE27713
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856613; cv=none; b=SjgIvfI+dBWYd4QPsdkhLzTPmmexZnaWJJfWC6nhEOVS+08c8KUylzsJtWwh6FrUlxkifG5XCALVsDabfR0a31gZwye8lOCEhXMVN88WEhDbIR477Oj/+ybdyMihvedlPZ2IQfNrwsIe8xu3X3J8I+qS6mhA0E7WHFZ2dZYJZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856613; c=relaxed/simple;
	bh=sdfxBxt4mURTAIPeCtfkcBrYZDH9reEz+rlyUwKcLO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur8gSA0M2Zq17HSa5ZbJI8XBvHgF420bgdGrxFIGTeJF8IoHhQbUTTd5ztVkmko8Xg3qNKyTKGvCZhltRTtYSk9ei3I+TgDEboL86mebvGo4VOd/wsPkRfjx538wfoQJtopkgJUPZE2TJArmYHhNH9Hd8v5jDQ+pHwRUGnRi2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKFwQaXj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32de2f8562aso2622004a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856611; x=1758461411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v/bwFXPYi1A/E+v0RDwAlOzUIE6ZiAt0F/hgL23dj4=;
        b=gKFwQaXjyaB0t8kuU+1qI3ECYcC7aui8imTZEfEWOe+i4YJVvGhXsfFfJyjUDikCq6
         l6Mzp+i5U4E8Wwj+wvX8+70LywCCAogjUMfirklvvHA0mOm28TYPewvmayuGSxdOaf/r
         4IeYX/FzX/CrCA1cmu2toaDzI28szBbOaVjAEHJL7BEyADHG5F2RYW8+xdFpArbAbEoS
         YFu/7RobKHy8xitduqC3ZIGjtFRVVsUHhjW5Vy8mr3XTBdPkLTwjEvaFJki2POpSrO0i
         B3470g+P8GIyHYzvdzdmqMLinCSPTtJjGdbqQaN6mRJSTFg5NgMrc78jebFMWeazzvZ3
         OPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856611; x=1758461411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v/bwFXPYi1A/E+v0RDwAlOzUIE6ZiAt0F/hgL23dj4=;
        b=idLL6LEh7IG6gdRqAjhOBUbXAvmZ8R34tkH8rm5aNNSpQRc9xgDty7s7CFE8uRh2+F
         HD5etwX64vJmWzdQ6GuYS2EIauRfObEIIsj7fPN15ucztD+rV029m0JGK2RhkFWBNwBq
         F/WUJIxl3ozGiA5IPLIoZ/tmYrlxLyHvqcwnGviwv6Y3AsrP9Tka/PVPewnn0tvLNMPY
         dHatWAckhnDIA84Xo1EwpZTtB5wpriCMxeZ3x10to5AJyorUu6JWDTJFAYe+cr5Rrc/X
         /O0w3ZZ+MjKDfUA1WhirI6Fc2/qQSNz1OVt9omQx5HXzkx5p4D7nyyb+kWZcTZ0rsTFO
         8j+w==
X-Forwarded-Encrypted: i=1; AJvYcCViVrU5Jtj53QX+MGBiUHUVf8UF9WcdgceEqoaHdVfkBBr5R25QmNjMv3DLULJ5yElFTFOE6TN1tMk+wOdW@vger.kernel.org
X-Gm-Message-State: AOJu0YzjB+iV4ojd10ntZrby2hZsVldar+Xgi2PmUYR/cVMvCEIL7r5P
	C16SxSzxSvsHGc/N0gc4sQEvRqANrsv3GkP84qXmuOp6RNh1/LjjUpKrC4q2RzIT
X-Gm-Gg: ASbGncsm+ohFkKumfpzt01nncQGJaDNerqug5E8VoqXh1A6JJqHUhzWrOHk2s6GqXrC
	mwrA7TE/j2HlCiQKvu/YBToYSIq4vxiAY6MkYITk8BygII/i9hFtKuUYO2qpQo5OlXAr0nEmQDJ
	Krlb1hkdd3B4RJ/qrtjSVeq8fZyr3ieO7Q3bGFPPWaj1aP0F/H9Cdlr9k53Lpshg66JxNnVxIMn
	HX8uq4vYrVOS5fF165jiqmZsKlheWRjGqw2YPRFgHfbkGHBJkRO3Ftw5BKLwqBnv+0wczRUj33r
	XZyPzKquF7J0DOgw6PVHS0zI4gzhLhUjnj7DBYAa5paF/DtMz5Vpcje20qPMddmOIG/IYuS6sbu
	AhHNupCEezV0oEevUEiTu9lsVnIPrehrS4ZLlwPsXrFO8
X-Google-Smtp-Source: AGHT+IF1KcNJt3UWmfwSpwE/UpWBqDtmNxg4KMzYyF8MLuCAmlCdngCBSBEjT/SyGByGhBx68l8iVA==
X-Received: by 2002:a17:90a:e184:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-32de4fb254emr11960351a91.37.1757856610930;
        Sun, 14 Sep 2025 06:30:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c78b5sm9622382a12.21.2025.09.14.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:30:09 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: kernel@pankajraghav.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v4 0/4] allow partial folio write with iomap_folio_state
Date: Sun, 14 Sep 2025 21:30:07 +0800
Message-ID: <20250914133007.3618448-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <mbs6h3gfntcyuumccrrup3ifb2dzmpsikvccu7ovrnsebuammy@if4p7zbtvees>
References: <mbs6h3gfntcyuumccrrup3ifb2dzmpsikvccu7ovrnsebuammy@if4p7zbtvees>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 13:40:30 +0200, kernel@pankajraghav.com wrote:
> On Sat, Sep 14, 2025 at 11:37:14AM +0800, alexjlzheng@gmail.com wrote:
> > This patchset has been tested by xfstests' generic and xfs group, and
> > there's no new failed cases compared to the lastest upstream version kernel.
> 
> Do you know if there is a specific test from generic/ or xfs/ in
> xfstests that is testing this path?

It seems not. But there is a chance that the existing buffer write will hit.

thanks,
Jinliang Zheng. :)

> 
> As this is slightly changing the behaviour of a partial write, it would
> be nice to either add a test or highlight which test is hitting this
> path in the cover letter.
> 
> --
> Pankaj

