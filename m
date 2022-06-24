Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAD55A41A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiFXV6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXV6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDECAE64;
        Fri, 24 Jun 2022 14:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D41CD623B2;
        Fri, 24 Jun 2022 21:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0D5C34114;
        Fri, 24 Jun 2022 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656107910;
        bh=5YFeqwxdjc3fwTrtujjbrPr3mh+R06xBDHB85uY2Hxw=;
        h=Date:From:To:Cc:Subject:From;
        b=Y+euUHggVXMEUss3N4As1UeCTwuLi98SThSF/PPaIK9QawD9q9PvFirgDzZWE+IQk
         taJ8xiRi8RDH5d3TUH4Vj7RHNo6W8nywNbuY8UlqtcNTsg50uruJaf7VADFPRJulsZ
         Xrlhbmwxg0SYoQXNeUEUhAzJp3AIXSNk6v62PHM2XM2v1byHO86sS/txpafOVEXdIT
         6ouCAnspr4VLAx1FLFnjgoCH+t7GiTM7HJuBoZGWZAlYT32biHpr/DqXdSxrwXbHgk
         Fr5D2bIDHLs5BxLjpw1Nzl8fOwIsPcqACzBJnRr5EOWAacPvBpUepthMgldd8bi52R
         HfvqxfEyiI/7g==
Date:   Fri, 24 Jun 2022 14:58:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org
Subject: Triggered assertion from "mm: Add an assertion that PG_private and
 folio->private are in sync"
Message-ID: <YrYzhB7aDNIBz/uV@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I bisected a boot failure on one of my test machines to your commit
c462f63731e0 ("mm: Add an assertion that PG_private and folio->private
are in sync"), which landed in next-20220624. I didn't see this patch
posted to any mailing list on lore, hence this separate thread;
apologies if it was and I missed it. I didn't see this reported yet but
I see the assertion triggered when systemd-zram-setup@zram0 runs:

zram0: detected capacity change from 0 to 16777216
page:00000000fed1c582 refcount:1 mapcount:33 mapping:000000007b9116a6 index:0xfffffda990ac2640 pfn:0x20b5278
aops:zsmalloc_aops ino:488c
flags: 0x2ffff000000001(locked|node=0|zone=2|lastcpupid=0xffff)
raw: 002ffff000000001 0000000000000000 dead000000000122 ffff6a6422c621fa
raw: fffffda990ac2640 ffff6a642a1e5e40 0000000100000020 0000000000000000
page dumped because: VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio) && (folio_test_private(folio) == !folio_get_private(folio)))
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1560!
Internal error: Oops - BUG: 0 [#1] SMP
Modules linked in: zram xfs fsl_dpaa2_eth pcs_lynx phylink ahci_qoriq crct10dif_ce ghash_ce sbsa_gwdt fsl_mc_dpio nvme nvme_core xhci_plat_hcd lm90 rtc_fsl_ftm_alarm at803x xgmac_mdio ahci_platform i2c_imx ip6_tables ip_tables ipmi_devintf ipmi_msghandler fuse
CPU: 0 PID: 813 Comm: mkswap Not tainted 5.19.0-rc3-00032-gc462f63731e0 #1
Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : folio_unlock+0x98/0x9c
lr : folio_unlock+0x98/0x9c
sp : ffff8000095bb680
x29: ffff8000095bb680 x28: 0000000000001000 x27: 0000000000000000
x26: 0000000000001000 x25: ffff6a642ab48000 x24: 0000000000000001
x23: 0020b59770000000 x22: ffff6a642a1e5e40 x21: 0000000000000001
x20: ffff6a642a802000 x19: fffffda990d49e00 x18: 0000000000000020
x17: 696c6f662864656b x16: 636162706177735f x15: 747365745f6f696c
x14: 6f6621284f494c4f x13: 2929296f696c6f66 x12: 0000000000000018
x11: 0000000000000000 x10: 0000000000000027 x9 : 0000000000000002
x8 : 0000000100000002 x7 : 6163656220646570 x6 : 6d75642065676170
x5 : ffffa31574652d6f x4 : 6f696c6f66286574 x3 : 65745f6f696c6f66
x2 : 80000000ffffe314 x1 : ffffa31573961a43 x0 : 000000000000007f
Call trace:
 folio_unlock+0x98/0x9c
 unlock_page+0x28/0x58
 SetZsPageMovable+0x74/0x100
 zs_malloc+0x218/0x234
 __zram_bvec_write+0x158/0x458 [zram]
 zram_bvec_rw+0x94/0x194 [zram]
 zram_submit_bio+0x1a4/0x240 [zram]
 __submit_bio+0x88/0x2f0
 submit_bio_noacct_nocheck+0xa4/0x1d8
 submit_bio_noacct+0x2e4/0x40c
 submit_bio+0x100/0x13c
 submit_bh_wbc+0x158/0x1a0
 __block_write_full_page+0x39c/0x700
 block_write_full_page+0x98/0xac
 blkdev_writepage+0x28/0x34
 __writepage+0x2c/0xbc
 write_cache_pages+0x1e4/0x44c
 generic_writepages+0x54/0x80
 blkdev_writepages+0x1c/0x28
 do_writepages+0xd8/0x1c8
 filemap_fdatawrite_wbc+0x80/0xa4
 file_write_and_wait_range+0x78/0xdc
 blkdev_fsync+0x24/0x48
 __arm64_sys_fsync+0x74/0xb0
 invoke_syscall+0x78/0x118
 el0_svc_common+0x94/0xfc
 do_el0_svc+0x38/0xc0
 el0_svc+0x34/0x110
 el0t_64_sync_handler+0x84/0xf0
 el0t_64_sync+0x190/0x194
Code: 17fffff5 90009781 9137e021 9401212e (d4210000)
---[ end trace 0000000000000000 ]---
note: mkswap[813] exited with preempt_count 3
------------[ cut here ]------------

If there is any additional information I can provide or patches I can
test, I am more than happy to do so.

Cheers,
Nathan
