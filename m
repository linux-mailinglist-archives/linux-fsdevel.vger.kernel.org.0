Return-Path: <linux-fsdevel+bounces-24993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8879478A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE9E1C212B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5B156F5D;
	Mon,  5 Aug 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s+iKzSiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A13156222;
	Mon,  5 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850834; cv=none; b=hgSexmKSRdm6bQhQ346VwYkyac5KVnFqxo43HtcXX1mOPAhkRTf1qy3WFt3qs72NSYUkmOE9jjn7V3vnev+LcfPokP2Yfc4m/CtfslHeHIaQbtDKgXgjsivFgtSsxmu8WKOUrC46YurinphcLlgypgfQFVX/oEHLfXptMQpDkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850834; c=relaxed/simple;
	bh=3loE47oz4+kHYtzjuSAEQuFtMdeOuD0nJOTPg/9sHL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft4FqcZj3lWoHFY71VTveHa54per421/rpIMWj8mwn4KmPsJnMAd2jyrZQ7edLIsUMnQIBybdAxuRF9wnZw5LuB7NxIWHr+PxX1NK0yU79WYeFhLqMGzko8BGGxUcATUNW9k7yU577JOnCChqSDTCuwZvN+Ct3KY47EYypd9/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s+iKzSiF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722850825;
	bh=3loE47oz4+kHYtzjuSAEQuFtMdeOuD0nJOTPg/9sHL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s+iKzSiFTm68ElySCR+Nxg/GqwJIyYqFZs7dWTrt0pHV3QaydJRJNY6YP1jqB4hEO
	 yghMOaGdy7b66wkgNtAUVQO4oVNXf4dBIXeqt0PN1/E2Yz5w+B1UEY+4lJUIfdf++b
	 kXyTeuMsDniULPD3Rs6N3tXm8r5n4Ms7skiEZw7c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 05 Aug 2024 11:39:40 +0200
Subject: [PATCH v2 6/6] const_structs.checkpatch: add ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-sysctl-const-api-v2-6-52c85f02ee5e@weissschuh.net>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
In-Reply-To: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722850824; l=622;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3loE47oz4+kHYtzjuSAEQuFtMdeOuD0nJOTPg/9sHL8=;
 b=aGRIqu9xBoUoSsAjkjtyWeDJfliY8Cu/X/z0uURmidSGKzrfjzfQGlZKMEszU/MEwnvmBiSu1
 NqTTrNTQ5nSC4oX9aHScWgSifBT05yPDHq7Ghj2xz2FCZ6naE/FKNTt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the sysctl core can handle "const struct ctl_table", make
sure that new usages of the struct already enter the tree as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 014b3bfe3237..e8609a03c3d8 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -6,6 +6,7 @@ bus_type
 clk_ops
 comedi_lrange
 component_ops
+ctl_table
 dentry_operations
 dev_pm_ops
 device_type

-- 
2.46.0


