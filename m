Return-Path: <linux-fsdevel+bounces-34838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF889C924C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E25E285A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCF1AB53A;
	Thu, 14 Nov 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxvGinIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571691A0AFB
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611631; cv=none; b=eNcZPX0CHQrODtL8HyoNA42Hhas6SBAGvGsKCdo5z1pPTWhkWbKo1rENRn4VI+b8ka7h8FpvPA4hQ6aKuPUprqAL+COYd/gCdVQ3a++A5R+KThlMazAIJcqHePjoyMvvuZTbyl2cbsHvcGp1xog3291RJ3JWoT2pjVs3u04wE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611631; c=relaxed/simple;
	bh=x7S0HFCi1iuOisBV6LIOasXWVmBn3hpsnW8+RI4qWuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7rpNLQ4f0btWqWChNVZ7yftTouZp5CGPF1vHGe9RPofsl5YM5HYCZcbtoOuiBz/L+i9ExoED+MxYkf/6vnKTfzp2XRBsOu6XRIGS3bAXcFhqGgqDxhR7746SJl9RjCgWsjx6abS4z0WER1MQNgaSOtlQAoo6D4N7Dkh6fNM//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxvGinIh; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38ebcc0abso11581967b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731611629; x=1732216429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ni7DEz0FU2l21f+b9yRi6GWWwaOmzg2F74dnsHL8nFk=;
        b=mxvGinIhwnO1jGIIXryvrkYigqip11N3vHou1w0Vtt03vltLiqXyNqrFJi705dcIMh
         G0HKIq1+mU/go2utaSgcAbUMcP7AHKFE+7+CoUqQaGrEZXj3W8RWqjU//sUDokfmR4Le
         ag4vt6ORoV7VBisERc6+2dhBB2BbQLYYqyuJdGvVqLn2XcYsYxJkQtgWrphXY1HhJ0rl
         0Kx1opYChmnjKfR5zqDpdQg45tjaojRZwodJKuv68SNEtkT9Wlkr1Vrwa78xRu975xQq
         qdO6n5zRYsxuKDc2y93uSXldGJteVavy/Xm8q1FZ+BuWL7H/vd8C2QurikAUxCNvxGZg
         t7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611629; x=1732216429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni7DEz0FU2l21f+b9yRi6GWWwaOmzg2F74dnsHL8nFk=;
        b=Okdb9JY5OuOu4UIwp9YKdX866+HjB/D1QD39xfDXengmkeRY+E8b9mArEvj14YOK92
         YspHz7nWkQZNs7U49jPkAyRvIinIA6WZ5pD8I7Sp5sPJNViWwAMbU99JkXFVOIYmr9gK
         kSz+6txNJM+CW1gcaQW2W1SATSslPB6L/okZBX8xC/i2bfCKzRyTvPdkJVs7KggF7fQN
         2wTldFWs9+Joegp1I3tC9KW/Cb8wW/7kviAVPT+Q0EgqnvDcz1BYAomYHTDFpztyQAtn
         FrwcgxIAIwYvu/NnRkgZxnMiBwt1NbfkM6LrDMrC+30DSP5GUYTaw1EOckDVwaBGoFjA
         zaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI2BpVUjbFaRyCkoLFff+XYQzkWvgLJnIfqraZMYqWLjh14GdkIoDXt3BsktaDcDzloEaCyYj86GVX4KJH@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbJCZ2zfTCIbT6HJLBuEIBEq8Vmst8u2Oz25+64YNAgL9BUyz
	ifyr61nXZHwYpLkK31me2KNqpEjeHnwWXzGWpSYXyq2yiB1NwdQ7
X-Google-Smtp-Source: AGHT+IE75WpWmOotP1yriXSvG/tioLZl3Z9ZojD7XghZDcuQK/5NFAvCo/8cqv+RoHYNF9ivBXWRew==
X-Received: by 2002:a05:690c:d19:b0:6e6:248:37bf with SMTP id 00721157ae682-6ee55a781cfmr711577b3.22.1731611629088;
        Thu, 14 Nov 2024 11:13:49 -0800 (PST)
Received: from localhost (fwdproxy-nha-012.fbsv.net. [2a03:2880:25ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4444b71esm3789827b3.108.2024.11.14.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:13:48 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH RESEND v9 0/3] fuse: add kernel-enforced request timeout option
Date: Thu, 14 Nov 2024 11:13:29 -0800
Message-ID: <20241114191332.669127-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or
stuck, for example if the server is in a deadlock. Currently, there's
no good way to detect if a server is stuck and needs to be killed
manually.

This patchset adds a timeout option where if the server does not reply to a
request by the time the timeout elapses, the connection will be aborted.
This patchset also adds two dynamically configurable fuse sysctls
"default_request_timeout" and "max_request_timeout" for controlling/enforcing
timeout behavior system-wide.

Existing systems running fuse servers will not be affected unless they
explicitly opt into the timeout.

v8:
https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong@gmail.com/
Changes from v8 -> v9:
* Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
  spacing (Bernd)

v7:
https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoong@gmail.com/
Changes from v7 -> v8:
* Use existing lists for checking expirations (Miklos)

v6:
https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoong@gmail.com/
Changes from v6 -> v7:
- Make timer per-connection instead of per-request (Miklos)
- Make default granularity of time minutes instead of seconds
- Removed the reviewed-bys since the interface of this has changed (now
  minutes, instead of seconds)

v5:
https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoong@gmail.com/
Changes from v5 -> v6:
- Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
- Reword/clarify last sentence in cover letter (Miklos)

v4:
https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
- Change timeout behavior from aborting request to aborting connection
  (Miklos)
- Clarify wording for sysctl documentation (Jingbo)

v3:
https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
- Fix wording on some comments to make it more clear
- Use simpler logic for timer (eg remove extra if checks, use mod timer API)
  (Josef)
- Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
- Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)

v2:
https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
- Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
- Disarm timer in error handling for fatal interrupt (Yafang)
- Clean up do_fuse_request_end (Jingbo)
- Add timer for notify retrieve requests 
- Fix kernel test robot errors for #define no-op functions

v1:
https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls

Joanne Koong (3):
  fs_parser: add fsparam_u16 helper
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++
 fs/fs_parser.c                          | 14 +++++
 fs/fuse/dev.c                           | 80 +++++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 31 ++++++++++
 fs/fuse/inode.c                         | 33 ++++++++++
 fs/fuse/sysctl.c                        | 20 +++++++
 include/linux/fs_parser.h               |  9 ++-
 7 files changed, 211 insertions(+), 3 deletions(-)

-- 
2.43.5


