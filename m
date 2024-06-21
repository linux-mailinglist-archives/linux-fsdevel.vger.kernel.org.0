Return-Path: <linux-fsdevel+bounces-22152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E608912E23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6371C21566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3416C6BE;
	Fri, 21 Jun 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jzaRl8Wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8F156F3C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999684; cv=none; b=OYPeNkplQn8/ITuzrUjyOlD3FuFfOWonT9QJodt0xn6sPQawK/m8o2cQGd3oUk4PizAgP/WBfmOahqP9HUjmrnOnYEvG0UWg1Th7gU2zi3Pz/WYT558f1BvQsiTgmPqMfr1QYhBBfQbuA8yrUdH50ShDQUj2Gut0IrxyP8iZgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999684; c=relaxed/simple;
	bh=D3ymLZciavul1Y12MVNcx4+feyXXYgMZz6/03/D75sE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ujgM5q1ZaTI/tE1ahLlsxR8mHC1EwGv38yrW05jqBMqOepnJP9WBD7Y+5CMhpHMUBY8LdQz66dbe4tsIk7hpq66g1Af9MxkUwN5kGSCvt4AgWfuDBFEPeGjgSgloCF5JKQKULeCSeNqagITkcDwUTkJh8QKd8Yemk4pcbQiSFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jzaRl8Wr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so297433766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718999680; x=1719604480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33jEI5/feKxqme62YiuJFqZt4cfWs+d7SXX2h8CWrRk=;
        b=jzaRl8Wrd7mvryJbCn5CX40Pe8/BJSiffXlFf/g7a5vo6zGimnPkCFrVbzWbiI/E7a
         YlUxJANtONOZOzf3/CQ1jqKezaLfzNJQ7DVYxj1TdLEFFYrHUg/fdzPCg2kkuIwGRHm2
         HkgvHeAi9eNeL8mNml+8m/Tn4n5PankPDw+CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999680; x=1719604480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33jEI5/feKxqme62YiuJFqZt4cfWs+d7SXX2h8CWrRk=;
        b=UCgozBjy5QF0qu2ggZInteaTZEq5ECVvq4Rgcqx3XD+l5Sy64zMkeAN22ABuM4Y33/
         4JFt35fpk3IhwYWxAOxC2bZrL3Jy/DoCXKRa2cEazLPPgXbTFW7FzvOLNze/kpj6oDw8
         yNrT/suTQWRujipv2gNbRbYYy5DCUSG+UtuSuR9Tcx754DNAiiTRyOQSmsvk9HioFmit
         EL4bgW7va97pxouEq+RRzLVRJtuY5fJHHzbEikRLsfRGGelM2x8rjQKTu1xUhlPLEHB2
         K3y3kInyMAB1VPaW+Z62f4SK8nPxLZLgtt54t8KSHA36iBmush/chsW/Mjpz1QswXWHZ
         IBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbM0sZAv4PfzjLYFSs9MiF3oyn57h6aP9kGmdso/x+rz9r2lPBFVR86XU0lEIwcvMwpEGfxfQ4NcNxXxBy8R3eHBYvgh06pItBQdGs+A==
X-Gm-Message-State: AOJu0YyJbNDlqa3e4vVI4w8Hph6QtCfy/NcK5MwuZxSyllpkUFwyCvex
	iHxXXnXDBxM6YVMpSIlxEHbyvl+mxPET39Ap0lr6jUQ/oFVTAgv1aAsacQ+n4+dUBUIhwrXmgN4
	gCXgkcNLJ/d4xbOS3jTGX1dmaukqKpolYH7sAQA==
X-Google-Smtp-Source: AGHT+IHMPxRSpeWfFETILoj83QSpeXgYk8tMPeCiUlyNTt4XtvfyTrE0PqN0dcALyeXIod8bt3F7q/kAGJ/d13yodi8=
X-Received: by 2002:a17:906:7148:b0:a6f:6292:2425 with SMTP id
 a640c23a62f3a-a6fab648959mr496741166b.38.1718999679727; Fri, 21 Jun 2024
 12:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Jun 2024 21:54:28 +0200
Message-ID: <CAJfpegvm9M9Kzmtd=X66YijMOoJpKX62vuL4maD+7xBJ0-n5Zw@mail.gmail.com>
Subject: [GIT PULL] overlayfs fixes for 6.10-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-fixes-6.10-rc5

Fix two bugs, one originating in this cycle and one from 6.6.

Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: fix copy-up in tmpfile
      ovl: fix encoding fid for lower only root

---
 fs/overlayfs/dir.c    | 8 ++++----
 fs/overlayfs/export.c | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

