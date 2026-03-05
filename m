Return-Path: <linux-fsdevel+bounces-79513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJciCf7MqWl+FQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 19:35:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11E21703E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 19:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEA2F307B23C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F701FC7FB;
	Thu,  5 Mar 2026 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WRT2IKqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67B3A1E84
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735704; cv=none; b=H7csl+lE6T2b0Sxhcm1yA2ioVHpcA81lttHuthIWY3BXf+dswHbEB8oi1ManTWrsf5B6UuWIYG8lvoLyfM5fYrm12Y5jGL1AAKbgXEllaH3GEG345sSWlV/mUQBWQ97OEO36bQQAgqslIMJbKBLukBQSmRJBN4WnjhtEwrVHegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735704; c=relaxed/simple;
	bh=3Id78WVIqcPglItXk4gutpSYAimZOI0B/zG45TjNknM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhmC5akhPR9rum71VcxxIS1Ew4d8r7SXRw1I2kyb7WhJrLX6jLtBEoogpK+049q4c6gLPzc5mHmAZEckkERnUwsMc2Ib+ealwMYhiZWfuSgbXhsCViU+8qTFtjM2XOFmoZirDKliYlvkuyfA9nbCmkTR1qLS6sf+PUjc6aGYqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WRT2IKqU; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d596a5be31so7355790a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772735702; x=1773340502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFhcK9Uem/LtMASOKzs4MxD6L+NtroLNk0fzDq8XxNI=;
        b=WRT2IKqUwlGQgkLwnTmIL+irm8VW156EoLbw7g4S6BT8skgmBbUKdhFVXHvXALqI1U
         UCEzZTB/X5dtTi4AfRPqYNnTS8jVUA7XuiubKjTPCQkw4LNGCK2YFZP9HsVbL7cDvdS8
         FT7zUxy9n/CIdRWqT1zhVr3xFNPY7t+pPP3aOk671kS0feLfFSquJDI1JzsofnrKUbJl
         RKvy0gowAYxaSwgDWCqYCzLeKoLSxsWK30zLkTWor2t8PUdARu/cQvVZzZbGDraYqdmp
         YOlkKCYHiMbJFSXh1mOQ/gqhpHgUqu6Wb5Ol4MddsVa09FiAmUx7V+em068aEyREpus5
         EFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735702; x=1773340502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFhcK9Uem/LtMASOKzs4MxD6L+NtroLNk0fzDq8XxNI=;
        b=w9fQenzZYU2W/GvrsgJZdt1MSYtwoblNq0xC3QE7/98YJORPhrlWGh17bO5AJx9y4O
         0RGpCXwNbqjcQ2blT5Hw05QGaofAV8ic1LILdFyswD/8FeFV1F7/cmwo+ThVWD0blSkm
         FOCY8npFFFrIE1dw0sDLvmF+L9IlgcAxoK7TP0uDkltrWMAveDcx9JXmF6/KDIPNAr9X
         WMjOVY8hEABYr+JhcN69Q9LpXIXUrC7o/cUfTqKZ1oo3oRktIe42oaC1ruQRidOLZyES
         bTWxIzUHMEu/0JqE7rDkgpI4Z4YymPchEzhwLEoQeXaN2N/+JQWBrwYyNRpn85avC0FD
         ZJrw==
X-Gm-Message-State: AOJu0Yz4wf+EKW0qoEJuxa40fGIZrFE1ugsZuihMoGX/pE65257abAFw
	NlMLL77BRjFuPpQ3JvkgZdwvCnCtYcRWdzsj9DBjnRtuLiPpzr2UCx6tPTmlFuhQv+g=
X-Gm-Gg: ATEYQzwnjNg8q2mPme+1vGu2q3Pi2uJXI44A1SPXQH6Pvy/g2CUReIiAyDXDv6OFtay
	fcf5v+p2uvvObUa42A9qG68FyGXq6NFe/MxG9xerMHYty7+G3a8khTNvkkNKY1IhJ9SaC1voTc6
	JNCTO4VQ4xq5+6x8xVrLuv7nCOc6G/im02seuYYJ6LpZstNjB4qUKg3Wc7/SQZYAU0eIBRjEPV6
	juVGNDVQ04JRaQvluFxRx61WTTjDrD1L+BGhsoHIZLlR4k8JqJbyIpngr7ECIz3xGf/RWP2v8dA
	YDwktgj35Vox/399MwxVCTD1KOZx5ppRaqPsmV2EXrkgWGx8UrFquYjgTnk15ayqfeuYPj69+zs
	ffIy5PjfHBFymtpvlFsIwWhOnGEqdtzdt9C7bhxlEbiDYZLAbYYZ0BZS4Ya2hZkCphEI9QpmJCT
	7cDsa55aJb
