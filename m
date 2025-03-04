Return-Path: <linux-fsdevel+bounces-43129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1291A4E7A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03B8425AA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB683290BB5;
	Tue,  4 Mar 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyoho5pw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E43284B22;
	Tue,  4 Mar 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106206; cv=none; b=cXBZXkT8NArNNMNr/Dc2X2eyU6LYRODBDMjMv3PpyhKhE8hkpQGR0zwxzsMIT2FFO12QEPr9d1YUHvIWPtgGK0cXRPVAHkC6WUHkCfmoCwbSPGp98PniKnlUeFlhYR0mePRskX8arqswii+o1QmKaiK2kLbsQsQkD066x55EoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106206; c=relaxed/simple;
	bh=/VwNv+f8CqDK8yhQ9iAAKbwqtOiBwJEN6Hd2TghtFZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBjtrVdTxvaPWv0eL2qpXBMS6IKmSGJJgE7sElyh+7nEjc0Mkp9GjjM2rhNmex5WOMyKlz6Pn1/0yW8Si62lftpLkks3OjVqH+E1rqMeJJVUzNeuJf68CuzMw2fkYUq4Iimpxgk4LZmLdDjxlrk9UTcG1I2m9QYE0HgniZlE9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyoho5pw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so9020813a12.0;
        Tue, 04 Mar 2025 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106203; x=1741711003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4x36SfgwH4a6mzeRo5RiBu0YGb1BD/4sIrjIFpJZWhg=;
        b=Eyoho5pwkWIdGz3ptBiLZSaEZ8UzhsEn2ofB94ISVijqT9p/xjCQjWrv0Ng0st1QPM
         BtLuYelJIJM7NMffEPOxB3Ow6hCF+cXjhLp4LDCXbLZcoAtPi2FEzanK/iiGALLCURdu
         pk2feG+VGNfUh0PzMljcD47D9ZFuzMnFJdrfmPW8l8kbWCHclgz5cHMosISeBCT9Um4F
         z5iRypUM+4vPEcv+Cd4QqakkVkYYKo0zBhfrJ7Lr1TQx3BfbvRPjc5hL9K+p1q8r/U43
         3E7vCJHSG/YvWwyk8UAYFY42YTL0HtKr01hbcu5W2zOtx2vfljlzkwTVQIslc2+wR2Nz
         FEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106203; x=1741711003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4x36SfgwH4a6mzeRo5RiBu0YGb1BD/4sIrjIFpJZWhg=;
        b=ratG4jhGdAYh2i1Af2vLhpAUt9bZnBDRILlHQeG5lcAp192HLjVO3B3iTulWCZdhlU
         7xbs4OcjwyNIod3knn40qiYrRNFaF1jnVU3TFYj8w+CVEJS2RDDTjqxF42R+QHe97be0
         PjA4fFXW6VIS46XSSanPp3NgXUk7LCLyOz19mx6V9K3v6Kw2tpvCovkH+VudmgvKG4io
         15FC8GzMu3YrDt5EjchfG0BxkLB7vyedGMPZEd5P6gJsehEcWJalBfoRSQwDCU0iTZZb
         +J8QrYt7eGpiuoYg4A6i6lQCp0WWlAuZY4F/EtJ5QJLCSh8XWeNm+8z0EZ8JctDsgrvY
         6exg==
X-Forwarded-Encrypted: i=1; AJvYcCUR/0NsVC+F2SIUak9lfKhHGQzS7PAm5qFblVEDq1vmKxRLC7YnPhOG3H++C/43a8kG1RgYDC77rCdXWfuo@vger.kernel.org, AJvYcCXH+TI4UDu+pWDrOo2y8r79egdkDo5rw9JopwifnmuIBJpVGaY4mRWRz9BJbk7oNWTM/dCKS3fxyHj34lky@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3+cLBUo8H4i4ZJeCT2dt5M5TqwhBMja1ajjmgrGJCZODJL9J
	rDU8Ba1YCcsL7/ds0k2LHqUlTerPHLOuzwHxXSzwQaCN6uCxPpYf
X-Gm-Gg: ASbGncthR+62crUGCWCfBPczuayt/bQJiOqCNzXol5Ntu4cXb0qUETUgvQCscEq9F7v
	UEKP8+Xy/rJcH5VjqOpZjs5zsE7a1NCLrFX69edAqBTHlLYXaK9HD4hM/RTrqa+ORpL55wzz1/P
	bzATHocnt8xc6sHNysYC1nfMUQJicsGTBTBH53TVmYLg+wa1kczIFMLUqh0AR37Ryf9oaOvBFc2
	5lTY60G8KcJ6M3gK2E3uWdvl8SqodLANskDqbtaQbvsz8LdDMKn5Ksc7PJo5fb7z/mU1Ju75ZSu
	hud4/51DAV18/ZQnAS9/hoJA/eIqnaw3JcqKYZj1wj8g0xo9pbAnml8nBh75
X-Google-Smtp-Source: AGHT+IH0ZLeSdC9t0mplrw5KelaqsUA2cuiAMNaazjh3v6eX2ezqTG1WJ11/Rv4ofHjtx2jZS+qoeQ==
X-Received: by 2002:a05:6402:27d4:b0:5e4:c522:51cd with SMTP id 4fb4d7f45d1cf-5e4d6b691cbmr18558642a12.20.1741106202474;
        Tue, 04 Mar 2025 08:36:42 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a663fsm8246202a12.68.2025.03.04.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:36:41 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH 0/2] avoid the extra atomic on a ref when closing a fd
Date: Tue,  4 Mar 2025 17:36:29 +0100
Message-ID: <20250304163631.490769-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stock kernel transitioning the file to no refs held penalizes the
caller with an extra atomic to block any increments.

For cases where the file is highly likely to be going away this is
easily avoidable.

The obvious place is the close() system call, patched in 2/2.

But part from that possible callers (to be evaluated):
- clean up after failed open (common)
- close_range
- close on exec
- process exit

So 1/1 adds some routines and 2/2 uses one of them. The rest can be
tackled on later or I can send a v2 with more places sorted out.

In the open+close case the win is very modest because of the following
problems:
- kmem and memcg having terrible performance
- putname using an atomic (I have a wip to whack that)
- open performing an extra ref/unref on the dentry (there are patches to
  do it, including by Al. I'll be mailing about it separately)
- creds using atomics (I have a wip to whack that)
- apparmor using atomics (ditto, same mechanism)

On top of that I have a WIP patch to dodge some of the work at lookup
itself.

All in all there is several % avoidably lost here.

Mateusz Guzik (2):
  file: add fput and file_ref_put routines optimized for use when
    closing a fd
  fs: use fput_close() in close()

 fs/file.c                | 75 ++++++++++++++++++++++++++++++----------
 fs/file_table.c          | 72 +++++++++++++++++++++++++++-----------
 fs/open.c                |  2 +-
 include/linux/file.h     |  2 ++
 include/linux/file_ref.h |  1 +
 5 files changed, 112 insertions(+), 40 deletions(-)

-- 
2.43.0


