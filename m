Return-Path: <linux-fsdevel+bounces-77392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNkqG8W8lGm4HQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:08:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10114F811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F45130405F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5166376466;
	Tue, 17 Feb 2026 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VtsYt4i1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EB374741;
	Tue, 17 Feb 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355326; cv=none; b=K54Df8rMCGoIpVpniGj98yqvgAuko7kpx3RpLhe58kD+e6rvwxi6wdm1ybCs60SrtKzkUQejY402kfZdW7vELYc2gD59J1byf4XP+20yC/WDc5Br47INVcCHKbMygOs/8MIJpeKYQ65iGwCdn4Co9VLQ3NimeV4g7OvGrYtMBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355326; c=relaxed/simple;
	bh=1VFBVzTBV82909jtjWYlhKQfTVLrz+jYpR1JBRVuuuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miSxSxBCvie7kvTxHOhfBs2FNmRrj/6g8Qg8fNwK1+xF7P6+1xGdqG/bS/zm/W/K1V4v0Zggeh3I7a55a9Kq4QwAG1P8Hl8o9q4enroZObSGgD5/H8Xd/a6+8CGspJr+hKdT8McjXGNj7yd+h6YypjU9MqrK26Zf0X+InUzDD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VtsYt4i1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MEOKnWH1MgK5HsJ1EHQ+ONzOF8KsD2ft0oTIw1Uo5+o=; b=VtsYt4i1+/UnLwgzUeBkLcM/Mr
	CSCCUnLVs8fVl3J9Pmx/d/D3p2RMKkp4bqqU/FyMCmyhAS/M+FSus/THD50FIpLIZWZHLQ0hxkaw+
	3ot+0PT1kfIcQZktnn4sQ+aJpRYoJMiJZ/3qOvvRulEDlPyTO/k2gSbZJ9Hf3gXEcU+13KTONV9XJ
	wjJQZnQmyvaPuhtqUja8kR8moKi53RP2qVt3vu82Zr07RcBdy5HkxxxLVDUO3K4kDonA+yohBgfnB
	AMm1L2C2K4Vr/2EDb3CMHtmn7xDl4af0G9ojCOwwwqgwWS0Cn97wRYuiLrCYNckybt1/3b1t3DYkS
	QvI4UAuw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsQR3-00000004pgI-1zRt;
	Tue, 17 Feb 2026 19:08:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: 
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC 0/1] Shrinking rwsem
Date: Tue, 17 Feb 2026 19:08:33 +0000
Message-ID: <20260217190835.1151964-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77392-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: BC10114F811
X-Rspamd-Action: no action

Some of Christoph's recent work has pointed out that we're achingly
close to being able to squeeze one more inode into each slab [1].
There are currently three rwsems embedded in struct inode --
invalidate_lock, i_mmap_rwsem and i_rwsem, so this saves us 24 bytes.
Of course, it'll shrink a lot of other data structures that embed
an rwsem (anon_vma and mm_struct come to mind).

We can do the same trick to struct mutex, but I thought I'd send this
out to see how people feel about the extra code complexity to make these
savings before investing any effort in doing that.

Maybe the performance bots will come back with some numbers, although
they've been weirdly sensitive to rwsem alignment in the past, so I'm
not sure I'd believe their numbers.

[1] https://lore.kernel.org/linux-fsdevel/20260202060754.270269-1-hch@lst.de/

Matthew Wilcox (Oracle) (1):
  rwsem: Shrink rwsem by one pointer

 include/linux/rwsem.h  |  8 ++---
 kernel/locking/rwsem.c | 74 +++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 23 deletions(-)

-- 
2.47.3


