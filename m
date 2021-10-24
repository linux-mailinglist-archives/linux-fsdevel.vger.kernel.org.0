Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144044387C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 11:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhJXJQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 05:16:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:35965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXJQP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635066819;
        bh=u4BDV842s250WtD/zqx91qjKHjMx0jeT2lBCtVYkKFQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GHr13pDoKDmRCCNwpDSuBRGnFtZsu5hy5iDFBSguvtOFAQHgOgwDFnoJU/fAp9fEe
         J6NLqE2FJJGscE6oUdB+pQCvdKs3/fY0nUEoysPRUzKVTxZfhhzhfZwLP8wYYsgTW5
         PIOaiDpYY36+J2atn6N8BRC2MhTLtBm/tlLS4SYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1mji0838C2-014ooa; Sun, 24
 Oct 2021 11:13:38 +0200
Date:   Sun, 24 Oct 2021 11:13:28 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] sysctl: Avoid open coded arithmetic in memory
 allocator functions
Message-ID: <20211024091328.GA2912@titan>
References: <20211023105414.7316-1-len.baker@gmx.com>
 <YXQbxSSw9qan87cm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXQbxSSw9qan87cm@casper.infradead.org>
X-Provags-ID: V03:K1:0wC+Ys0wsn04QEXB/dcut5eKpX4NL21c+/eYDbpuoFecMyvTA/t
 hBDYpHVn/f9unZCu1QOu0CwdHO7JxDDvwoUn+N+PVIRvz1CLNAftsq70oiWVHO1G0ppkx4+
 eZ+DxkTQDuNvd/1whCK5t+PYdK5tqbrMoIijP9e8TxcQqqA21xyeTPvf7+54a7BpVFJzrqD
 dak/+ybJHBGHsECsVf27A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FDtNjSFQpoY=:8PbrYln+szkKRqFNAdfLBq
 5AQ6KgEn1JwrOMCIkMVtC7T16zH4cVOHhgseAwX+VW3ozbJICpF1D0LoRpIrQUL5rypzrfn+p
 sfLUrqw838EXTI/k/UUbk4XvLbAkBMKFl8MDI84270oRqed5J92qsPGM69dA++xQjYhNvt7pH
 7r6uf1eJTWi24k4JP18FvwjmWv/G5t7WHUt+g7VNuk7lzgIfy4C53DXyDCPhXq6/9yKFJg23U
 zMyf91esS35kNsYbbYgq/0MhQBRFFCFBIkiG0nuzmFKaHyo6IE1pgPAp9jGZcldcKXVeX5lm4
 Ys/1vMTpRgRlv/OnZW3uxYMmjZORJnOSCwaKj1GL5sdnLOpsDZay1FqufA4XPwy+PtDFzusfr
 WNJapVLZ2TuHaMKlnmHo2oiyTRVM9aXAAc+ebI35FK2gbXeWT/FUK4Ztu43QLRhalf7l649Qw
 i7/fWaujWmZitCCeOSwRBlPKZY+j3WkflbaK3de0MtPkLRfA/wcmhrRDYtrZfdyL0cHIeQ8Pw
 gTuWNGKyx0OVkbsqPXoIHG/YjLCBqQom22fmsDADo47LOIYIGjZArdXDMBcQym7ezkhinMikR
 l14d7YYenVf7gqm9fnZTBRJwY+IJnwen8syS/axmty6gfvc/414+d7tVdNJ7UQMoxsWiEDkGn
 vWMWUbXIYDpnGI78a2OLYv7X5VU3vWng7+MTmIw1U3hMj3SiO9T7kSVwy8kDTUbZr+4oPzesq
 IL5/bZbCu7TarCYnpjaCEVLsVkHhIzIqNlG9eiMsaAGPVGyMZOeXnITZBFmXFg9By3CBSwDPY
 cD0q0a2iAqwPOJ74WSzbx/6AQayrWAQFRiH1dCZE81WpU8UiVP4UcB12DVCbPg1zywB/8jfYx
 rtTaOmivnqg0vo/g4EXngOVxs1OnNmBPrsm8YeMgED9xBz9fSwgUNowtNQYNIg36eW4bI+9KT
 lVuxa574SAlCG32/iRvc6tE6cbK+kGZhihSCUN6WygYrjHGblgjrRlRlH9Y+92uOtEm/rjSo7
 7QYojATFHSO42X/cCpqhcK/bfKwyGr+Vj5FcgtqNerePFi3oNHFSmRUFhQKTFA1YgtimwzlhL
 wKbP/vw8SP5ks8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

thanks for looking at this. More below.

On Sat, Oct 23, 2021 at 03:27:17PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 23, 2021 at 12:54:14PM +0200, Len Baker wrote:
> > Changelog v1 -> v2
> > - Remove the new_dir_size function and its use (Matthew Wilcox).
>
> Why do you think the other functions are any different?  Please
> provide reasoning.

I think it is better to be defensive. IMHO I believe that if the
struct_size() helper could be used in this patch, it would be more
easy to ACK. But it is not possible due to the complex memory
layouts. However, there are a lot of code in the kernel that uses the
struct_size() helper for memory allocator arguments where we know
that it don't overflow. For example:

1.- Function imx8mm_tmu_probe()
    Uses: struct_size(tmu, sensors, data->num_sensors)
    Where: tmu has a sizeof(struct imx8mm_tmu) -> Not very big
           data->num_sensors -> A little number

    So, almost certainly it doesn't overflow.

2.- Function igb_alloc_q_vector()
    Uses: struct_size(q_vector, ring, ring_count)
    Where: q_vector has a sizeof(struct igb_q_vector) -> Not very big
           ring_count -> At most two.

    So, almost certainly it doesn't overflow.

3.- And so on...

So, I think that these new functions for the size calculation are
helpers like struct_size (but specific due to the memory layouts).
I don't see any difference here. Also, I think that to be defensive
in memory allocation arguments it is better than a possible heap
overflow ;)

Also, under the KSPP [1][2][3] there is an effort to keep out of
code all the open-coded arithmetic (To avoid unwanted overflows).

[1] https://github.com/KSPP/linux/issues/83
[2] https://github.com/KSPP/linux/issues/92
[3] https://github.com/KSPP/linux/issues/160

Moreover, after writing these reasons and thinking for a while, I
think that the v1 it is correct patch to apply. This is my opinion
but I'm open minded. Any other solution that makes the code more
secure is welcome.

As a last point I would like to know the opinion of Kees and
Gustavo since they are also working on this task.

Kees and Gustavo, what do you think?

Regards,
Len
