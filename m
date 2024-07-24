Return-Path: <linux-fsdevel+bounces-24177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8093AD03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01BA2810C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1924161FD4;
	Wed, 24 Jul 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZwC+6rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CCD29E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805129; cv=none; b=KShy0Kgq2HWQ2lai0Ns6mcc3aWw3JbRjcICHg4ov91Pxr2KMogCrZMJx6Tk9d3iA42ecybzQjmmjEmasn6PyMZYSKUaOAqmKtEX7hIam5mEg++M8jpX6dNYw5mLnFTofADQ9XnBGYJmGFiCnRWNBgyUJMptPqYOcV83BOl5vktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805129; c=relaxed/simple;
	bh=2oJJ69qtzuLZ3w8wPW8NKzeCExwIaxgV4Sirb4f34OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H6wbKsfcLCytnw+vag5COtUnqntR8LpyyvPFZBabpEQXaIUacroaBc1E+OUU1BJRj6obKww4W8MfpQx1vaN6BUVukuEZGFVCkgVPjNQyHVDe76daTk3q3rdwmGBKZIMDPhlBwDF7P0AaFq69Rfg/p2moWVBNtNRMwmFISHAdcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZwC+6rz; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8111f946f04so250541239f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721805127; x=1722409927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA4khZWeOIwK8nRkz2uiW9WZV8Kpp+rXLuVpSD/FKYk=;
        b=ZZwC+6rzuyX1Re9DGufPwz/yogz6Ro/nM5x4DAYlVI+2cFqkMPYakxuOlr/akMaY/G
         kti7g7rlZctssvvfWJf5YW4lLqHZxRezjKQlSamtPkkqvM+bHd+By1GF07EuNbVD47qj
         N24Jcv+DeSIF/tCAFI9iex+4VLa+KUj4yJyM+sf1oBmQd8D1WN9nYpwl+c0y9shfEDjM
         opd6qoAQNZkzkwOgDlQmWGjJ9l/OHa+D6QELsCxwIuCDp6SzLV2I2lzUhpA+8X9MeTZ3
         VkWN70YdfQsTEy3CmKOFj5zeF2QMbJYLYcnEqzNO67pyTPRcMBtOIscR3unnvkKz5zyf
         wCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805127; x=1722409927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA4khZWeOIwK8nRkz2uiW9WZV8Kpp+rXLuVpSD/FKYk=;
        b=sOj5fPCt7LRqyvfM1xH5D7uj6tcjJD4i54973qqUAczgTbhgMSfCwfZDYPRo7Y1nDU
         DJJJKb54KWLZZkQLcEAVK9Ey+RxCcclvGNLEw3gsWQMnMoEvZdl18t7OuhrSdBQ+Hcp/
         Cq5gM9ECZL3KMnZQqxx+4PpyuLGb8igqPf29K9pr+QHAnfay3YtLBD+jylAFHmvKTdZy
         3B3cQpDU4xWZiARj/TZk43ZnGKfjIhkRD4LjFMtOAZHSWLhWfRRnsd8IV//iNcH+MU1S
         1qGWzFItYqhVPjXMyyexlm8azKSFilqpadXvsN/XTh1247U8yh7EYBq3G601cisddbJW
         kZDg==
X-Gm-Message-State: AOJu0Yy+WDKZdxeCItl1N0ol/HGeX7yu3uVHrqaIamT/N1a/LELsFaA6
	YgJzR4QjNhbNuMrQHackHktz9k4pdflca6EQF+wbVcOxBgKxG2KIOeDQoQ==
X-Google-Smtp-Source: AGHT+IETw/9rU8gbE5/OGUpWyJcPdQNE6spUjoL/CCPbq3c6piZ8VvieZLaD+MNlVfulGcAPe6x07Q==
X-Received: by 2002:a05:6602:6d13:b0:805:23c4:490c with SMTP id ca18e2360f4ac-81aa763717cmr1665776439f.15.1721805127138;
        Wed, 24 Jul 2024 00:12:07 -0700 (PDT)
Received: from localhost.localdomain ([117.136.120.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a2163d7d3csm4096841a12.13.2024.07.24.00.12.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:12:06 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/2] fuse: Add timeout support for fuse connection 
Date: Wed, 24 Jul 2024 15:11:54 +0800
Message-Id: <20240724071156.97188-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, when an issue arises within the FUSE daemon, the FUSE connection
can become indefinitely stuck. The only resolution currently available is
to manually abort the connection using the sysfs interface. However,
relying solely on the abort interface for automatic error handling is
unreliable. To address this, a timeout mechanism has been introduced in
this series. When the timeout is reached without receiving a response from
the FUSE daemon, the FUSE request will terminate with an error code
returned to the user space, enabling the user space to handle the situation
appropriately.

Furthermore, the timeout value is configurable by the user, allowing for
customization based on specific workload requirements.

Yafang Shao (2):
  fuse: Add "timeout" sysfs attribute for each fuse connection
  fuse: Enhance each fuse connection with timeout support

 fs/fuse/control.c | 50 ++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/dev.c     | 57 ++++++++++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h  |  7 +++++-
 3 files changed, 104 insertions(+), 10 deletions(-)

-- 
2.43.5


