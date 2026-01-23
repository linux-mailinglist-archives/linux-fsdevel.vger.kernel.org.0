Return-Path: <linux-fsdevel+bounces-75300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLJ+MjCTc2ntxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:26:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E905577C5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38A97306C60B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D832D6E76;
	Fri, 23 Jan 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="AVvGIbBW";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="eKeFG+hs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBC2405ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180800; cv=none; b=rWJLLfy9+ub/T8rGgc8wIDRSrj2I6cwOAR47fNo3iqQg9up8XVrIE6pXS9PKilk/rZVi1exhKUsF2ByW4I5GTwCKtkxzZrgCXyiZEmR9qayP/dxbQQrsDDJPSiu0GxGljBGyZt+vZGi4HWKVzWsfnpUYrQhmWqOae7OamnIBlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180800; c=relaxed/simple;
	bh=Pynp0nE/3zAtaQ+2+SSJ/nl47ljUhiFgkbGLgQ6OWNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+fp5JFlULu4f4skurznNd9M1LtwRsLQna2vzK639TO5/nAMXEZXymiPbCpko7yu1BWOEZqaJInlMETnHSDnud5qQJFBBW1NxO+E5eIEORLcBxRaEICo1F+d1mGw9y5TESJsGGhPEOgH/MlF2TUTsXSaJyARF9ljOgmIVPJAlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=AVvGIbBW reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=eKeFG+hs; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769181699; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=SAgBVedFuyxPIgCRhhig25olZXujs9yuAYM+zynQ8pg=; b=AVvGIbBW01a9/dp2blf35BxHd9
	nGvN553Q+7JU0wrWwMLeqJ4gSzNGZx9ULW0xloH/D/f+JqR+Q/9Mnyfyp+ES2UXjTdbh5oQCZD3f1
	6xSK//QsMCyStjcX0+QZrGchLBt3NeG/7EvGT0qpS/jfaEaU/kXw4EDOWJbWOtlcKKMfORI8KaFif
	vhuZ+huiJiR2v+metSmyOKTzw45z3eFI1f/0uy4bSlT9eOrBje0EBhbF2oHzQWPDO12NZu8mApc1u
	Xg6Qxp/Dlv3w0V9uGw7F+16BDZkQc3vbP0yq88D04IntF1pbLW73LUZ7IEV+BcIgVCwd6zGozJyF1
	d+3wa1PA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769180799; h=from : subject
 : to : message-id : date;
 bh=SAgBVedFuyxPIgCRhhig25olZXujs9yuAYM+zynQ8pg=;
 b=eKeFG+hsTdDvxiBwpAxRJt8I9Xm9shJAMkm3nhKhZVUlgh66SEYm1HCxZgMBBiWDkSB5f
 /VJZZJP1ZwwN0pnxIUgzZ+Bi15HyTvgGUSa6GY9L0h09kYQfBptNGDQxYhoRzw7DZTF9xpx
 B1FVOrE2qDk86cXXbzn//Iccq7phnvdrIv3+pXjV6eKeTk1Z1waOaTZRinOxPCB+n9JpzR4
 TjBorj2QMTJRixPWX2zBCnnjshwZo5hepjYUUmicGRFZfn/HzFQG8pKKC7EePdM/ojH2rJq
 7VAL5nr1dceoeFpRRs4ATyKFY25jGkEopUMNwy5AqnWPVfpiM+6wQG2A+aOA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjN-TRk3KW-7v; Fri, 23 Jan 2026 15:05:49 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjM-AIkwcC8p1zf-KKLF; Fri, 23 Jan 2026 15:05:48 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/2] wait/9p: Account 9P RPC waiting time as I/O wait
Date: Fri, 23 Jan 2026 15:48:06 +0100
Message-ID: <cover.1769179462.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 12AKV0VVjs0j.9YjSjez59Bmd.wFnU8wrYxNP
Feedback-ID: 510616m:510616apGKSTK:510616sLG8nV3o7E
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75300-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[triplefau.lt:mid,triplefau.lt:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E905577C5C
X-Rspamd-Action: no action

This patch serie helps to attribute the time spent waiting for server
responses during 9P RPC calls to I/O wait time in system metrics. As a
result, I/O-intensive operations on a 9pfs mount will now be reflected
in the "wa" column instead of the "id" one of tools like top.

Changes since v1:
  - Convert a bunch of other 9P's wait_event_killable candidates

Remi Pommarel (2):
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 include/linux/wait.h  | 15 +++++++++++++++
 net/9p/client.c       |  4 ++--
 net/9p/trans_virtio.c | 14 +++++++-------
 net/9p/trans_xen.c    |  4 ++--
 4 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.50.1


