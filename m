Return-Path: <linux-fsdevel+bounces-79550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAexJsQgqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB8219D41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FF4C300D4DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EA22D3A7B;
	Fri,  6 Mar 2026 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHcH9ulP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632A2BE7D1
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757186; cv=none; b=d/RHXxkRtGErKTBJ0llsrVbe+nuCfzphu0xFP109ssfhS7RFECJOWEVvSOsxKst8B7em5kKSThodr+xr+iTDi/7u13jehaNO4515U1DeapmpI69rjlCUWRre+R1qN+gxztv/pgrximWH6BnGSIDeceh5fhOTtWFo9fqvtUsHDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757186; c=relaxed/simple;
	bh=MT4DRoCGB/girfxR34MqAbQes4URJrHY/VHWRaSDw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtE/IItO2IXLjh0K1oTDQKjjTJopnt0mje2h7QOne2/FSB9CB3fu0TOLEK75tBQRj55D5nZC8PVU6m7W/pqy5uEMWb6Y+80fJ7IZd2xo2S0FA6MnJv18W7fIzUX2iAhMPOXbx+szlNPH6Kkigeefaiy0ljkkSozFhCVMaksvgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHcH9ulP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8fba3f769so38179595ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757184; x=1773361984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1twlmSPwUnfXvGoR6t3HmIMwyyrF4rU9pLV0zVz/MSo=;
        b=RHcH9ulPi3mRAlS9JvTNCIRwRTRn/fyAGtmkgR/R/czXS2oJ41KzdtjT0gJSgjTOUj
         d9XYZ0ch7OhtF8tLCU20+ez+nKlokqe1GpJzVPwt9V81BVhN7iQM1Y9ZxOaFgMnwY2u2
         py2gz54wx+01BWsyKJsLSLBzQxIRKhCj2ID8JgHznHTuZ7KSutJLRLSV58LeOTX0CTTU
         Aj9eORTC+QIYHCdTKykYT8Z/BSY8qv4qmW/bLr/SNi9oQzJcVEtEi3DwExxpRLzOMwpP
         Npm4XXqyG0GDzkLIQRoMivb6r77K7q96CjyLXSrASPq3UcvQj4eTTJIOno5gZPLunweq
         wo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757184; x=1773361984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1twlmSPwUnfXvGoR6t3HmIMwyyrF4rU9pLV0zVz/MSo=;
        b=Nxyz9DHRSCK3GG58OFimL/xvGSCW0r3VatJOzidCXEmUOnGh0hbxjh1kYy3nY9slOo
         TjQfG9H9uHK4SJ+7D4vydvfZOC8D0kL/757aPcu0qLV85G3YgpLMlGeXY3sRPWuoATTU
         aosfzoJau6FV/xrCpvipIaskbdGg7o/i1MVB2ze26hmzXF529XbDJ7N8ZBRPJlsDvpin
         52ITn1XClQhYbcxdL3P1UHLMocE7ep+eCUfSfnAsEszVMUPJc+TsL8jbGAocw1f0CWrg
         yV63VRZU/oI2TdYKaixJduO3Qnxzrr7pyqn9TJoiXHwPnBgcP3dPJhmmIW+9yJurdp1I
         JEEA==
X-Forwarded-Encrypted: i=1; AJvYcCXEs8BP4pAAAgkALU3KqGDzpPtgxY+o7IlkY1VKRiSNIt1lMfQsWz/5haVX5XJmByl7G0v8i4HRVcNHQCSn@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiXzsbu56FYHowg7uVJ+dahmgHbiD7P507UekQ8lmebOlTdDw
	/7FAJl995BRLc3cEu3TiOXBrELZwZSZa1PnwbplPSGN9BSiEkFwax043
