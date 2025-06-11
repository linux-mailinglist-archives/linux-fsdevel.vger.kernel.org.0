Return-Path: <linux-fsdevel+bounces-51219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C591AD4901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 04:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0A57A3D32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 02:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE822541B;
	Wed, 11 Jun 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FraPMRfa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03FEAC6;
	Wed, 11 Jun 2025 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610653; cv=none; b=hCrpymwyraJ1oYFrOn/YduIA5UJC8jHfb97v7eFtwq73DDkHXy/bQz9RE/bDsQo3bz4CllWGkYRvi3McU3si30zLmux5z1WBIFgaW7CUi6pjYmlNu0C0HDxqLKqUff3TjteNXmzLMshrs694J5I2rU5EpZbSfYvh9IjJ+woJAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610653; c=relaxed/simple;
	bh=ftbRrev081YY708k/2HkfTQQMsecdpEbMiB+x4kF9Ec=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EAwdSv1SEwXkR5T3tjxHbShDXb7EdfZmKNKIq8BSHgoTf3F2TmbKL0mZd9SJjbJqm+mpgR9p4Q+KaZAm3wtnrkv/ZwbdgPqUB8Q1padkc0R9+vr1nQkvO52ItDluwdRKH+ochaLabRWedsCh95ij7yFyuFu2opsSWCN7NDTMLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FraPMRfa; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3292aad800aso4792341fa.0;
        Tue, 10 Jun 2025 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749610650; x=1750215450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k5/dKPGbzIpZPRhOJIYAIUAY23sahY1p0GkM5Dbi828=;
        b=FraPMRfasMRsKi8S6wGwXMAlrzUCHdzRWYHzkki/JEbvAhwzAiYAaPqijhz8nLLr6Z
         nW5bOp8p4PM/OlR8yYK9OHu+VnHnh6GZjUEw9a92ICBPtqmUNKmcZhApD08RpFWDmk0B
         HHa1h3yJJcrVI5t/rxBUQrnYwP5o0zoX6ete26K0i8hUP2g2MJEnWSn4rqSSYlobBwKo
         YmmRG94NBsXlYAS5vqhnHhdsILsnDAfFwoTBSGsAyOb65flfJ0DSgT76tAd4zohbv21t
         x9EB2rzfhY3YizBry4YraKY538gcB4LO3+E2QUzCW4t3Mu5XB5/8ODRoouBgt8dGupPy
         ZJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749610650; x=1750215450;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5/dKPGbzIpZPRhOJIYAIUAY23sahY1p0GkM5Dbi828=;
        b=dYAXWNkupbR2Dia58D7TU1xuztXeprGrfzXn7hlhdI9TCmzwLGOVGDH+HNTZLyg1Kx
         ZnYfHWZpWqZE8asJRLO8yr3gx+FDgkMMvBM8WuYrYa5KDNkqt6AENlt0f+rVCOWveZPv
         3kmQTSZ7VG/qDTaimp/SX28aFdoJabPy1VaOhWoUrnfNR6QEkpChT9+t1dESVfedCQBm
         jnb3eEUr4Nu/LKbjh/uMMgd1Dt4qJfSznmTUGT5JqO8qGc2Z2ORZYIGaL8016mL9MntL
         oPPRI23OHY+lBZ6Jvt1EvlMd8zA61TMMQCH9LwDFyJ2Ynp1z+5otZSSIulLEOk3r9q4P
         g+4g==
X-Forwarded-Encrypted: i=1; AJvYcCWtzzThM4uzw3SrsmE604A6cA6VPXzqH1yVnQbh4BNX5p0BgagL2Yt/ke/rkWNMqQKwAMBNkKLXis3a9nh6@vger.kernel.org, AJvYcCX2MXUY3m9E0DUl64h1nX4HR9/mhundMn9NOnp8YyfUUpkaoR9l6fEuqtQpVoRCjVA1bQLxqCGEoDyegSH0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5P42e8ViyBsL7MK81ViHJWA9p6Swv5znmUXmxP/ZP/z58ANBe
	XuXYQa6L7VG76OmfpSmqxAWNPwuEVL0LCoXc1EX5zWor1H5lVkeqJR1h0Yq1Si0obsTWgUkQgxU
	ZlUc2ad+/z+P6uGsSRr0T9tJR5G03/g==
X-Gm-Gg: ASbGncsBIL44rsd6iSrKpaV1hMDlNfj3/2ZVv8wa7pybbWIL9Jy0Q++sdwGo7YUlIwD
	k/rzAOrKGzyVk2+GY2uIROUouAdyq7x4JD3qFkjMz6sGGOfq+ez14mdSWKza8GRtvxzQ4NGDJaE
	CK2ZYZiz+8yHMgQ2q5LJd/3N9EuVNrVKWKvZFNcbDKzl7x023DrHTWjHFkM2aid1B3
X-Google-Smtp-Source: AGHT+IEFNzBv8fZSBw4aZ1kXDaDWLmj7aUuxHZCWz3lfEOlNJgoEOiB4e0JsaAMYaDjUOLs41dCtCLk2PDK81AZCINc=
X-Received: by 2002:a05:651c:210f:b0:326:cf84:63c4 with SMTP id
 38308e7fff4ca-32b210c657fmr5158651fa.1.1749610649747; Tue, 10 Jun 2025
 19:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Wed, 11 Jun 2025 10:57:17 +0800
X-Gm-Features: AX0GCFt0cfSVXX65tmSyu3WNgHQ4OBUou2DiUUZrRdo_qtrgZDXAjeLg3uyGav4
Message-ID: <CAP=Rh=P1fGXNWpy02ZfNaDaRVx-7i5sKzehHxjMn5s7puwTbtQ@mail.gmail.com>
Subject: [Bug] INFO: task hung in bdev_getblk in Linux kernel v6.15
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15.

Git Commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca (tag: v6.15)

Bug Location:

Bug report: https://hastebin.com/share/xafazazeve.yaml

Complete log: https://hastebin.com/share/wopivucivi.perl

Entire kernel config:  https://hastebin.com/share/ajowibazak.ini

Root Cause Analysis:

The bug originates from bdev_getblk() in fs/buffer.c, where an invalid
1024-byte block size is requested on a device with a 2048-byte logical
block size. The function does not enforce block size consistency,
leading to downstream allocation failure in
ext4_reserve_inode_write(). This failure is not gracefully handled,
resulting in a persistent hang of the writeback worker thread, I/O
errors, and filesystem instability.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

