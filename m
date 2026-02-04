Return-Path: <linux-fsdevel+bounces-76330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JoAMC53g2mFmwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:43:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B0CEA67E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03D7830013B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8C31B100;
	Wed,  4 Feb 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LHxLKnMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15B2F6160
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223400; cv=none; b=Wnb4GHnuIkoP68+AykHP8kGIKCv/hHwgY31tMuPba8rMoAszD3+BBOUZ/Y3Fe2Y6WavCk/c2zuB2RYtxRvP2mOshAtnYWpBl8YtQ20nlAZUvBjEpR8Ie07bTvz/Uff8Zo/jVZLVXD7KviyID0h+Ebu9yn3Q+LWknrHC2vmVm6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223400; c=relaxed/simple;
	bh=DduLnUf8OZ24hiNT7/v93YL5Zgdn7hfN1/ijU5jQbac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WFW9C+20WbkPPat8vnmmKpnRrZOVLlzNMBA4JlOsxHpfEGDMaTm4dj9N8BZNvF9XZGFodOY/a9tSZhXVrDvFQxcC8AarEbxH/FesnCF02r1tup2f9U/KFbluNC0+uvCUYdlW7m6t3e+CmbwhneYWyr3+P+cTSfMlGO/7cC5UN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LHxLKnMh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d189e5b05eso3913a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770223399; x=1770828199; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oifKHjrKLZmTYhWeeUIGoTzejpK/elT/jpEKRJR5q7o=;
        b=LHxLKnMhXBAJN/YGncME8KJeDlo8EfDbYl3NEiUcbj2p+Taq4oVG4geIGsYWk9VMyR
         ho6WvvR0Ybb+mV+Ml6C9sX51TRH6bOtU14AEfav7rhQGd63Zq9KABV9Y4JCTA/L18fsC
         3D0WFn1OJm4NPxz5qgu046067Jt5N4Aa/KGDbzNlTgq8bnq2YoP+KmTnfqGLl9aiXGr7
         P7U1goh6pmLhdD7mXsCezz+xW9TFYV3Gzej5ebDxBEOxYs2JKMf2+4RbeCNtQ32SwI/6
         ftCsdMEuw0Iy/xcPkvv23aoL+42SqLw1QqROl2NNDrOVEYYYFKB4BtKWOb/K/MRWO8DI
         z1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223399; x=1770828199;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oifKHjrKLZmTYhWeeUIGoTzejpK/elT/jpEKRJR5q7o=;
        b=XRJMJY81gWNsmGajTWRegot0ejgyoQzm6rqBWXFWrKmrWw/+2cI+q+lxJxO3xFad44
         tjEA2HudDYasSjaMqd2toCw9cRPOCZvExUnzxwi41+UyTIeZ/M2QRGbODp3hkdEra5yY
         Q9p47E6hYWadQNouvF4gnfKxPEw+CwBlU7R8YT4ceFKbcPYt2aWtew+gx7xb/IIZT/Gw
         aWtN7Uqw3zDduSTjbHjHVLu8Aciv3HR8vKxh1fPoW1CPknjzpbVt8GY1L/2z9FLKnXQC
         Ls6Ni9EHPrcnMgmHtGNoAcStzENxytZLK9UvCsjSysYxomP3hR4HmVYu2rC0hQ4y8HCl
         IIbw==
X-Forwarded-Encrypted: i=1; AJvYcCWXswW2WKtf9yQpFiCc5FcdpkdIE7Wobti252ZPTANZNe8W1/HAJUtcjFnOZkoZOsUU5wThT104D/SiiFG+@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkFqxgfHVRItwzALVTMVuRQLS6O9p0hDykKuTh8N/j1FuSGri
	8E0yrEiYIlPltKOuwZ+WqDMs+375eAYX+8azko6RGHo+pSEzPPZ1XEuGTOWQiYBN8F8xMC3xXo/
	+OOcw35Y=
