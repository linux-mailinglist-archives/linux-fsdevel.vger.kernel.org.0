Return-Path: <linux-fsdevel+bounces-32905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4C9B084A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8071F212EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4FA1422D4;
	Fri, 25 Oct 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BV/VLkhq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26C6F099
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870223; cv=none; b=Ju8k62zqIOQjCdGFP783+z4uFVvc09ZUUjlHqzKGqrYz9dDhDgubGMQ7zAO09kI8k84IcxHw5OBScUO1grxuPYrMv2PhIN+T0o2hfNP/qFwv1z9hEErFwoVwjmfe7vlkTTzknAI+4ZGMQgrjoBlboScmBqG2JWQ8htiwwsN3VRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870223; c=relaxed/simple;
	bh=NdKEYU7SSmomiQox6PG8vZzeDfCa97hRQnFFhOzpm54=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K0NGg3ac0sBTxcuFtry9mjTUWOPvdsHsuQBkozZV4YVBo4NJNqRJMg4NqoJbpz9d1nK0AaXsxG/ge6mAOdf89dCx7XpZPgIWUDKMREp6FSA52ocleM4s36Sl0qcWRuCv4pRvFFoo39KkMYBdnHhqoWdyKIG1L1OZQjmSfghF2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BV/VLkhq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460dce6fff9so14678501cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729870219; x=1730475019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/0gSt9Zn5voS0xYF+67Tc7RHamS0uLc55qNVJevcTg=;
        b=BV/VLkhqaFKjdf6lWrfAjTUpewRJYfdpbz9SBGiBE08cCyXoYYrDnSRK7FW5l8Pd2I
         sdD1wbOxtuo4Wt/uK4RV3+tlDzeG/dRI/RmxKY478pZ0w47vBvO5+Ql+w6Bl5A1kIuTa
         x4Q9stcoMWsvq8ZFABu+tWxNAgqeFVpftrjP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870219; x=1730475019;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/0gSt9Zn5voS0xYF+67Tc7RHamS0uLc55qNVJevcTg=;
        b=NajPeJhLEaUw7+DKurex2eV7C40qc/GQTwvZ6Y3ZVHrmC2cO+mz5mmwUIKXM2mT2Qd
         QECvZE1OhJexUkVtfGEiAi91avCesmnjGkfnhURvkMOgweFCU2rwssvd2M8Sf1GUpW1H
         YPP1/cCdKRpdS/K9XEHoqZNCAPsi7K5EJEt8NQiOvah4p7+Oc3aX+gGim4y8xcPyesiV
         ViaCkLCDYUm87WhCGQ+L1Sb6J9vdnXtCOU2avkua/YvCz5GMdBTnweiwgdESklvarNyP
         klS6avYazdL/yWb3fQoTUz2X8RKdEdfeX+LotFx0GW0/GQdGzGHZcOxlW7TbAPSbVoO+
         luvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMYlLpi/CZ6pycV4q2idEZDV/Yy0GTC/0JUoUxWEHLVdee9ps0yl1W4k7B6vULdxzQwcD9TAr0LxE/p5rR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BU72HW3D8wNLLv6E9cxJDHMcY9SjaN991O9nDN9Fnxa0AdoU
	EGUDOKmX0SovHHOv9tDN00UHo5J/R5So+Y8LSDSVB77MnwWS3vfeLCqkTtyXn0UPQASwAdXTeUz
	jJVrzm8HTqixzSCoqs5cfVHXNbJ44JwLXOVnGPw==
X-Google-Smtp-Source: AGHT+IENPXL5kBY76KVgzzN5iP+92toLqFuO5GmVpaPEr/KAjSQrgUt7sY9WE1S/LY2aq+ByXCkrXVad7005xbl9STI=
X-Received: by 2002:ac8:598f:0:b0:460:e633:556e with SMTP id
 d75a77b69052e-461146c5a31mr130256971cf.30.1729870219255; Fri, 25 Oct 2024
 08:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 25 Oct 2024 17:30:08 +0200
Message-ID: <CAJfpegsjHymOXg++KGrwMUWAP4e18aqWCMC2e83hLBy2AvYZyQ@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.12-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.12-rc5

- Fix cached size after passthrough writes

- Revert a commit meant as a cleanup but which triggered a WARNING

- Remove a stray debug line left in a commit

The passthrough fix needed a trivial change in the backing-file API,
which resulted in some non-fuse files being touched.

Thanks,
Miklos
---

Amir Goldstein (2):
      fs: pass offset and result to backing_file end_write() callback
      fuse: update inode size after extending passthrough write

Miklos Szeredi (2):
      Revert "fuse: move initialization of fuse_file to
fuse_writepages() instead of in callback"
      fuse: remove stray debug line

---
 fs/backing-file.c            |  8 ++++----
 fs/fuse/file.c               | 18 ++++++++++++------
 fs/fuse/passthrough.c        |  9 ++++-----
 fs/overlayfs/file.c          |  9 +++++++--
 include/linux/backing-file.h |  2 +-
 5 files changed, 28 insertions(+), 18 deletions(-)

