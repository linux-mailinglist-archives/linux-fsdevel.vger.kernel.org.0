Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE8C20F205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbgF3J7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgF3J7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:59:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F52C061755;
        Tue, 30 Jun 2020 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Za5Hzb5OyUUVNW5GfXZ3A73U/lLcFexOctNrPwh6ICc=; b=fhdlz+XaNzQGh/692amZWsNd5J
        dqUN0J8wiuIvx1p3/nSlYUwmZkWW75cTrTEtQRES+MZkJkkJx0RT4XYT2iWjZdwNogcFQG4URUjRW
        osID6+Eybu9JbD+uhy9Inn7fYX/J92hBJ5EMbdCrneaHtv3q7uiN7yKFlINgwCWxrT2wPxYletSrb
        w5I5s/31dNR4WCbNJ4vekrDOFAet/drCGl6MMSrAgbHQNsRxoZ5Cl7d3jl7ArWR1+V6gtM8EW+JWH
        ywMHcyMpQxJiiXQOtIaPHuXqhRE7trw5jJ2UCZQGXFOU5vbhUhypWVU4usk4y1GmvKZSi1czwxvta
        pneVCrkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqD2x-0005Cw-84; Tue, 30 Jun 2020 09:59:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACA7A3013E5;
        Tue, 30 Jun 2020 11:59:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 219B4203A617B; Tue, 30 Jun 2020 11:59:20 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:59:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, viro@zeniv.linux.org.uk
Subject: Re: mmotm 2020-06-25-20-36 uploaded (objtool warning)
Message-ID: <20200630095920.GU4817@hirez.programming.kicks-ass.net>
References: <20200626033744.URfGO%akpm@linux-foundation.org>
 <ec31a586-92d0-8b91-bd61-03e53a5bab34@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec31a586-92d0-8b91-bd61-03e53a5bab34@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:35:08PM -0700, Randy Dunlap wrote:
> arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0x57: call to new_encode_dev() with UACCESS enabled

That's c120f3b81ede ("x86: switch cp_stat64() to unsafe_put_user()").

Where __put_user() made sure evaluate 'x' before doing
__uaccess_begin(), the new code has no such choice.

The simplest fix is probably something like this.

---
 include/linux/kdev_t.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
index 85b5151911cf..a840ffef7c19 100644
--- a/include/linux/kdev_t.h
+++ b/include/linux/kdev_t.h
@@ -36,7 +36,7 @@ static inline dev_t old_decode_dev(u16 val)
 	return MKDEV((val >> 8) & 255, val & 255);
 }
 
-static inline u32 new_encode_dev(dev_t dev)
+static __always_inline u32 new_encode_dev(dev_t dev)
 {
 	unsigned major = MAJOR(dev);
 	unsigned minor = MINOR(dev);
@@ -50,7 +50,7 @@ static inline dev_t new_decode_dev(u32 dev)
 	return MKDEV(major, minor);
 }
 
-static inline u64 huge_encode_dev(dev_t dev)
+static __always_inline u64 huge_encode_dev(dev_t dev)
 {
 	return new_encode_dev(dev);
 }
