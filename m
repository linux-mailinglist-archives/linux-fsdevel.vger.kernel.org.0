Return-Path: <linux-fsdevel+bounces-37379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B417A9F1907
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A54D188F1A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2B1AE876;
	Fri, 13 Dec 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOGXEdej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D761A8F94
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128588; cv=none; b=R48891IrhoOjA1Edu5uxQWh7qpbjcishBzlVe4yR36vYyXGP3+gEiacli4HyYpJTyu/1De0gKLvu11eOwpLPXNu0B4mAKk62JAC8LQTri/YLWua95VoJfJjFB3sT8UOaMF8kco2AP/Q9V6ojuvgnWfVq3CAdyNJA3/W6dQpdh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128588; c=relaxed/simple;
	bh=vkBbFZJgu/tTCiZNngzaBAHvw6yUXKyZFOoYns24n8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K64dUdzpfZ0oPKcMvTznOyxhMvM/MSwo5TqF4fRKmZ3m9MLM+HV0hnJfw86k+mEPgTTaVJxvRBQyz2DvIixH2UZYfPfS2aXJQIgy77q3xgKabJY73p8DeArzbltCAWdnWjzUEaV/iSyuHi0V2Monhs1+GtcYTeQJ3yvQzKLqUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOGXEdej; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef0ef11aafso19516087b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128586; x=1734733386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oI0Xq1ySQWY5EztpIC4ekXRBUNBzbF5wPqJF3oP+upY=;
        b=eOGXEdejzJ1ObfcjQYBJCWjq7nW3BPJPrcA3hvm1QvkQII8jR5OehCzQGHlPitasvC
         /j9K1sIfymkUkIFX1B3xuA19hWOuodqguImWSfukev913aFSi13XNPsE9k1ytdWue2Kp
         4qQ5PEjB92MzEro1BcTb0R2LE9ZlMw0HHgPoJmV6R/x2UrFMQRhX1AiXSIjqAmeql2N7
         2K9r+WoQ9D6YUD4lxO4lBgHZEpwcmFxSqrsG3yRVdBknjvhHnVDUEkbEXaCdvCyFhI6L
         1KUazG7SXbC8g2TsZPFSsVii0z1F9Fxo8A332PdpMPmAVO94zoca+njN+n0T/NF5ST5f
         yh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128586; x=1734733386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI0Xq1ySQWY5EztpIC4ekXRBUNBzbF5wPqJF3oP+upY=;
        b=kHXeNf5mmm3v+Tsj2nmC4zaTgVyEu4hc3boiM2xQUTadUxHzNgOPZQE7oL58CpXQL8
         rqyOF7zUnVMrTrAmo30nW6oN0VOtW5pRu/p22lL1E0+Dhf8dLMYOJ6JwUwZZVnIwPaHB
         Sq7km+P1GJOtYANSU+okQ6ZGQDawfFVWrDQApeGep7UpCTG39c5JkQ7uNZPFbPJ17/zU
         s0uOvtEFrP/QkCbDQPxTXNRdDt6tcFYB05LPq2BqVx/kcEOYKGocrqVA58jv6QZGANTi
         R6j9758UBX1RNKggW9uXKwIwPTfHBLTkdl7j0LH3EzvDtd/GJ+Cb9VBEl+jT00k8cB+a
         EvQA==
X-Forwarded-Encrypted: i=1; AJvYcCW4zMG6NPBWyh9/+FPV5ZMy8trgWYrDOa7thk8/GCMmR8qcCjOCuF9612ktsizSNWofhyoQFv+4Fa2rdDOS@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMo9RRjPxQpY/cA8CSZKEJOKkaxhfWaemjotBd45NZkxxnNRX
	O9Af1+QUqS8o68xEIQ8chwaqkJDyoMXzvdWptDelN6nYHAH5z7nn
