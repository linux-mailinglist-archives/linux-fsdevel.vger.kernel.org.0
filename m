Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF4D2CDC5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 18:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbgLCR2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 12:28:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41314 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgLCR23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:28:29 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201203172736euoutp02cfeb67aa52bc0760e3d5fc2d5cf82885~NRPPgYCtf0760407604euoutp02L
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 17:27:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201203172736euoutp02cfeb67aa52bc0760e3d5fc2d5cf82885~NRPPgYCtf0760407604euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607016456;
        bh=GjaFqTJ5lp61k/LGJVQAhrKoVyTGjwsxrnSkt04ovtE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F5J9vp0rzYz6KHiYYsCJEkwdQ5/2R/N94lGrhDRb5FR4n19iVy0WsQfjsHQmTKfhr
         VWDJfJrzd1S2X36CRh89gHzb5cUaa5WQpuI/U2E1sEHUZFDjpZ6hbzsUvf62pK3HJX
         znO/84PY8VdVAdkD9hSQyTWzgYj91HR9HLOQjzZ4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201203172726eucas1p264e2e84dc61dc8b723bb7bedcbf57861~NRPF_y_dX2650426504eucas1p2D;
        Thu,  3 Dec 2020 17:27:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D8.92.44805.DFF19CF5; Thu,  3
        Dec 2020 17:27:25 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201203172725eucas1p2fddec1d269c55095859d490942b78b93~NRPFnjqiC0463904639eucas1p2i;
        Thu,  3 Dec 2020 17:27:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201203172725eusmtrp1e973a606237785b1f9a1a54bb0d32974~NRPFm2BV42689826898eusmtrp1k;
        Thu,  3 Dec 2020 17:27:25 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-6c-5fc91ffdba9d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.F3.16282.DFF19CF5; Thu,  3
        Dec 2020 17:27:25 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201203172724eusmtip1189e0e7a7c619e60fb77515c850b4375~NRPE-sis71314213142eusmtip14;
        Thu,  3 Dec 2020 17:27:24 +0000 (GMT)
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <0107bae8-baaa-9d39-5349-8174cb8abbbe@samsung.com>
Date:   Thu, 3 Dec 2020 18:27:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <bb95be97-2a50-b345-fc2c-3ff865b60e08@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTdxj1d+/l9rZavBaUb4i6NIwFo4BM3SVTJvF1XbJHjMlwyYJVbhAH
        RVuKY/MPArq4rkFUtLVg5CEpIhYpIgzGItUWKgPc6hMZKWglQglCeWxUUNrrg//O+b5z8p2T
        fBQu+dsvmEqWp3MKuSxFSoqI69b/O1dPr7AlRE0NxjCFVZUk0z5wXsBcNn3JXLpswRjnaC7B
        FGhzMOaPJhvB2BsKSaan8pUfU1OqxhjPf7N0JLuH3LSAvekaxtkik4qtKV/JmkZPCdhWnYdg
        f++NYRsfZZHsiLOLYIf/vEeyfxXdErBu0/Jv5n8n2pDIpSRncIrI2D2i/e3WcvygQfTjQ+vG
        LNRGqZGQAnotqM21mBqJKAldjmDgRQHOkzEEZ2+NI69KQrsRuO4L3zrKb9rfiAwInutPkjwZ
        RtBmeexzBNBx8KvTIPBikl4D6iE16cWB9A74V92HvAacLsHgTIHLtxDTsaDLa/eZCToUnkyc
        85kX03uhecTxRrMIbOeeEl4spD8Hz/mLPozTKyCn1pvbi4Og6+kFXyGgS4WQbejH+dxb4I7R
        6cfjABhouSbgcQi0ndYQvCEHQW/HFQFPNAjs2TrEqz6D7o6p2RjU7IlwqGqI5Mdx0FHWS3jH
        QPvDw6FFfAh/OHVdi/NjMRz/RcKrw0DfYnx3tvnOP3gekurnVNPPqaOfU0f//m4RIipQEKdS
        piZxymg5dzhCKUtVquRJEfvSUk1o9uvaZlrG6pFhYCTCjDAKmRFQuDRQ/LisNUEiTpRl/sQp
        0hIUqhROaUZLKUIaJN57rTJBQifJ0rkfOO4gp3i7xShhcBam03T9Nm6zhD93u+rSd38c1rwb
        OoLjsSr3cPWBBwqR/YTRXNt4VBq+Z8HCME29Xnc7eFx15Qvnqwmt/ZGj7NBE3JnRn6MYR3fF
        Osl88oPvm3uObK5wGR3b47moJ0h4/5O+r3WZ21AARsjI/OODD7aC62XjKuON7laNlf5o4u6z
        efhk9eri+v4lk5ojJdOfZsY4diU6MtynZwL9FflNXwkzGrgSq7nJNhNri/bk3xjUGteHlBZP
        +RdfcHxbdKLPk2u+vcEvpH2jZmdjdV5k7fSxndmTxuhtH46GFqYpZXct8gM1qviri7fXdS7d
        oQ3tb31x6WRdcueyi65dQ5ax3IVXpYRyv2zNSlyhlL0G00TxRuQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7p/5U/GG8w4oWIxZ/0aNouzr+ay
        W6ze5GuxcvVRJounn/pYLGZPb2ay2LP3JIvF5V1z2CzurfnParF5cReTxe8fQO7HpntsDjwe
        h9+8Z/ZYsKnUY/MKLY9Nnyaxe5yY8ZvFY+dDS4/dNxvYPD4+vcXi8X7fVTaPMwuOsHt83iQX
        wB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3H2
        2ArmguVcFTeO2TYwnuboYuTkkBAwkVhx+DJzFyMXh5DAUkaJPRueskMkZCROTmtghbCFJf5c
        62KDKHrLKPHq4DQmkISwgKNE59PlYA1sAoYSXW9Bijg5RAQ8Je52PWIEaWAWWMQkMWfZbKju
        KcwS0zauYAGp4hWwk5gx4SwjiM0ioCLx+NtMsEmiAkkSv5euZYOoEZQ4OfMJWD2ngL3E77lL
        wGxmATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmB0bzv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe3vpiXgh3pTEyqrU
        ovz4otKc1OJDjKZA/0xklhJNzgeml7ySeEMzA1NDEzNLA1NLM2MlcV6TI2vihQTSE0tSs1NT
        C1KLYPqYODilGph2Mk49vHbG1/k+PAkauxzNuHOXNLBcqpo+aclqttQZbD0ijE9K+vyL/ma9
        OJHEEH+hQVH2Yn+97ZeYotWZOvZTt4idltbgapjY4n7bQYVlc+G5yG6/AKY3svst/whfnLKe
        e4dy4t20/gNJ0n11Aoxycm7vvu51uOX5YM+7za7uAh2Mn4vUMo7H3j1XwMrR0+e1yc7B4cH8
        /O55vV8UL13f8HXnn9m2zY1PuOKbk53+HVpVXZKl+3YFB+cfZanKB/0292rjWtd53fhurb4r
        1LR/yqJQi2V5FnGmSzp6dW5kT15swClqu9te9sEEj87La1w/vImf7vj3iO/0wJgXlxqcpHNO
        3DurFFd6JGT3DyWW4oxEQy3mouJEAFW9ZZZ3AwAA