X-Gm-Gg: ATEYQzxuXleqHUTVniDCwpRQf/qxbz0Sm6XLQV11IFQFqo6CKi3DmkfSXUHKrOE8tV6
	xUar36OUgRkIgdpRxFWeApFEMYBHmRsn3RfKw/HpDHUKtZbi93UyP25lP1eL7KjzG4hlTIVYrgU
	HXP6vl/mnCM872ZVonVlkGMLiasQt80+w4ACmruDErcTZx+aehjc8vnCZb+xbXSGAmQNdrX7ZRW
	lIRr9e/y6qQ8RcM0+TDvGPsDl8Na60CeXej1Br5Kspbzxvo+0qy5LBaV9lfYNGyowpX9RuNxbaR
	+qjo5wp9FWwpyid8Dxtdy02S4G17eEDetk4ISZ9JSxbRWY5PWC9ftWwvzqtQgjKT7V8ZboZaBCx
	FLEPJ8xXylxmEL6YILnlQSqYBaV4E7P7UqEwJFZKvy4oVlRA7wMg4YF5D3+4PGbQHBfs4Jt8xaY
	GtJscLxLx2L16AC0cexBN/nM6pdrs=
X-Received: by 2002:a17:903:2452:b0:2ae:5752:af82 with SMTP id d9443c01a7336-2ae82498328mr3893045ad.49.1772757183664;
        Thu, 05 Mar 2026 16:33:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c5esm170699065ad.6.2026.03.05.16.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:03 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
Date: Thu,  5 Mar 2026 16:32:16 -0800
Message-ID: <20260306003224.3620942-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BCB8219D41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79550-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,bsbernd.com,purestorage.com,suse.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently, io_uring buffer rings require the application to allocate and
manage the backing buffers. This series introduces buffer rings where the
kernel allocates and manages the buffers on behalf of the application. From
the uapi side, this goes through the pbuf ring interface, through the
IOU_PBUF_RING_KERNEL_MANAGED flag.

There was a long discussion with Pavel on v1 [1] regarding the design. The
alternatives were to have the buffers allocated and registered through a
memory region or through the registered buffers interface and have fuse
implement ring buffer logic internally outside of io-uring. However, because
the buffers need to be contiguous for DMA and some high-performance fuse
servers may need non-fuse io-uring requests to use the buffer ring directly,
v3 keeps the design.

This is split out from the fuse-over-io_uring series in [2], which needs the
kernel to own and manage buffers shared between the fuse server and the
kernel. The link to the fuse tree that uses the commits in this series is in
[3].

This series is on top of the for-7.1/io_uring branch in Jens' io-uring
tree (commit ee1d7dc33990). The corresponding liburing changes are in [4] and
will be submitted after the changes in this patchset have landed.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260210002852.1394504-1-joannelkoong@gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/20260116233044.1532965-1-joannelkoong@gmail.com/
[3] https://github.com/joannekoong/linux/commits/fuse_zero_copy_for_v3/
[4] https://github.com/joannekoong/liburing/commits/pbuf_kernel_managed/

Changelog
---------
Changes from v1 -> v3:
* Incorporate Jens' feedback, including fixing wraparound int promotion bug
* uapi: merge kmbuf into pbuf interface/apis as IOU_PBUF_RING_KERNEL_MANAGED
  flag (Pavel)
v1: https://lore.kernel.org/linux-fsdevel/20260210002852.1394504-1-joannelkoong@gmail.com/T/#t

Changes since [1]:
* add "if (bl)" check for recycling API (Bernd)
* check mul overflow, use GFP_USER, use PTR as return type (Christoph)
* fix bl->ring leak (me)

Joanne Koong (8):
  io_uring/kbuf: add support for kernel-managed buffer rings
  io_uring/kbuf: support kernel-managed buffer rings in buffer selection
  io_uring/kbuf: add buffer ring pinning/unpinning
  io_uring/kbuf: return buffer id in buffer selection
  io_uring/kbuf: add recycling for kernel managed buffer rings
  io_uring/kbuf: add io_uring_is_kmbuf_ring()
  io_uring/kbuf: export io_ring_buffer_select()
  io_uring/cmd: set selected buffer index in __io_uring_cmd_done()

 include/linux/io_uring/cmd.h   |  53 ++++++-
 include/linux/io_uring_types.h |  10 +-
 include/uapi/linux/io_uring.h  |  16 ++-
 io_uring/kbuf.c                | 250 +++++++++++++++++++++++++++++----
 io_uring/kbuf.h                |  11 +-
 io_uring/memmap.c              | 111 +++++++++++++++
 io_uring/memmap.h              |   4 +
 io_uring/uring_cmd.c           |   6 +-
 8 files changed, 427 insertions(+), 34 deletions(-)

-- 
2.47.3


