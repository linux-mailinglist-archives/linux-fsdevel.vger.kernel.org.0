Return-Path: <linux-fsdevel+bounces-79180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA0JJBrApmlDTQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:03:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 262411ED47F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 167C630234D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941283E3D8C;
	Tue,  3 Mar 2026 10:59:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD773E0C73;
	Tue,  3 Mar 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535577; cv=none; b=O0LujDgr1HKenAia15kVTlKlJvADklkjOa1mfneJzQw/abwdh7AyUpGDoY4OOdkY+ToLeXvDZ+s/TEwSCYjL6yOLlnGcqe1DloNZtCFoj1v/wT5z9CJxJx+aiWGj9ZWVv5leA6i/ePMy/5suF0y3nvy8wvXsmAGDyYLNsjmvwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535577; c=relaxed/simple;
	bh=fxfNMY1/bETtKv/qGV2veO9GsO00dZq3D5BMTLQiLuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGrFwUmjy7DLNn1l2DGPgvi4yRurspRFW++8OlBecArKdGc1Am1oKnwVW6fLNlUrFxR2JC0OuUYt03j9A9gGSlwoku3wNduSq7fnNVZwVtwA4GYWuEhd2vZ2e8jikgfJRiZynAXta7R0qbb0Uc0oMUIpflCjxSDQbLaosTVogks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69a6bf0c-0473-7f0000032729-7f0000019b32-1
	for <multiple-recipients>; Tue, 03 Mar 2026 11:59:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  3 Mar 2026 11:59:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: Fix 2 issues found by static code analysis
Date: Tue,  3 Mar 2026 11:59:13 +0100
Message-ID: <cover.1772534707.git.p.hahn@avm.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1772535564-CD7F895F-0275334D/0/0
X-purgate-type: clean
X-purgate-size: 696
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 262411ED47F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79180-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.894];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-fsdevel@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

I'm going through our list of issues found by static code analysis using Klocwork.
It found two issues worth fixing:

1. The 1st seems to be a real bug due to C's integer coercion, where the
   inverted bitmask `s_blocksize` gets 0 extended.
2. The 2nd might just be a dead variable assignment, but maybe `num_clusters`
   is supposed to be returned or stored elsewhere?

I hope my alaysis is correct. If yes, please apply. Thank you.

Philipp Hahn (2):
  exfat: Fix bitwise operation having different size
  exfat: Drop dead assignment of num_clusters

 fs/exfat/dir.c   | 2 +-
 fs/exfat/inode.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0


