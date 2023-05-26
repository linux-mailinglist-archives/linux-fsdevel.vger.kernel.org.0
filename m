Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF7712FF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbjEZWWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbjEZWWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 18:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336D12A;
        Fri, 26 May 2023 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IzItOB3HiwfECPzC/ygFZaFi0mtHzGOxDJyi3k00e5g=; b=XhKaA/EFveChr6XSzEIIdk96Bd
        N/LzOSqRdpRE7noKTonD+Npx3tdNYEMg39PuqpF/5A+X7Rw+T8IQtL1E5EPqgyiVX0Oi4e6kd75pq
        U4hEQsQLOzOCu8bOewafR1MzBn2xWevyIAUl8L3vtHkl1jRfzAn8NZZGFDhr8vemSMCFa+BDB0Pt4
        /Uy2Fv3S28wHZaRMri6FbXMzWNqC4Rpplr5I2Njcr1wFuI2AOrDufkOQedrb1dGfZHJl9mjP7u7A2
        G5hlUz2qYXz+Uj9ZCPTx04v3CeLnTvYxH2HPb4GU9gyOs8xv1NMxN69hRutCYC51allOLJKCOcf00
        j46705Ig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2fp1-0047Uh-28;
        Fri, 26 May 2023 22:22:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        dave.hansen@intel.com, arnd@arndb.de, bp@alien8.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, christophe.jaillet@wanadoo.fr,
        kirill.shutemov@linux.intel.com, jroedel@suse.de
Cc:     j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/2] kernel/sysctl.c: remove to major base directories
Date:   Fri, 26 May 2023 15:22:04 -0700
Message-Id: <20230526222207.982107-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes on this v2:

  o remove header changes to architecture code. If they were already
    comiling this should not fail

Now that Joel has cleaned up and removed one of the routines which we wanted
to deprecate, remove two major arrays from kernel/sysctl.c which are empty or
almost empty. One of them, the debug one just needs moving to its source, so
do that.
                                                                                                                                                                                              
The move for the signal sysctl costs us 23 bytes but we have already saved
1465 bytes with the other recent cleanup Joel made. The next step is to
depreecate one more call and then we can simplify the registration to only
use ARRAY_SIZE() completely and remove the extra empty entries all over.
That should save us tons of bytes all around in the kernel and we'd then 
later kill for good all recursion possible sysctl registration calls.
                                                                                                                                                                                             
These patches apply on top of sysctl-next [0] which already carry Joel's
patches.                                                                                                             
                                                                                                                                                                                              
[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next  

Luis Chamberlain (2):
  sysctl: remove empty dev table
  signal: move show_unhandled_signals sysctl to its own file

 kernel/signal.c | 23 +++++++++++++++++++++++
 kernel/sysctl.c | 19 -------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.39.2

