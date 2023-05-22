Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9770CBF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjEVVI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjEVVIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 17:08:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882F9D;
        Mon, 22 May 2023 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ruA1o1aWWqhoGunqxzs4d011qFZVDul7CrOFbNPB0ws=; b=ms2snZCjiEJFl5SmiuOFzrdKQ6
        MYICcqiEnfWgGuIvZPyTwWCLAxBPXwTyJK2C+UQ6arMXNyL6Hcrpr/KeoD09Luk5woD4jxokn8AqR
        Ce1damz3W/RLHF+v+S0jzo5xerE6IKDIh+s0a63d5C/KdXHmYdlB+0pF0FV5I5a43cE3Pu/FwVxjG
        9BSLpzNyI+K8ospD5vZ20z/1v3b9gNTOdvmprPE47bgPmXMnOgaWZwWbaxpcygLUGvZdvrrfQ5F0H
        HSsiKJjhNQ6APzqDA7KPyJwibBo+0XW3Y4lKSAuGXvDTVlOsHxqAKCEzJP7M67AmAtM0Y2rY0AtKY
        SQSBOpVg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1ClL-0083JV-1j;
        Mon, 22 May 2023 21:08:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Cc:     j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] kernel/sysctl.c: remove to major base directories
Date:   Mon, 22 May 2023 14:08:12 -0700
Message-Id: <20230522210814.1919325-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd, x86 folks, your review for the second patch would be greatly appreciated.

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

These patches apply on top of sysctl-next [0] which already carry Joel's patches.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

Luis Chamberlain (2):
  sysctl: remove empty dev table
  signal: move show_unhandled_signals sysctl to its own file

 arch/parisc/kernel/traps.c |  1 +
 arch/x86/kernel/signal.c   |  1 +
 arch/x86/kernel/traps.c    |  1 +
 arch/x86/kernel/umip.c     |  1 +
 arch/x86/mm/fault.c        |  1 +
 kernel/signal.c            | 23 +++++++++++++++++++++++
 kernel/sysctl.c            | 19 -------------------
 7 files changed, 28 insertions(+), 19 deletions(-)

-- 
2.39.2

