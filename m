Return-Path: <linux-fsdevel+bounces-28652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6796C8A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BCF28AB3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF7148826;
	Wed,  4 Sep 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MAkbVD8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA6148304
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481978; cv=none; b=LL80mPXwqr4xO+q85sZrenfp+M8C57dOwzOND/++NfADPnETOrfWl2UX7O6x940VeR/qxqgj7IkvnKjTvmeXn4HHxe1WGz13f0h0sAlq/of/8JWgN4wE6TpUAEv8h3RM4z1hv8OEgFHGqbX5b517RQPQhQTFbqaqkwvt7lbj1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481978; c=relaxed/simple;
	bh=iZpVg4UIks4/9zZsmikXI+KOj1xpK/F7nLp3FyWdb+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h5Max92pv2PDyM/dxk0VNjdrMX4QSt4jgTHUWpkv/sZDSksjEwevKSep7DwZNqiHKMZtKpQUaNp2EyYOP+fj2zZ198SyL8RLCLgpOjoHvi/rUQtXRJlkl3Du24SPfJlp17WwsctfBXyeY+gyrXVr8iUZ7Dy0guvWKSwqqJxtppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MAkbVD8A; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a812b64d1cso3132085a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481976; x=1726086776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGItxRWpB1BXrg+dM0KAmFZrRL5wbFT/VlU41y0nc9o=;
        b=MAkbVD8AAOqfTOR6szM0VwOIFs1TUf/HkLnA6RL/USHUSXFv397pkxNBb0WXWJvgZ9
         5wdaHETQCJpF51y/NrLUebSVlqF9cu2ncGd2DMDuigx7e+lRX7Ja8X6sAQ4jq1GbAubb
         kJSPxby1+yr4gyG7DIrKE73uu4D96Nb1HdrB2ND5HVGnzDMdBOR3jqj9AQ/vTzwUmIOS
         jpkcswkwb4Ge2EQ0wM8IAqBOg920Dyf+yn/8r7drrX/g7fr9+Uk3/FqHtFZ93FLUXDUG
         TMtWgm2vK555cC3KqxxrhKrdhqcz5ASS0f50G4EAMYSP8odW1Mpi8CbQkPknqp8+/Yo5
         WNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481976; x=1726086776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGItxRWpB1BXrg+dM0KAmFZrRL5wbFT/VlU41y0nc9o=;
        b=X+zA6iMbfjuZ+Oqt4+UeelD2kKNYN3CC33/UtHQhe2qUDd6AhaMnYSVIp1LOR1xLxo
         CoASf24UqN45PW++jH3IfHz1YFyxBCUk7IP0Cp80TeyxiALxnJQiTTA5vNMgR+aWxbo8
         iAWXJvQW+tVEfnIAm708AsqWPbrY1pyZqHWUmxB65zreEq03ro7feDkidIKQzQn99QaO
         82K5o/7JdNzsmTA/eM0+jdxBDmmxXjN0oDXrPlJ7/d4QpJj1ynhGMY0jZIM6XCKCI3TR
         dUONKBFFiUpFrMpYQHEHJ94vzjM92sRvrClQNPrSaFaoPxtcCu/PPpnQM6oVwyzq+oZ+
         e8rw==
X-Forwarded-Encrypted: i=1; AJvYcCXt2emyzy0DBjJUdfSYyVmE3gf/nYksptElDVT66LwjPZ0FWAV0cnQyuCTR3eYVdEBI3v1A8/qC8wKv8yqH@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoAd9KuwL8IJfFHaUu7+fPWyAcCe8lbP4+swyJmc6lxYmbBnc
	x5XMcJYOEweIo969nE5uYKUxOsQ9q7K3aF72rkAMDEnBkeYoqAzCFKUf31P68Iwe+3lu2pPMtO9
	v
X-Google-Smtp-Source: AGHT+IEi1V/Ca8ZoGqLHg/gJq1ahEKiD8SV537hISGdQ1Dg/lsO+1J8oNbCBAKE+WtA1QxRks1jk9g==
X-Received: by 2002:a05:620a:191b:b0:79f:afc:12e with SMTP id af79cd13be357-7a8041ce41bmr2465667285a.31.1725481976044;
        Wed, 04 Sep 2024 13:32:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b3318fsm1533671cf.34.2024.09.04.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:32:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] fstests: add two tests for the precontent fanotify work
Date: Wed,  4 Sep 2024 16:32:47 -0400
Message-ID: <cover.1725481837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These are for the fanotify pre-content hooks feature which is posted here

https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxicpanda.com/

It adds a couple of c files to do the work necessary to setup the directories
and do the watches, and has two tests, one to validate we get the right values
on mmap and reads, and another to validate that executables work properly.

I've tested them to make sure they work properly with xfs, btrfs, ext4, and
bcachefs with my patches applied.  Thanks,

Josef

Josef Bacik (2):
  fstests: add a test for the precontent fanotify hooks
  fstests: add a test for executing from a precontent watch directory

 doc/group-names.txt            |   1 +
 src/Makefile                   |   2 +-
 src/precontent/Makefile        |  26 ++
 src/precontent/mmap-validate.c | 227 +++++++++++++++++
 src/precontent/populate.c      | 188 ++++++++++++++
 src/precontent/remote-fetch.c  | 441 +++++++++++++++++++++++++++++++++
 tests/generic/800              |  68 +++++
 tests/generic/800.out          |   2 +
 tests/generic/801              |  64 +++++
 tests/generic/801.out          |   2 +
 10 files changed, 1020 insertions(+), 1 deletion(-)
 create mode 100644 src/precontent/Makefile
 create mode 100644 src/precontent/mmap-validate.c
 create mode 100644 src/precontent/populate.c
 create mode 100644 src/precontent/remote-fetch.c
 create mode 100644 tests/generic/800
 create mode 100644 tests/generic/800.out
 create mode 100644 tests/generic/801
 create mode 100644 tests/generic/801.out

-- 
2.43.0


