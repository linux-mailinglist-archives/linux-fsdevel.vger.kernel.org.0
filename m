Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318F3694BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBMPy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 10:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBMPyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:54:24 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5006630CF;
        Mon, 13 Feb 2023 07:54:15 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pRb9e-0003qT-2v;
        Mon, 13 Feb 2023 16:54:11 +0100
Date:   Mon, 13 Feb 2023 15:54:04 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: regression in next-20230213: "splice: Do splice read from a buffered
 file without using ITER_PIPE"
Message-ID: <Y+pdHFFTk1TTEBsO@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

I'm Currently trying linux-next daily on various MediaTek ARM64 SoCs.
As of next-20230213 I'm now facing this bug:
[   30.119220] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   30.128134] Mem abort info:
[   30.130932]   ESR = 0x0000000086000006
[   30.134682]   EC = 0x21: IABT (current EL), IL = 32 bits
[   30.140009]   SET = 0, FnV = 0
[   30.143067]   EA = 0, S1PTW = 0
[   30.146210]   FSC = 0x06: level 2 translation fault
[   30.151151] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000048cbf000
[   30.157603] [0000000000000000] pgd=0800000049d82003, p4d=0800000049d82003, pud=0800000049d82003, pmd=0000000000000000
[   30.168412] Internal error: Oops: 0000000086000006 [#1] SMP
[   30.173972] Modules linked in: nft_fib_inet nf_flow_table_inet nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject_bridge nft_reject nft_redir nft_quota nft_numgen nft_nat nft_meta_bridge nft_masq nft_log nft_limit nft_hash nfs
[   30.174180]  usb_storage leds_gpio xhci_plat_hcd xhci_pci xhci_mtk_hcd xhci_hcd vfat fat usbcore usb_common
[   30.273791] CPU: 2 PID: 1232 Comm: cat Tainted: G           O       6.2.0-rc7-next-20230213+ #0
[   30.282469] Hardware name: Bananapi BPI-R3 (DT)
[   30.286985] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   30.293929] pc : 0x0
[   30.296108] lr : filemap_read_folio+0x40/0x214
[   30.300547] sp : ffffffc00a28b9a0
[   30.303848] x29: ffffffc00a28b9a0 x28: ffffff80079ce7c0 x27: 000000000000000f
[   30.310970] x26: ffffff80072f5500 x25: 0000000000000010 x24: fffffffe01f8dc40
[   30.318091] x23: 0000000000000000 x22: ffffffc00a28bb80 x21: ffffff80072f5500
[   30.325212] x20: 0000000000000000 x19: fffffffe01f8dc40 x18: 0000000000000000
[   30.332333] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   30.339454] x14: 0000000000000000 x13: ffffff807fb9b570 x12: 0000000000000001
[   30.346575] x11: 0000000000005242 x10: ffffffc0090c5d68 x9 : ffffffc076cb9000
[   30.353697] x8 : 0000000086a580b0 x7 : 0000000000000050 x6 : 000000000000141c
[   30.360819] x5 : 0000000007ffffff x4 : 0000000000000000 x3 : 0000000000000001
[   30.367939] x2 : 0000000000000000 x1 : fffffffe01f8dc40 x0 : ffffff80072f5500
[   30.375061] Call trace:
[   30.377496]  0x0
[   30.379325]  filemap_get_pages+0x254/0x604
[   30.383409]  generic_file_buffered_splice_read.constprop.0+0xc4/0x2dc
[   30.389836]  generic_file_splice_read+0x38/0x2a8
[   30.394440]  do_splice_to+0x90/0xdc
[   30.397916]  splice_file_to_pipe+0xd4/0xdc
[   30.402000]  do_sendfile+0x114/0x38c
[   30.405565]  __arm64_sys_sendfile64+0x138/0x17c
[   30.410083]  invoke_syscall.constprop.0+0x4c/0xdc
[   30.414775]  do_el0_svc+0x50/0xe8
[   30.418078]  el0_svc+0x34/0x84
[   30.421126]  el0t_64_sync_handler+0xec/0x118
[   30.425384]  el0t_64_sync+0x14c/0x150
[   30.429041] Code: ???????? ???????? ???????? ???????? (????????) 
[   30.435119] ---[ end trace 0000000000000000 ]---

I've traced it down to commit d9722a47571104f7fa1eeb5ec59044d3607c6070
("splice: Do splice read from a buffered file without using ITER_PIPE") and
reverting this commit and commit 82cf0207bed44feb0b3b8b17a4c351fdde34a97b
("iov_iter: Kill ITER_PIPE") fixes the issue.

I have no time to look into this any deeper, but I'm ready to test fixes you
may suggest.


Best regards


Daniel

