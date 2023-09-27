Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154FE7AFA48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjI0FrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 01:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjI0Fqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:46:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37FCFB;
        Tue, 26 Sep 2023 22:36:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c328b53aeaso92557875ad.2;
        Tue, 26 Sep 2023 22:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695793018; x=1696397818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5K+YRG5hEOKPK/kmH64oQd5ruJEAzi5Tg3xBRrxYzk=;
        b=B0K7lAp1JwVX/J0r3BdSJrcoFedWjtfaWNKJzid9PR34woY9v4ezw0mAHT2AB4+7P8
         62vL5ue4nmE9mwsugbR9QTv/PL6AhRxVILcRmhqqE0T0WP7pSWZJlG/3WOftiAQgCoJn
         6++cBrymicbP1lJOZ4ILf6D9h5gz64lkAmrTUMQuaXMz6YGDwoNL1NqlIC66MnR3h16/
         7MFcP7pvbo2u8jMOvQPwTTq4YxU6zEYDSSlhE9MjgMVEoH0ZMt3I3te6gkl8BKdkivqc
         r58DDkbj28f+JhESGxWP+GtVv7w9bVZfOXJLqRGUR6PaqHDrEj5DqaBA1HeahtQaidm1
         8eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695793018; x=1696397818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5K+YRG5hEOKPK/kmH64oQd5ruJEAzi5Tg3xBRrxYzk=;
        b=WhDcjHwswPgkZhdLUEe79jxZG9Az3Reh/hpVHv+olc+lz++iX1VA+OcIuYSwBb14mA
         tLdG9t9NGzMMXMPcslxMayraj/IkQYB6pNwmZlNt2Q0JquNLR741WVuXuyEAAVTTNzw9
         iDAWbwhXmCKJvp9Tb7SV5Tk9irnAeAev73c3TbguKxxSFlmzm0mz3MQJNi4ybJF2Ol3v
         5BBzJMl6ogRKs0IjI23v+Mm1xWTtta/ORzptCAVCMegjQ28Hbq2n2FdZHKYwbrlaHNef
         cJxvtQ1ZYevnK+jhlY2GLSccPRRZWOvt5cNMrLY2CYiNFNx1x6vH1V7KPKjjRYeUUGI2
         ikrA==
X-Gm-Message-State: AOJu0YxAlnD7/XYvATR0VO0pikeJRmxSNYQfo1LTFN7A1hoX/6qEfc6t
        Ld6vA32AcEtduoFu/TwzJD4=
X-Google-Smtp-Source: AGHT+IFN4heEvUer+8gFJIklOaZkFFkAm1hR3qOkt+vqDOUafnU5Y4o6XGI+3Aqa5UhYIYKD317NGA==
X-Received: by 2002:a17:902:e549:b0:1bf:2e5c:7367 with SMTP id n9-20020a170902e54900b001bf2e5c7367mr1042791plf.42.1695793018271;
        Tue, 26 Sep 2023 22:36:58 -0700 (PDT)
Received: from ?IPV6:ddf2:f99b:21f4::3? ([2401:5a0:1000:1e::a])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001c60635c13esm7558557plb.115.2023.09.26.22.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 22:36:57 -0700 (PDT)
Message-ID: <b290c417-de1b-4af8-9f5e-133abb79580d@gmail.com>
Date:   Wed, 27 Sep 2023 13:36:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   dianlujitao@gmail.com
Subject: Re: Fwd: kernel bug when performing heavy IO operations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
References: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
 <ZOrG5698LPKTp5xM@casper.infradead.org>
 <7d8b4679-5cd5-4ba1-9996-1a239f7cb1c5@gmail.com>
 <ZOs5j93aAmZhrA/G@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZOs5j93aAmZhrA/G@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, I got some logs with 6.5.4 kernel from the official linux package 
of Arch, no zen patches this time. Full dmesg is uploaded to 
https://fars.ee/F1yM and below is a small snippet for your convenience, 
from which PG_offline is no longer set:

