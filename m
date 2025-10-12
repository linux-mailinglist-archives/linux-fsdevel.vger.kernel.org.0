Return-Path: <linux-fsdevel+bounces-63857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ABBBD0184
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 13:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CC1893C98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF725C816;
	Sun, 12 Oct 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAiUcBfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9A233D88
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268452; cv=none; b=lkEQqxNO8xaEGmnagEyZyIliaOpmSbFndg3pgy15vMOseXh8i4pHQlS7UdlQiIlWW5sI63rpqYpnG792xMgnWFH2m6q2JJ2EuFk+5Mh1Suq55ol7QJxvtmvatCE0xiZ98Bt2wetCy1H0NYSUnXsez4bzlsfJWj5oXEZ0zdNbj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268452; c=relaxed/simple;
	bh=mZuy+q7YShu9142s/CZ5ntCHum6xcITP08Ik5YtU3EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa+butlYGx+BsC9j9YzCNoMQPbQXK/fr7zq0Oe3cPClGq0D3FkizLSPhCIOgIibxSeCgoogup/JbakKVDIDtpgbIXy2ukl6fSj3pur6fHmzl+QAUqhjaslsBuPPAJFBqzPltlhH8gb1vVvG+rLoCQquaeGTUw8Ap9JPjBKlgIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAiUcBfK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e52279279so22910715e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760268449; x=1760873249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbO1RUDsAWDIoIlyeqIMdpVMOfB3YykkSikMqjPALEY=;
        b=JAiUcBfKHCjNHNHxPKuPRoze+SkzuzVTr0GrVRbTyJOgsAR+BKeeXlVHXkMj0Hhf7B
         eTfBPavylCLthPy1IUihmO1HTF9uc/rxw9mfaZJtrmOWmjQPK2toqqqM74ujqnt60Jox
         Cn/GltExyIDYcapZev9uEkvtV6YOEtzgRWcyNpdVyrUy3KcxUEYVuoL+C71TcpXSlWRu
         +n4yoQF7gKTqmAa6ZjKnqS3dOYJc6cyFAwkhR/1vKgtzX23hQ+Nnqjpt6WaZi7w0HBxY
         CF+nt7vgmJKHQaPhTHvhjaoUnQhGL72pky/FM+1HdQm8QKFSExNuknaAgSy14++BrAn6
         /99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760268449; x=1760873249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbO1RUDsAWDIoIlyeqIMdpVMOfB3YykkSikMqjPALEY=;
        b=I/IHNm3oQox5Jhpn6VIeLLPKydTzl7kQ6y4qrBDaSNR0ppJWilpz55P2zlSfd8Y2lr
         W8t4axryA5dR/edYnw6Go8vxLT53SUjJ21Ye7nELrVB0VVdcvtZbsyvoeFyZVu4i/rnf
         zGYiPMjBKdPq2vJbLob4o/gRHDH0f1XjI8lmGpiu9hL7M3B5XjVxKgaxHTjwua3iXMxV
         R1+l27J/xgbAk4wdFvKswn3NU4Fyz+z6zwdMqGX9CwSR1iLZ8IEb+ScnlEX+epgirt6N
         Zxt2WewMqtYkB3cJsjYaefSaBgYlOtXGCdtV2Urf4CY6sP8EGfFGrspBz2ls52UIDj2x
         xK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCULMq5NzzhIimERv1hn5R2dVQI1gZcHr4xzY5Vs13TDRMOEYo7VdXIOv039tEXzmCqJlfwbNPPQ00NF+tyD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40p9qJhUTVgdom8G8WKe4djjY9Ydpwy7vebybdOooivVmV5xF
	YXYvkkcMpeCKGPtdc8VYzx9/OEaCOIBeNwaWKo4EqTXwz/Kwke07eXEG