X-Received: by 2002:a05:6808:30a9:b0:450:d693:4d1b with SMTP id 5614622812f47-4651abd6437mr3134495b6e.26.1772735701838;
        Thu, 05 Mar 2026 10:35:01 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm13913851b6e.10.2026.03.05.10.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:35:01 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	william.kucharski@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH RFC 0/1] fix for large folio split race in page cache
Date: Thu,  5 Mar 2026 12:34:32 -0600
Message-ID: <20260305183438.1062312-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE11E21703E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-79513-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

In production we've seen crashes on 6.18.7+ with the following
signature below. These machines have high memory pressure, were using
xfs file-systems, and generally journalctl was the comm when we oops.

After some crash-dump analysis we determined that this was a race
condition. We tried to create a more self-contained reproducer for this
issue, but unfortunately were unable to do so. This patch will be
applied internally as a mitigation for the issue, but will take time
to validate fully (ensuring we don't see crashes over a longer time). We
are looking for feedback to see if this could be a valid fix or if there
are other approaches that we should look into.

An earlier email I posted with some analysis is here
https://lore.kernel.org/lkml/aYN3JC_Kdgw5G2Ik@861G6M3/T/#u

Thanks,
--chris

Call Trace:
```
aops:xfs_address_space_operations ino:5000126 dentry name(?):"system@d737aaecce5449038a638f9e18bbf5f5-0000000004e06fa7-00064"
flags: 0xeffff8000001ad(locked|waiters|referenced|uptodate|lru|active|node=3|zone=2|lastcpupid=0x1ffff)
raw: 00effff8000001ad ffaa3c6b85b73ec8 ffaa3c6b85b73e08 ff4e378b0e95dea8
raw: 000000000000737a 0000000000000000 00000002ffffffff ff4e379527691b00
page dumped because: VM_BUG_ON_FOLIO(!folio_contains(folio, index))
------------[ cut here ]------------
kernel BUG at mm/filemap.c:3519!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 49159 Comm: journalctl Kdump: loaded Tainted: G        W  O        6.18.7-cloudflare-2026.1.15 #1 PREEMPT(voluntary)
Tainted: [W]=WARN, [O]=OOT_MODULE
Hardware name: MiTAC TC55-B8051-G12/S8051GM, BIOS V1.08 09/16/2025
RIP: 0010:filemap_fault+0xa61/0x1410
Code: 48 8b 4c 24 10 4c 8b 44 24 08 48 85 c9 0f 84 82 fa ff ff 49 89 cd e9 bc f9 ff ff 48 c7 c6 20 44 d0 86 4c 89 c7 e8 3f 1c 04 00 <0f> 0b 48 8d 7b 18 4c 89 44 24 08 4c 89 1c 24 e8 0b 97 e3 ff 4c 8b
RSP: 0000:ff6fd043bed0fcb0 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ff4e378b0e95dea8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff4e375cef81c4c0
RBP: 000000000000737b R08: 0000000000000000 R09: ff6fd043bed0fb48
R10: ff4e37b4ecc3ffa8 R11: 0000000000000003 R12: 0000000000000000
R13: ff4e375c4fa17680 R14: ff4e378b0e95dd38 R15: ff6fd043bed0fde8
FS:  00007f6c5b8b4980(0000) GS:ff4e375d67864000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c48b7b050 CR3: 0000005065d34006 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? mod_memcg_state+0x80/0x1c0
 __do_fault+0x31/0xd0
 do_fault+0x2e6/0x710
 __handle_mm_fault+0x7b3/0xe50
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? anon_pipe_write+0x27e/0x670
 handle_mm_fault+0xaa/0x2a0
 do_user_addr_fault+0x208/0x660
 exc_page_fault+0x77/0x170
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x7f6c5b67c3dc
Code: e2 ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 55 41 54 55 53 48 83 ec 18 48 85 ff 0f 84 bd 01 00 00 48 85 f6 0f 84 d4 01 00 00 <48> 8b 5e 08 48 89 cd 48 85 db 74 60 48 83 fb 0f 0f 86 86 00 00 00
RSP: 002b:00007ffe78c072e0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 000000000737b048 RCX: 000000000737b048
RDX: 0000000000000003 RSI: 00007f6c48b7b048 RDI: 000055bc3b28dee0
RBP: 000055bc3b28dee0 R08: 0000000000000010 R09: 000055bc3b28df18
R10: 0000000000000001 R11: 00007f6c5b679fa0 R12: 0000000000000003
R13: 00007ffe78c07450 R14: 00007ffe78c07450 R15: 00007f6c48b7b048
 </TASK>
```

Chris J Arges (1):
  mm/filemap: handle large folio split race in page cache lookups

 mm/filemap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--
2.43.0