X-Gm-Gg: AZuq6aLesNc+QC9E0h6J4w140HdJX/pnxLEf2PY9C8VLh5pv10Cefijth/yJktzxmEz
	zNT4PSonO3iNaE04jyXgs02Mq105M+toVe5DTWXxIcy1pQvRd8Mnam84ZVKJStblAxY7Nwe9bK1
	BOZZPL3aYLhWbJhNAxlulrXYYHNOLZPWAKukN406SwAg7om9QVSen0nDmlovbVIO+dLMgzcH/Lx
	WvjEr1K0w4lLMPBeYWHsoHmbRBoLr4oKhf2cp2P9yKFkfnn+rk6b9jBb5oXT2qBBf10E1xToeOs
	eOoizQj5HQcfRC7E22X75+yCGJ/8sXUR3b7S41jWjbMPVA9Jb2DCN7QMMaCtn1KJX6f0DERaVkm
	7vBtFZijuZzIcWMOjkxWx2ZK94K2BN4VuaK5HJlLdTbLJ1M070hDF4h+usQW2XrIfpw7PGg==
X-Received: by 2002:a05:6830:6aae:b0:7c7:6063:8e0f with SMTP id 46e09a7af769-7d4489f0fe5mr1896594a34.15.1770223398896;
        Wed, 04 Feb 2026 08:43:18 -0800 (PST)
Received: from 861G6M3 ([2a09:bac1:76a0:540::281:ee])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4491ffb19sm1956584a34.18.2026.02.04.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:43:18 -0800 (PST)
Date: Wed, 4 Feb 2026 10:43:16 -0600
From: Chris Arges <carges@cloudflare.com>
To: linux-kernel@vger.kernel.org
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kernel-team@cloudflare.com
Subject: kernel crash at mm/filemap.c on v6.18.7
Message-ID: <aYN3JC_Kdgw5G2Ik@861G6M3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76330-lists,linux-fsdevel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:dkim]
X-Rspamd-Queue-Id: D3B0CEA67E
X-Rspamd-Action: no action

We got the following VM_BUG_ON_FOLIO assertion failure on a v6.18.7 kernel
at mm/filemap.c:3519 in the filemap_fault() function. The crash occurred
during a page fault while journalctl (pid 3666669) was reading a file on
an xfs filesystem. System was under memory pressure.
This seems like some sort of XFS/page_cache race.

Backtrace:
```
page: refcount:2 mapcount:0 mapping:000000006db8c9ab index:0x7652 pfn:0x2af2802
memcg:ff25824893476540
aops:xfs_address_space_operations ino:c0000c0 dentry name(?):"system@951e885c16c946debbe32b18d75328c2-000000000cc0fd3c-00064"
flags: 0x2affff80000012d(locked|referenced|uptodate|lru|active|node=10|zone=2|lastcpupid=0x1ffff)
raw: 02affff80000012d ff8c4b17ebca0008 ff258260eda3d3b0 ff25825437d792a8
raw: 0000000000007652 0000000000000000 00000002ffffffff ff25824893476540
page dumped because: VM_BUG_ON_FOLIO(!folio_contains(folio, index))
------------[ cut here ]------------
kernel BUG at mm/filemap.c:3519!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 7 UID: 0 PID: 3666669 Comm: journalctl Kdump: loaded Tainted: G        W  O        6.18.7-cloudflare-2026.1.15 #1 PREEMPT(voluntary) 
Tainted: [W]=WARN, [O]=OOT_MODULE
Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS HR355M_V3.G.031 02/17/2025
RIP: 0010:filemap_fault+0xa61/0x1410
Code: 48 8b 4c 24 10 4c 8b 44 24 08 48 85 c9 0f 84 82 fa ff ff 49 89 cd e9 bc f9 ff ff 48 c7 c6 20 44 d0 96 4c 89 c7 e8 3f 1c 04 00 <0f> 0b 48 8d 7b 18 4c 89 44 24 08 4c 89 1c 24 e8 0b 97 e3 ff 4c 8b
RSP: 0018:ff4ac5c342ccfcb0 EFLAGS: 00010246
RAX: 0000000000000043 RBX: ff25825437d792a8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff2582406fb9c4c0
RBP: 0000000000007653 R08: 0000000000000000 R09: ff4ac5c342ccfb48
R10: ff2582986cc3ffa8 R11: 0000000000000003 R12: 0000000000000000
R13: ff258239e9fbf740 R14: ff25825437d79138 R15: ff4ac5c342ccfde8
FS:  00007efd812b2980(0000) GS:ff258240d7be4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efd7ec53a08 CR3: 00000021f5891005 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __do_fault+0x31/0xd0
 do_fault+0x2e6/0x710
 __handle_mm_fault+0x7b3/0xe50
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_mmap+0x48a/0x670
 handle_mm_fault+0xaa/0x2a0
 do_user_addr_fault+0x208/0x660
 exc_page_fault+0x77/0x170
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x7efd8187c3dc
Code: e2 ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 55 41 54 55 53 48 83 ec 18 48 85 ff 0f 84 bd 01 00 00 48 85 f6 0f 84 d4 01 00 00 <48> 8b 5e 08 48 89 cd 48 85 db 74 60 48 83 fb 0f 0f 86 86 00 00 00
RSP: 002b:00007ffd3e56e120 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000007653a00 RCX: 0000000007653a00
RDX: 0000000000000003 RSI: 00007efd7ec53a00 RDI: 00005653db23c150
RBP: 00005653db23c150 R08: 0000000000000010 R09: 00005653db23c188
R10: 0000000000000001 R11: 00007efd8187d3d0 R12: 0000000000000003
R13: 00007ffd3e56e1b0 R14: 0000000000000001 R15: 00007efd7ec53a00
 </TASK>
```

