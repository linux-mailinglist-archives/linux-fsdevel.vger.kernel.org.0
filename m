Return-Path: <linux-fsdevel+bounces-60374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE65B46415
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3A93A63FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C027B50F;
	Fri,  5 Sep 2025 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="3F3aTWeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB1BA42
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102509; cv=none; b=X2mKVL2eqwwJCS9ffW44GyFK3wHeQQe2yn5atIxUnhr4QKDYdpiME32g+HIUAYovlGy9krrMCkF/mADpAV8mxzQ//yHGhEFO+j8tX+63AAGvptHDB1DcwlAtDtt66+4nkhVwZmeGiNnadwCLG2/WFb/7J53zCi5Ucw9JG9a7l4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102509; c=relaxed/simple;
	bh=CIt2rudRtW4UBrSZeLFjRUpcL/34sCPSMHO4G+HzerI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izf/+snUM+2/v90bYIMw0vcCLXONk6Fuo8MwsK1TvcmEu+H8vQ3FHfyASaJ9SvWAjxeXa85f9BkKdoSslth1gLJVki7Kp5PwnoP/NedGUlM5cyNHIEbz0aWoUHDvciAz5sHVIGSR1Jy2sqcQL1dIY6K6PUb/4JW5M2aE27+H1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=3F3aTWeV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d6059f490so25598597b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102505; x=1757707305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOy/Lx1hali3hqni7ugXsZX+qSqE1qh4LpVXkqYzo1w=;
        b=3F3aTWeVRG9DQesHQ95dW/ZLjipg1N52Qoxfgnc8uk1S3x8ne6qRrPGapWfCDB2Mpe
         /ckbbbTu1EJTh32mawJFf/zEVAr4UwxQMJ2mm9L+a+ZE7HQ3nmt0DyaonpDrqcgUIa0C
         bN6NtVTj4GyDa5g4IqMQedCS/P2NsAJlh2e5DkaQq0OPXeG5NiqKaUP0pocUCasvSqQY
         umwwgltqis3VwpLY0X+pWaQnr/rxJuYho81CeAV2nsuv+hhL0qlbIdXp8TN33KKYV6wc
         b5STtHAH0ep6mymockMqm0Ezcf8jp2gN0g00ATux1X/889KvmyQ8DJfQFVGcH5nyDPPn
         fqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102505; x=1757707305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOy/Lx1hali3hqni7ugXsZX+qSqE1qh4LpVXkqYzo1w=;
        b=q8KQx23X7l2yJ8J+swP5mwtAI7aG9Hc4o0Ip1/b5BMSh3U8ZVvpzssWpdjLrH+kLJK
         NO4hZTvhUIMk4OfAjKmMlfH6ZLWOTtVw6Q10evl4ri13gT1iGYYJzB998Ct4WpIv6tL4
         2ZtzeHhKjnQ/vesIdsckmKb9wJNxjnKXQKvVlImiBH0gCf2gVJhAamRduqPGJgqQX/Sf
         yZfAv556SOOjdkVOJIrouy3ZnrN7pAz+Lj5f4SkRpiBhureHfdkbJy7/eWGroou917in
         Sv3RtgZFFEgKVZi+t9K+soq5TqeCYTx79OB4gbHRrGcHXnolcXnBFsVWnT66veC+O1Py
         c+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/ClqAi1ttwzSX5JWXcOSl/MG05zzPpcTLJdV/7CtcLBinVg6z5VTfwAgsOW19gjwyLYcVx0CS+RiaQxt@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXXOl4ZSe1gJhgYsTldB2AgzyK8yxQsKeRaZr36mruM/SPNho
	vCoXcVun0TYjdCigzlmqSB7jO3xdaHwhUKlsiI9gDWuY+cqc1DaH9FQ8cuhaLOPPXcM=
