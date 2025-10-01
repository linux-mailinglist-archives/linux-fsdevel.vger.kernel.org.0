Return-Path: <linux-fsdevel+bounces-63144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80542BAF248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 07:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D11016387E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 05:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA9254B1F;
	Wed,  1 Oct 2025 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTpedSWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901556B81
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759296038; cv=none; b=HJ2eZd8OQaivNHR/avbKmQL0MlKtlTd2hXeN8u69WA51XB7xW5ovDNNnOIIuP+EnMJ7AHDrJKw/XBPY5JUsdtHZJYxWsvr21fQeLxiNbaBXoUW4ad3fmHovx0uLkwuU7b0bWcMmZifAFmfGu9a+NZ+4UYZB4h+nTc0nC3/N4B74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759296038; c=relaxed/simple;
	bh=pavEtnoo8vrFDTJ6BQAdYsqVXpuXcYgxwvBxXZ6E4n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQu1uTgFPQJx6XpsjMthjQqrXEx9IpQhyb4BLkbg+9BO33uaRCdoyylJENmrcNr5blNbK/3P4QCxEA/hgHTtU7z80RtzYTIJ9sXSJzP+FR9WZD2i4Lz2Y9W6Tv/8PkDawWkIT8YaCTb44ZOtWdX/se6/O/MBkeHrUiNFF+hxRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTpedSWf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eda3a38ceso16359805ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759296036; x=1759900836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH4GQA68OgOjz0m0FNs9gjF+dMkismSV7fAIc1tlIUY=;
        b=RTpedSWfmzZlYOIPT2XNjXY4FEI9oOyWONu3q7WjbFfC+GPbqUalwkwQ8xXjPasyQ0
         0VkcvSYJ+jxZz2CDg3nOJU1q+rpVB/CaKC6BNnPok8P+ScQ2xHTVdv3YQyp7FFCueMUm
         N5w/39fVbNn7h8xFwJNIuR8inQR72tx+CMjWiOtbhiXFfCgo9SJkrGIuK36MiB92ONP4
         RW5XHNLckn1jkit6Av+N5lNQ301R9adOT5X73P5i10EJ5nBIt58ojb31nszLQ197QbFr
         fNl/dnhNKINtHctVlwvf69OcrTgbFiU3MHM/+ao6cC6cuQki5c4VbFkqsdpFfCyYUCR+
         ojMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759296036; x=1759900836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH4GQA68OgOjz0m0FNs9gjF+dMkismSV7fAIc1tlIUY=;
        b=ZSMWZw3YzWr6Dd3BR+J6neXDJhv4ZgEyXbFZtiHsAX1OnNmH8SLWKHQSrnvu0s5Pdm
         HmLuJnrfZ6lFqBY8bxx24HOy9oTf5Qt0hQGNC1H1BSoWdv7YiaoOBCvUYO6nnX6mxBOd
         nSVWBLRrpvSVqH/A/iySUYTkF0dAG+9HPiVYe88xTzAhVO/rqqtFfW2+0r9Pim1vw3Y7
         f6JWNClzHNBU6OZRIy5vbZ6KE5vxn7ZTRyDyNKrrISxgVzbTzFwatYZpwrjD2F2piG1l
         MiNsUa4lYSfYfK7AX9TnKTQIYAf+V03Mj6wkN5u5u0vCaH0gen9JdD5MikFlZ5paDn4I
         QFTg==
X-Forwarded-Encrypted: i=1; AJvYcCUq4HDfi6/MWT3zzg1EHcyELnVr/iQN6XHwQOvKJ7W/FjnaQ9WXMEPKda0Kn4p0Ei0tQ6SW8DnkrmbjT04Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDCxEYaR+VqF8y9qIpu6OOlLPwO6bfyiKY74oVqetkKAifxX/
	vmkPGkMIOO2h5BanRELA2xIrL54D4fCfGKrHB6guUfHJQbgPB0S/Y6HZ
X-Gm-Gg: ASbGncsE7rYL1drVToY82P8X/EYKGK8aUuFKYR8W5IkvTIhCF3C7zF7tD9ObNc42UN2
	192XihQCCNRLqwvCVzrv40l3bmbF2AKOHO43Dyb0yXwwPCPrZp++VceobqpYGCTv2pgoTNo+x4Q
	Q/ieJ4ocDHyRBtoKI2k6p4TWFy0hzQVibkRa2ZbA07LozMU4b9GdeKGdy1yDNLhhafbMAYJ2sd3
	/ShI5XAPcy4ybz4K5I+1wid5gNb/s5UWQa79y9NYP6PaS8IdyStVR9bFXAfwTTnYJJIKk/SLckf
	+ll+rkDnyCkQ71TQjw/we66pD+xaA/0L5yNOPiJC15I9NWbP/4dvEl4dtdJpGVvALx1e8A+PEes
	xswgBRTOJ2RxAcKjmb1OXyYnjy90TBehClcO/p+RQHSBcKhjW95rLUoxQFR6uFkac91y5ky49GU
	VZ9N0i1Thc+ZmzYDkxeQE=
