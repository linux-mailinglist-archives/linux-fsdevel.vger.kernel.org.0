Return-Path: <linux-fsdevel+bounces-75785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLBhEodRemnk5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:12:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E433A7915
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E09030D1241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75F371078;
	Wed, 28 Jan 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WejVM5HG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26A372B22
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623554; cv=none; b=u/PcG5Oqx37ZXZMBKptj/hPsXNV8lWGUBPV5h7mGdxHrRys2ndqWb7MPwuBbQrMHYF/J1jUcxhHmnaIwyK6thSO1qUUFCSQ+vSyzaabAC/IE6IV0mDgF8SYWmTErel3MqBoCz5zEFV6vj2jwavDPu1rEkOXVFXBeV1Kaax2VHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623554; c=relaxed/simple;
	bh=0IaaSlfj/tMi4yxeSnvPlMcfeus7+kIDLygE1Bk486o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8izq00hmug16/cX5nLMVZqpZkvP5QeCfDaKH+A28XgXaTDVXal3PnyvI8gB+5AVVtfHG2EIerkzz+krufA/xNBv+cdnV5rRQHiwFWHsGJMPcBkZ765HIe+FOliaipMM0Oz7nDhS5a/xtpz8VFnXFMCyrEr2BvChYjiDRvitor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WejVM5HG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5Ix7028726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623520; bh=XOneXklHv1jiBk7rOfudnuchHo0WNmnJWMY901JnApw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WejVM5HG19YQvDFYigzzR+gZNeVwH4ERlRWh4vV7/XW5h3vXmJpiT6t66z7hPDtsq
	 NgYCJy8jIPN7aDglPMzjhllARcnzfu7XYVHrw37QDfxu5+K3deDjCX+laM9j856/Nl
	 Nr8CGKBhJNkbtd+rh7NAtya8Ra5ssDVGFDBSMTK3DmutAFcGKfsw/tjLANhoz0deS+
	 lzu/8adSoV1nxvaDWrq+SRBZE/YCi8f+jb+w6bXhMGKV0yE3Mos060U5G96vtgPlsA
	 vuILM1LkPfz5DlUVsrUdrFOYnsCUrKLqUWWV4+WtMRQLOJ78d9uPnD2d0fDffc7Vjw
	 XMC8C3GE9J8cA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 20BA02E00E1; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Yongjian Sun <sunyongjian@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com,
        libaokun1@huawei.com, chengzhihao1@huawei.com, sunyongjian1@huawei.com
Subject: Re: [RFC PATCH] ext4: fix e4b bitmap inconsistency reports
Date: Wed, 28 Jan 2026 13:05:07 -0500
Message-ID: <176962347639.1138505.6141824430366295375.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
References: <20260106090820.836242-1-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75785-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: 9E433A7915
X-Rspamd-Action: no action


On Tue, 06 Jan 2026 17:08:20 +0800, Yongjian Sun wrote:
> A bitmap inconsistency issue was observed during stress tests under
> mixed huge-page workloads. Ext4 reported multiple e4b bitmap check
> failures like:
> 
> ext4_mb_complex_scan_group:2508: group 350, 8179 free clusters as
> per group info. But got 8192 blocks
> 
> [...]

Applied, thanks!

[1/1] ext4: fix e4b bitmap inconsistency reports
      commit: bdc56a9c46b2a99c12313122b9352b619a2e719e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

