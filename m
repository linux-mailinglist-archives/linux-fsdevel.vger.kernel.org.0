Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3283425489E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgH0PJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgH0PAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:00:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F238C061264;
        Thu, 27 Aug 2020 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+FDq8L6rGnI/x/fcZZwnAe98btu7wV0Ys0/vNLegxzU=; b=F+uxR0Mj1uhT1FBZqAiv7eN7GW
        v9efLGDvyKR4HMaQr2BO7JfB6QBG9Q3iERm1of9luLKOOUnD1Xrd8iSAJSSXNB/Vv6CzWMmdVu2ub
        q8+LsIfUOTAjwJOAKQikPQK+bAtTN543PVVJwZdg9c8CQbNSXYUogS2MKD80wxL78pbufGfYKpkb7
        2743JUEB32qVF7u5YrUBh1rdiHvnsI0mx2Yv3lZG+aWMUO1vv+vGYlxp8RdPAU0zs4Pvx9Coofw0a
        6uOeFBRpcgiRt/EeooQPnfwo9WXbDe+WJaFAGo1OqfRMJD2Ml9OMqxehVjH2RtZNLBFX9T1xxEvoU
        xyZ5WPdg==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJOB-00044J-Lk; Thu, 27 Aug 2020 15:00:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: remove the last set_fs() in common code, and remove it for x86 and powerpc v2
Date:   Thu, 27 Aug 2020 17:00:20 +0200
Message-Id: <20200827150030.282762-1-hch@lst.de>
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

Changes since v1:
 - drop the patch to remove the non-iter ops for /dev/zero and
   /dev/null as they caused a performance regression
 - don't enable user access in __get_kernel on powerpc
 - xfail the set_fs() based lkdtm tests

Diffstat:
