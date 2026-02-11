Return-Path: <linux-fsdevel+bounces-76918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIbkGdPbi2nMcAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:30:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA901120789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0F2306A51B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0393238C0F;
	Wed, 11 Feb 2026 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj/oc/a5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D31E511;
	Wed, 11 Feb 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773448; cv=none; b=Pg44Zj72fqUQi5V8xyUTMEJzfKilcYqNeYN5oFZ4kGQ7kLc/DWgVLa25AUAJDa3HtRWK1TUSO1r8q4AkXRWDStMM7zAb8HHnGYvv+vwziOWEoeyip/aOd3xKyHRtGu0XUCaClOEyqysplCV23H+cNR64TOawogbERXsaxh+S84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773448; c=relaxed/simple;
	bh=Fi1WNYnUwJRuTNrA01/0llli4cFlbNWkNf0uzzIfG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDs/ivK6xJxtonpy6Nzl/rpn3qMFgoHR3itzwiiFneDsGwxVC9QY422MmX+Z9ozdQBNNt+iTgji0ptVi03gXS3TbqelVkNGRT7D7gQ0FPmnsukdnDd847s0CXO69gLKwctnhhDG9YVozgHJlM2/6h2nJXwOltzk8nJgtuyJ/E6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj/oc/a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A06C19423;
	Wed, 11 Feb 2026 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770773447;
	bh=Fi1WNYnUwJRuTNrA01/0llli4cFlbNWkNf0uzzIfG1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qj/oc/a5754lLv4yItnshbjodvBlITYun3IA8xek2ttqA/zlqBju/Fe664ap2i6xc
	 Y7MpTcU5VyBn5UnDqE1r4+GlCs7VRA2G7VnjEzYz7YWb9qJM4XQMMSPRIusF0KTwwb
	 oQR2G8nN3drVkvDc9gA0jH4YL5PtYG6AUKHikDnT2852PSkpCmsg+dxa0dZfB6Ze5L
	 JjxWRATC2apsvTFM8/Ef3u5QU3hn3DJA3cfFUJzCP1IgcqnwPBQ0FC/PR77CogTx8V
	 QA/xhmTAnZtVNjORc2XtYu8zsvuQAuWr9FTVljDVAtdIXaxu4RdGBL33qv1u9f3BEd
	 dVYq/uD7Lmp/A==
From: SeongJae Park <sj@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: SeongJae Park <sj@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"clm@meta.com" <clm@meta.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"chrisl@kernel.org" <chrisl@kernel.org>,
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: RE: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
Date: Tue, 10 Feb 2026 17:30:38 -0800
Message-ID: <20260211013039.68143-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c24a209d5a4af0c4cc08f30098998ce16c668b58.camel@ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-76918-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA901120789
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 22:36:35 +0000 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> Exactly, ML-based DAMON approach by using ML library is my next
> implementation/exploring step.

Glad to hear this.  If you find any question or need help for DAMON while doing
this, please feel free to reach out.  I will be more than happy to help :)


Thanks,
SJ

[...]