X-Gm-Gg: ASbGncsmq+e4V+4A/B8LXgRtpqHYsHRfs6sdmuhoCKv5Wgc/vRVle23pyxnSRR5vr2D
	EIxnelONtNrvkhVtHloXIXzrF8NvURKovjVO4ybTwUvxbeUinjRjRWW/642EaF9WZ5P75HABqXC
	PU0g/lR8SGPB68dE1BHFF4mMOP5DQM4ZQY6augiLoLWjosrz3BGDooUkExUhIV0qjWMENuJV3f8
	lWdzNeWEdpX7IAfl74MPduwPrW5pF7dSHdlhVjYNZHXtNEV3s4/5iQpyMafWAVm+66hpLfW29+T
	NJx42Y7wDFqI9s0m5I97rc1Zv1b1lXHcx/zIRjSOPrvv+4JX6RzOc5UGPpG4t0HInqRZ3uvfDAQ
	Fw2uRm7QM0XOQXXIr2lZoVNFGYU/ZQHe/W2FHxw==
X-Google-Smtp-Source: AGHT+IF3pdCvcLd+Zp4Lzx7x8u0sYsLUwD2VM6/35sHH+5UsbHJ5uw2Ut7l9mdO5uCF+kgctu6up4Q==
X-Received: by 2002:a05:600c:3b2a:b0:46e:3e63:9a8e with SMTP id 5b1f17b1804b1-46fa9b07717mr98919125e9.26.1760268448916;
        Sun, 12 Oct 2025 04:27:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb49c4027sm130749605e9.17.2025.10.12.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 04:27:27 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luca.boccassi@gmail.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	linux-man@vger.kernel.org,
	safinaskar@gmail.com
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
Date: Sun, 12 Oct 2025 14:27:21 +0300
Message-ID: <20251012112721.44974-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luca Boccassi <luca.boccassi@gmail.com>:
> IIRC Christian said this was working as intended? Just fsmount() to
> create a detached mount, and then try to apply it multiple times with
> multiple move_mount(), and the second and subsequent ones will fail
> with EINVAL

I just tested current mainline kernel (67029a49db6c).
And move_mount doesn't return EINVAL in this case (move_mount succeds).
This means that either EINVAL is not intended, either current mainline kernel
is buggy.

I tested this in Qemu in very minimal environment (rdinit=/bin/busybox sh).

See C source below.

-- 
Askar Safin

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/mount.h>

#define ASSERT(cond) if (!(cond)) { \
    fprintf (stderr, "%s: assertion failed\n", #cond); \
    exit (1); \
}

#define ASSERT_ERRNO(cond) if (!(cond)) { \
    fprintf (stderr, "%d: ", __LINE__); \
    perror (#cond); \
    exit (1); \
}

int
main (void)
{
    ASSERT_ERRNO (mkdir ("/a", 0777) == 0);
    ASSERT_ERRNO (mkdir ("/b", 0777) == 0);
    ASSERT_ERRNO (mkdir ("/c", 0777) == 0);
    {
        {
            int fsfd = fsopen ("tmpfs", 0);
            ASSERT_ERRNO (fsfd != -1);
            ASSERT_ERRNO (fsconfig (fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) == 0);
            {
                int mntfd = fsmount (fsfd, 0, 0);
                ASSERT_ERRNO (mntfd != -1);
                ASSERT_ERRNO (move_mount (mntfd, "", AT_FDCWD, "/a", MOVE_MOUNT_F_EMPTY_PATH) == 0);
                ASSERT_ERRNO (move_mount (mntfd, "", AT_FDCWD, "/b", MOVE_MOUNT_F_EMPTY_PATH) == 0);
                ASSERT_ERRNO (move_mount (mntfd, "", AT_FDCWD, "/c", MOVE_MOUNT_F_EMPTY_PATH) == 0);
                ASSERT_ERRNO (close (mntfd) == 0);
            }
            ASSERT_ERRNO (close (fsfd) == 0);
        }
        ASSERT_ERRNO (umount ("/c") == 0);
    }
}

