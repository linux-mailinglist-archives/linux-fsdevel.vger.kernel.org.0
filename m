Return-Path: <linux-fsdevel+bounces-15614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD55890C16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1321C31184
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4AA137920;
	Thu, 28 Mar 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8L8692o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FE128369
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659515; cv=none; b=IQS+bmIcdry/ODlkOv+GsHti1dDRylWGAWdx8Gro/4/GkK5pKcvHwm8Dh7dChGrekWMGqtWHsfL8TUlpuRTtDqg39jybbi7AnXQQSNFAZE31kgdINeKr3T8Q4MoQGDS4TXgSc8o//JmtCA4eI8a+Kw7+GdwhMFf0xQlW3FiWlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659515; c=relaxed/simple;
	bh=fdLZxHH8IWfB+w9U5nenQqjjtPCSqioPboSJa0ViRzM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=syAdvPB9d+e7O7UgUaxRpm7kabY6EnaM3+hrcD8ytRAWnZdjOAS6DV+XycSLqT/u8Z/Rdj+RLtX6Z38nobfYA0hpYJBtMXIlikz3r9Kyi9W5ce4J9BCSU9fzLKQ8sGPz7hi7UOLTjYmrrL4nhujhuFsBSIdhkdj5MXFnaOqfwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardfung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8L8692o; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardfung.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-614326753f1so4637127b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711659513; x=1712264313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fheqdSknqdFVuavegXLD4EaWL6dOetw+hMnofY6rkrw=;
        b=l8L8692o2t7QZM5iofRToxQlgCCfX1MCXNwDb/ZNGx1OLOXQp1PYK6W4RJWZfP9NOj
         4MMcHQK+nEYuawxjYFBJEjB7p9eqcfKHjotbfQjNwvnlSEvWLKlgSosJ7Im3SuSS4T5k
         lI9Eg7Fnlc8DezOghwkUDJWZ6aNJ6s0A/RNU0Azkxulakw4kfpB+W4tmDNtLA0cHi3Eu
         gyMRhZhbrnOfRoV3gN0jx8/Z5hWGBmLL9nxR8sJxGXbCA37s8B6pgDVrmzmzBDKNYx2y
         AoY2dPuvSCevPTYmRlr0DpineJXmMyPZPxsY4PdyQRGwevRG+wjLxSHACUMNzKrDHMzP
         eIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659513; x=1712264313;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fheqdSknqdFVuavegXLD4EaWL6dOetw+hMnofY6rkrw=;
        b=u9aFXTm48y1gUy8A2TIlvOh51RsLCJiMrBHzNegmPtfYJxwY4PLWB2g4MqOO+c98Je
         ihU7gDnRMRbybcaomwP80J+etum7w7n0yCDfTwIVd7InDUA5Q3fw4fAMSaQJoDALmIkr
         06C7z7WfVZxWMf/RySv9B8kfqUAqOjTNQky83wSo7SVSD5pP3DWnxIINAdTQ9a9ZIHI3
         FbgzfzWpXssMk6bTSgV1QQtbGXo+EsGI1wR/lZsJpEHlwYph+vm0pOiHlDZEw32Gsqpp
         KQ/8RIzgeBE82D6eF3+3OttInaX0jp/7dRgZY7YCw0HYS5CAM841hyNrSx/7+a5FysOT
         9KkQ==
X-Gm-Message-State: AOJu0YwNRYPJHhYFTy03HDMTm4SOENfG/Iubez79Fq22B0pihofL/igL
	1rQq6GMsfih7HXq6rpxHaBT6vu31ct8bQp6JRt/vMAf4g5LR2B/vnwATFf24kFWyRx7ajWaUzdC
	LojvZJmtS6b3tNGH08cGYcw==
X-Google-Smtp-Source: AGHT+IGnOUEBw3tybFRy2Fpkvnd8HmDr6HlIYkliAiGGbxihuAvsJCXRThSk5YMU/I0y0ElRUvWl71Xggv7YtiyMWQ==
X-Received: from richardfung.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a5c])
 (user=richardfung job=sendgmr) by 2002:a81:4ed6:0:b0:614:23a4:7b98 with SMTP
 id c205-20020a814ed6000000b0061423a47b98mr123433ywb.4.1711659512799; Thu, 28
 Mar 2024 13:58:32 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:58:21 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328205822.1007338-1-richardfung@google.com>
Subject: [PATCH 0/1] fuse: Add initial support for fs-verity
From: Richard Fung <richardfung@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Richard Fung <richardfung@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi! I am trying to add fs-verity support for virtiofs.

The main complication is that fs-verity ioctls do not have constant
iovec lengths, so simply using _IOC_SIZE like with other ioctls does not
work.

Note this doesn't include support for FS_IOC_READ_VERITY_METADATA.  I
don't know of an existing use of it and I figured it would be better
not to include code that wouldn't be used and tested. However if you feel
like it should be added let me know.

(Also, apologies for any mistakes as this is my first Linux patch!)

Richard Fung (1):
  fuse: Add initial support for fs-verity

 fs/fuse/ioctl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

-- 
2.44.0.478.gd926399ef9-goog


