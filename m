Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D776B430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfGQB5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:57:22 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56298 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfGQB4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:56:10 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so13458263pfo.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
        b=anmcre763jqYfgk0jWG0amSJjr9xJDchU7aCLTMoA7GWTjnXP43elmKF15Bo6z8jT/
         uSdYJORRrIzHzGZUbqnAbFwRKeFJDrWfiw0+1PMnDT6HXctOw3e70AmsBr86zxdtYfSF
         9QjexNnudSykx+gILjsNgF/Izk1Qd8cYoWCnqxAFQZkhT4rceTgpbKV8nPdU7wapAdRi
         hbcyVdfr+6dA554hVrDR7CH/dYVdpdsHvTXr12IEodevpJMzgKPwR62HOJtcZbsFshbz
         4nNBdIsyoQPIZCFxFyp3Hb3/XaXqHo2KdfXbEpGJ/wTbzl09x42ZZcaPUlA1B0bBeqvO
         Hw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
        b=gu8cSXaKhl/M1pg2sIyF+Po7h6aUwTTn8deFXG+J3d2MlgJAmZjXAhWVSkFb9qZun4
         LC2DKHq1fTV1tXwVk9bDIv92lueh5HLH955SMIQm9rCVOhQHRhz9wJ4OkvtIOFvoB/fQ
         XjatDbg4PJWOU4GPrIsDVsfxwPsOQmB0kWvSWGwflxFnzvBLbqHHTsns6oeJAeLKwCZW
         mbitR8bqILqAnTsJN81VxwyIKfGdtdDZI+8ch7uUxsH7os00oo8a0lWKN0zEfndpXwSU
         qofUOxcsuwG0fUYgbE6N8NEKNoFNAiL3+PXv0wmGXFElK6BlJdUNAMembfBz/yHGF+Zm
         bHZw==
X-Gm-Message-State: APjAAAUd/NJCd5RcfejoMbGRqm/OV50MccFRgccZbhmlaMnyLBOhRRYt
        NDvuKvhxw5Gpaf8oPjVjwgojdsLgPFgARvD/t7CZ9g==
X-Google-Smtp-Source: APXvYqzdOd/pnZZFL/pS6/iieMJ7feNcywGmwm2i67xQ+rYX0bj48kl8BcSe4yfiKEhFGYAbbZpECxiAzIcb05C1kfs0DA==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr37450939pgk.378.1563328569459;
 Tue, 16 Jul 2019 18:56:09 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:31 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 06/18] kbuild: enable building KUnit
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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
2.22.0.510.g264f2c817a-goog

