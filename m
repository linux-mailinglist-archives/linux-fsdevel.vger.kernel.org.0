Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03FC96DB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 01:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHTXWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 19:22:33 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:35070 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfHTXVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:21:11 -0400
Received: by mail-pg1-f202.google.com with SMTP id q1so195964pgt.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XDtrvkw0RFhKlN+LitTFqDIh4jTE9hk9LUw2Z5/BXjo=;
        b=GfB79yRsARKNmez787qOELsZmZ3ww5c5KdNG+MLM0ZkalMFVMmzyjPSn7wZeKhOphO
         BJWZzy7YmkXN9/UgkFTtef1jj4+FlXlngojqX89H7vuOPC0dYVsNdB9owDKZLENOO6L5
         mxaSuOLfjrFzQEiAZ9YZ1XMnJWlLFr+j5jaqMZyZSETAJxRVYZ3vcpGhrvvLt0+24Fkg
         GZ+bfBrp0EHb5FcC7VXGQ67bGympCSJmn5xE411lPMKlT0PWqRWUEwUdiREWT5Re1UX4
         RFh+MSnWSjrJ6WwkjZADkd8PAGH3yovb64iBwHH4kCoaMcvhoh9Vu+pgfCSgkklmMJmE
         GyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XDtrvkw0RFhKlN+LitTFqDIh4jTE9hk9LUw2Z5/BXjo=;
        b=BX/P/UoOkc7ejrAm5N8xkYycYbIuP5qu6zX269UedKXKz+gU90SgaHNbvH0GIdsKjw
         VqZY/RPS6lv0lPt+dgechYI4f4z6Qx5RIYxf6WUvUr83VtIjt3hJtA7SCM2D6vgeQiBb
         O5/qMWA/WtMMQcwGWyYgnFrPzFNrW17Pe9Ge+9/32UN48VW/g+CHHOstivRL1kJF8x7Y
         u2tP5SPBjXvWdsuBezSw8DgzeCaLZo8xacGkUHaMitNKYMnGNSozXgRhqwW70iyZ5jBo
         ZkRc0A/CVue3qfCBTTktE9ULUXl+i9wBsjVINQ3s+rRqWjQMTOJCsoSTHh2XZ9DnIz6X
         b0bw==
X-Gm-Message-State: APjAAAXSZ1Lx0jEt+PECKhwhI6PrDVUsQjGTD4OEr24hsvQGV38ORvpb
        UrYj15vg115IybK4MzM2ZYjqNgi4XTHd1MX8fOCjtg==
X-Google-Smtp-Source: APXvYqwnRfaDdNNQbwqYi1sBE/pq+1Vm1Sa6tTF8ExzVh/t1i5vgUriUWM0c3aCP4jWc1mxnMQ3Gtejv3fCq1fQ0LkUxoA==
X-Received: by 2002:a63:460d:: with SMTP id t13mr26021274pga.205.1566343269803;
 Tue, 20 Aug 2019 16:21:09 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:20:34 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 06/18] kbuild: enable building KUnit
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
index e10b3ee084d4d..47886dbd6c2a6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -32,3 +32,5 @@ source "lib/Kconfig"
 source "lib/Kconfig.debug"
 
 source "Documentation/Kconfig"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 23cdf1f413646..3795d0a5d0376 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,6 +1005,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.23.0.rc1.153.gdeed80330f-goog

