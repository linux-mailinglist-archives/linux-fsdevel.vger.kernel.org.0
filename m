Return-Path: <linux-fsdevel+bounces-29711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68B97CAB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE96B1F219AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAB19F46C;
	Thu, 19 Sep 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSf3htjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4519B59D;
	Thu, 19 Sep 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754781; cv=none; b=CpyV+7h9CWrAblL9awTGg7wLL1quJveH6IW9vllq3pkitTTlOtiH8yV77gr4IkbXqk/j/fdp9hZyi2NQx73IvCuUplQixwKNykMCHWDcTRUgXUS+sE4suQvkz3tTx0BPhYuNWMnNVZUEmjoTHiwSsHtgVIfrBKgeJsK4y2c6ajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754781; c=relaxed/simple;
	bh=tyPNWJUTxAw4PYTtIiDEFPLbPvzP/omGxXJINUksoaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAA1rTnWGfnfSuTMcndpAEFVh9WYjptQJpWxMr3cKDXqRGH+E07YF9/TiOBcMtqnt1MBqWnM6qYCpmAqZg1MCGI4XkSaQX+j8VErkZTgBcAVT2ZrCqpjnY9KVojR7+3B0oXr6r0z0JM0zbP5uMBs+gOB3DgI+29mvDFTKlA6abQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSf3htjv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-536a2759f0eso1132822e87.3;
        Thu, 19 Sep 2024 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754778; x=1727359578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nFUu1Lm/TA49yAYnHi6fn//+2AUGCtCFlyf+jhldFE=;
        b=hSf3htjve2yiN1RyjaMNKNDnY5pgcxwiVZGKNyubhy0hdTdLkJ9K4Zns8EXYxO9uKr
         VMZ/06QZL3Hq8026ItWfO3v2xmXN6zAlP8lf8mpU8LwYUXoHOn/Iyd1Sg+soBgKVpuj0
         uE32SxuP+206xF/057zVQROyOW3wb9ogiVLzIwDNxejJW8N4RXL6Sz0f+6erMPND23UW
         8yAPP0Rob4ftX31LoDDc7nvPwgpUbM+PzcTGan1Lunn8UTep37zp7tvAus+ZmXh4sAEC
         fiWMh7yui8Tv2fzm8vP++lZeSkj+zYOu1W/auXHbSHMWOosnfFvb9y9OHTqjFHosEktH
         E5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754778; x=1727359578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nFUu1Lm/TA49yAYnHi6fn//+2AUGCtCFlyf+jhldFE=;
        b=oFB7Wj114J3ijh4l3lsQbCAjVMPDijMC6W3wjsh52hbTvDcIvu0DEJhMAaC6PUB7et
         jz/LIKEyIyiGU9WfMv7wuBQCsCd41ZVPSwpGW2b+yAI9RtiVo66lqkQWeNMHNB1bpG6n
         UqXwZ43LLChP5svheS3BFKcDJqkoX/IhlsZBzCav7cA0qwRJouPq5DNYgiIVQVejq0Yi
         al/bw8XTP9lRJUZWpKIB0pzcaZXlkNhmBtlHTqxB8BgvDGomr2/ARZaIpob+rNWzIh84
         8xvbHhWGqfStplWbxZnWtLbLLZAMND2uTYkdsem4slB2XyDLPJGDRymeviQsxxLORtPQ
         NOig==
X-Forwarded-Encrypted: i=1; AJvYcCVEGlKSqxRDwEDQL67E/AFkZ5iZCSY1rNZfTMqzTIdAqcWvKd12viQemRy7R5ueNQ72ZbvGjCSjqUrSGSp7@vger.kernel.org, AJvYcCW2JvrT0oo2ZesB1h52gh1IAUHKYXr+RnagQ/inDj7j+WwgdV9GhJvrcMS6UhnCosadLjM9NFK0uzVd@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOQlNk3lK+8+nOCgYaOEY+PLGC7vWrfcvFt26OsB14XnsnjaH
	+KAmDS1ysHapBNPIZroIFopCWpTLrACIpqtOt36QRKDj5V+4ukAA
X-Google-Smtp-Source: AGHT+IHmk9ZJR9CZAp10wp+ZW9Eg17WM9stiQLYTQPsL3sM3WwaiEug03b/U2eBr0HE561XdQSZFJw==
X-Received: by 2002:a05:6512:ba8:b0:52f:d15f:d46b with SMTP id 2adb3069b0e04-53678fb6de0mr15008070e87.14.1726754777175;
        Thu, 19 Sep 2024 07:06:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c1fsm719503266b.206.2024.09.19.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 07:06:16 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/2] API for exporting connectable file handles to userspace
Date: Thu, 19 Sep 2024 16:06:09 +0200
Message-Id: <20240919140611.1771651-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeff,

These patches bring the NFS connectable file handles feature to
userspace servers.

They rely on Christian's and Aleksa's changes recently merged to v6.12.

It may not be the best timing for posting RFC patches in the middle of
the merge window and during LPC, but at least this gives you a chance to
gossip about how bad an idea this is with folks ;)

I am aware of the usability implications with connectable file handles,
which are not consistent throughout the inode lifetime (i.e. when moved
to another parent), but the nfsd feature does exists and some users (me)
are interested in exporting this feature to userspace.

The API I chose for encoding conenctable file handles is pretty
conventional (AT_HANDLE_CONNECTABLE).

The API I chose for decoding a connected fd is a bit whacky, but if
you let it sink, it could make sense - my use case is to examine an
object's current path given a previously connectable encoded file handle.

By requesting to open an O_PATH fd, relative to an O_PATH mount_fd,
I would like to get an error (ESTALE) if the path connecting mount_fd
to the would-be-opened fd is unknown.

Thought and flames are welcome.

Thanks,
Amir.


Amir Goldstein (2):
  fs: name_to_handle_at() support for connectable file handles
  fs: open_by_handle_at() support for decoding connectable file handles

 fs/fhandle.c               | 85 +++++++++++++++++++++++++-------------
 include/uapi/linux/fcntl.h |  1 +
 2 files changed, 58 insertions(+), 28 deletions(-)

-- 
2.34.1


