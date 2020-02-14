Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25B15FA2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 00:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBNXDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 18:03:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48003 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727620AbgBNXDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581721429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLyecxtzQ20swRYEBPr26QSneSr63ZyhKts66QMgLU4=;
        b=c7zes+TSUgzz1BfadAYosvJDRfcyeg/k2wN2PC9sY44yaK7HqDvLBLsW68fEdJ7tWD9Mgq
        MT5BUkKNKfHQ91Q7+iA2etfZbAHaDie4Tg9G/uA+VAAWpe4fz003lP8WXigoITP4cKEIz9
        7ubB7S9FWPkeRFnRcBrNYcOONqcmfFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-wWuEVOUANQeUCH3-mJKnAQ-1; Fri, 14 Feb 2020 18:03:45 -0500
X-MC-Unique: wWuEVOUANQeUCH3-mJKnAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A228010EF;
        Fri, 14 Feb 2020 23:03:43 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43B8A87B11;
        Fri, 14 Feb 2020 23:03:41 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
References: <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
        <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
        <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
        <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
        <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
        <20200213195839.GG6870@magnolia>
        <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
        <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
        <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
        <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
        <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
        <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
        <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Feb 2020 18:03:40 -0500
In-Reply-To: <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Fri, 14 Feb 2020 17:58:10 -0500")
Message-ID: <x49pnegbwkz.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> writes:

> Hi, Ira,
>
> Jeff Moyer <jmoyer@redhat.com> writes:
>
>> I'll try to get some testing in on this series, now.
>
> This series panics in xfstests generic/013, when run like so:
>
> MKFS_OPTIONS="-m reflink=0" MOUNT_OPTIONS="-o dax" ./check -g auto
>
> I'd dig in further, but it's late on a Friday.  You understand.  :)

Sorry, I should have at least given you a clue.  Below is the stack
trace.  We're going down the buffered I/O path, even though the fs is
mounted with -o dax.  Somewhere the inode isn't getting marked properly.

-Jeff

[  549.461099] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  549.468053] #PF: supervisor instruction fetch in kernel mode
[  549.473713] #PF: error_code(0x0010) - not-present page
[  549.478851] PGD 17c7e06067 P4D 17c7e06067 PUD 17c7e01067 PMD 0 
[  549.484773] Oops: 0010 [#1] SMP NOPTI
[  549.488438] CPU: 68 PID: 19851 Comm: fsstress Not tainted 5.6.0-rc1+ #42
[  549.495134] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0395.022720191340 02/27/2019
[  549.505562] RIP: 0010:0x0
[  549.508186] Code: Bad RIP value.
[  549.511418] RSP: 0018:ffffab132dc9fa98 EFLAGS: 00010246
[  549.516642] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[  549.523768] RDX: 0000000000000000 RSI: ffffdcf75e7060c0 RDI: ffff8c3805d22300
[  549.530900] RBP: ffffab132dc9fb08 R08: 0000000000000000 R09: 00002308a18f9f3f
[  549.538030] R10: 0000000000000000 R11: ffffdcf75f4b19c0 R12: ffff8c37cfe6d2b8
[  549.545155] R13: ffffab132dc9fb60 R14: ffffdcf75e7060c8 R15: ffffdcf75e7060c0
[  549.552288] FS:  00007f849d20cb80(0000) GS:ffff8c3821100000(0000) knlGS:0000000000000000
[  549.560373] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  549.566117] CR2: ffffffffffffffd6 CR3: 00000017d3088005 CR4: 00000000007606e0
[  549.573250] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  549.580383] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  549.587515] PKRU: 55555554
[  549.590228] Call Trace:
[  549.592683]  read_pages+0x120/0x190
[  549.596173]  __do_page_cache_readahead+0x1c1/0x1e0
[  549.600965]  ondemand_readahead+0x182/0x2f0
[  549.605152]  generic_file_buffered_read+0x5a6/0xaf0
[  549.610032]  ? security_inode_permission+0x30/0x50
[  549.614824]  ? _cond_resched+0x15/0x30
[  549.618620]  xfs_file_buffered_aio_read+0x47/0xe0 [xfs]
[  549.623861]  xfs_file_read_iter+0x6e/0xd0 [xfs]
[  549.628394]  generic_file_splice_read+0x100/0x220
[  549.633099]  splice_direct_to_actor+0xd5/0x220
[  549.637543]  ? pipe_to_sendpage+0xa0/0xa0
[  549.641557]  do_splice_direct+0x9a/0xd0
[  549.645396]  vfs_copy_file_range+0x153/0x320
[  549.649667]  __x64_sys_copy_file_range+0xdd/0x200
[  549.654375]  do_syscall_64+0x55/0x1d0
[  549.658039]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  549.663091] RIP: 0033:0x7f849c7086bd
[  549.666671] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9b 67 2c 00 f7 d8 64 89 01 48
[  549.685414] RSP: 002b:00007fff81b78678 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
[  549.692980] RAX: ffffffffffffffda RBX: 00000000000000c9 RCX: 00007f849c7086bd
[  549.700112] RDX: 0000000000000004 RSI: 00007fff81b786b0 RDI: 0000000000000003
[  549.707242] RBP: 00000000005d92ef R08: 0000000000006cb4 R09: 0000000000000000
[  549.714375] R10: 00007fff81b786b8 R11: 0000000000000246 R12: 0000000000000003
[  549.721508] R13: 0000000000006cb4 R14: 0000000000037f58 R15: 0000000000365871
[  549.728641] Modules linked in: xt_CHECKSUM nft_chain_nat xt_MASQUERADE nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 nft_counter nft_compat nf_tables nfnetlink tun bridge stp llc rfkill sunrpc vfat fat intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iTCO_wdt iTCO_vendor_support kvm irqbypass crct10dif_pclmul ipmi_ssif crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore mei_me ipmi_si joydev intel_rapl_perf ioatdma pcspkr ipmi_devintf sg i2c_i801 lpc_ich mei dca ipmi_msghandler dax_pmem dax_pmem_core acpi_power_meter acpi_pad xfs libcrc32c nd_pmem nd_btt sd_mod sr_mod cdrom ast i2c_algo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec crc32c_intel i40e drm nvme ahci nvme_core libahci t10_pi libata wmi nfit libnvdimm
[  549.805384] CR2: 0000000000000000
[  549.808744] ---[ end trace 62568a4ecc43ee90 ]---

