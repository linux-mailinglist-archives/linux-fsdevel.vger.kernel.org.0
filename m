Return-Path: <linux-fsdevel+bounces-38292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7E9FEEF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A911615FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EEF199230;
	Tue, 31 Dec 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXezhYKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BA193084
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735642023; cv=none; b=lsIiDcLtiNOvxy94R1/3gCjVwymF8yYh5dimXtz+Q/FpxeCTI0Qe4IsIUwU5AmN6oTnMIpy1fDf5jMOFso1xfrDjKFq48+p7vhCicBcFqUFzFbpb3B+CK3eNmOjH0qLPrG3nqCL1SgG04kxbFfTylVJugnjQ4lc6D+jBIz36Mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735642023; c=relaxed/simple;
	bh=WbOs/rwhZ6oh9uaYb4nJYSwMFrR5+VC1qBbxr7tEvf4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=saYZinakCgWsFc807Q4Ntin1XRlx60wRP5/CJNeFrxKiKcfmmMeboj6+ATfzOfwr1m/JV37ur8a2l3lQP7yecExMrCfcOTlnxa83/nAEyO9t3gwFqapPFUiVW52QONj7yDJTm9zpq7sU/5hXREOWiBFMffhlekspVr3FKCJmJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXezhYKU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a1cfeb711so10141434276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735642020; x=1736246820; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LcNv65wmBPfY4SiatcxN0WKgj/HKk5mfBlUAWeJr4h0=;
        b=EXezhYKU8wBhPmJQASs7fn6sScBAJ/jd4HoiDq1uqy1fkGBs+Y9tx8dNpe7pZ2MGxd
         KV9kXFyE80cdKDbqYrRqCCXjumk5m57gfM5fmF51t/2ne/xuRNq5gRKmXMUzqCo05PHW
         j6ioWM9f7bmkh2KgRndVtoC010sxuFncbZjcaooBYHGJ5g3qZkd4Q2Y/WNoOWTpibJBD
         dZY9V4n7T1qpK4gdEuKRbLGarZIB+2I04aHnAKtJDChCSDrUt6iZTgbUP6WaM2mC2bKZ
         wxEToo3F923hiqC1r4NGyZBIRXFvRx7v71FcH4oIAWeccM5MJ4jgtW7fKSS/LfQJidym
         u/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735642020; x=1736246820;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcNv65wmBPfY4SiatcxN0WKgj/HKk5mfBlUAWeJr4h0=;
        b=YVNo7YNvEP0P4JHIY17A233OgzhqpXDg5P7+1OLkBKjgXebjeT7ReHqfryj2nyagVq
         LEfI+ZgvXqQIeB3u53UaFOi1mHTknve7gTj8FBDVXrRNeqhnQgqV17+hmI3ozFAvD35t
         SvbECxQiTC7dWNlrWRufSVyLiewnbZx6DRsCyOSYkSr/YjTuJplx38XW9hWiJpuxTdfi
         dPbdTDq11a2kXecwZ1VmHk9i7rK/FgUrFWp4AGWkdz33th349AxBNxnu2vCIyI3P0/Pa
         x3cOIImifOGzbGpHc7HPJCyJFnOzN/9l+H4CQwdCG4bDsEiI6WE01+kSOT7a0eGUBEuC
         ANlg==
X-Gm-Message-State: AOJu0Yydivr8UxhzmVjppAHGg9fQ0Ik/YkhhQSiK5025RhbosdJe2/gX
	Y9s9ZToJ33BhZxNtYfuNuXi7J9knQHjl/AWbbxK7fgANP4l8Rxd9X94cxr6RULTPiJl8vE1lOzL
	RBEKARHr2IMLVDQyl1Lgdz0NoQ6ilY9ud
X-Gm-Gg: ASbGncvZooREEMgjp3d/9NcpqnSkBUM0RPlnfDbyfPFHhHvd+tqD2apFgqJNDu4OWdu
	WGQwEfVB2HfBouGmmIurSXERFeh2ZvacojFgB
X-Google-Smtp-Source: AGHT+IFmwIyXfykNwDVw6pYexJcybqqSPraWbnNZf0Vhe+Y3ktC8cSzKNMIeE2vZ8rilwqylxWIy5PMZDcdiZzzJ+Ds=
X-Received: by 2002:a05:690c:2502:b0:6ef:641a:2a90 with SMTP id
 00721157ae682-6f3f820cc4emr292750367b3.32.1735642020648; Tue, 31 Dec 2024
 02:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rohit Singh <rohitsd1409@gmail.com>
Date: Tue, 31 Dec 2024 16:16:49 +0530
Message-ID: <CAM70bNYLby0JWtax_oW7yKoZQFyjwA=x5fiNipnE5ZSZJ7NW5Q@mail.gmail.com>
Subject: Doubt regarding fsync behaviour
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

I have a doubt related to the behaviour of fsync().

I am tinkering with Ext4 on a slightly older linux kernel (5.5.10) and
I observed that dirty flags (I_DIRTY_INODE and I_DIRTY_PAGES)
maintained in vfs inode state (inode->i_state) do not get cleared
after fsync().

I observed this behaviour using the following simple program:

open(file);
write(file);
fsync(file);
close(file);  //I checked status of inode->i_state inside close()

Since, both dirty data and metadata get synced to disk
(ext4_sync_file()), shouldn't inode state be updated to not-dirty
after fsync?

Could someone please point out why this isn't done or whether my
observation is incorrect?

PS: I looked around the source code of fsync() in latest kernel
(v6.13-rc3) and I think this behaviour still exists in latest kernel
also.

