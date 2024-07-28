Return-Path: <linux-fsdevel+bounces-24379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D993E8FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 21:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E94281638
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184A73451;
	Sun, 28 Jul 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJwmd+9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4E2AD29;
	Sun, 28 Jul 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722193769; cv=none; b=fmV1MLjVhUohdqhvy0YN8HwH6sLdKxlaClqdNBDx/H1K5GafLRZ/sHlrQneaCeQTt9IuyleZfaS3aGLHohDtdZBIoHWxNU4TGiqZKnJxZ3VN6R/RHaNKcBsZaExeHni/Ny2TX+5E8/q5RgwH5GVTfESq47sgNmuxzOGOwcgBTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722193769; c=relaxed/simple;
	bh=zT+SnmbtFeF/fvHrxsBtPteublxfAX+cKI1ux8yhDmM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=og6R10nPsK3ayzjOOVd/4ouUkrJ5ri218NgdSdYPUJy0IM1Z5qrVfIOHxHYjAV6vO4dWNR7VrPcfwHHUF3FSpd01P7BX3lCSeA5q97S2kuMkwJSmcU4LFLQSO4d4Ti7+wgNJIwb4ChB7V+NGXA5z4YOj7or5rGbKBhG5csqH9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJwmd+9U; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f04150796so4578968e87.3;
        Sun, 28 Jul 2024 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722193765; x=1722798565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z6vY6a+UKismis/SRDyc4ybX+UEQqHZsmxRFnBfXOXs=;
        b=AJwmd+9UiWyIWnN6bNLj0vETtUTDNOttBVgQujWaaxf5DjTeZi/3zKkCoCQBvt18tB
         h17ToVoZA9mERg62v6feH9S2jlIzmBhVJ6t5LBnTi8J1M4wNhe0sajSCSUCJAQItwyGn
         phBVuXvOuODj7ASB0gT0m6PF0a73zz1jR5aMykKnbahrGYp2Sj3vJlG9GgcPOL/OD2JQ
         NBeonf3E1PQUDsS+duZwIu7bwG/e56HrMjSyKf0D8oklDxUPCcuxKAWx9vl+rzGtQAYG
         OaBmjI85b49aZyICTPFAxn6hHI1qxhm1KzcNLCILc/prYldUgeMyRx3DtE0N1VvZQl7f
         68cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722193765; x=1722798565;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6vY6a+UKismis/SRDyc4ybX+UEQqHZsmxRFnBfXOXs=;
        b=GtCCEk57eaN7IV50p1mN2+wB2FbI95dSrMUC1gIPapY17yImQBEIGNr08s/TrCqIOw
         tmGzEoE13qG6/Wgu3OzloMLg1tuDCG43QHBzAPDJm8FFwK/e9fmKGaHudG8GEy9S6Jaz
         9smGR5xc+oIOYBQGIOtIbyhQDaaK9d2cPUbvVMUpgXRyau+E9OHIqLAfVPTS7DIF5HBG
         xgZveN/jZvpCFsMXiX7IM5lfr7bcV/toHOOQORRGSo7ClkL5QHFq/hv1Um8hLS5LXWY0
         9BAU/cI5XW9bpXmV+0UYVvHAxGehkIzBMTQRvjnCBlifHRPcRHe5jUlZsxbvkpXtQ7Wv
         CG+A==
X-Forwarded-Encrypted: i=1; AJvYcCUzqQOLDHftESciGr70ZvwT8RjdGNc5TmqivUky9Toy92XSkpguZUvnyY6proN0EqMqvqkue2FeZvrcriuQWcWDGn784MsZ9Ul4+g==
X-Gm-Message-State: AOJu0YxWd1OCYqFS6XK2Y0PW6ljUfgUehQdAZnSBucr8H99oRLpi8T0e
	iPPWxndLiziiBBnNPasu2VHwri/tXhTg4j8tY3Ruynx/oX6rTWDiK2RZ3guZvokizkuTSqH76fn
	53qKJKKrNMDPFQfTw0rhEzBnxyWiMb5Tg
X-Google-Smtp-Source: AGHT+IGixSuGf4VOHXLIMPxkM9HL+BeZhH5ZjPhG3tH9I3A5HsmUVZRkbDNAQyDAmnjQoZdztXrE1f7mpIOtPaJoBD4=
X-Received: by 2002:a19:2d5b:0:b0:52e:f367:709b with SMTP id
 2adb3069b0e04-5309b2c3056mr3133888e87.42.1722193765214; Sun, 28 Jul 2024
 12:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sun, 28 Jul 2024 14:09:14 -0500
Message-ID: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
Subject: Why do very few filesystems have umount helpers
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I noticed that nfs has a umount helper (/sbin/umount.nfs) as does hfs
(as does /sbin/umount.udisks2).  Any ideas why those are the only
three filesystems have them but other fs don't?

Since umount does not notify the filesystem on unmount until
references are closed (unless you do "umount --force") and therefore
the filesystem is only notified at kill_sb time, an easier approach to
fixing some of the problems where resources are kept around too long
(e.g. cached handles or directory entries etc. or references on the
mount are held) may be to add a mount helper which notifies the fs
(e.g. via fs specific ioctl) when umount has begun.   That may be an
easier solution that adding a VFS call to notify the fs when umount
begins.   As you can see from fs/namespace.c there is no mount
notification normally (only on "force" unmounts)

        /*
         * If we may have to abort operations to get out of this
         * mount, and they will themselves hold resources we must
         * allow the fs to do things. In the Unix tradition of
         * 'Gee thats tricky lets do it in userspace' the umount_begin
         * might fail to complete on the first run through as other tasks
         * must return, and the like. Thats for the mount program to worry
         * about for the moment.
         */

        if (flags & MNT_FORCE && sb->s_op->umount_begin) {
                sb->s_op->umount_begin(sb);
        }


Any thoughts on why those three fs are the only cases where there are
umount helpers? And why they added them?

I do notice umount failures (which can cause the subsequent mount to
fail) on some of our functional test runs e.g. generic/043 and
generic/044 often fail to Samba with

     QA output created by 043
    +umount: /mnt-local-xfstest/scratch: target is busy.
    +mount error(16): Device or resource busy

Ideas?


-- 
Thanks,

Steve

