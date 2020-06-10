Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2171F5C54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgFJUBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:01:07 -0400
Received: from mout.web.de ([212.227.17.12]:42811 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgFJUBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591819231;
        bh=V/kXYOzuw6rH33xEKI0N1+DMgJKBXkECKuaKk9JHHnw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Xf7T8lewcVQ950UiWBGazQBupJWbngdQ6RKlNpv7lXxjzOiBGo58ntdcQizhBSw6F
         WBGzWXY1cKuCKdgEbGyiWYW6pkvAgW+HTwpoudoE9p9/Cl6EXKXghdBV/BqD6iszWB
         OiRXvFsW+ZQgaFqAUjAJ5nGAs3pwWo1+ELwQ/3es=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGicf-1jeNo62qtV-00DUaM; Wed, 10
 Jun 2020 22:00:31 +0200
Subject: Re: exfat: add missing brelse() calls on error paths
To:     Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20200610172213.GA90634@mwanda>
 <740ce77a-5404-102b-832f-870cbec82d56@web.de> <20200610184517.GC4282@kadam>
 <b44caf20-d3fc-30ac-f716-2375ed55dc9a@web.de>
 <20200610192244.GK19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <015e5093-d139-6bee-ca45-4cb0e871e65d@web.de>
Date:   Wed, 10 Jun 2020 22:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610192244.GK19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:1CFfg75+PNIhMjnaQFQgUxOoGYHJRs1zzs0vyK9t5n9UoWJv9Ig
 mPzwqJ5d+rMhw20lCvjXHC5KCvcB+1bOIhzn2E2SyJAbaMlB/zOe3aNf1lEflIgac/9wB/b
 DGe8OrxFqAvL3lypMV8JLiPeuesd2VFZGYdjqkHzAPfmc2yHujO6gFIoC4Xb2e6QdAz3GkK
 K5XPIrYve5ki1KAalEFfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MOzWbS8W4yg=:fpMHfAlrbTN5wB+pGEIK+u
 h0vrDtpssBVanAfTMcK/8e/dMTFFiATBtMwubX2lFbFQG/PTkBIll21BOHz6ncwSRtr4bncYv
 fghoFFgnVap9HlYNRfba1+dLJzCpyWiEbYjCB1AyCubhgvHFGWq3iZ1UkR67xpOOOrxJdpzx4
 OMbcxgpcRDnimk4SjT4Sn5XecMuw9AIq2Z5maYfPORsr5TpOTEgsrxqzyrt67aLzPnZVQ6zcS
 BG1koWnh4/GO669tfLy+5UH3TZG778v4FLffyBVcPhn+FTC4Wig15Tf/MbB7M1NWTl0ljVwuu
 HrqvMQZ35a4FCqCsFDkIHWLyB5eKOfm46lD2GMeBgrLUs4KR4Al6bFtH5MYnnbm/3IlnSGkVs
 BHAnPjKHOTCICXUKnc8Nizj0yiwWzEauRutD6XyJHNgz4FwJapT/jUMOufUY16Q72WmVWjbTb
 ytlsnh2Q67ENwY9oFq9fwO2Y6Tit/D+WP9QSmDj2y62gafOH85pMweVG1aO4H7B9+DLSUUrKT
 3RKyXwt4TZxB8BElrIKsQa5QujqpZNof1S7wjcRVQ+oCsKz0zKPK5yjUrGafVBaA6bltBFOUj
 bwF7VioP/KRMjvLOc0mr6jDENGY4KnFMve7TBywyjxl40oiIR9HMZYodRJ/ejWmlUPIQGoZaN
 NGY34FlRAfi5QeK1H4FKoWCRZw1ASCw/ZD8XjX0/kgB2maGjLlt8xfipSD7UWkPt/QOJVvnPy
 lBeTCzEOCDHHyFSv6R8SN6/Qs6fa90B2vCjQlHlwhfCL06Wq8xsxaXoWz8vz98ddW/guUtWmg
 O397UvsP3rbSKQuhCAeu+Y1mGKw/1PrUHb18XVwdtB1FHIAusIAsPdF2qt9hBbfzCeDHmtfxV
 rj8A1ZnX/5hS6C9jXsWlSGjt/cTUjZR1Z4PSd2UCzNb9Z2a2IDaQo2qv16v1+WZqCh29peHHo
 Mjju+cI/ba52ZA2H7SSH2RrxXr7Ds5ugX2zmy/gPsZwYTrYd8U+zDQ6NmMN70PhYacffH8sFt
 ATpnJ45B9veqWzOn/gSsGDmYxxIznxYbix5eu78gIZ4DgXdj7PKaF/YCddgVeHKrrl78NnhbX
 QQ5PuPn5co0kL2xWHPZ6kZ9iTaeyke+KPtzs7/xf5eSBkBkUWFaumEaIZo0f7QkxlSMDqHEWt
 dIov0Z0ft9l8lp/oWFedKXJcL8z4tRy2jqs394XO9iP83KWdIBL7/3IS57/QUHa+2tIuLPVkp
 jTm/kTEBdTdYf9WGk
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> You're nitpicking commit messages.

I am occasionally trying to achieve corresponding improvements.


> This is exactly the kind of thing which drives people away.

Would you like to follow official patch process documentation?


> Dan's commit message is fine.

I have got the impression that he indicates another deviation from
a well-known requirement. I am curious under which circumstances
such a patch review concern will be taken into account finally.


> It's actually hilarious because your emails are so unclear that I
> can't understand them.

I find such feedback surprising and interesting.
I hope that we can reduce understanding difficulties together.


> I have no idea what "collateral evolution" means

This term expresses the situation that a single change can trigger
further changes.

Examples for programmers:
A)
* You add an argument to an used function.
* How many function calls will need related adjustments?

B)
* Some function calls can fail.
* How do you think about to complete error detection and the
  corresponding exception handling?


> and yet you use it in almost every email.

You exaggerate here.


> Why can't you use the same terminology the rest of us use?

I got also used to some wording approaches.
Which terminology variation do you prefer?

Regards,
Markus
