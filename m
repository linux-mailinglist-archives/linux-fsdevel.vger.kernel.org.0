Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C225C341
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgICOsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgICOX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:23:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00CC06124F;
        Thu,  3 Sep 2020 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Nmt3gQrXHRpJsq5nosMrsljZettvm0yOX7zhocjtN3o=; b=H1ysAq3n3J6+FAOCcSXFaaRG8D
        fuHtZL4njNSPBAI3AAdu+2NhFbCA0M/aFer+STq20lof8lzzLkcHwR+4mUTX+D0OnGGRKirmYoTjG
        EdnkecbKc4QL1WDsCKuG9gjFRHY4W+kA3NaiFvzHmE7krKfzPxtpP//6nMpTok5F3qQKEfpKv2Wk+
        B/I87rPNxRr3SGs9cjQH2lP62Am3AmAkrgJHUCDx6nxKWYJ9IGmyL8OPQ/S5+kXwOaGOIk6OHjy+D
        vtZSYF0uJln0Jn1YMjj1NEYT4k/z9t438BC2mqYo5NUFChlAdhDU8L6mp+Ue0DSSntfuCiP05e1qW
        Ddh3SSAg==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8R-0004a3-Rf; Thu, 03 Sep 2020 14:22:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: remove the last set_fs() in common code, and remove it for x86 and powerpc v3
Date:   Thu,  3 Sep 2020 16:22:28 +0200
Message-Id: <20200903142242.925828-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series removes the last set_fs() used to force a kernel address
space for the uaccess code in the kernel read/write/splice code, and then
stops implementing the address space overrides entirely for x86 and
powerpc.

[Note to Linus: I'd like to get this into linux-next rather earlier
than later.  Do you think it is ok to add this tree to linux-next?]

The file system part has been posted a few times, and the read/write side
has been pretty much unchanced.  For splice this series drops the
conversion of the seq_file and sysctl code to the iter ops, and thus loses
the splice support for them.  The reasons for that is that it caused a lot
of churn for not much use - splice for these small files really isn't much
of a win, even if existing userspace uses it.  All callers I found do the
proper fallback, but if this turns out to be an issue the conversion can
be resurrected.

Besides x86 and powerpc I plan to eventually convert all other
architectures, although this will be a slow process, starting with the
easier ones once the infrastructure is merged.  The process to convert
architectures is roughtly:

 (1) ensure there is no set_fs(KERNEL_DS) left in arch specific code
 (2) implement __get_kernel_nofault and __put_kernel_nofault
 (3) remove the arch specific address limitation functionality

Changes since v2:
 - add back the patch to support splice through read_iter/write iter
   on /proc/sys/*
 - entirely remove the tests that depend on set_fs.  Note that for
   lkdtm the maintainer (Kees) disagrees with this request from Linus
 - fix a wrong check in the powerpc access_ok, and drop a few spurious
   cleanups there

Changes since v1:
 - drop the patch to remove the non-iter ops for /dev/zero and
   /dev/null as they caused a performance regression
 - don't enable user access in __get_kernel on powerpc
 - xfail the set_fs() based lkdtm tests

Diffstat:
