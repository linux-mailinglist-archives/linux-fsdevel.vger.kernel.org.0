Return-Path: <linux-fsdevel+bounces-70748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCACA5C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 01:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB8F307B583
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13516215F42;
	Fri,  5 Dec 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pu0MNb0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125420CCDC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896332; cv=none; b=B4DXHuKul1pPzEUnbEkhAAGFZjqyTPUgzqi0RDhrazFkwfbHSEsgzlgcBpYs9Y/BoXsVKDNGc4Sa2rk/WURANwUo58tXAKhb1NsM1xNuHOQwD9HBrRrL7y1rwHAkfYdNSipRNPhPrItsDgElTA6NgxVMQE3rbVxL6Oto4UbGbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896332; c=relaxed/simple;
	bh=LLwOjwJb3krQOl35pm6jPUBFIvmN0U0U/HlVN35oQmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G60hTKNnjxQ7ifyklk5KCrT2iOg8o56+l70Unk+k+flX3vtdXsSxLNSgZkE7bMf1Rne97TwNxms0dS3Jc6+qAEIyVEhQxpB+rRAvXlaWefLRy+MA3OpPahWekVz6Cig398Efeb9pYk9UoEWBkdgcBt/3vP5vKjhOm7tIfpLKY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pu0MNb0e; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-45033344baeso3576617b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764896329; x=1765501129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVE0N0KUpY0wO1fMUhmyg8I9ioeDz1sYwcQ5NNPx/VI=;
        b=pu0MNb0eIh3SqZbOq8ShY0wCZTmi6kG5Fo+kqHqdMby0LhQ3z+iEUltuPHsoyv0LQy
         fwNU8V+BdXuVHMV0FC5VS5Wrq4zbswIvW2yqmn17wNbw22u5636fw+XvBw65gn0TZIZ4
         GM/Lf9pJDB56AGui08QYRJyE+R3640z1buFm30bWjhd3zj6ilz3PocA2/k3iB4pPaNu0
         Yn6Rj8Ws1pmVuvi7R25p/VnjAdD45pnTlRL8ZRp8aWV6IiICymL9gRRxWfFSYcGLiDi2
         lQ+Y1oDAlT0rzRomDdGKqtyB+R3OsHUZnudA9IRT3EgCWq0D1URDUX6QnVu49rr605o2
         zVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896329; x=1765501129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVE0N0KUpY0wO1fMUhmyg8I9ioeDz1sYwcQ5NNPx/VI=;
        b=hRDSQk4ahvV7otTwvo5r3eq4F2BxjCCZjI/fKVaEtVwJ19Np52VC59ykugOrp4XJwT
         JXDgNVEYuzefw8kUGgZS+NjdZEXKhyS1r7bHzjutMLfVp4i3DHcACV/YqNWVn649xquj
         27WqN8+/KFy0p1CqtRWIgoZbchikrpKRExf+PprNqj9S9f/w1h2m+TOhJUiK+QT+KXY2
         +6+IK+913KmSBLT1K6SXpw/DFFufhhRvYEQC4uYALVUrhw9O/cKA3c/oahkIFRRP9WYN
         S9btpgWm05sMN966icL7sBm0iIbnkK6X9htKryuZJ5rX4N5lYITvdAfrQ0J45LqXEFvn
         q+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU5EevXdLLu3JAJLaBds7CfsK1zsYv2JR8w2D2aVGkghzg8bD7h2SKbcrLFYX0Z5t4kn0X8MzCTytNq3Zwd@vger.kernel.org
X-Gm-Message-State: AOJu0YysBiU2i+vZyJQY6++B1NgGEUynEQOuWcyJAEtt6uWRfw+kURG0
	lQ3Hz4eaP61CCIlmksvAiOMyFddpQ+aGEQ2+iQc6Pkw7joQHckAgN6BFglUj+4Hyb2f/8SAWiE7
	pb+0hnQ==
X-Google-Smtp-Source: AGHT+IFifApyQ81uqcVNp3ozqjh2VV5F+exYOtd6RAsz1O9td1lhZ/L2nTazk9kUzTzPa/vDQgHRCZrkH4g=
X-Received: from iobfb16.prod.google.com ([2002:a05:6602:3f90:b0:949:11f9:31f7])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:11c4:b0:450:b3ec:c154
 with SMTP id 5614622812f47-4536e3de299mr4587772b6e.25.1764896329505; Thu, 04
 Dec 2025 16:58:49 -0800 (PST)
Date: Fri,  5 Dec 2025 00:58:32 +0000
In-Reply-To: <20251205005841.3942668-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251205005841.3942668-1-avagin@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205005841.3942668-5-avagin@google.com>
Subject: [PATCH 3/3] Documentation: cgroup-v2: Document misc.mask interface
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Updates the cgroup-v2 documentation to include details about the newly
introduced 'misc.mask' interface. This interface, part of the 'misc'
cgroup controller, allows masking out hardware capabilities (AT_HWCAP,
AT_HWCAP2, AT_HWCAP3, AT_HWCAP4) reported to user-space processes within
a cgroup.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 25 +++++++++++++++++++++++++
 Documentation/arch/arm64/elf_hwcaps.rst | 21 +++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4c072e85acdf..9d9d923e0d4e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2924,6 +2924,31 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
         cgroup i.e. not hierarchical. The file modified event generated on
         this file reflects only the local events.
 
+Miscellaneous controller provides one interface file to control masks.
+
+  misc.mask
+	A read-write flat-keyed file shown in all cgroups. It allows
+	setting/reading the masks.  The file format is a series of lines, each
+	describing a mask of a specific mask type.
+
+	The file has the following format for each line::
+
+	  $NAME\t$LOCAL_MASK\t$EFFECTIVE_MASK
+
+	Where $NAME is the mask type name, $LOCAL_MASK is the mask for the
+	current cgroup, and $EFFECTIVE_MASK is the effective mask for the
+	current cgroup, which is a combination of the masks from the current
+	cgroup and all its ancestors.
+
+	To set a mask, write a string in the following format to the file::
+
+	  $NAME $MASK
+
+	For example, to set a mask for the mask_a type, you would write the
+	following to the file::
+
+	  # echo "mask_a 0x3000" > misc.mask
+
 Migration and Ownership
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index a15df4956849..5526daff5d30 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -450,3 +450,24 @@ HWCAP3_LSFE
 
 For interoperation with userspace, the kernel guarantees that bits 62
 and 63 of AT_HWCAP will always be returned as 0.
+
+5. Masking hwcaps for a group of processes
+--------------------------------
+
+The misc cgroup controller provides a mechanism to mask hwcaps for a specific
+workload. This can be useful for limiting the features available to a
+containerized application.
+
+To mask hwcaps, you can write a mask to the ``misc.mask`` file in the cgroup
+directory. The mask is specified per AT_HWCAP entry (AT_HWCAP, AT_HWCAP2,
+AT_HWCAP3) in the format ``<HWCAP_ENTRY_NAME> <BITMASK>``.
+
+For example, to mask ``HWCAP_FP`` and ``HWCAP_ASIMD`` (which are represented by
+bits 0 and 1 of AT_HWCAP, so a mask of 0x3) for a workload, you would write the
+mask for AT_HWCAP to the ``misc.mask`` file in the new cgroup directory::
+
+    # echo "AT_HWCAP 0x3" > /sys/fs/cgroup/misc/my-workload/misc.mask
+
+Any new processes started in this cgroup will have the specified hwcaps
+masked. You can verify this by reading the ``misc.mask`` file, which will
+show the effective mask for the cgroup.
-- 
2.52.0.223.gf5cc29aaa4-goog