X-Google-Smtp-Source: AGHT+IEQBKkMmRJFhaLk6aiUUkZoMWjQ9aJLtNwc/fNJqUJtv9OSvqT5Ztf+nL1s0I42Kh7r/e+d+g==
X-Received: by 2002:a17:903:41d0:b0:273:a653:bacf with SMTP id d9443c01a7336-28e7ec78ddbmr14326235ad.0.1759296035825;
        Tue, 30 Sep 2025 22:20:35 -0700 (PDT)
Received: from [172.20.45.103] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671738esm176840585ad.46.2025.09.30.22.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 22:20:34 -0700 (PDT)
Message-ID: <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Date: Tue, 30 Sep 2025 22:20:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning caused
 by lock dependency in elv_iosched_store
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
 sth@linux.ibm.com, gjoyce@ibm.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
Content-Language: en-CA
From: Kyle Sanderson <kyle.leet@gmail.com>
In-Reply-To: <20250730074614.2537382-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/2025 12:46 AM, Nilay Shroff wrote:
> To address this, move all sched_tags allocations and deallocations outside
> of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
> the elevator queue and its associated sched_tags is closely tied, the
> allocated sched_tags are now stored in the elevator queue structure. Then,
> during the actual elevator switch (which runs under ->freeze_lock and
> ->elevator_lock), the pre-allocated sched_tags are assigned to the
> appropriate q->hctx. Once the elevator switch is complete and the locks
> are released, the old elevator queue and its associated sched_tags are
> freed.
> ...
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Hi Nilay,

I am coming off of a 36 hour travel stint, and 6.16.7 (I do not have 
that log, and it mightily messed up my xfs root requiring offline 
repair), 6.16.9, and 6.17.0 simply do not boot on my system. After 
unlocking with LUKS I get this panic consistently and immediately, and I 
believe this is the problematic commit which was unfortunately carried 
to the previous and current stable. I am using this udev rule: 
`ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", 
ATTR{queue/scheduler}="bfq"`

 > Sep 30 21:19:39 moon kernel: io scheduler bfq registered
 > Sep 30 21:19:39 moon kernel: ------------[ cut here ]------------
 > Sep 30 21:19:39 moon kernel: kernel BUG at mm/slub.c:563!
 > Sep 30 21:19:39 moon kernel: Oops: general protection fault, probably 
