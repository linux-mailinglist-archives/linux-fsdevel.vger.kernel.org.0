Return-Path: <linux-fsdevel+bounces-48775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB8AB47B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FB946049C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934729A323;
	Mon, 12 May 2025 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv+Jz5tp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DF18024
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090769; cv=none; b=DJ3XVU3M8LVlmTozDDV+qIAr9LBVGKGYrC4MYuI5D8A7rO5IMbrIXh4y1qbrh67YVwqPDC8e3L2PrePbyvrQZyGWKYZr6AXnWyqfP4Bxnm574FltxWpoGCuYQtR8UChmrtRDdJOyqaNTwzGVvUgOjOqx9L0Jlc4+hyPtRgjkNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090769; c=relaxed/simple;
	bh=cl4MWdQk+Vz7ZtQnEv4lAqsUs1PKAETlPB+HB/O5uGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLWM+K299bhwupciyyCpC/9dfW70fmzrdf3+SjNxxab/MrTtESaEEmGUVCtWQwM/HYm+ZRf3oilPTR8AjTFYRMJWAMJNIOqr4kO5/OIJZbz7Vzy+hBUYdY64ChiDCzUoV6TeEQ7nH9m26IuGUJuEogk00ukCnXzmzOEe3PyA9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv+Jz5tp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22e8e4423ecso45159235ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090767; x=1747695567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzDIDe972n4S2wck5XxjPChqiKpobK75OR605WIwBLE=;
        b=Gv+Jz5tpSk5aax6IBlyw+z/wU2FTVUgjkRRS42SOfEDM/CSOJdaEbT3L0yVyR8tzGs
         bGVhNUmOs/GXbGDP+q40Llkt2yr2T+qHhLSFWlHa3sfpr3Vi0Ypx9H+fbc9svEuhvKCj
         u2TEisRSViXtMWHI2U6fOwmU1hkKxWS/6kj8P2BkmzKqE1MuVa188uygSHl+WTpZIcll
         mvFCIccn23rekocjfuBUoCdvgusjnMOVt0EX4UmFHc5mJeoANNrK0Wu2R9XaYkv/SMLZ
         9PovJr9wPQu9m16RPSi06FKsgu5V0nTUnKd9NZoORYiz7NimpHlmPd3yWqTKVcvupBSr
         ayOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090767; x=1747695567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzDIDe972n4S2wck5XxjPChqiKpobK75OR605WIwBLE=;
        b=gVL9pDD8af01M5qaQPJip+nNZov1/5kOuRbzHfeashP2nk7WcNX0JmIL5sZpk6T8TH
         VfSFnvbgMcj52n2VWesOapg48fnNs3joLEQx8UCG46OM4eTXJ8mdza0xreJGR7eTv4MQ
         ZLEYzgsJgvld+PFnrDEEDghtEvyjdRWTrXIXuN39H9f+/EWpZiHtkjIsZwg1fdmQ75xN
         rtnXQbSsfj02Ip0cSXIwvbSJNzdxOcFQB8T7DFkXAgHgGpaeybSATJN1aRuM7FfZ0Cbc
         fbgkFpda3tGqGxPYKtfy8nGRaoIZ+ckIkih8rMAkyRje/gXXwg8PnyWI3qJHbS4f+58E
         9OUg==
X-Gm-Message-State: AOJu0YyjWCEvqz8nilWaF01M5h5Gzbjs9GZAQUmIZs+id7zRP61gPwIY
	1mMZj2buvWErWb73f1hnyr+VFuTYiN/RvpFbYjnnygeLDZAuecA/
X-Gm-Gg: ASbGnctcHeGCzMv78WOKbfw72I4P7GYcg9hJoC2JqOu80qzOdt83cDtNlNsQTDYbEmx
	/Rye2bTWK0iFVtV8DHRxwEizOXvxn+Wsxykzjm3YDB0ofR2XjmKOdALucPgymx8/58yarlqTUG/
	wg/SnLiP3rdtlJ4HT/tdgjtS0G4SHkvcnwgpx8W6X6S/o2MBxQ0UOCZkT/tDzzSHbh4al4cUg+P
	OT6VqCZ27wBm5u4ZAU/0jsL/27QvizINiuS2DdLjozxWtBhDTnZkYCKy/UhrRx8EHF1c2DA2hhQ
	7xzcFdghf/wia8NM3t+DT8e6SpPFW94T2DvNwck/ChB3/g==
X-Google-Smtp-Source: AGHT+IHbQTzLl3aWz7klTzK8OUa+mDNLgxCvoQVcJ69WN4FMP903vP2e1pmCBt81o7qdcdqzHcJkBg==
X-Received: by 2002:a17:902:d545:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-22fc8b703acmr229125115ad.25.1747090766557;
        Mon, 12 May 2025 15:59:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544e9asm68561605ad.6.2025.05.12.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v6 00/11] fuse: support large folios
Date: Mon, 12 May 2025 15:58:29 -0700
Message-ID: <20250512225840.826249-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for large folios in fuse.

This does not yet switch fuse to using large folios. Using large folios in
fuse is dependent on adding granular dirty-page tracking. This will be done
in a separate patchset that will have fuse use iomap [1]. There also needs
to be a followup (also part of future work) for having dirty page balancing
not tank performance for unprivileged servers where bdi limits lead to subpar
throttling [1], before enabling large folios for fuse.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com/#t

Changelog:
v5:
https://lore.kernel.org/linux-fsdevel/20250426000828.3216220-1-joannelkoong@gmail.com/
v5 -> v6:
* Add Bernd's reviewed-bys
* Iniitalize err to 0 for refactoring fuse_fill_write_pages()
  (Dan and syzbot)
* Add comment for readahead about size of large folio (Bernd)
* Use WARN_ON for readahead size sanity-checking

v4:
https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-1-joannelkoong@gmail.com/
v4 -> v5:
* Now that temp pages are removed in FUSE, resubmit v3.
 
v3:
https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelkoong@gmail.com/
v3 -> v4:
* Add Jeff's reviewed-bys
* Drop writeback large folios changes, drop turning large folios on. These
  will be part of a separate future patchset

v2:
https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-1-joannelkoong@gmail.com/
v2 -> v3:
* Fix direct io parsing to check each extracted page instead of assuming all
  pages in a large folio will be used (Matthew)

v1:
https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelkoong@gmail.com/
v1 -> v2:
* Change naming from "non-writeback write" to "writethrough write"
* Fix deadlock for writethrough writes by calling fault_in_iov_iter_readable()
* first
  before __filemap_get_folio() (Josef)
* For readahead, retain original folio_size() for descs.length (Josef)
* Use folio_zero_range() api in fuse_copy_folio() (Josef)
* Add Josef's reviewed-bys

Joanne Koong (11):
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

 fs/fuse/dev.c        | 126 ++++++++++++++++++-----------------
 fs/fuse/dir.c        |   8 +--
 fs/fuse/file.c       | 153 +++++++++++++++++++++++++++++--------------
 fs/fuse/fuse_dev_i.h |   2 +-
 4 files changed, 172 insertions(+), 117 deletions(-)

-- 
2.47.1


