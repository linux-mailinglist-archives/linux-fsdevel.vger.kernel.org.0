Return-Path: <linux-fsdevel+bounces-15623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9598910A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826551F235DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFDB20332;
	Fri, 29 Mar 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMbkzifS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A541CAA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677244; cv=none; b=OPjQBwvgpRVCSBisTfm/YclfE2obZgL142Dv6/4u3HsWCIDg31fRnLTU/WkV1PiS0XQ6THMNAvNblPiVCTD6UzZjTjPgokvQNjfndx9IRcxrDNhjWbbzt5PdNWg2GlDaDX+7XMEvBZ4GfgGXkzOnrYnpE5ZRxZKGmxRYS3ZpCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677244; c=relaxed/simple;
	bh=COTMQsswrF0FRMT13SRuAVp3LcxDhFLtqlaO5tjK0pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbUf1qKhX2w3ruNFW+rELxggLPSSyHjuWbrJlolXSci0K6kW0QeWEAD8CATG0ju5WesV6PHAU/qbgymBqRbDCHnVZbZVecwgLaejSFnk2ao/LJVNHVNHeB1TLugL4JSP+n5I4UbC6vGQ5OEPuh2e9AA0txYEgDyZ2v5pBRM9MOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMbkzifS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610c23abd1fso29387417b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677242; x=1712282042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuG/mHGKrSIUtx4w6cEfQTJMQYadvua3gQmJfgk1lpo=;
        b=JMbkzifSdQbpTkTqfHNkqnaRj+wpfquBvXHY8dyVo2yT8jVN7RReBnh86V0Vzv7pOT
         1Z+B7LJKxNIldSDuPZzmhQuwOSH7Q2+HqEh9wtGPSCHKz+6U8kWx5jz9bXvIFyX2wgNK
         PpjOlfHzxmKVClgNJXQ1kxEex9CHQgMjGl+IRI5NSHq+VlLODdw8YC+DZ8cn3yaIhBxp
         RWTjoPy7H+7CDrOZ38IQjeYf0mFavZ8B2QrxsAa8VdY2qAhqW7+/nYKkNjJBtiB2JZUd
         ywF3NY8v1LJdJPO1Tr0E7YsrSpWQKN0VYB8ywjJgRWBHdeT+9MwX+AoPTpp8XZKuYigC
         BKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677242; x=1712282042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuG/mHGKrSIUtx4w6cEfQTJMQYadvua3gQmJfgk1lpo=;
        b=jguZlOZxxaMMM9b5amNJHQY3vZcJ6Tj9v+H2Uqh2a6GSflOmRkpPuRWZ/9lT6JTPS1
         9SOUehqs4Cm7+pdYfz1x8hUf5OR5UG0wtB7MJjL290RaNOXc6UsrFGLtaI2MiHtZE9qK
         pKvViiwcutp8cIbpJpZV7h3uGXwg5rBB1NUmbHy7I3tD89tKTgEreU0sBmD0HsNWMriR
         argYjIebHRXxTbyaPQ9bQo0ONOqtdLMeLyWiu6wXWr1Gg/vumAYILKl9GE898sc04hmn
         M9nn2RNoOYTwnfN9RC+/qg1rRSrqrpRkqs5jDxb5InasyFuvLg7p42wd14FraKVU01bP
         +oPA==
X-Forwarded-Encrypted: i=1; AJvYcCXv3Yy9pXSQm35Lr/SN/GRkp2Y264h+2VtraoR5lHTrbD4AzZFBu/GPa268wYMVUpeIwRPCuUEui1B1mZo/TMuV4K9tBCUzBw48lavPng==
X-Gm-Message-State: AOJu0YweiZ96dwGwbJNhPejrQGp3Na/2k1I8gTMyLrh05CFj8XWw9wpl
	rxqQkUPt0BrivjPuOp89xre0+LJa6250DI6R8NThYpkUp9AOrsdQmOYqKSE2H/pggTJ6BFeguAc
	MSw==
X-Google-Smtp-Source: AGHT+IED/jGR9FMIZIsjwVV243BUIl4S9ew034aRBgTPJL//6If/s8rpgztWDMC7HEN1dk/qJiRztH6LPzI=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a81:52ca:0:b0:609:25d1:ea9a with SMTP id
 g193-20020a8152ca000000b0060925d1ea9amr309533ywb.9.1711677242218; Thu, 28 Mar
 2024 18:54:02 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:16 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-2-drosen@google.com>
Subject: [RFC PATCH v4 01/36] fuse-bpf: Update fuse side uapi
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

Adds structures which will be used to inform fuse about what it is being
stacked on top of. Once filters are in place, error_in will inform the
post filter if the backing call returned an error.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/uapi/linux/fuse.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe39..0c0a9a8b5c26 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -654,6 +654,29 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+#define FUSE_BPF_MAX_ENTRIES	2
+
+enum fuse_bpf_type {
+	FUSE_ENTRY_BACKING		= 1,
+	FUSE_ENTRY_BPF			= 2,
+	FUSE_ENTRY_REMOVE_BACKING	= 3,
+	FUSE_ENTRY_REMOVE_BPF		= 4,
+};
+
+#define BPF_FUSE_NAME_MAX 15
+
+struct fuse_bpf_entry_out {
+	uint32_t	entry_type;
+	uint32_t	unused;
+	union {
+		struct {
+			uint64_t unused2;
+			uint64_t fd;
+		};
+		char name[BPF_FUSE_NAME_MAX + 1];
+	};
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
-- 
2.44.0.478.gd926399ef9-goog