for non-canonical address 0x2cdf52296eacb08: 0000 [#1] SMP NOPTI
 > Sep 30 21:19:39 moon kernel: CPU: 2 UID: 0 PID: 791 Comm: 
(udev-worker) Not tainted 6.17.0-061700-generic #202509282239 
PREEMPT(voluntary)
 > Sep 30 21:19:39 moon kernel: Hardware name: Supermicro Super 
Server/A2SDi-8C-HLN4F, BIOS 2.0 03/08/2024
 > Sep 30 21:19:39 moon kernel: RIP: 0010:kfree+0x6b/0x360
 > Sep 30 21:19:39 moon kernel: Code: 80 48 01 d8 0f 82 f6 02 00 00 48 
c7 c2 00 00 00 80 48 2b 15 af 3f 61 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 
48 03 05 8d 3f 61 01 <48> 8b 50 08 49 89 c4 f6 c2 01 0f 85 2f 02 00 00 
0f 1f 44 00 00 41
 > Sep 30 21:19:39 moon kernel: RSP: 0018:ffffc9e804257930 EFLAGS: 00010207
 > Sep 30 21:19:39 moon kernel: RAX: 02cdf52296eacb00 RBX: 
b37de27a3ab2cae5 RCX: 0000000000000000
 > Sep 30 21:19:39 moon kernel: RDX: 000076bb00000000 RSI: 
ffffffff983b7c31 RDI: b37de27a3ab2cae5
 > Sep 30 21:19:39 moon kernel: RBP: ffffc9e804257978 R08: 
0000000000000000 R09: 0000000000000000
 > Sep 30 21:19:39 moon kernel: R10: 0000000000000000 R11: 
0000000000000000 R12: ffff894589365840
 > Sep 30 21:19:39 moon kernel: R13: ffff89458c7c20e0 R14: 
0000000000000000 R15: ffff89458c7c20e0
 > Sep 30 21:19:39 moon kernel: FS:  0000721ca92168c0(0000) 
GS:ffff898464f80000(0000) knlGS:0000000000000000
 > Sep 30 21:19:39 moon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
 > Sep 30 21:19:39 moon kernel: CR2: 00005afd46663fc8 CR3: 
0000000111bf4000 CR4: 00000000003506f0
 > Sep 30 21:19:39 moon kernel: Call Trace:
 > Sep 30 21:19:39 moon kernel:  <TASK>
 > Sep 30 21:19:39 moon kernel:  ? kfree+0x2dd/0x360
 > Sep 30 21:19:39 moon kernel:  kvfree+0x31/0x40
 > Sep 30 21:19:39 moon kernel:  blk_mq_free_tags+0x4b/0x70
 > Sep 30 21:19:39 moon kernel:  blk_mq_free_map_and_rqs+0x4d/0x70
 > Sep 30 21:19:39 moon kernel:  blk_mq_free_sched_tags+0x35/0x90
 > Sep 30 21:19:39 moon kernel:  elevator_change_done+0x53/0x200
 > Sep 30 21:19:39 moon kernel:  elevator_change+0xdf/0x190
 > Sep 30 21:19:39 moon kernel:  elv_iosched_store+0x151/0x190
 > Sep 30 21:19:39 moon kernel:  queue_attr_store+0xf1/0x120
 > Sep 30 21:19:39 moon kernel:  ? putname+0x65/0x90
 > Sep 30 21:19:39 moon kernel:  ? aa_file_perm+0x54/0x2e0
 > Sep 30 21:19:39 moon kernel:  ? _copy_from_iter+0x9d/0x690
 > Sep 30 21:19:39 moon kernel:  sysfs_kf_write+0x6f/0x90
 > Sep 30 21:19:39 moon kernel:  kernfs_fop_write_iter+0x15e/0x210
 > Sep 30 21:19:39 moon kernel:  vfs_write+0x271/0x490
 > Sep 30 21:19:39 moon kernel:  ksys_write+0x6f/0xf0
 > Sep 30 21:19:39 moon kernel:  __x64_sys_write+0x19/0x30
 > Sep 30 21:19:39 moon kernel:  x64_sys_call+0x79/0x2330
 > Sep 30 21:19:39 moon kernel:  do_syscall_64+0x80/0xac0
 > Sep 30 21:19:39 moon kernel:  ? 
arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 > Sep 30 21:19:39 moon kernel:  ? do_syscall_64+0xb6/0xac0
 > Sep 30 21:19:39 moon kernel:  ? 
arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 > Sep 30 21:19:39 moon kernel:  ? __seccomp_filter+0x47/0x5d0
 > Sep 30 21:19:39 moon kernel:  ? __x64_sys_fcntl+0x97/0x130
 > Sep 30 21:19:39 moon kernel:  ? 
arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 > Sep 30 21:19:39 moon kernel:  ? do_syscall_64+0xb6/0xac0
 > Sep 30 21:19:39 moon kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 > Sep 30 21:19:39 moon kernel: RIP: 0033:0x721ca911c5a4
 > Sep 30 21:19:39 moon kernel: Code: c7 00 16 00 00 00 b8 ff ff ff ff 
c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d a5 ea 0e 00 00 74 13 
b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 
48 83 ec 20 48 89
 > Sep 30 21:19:39 moon kernel: RSP: 002b:00007ffdfffb8b58 EFLAGS: 
00000202 ORIG_RAX: 0000000000000001
 > Sep 30 21:19:39 moon kernel: RAX: ffffffffffffffda RBX: 
0000000000000003 RCX: 0000721ca911c5a4
 > Sep 30 21:19:39 moon kernel: RDX: 0000000000000003 RSI: 
00007ffdfffb8df0 RDI: 000000000000002a
 > Sep 30 21:19:39 moon kernel: RBP: 00007ffdfffb8b80 R08: 
0000721ca9202228 R09: 00007ffdfffb8bd0
 > Sep 30 21:19:39 moon kernel: R10: 0000000000000000 R11: 
0000000000000202 R12: 0000000000000003
 > Sep 30 21:19:39 moon kernel: R13: 00007ffdfffb8df0 R14: 
00005afd465c5100 R15: 0000000000000003
 > Sep 30 21:19:39 moon kernel:  </TASK>
 > Sep 30 21:19:39 moon kernel: Modules linked in: bfq nfsd tcp_bbr 
sch_fq auth_rpcgss nfs_acl lockd grace nvme_fabrics efi_pstore sunrpc 
nfnetlink dmi_sysfs ip_tables x_tables autofs4 xfs btrfs blake2b_generic 
dm_crypt raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor asy>
 > Sep 30 21:19:39 moon kernel: Oops: general protection fault, probably 
for non-canonical address 0x3ce12d676eacb08: 0000 [#2] SMP NOPTI
 > Sep 30 21:19:39 moon kernel: ---[ end trace 0000000000000000 ]---
 > Sep 30 21:19:39 moon kernel: CPU: 3 UID: 0 PID: 792 Comm: 
(udev-worker) Tainted: G      D             6.17.0-061700-generic 
#202509282239 PREEMPT(voluntary)
 > Sep 30 21:19:39 moon kernel: Tainted: [D]=DIE
 > Sep 30 21:19:39 moon kernel: Hardware name: Supermicro Super 
Server/A2SDi-8C-HLN4F, BIOS 2.0 03/08/2024
 > Sep 30 21:19:39 moon kernel: RIP: 0010:kfree+0x6b/0x360
 > Sep 30 21:19:40 moon kernel: Code: 80 48 01 d8 0f 82 f6 02 00 00 48 
c7 c2 00 00 00 80 48 2b 15 af 3f 61 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 
48 03 05 8d 3f 61 01 <48> 8b 50 08 49 89 c4 f6 c2 01 0f 85 2f 02 00 00 
0f 1f 44 00 00 41
 > Sep 30 21:19:40 moon kernel: RSP: 0018:ffffc9e80425f990 EFLAGS: 00010207
 > Sep 30 21:19:40 moon kernel: RAX: 03ce12d676eacb00 RBX: 
f3854f723ab2cae5 RCX: 0000000000000000
 > Sep 30 21:19:40 moon kernel: RDX: 000076bb00000000 RSI: 
ffffffff983b7c31 RDI: f3854f723ab2cae5
 > Sep 30 21:19:40 moon kernel: RBP: ffffc9e80425f9d8 R08: 
0000000000000000 R09: 0000000000000000
 > Sep 30 21:19:40 moon kernel: R10: 0000000000000000 R11: 
0000000000000000 R12: ffff894580056160
 > Sep 30 21:19:40 moon kernel: R13: ffff89458c7c20e0 R14: 
0000000000000000 R15: ffff89458c7c20e0
 > Sep 30 21:19:40 moon kernel: FS:  0000721ca92168c0(0000) 
GS:ffff898465000000(0000) knlGS:0000000000000000
 > Sep 30 21:19:40 moon kernel: RIP: 0010:kfree+0x6b/0x360
 > Sep 30 21:19:40 moon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
 > Sep 30 21:19:40 moon kernel: Code: 80 48 01 d8 0f 82 f6 02 00 00 48 
c7 c2 00 00 00 80 48 2b 15 af 3f 61 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 
48 03 05 8d 3f 61 01 <48> 8b 50 08 49 89 c4 f6 c2 01 0f 85 2f 02 00 00 
0f 1f 44 00 00 41
 > Sep 30 21:19:40 moon kernel: CR2: 00007ffdfffb5b70 CR3: 
000000010c1aa000 CR4: 00000000003506f0
 > Sep 30 21:19:40 moon kernel: RSP: 0018:ffffc9e804257930 EFLAGS: 00010207
 > Sep 30 21:19:40 moon kernel: Call Trace:
 > Sep 30 21:19:40 moon kernel:
 > Sep 30 21:19:40 moon kernel: RAX: 02cdf52296eacb00 RBX: 
b37de27a3ab2cae5 RCX: 0000000000000000
 > Sep 30 21:19:40 moon kernel:  <TASK>
 > Sep 30 21:19:40 moon kernel:  ? kfree+0x2dd/0x360
 > Sep 30 21:19:40 moon kernel: RDX: 000076bb00000000 RSI: 
ffffffff983b7c31 RDI: b37de27a3ab2cae5
 > Sep 30 21:19:40 moon kernel:  kvfree+0x31/0x40
 > Sep 30 21:19:40 moon kernel:  blk_mq_free_tags+0x4b/0x70
 > Sep 30 21:19:40 moon kernel:  blk_mq_free_map_and_rqs+0x4d/0x70
 > Sep 30 21:19:40 moon kernel: RBP: ffffc9e804257978 R08: 
0000000000000000 R09: 0000000000000000
 > Sep 30 21:19:40 moon kernel:  blk_mq_free_sched_tags+0x35/0x90
 > Sep 30 21:19:40 moon kernel: R10: 0000000000000000 R11: 
0000000000000000 R12: ffff894589365840
 > Sep 30 21:19:40 moon kernel:  elevator_change_done+0x53/0x200




