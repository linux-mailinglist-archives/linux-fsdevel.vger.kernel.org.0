Return-Path: <linux-fsdevel+bounces-30152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF42987031
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB54B2677C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E51AC897;
	Thu, 26 Sep 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="okCdTKbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770021AD3EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343018; cv=none; b=D66lBriuvMAZd9RW9dNCa3mfMMaitmYfXmnOqWMWceFfrr979IiTuI3EMmCouHw9UJi+At7YJV9LvWdAMrr6j9jhGx85rBHJQj04gu0IoSnR8wBxXhr9wjVezji4J7cikrZ5QKabeP63mmtfcQuqVf1RURSxajSB2FdM36jWpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343018; c=relaxed/simple;
	bh=lWks5AbQTns8xoGiXZ8iHqB6GWZbAzaW22hmp0qMM1A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bSBEVkWeqYuxX9lu/m2RYpCucs+9A+bx4A0RtA1RSv+mMUeQZsWOn2hj87xHIptyvLC2bKNUCqnWen/xx0S4IDIlH6x4p2vIKstfcAltYY/Ro55gchOIhGgcu3KZdbhQfx9Gg2LFrHh32aa9niqmVdjvEMCFtEm4DXkAWDXN50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=okCdTKbs; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e24985919c8so757366276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727343014; x=1727947814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nyou1ZAVx0ZVf3uAAhgzuQpfNnp1ypcAHepL1cHliPw=;
        b=okCdTKbsssR7ExI/x/HmagjSB5zmxqzJOXJedlE3VljDFi36P3V5CN7wpOS0Ia2YHP
         4/PBBIuOPhHxVlbNtRrrBU5BViT6GCfIOZxTnRlEN0oY0aGyGEcWhwRrFp2fC7Y9d56z
         KVX8r7cx9qnPH7UV3+v5cf1HHA1V9MRiT96rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343014; x=1727947814;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nyou1ZAVx0ZVf3uAAhgzuQpfNnp1ypcAHepL1cHliPw=;
        b=tLaUq/4Z67+LfYh/ckXpPih+tYQzUcGL/7x8hY01pVF65RJzs7iOG3IRsaeM+xXT3I
         lxOJn5x65PWdbsvVQ0I+An/apdlW4L67zIRQnRlTypAqWA8mUkbdH1/nJldbSpDpizMI
         eoEubVjNksesL63+c5Rwf4GsMROLNXbfxoB2OUg4C6vAv9FgYxSS9QLkke9XurI3oJQV
         RgXG8msr/UAiXw4szMd4NxbdMBrFcxwFDWTtLjjBsevB1/MYZAFhrjAuhHRTnGAtK4bU
         TNW2Hl8l6yD3Zxd99bqd0O2jjClWC0XCA/YHqvdDHu5XeVZqPaY9Wyy/xSz+Xxmj6wNi
         vvtw==
X-Gm-Message-State: AOJu0YwStYF1Hgg70Ubv9U+rrNFOc76LNSGJzOudljBHYZnXqzAhTK8C
	L3j6f9xlAqQypFwKLVyUztq2bH+7gON4g+3tFFqbawJEj+y0l7R+9Ky0c+2lmj5Bhc1ym6onoMA
	oPRRIzOaw6/ZqPFmqjy8raqs1KF7khckUIlhayw==
X-Google-Smtp-Source: AGHT+IGhuzRle/WPEaylBIBRgs3i3y0CTD7aZdyFKJV2gyylLm3duCKIFwZ9vzBJn4SGSSmKfzfaTJx3l1QK4Obdpco=
X-Received: by 2002:a05:6902:2b88:b0:e20:2232:aab6 with SMTP id
 3f1490d57ef6-e24d7debcc2mr3949475276.7.1727343014145; Thu, 26 Sep 2024
 02:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Sep 2024 11:30:02 +0200
Message-ID: <CAJfpegsmxdUwKWqeofn9-DYvqmPWafwxQfy4nLgfvosvhXfjOA@mail.gmail.com>
Subject: optimizing backing file setup
To: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Jakob Blomer <jakob.blomer@cern.ch>, Jann Horn <jannh@google.com>, 
	Laura Promberger <laura.promberger@cern.ch>, Valentin Volkl <valentin.volkl@cern.ch>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm following up on this item mentioned by the CernVM-FS developers.

The concern with the current passthrough interface is that for small
files it may add more overhead than it eliminates.

My suggestion was to simply not use passthrough for small files, but
maybe this deserves a little more thought.

The current interface from the fuse server's point of view is:

  backing_fd = open(backing_path, flags);
  struct fuse_backing_map map = { .fd = backing_fd };
  backing_id  = ioctl(devfd, FUSE_DEV_IOC_BACKING_OPEN, &map);

  struct fuse_open_out outarg;
  outarg.open_flags |= FOPEN_PASSTHROUGH;
  outarg.backing_id = backing_id;
[...]
  ioctl(devfd, FUSE_DEV_IOC_BACKING_CLOSE, &backing_id);

The question is: can we somehow eliminate the ioctl syscalls.  Amir's
original patch optimized away the FUSE_DEV_IOC_BACKING_CLOSE by
transferring the reference to the open file.  IIRC this was dropped to
simplify the interface, but I don't see any issues with optionally
adding this back.

The FUSE_DEV_IOC_BACKING_OPEN could also be eliminated when using the
io_uring interface, since that doesn't have the issue that Jann
described (privileged process being tricked to send one of its file
descriptors to fuse with a write(2):
https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/)

AFAICS it's not enough to restrict the backing fd to be an O_PATH or
O_RDONLY fd.  That would likely limit the attack but it might still
allow the attacker to gain access to an otherwise inaccessible file
(e.g. file is readable but containing directory is not).

Thanks,
Miklos

