Return-Path: <linux-fsdevel+bounces-75872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGQ1LtOBe2mvFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:50:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C7B1A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1993B300CA02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F133122E;
	Thu, 29 Jan 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkjxntEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099B3090C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701834; cv=none; b=j5bNftGO6Vm+pTH8LZbqoSGdc4XWg15TugQTshnYuutB+sa9Kd1yN6WruIhjueZkhPnnhMqUAHwh8nh6Gm7DZBblUIlDnhQjK5MuLNBK3WjMEUrWh1SlS/XDwb8iQQQJeaIeariCYhPsWveC8qojwh1IXnAniivPfN8BOp4S0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701834; c=relaxed/simple;
	bh=dVoci7UurIKaLWVhEEQyOA/oRtbZVi8H/yVXGSLOoME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sbv6cDlLCcvFO/gz2JM5rmX8p2WaMThokloTIdz9PqVqHk4UyyiXZELKLo/B87k4NbqT8t5MUI5j1MePGNwKjm/5Kdu+ntkizCwQIs3YBxlHsSWpWTtXu5NeKrGmb7bLBvSOMxOGra0g6ZrLDMXWTNGeiCzRTMHPT392H5ScJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkjxntEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769701831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6i3WlIu8fBaSjICdJuR/n+CyzTL3A1o0ivoFGDjDtQ=;
	b=bkjxntEaWpvQtpM4naeRanax2hil3GNUxMWMoLMKVLTETjmc/Pm/g87hsTYfZmeN84mWED
	WoeXikLRQY4G0LlQ3Qaf25oacex63rnkbUwsz8r3sxfuXN16HxwfoWr8qGLD9ag8werUEa
	0KhzcLY5KODiDUSwzQFJJRDH9cHVsCM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-4ZKjX25YN3GuGvp1pn5uyA-1; Thu,
 29 Jan 2026 10:50:30 -0500
X-MC-Unique: 4ZKjX25YN3GuGvp1pn5uyA-1
X-Mimecast-MFC-AGG-ID: 4ZKjX25YN3GuGvp1pn5uyA_1769701829
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41AEA1956060;
	Thu, 29 Jan 2026 15:50:29 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.81.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2F901800109;
	Thu, 29 Jan 2026 15:50:28 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2 0/5] iomap, xfs: improve zero range flushing and lookup
Date: Thu, 29 Jan 2026 10:50:23 -0500
Message-ID: <20260129155028.141110-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75872-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C3C7B1A33
X-Rspamd-Action: no action

Hi all,

Here's v2 of the iomap zero range flush cleanup patches. Patch 1 in v1
has already been merged separately, so that's dropped off. Otherwise no
major changes from v1. The remaining patches here lift the flush into
XFS, fix up the insert range issue that the flush implicitly suppressed,
streamlines the .iomap_begin() logic a bit, and finally replaces the
just lifted flush with proper use of the folio batch mechanism. The end
result is that the flush remains in iomap zero range purely as a
fallback for callers who do not provide a folio batch for pagecache
dirty unwritten mappings.

WRT some of the discussion on v1.. I looked into changing how COW blocks
over data fork holes are reported in XFS as a first step, but I
eventually ran into complexity that would essentially duplicate some of
the hacks I'm trying to clean up. For example, we'd have to determine
whether to report as a hole or "data" mapping based on pagecache state,
and this series adds some of that by the end by explicitly doing the
dirty folio lookup in this scenario. I'll plan to revisit this on top of
this series as a standalone XFS improvement, but haven't got there yet.

The other thing that is a little more annoying was failure of the idea
to essentially prep the shift where patch 2 adds an EOF folio flush [1].
This ordering leads to potential pagecache inconsistency because the
i_size update can zero and repopulate pagecache. I'm open to other ideas
here, but otherwise haven't been able to think of anything more
clever/simple (including futzing around for suggestions with AI). All in
all I still think this is more clear having the flush isolated in insert
range where it is actually required than having a flush in iomap
indirectly suppress the problem.

Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20251105001445.GW196370@frogsfrogsfrogs/

v2:
- Patch 1 from v1 merged separately.
- Fixed up iomap_fill_dirty_folios() call in patch 5.
v1: https://lore.kernel.org/linux-fsdevel/20251016190303.53881-1-bfoster@redhat.com/

Brian Foster (5):
  iomap, xfs: lift zero range hole mapping flush into xfs
  xfs: flush eof folio before insert range size update
  xfs: look up cow fork extent earlier for buffered iomap_begin
  xfs: only flush when COW fork blocks overlap data fork holes
  xfs: replace zero range flush with folio batch

 fs/iomap/buffered-io.c |  6 +--
 fs/xfs/xfs_file.c      | 17 +++++++++
 fs/xfs/xfs_iomap.c     | 87 ++++++++++++++++++++++++++++++------------
 3 files changed, 81 insertions(+), 29 deletions(-)

-- 
2.52.0


