Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F292B52E7C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347237AbiETIjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 04:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347207AbiETIi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 04:38:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E69D4CF;
        Fri, 20 May 2022 01:38:57 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220520083855epoutp016fa069d66602b42f61964cb062d9f8d5~ww2zHyyO_2633026330epoutp013;
        Fri, 20 May 2022 08:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220520083855epoutp016fa069d66602b42f61964cb062d9f8d5~ww2zHyyO_2633026330epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035935;
        bh=oZhGlLI83t5qJYIpB4tYvwEL1hnzUFffSLhokei+vZw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ipd4KLW4NM9s1EshcHiVYcOCkwPMINX24v6Ff8vxhss0aRvGT3BAM+Z2tgxqYcKw0
         qNjaNJkTm0uxpL6ti92DZ17Gaf4U+g4fYaLnhavWvPgve8gXKSklZoHPvBd1TT+SfT
         rBmVRrBfDNF483ylhq7Vc+97bXV0LRsjU1ieKMag=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220520083854epcas5p3cf9401d13a42a8134d2a52391dcc4d89~ww2yiZHpG2034420344epcas5p37;
        Fri, 20 May 2022 08:38:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.83.09762.E9357826; Fri, 20 May 2022 17:38:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220520083715epcas5p400b11adef4d540756c985feb20ba29bc~ww1WSNe9p1594815948epcas5p4w;
        Fri, 20 May 2022 08:37:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520083715epsmtrp2a62dfe8d18384a72c2a4ccacc969621e~ww1WQg0-r1034110341epsmtrp2B;
        Fri, 20 May 2022 08:37:15 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-1d-6287539e2b57
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.F7.08924.B3357826; Fri, 20 May 2022 17:37:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520083707epsmtip27d956809dfd1d7b7f768b3f968c214b2~ww1O1WuqV2442924429epsmtip2f;
        Fri, 20 May 2022 08:37:07 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 0/5] kallsyms: make kallsym APIs more safe with scnprintf
