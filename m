Return-Path: <linux-fsdevel+bounces-50878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF801AD0A5C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28E4171D4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63523F40E;
	Fri,  6 Jun 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loxXH5jA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9323E35E;
	Fri,  6 Jun 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253369; cv=none; b=W6QCiza4O7LuRqNBYFJLjlGCUcwD4vvNGBNfEoQYENRsSIdGnVOnQyVt1xuFBs4FkXPfnawHH7oei9un11Z7eokpIJ4QCoBfVzgZaex85Sc0YcXZICJb4qgi5W2yq8HhGTkakRKEEUXfTmkAsy0s8HcEyNKaWTN6iNcMzE9gu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253369; c=relaxed/simple;
	bh=C4yw+q1Mtoeq8ecsHEMUNodiJ1+Jo7Ey1skwRmU7Dto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmeJGm9E+FpFlj+5xs5LFVCTn3xVAa0Y020E3wvPSsLR7JHXNz+YwuFQWQEdSiWhKNDwF6Pq8g11wlTS6HPYEK3ARA1Tbnqf+A9X1zhscIJ9kYxl0tw6/VQQFcea9yej5tsvPPUXU7HSYtD6AOCjvC3jbz5v71YqRvm4W70Ubq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loxXH5jA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747fba9f962so2262147b3a.0;
        Fri, 06 Jun 2025 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253367; x=1749858167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAGbxMylUR9JTwaiX5UAtGc8l47rpV4ShZHZ5Go9LaI=;
        b=loxXH5jAH94ekdPjZr7Jz43DviFcK/g6iZ4zSqGBTYtZY3NxGHppzzNCEMzPngJdEY
         kPUKgIwRhg0ev4njUWMWwbBZ/9vwnzp6kVtRth9c6VD1E/xK4dgPvsyyZRhpelgXpT0+
         TS+mmmLkDISeA9ORUNYOPueVlTLGE0xpy8p1Z3SynsK8+lc1ZylEP4aqSXEdcdIX0wYy
         uF5Gt74BjP+rpYw8sWnhIAQ21GUUzcaA50k+KIIcShpI84jQtyVOMS/6TIRD9M3+iW6e
         UMVKg8laULjtLecgTHvrq3oWaTver2E38qf1ed2Tbn/MmTseOEIH9qZvBqEg+4SIoXIw
         gHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253367; x=1749858167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAGbxMylUR9JTwaiX5UAtGc8l47rpV4ShZHZ5Go9LaI=;
        b=P79Z910LIeRPaVLfpxIxF4wRj+JjlylaBei4QExAsCZVG8ZzimCknDZuM8e5hbEfDW
         5klJjWEuex8hBLdRIclnv0jZr9AtnRze+TO5kKFUJjjil4XxfUmomXTjJwxK8IylaGSq
         85dy3J9AwizI8m3Rd/FOj5fPaUDNvjF9HmF4VHDYDT7sxCo6bRFiMIkejK3dltLj+tkB
         /kE/gNPq2zOYXXh+D30zdhv0AxIUtvkTGz30z2IFwKnh4qfLNA9/zHRxOqazohuRbzEI
         YkdIaSTwL4f5EvcTXgHenOLO7zJbWXRCPN2YYCWo9CPOIjAA+XyBhfXXpFZKTn6wyxVI
         KM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfl9BvuVJgOWc6gw3f6ph3t1042c5AYlZrFT8gefel3+LJCpxS+KpBFEXWKk1KQunR5g2ldCavLYcv3ChA@vger.kernel.org, AJvYcCXoldAniG2/zUDfll89QXeLJaSNmCgmBfFdUJ6JnI3TU+RSQtKWsntzAV8/7d2aNiqp1WhR+cjlAVB2@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPyDAStZj4mJPEPPSe99sjgg10NBAWxxoH0BumE3ryfw4gzz7
	q5nRJFM+sEVxMz/CbhK8tqdOu1tiGc264bQ5kJRwkTyXa/WcvA5nQCLG
X-Gm-Gg: ASbGncstQ3Lovat+xIMBFNiL5cCVSZlW4ZkPV/ZVzCyyQWawoU6eA/K91jAM7qe2baH
	OR15bkwqP9m4W0OWAOl8PkfY5+spiZTDwzeHqwzunZArX4X98CtDn1I1m+Fl0pHj7bHy/79bbD6
	eFYU2SJstAx7i8d3oQgBnEpBm7hxbGaoLo4fR5wpFWu9uKe48T/Md0VIrJoNFgDvGONO4FgNXS4
	WkMhv584newzy2+JYbHr0f4/qgY93f9vvCxWrbsAMwlS6VXkT8tILLbjsqUD4abP9nDbd43MaI0
	Tq39zUQoKHewR9Y1Cel2KR6+XaUGd2yjkaje83ul6ck8pQ==
X-Google-Smtp-Source: AGHT+IGS86hBrJvzOZKWWGGMYtTYleNtaCyQoYVQPO7jNUql3hf1oHRWUIF8s7wyooFnySliQlrROw==
X-Received: by 2002:a05:6a21:a8c:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-21ee2647c8emr6350524637.14.1749253366861;
        Fri, 06 Jun 2025 16:42:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083a9bsm1821628b3a.77.2025.06.06.16.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
Date: Fri,  6 Jun 2025 16:37:55 -0700
Message-ID: <20250606233803.1421259-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered writes and dirty folio
writeback. This is needed so that granular dirty tracking can be used in
fuse when large folios are enabled so that if only a few bytes in a large
folio are dirty, only a smaller portion is written out instead of the entire
folio.

In order to do so, a new iomap type, IOMAP_IN_MEM, is added that is more
generic and does not depend on the block layer. The parts of iomap buffer io
that depend on bios and CONFIG_BLOCK is moved to a separate file,
buffered-io-bio.c, in order to allow filesystems that do not have CONFIG_BLOCK
set to use IOMAP_IN_MEM buffered io.

This series was run through fstests with large folios enabled and through
some quick sanity checks on passthrough_hp with a) writing 1 GB in 1 MB chunks
and then going back and dirtying a few bytes in each chunk and b) writing 50 MB
in 1 MB chunks and going through dirtying the entire chunk for several runs.
a) showed about a 40% speedup increase with iomap support added and b) showed
roughly the same performance.

This patchset does not enable large folios yet. That will be sent out in a
separate future patchset.


Thanks,
Joanne

Joanne Koong (8):
  iomap: move buffered io bio logic into separate file
  iomap: add IOMAP_IN_MEM iomap type
  iomap: add buffered write support for IOMAP_IN_MEM iomaps
  iomap: add writepages support for IOMAP_IN_MEM iomaps
  iomap: add iomap_writeback_dirty_folio()
  fuse: use iomap for buffered writes
  fuse: use iomap for writeback
  fuse: use iomap for folio laundering

 fs/fuse/Kconfig            |   1 +
 fs/fuse/file.c             | 304 ++++++++++++---------------
 fs/iomap/Makefile          |   5 +-
 fs/iomap/buffered-io-bio.c | 279 +++++++++++++++++++++++++
 fs/iomap/buffered-io.c     | 410 +++++++++----------------------------
 fs/iomap/internal.h        |  46 +++++
 include/linux/iomap.h      |  32 ++-
 7 files changed, 586 insertions(+), 491 deletions(-)
 create mode 100644 fs/iomap/buffered-io-bio.c

-- 
2.47.1