[177850.039441] BUG: Bad page map in process ld.lld pte:8000000edacc4025 
pmd:147f96067
[177850.039454] page:000000007415dd6c refcount:22 mapcount:-237 
mapping:00000000b0c37ca6 index:0x1075 pfn:0xedacc4
[177850.039460] memcg:ffff9289345d4000
[177850.039463] aops:btrfs_aops [btrfs] ino:fb2b838 dentry name:"lld"
[177850.039592] flags: 
0xaffff9800002056(referenced|uptodate|lru|workingset|private|node=1|zone=2|lastcpupid=0xffff)
[177850.039597] page_type: 0xffffff12(buddy|0x6d)
[177850.039602] raw: 0affff9800002056 ffffe7623b6b3148 ffffe7623b6b3088 
ffff928202a9fc10
[177850.039605] raw: 0000000000001075 0000000000000001 00000016ffffff12 
ffff9289345d4000
[177850.039607] page dumped because: bad pte
[177850.039608] addr:0000000001275000 vm_flags:08000071 
anon_vma:0000000000000000 mapping:ffff928202a9fc10 index:1075
[177850.039612] file:lld fault:filemap_fault mmap:btrfs_file_mmap 
[btrfs] read_folio:btrfs_read_folio [btrfs]
[177850.039846] CPU: 40 PID: 2060138 Comm: ld.lld Tainted: G           
OE      6.5.4-arch2-1 #1 a30a3b4701899b64bf6025fd97642e50bf2dcad4
[177850.039851] Hardware name: JGINYUE X99-8D3/2.5G Server/X99-8D3/2.5G 
Server, BIOS 5.11 06/30/2022
[177850.039853] Call Trace:
[177850.039857]  <TASK>
[177850.039864]  dump_stack_lvl+0x47/0x60
[177850.039871]  print_bad_pte+0x1bc/0x280
[177850.039879]  ? page_remove_rmap+0x8d/0x260
[177850.039885]  unmap_page_range+0xa96/0x1150
[177850.039894]  unmap_vmas+0xf8/0x190
[177850.039900]  exit_mmap+0xe4/0x310
[177850.039909]  __mmput+0x3e/0x130
[177850.039916]  do_exit+0x31c/0xb20
[177850.039920]  ? futex_wait_queue+0x63/0x90
[177850.039927]  do_group_exit+0x31/0x80
[177850.039932]  get_signal+0x9a5/0x9e0
[177850.039941]  arch_do_signal_or_restart+0x3e/0x270
[177850.039947]  exit_to_user_mode_prepare+0x185/0x1e0
[177850.039955]  syscall_exit_to_user_mode+0x1b/0x40
[177850.039962]  do_syscall_64+0x6c/0x90
[177850.039969]  ? do_futex+0x128/0x190
[177850.039973]  ? __x64_sys_futex+0x129/0x1e0
[177850.039977]  ? switch_fpu_return+0x50/0xe0
[177850.039986]  ? syscall_exit_to_user_mode+0x2b/0x40
[177850.039991]  ? do_syscall_64+0x6c/0x90
[177850.039996]  ? exc_page_fault+0x7f/0x180
[177850.040002]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[177850.040009] RIP: 0033:0x7f1851e164ae
[177850.040056] Code: Unable to access opcode bytes at 0x7f1851e16484.
[177850.040058] RSP: 002b:00007f18227fbd30 EFLAGS: 00000246 ORIG_RAX: 
00000000000000ca
[177850.040063] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
00007f1851e164ae
[177850.040066] RDX: 0000000000000000 RSI: 0000000000000189 RDI: 
0000000005818134
[177850.040068] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00000000ffffffff
[177850.040070] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[177850.040072] R13: 00000000058180e0 R14: 0000000000000000 R15: 
0000000005818134
[177850.040078]  </TASK>
[177850.040112] Disabling lock debugging due to kernel taint

在 2023/8/27 19:54, Matthew Wilcox 写道:
> On Sun, Aug 27, 2023 at 12:34:54PM +0800, dianlujitao wrote:
>> 在 2023/8/27 11:45, Matthew Wilcox 写道:
>>> On Sun, Aug 27, 2023 at 10:20:51AM +0700, Bagas Sanjaya wrote:
>>>>> When the IO load is heavy (compiling AOSP in my case), there's a chance to crash the kernel, the only way to recover is to perform a hard reset. Logs look like follows:
>>>>>
>>>>> 8月 25 13:52:23 arch-pc kernel: BUG: Bad page map in process tmux: client  pte:8000000462500025 pmd:b99c98067
>>>>> 8月 25 13:52:23 arch-pc kernel: page:00000000460fa108 refcount:4 mapcount:-256 mapping:00000000612a1864 index:0x16 pfn:0x462500
>>>>> 8月 25 13:52:23 arch-pc kernel: memcg:ffff8a1056ed0000
>>>>> 8月 25 13:52:23 arch-pc kernel: aops:btrfs_aops [btrfs] ino:9c4635 dentry name:"locale-archive"
>>>>> 8月 25 13:52:23 arch-pc kernel: flags: 0x2ffff5800002056(referenced|uptodate|lru|workingset|private|node=0|zone=2|lastcpupid=0xffff)
>>>>> 8月 25 13:52:23 arch-pc kernel: page_type: 0xfffffeff(offline)
>>> This is interesting.  PG_offline is set.
>>>
>>> $ git grep SetPageOffline
>>> arch/powerpc/platforms/powernv/memtrace.c:              __SetPageOffline(pfn_to_page(pfn));
>>> drivers/hv/hv_balloon.c:                        __SetPageOffline(pg);
>>> drivers/hv/hv_balloon.c:                        __SetPageOffline(pg + j);
>>> drivers/misc/vmw_balloon.c:             __SetPageOffline(page + i);
>>> drivers/virtio/virtio_mem.c:            __SetPageOffline(page);
>>> drivers/xen/balloon.c:  __SetPageOffline(page);
>>> include/linux/balloon_compaction.h:     __SetPageOffline(page);
>>> include/linux/balloon_compaction.h:     __SetPageOffline(page);
>>>
>>> But there's no indication that this kernel is running under a
>>> hypervisor:
>>>
>>>>> 8月 25 13:52:23 arch-pc kernel: Hardware name: JGINYUE X99-8D3/2.5G Server/X99-8D3/2.5G Server, BIOS 5.11 06/30/2022
>> Yes, I'm running on bare metal hardware.
>>> So I'd agree with Artem, this looks like bad RAM.
>>>
>> I ran memtest86+ 6.20 for a cycle and it passed. However, could an OOM
>> trigger the bug? e.g., kernel bug fired before the OOM killer has a
>> chance to start? Just a guess because the last log entry in journalctl
>> before "BUG" is an hour earlier.
> The problem is that OOM doesn't SetPageOffline.  The only things that
> do are hypervisor guest drivers.  So we've got a random bit being
> cleared, and either that's a stray write which happens to land in
> the struct page in question, or it's bad hardware.  Since it's a
> single bit that's being cleared, bad hardware is the most likely
> explanation, but it's not impossible for there to be a bug that's
> doing this.  The problem is that it could be almost anything ...