X-Gm-Gg: ASbGncvXgC7D4b9jaRWTvWza8qbxU0n8WWsiwrhC8f9b2hWHkP2ZPPfwfzZHSKCTzRm
	6Tsx7oMNwGIDsIrrSNISF5N1xCQLuO6ZTmf1ML9Jh7bQ/7AHH4oZKnu5u73DdR0vg8SBMbPeZ9E
	N5SgPQMm4Hayb0dbaZLtOgHlewei8aEm0lfT1MS/mRj8Gux8yKuPgzfdSFhqJCUPE0cubPWAGKz
	0q+pD+opSr3q59+/9jR4sJ2LUIjFi2FPZnfb6f/NTw4J4wQUCB+WurXvSNPxv0niql8NdVijKcV
	hH5EMJAtowhAILIC5VLhiCsHEHMxmNB5D7qCWoj4mmPg3IX7lq8F/7n+l3NA1C3zHMYkuGopvZJ
	YQxJN3LMVrfBfM/h16jIMIcnmTDv0tWF0Jra6IPb4gXM6LDmM9N4=
X-Google-Smtp-Source: AGHT+IEr/a6oBelU2QV3zVFEFZ3TC++egfhB+J+cNPqYIHA9Iy874iEk3OeK+W4CA42HPxHoko/Auw==
X-Received: by 2002:a05:690c:620d:b0:722:875f:5ba7 with SMTP id 00721157ae682-727f6b21ff2mr1152567b3.39.1757102505276;
        Fri, 05 Sep 2025 13:01:45 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:44 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 00/20] add comments in include/linux/ceph/*.h
Date: Fri,  5 Sep 2025 13:00:48 -0700
Message-ID: <20250905200108.151563-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

Viacheslav Dubeyko (20):
  ceph: add comments to metadata structures in auth.h
  ceph: add comments to metadata structures in buffer.h
  ceph: add comments in ceph_debug.h
  ceph: add comments to declarations in ceph_features.h
  ceph: rework comments in ceph_frag.h
  ceph: add comments to metadata structures in ceph_fs.h
  ceph: add comments in ceph_hash.h
  ceph: add comments to metadata structures in cls_lock_client.h
  ceph: add comments to metadata structures in libceph.h
  ceph: add comments to metadata structures in messenger.h
  ceph: add comments to metadata structures in mon_client.h
  ceph: add comments to metadata structures in msgpool.h
  ceph: add comments to metadata structures in msgr.h
  ceph: add comments to metadata structures in osd_client.h
  ceph: add comments to metadata structures in osdmap.h
  ceph: add comments to metadata structures in pagelist.h
  ceph: add comments to metadata structures in rados.h
  ceph: add comments to metadata structures in string_table.h
  ceph: add comments to metadata structures in striper.h
  ceph: add comments to metadata structures in types.h

 include/linux/ceph/auth.h            |  59 +-
 include/linux/ceph/buffer.h          |   9 +-
 include/linux/ceph/ceph_debug.h      |  25 +-
 include/linux/ceph/ceph_features.h   |  47 +-
 include/linux/ceph/ceph_frag.h       |  24 +-
 include/linux/ceph/ceph_fs.h         | 792 ++++++++++++++++++---------
 include/linux/ceph/ceph_hash.h       |  21 +-
 include/linux/ceph/cls_lock_client.h |  34 +-
 include/linux/ceph/libceph.h         |  50 +-
 include/linux/ceph/messenger.h       | 449 +++++++++++----
 include/linux/ceph/mon_client.h      |  93 +++-
 include/linux/ceph/msgpool.h         |  15 +-
 include/linux/ceph/msgr.h            | 162 +++++-
 include/linux/ceph/osd_client.h      | 407 ++++++++++++--
 include/linux/ceph/osdmap.h          | 124 ++++-
 include/linux/ceph/pagelist.h        |  13 +
 include/linux/ceph/rados.h           |  91 ++-
 include/linux/ceph/string_table.h    |  11 +
 include/linux/ceph/striper.h         |  16 +
 include/linux/ceph/types.h           |  14 +-
 20 files changed, 1907 insertions(+), 549 deletions(-)

-- 
2.51.0


