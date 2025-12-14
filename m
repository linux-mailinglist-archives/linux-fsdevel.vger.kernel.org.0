Return-Path: <linux-fsdevel+bounces-71271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3CFCBBE77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0C2C300EA2C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5030CD99;
	Sun, 14 Dec 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqsL/h3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FE2E764C
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765735379; cv=none; b=phhfpBvgjtus5hqhNR1wrgMIisKvoCn7PtVw0xRdX3g+5Rz7hBIOZ8FVyKdQNKrKB1A//9wOarTDvfBbYBYecNgTlWxc6i8/Vf1xWVf/CfIBVynO/YPJM4oATrEo/kPLWRR5N/QX2XlXh4wf0h8emk2yB5PRCd6ZYsf8mdOnoNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765735379; c=relaxed/simple;
	bh=IVvRulDuWrrNS9715azItbKskAH+S1PQ1xvsLxX6NH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLTuutW6hKukVu/uK79d6r1M2UubNWHUipXP/h6k8m1YyxFxaUM1tRoykwDWY30waKtyYTCeFIFEBB9lzlBptQwjfo6i9ujRSDLRK702SWCehq3fAyy+W4tk2EfDdLkBGlZkHRxSUHQbRgYxJk7ZYMS11F8mryGrl/bZKWDRgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqsL/h3Y; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2627269d5so285902185a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 10:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765735377; x=1766340177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cy/g9evgHNFkAquxzr3d7GuxFauDlKjTyALOqssS9A=;
        b=AqsL/h3Y/mACwWcpSGC3kQ/JZsSkD5Rm3VEWV5p2BiWyT361MvHmbkQtY1nnFpdJlB
         EAS3UTzJlJWQLWENaVzkB+bSfYSvmhO+Wvg69zW1EhdUM2mgFEokIQjffnIiesOwwYfE
         RJfso84W6q3DKIsVG+lNDkaq3dWWTgasyWyP/tP68MYaHOEYe/8n+QHx3BMpKI+qsab1
         OP/ruRvQxbsyDJD3qh81LoEQzmNb9Ch5tsHUWp2rQf6r41SJG7trR32T0Ll43QKUSe33
         9hdRfEPS5mZBV9YyhIrqWt7S99ZH16lbBx6hjYa0VpDIjgY9kS5An4FOkUhtwIfysX5E
         SvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765735377; x=1766340177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6cy/g9evgHNFkAquxzr3d7GuxFauDlKjTyALOqssS9A=;
        b=AaUuBrbm7oY8gmP88imxF7e7+jpp1FJrFleU7v6slQiVFnPhkId1D5w3vPhTojUoN4
         zpXO/ouQXy2ccCkLv4wb2lDPbg2uvHBe3zRmJJKCy8h3fUuPkdxHMCYc3Ejvv2j4jLPn
         oNvoen26RAovxZjXj+WW4o5rzo7aB4N4K5qFFfsH65MXr5EM5XBq9zG0gbi2VB3wGxLr
         3ydeMI79664kZkm4FgqqK4XMvYFOi93rMqbYVuRb5GaYlXmtD8snEDWG1RhaZ4s2EsMY
         svqAve6Zl5ZT6d5wz6O9M3A/W8cAbHI0BxUrdt3Tmn+j+vQOhWxel8zpIQa3YrH+/ffx
         aL8A==
X-Forwarded-Encrypted: i=1; AJvYcCXRlcp9RVqLIiJC5YCxtDpCKd5omiy3YxV2rY4QcbMnQy/4Q2vQtSqLwdPoUpGfZB0llQdLvqOQLA4gHvCv@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+Fr/pa5tzpUbj21881l0RArbCvzZdXCFyDMjhdiaz7hBniG7
	VxqIs+HT5ixiBY91C2iWvyv7nKO0OEQx8hO4E/QQRYCHVpyzbU9aVgOn
X-Gm-Gg: AY/fxX5usHPzqppOpXdFsHIfD5Qj6rUgppgiG9wgO4PV7FTU8DP7FZpSNYGp1aot2Oz
	qMtB0HfgT+AAvWhIFWk0XIZLuQTKYId+JEcCSkRU8wa7crkQDwaPTrtFEGdb4uYLQSIlVKeqp0h
	yWeKfh6wNIe1YdXAF5cpO207WRAj45JItCzypDKixIGLjtcWPzM1dQeJtZhHZYGWFyEKW+zeg6t
	2ollhRalbiQukBfgJJZdZmjdlaXgwOCVc9dfLNo/P+gJfZ/6z9GfRf570TZsQRkyAOVd92KyOwo
	n58kDuUBYf4BQe3IHIivWp65LGTgDYfnoNS/Ojkg74gVz3DJOdYyutdqp0Q8IG/3SSwL9vasdLT
	DfZkg0SCxT9kBAupMl4bIIfWG8S+Fh2GarMFJt/F0Y53W4tFqUG1ljRA2TuXRBw/u9XPZlq77b9
	o/eUXaJehmYGL6EW6EpHkw9UDrEcQLncIut3lkrQaUQ2YADf4=
X-Google-Smtp-Source: AGHT+IF4CyCgSDlTgHN3haCqqdOhd5KCo9UN7nKgxU7MjiducFCfBbhTh5Ca3dMYLQuvxHuk1OnEHg==
X-Received: by 2002:a05:620a:4046:b0:8b2:dd0a:8814 with SMTP id af79cd13be357-8bb3a39ee87mr1219774285a.85.1765735376520;
        Sun, 14 Dec 2025 10:02:56 -0800 (PST)
Received: from dans-laptop.miyazaki.mit.edu ([18.10.148.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d4cd34sm891587485a.47.2025.12.14.10.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 10:02:56 -0800 (PST)
From: Dan Klishch <danilklishch@gmail.com>
To: legion@kernel.org
Cc: containers@lists.linux-foundation.org,
	ebiederm@xmission.com,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount visibility
Date: Sun, 14 Dec 2025 13:02:54 -0500
Message-ID: <20251214180254.799969-1-danilklishch@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aT7ohARHhPEmFlW9@example.org>
References: <aT7ohARHhPEmFlW9@example.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 12/14/25 11:40 AM, Alexey Gladkov wrote:
> But then, if I understand you correctly, this patch will not be enough
> for you. procfs with subset=pid will not allow you to have /proc/meminfo,
> /proc/cpuinfo, etc.

Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
tree to the sandboxed programs (empirically, this is enough for most of
programs you want sandboxing for). With that in mind, this patch and a
FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
/proc/cpuinfo / a small kernel patch with a new mount option for procfs
to expose more static files still look like a clean solution to me.

>> Also, correct me if I am wrong, installing ebpf controller requires
>> CAP_BPF in initial userns, so rootless podman will not be able to mask
>> /proc "properly" even if someone sends a patch switching it to ebpf.
> 
> You can turn on /proc/sys/kernel/unprivileged_bpf_disabled.

$ cat /proc/sys/kernel/unprivileged_bpf_disabled
0
$ unshare -pfr --mount-proc
$ ./proc-controller -p deny /proc/cpuinfo
libbpf: prog 'proc_access_restrict': BPF program load failed: Operation not permitted
libbpf: prog 'proc_access_restrict': failed to load: -1
libbpf: failed to load object './proc-controller.bpf.o'
proc-controller: ERROR: loading BPF object file failed

I think only packet filters are allowed to be installed by non-root.

Thanks,
Dan Klishch

