Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4F2B00E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 09:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKLIK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 03:10:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47194 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLIKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:10:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201112081042euoutp01ee2b09c53d6708d5028b94218aec3a07~GtGA8LMfA1889818898euoutp01_;
        Thu, 12 Nov 2020 08:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201112081042euoutp01ee2b09c53d6708d5028b94218aec3a07~GtGA8LMfA1889818898euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605168642;
        bh=5QhIz+Gn5Nu1t1BJ55g8tgSxAnN2Qhv3UsWQAPjr2XE=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=b64XoHNHyRH94WtnWrIiT5KU/cDx5fnxzItI77Kk7w6SZX7tsbA7Ai3ryZMzN5Lct
         /YSCwayQ3wP9rhBfKUQ6YvKDKVpMpPXrLRlytAyQgSyHTrglDtwehR53iPmlFxJL/4
         fmxfGzt1a6FiPCOc3jgRik1oRrUBO3w1EsNW9HmI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201112081037eucas1p10001fdda6dddb9d057a3eb3cec683c9b~GtF75tkcF3069230692eucas1p1I;
        Thu, 12 Nov 2020 08:10:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F7.8C.27958.CFDECAF5; Thu, 12
        Nov 2020 08:10:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df~GtF7QhSjo3069230692eucas1p1H;
        Thu, 12 Nov 2020 08:10:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201112081036eusmtrp1008f17458f30bdd010557b6fe39947dc~GtF7Pb3DY0531605316eusmtrp1k;
        Thu, 12 Nov 2020 08:10:36 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-d1-5facedfc7293
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.81.21957.CFDECAF5; Thu, 12
        Nov 2020 08:10:36 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201112081034eusmtip10485455f165c607ea5327c010a6dcda1~GtF5oIs1T2201322013eusmtip1k;
        Thu, 12 Nov 2020 08:10:34 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [patch V3 10/37] ARM: highmem: Switch to generic kmap atomic
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Huang Rui <ray.huang@amd.com>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul McKenney <paulmck@kernel.org>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        spice-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-mips@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-btrfs@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
Date:   Thu, 12 Nov 2020 09:10:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201103095857.582196476@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxzdd58tWnIBJx9gtliUBLehbNN9ic5oYuI1MxuLWbKYkFrmDbjx
        SitOINlAkPESTUFWSnlNCC3lMS/PyLsOKiBlUGQIDGxgSHjoVodMsGXQqxv/nXN+53y/8/vj
        E+HuVspbdCHyIqeIlIdLKReiofuF+T37UqXsQKMWQw/GijGkramkkF3VTaPb6hoS5Q6qcLQ0
        1Uwi7UAygYaXn1JIb+jCUE7uFYD46RESDU3raNRQloyhltYeAlnuaCmUxtcDNFm5TqKrE1UY
        0vdX0ch4sxWgtRUHibKfzAJkcPQCtJKVRSJb6XMCma51YOjaTBaG2lIfYSihR0eiGr4IR7X8
        TRwV9FXTaMBuIlF5fyGF/vl5mjzmy14dslOsZWQQZ9dWVYCt0z/E2OS2MZqt1e1j+Yo0iuVt
        Kpp9YjbT7D31GsHOdTbibHtBJc1OZZgwtrb0ezZ7tBywA+oSELTzrMuR81z4hUucYv/Rcy5h
        jhuZIDrH4/LgeBpIAH1MOhCLIPMhNHUX0OnAReTO6ADUFufgAvkbwHq1FhPIMwAXMyz460hz
        k40SBuUAlk40EQJ5CuCj0lZi00UxgTB9KZ3axB7MKdjaoXOmdzCfwdmk604PzuSJYaI+bBNL
        mKOwOWfK6SGYvfDecLrT8yYTAhPvJlGCxw325M04dTFzED7svI4L77wNk+rzX2FPODZT5KwN
        mUUXOD7fAoTaJ2DeZDsmYA84b6qjBbwL9mVnEkIgCUCruYoWSCaAlivqV+nDcMK8ulFDtLHC
        H9bc2S/Ix6G1dIXelCHjCkeX3IQSrlDV8CMuyBKYmuIuuP2gxlT939rOX4fwG0Cq2XKaZss5
        mi3naP7fWwyICuDJxSgjQjllYCT3bYBSHqGMiQwN+Coqggcbv6DPYbI1gYL5vwKMABMBI4Ai
        XLpD4nusUuYuOS+PjeMUUTJFTDinNAIfESH1lFTkb4yYUPlF7huOi+YUr6eYSOydgBFiSXWE
        ZUFr7c01LGfaqjte7M2zei88eEcReGLOcms51Td1eXWm4KdeXv9+fnFJ3Nc/xPt4eUZZtt/O
        g2PQQJ3zm9jlH/eukjB+nPjW8cbx+3zLqceT/JpH4Sd/ZvMmfeKlaNlJx4GEzp0hwXYvn/WZ
        IynbAv13373stmALXv6oqyWxnOwYbow8+UtbEG3cI3sZpxPXH/J7o7mwoSuBBOTzWxHbu0YM
        rf3r24oaix4f/K7sjzM5u0Oe+YSc/aDf4LY+yzSk/H7YrS5Dbe38NF4ZoCH4Cl2wbS7V0O5Z
        plb9Js13zSrpD1r83Msedyj6y8XQtVEuNvYLzWr8y/unZQ6zlFCGyQP34Qql/F8F4KeXdAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0ybVRiAPd+tBa1+lCInzIWlExc3KRQoHnCSJVvc54VsmphsbrMr7AsQ
        abu1ZRleQp2MjDouK9d1FKgOKaPAaMdEEBjoBgiMFLBKQdG1Elwsm5CxKVCEggn/nrzned7k
        JC8X58+TIdw0hYZVKWTpQsqfGPD2/hK+5LFII7sHIfrRWY2hiiYLhZb1tzmoubyJRKV2PY48
        U+0kqhjOJtDYw/sUqqu/haHi0rMAWV0OEo24zBx0oyYbQ9929BNotK2CQrnWFoB+tayQ6Nxk
        A4bqhho4qKekA6DFR14SFc1OA1Tv/QGgR/n5JJq7skCg3rybGMpz52Oo8/xvGNL2m0nUZK3C
        kc1agiPjQCMHDS/3kqh2qJJCj6+5yD3bmXMjyxQz6rDjzOK/esBcrxvHmOxOJ4exmXcy1qu5
        FGOd03OY2Tt3OExf+SLBzHR/jTNdRguHmfq8F2NsV7KYop9rATNcbgIHn31PtFulzNCw21KV
        as2rwiNiFCUSxyFRVEycSBz98rH4KIkwImH3CTY97TSrikg4Lkr1Fl4AJ4sDz9gncoEWDNA6
        4MeFdAxsb52jdMCfy6drACydXKLWH56D/aVacp0D4ZJDtyF5ADQ1TfskihZDnUfn40D6ddhx
        04yvsYBOhGfzqsm1AKeNfvCLFYNP4tNS6Bh2+Lby6ATYXjzlCwg6DPaN6Yg1DqKTYI5lGaw7
        AbD/kts396MlcLy7wOfjdCystP2+waHws5bLGxwMne4qrBDwDZtyw6bEsCkxbEqqAXEVCNgM
        tTxFrhaL1DK5OkORIkpWyq1g9fpu3P7H1goq7/0t6gEYF/QAyMWFAt72PRYpn3dClvkhq1JK
        VRnprLoHSFb/cxEPCUpWrp6vQiMVx0ZKxDGxcZGSuNhoYTCvxbga0SkyDfsBy55kVf93GNcv
        RItpjr4W0TacaT/Q3FWUOX/YspWfc/FLavR+kHdv6wVQa7v2Vu3MwnjYZMHK+DttS5YtGkIf
        n1fxoD24zHk3ybHwdmNEuPn9xleGFKfcl0MdYccEgp+sn9w6c3Bqx4s18tBw7LH+3Y8O8Mfc
        dODpsInjLYnoiGluiytAsEPVV7Y3R2udHey0J34TX+KvMGif2L+U53ljkDhEsQV9L5z/o+HB
        p8Fbgx+mPO1Qf9/8UuclZdpk0UhWzq7rTxZPH733XepTHUmHF6pMmpkxRBcPvem4uwj/zLJ1
        saZdftHJDc/8FTDP+9g7Mfp8ZWHoNlPbvn1FESX+s4dcxvavpirE9WWnJCrWKSTUqTLxTlyl
        lv0HmCntXQYEAAA=
