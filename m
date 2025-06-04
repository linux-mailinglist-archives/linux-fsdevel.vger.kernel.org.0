Return-Path: <linux-fsdevel+bounces-50574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF7ACD6CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEAC189A50A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A162620C3;
	Wed,  4 Jun 2025 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL7c+7E+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FA26157D;
	Wed,  4 Jun 2025 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010362; cv=none; b=KKlr2SxVIZA79lnTTOfWFlYBiOcCYJlMw05iHKdy/UHPLewyGdsCsPoTHk7xx7eXftucdvJsVD5TYHVV1wbFDQ17fFUHzs0copwa3MFRrF0AzVIHAhksciUNq281ee3sy2Z889hXczF7Ne24C5qqh9cnGn6gnDeBKFN4gHnpMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010362; c=relaxed/simple;
	bh=XJBDX8abIVoj/KwsT7XPYFxTbYo1NCn7Gv4xRGqv3HY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nDIq2Nr2UhirQIEzoBXRqD4n2HlaE8prqFGEdBF/kwJELQ0K44AlzSQ40fcSxvOG2XPiLK4Cxf82uwAZXhbzRZVI/yDMp6kMzZDTsl9hAGvnDrkchgjsNFjcCEWV7LGXts8FL2UUbZ+n7CtDdJ8TPpNiCjluw2iqLtoLrPO/FwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL7c+7E+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32a6083ef65so54026811fa.2;
        Tue, 03 Jun 2025 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749010358; x=1749615158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+kQgjVXHJUwwbUQHCqsK2/rVpeNa/I7am0vaIu0CXTI=;
        b=dL7c+7E+7/tZl7KguxhkKyYSYHjgIbG3y5FecnNfPCuX793l36AZUOAcu6foIMW1VP
         C5Bkji8eWBnyPtco3f7esdZCObT/7N/uE0/gtGSicpss4QBq6TEASCBlOsz/P3LOnNTZ
         K67JKc9uXUaX+OP/beRsxU0qgBqg3X+GlNvlyKbv9/b3DzRh6nUubY9nof78N2Kd/pbQ
         KqGFLEdRoufFXx42S/cuap1w3ncNNDDoCMqBm3m2tqtUnAsNJYzglrTCw7ThNFPZsR3E
         yfcFxElEnTlmn0YYTGrPswFUzeFhbf7TswHalNQOS8vOMyTw1C9+juqP+aHLsv4KN+k4
         v9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749010358; x=1749615158;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kQgjVXHJUwwbUQHCqsK2/rVpeNa/I7am0vaIu0CXTI=;
        b=HxbvJAgc27mR8LkoMt8Hybd3xPLozhWMFmp/olF9vTFqwC/u9GKJpMCoQPpn6ysVl0
         I3AEVkv2nXTDwSXE09xDnyJepNUMMg0BhsHLT32a8ogRIiBc2JBsBRGrE5W4nIoMcTA+
         dFzycps/g0AsNLfMqhiOB0cdOdGXqIAftIKfnuDY/pxjm8Zg9wrPctswKFQEUKUAj9vA
         BPB/SmV7MvTyyGT1PD+kimAfkY25yRFkx0nOYs9vXr7HftPOaCxItrwOdVeDeV4GWuJ3
         VlX55clywVulRQpaPMQ6R2Rgf2z+fPWiY+NZltB+BffFWynUFxG9CXTGwpxct9YPm+qE
         1fhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW8z1i18tcppeAIJNxYPvC914bbuh9mvRXcN5VMArBGLaCWLp6/Yt77aRkeB33Vspsfk72cZ9P0+5lja9u@vger.kernel.org, AJvYcCV5hitwwvngi0XPuROaC7bx2nqMWmZF53K5bR9TV6Xeg8B/a93k30i650LhcM00aZo1+g7OUJmHEhep6Ewj@vger.kernel.org
X-Gm-Message-State: AOJu0YxIU+2GSz9kPmh5rljK1oAEW/DSRyd/4T7umAbbkul9X219fBBj
	IFkMJB0+9cES+/Nk6UHywWcelG49u3mcBhK613Y0n5mlulbHqMx9j6UJCV+20IF44/VNUSUc+KL
	NpR8EozC4b+4iRpqm62NzSx7bfUQL6Glv7TKj
X-Gm-Gg: ASbGnctP5qoJEBXczT3Og4Z5iw1k3/MIXlu4OXnAQikaE9jZjqxFZOLLwTsowuRkNLE
	pA2QZA9sytt4e5hA+hhsZYLlbBuEb/lZlmW8NHftb80KoKEa7RNLJ2roBvHdCnMBXMGqq/u8ikw
	wdhf20fdqezsrnd36CB79/Yb7ep9O3Gl6mSwVCkEIcNqPlTw==
X-Google-Smtp-Source: AGHT+IFpB6PO6H1V4f8i5BfKNDWMuBnXkAgeoZtjEuN6vs4WW8M3cd1mBh08KM+1FSdwFcOzU8LBkhZFsTPk14jjlW4=
X-Received: by 2002:a2e:be10:0:b0:32a:7122:58cc with SMTP id
 38308e7fff4ca-32ac714b403mr3622851fa.6.1749010357933; Tue, 03 Jun 2025
 21:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:12:26 +0800
X-Gm-Features: AX0GCFtm5zCxySMuzwiYXm6zuWo6QPQsCyhWWibjConC-4547zeApVOrpr10avE
Message-ID: <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>
Subject: [BUG] task hung in fs_bdev_sync in linux v6.12
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.


Bug Location: fs_bdev_sync+0x2c/0x68 fs/super.c:1434

Bug Report: https://hastebin.com/share/pihohaniwi.bash

Entire Log: https://hastebin.com/share/orufevoquj.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