Some crash analysis showing the index variable requested and the mapping's
inode number matching the file in kmsg.
```
crash> files 3666669 | grep 0fd3c
 28 ff258239e9fbf740 ff258241714d7380 ff25825437d79138 REG  /state/var/log/journal/a8313fd61d2511efaf3fb49691bc0851/system@951e885c16c946debbe32b18d75328c2-000000000cc0fd3c-000649d02a75bf77.journal
crash> struct inode.i_ino -x ff25825437d79138
  i_ino = 0xc0000c0,
crash> p mapping
$2 = (struct address_space *) 0xff25825437d792a8
crash> p -x mapping.host.i_ino
$5 = 0xc0000c0
crash> p -x index
$10 = 0x7653
```

Frame and dis:
```
  #7 [ff4ac5c342ccfc00] asm_exc_invalid_op at ffffffff9460123a
    [exception RIP: filemap_fault+2657]
    RIP: ffffffff94b3ace1  RSP: ff4ac5c342ccfcb0  RFLAGS: 00010246
    RAX: 0000000000000043  RBX: ff25825437d792a8  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: ff2582406fb9c4c0
    RBP: 0000000000007653   R8: 0000000000000000   R9: ff4ac5c342ccfb48
    R10: ff2582986cc3ffa8  R11: 0000000000000003  R12: 0000000000000000
    R13: ff258239e9fbf740  R14: ff25825437d79138  R15: ff4ac5c342ccfde8
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018

crash> dis -d filemap_fault+2660 16
0xffffffff94b3ace4 <filemap_fault+2660>:        lea    0x18(%rbx),%edi
0xffffffff94b3ace7 <filemap_fault+2663>:        mov    %r8,0x8(%rsp)
0xffffffff94b3acec <filemap_fault+2668>:        mov    %r11,(%rsp)
0xffffffff94b3acf0 <filemap_fault+2672>:        call   0xffffffff94974400 <up_read>
0xffffffff94b3acf5 <filemap_fault+2677>:        mov    0x8(%rsp),%r8
0xffffffff94b3acfa <filemap_fault+2682>:        mov    (%rsp),%r11
0xffffffff94b3acfe <filemap_fault+2686>:        jmp    0xffffffff94b3a5bf <filemap_fault+831>
0xffffffff94b3ad03 <filemap_fault+2691>:        mov    $0xffffffff96cd7ce8,%rsi
0xffffffff94b3ad0a <filemap_fault+2698>:        mov    %r8,%rdi
0xffffffff94b3ad0d <filemap_fault+2701>:        call   0xffffffff94b7c920 <dump_page>
0xffffffff94b3ad12 <filemap_fault+2706>:        ud2
```

Seems like rdi should contain folio pointer. However the mapping looks to
be NULL.

```
crash> struct folio.mapping 0xff2582406fb9c4c0
      mapping = 0x0,
```

Happy to run experiments, tests, and get more data. So far I've seen this about
6 times on various machines (both arm64 and aarch64).

--chris

