Return-Path: <linux-fsdevel+bounces-23424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F51192C26B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C53CB228CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C278C83;
	Tue,  9 Jul 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Eyc/Ogj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DB15886B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545977; cv=none; b=WIG/1oxMpRj4iATB+2C52XFkgoSZoXv9r62v/DfD3O2M0OwufqnLzy8rpybjDegai++98EClLfm0zq9ycQb5qN1g8FhzmZZkic+atU2pRD+cfi2uSdO6H9w/iEqUJxG3No2yYgX9lwDAqBo9EgzMPgEA8xirgR5iPo7KnRHJIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545977; c=relaxed/simple;
	bh=ANkSrrv4ScO6qWavb5OUztt0A6to5bgj4/URa2V+Wjs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VhFOL2bkv/4iaQwMg+4VHafJ8tk9NEtYHwPSu3O5KeuaUV3dq6N+0OCcPyCtpPZPQfpGWcw7CB0tnsSrlKRGKhvwqV4N/RpDmHXkJaSKCudHbYyWImc2/DsJ/OzhGgnf/+7qWiRxljMxwyKp8IXT0nFJOUUM5l9EppbxlahgwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Eyc/Ogj0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5def3916bso27833716d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720545974; x=1721150774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5zeumC0NSb8T/WKRDCT1PvfNBJFN4DOntoCOW0mC9g=;
        b=Eyc/Ogj025+ujm+SjVZGI+vx07JvB8jprdETKDeqnJxbhaabLAckOMHms0IXiMcC4P
         f19lcDD5cDrj4yOpeEDHWYnFTOSIfhusy0z9HA0LlQNEHuTirpApBlbujNkBleWHmOf/
         haWelcqv9HjaVdrFvTxlHqdup58XMj8YQSG7I52flfAOBq4tq6PiqDGsfqermOdz5kZO
         5zdo2L+aKrlWlUnvzOnBNa1/yvYnBylT//ZODTcg9PISIZ8rSxani3jX+QY1lUvQ+70l
         LKyhoKbPvKADiB2jqMxg+zpZxJa4YQ7plS2RMf3afKr3Tc1pvTKWuMEouBoR4A8aq/Ul
         bs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545974; x=1721150774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5zeumC0NSb8T/WKRDCT1PvfNBJFN4DOntoCOW0mC9g=;
        b=VlfyX4cnniB33QflGMfjQjuU0oW+xEB+S9Wtju7/KmXVxWrXqrhRYIgszQgJymDPn3
         CUmmzrHCDcq3AQE+L5dli3DXwenTBYeVkDGs8vAdHQcFQg5Sx1SsmeruRivf9dSmt4i8
         vY8uAUaAs+M/iXx5epwqcf1xPncS+UQW1jfBtCQjdt642Pbw82At/b3vBXMyDOHMbLV+
         EZK3CpWGoGinbG+Klgc+uLzcG1w8X5L2RlskaLYZTfxzs7Qs8Tbqot19gW1UsUrOcPxj
         FLDuddUiRk7dwKBm93oz8LvHZxUk8yjA4s8WLwcub57FbOnUD6NSZYC9/lUi3RbgGkou
         DYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLtsBEcUYnjUIAXTHX2Rm+nkDvkaR9SIabMBncgmU7Vb8hkTaJnSOGrUGj9Xy/0y5j8Ye9PMeq5hFl40WsSgTfYQNJeLo8WWuEkWYfg==
X-Gm-Message-State: AOJu0YzyBDVW64Y4ICVYAE++2pE9IoyT8LeCSZkQ0k9dhQxMZAUfsLXr
	oqQJVewkScVLdP+bN7o4NWuQrTuGeFxAWZ0SeCjYkUElGfe7Nr1XIBpII9f/zOc=
X-Google-Smtp-Source: AGHT+IHbJbJe7Rx7qH4gUCepFBkDoWzLxn6HMiEAkpQsd0GlXnH7yBhA1FGdzELmXKXKhRERKdwu+A==
X-Received: by 2002:ad4:5f8f:0:b0:6b5:4288:7e94 with SMTP id 6a1803df08f44-6b61bc855camr46649846d6.8.1720545973807;
        Tue, 09 Jul 2024 10:26:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba04c16sm10329356d6.60.2024.07.09.10.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:26:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v5 0/2] man-pages: add documentation for statmount/listmount
Date: Tue,  9 Jul 2024 13:25:41 -0400
Message-ID: <cover.1720545710.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V4: https://lore.kernel.org/linux-fsdevel/cover.1719840964.git.josef@toxicpanda.com/
V3: https://lore.kernel.org/linux-fsdevel/cover.1719425922.git.josef@toxicpanda.com/
V2: https://lore.kernel.org/linux-fsdevel/cover.1719417184.git.josef@toxicpanda.com/
V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxicpanda.com/

v4->v5:
- Described bufsize.
- Moved the general description of some of the fields to under the field labels
  themselves, and generally reworked everything to be more specific.
- Addressed the various formatting/wording review comments.

v3->v4:
- Addressed review comments.

v2->v3:
- Removed a spurious \t comment in listmount.2 (took me a while to figure out
  why it was needed in statmount.2 but not listmount.2, it's because it lets you
  know that there's a TS in the manpage).
- Fixed some unbalanced " in both pages
- Removed a EE in the nf section which is apparently not needed

v1->v2:
- Dropped the statx patch as Alejandro already took it (thanks!)
- Reworked everything to use semantic newlines
- Addressed all of the comments on the statmount.2 man page

Josef

Josef Bacik (2):
  statmount.2: New page describing the statmount syscall
  listmount.2: New page describing the listmount syscall

 man/man2/listmount.2 | 111 +++++++++++++++++
 man/man2/statmount.2 | 280 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 391 insertions(+)
 create mode 100644 man/man2/listmount.2
 create mode 100644 man/man2/statmount.2

-- 
2.43.0


