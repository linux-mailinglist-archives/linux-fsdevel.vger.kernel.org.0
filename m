Return-Path: <linux-fsdevel+bounces-30365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07498A5B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC3284134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FF190064;
	Mon, 30 Sep 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zwv6cuo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D711E4A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703939; cv=none; b=YfAoaJgQrKVx58aalLvPtJd4T7fJ3jt2yJ14ZW/KFCPH9N/3z8pK3P0xjwschCmpvWc4StEPoWP8mhzulzKM4ly+8NC5T/LLJbMXRoA9rZ/n7CG6OJt+lUgWXAjl9bfAEfBk4jvK3WSAsRxtsfDpQUZNcIc00AXsb20RZ7b7upA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703939; c=relaxed/simple;
	bh=iNKJWN3NjkWOBvOR38EZrpI3Y+DTDxbHNuz7WKAekLM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fS2hpx/OUnE466THM0OY178HkzRlsGSGvZL/eSWxf2VmVmfG54/m7p85sq/7Q1DZygrQPMt/L1HZLvyVT20XU/TuNtOBGM5SPG1lz9bVnx1/LfWqzRv6X3jMMFVf1MLpBC59o/ooZM9v4Hz0qv5D03XxNnnAClVjYVu5SRO3n94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zwv6cuo4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4582f9abb43so32478281cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703936; x=1728308736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlauS0MPvFUm/XydfaAtV49Lm7BnU8LhWjOZsOTfins=;
        b=zwv6cuo4C+gFTt/cDAnCGBXojsxFkXETTFEZRcel5BLPZJcobg/kDMjn2DctwwCJmy
         REDMZyOMXLBjYEJXPn37YPIzGQ1vI5PFvhPTeTa0yP/Bq/Vjrksw8C9wBts97BjPxlZk
         vkrJ7rLUB0sVqDb7exE/HYdAjHT/e/cn8OjuPBW+v+2EIr9Os8+UoEld1bWidkzuXZCR
         HwLQNz54QCo8TJ5MWiWOncN9QnwtNrgKacK/1jqCcIkPymIfJ6e9FCQQCVrMbReL7SdL
         HtGFelwWvRWpF2FJQ1zfl9f2tzTmPrTdXPt17ydN+v+GP7XrQz0+Kbt2YfukbJB5w/hV
         QZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703936; x=1728308736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlauS0MPvFUm/XydfaAtV49Lm7BnU8LhWjOZsOTfins=;
        b=u2aPvNUUfR5irILEYE0uBrdJfHeaTGg3TYVNAsquJw1qMPtr4bQSFpF9CS6OIf4Qev
         C9z3fOfJsnZiiav0iwBMAHo6QZa2NnQQcn5GGwh4un88QgLH/5z/QiVlHFHShoOMRdzE
         dDi5bf7hK6s7mFbZ+io/lk7ldDLxGLbtNbCorNrSpjFuIcwXxsm2frYTM03QhV5skrve
         59RipoXkMoQfOoRvAo9ZkKJHrYqPWVWJgm1O5OD/5X2+UmQ3VzgVsi6JEHx/D/MckOHI
         96bqbq9l8Xg3GxNImaw8Rxww5qN7PxKmYOeHlA/KPtyRIweC3hNo037fyW3mOePyiWpM
         4aYw==
X-Gm-Message-State: AOJu0Yx7IGSHJTbTCDzmgCSLXGPPJdBRwLlQ0E9481qciVG1Bcg0iRPC
	YW8tRLEu+Aahurr+wza0G4RU9Pjt+93PVYc3tEE0/+EizdU74tuTGj27JvaG1smHJSA//kQ6O8w
	+
X-Google-Smtp-Source: AGHT+IEtRs0Q8668vM0sGxCe6J4k51+AAGOW+Uy7F4YZdUYTUelwxTWZIxhzYV9vPMurUgidUS523A==
X-Received: by 2002:ac8:5a87:0:b0:458:3154:4d0d with SMTP id d75a77b69052e-45c9f282996mr186871141cf.37.1727703935506;
        Mon, 30 Sep 2024 06:45:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f362e06sm36003071cf.90.2024.09.30.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v4 00/10] fuse: folio conversions
Date: Mon, 30 Sep 2024 09:45:08 -0400
Message-ID: <cover.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/linux-fsdevel/cover.1727469663.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-fsdevel/cover.1724879414.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1724791233.git.josef@toxicpanda.com/

v3->v4:
- Added Joanne's Reviewed-by's.
- Renamed fuse_do_readpage to fuse_do_readfolio, and updated the comment to be
  more clear about why we were waiting on writeback, per Joanne's comments.
- Used filemap_get_folio instead of the __ variant in fuse_retrieve, per
  Joanne's comments.

v2->v3:
- Discussions with Willy at Plumbers helped clarify expectations around large
  folio usage, he had already converted the generic_perform_write to deal with
  large folios, so I dropped the iomap conversion since it's a bit overkill for
  FUSE's buffered use case.
- Rebased onto linus + fuse/for-next.  I had to combine the branches because
  fuse/for-next is behind linus and there are fixes from Jann and Willy that
  aren't in the FUSE tree.
- Pushed a new GH branch since I had to combine everything
  https://github.com/josefbacik/linux/tree/fuse-folio-prep

v1->v2:
- Fixed my fstests setup to use --nopassthrough so my code actually got tested
  this time.
- Fixed a bug where we double put on the folio in readpages, because previous
  behavior was the reference was maintained until the endio, but
  readahead_folio() drops the reference on the folio, so we need to not call put
  in the endio anymore.
- Fixed the IS_ERR inversion pointed out by Joanne.
- Made the various adjustments pointed out by Willy.
- Updated the Kconfig per hch's suggestion.
- Pushed to my GH tree since there are dependencies to make it easier to see
  what the code is https://github.com/josefbacik/linux/tree/fuse-iomap

--- Original email ---
Hello,

This is a prep series for my work to enable large folios on fuse.  It has two
dependencies, one is Joanne's writeback clean patches

https://lore.kernel.org/linux-fsdevel/20240826211908.75190-1-joannelkoong@gmail.com/

and an iomap patch to allow us to pass the file through the buffered write path

https://lore.kernel.org/linux-fsdevel/7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com/

I've run these through an fstests run with passthrough_hp --direct-io,
everything looks good.

The last remaining bit that needs to be made to use folios is the splice/pipe
code, which I need to be a lot more careful about.  The next step is to plumb
through the ability to handle large folios.  But this is a decent start and
removes the bulk of FUSE's use of struct page, and is relatively safe and
straightforward.  Thanks,

Josef

Josef Bacik (10):
  fuse: convert readahead to use folios
  fuse: convert fuse_send_write_pages to use folios
  fuse: convert fuse_fill_write_pages to use folios
  fuse: convert fuse_page_mkwrite to use folios
  fuse: use kiocb_modified in buffered write path
  fuse: convert fuse_do_readpage to use folios
  fuse: convert fuse_writepage_need_send to take a folio
  fuse: use the folio based vmstat helpers
  fuse: convert fuse_retrieve to use folios
  fuse: convert fuse_notify_store to use folios

 fs/fuse/dev.c  |  38 +++++++-----
 fs/fuse/file.c | 164 +++++++++++++++++++++++++++++--------------------
 2 files changed, 117 insertions(+), 85 deletions(-)

-- 
2.43.0


