Return-Path: <linux-fsdevel+bounces-39512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD67A1563C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEACF3A8337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF341A3BA1;
	Fri, 17 Jan 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acXOYVEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AB1A3A8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136925; cv=none; b=KLErq1s1sswAzWnpusmspgLtdpKCKfJlmevEzgbjQQ9JRtBuaz3B5MMCPhHERXq7Slt9DlNc7NXOb4VbP/GrjJKPDHnWOtGt0ET+nJZo8dOrVL1Q48jBvIs04RvjAqydThBonUYuzS0nFz4YAqbycHTQjFGzFBEdT7f0F/iJ57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136925; c=relaxed/simple;
	bh=2TVvvWKA9wwbtOPHp1glyXej8vReUZ/tQ3uOZTlboCk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mBky3GWGyK8KTeACtUesGJpDrOz1UIJFpK5zf/Ep1OXejM+Ak6KnXN8YHUzazmfuMBzVTD+HAx7RgS+7+R+G/8E7ffylH+zhmt43vEhnV+NILbfAOY/Fc1Br5p4BPVKzNyulB0zrRFNaqbQzVZlJsN3940u5kCykTP7sPLBMG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acXOYVEe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso4017686a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136922; x=1737741722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ilvr+t2fmQAVnwiwuvMRyyaid0g17xjTtaEirLKnx1Y=;
        b=acXOYVEeA5UFI61ePdkns/n/WDBY0yeVgRf1/2YUKQrcNTPlr/npShemYE2m/iuVAp
         4k3Qy6Ap8pRUBQRgl7tk3YEWz4891UQY8eBwk4TVSLlkshY8CqKOGwZ1Es/eiBKMJSiQ
         fZPf7vMUPrGkeZzLK0THM7NooAiuc493l/WhDnGzr+wYdIRJcA5iv5mM+vS9JcyNB03r
         lwdj3Mdkgcb1PqKKP4cz7xMZ0teyIDMbGmQnVYQ1C4zlpmF/qpnST658863/jsajQuK7
         T7aMk4hK9loV5XDhSZL3wFaNQhiPHo4ar2Ezojm0P5wvt5EotGBLiYsufuLERbXTG6Tz
         wL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136922; x=1737741722;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ilvr+t2fmQAVnwiwuvMRyyaid0g17xjTtaEirLKnx1Y=;
        b=frUAPjzUHozuYOSFYbOaBcSlbnjiw7ITpV7pJM7PLLxiGug0LxnQuf4pWN3UGfoxcr
         j8XrYKEJs84hK6JgbaIPBtfFjLvfrA8HwMtsP/0yRWNUr32oGvhmpgo4RnVHB7thl/g0
         +g28rYgd+LXnjq7m+bPCKSF/DnsRjT8oLQ3TuIK4ZznefjwsH6cC3YKQup0dxh/PxbCN
         UsfGBK74vof74/gAhYVa2cr2MwdlrUHak7HsRU01JHKj+xQ4K817put00iIfuHP7hbnc
         iUVuxw0W/CKpPYAVmSZ0MsCFRepJbCephkT2qj9ZipFfnWiwT7zvCmRWUY25IvgMHKe2
         S+jw==
X-Gm-Message-State: AOJu0YyP+sHIcKuaxpW049A1LyDOLUD/vT1VtL27elqBC1b+nMFr8TO1
	jyOy3uP+ePtrOPEuJIEyOgiPOobfvDGPQEtfstFI813Cj/l1Jn4o/s4pNvE5gfHlIpqtYJbd6e9
	1zUPEYRSubFG9hgWDJ5ruhmWPPwDa6ywG95Q=
X-Gm-Gg: ASbGncs+L6voO+p3lgGqHEvM+GrVVqCeC/ObJfKFEH+TLrhetg+LZhsBprs85Z+gC7L
	KWdHuchuhSHH+/ZkpBPqb7aP9uMkt+8WSMoNnZQ==
X-Google-Smtp-Source: AGHT+IHsQT/baXVirWUr7vGzRHZvkrvYxJjLt+EDt0w30MEwtcmWKN62pqs8QNNS/t4ff4haOIEKZqmbNt9rpTyha8E=
X-Received: by 2002:a17:906:794a:b0:ab3:ed0:ce7 with SMTP id
 a640c23a62f3a-ab38b3ce74bmr325806966b.55.1737136921542; Fri, 17 Jan 2025
 10:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Jan 2025 19:01:50 +0100
X-Gm-Features: AbW1kvZSCkD5dHAUxuVHHQ4ixVYLqFZB90NIy3557ZetMaGOTGK7yOa51D7Wo7w
Message-ID: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] vfs write barriers
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I would like to present the idea of vfs write barriers that was proposed by Jan
and prototyped for the use of fanotify HSM change tracking events [1].

The historical records state that I had mentioned the idea briefly at the end of
my talk in LSFMM 2023 [2], but we did not really have a lot of time to discuss
its wider implications at the time.

The vfs write barriers are implemented by taking a per-sb srcu read side
lock for the scope of {mnt,file}_{want,drop}_write().

This could be used by users - in the case of the prototype - an HSM service -
to wait for all in-flight write syscalls, without blocking new write syscalls
as the stricter fsfreeze() does.

This ability to wait for in-flight write syscalls is used by the prototype to
implement a crash consistent change tracking method [3] without the
need to use the heavy fsfreeze() hammer.

For the prototype, there is no user API to enable write barriers
or to wait for in-flight write syscalls, there is only an internal user
(fanotify), so the user API is only the fanotify API, but the
vfs infrastructure was written in a way that it could serve other
subsystems or be exposed to user applications via a vfs API.

I wanted to throw these questions to the crowd:
- Can you think of other internal use cases for SRCU scope for
  vfs write operations [*]? other vfs operations?
- Would it be useful to export this API to userspace so applications
  could make use of it?

[*] "vfs write operations" in this context refer to any operation
     that would block on a frozen fs.

I recall that Jeff mentioned there could be some use case related
to providing crash consistency to NFS change cookies, but I am
not sure if this is still relevant after the multigrain ctime work.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/sb_write_barrier
[2] https://lwn.net/Articles/932415/
[3] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#modified-files-query

