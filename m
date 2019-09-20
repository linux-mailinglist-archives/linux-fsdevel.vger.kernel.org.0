Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F379BB9A8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437250AbfITXVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:21:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42811 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407109AbfITXT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:19:56 -0400
Received: by mail-pg1-f201.google.com with SMTP id d3so1748642pgv.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iAt6nbLOTb6MSd0OQpor+vgL4LVt0KITsii11UOE388=;
        b=AYjtMTJ/bM129CXuepq5nEai9unWmuv9KrBsNEIaNyPvQ4Lt9h0LEysSES4HAewjdy
         29QdHAI+HmjwUpZpOFfp+65UA1AXawPyQBrV9eC7bzwv+iTdkaID8+C2RbUTQ424wFXU
         ikBwbFbcoWCNie+/3MBIfmo5PilLysY1O2sVT4F+CzBPblIy6HgcB1k/q+DaLNKLnOPG
         KGhX19FC/G+6Iq+SUJYyTo1TyMfAp7OPjYNGjrMoMDGT8Lcrz3+Do8Yd4VbmfMqldrGC
         31xONjlg/4CyE/OtZ+d8kznbXo+3NUSFplR4NcCXIsv/+7PDrkmrSqkTzl+KSxrv6PXb
         yRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iAt6nbLOTb6MSd0OQpor+vgL4LVt0KITsii11UOE388=;
        b=nQIlqAM/oK2erCg/wt6AReb967VjHoLF4iDtcWkBhgKFzWbzPd+rqN3Hr3Oro1CrJr
         tajOcECKhUukmwAnqp0Z96MulgYr4u3pFEIyZUdMf+aJG85yGogFyJOwYwU+fcFO49jb
         bnXH55pTSmTqbkjvb0HFQyLJ2qCyWRo8cezgV/seGHMsUnvW9pTrlENyj6jdwxLa3Nv2
         RfahJEcs5uvBfLWkmE3yUIqKC0T2WcndMwsCn/cmZ2Zhvx4XMXEFBxiN788Zd7T8ZlDh
         7zOlWZGdOGPkbFdlGrdVqMHkTYyPimI+dYeLYasF/SXmajgiuS/D5tQMs2gBn2Sv934x
         eq4A==
X-Gm-Message-State: APjAAAWOTPjgbsMdD2ZvEVeGdTFeW8OsdWIZlTKZ+wCbhT/sJPSaR5Cd
        wpZ8pqEELu2XHmtthr8JOlcaKyO/MAJSbbN8zJqv6A==
X-Google-Smtp-Source: APXvYqwvNWfMwXT5OHmC0FOVMC3AvIVvQINgZf/DTvElVJK0vl4Su5PZQX9OXJ1XdFr+Yzg+uGF0Z+1UbeiJPCoJbgdZWw==
X-Received: by 2002:a65:4145:: with SMTP id x5mr4101853pgp.259.1569021595251;
 Fri, 20 Sep 2019 16:19:55 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:10 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 06/19] lib: enable building KUnit in lib/
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the lib Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug | 2 ++
 lib/Makefile      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..5870fbe11e9b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2144,4 +2144,6 @@ config IO_STRICT_DEVMEM
 
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+source "lib/kunit/Kconfig"
+
 endmenu # Kernel hacking
diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..67e79d3724ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -96,6 +96,8 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
+obj-$(CONFIG_KUNIT) += kunit/
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
-- 
2.23.0.351.gc4317032e6-goog