X-CMS-MailID: 20201203172725eucas1p2fddec1d269c55095859d490942b78b93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201203172725eucas1p2fddec1d269c55095859d490942b78b93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201203172725eucas1p2fddec1d269c55095859d490942b78b93
References: <20201112212641.27837-1-willy@infradead.org>
        <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
        <20201117153947.GL29991@casper.infradead.org>
        <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
        <20201117191513.GV29991@casper.infradead.org>
        <20201117234302.GC29991@casper.infradead.org>
        <20201125023234.GH4327@casper.infradead.org>
        <bb95be97-2a50-b345-fc2c-3ff865b60e08@samsung.com>
        <CGME20201203172725eucas1p2fddec1d269c55095859d490942b78b93@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

On 03.12.2020 16:46, Marek Szyprowski wrote:
> On 25.11.2020 03:32, Matthew Wilcox wrote:
>> On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
>>> On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
>>>> I find both of these functions exceptionally confusing.  Does this
>>>> make it easier to understand?
>>> Never mind, this is buggy.  I'll send something better tomorrow.
>> That took a week, not a day.  *sigh*.  At least this is shorter.
>>
>> commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Date:   Tue Nov 17 10:45:18 2020 -0500
>>
>>      fix mm-truncateshmem-handle-truncates-that-split-thps.patch
>
> This patch landed in todays linux-next (20201203) as commit 
> 8678b27f4b8b ("8678b27f4b8bfc130a13eb9e9f27171bcd8c0b3b"). Sadly it 
> breaks booting of ANY of my ARM 32bit test systems, which use initrd. 
> ARM64bit based systems boot fine. Here is example of the crash:

One more thing. Reverting those two:

1b1aa968b0b6 mm-truncateshmem-handle-truncates-that-split-thps-fix-fix

8678b27f4b8b mm-truncateshmem-handle-truncates-that-split-thps-fix

on top of linux next-20201203 fixes the boot issues.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