Date:   Fri, 20 May 2022 14:06:56 +0530
Message-Id: <20220520083701.2610975-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTVxzPuff2tnR2uytkO1RUwkQD28rMYDl7iSZuuWwjSkYyJyPSjg7I
        KLAW1KHMAp0wsNIQUCnl1fIaD6FQGqDlIRgKAlEw4zEhOAED2k0esxCeoxQyv/3+v2fOh8PC
        uWskjxURFSuSRAki3Ug2Yej0OPxu/tcpwvfyjC5I1ztLInVNFYkUSTcwZJx5SKD1zC4m+sso
        J9Bc0q84qtInYmhyvYNEfZZxJlLf2xL6S2+T6L7KykDP8isAmuzSY0gzYsDQaKUU9aWLkVw3
        wECmlh4CPZc3kuhBs5pEstwlBlIWJeMofXiLm1Tlk2h1aYOBeru6CdRZcIVAZeYNDI0opwHS
        lh1Cg+2FGNLLtpYrs9aZqPzqHANV3dEykVnRjqHNyRcM1Jr6CEN9JbkApa/kAGTUaUhUWlPN
        RB09eQDJx3yO8enVlUxA58oGCDprVceg9b+PYrRmVkbQTapxJi1v/ZNJ15d70lrTLEZftcgZ
        dF3FbyQ9NmQi6e6bqwSt1LQDOr8ngL53swic4p1hfxIqiow4J5J4HQ1hh1sqLXhMivOF6ZQ1
        QgZ0jmnAgQUpb/h3RjEzDbBZXMoIYOGzuzvHAoDd1Q92jkUASzM1YDfS8mQY2IVmABs7c3eO
        fwGsrryO21wkxYcVzSbChp0oHQmtff42E06NY/DWzBzTJjhSfrBMMb1dS1DusHXw4VaYxeJQ
        R+FCtq997QDMGVzatnOo12FPztR2J77FJzfk4rZOSJWw4cSQnmkPnIB3MtUMO3aET827PA8u
        /tNC2vohdR42KC/bs3IA29RZpN3jC6cGihg2D055wJpmLzu9D2bfvYXZd1+FitUpzM5zYGP+
        LnaH8tHandm9cHF+nrBP0fCx/mMb5FLBMLn+ohIcUL30GNVLj1H9v1sI8ArgLIqRisNEUp+Y
        96NE5/lSgVgaFxXG/z5aXAe2P4jnl43g8aM5fgfAWKADQBbu5sQBYrmQywkV/BwvkkSflcRF
        iqQdYC+LcHuTQ20mCrlUmCBW9KNIFCOS7KoYy4Enw4bu11x0fxqe4a0fWc6e+OUtS+FPAtX8
        6XX1kYgI5yrF5ZMT1m+DSL+459MfmBNPJAT1v7GMr7har8cZvhK+nebaJl5GKWeD/D46dOpg
        aydMDT4Xy4kO4XxzzYDJPPMSis/4vUgP9bW47H8loGXPjFDOKcjW1GdYef7j15IrjiWZVYZq
        3oVPg09f+a4qULuRl2XEhqxU+/GsguBh7jvdT4rZGuEPvZccm14jxoL2x8etJZnnnL3E3Abl
        cv/BoEsf8pcCQuoVTlzHL3wcjnuMle+L35Na8rnBOn647bPNhNqyJqNJz5HFZtz4w9tX21t7
        2991MzBwITn0pIru19aZXJDKjZCGC4544hKp4D/+IEYEjwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTdxyG/Z9bW5KarjA90iUkNSOs27q57PJLFAWzjLMsjl1gWVyiFHoG
        QluwB2FjwVXpALmlcxqkIEIbbqULFAoyKAQKQxogSN2Qa5yDwohsEjJAQcoKZInf3rzPk7xf
        Xj4uriID+ec0qaxWo1BJKT+itVca9PrRz3Ni3xx+Igbb4CIFZQ1WCgovF2PQ8dcUAVtX+3nw
        sENPwPLlH3Cw2i9hMLvlpGBoaYYHZSM+MFzdQ8Fd4xoJj8otCGb77RiYxlsxmKjnYChfDXrb
        KAmOThcBj/VtFNxrL6NAV7pOgqEyC4f8+75u1lhOwea6l4TB/gECem9lE1Bzx4vBuMGDwFwT
        DO7uCgzsOt9y/bUtHtQWLJNg7TPz4E5hNwbbs6skdOX+gcFQVSmC/I0SBB02EwXVDT/zwOm6
        iUA//U6YnNncuIqYUt0owVzbtJGMvW4CY0yLOoL5xTjDY/RdkzymuVbGmB2LGFOwpCeZJssV
        ipkec1DMwI1NgjGYuhFT7vqUGblRiT4JPO13TMmqzqWx2jeOx/glLNUv4Sk5h77x5DwjdMjm
        n4cEfFr0Nt05fx/lIT++WNSGaI/1NrkHJPRT72NiL/vTdd4F3p60gujuvsVdiRLJaUu7g9gB
        AaIZip7PKdq1cNECRjc+HMB3LH/Rh3RNoQftZEL0Mt3lnvL1fL5QdJxeuX5ibyGILnGv83ay
        UPQC7SqZ213GfX1WSyluQPuNzyHjc6gCYRZ0iE3h1PFq7kjKWxo2Xc4p1NwFTbw8LlndhHaf
        JJO1IYdlWe5EGB85Ec3HpQFCpNbHioVKxbcZrDb5rPaCiuWcSMInpAeFd/NcZ8WieEUqm8Sy
        Kaz2f4rxBYE6TBl5JrQn8mQdZWprHjC3Ty6EasaehECG6StBbnhvgHtx9TPFAc9c+gcZf2oT
        PzpVfzizgpWlBX33IuH9N4bbyAx/r7l1X/XKUPIrYWOPrsdc/PW0pyri/ds9Xw5FbWUeXYsw
        qCA+XIGtPohOiEqUBzTT549dsv5mnZIIOv85IWny339R15hl/VFqn7xXHjZofElX9H19SFrt
        9vmbcX2HX9uOyf89KnY4+0FWZVK1UvJqyy230fJFanZqy0bInLJL8nGkI/rdqL/nlsf3BZsT
        CxqiPaPcMHdKQNYeaHyGvo4rnnYczD0jJGzFI/NrKlN6X1GoLjj6p6TMCRfjJ2vFI65ICS5B
        cUSGaznFfwD17ma4AwAA
