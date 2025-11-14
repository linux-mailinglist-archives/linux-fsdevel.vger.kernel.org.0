Return-Path: <linux-fsdevel+bounces-68443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FCC5C466
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66E4235D08B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8EE306491;
	Fri, 14 Nov 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AMh70ouL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFD306482
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112136; cv=none; b=D6cbkfka0W7+yhRACPZBsVmWXHl4GAHIEyRu7JiSkf+VrzIxW3oeR1smSXbYO82yYq99VF11ZzoPJIGcoGpeZ6+vPfbLhiiEf0oOrBpxEPWBggsOdT+lDU52AGRiGhW4PHDzD+zcaat80KYzbn2AJJcrgptanmwLXL1Tom+1orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112136; c=relaxed/simple;
	bh=3yKmCrbAdSfO2k3GcxeDVFzxOqz5BImDvVOtgCC29lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mBaQ2Q3LXqnYOvIxyE60gTIc2H9UNYD2yswmulAQZE54X2q+0hGPpLWg/BAcfZ8Neb4glXYkpA08huXxjqdHqWCpxXBMrFkR2HQ8piv0XCXqck8ovP+EXYg9Hy0aLGzeWBVKA5j+sRRtHRptTzRI1JMbnGGTy/jWAZvflhLwrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AMh70ouL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980d9b7df5so16576145ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112133; x=1763716933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=AMh70ouLRszzEBY6WQZeYRCj1O4XxwjqQOj8XGUCFBNcIVfE9P+bAcsy2QMKVHj7K9
         zKbMYwESq3+4J54eIW4h3ofW7+19+oCd/fLKVhgapYb+uhhHLzelhDc4IgjX9UVvF6P1
         V9Y56unZ1bsHJVw+XjvEo/DE7yFD5oj2sj/MTlGWq8XeFuAK6QMQa4tAi+t/HJbyBa6t
         6kM/PBY8BZjkSugTDlP9ywabgXtJY1Vic7CpMnYC9gxbx8IlwrK8GbmFE5MDXQd/IzzQ
         rU04v3dxv9BW+RpD1IXTckglzGgKNaLSxTCH+7AIBe5CGPQVZagLUUr3zgE1vzn4bzdR
         r9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112133; x=1763716933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=q7Ssx5a6+3JXHHhSH645bBOXEqkAQdR1xAYWZ/mSfXL48LfAzLxE6jgogOGQENK7N0
         cRs1OUlN9urwG5EOuUSi2zCx3Dl1Qe3iyNN5/qOY9sir1X34SjoKikh7rTsT9amnclHs
         cVsN4VUxgwiw4vHTB6iI2aLtN7wnzpZ58MQMQP/KagEfdoeKZ+3IS2bBkcj6KdDsZMbL
         B1jXEGlvd4w5DxBWPErX351FN5XQjqfyKoKxgZxs6opNoZA39+s545mXNRjt3hk6xo5j
         Kmse5pgPQaO+441nYakFDBTA2N1DVHsLXhSohJ6R/U14Opfj3SUpJUOK38j1X7Bd9dWs
         PtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcosBzMoaczt9BU4Ba6wRl1540MhtU9UvrdKKB7AKNDimO0LTZxrZYdR0N4VaEwubv+C9zxAGnCgmYblp2@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFFyZt7BSruM9vJvWz1wFl0k9gwvc++s/xCUVamyQ6I0DVn12
	mTp10OWZnphUThseVg1No3/JjrRtJBdBFKumZv1AKY/1blhkJmfOoDXUAzfmlJQy31Y=
X-Gm-Gg: ASbGncvUBpaXjNtBMQLgdF5jju2dl1khqKba2hRZ+I5woQMKMu1zt2ty0hA198N8drB
	ZVx58lsbZy/gejCVB9qRopyf61eaHIIq/Llfe7Jga+iEwvobCfbSEYJEP8ayvJ/e48PN3HQOa2F
	Ts6pqVWwFHv01msXenSO6cBt+nrPX94I9ggSCpLwsyEO7a8Rkl/puUJxk3kOqisI60n8SXGu+ZL
	a/ws/utMgjztl3Uh6e1e91D8z37j2IYIteyv27BygeW12Jk+ZnLf1S8cHWBCxaf3BI2+eBNcumj
	V1IwrW50ltRBlbyD9/xexbfXg97O1YVpJn0+yquGWgJGYasFFHuM8YLWVOyKefjdbNMSQlWSVw/
	otoZghmeeAqlP436DOLI0ulFIfEb+uYbtN+vfn8/YEXMR9bqNZCxAA/tww9oAL6OVIl+Eam3Wn8
	Qt4q7FR0m/eRzF2zJ1ae/Gq87y6dlqKzlOhg==
X-Google-Smtp-Source: AGHT+IF+L62VoDL311ziY3WGmIGqOUF1aAOhbYoj7EpJUNyw6PsD2tlvnXHX5j5jjprmk+4XNcS2IQ==
X-Received: by 2002:a17:903:198b:b0:267:a95d:7164 with SMTP id d9443c01a7336-2986a76b6c5mr23867635ad.60.1763112133120;
        Fri, 14 Nov 2025 01:22:13 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:12 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:47 +0800
Message-Id: <20251114092149.40116-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, per-cpu bio cache was only used in the io_uring + raw block
device, filesystem also can use this to improve performance.
After discussion in [1], we think it's better to enable per-cpu bio cache
by default.

v3:
fix some build warnings.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/


Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++-----
 block/blk-map.c           | 90 ++++++++++++++++-----------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 49 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)


