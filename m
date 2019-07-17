Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529296B417
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfGQB5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:57:18 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56936 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfGQB4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:56:16 -0400
Received: by mail-qk1-f201.google.com with SMTP id j81so18640625qke.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 18:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
        b=tqrR9xFTwORg1QSrmBsFleKT9JOo0mWeTxGW4Cfwc/bY+SbwKbWZtnZC5uqvLPXSy0
         fFTbFyRnOTfxluTh2q6BMZP1q+PSU3GiYh3dcvTTUMWsTDnE6XZgVauYWvDh+EbTKMPB
         KOgoPOnY6LBnwW9fDpo4DT805XeLouwSR15jHAff7jT0L9EmtILO0Z0eY1r1rCV8Q2i5
         O5GViNSp0p+IvC97BTusPHUJbhRwBbnLV8q2bc7TmAONmWtyLpSkhVrAreIyO5wcuztq
         zhOnGzS12A0sd7xlto/kMnwO3Xxh5zXw/gRGmyzq7nhT8lD3eB9n4tJ+8f/lrXrHJcfq
         mv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
        b=EcWqrgWvpvfY5sPXplRa3bjv/lU3DWq8TVu3N7D2CNt7Oy6dIdTkHTA9P/bssReNLA
         aN1/6jD94T5fFJZQDcncm/0+jFkxblYnZqrd9XXfaQL/gU6Vz4X2I1TESd5Ar15Z8tXn
         VW5oqTfzkhs0cwnR4xCXpaZob4mDmS3gsxTOpOnK+umz0Tny9JFYW1iY45sDJHlyeKKn
         8z+4avKBFi4zqDLIGNqfSRnVC3mR4SUU+XHfkm7kTfCDpAJ9iEpnqVzAmDCReFcWufDm
         CyYGgrTq8Kbger6/NKpFBC+JZiXPH/xtQBS75UEi1bj3cfO49J0gScs9cFmC9a8Tdw8w
         3i5w==
X-Gm-Message-State: APjAAAVZhO7Zj9AsuuMjLujYDTY3eK07JH6mO898kW3zRKw3GVy2l95H
        r/N0wVzZ0k+LSU22xGzfRcUcYCIgVfeSNBtKOeLc8g==
X-Google-Smtp-Source: APXvYqy/TbQinVkJuiRr7In6NyYeP8GT0mPKVABGBjQoi+qfrDV3qI73/LYe4gjXEi7BN46B71HCJBM5Bwy+83T+EO8gPQ==
X-Received: by 2002:aed:37a1:: with SMTP id j30mr25579345qtb.367.1563328575182;
 Tue, 16 Jul 2019 18:56:15 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:33 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

kunit_try_catch_throw is a function added in the following patch in this
series; it allows KUnit, a unit testing framework for the kernel, to
bail out of a broken test. As a consequence, it is a new __noreturn
function that objtool thinks is broken (as seen above). So fix this
warning by adding kunit_try_catch_throw to objtool's noreturn list.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f991957269..98db5fe85c797 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -134,6 +134,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.22.0.510.g264f2c817a-goog