X-Gm-Gg: ASbGnctZQttTcNsHgfdjP5U07CuAJWN5DhyllmeU5COsVTKPzebxt8kMjze29J1lDNw
	1sFpasN0PipURMrxM1WnSEDkgfgfE/NV+QU6+M88VQEB4YKGSUgexPq2ZhVIKx83AOmEqY8xwDl
	GvLgab2xrPs9YflHqbNqgsb8Bazed/3p4Gp0CxfGnyqJNIkcddH/xJ+nesdoaqzLpO/HIf6a32j
	E9RgKotWWdUJ0r5Ub9qDxleTSKTjfRYNn9Gf7ByE5iiQ2DliPHv7rc8vja1VBPlpPKHbxdnFSG7
	roGZyrmM5HpvpRw=
X-Google-Smtp-Source: AGHT+IHnYjOLf5uh3da6Ku/vY1AgKRtYE8uhNdEatOf7FymZLirqHmdHLatSdYR7Q0X+C1FyxLGMsA==
X-Received: by 2002:a05:690c:23c6:b0:6ef:e390:1d36 with SMTP id 00721157ae682-6f279b012cemr47987327b3.12.1734128585805;
        Fri, 13 Dec 2024 14:23:05 -0800 (PST)
Received: from localhost (fwdproxy-nha-007.fbsv.net. [2a03:2880:25ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2890c80cfsm1208487b3.84.2024.12.13.14.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:05 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 00/12] fuse: support large folios 
Date: Fri, 13 Dec 2024 14:18:06 -0800
Message-ID: <20241213221818.322371-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for folios larger than one page size in FUSE.

This patchset is rebased on top of the (unmerged) patchset that removes temp
folios in writeback [1]. This patchset was tested by running it through fstests
on passthrough_hp.

Please note that writes are still effectively one page size. Larger writes can
be enabled by setting the order on the fgp flag passed in to __filemap_get_folio()
but benchmarks show this significantly degrades performance. More investigation
needs to be done into this. As such, buffered writes will be optimized in a
future patchset.

Benchmarks show roughly a ~45% improvement in read throughput.

Benchmark setup:

-- Set up server --
 ./libfuse/build/example/passthrough_hp --bypass-rw=1 ~/libfuse
~/mounts/fuse/ --nopassthrough
(using libfuse patched with https://github.com/libfuse/libfuse/pull/807)

-- Run fio --
 fio --name=read --ioengine=sync --rw=read --bs=1M --size=1G
--numjobs=2 --ramp_time=30 --group_reporting=1
--directory=mounts/fuse/

Machine 1:
    No large folios:     ~4400 MiB/s
    Large folios:        ~7100 MiB/s

Machine 2:
    No large folios:     ~3700 MiB/s
    Large folios:        ~6400 MiB/s


[1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/

Changelog:
v2: https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-1-joannelkoong@gmail.com/
v2 -> v3:
* Fix direct io parsing to check each extracted page instead of assuming all
  pages in a large folio will be used (Matthew)

v1: https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelkoong@gmail.com/
v1 -> v2:
* Change naming from "non-writeback write" to "writethrough write"
* Fix deadlock for writethrough writes by calling fault_in_iov_iter_readable()
* first
  before __filemap_get_folio() (Josef)
* For readahead, retain original folio_size() for descs.length (Josef)
* Use folio_zero_range() api in fuse_copy_folio() (Josef)
* Add Josef's reviewed-bys

Joanne Koong (12):
  fuse: support copying large folios
  fuse: support large folios for retrieves
  fuse: refactor fuse_fill_write_pages()
  fuse: support large folios for writethrough writes
  fuse: support large folios for folio reads
  fuse: support large folios for symlinks
  fuse: support large folios for stores
  fuse: support large folios for queued writes
  fuse: support large folios for readahead
  fuse: optimize direct io large folios processing
  fuse: support large folios for writeback
  fuse: enable large folios

 fs/fuse/dev.c  | 128 ++++++++++++++++++++++---------------------
 fs/fuse/dir.c  |   8 +--
 fs/fuse/file.c | 144 +++++++++++++++++++++++++++++++++----------------
 3 files changed, 166 insertions(+), 114 deletions(-)

-- 
2.43.5


