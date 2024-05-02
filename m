Return-Path: <linux-fsdevel+bounces-18530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E218BA337
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18EE2811D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D419BBA;
	Thu,  2 May 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KV0UXu5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2B14267
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689225; cv=none; b=UcU6keQ+w950CLX3hNVyrwOJoJP75PnxZywyVbXehaY5bozpgrPb2Rh2xlLptVguTvmnGQR+V/GNt5QUs35zkkW6wz8bZnDCW2aSTjthJuWhxM4Xk89gqKO8VcY7W0R8R//aUr8QS9KyvbmJLo28bAQpqcO7m64PpGK8Foh1aHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689225; c=relaxed/simple;
	bh=zh3jTYlv3gAfsJ0fJDEOOWbgXfu84QDhZ5jAngTPr/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TD+mYJqdRSnJ86etb6tZ01Jw2vznQuCyVfIRbiZKEAu0/2Z4i6wbf2wQGnnZ13V0O9rKzbG9GA5WTTEKguP69xhNyfwjdhxK7d00gUSHV8xq57BBA16rb9xCsYHAYJot5EOG2pP5wsiWzpsemoHnKtyPtGrxMMYeOjdB3QM9LaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KV0UXu5f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ecd9a81966so9591855ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689223; x=1715294023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Alkyi5JqXUdcGMCJmPn2xNXTUHn7MjYy9EVPcBLGUQQ=;
        b=KV0UXu5fQphPwu/En8bFdZb2papNHd9PJxLZ2WTsEqQNz8tuinfCD2icHLLIK4jv3X
         epozpPCTWjKYEgy7RvzWsKC8cKABBzmDCIF3jWCtxn/BwsdRAln4s6YwOAPx3lvmE81A
         zY0yGcqQ8nkuoD1xGakPTTyykaawUVOwTUwcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689223; x=1715294023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Alkyi5JqXUdcGMCJmPn2xNXTUHn7MjYy9EVPcBLGUQQ=;
        b=F+ljB60Cj0iGKpOXLVX1AoKkVI3oCmF6h9rLY2K6ry46rgB9NzOCRcn+iN6ECUYgEe
         mm1PRhqtAayuiyB1G6wJAiWKh6yP07o1svC04zsyQQ4kVFhxz6xK9MLfSSLNNVImNnC9
         S41FM+5UDrxU9wBHeishtPS3EuLRMr1rSQl2jZN/spU5Tm9jdUe2ctPcu91DOUK5lyeP
         cosCx5Mu54A0/nAWYkEZkPkeHzsitpcwpUkeMFTx1pN4F5fN1O6teuBXrM9DxbXdbbNL
         fW+aKfSAPIe59NVi7Ph5BQdxQCH8xD5U7TZVTB4hgblErnLrRVf7oM+hUIijoYH4hozl
         Xg2w==
X-Forwarded-Encrypted: i=1; AJvYcCVH7T+nq7Ntfq39wF80Ss125mfBiKS0PjiBbLUPwziRyaeaXz9wwH7V2uwn8JTDJXs3ZMyJttrP1IB5Z4LFEoQf2oceTRw5MkMUA5iIdA==
X-Gm-Message-State: AOJu0YyYZy2eEduGMPI6VaZFWTqXjfOmxIV/Um8hisUD+edk3sfZAiIr
	qj0xMWr75aDPNmmg0vVzeNlrs+pSOt9hUJ14WXxUkZMtVlxdYAhI0Q+klT+65w==
X-Google-Smtp-Source: AGHT+IGAayZiLEBsyLgIJp727/HOhIW8jcf68JHnImgIz5MoqiH36x7xVdhDcqAQUHQ4AOs7ALD8tQ==
X-Received: by 2002:a17:902:ce81:b0:1e2:7734:63dd with SMTP id f1-20020a170902ce8100b001e2773463ddmr5911220plg.30.1714689223609;
        Thu, 02 May 2024 15:33:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001ec852124f6sm1859006plh.309.2024.05.02.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] fs: Do not allow get_file() to resurrect 0 f_count
Date: Thu,  2 May 2024 15:33:35 -0700
Message-Id: <20240502222252.work.690-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zh3jTYlv3gAfsJ0fJDEOOWbgXfu84QDhZ5jAngTPr/A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNBTDFUoY6TVoqmQxs375eqvdFBj89/ctuDLOW
 2+X99yJ49+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjQUwwAKCRCJcvTf3G3A
 JspPEACtGBTA/04xGkfNe0POOY6UGlh9ESMNyH/8oZZ8d3UQPt4M6jepl1PWlD4m3cEnHJK7W59
 Ew1O/o3JMO6xpM/DaYhVWnWU6vmyOuXC2BLL3sC0H78DoDCS1YeGvgwcsLvoJQkPR6yocxZc1Lp
 ArPQeS2n1GN6Natd2CKQpRU1hHaVx8V4k47jJ1C1ooXgDt7NaA3v3Mxp2k1nkVABc40Xt0iPZHe
 N135yJYCUnJcpYLB0ibjarI10wI4Q38s3kkHaSPBUFFlyZzwaqs8cVJtVafb+WFIadgKLSgplR6
 Gvo818ypPYTYB7jNIlptvHB2MpN4nJBL6DYjM9W9EA22HbIDDGJexmcFxNXqlQl/qXZpFt7XmnP
 Q6IX+BvQ65e6Zl3n+AYDDb+8lD/3uddFxKLY+yN8uImNTJaomfLEsLEdpWNQISX4Sd0iZoqRgNU
 wW8OcE471z7VJafbM8my64tY9J+xrj7sh3jZrbv695WaOXZVOZhvKl4yHNKdmuB7SwoTxzGJp8c
 6H/kFSBF+jTC0H5n89DfR0Uuy/y1HoONrXrvE252vDox1DwVh8Gfz62Vr1+HtbNlBpcN9K4w/k7
 /tznwjyRyIqPUxNhJJzdX9hpAs9d/CHvDyY8049XOPocPYOnqRtriVf3abZjlh68t5HB+axTGF/
 GHusxWn D0shXk1Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Failure with f_count reference counting are better contained by
an actual reference counting type, like refcount_t. The first step
is for get_file() to use inc_not_zero to avoid resurrection. I also
found a couple open-coded modifications of f_count that should be using
get_file(). Since long ago, f_count was switched to atomic_long_t, so to
get proper reference count checking, I've added a refcount_long_t API,
and then converted f_count to refcount_long_t.

Now if there are underflows (or somehow an overflow), we'll see them
reported.

-Kees

Kees Cook (5):
  fs: Do not allow get_file() to resurrect 0 f_count
  drm/vmwgfx: Do not directly manipulate file->f_count
  drm/i915: Do not directly manipulate file->f_count
  refcount: Introduce refcount_long_t and APIs
  fs: Convert struct file::f_count to refcount_long_t

 MAINTAINERS                           |   2 +-
 Makefile                              |  11 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c |   5 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c   |   2 +-
 fs/file.c                             |   4 +-
 fs/file_table.c                       |   6 +-
 include/linux/fs.h                    |   7 +-
 include/linux/refcount-impl.h         | 344 ++++++++++++++++++++++++++
 include/linux/refcount.h              | 341 +------------------------
 include/linux/refcount_types.h        |  12 +
 lib/refcount.c                        |  17 +-
 11 files changed, 398 insertions(+), 353 deletions(-)
 create mode 100644 include/linux/refcount-impl.h

-- 
2.34.1


