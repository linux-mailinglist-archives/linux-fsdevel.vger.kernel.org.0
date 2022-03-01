Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE14C893A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 11:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiCAK26 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 1 Mar 2022 05:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCAK26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:28:58 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 02:28:16 PST
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E03E4F9F5;
        Tue,  1 Mar 2022 02:28:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D7119609B3C0;
        Tue,  1 Mar 2022 11:11:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uHtvGrDw6G89; Tue,  1 Mar 2022 11:11:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 77E61609B3F0;
        Tue,  1 Mar 2022 11:11:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V9Nv3lnaehro; Tue,  1 Mar 2022 11:11:57 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 47DDE609B3C0;
        Tue,  1 Mar 2022 11:11:57 +0100 (CET)
Date:   Tue, 1 Mar 2022 11:11:57 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     wuchi.zero@gmail.com
Cc:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        jack@suse.cz, tj@kernel.org, mszeredi@redhat.com,
        sedat.dilek@gmail.com, axboe@fb.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2104629126.100059.1646129517209.JavaMail.zimbra@nod.at>
Subject: Different writeback timing since v5.14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 5JNzjBL9+smBCCGCkEapAfbWm9hEtw==
Thread-Topic: Different writeback timing since v5.14
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

Rafał and I discovered that page writeback on UBIFS behaves different since v5.14.
When a simple write, such as "echo foo > /mnt/ubibfs/bar.txt", happens it takes
a few seconds until writeback calls ubifs_writepage().

Before commit ab19939a6a50 ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
it was 30 seconds (vm.dirty_expire_centisecs), after this change it happens after 5 seconds
(vm.dirty_writeback_centisecs).

Is this expected?
Just want to make sure that the said commit didn't uncover an UBIFS issue.

Thanks,
//richard