X-CMS-MailID: 20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df
References: <20201103092712.714480842@linutronix.de>
        <20201103095857.582196476@linutronix.de>
        <CGME20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Thomas,

On 03.11.2020 10:27, Thomas Gleixner wrote:
> No reason having the same code in every architecture.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org

This patch landed in linux-next 20201109 as commit 2a15ba82fa6c ("ARM: 
highmem: Switch to generic kmap atomic"). However it causes a following 
warning on my test boards (Samsung Exynos SoC based):

Run /sbin/init as init process
INIT: version 2.88 booting
------------[ cut here ]------------
WARNING: CPU: 3 PID: 120 at mm/highmem.c:502 
kunmap_local_indexed+0x194/0x1d0
Modules linked in:
CPU: 3 PID: 120 Comm: init Not tainted 5.10.0-rc2-00010-g2a15ba82fa6c #1924
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0111514>] (unwind_backtrace) from [<c010ceb8>] (show_stack+0x10/0x14)
[<c010ceb8>] (show_stack) from [<c0b1b408>] (dump_stack+0xb4/0xd4)
[<c0b1b408>] (dump_stack) from [<c0126988>] (__warn+0x98/0x104)
[<c0126988>] (__warn) from [<c0126aa4>] (warn_slowpath_fmt+0xb0/0xb8)
[<c0126aa4>] (warn_slowpath_fmt) from [<c028e22c>] 
(kunmap_local_indexed+0x194/0x1d0)
[<c028e22c>] (kunmap_local_indexed) from [<c02d37f4>] 
(remove_arg_zero+0xa0/0x158)
[<c02d37f4>] (remove_arg_zero) from [<c034cfc8>] (load_script+0x250/0x318)
[<c034cfc8>] (load_script) from [<c02d2f7c>] (bprm_execve+0x3d0/0x930)
[<c02d2f7c>] (bprm_execve) from [<c02d3dc8>] 
(do_execveat_common+0x174/0x184)
[<c02d3dc8>] (do_execveat_common) from [<c02d4cec>] (sys_execve+0x30/0x38)
[<c02d4cec>] (sys_execve) from [<c0100060>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xc4561fa8 to 0xc4561ff0)
1fa0:                   b6f2bab8 bef7dac4 bef7dac4 bef7d8fc 004b9b58 
bef7dac8
1fc0: b6f2bab8 bef7dac4 bef7d8fc 0000000b 004b8000 004bac44 bef7da3c 
bef7d8dc
1fe0: 0000002f bef7d89c b6d6dc74 b6d6d65c
irq event stamp: 1283
hardirqs last  enabled at (1293): [<c019f564>] console_unlock+0x430/0x6b0
hardirqs last disabled at (1302): [<c019f55c>] console_unlock+0x428/0x6b0
softirqs last  enabled at (1282): [<c0101768>] __do_softirq+0x528/0x674
softirqs last disabled at (1269): [<c012fed4>] irq_exit+0x1dc/0x1e8
---[ end trace 6f32a2fb4294655f ]---

I can do more tests to help fixing this issue. Just let me know what to do.

...

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

