Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B06688B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGLISK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 04:18:10 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55741 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfGLISJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:18:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so5090142pfo.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tRWxB/VAAV03ErbuMUlwG4nfr04i5uXxvmyjeK/eYMw=;
        b=fHwJnLlLISoqqvDLfyGk8Vw3/9WOMxJ7OvlFCg60FTmh8rrkGX1XqrgWqeHGbkOsY9
         +9oig5zdjDaOqX38pwXJ11qc7zDS9xm51tLG8d25Pjl1qnpFQ00DiM7DgsXnHCHhAf4u
         nWPLyei0fJyAgxO/X1UeAkr7Vthrx42va4uBivgP+bj8Y81BwkUY+zTsBlN4qLRnMdWU
         WEsrFUyDNb2QC4wmy18R655kwuWcHYQFH6bB1A4/qso+3SZixPG89crgQSo4SlPakdWA
         lNMkNruO9RTX0Na3yK694/C+DuZRUD9DprT3tYjpbz8Q1UNMfW9LI+przQMH/Z0msupI
         vhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tRWxB/VAAV03ErbuMUlwG4nfr04i5uXxvmyjeK/eYMw=;
        b=dUG6Y5H7QUdANpJh3RqCq5/aWYLJxeIuhzftIuJApPckjkQ/dbHvCuHnJWBhRfz3YJ
         heU+2NqNDSADXhVho9F4sgxC4Rt/re2C/iMwJI8fkxFtzs2fWXiJ2JgPOdd3Olpvq32I
         zmfbRGZlkhR6rMXK7fg1OXpKU+VnWHIN4/3J2HuXW5rCDWVUgyMcmDaCizRTsdMxNRA6
         VYXwmr1yUk5/rxHskk5AUrth+0F1+q9dLe/z5dibMSvgBx5S6U7KKOvYSeCt0rrwlirl
         BIvNnUoe2Ogay2jJuQZuwE3ERfpCwuicxLBW9cMfK2tmJz42wbTAiBzE6rlDlVx4aeuv
         1vpw==
X-Gm-Message-State: APjAAAUCFhqTrF3a4wQt8yajmZzd+W447chptleRZMWd+OWU4t46dvyz
        CjcIuN6Q+bb4R0MZMlXLef64Gi4Fch1BvmYy5WURXw==
X-Google-Smtp-Source: APXvYqzSxxZhDV/VHuvjEAx+PSSV2CXvVreQjca+MxOlfBW78VEVBMXf9ELB10VRLpFN34tmpwg5o+RRVIJafuHGXJT+dA==
X-Received: by 2002:a63:755e:: with SMTP id f30mr9386006pgn.246.1562919487340;
 Fri, 12 Jul 2019 01:18:07 -0700 (PDT)
Date:   Fri, 12 Jul 2019 01:17:32 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 06/18] kbuild: enable building KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index 48a80beab6853..10428501edb78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 3e4868a6498b2..0ce1a8a2b6fec 100644
--- a/Makefile
+++ b/Makefile
@@ -993,6 +993,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.22.0.410.gd8fdbe21b5-goog

