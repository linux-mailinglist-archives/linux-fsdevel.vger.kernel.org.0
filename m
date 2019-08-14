Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8228CB04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHNFwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 01:52:33 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42758 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfHNFwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 01:52:32 -0400
Received: by mail-pl1-f202.google.com with SMTP id x1so21670753plm.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJI3f1SN7FHCWsT2YqJJAK+Vl1EvHBTDcI6eHyMtfac=;
        b=sDK5BT/dvFb/4wwwQc1PTpPfH2empuHwtwW683jTc1/UBzcVhObxNP6pBGFilT0sdq
         YjFA/RSQMApVVG+t8h1ynCnvPdjVkkT4nFOBzw6j86bvAZfGFyoYXaIKH1aOmyN2jmCD
         jUU/GIuMEPnspV2nccFjXTCmkzDGT+WZ84tAAqSxmHfl/ERNtjccEG5kl3wcxEb9cTTq
         HoSgKYVtNTanG5OqH7HxaTtMxnQztFLBRlhJ5hoYcT1Yny5tYkm3VtA63Leys4fWCsMI
         KbnsbQWD30WYxkZtVqZaWnTXS2XmF8P1lMAnt7SfjvXusNDDBGHrhs/Rz5S38DPj/h3r
         n92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJI3f1SN7FHCWsT2YqJJAK+Vl1EvHBTDcI6eHyMtfac=;
        b=O4+zAkgv2D6EYcuDkCmkICD9gHhafRPwUyZW6cutAiElkHtEy9wsoW9ekJQDgtggoX
         EN81ieakjSgY1jIModXOYmMzlYZ+JhF1423zJyJ1zk/1azr3MoUOYrd/lODdQhE4gK4V
         j+EtVupU/UOjA95dn5mOnqPyhOk5pX2cOqW4lrntCdOZwU7av2IjleKK9l4pwrL5rMH7
         yTL0mmBoAgAkqPsxG65sQfE0D39JXT6T/0bHL30BsuC1Itd2tmExAQPDu+K27/3GhWJm
         yqfXZsD7xxOgYD6ahGUlUhJ98ylXZUQPv3BIA8nv7dMaYHFTYd4NlGtqW0htxDJ1R/4S
         50mw==
X-Gm-Message-State: APjAAAXLgi38Cvh7wOb8qHoFezT7RDkQ1xibanLcyAedKGW56GG0W0dU
        DjQBlnop9QZcjjhodjMX7Spn90xfQinDF0XEose4Yw==
X-Google-Smtp-Source: APXvYqx15GDkg8PQB7JqjQGJp0JcWDFj1Zkf1yox9JkFPI/5qXF/sLjhNwC7NbFBzfAoGHt2OonLFNZNFwcrsUAQ3uzHkA==
X-Received: by 2002:a63:3006:: with SMTP id w6mr37892554pgw.440.1565761950937;
 Tue, 13 Aug 2019 22:52:30 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:50:58 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 08/18] objtool: add kunit_try_catch_throw to the noreturn list
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
index 176f2f0840609..0c8e17f946cda 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -145,6 +145,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (!func)
-- 
2.23.0.rc1.153.gdeed80330f-goog

