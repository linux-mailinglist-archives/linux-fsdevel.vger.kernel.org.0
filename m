Return-Path: <linux-fsdevel+bounces-47423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FEFA9D68C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF242924D1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C97188734;
	Sat, 26 Apr 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXt/dB8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E11862BB
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626205; cv=none; b=INS29fzGD8a/feXgq2Wi+MBrfck3M6gQkZXmYcqtiv/N41RA87G9/tv6Plskw8q6tGAcSpBpF11EgGlzkOpJdU4ItH9cPq//zaeLd0F7FbpgCtu1Ag3tsPWhiidSsdv0JwhzGcJT+ZRxT/YjkjXJnF1SXfl4LtxyK0+STIgO2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626205; c=relaxed/simple;
	bh=v2JCz5eFZH2+5idSxyovyVmnpzXNXpXVdLko4xuPCCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wottkz3c782ajdGnV1RR//koAMhK8dD6zEOZTRaD7x9vQYOYjAT+0wUp5JDvnfV4X0LLsMWH3YKhru58whJ/K9yL0m8btXhb3DsAM90KbGkMAbrh9UV3++7rkzKZpO6XMvx1MCfUs3qlI84wG8r72ifWMPNFTMN0beurqop5R3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXt/dB8J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224341bbc1dso34064265ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626203; x=1746231003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pesDiXTrz/zI/jfDQ7sMLUAG00DScaYGhDwidKoo7Y8=;
        b=aXt/dB8JV8Tv677iQkXVkUY16k0A0FQm+rPecArSb25gwzHwXY4cRBn8NGPQ0KGdJy
         3y+sMLza96KukADmKD+Aeg64VQE7/BNAc0t9NnPtM0m4f0Rz2Rg7+7Wi28Zhl6tpr1Qt
         er0YLwBA5MmMazbaQrPhcn/r5yekJazSKHrT8jODzD8rkwVStPgqLX+SFmGn1Z4GEtrk
         +aQqOyfgrFyW7TLca+/x5+c8TTd4oV0N4zC5WecMxd9K/2/+6PY01FYJUuLhV53FWLd2
         03CVQQJgy4AtKMW0Wk2cvodS899K981TzxS5e1q+YbOBWqiZgtyt0kNOkcncrSpj25ub
         CqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626203; x=1746231003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pesDiXTrz/zI/jfDQ7sMLUAG00DScaYGhDwidKoo7Y8=;
        b=DUe8u03TNyxkzh0lfkO3jBSGPVsuxkFB57Ila8tyqyEWI8UnPWFP/U2+LqlEWHsRbC
         0j8Sriu/zkRDZXsN5XhFJ6APqMKFl1ONuGZFWrlI7Oa84rusO2JtMOExiL8iGfMXzf81
         hVzJ8FHVAeLW4lH9b24UyUt+IuAjB1DpyV3Kb6+n7ChkD2WIfpjiXedBxG/zKrwOg3Vt
         67chy50NPp8xivA9Y6092JYritkzBVUXZlSDtvH5WKyhNY198vS4aPCyfXLNZ+lxHsGQ
         HUcYCFoZPi+AFxBMj3ZcOPEQrp1aKV2DWADdTbYLXAbHZeBoOuZt9W8RVUQ5TkdEIfnx
         Z4lg==
X-Gm-Message-State: AOJu0YxRrQ6HESdbfS0e44n4M4L7gqre7/dLvumxnDmmmwR5TOKQyRRH
	pFeq9Rt9TIjrA2ncasFGQIaSZSZJmjMLj8kHDypeGOYcizxNVCZA
X-Gm-Gg: ASbGncvOPN6Q10OLwP8nJikUhAPAl2KmVXU69Ip93wneTcd9fFiU3CIyml/CJDKbYkr
	u+4Zi20BALDqZ8tRwpEiSgsCjllzdWARvZx9+1cqs+z15wBBZh2Sxgy9LAggAenVxzHxTTSJ+dk
	3F7melDiqKWX9qHqTqzfru+nKJdu/1HqyvsFhpR81blUgj1MDGQiFluiAHmPr+/tDoRjmlX5NzK
	JOri8zff+FMyLzFIAz4XfdGBR2fe3KFRlwHhsPoIvmhECbl2dEXcOkJ8uo1UJbRk7gZtlSqetZi
	hTk/cs+5AtKYtBy+HHugklPlVw00hMHr
X-Google-Smtp-Source: AGHT+IGVub4rXNp2k45HZ3pQkP3EKuV98F6EQsdVZkPOkYhtGE0jkqbJ6ZFc325H7d9gxzA0mv1wTA==
X-Received: by 2002:a17:902:f605:b0:224:584:6f07 with SMTP id d9443c01a7336-22dbf62c3d3mr56087725ad.37.1745626202771;
        Fri, 25 Apr 2025 17:10:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db522216asm38790945ad.241.2025.04.25.17.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:01 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 00/11] fuse: support large folios
Date: Fri, 25 Apr 2025 17:08:17 -0700
Message-ID: <20250426000828.3216220-1-joannelkoong@gmail.com>
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

This patchset (v5) is pretty much identical to v3 except for fixing up
readahead error handling.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com/#t

Changelog:
v4: https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-1-joannelkoong@gmail.com/
v4 -> v5:
* Now that temp pages are removed in FUSE, resubmit v3.
 
v3: https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelkoong@gmail.com/
v3 -> v4:
* Add Jeff's reviewed-bys
* Drop writeback large folios changes, drop turning large folios on. These
  will be part of a separate future patchset

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

 fs/fuse/dev.c        | 126 ++++++++++++++++++------------------
 fs/fuse/dir.c        |   8 +--
 fs/fuse/file.c       | 148 +++++++++++++++++++++++++++++--------------
 fs/fuse/fuse_dev_i.h |   2 +-
 4 files changed, 169 insertions(+), 115 deletions(-)

-- 
2.47.1