X-CMS-MailID: 20220520083715epcas5p400b11adef4d540756c985feb20ba29bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220520083715epcas5p400b11adef4d540756c985feb20ba29bc
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kallsyms functionality depends on KSYM_NAME_LEN directly.
but if user passed array length lesser than it, sprintf
can cause issues of buffer overflow attack.

So changing *sprint* and *lookup* APIs in this patch set
to have buffer size as an argument and replacing sprintf with
scnprintf.

patch 1 and 2 can be clubbed, but then it will be difficult
to review, so patch 1 changes prototype only and patch 2
includes passed argument usage.

Patch 3 and patch 5 are bug fixes.
Patch 1, 2 and 4 are changing prorotypes.

Tried build and kallsyms test on ARM64 environment.
APIs are called at multiple places. So build can
be failed if updation missed at any place.
lets see if autobot reports any build failure
with any config combination.

[   12.247313] ps function_check [crash]
[   12.247906] pS function_check+0x4/0x40 [crash]
[   12.247999] pSb function_check+0x4/0x40 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.248092] pB function_check+0x4/0x40 [crash]
[   12.248190] pBb function_check+0x4/0x40 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
...
[   12.261175] Call trace:
[   12.261361]  function_2+0x74/0x88 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.261859]  function_1+0x10/0x1c [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.262237]  hello_init+0x24/0x34 [crash df48d71893b7fb2688ac9739346449e89e8a76ca]
[   12.262603]  do_one_initcall+0x54/0x1c8
[   12.262803]  do_init_module+0x44/0x1d0
[   12.262992]  load_module+0x1688/0x19f0
[   12.263179]  __do_sys_init_module+0x1a0/0x210
[   12.263387]  __arm64_sys_init_module+0x1c/0x28
[   12.263596]  invoke_syscall+0x44/0x108
[   12.263788]  el0_svc_common.constprop.0+0x44/0xf0
[   12.264014]  do_el0_svc_compat+0x1c/0x50
[   12.264209]  el0_svc_compat+0x2c/0x88
[   12.264397]  el0t_32_sync_handler+0x90/0x140
[   12.264600]  el0t_32_sync+0x190/0x194


Maninder Singh, Onkarnath (5):
  kallsyms: pass buffer size in sprint_* APIs
  kallsyms: replace sprintf with scprintf
  arch:hexagon/powerpc: use KSYM_NAME_LEN as array size
  kallsyms: pass buffer size argument in *lookup* APIs
  kallsyms: remove unsed API lookup_symbol_attrs

 arch/hexagon/kernel/traps.c        |  4 +-
 arch/powerpc/xmon/xmon.c           |  6 +-
 arch/s390/lib/test_unwind.c        |  2 +-
 drivers/scsi/fnic/fnic_trace.c     |  8 +--
 fs/proc/base.c                     |  2 +-
 include/linux/kallsyms.h           | 34 +++++------
 include/linux/module.h             | 14 ++---
 init/main.c                        |  2 +-
 kernel/debug/kdb/kdb_support.c     |  2 +-
 kernel/kallsyms.c                  | 92 ++++++++++++------------------
 kernel/kprobes.c                   |  4 +-
 kernel/locking/lockdep.c           |  8 +--
 kernel/locking/lockdep_internals.h |  2 +-
 kernel/locking/lockdep_proc.c      |  4 +-
 kernel/module/kallsyms.c           | 36 ++----------
 kernel/trace/ftrace.c              |  9 +--
 kernel/trace/trace_kprobe.c        |  2 +-
 kernel/trace/trace_output.c        |  4 +-
 kernel/trace/trace_syscalls.c      |  2 +-
 lib/vsprintf.c                     | 10 ++--
 20 files changed, 93 insertions(+), 154 deletions(-)

-- 
2.17.1

