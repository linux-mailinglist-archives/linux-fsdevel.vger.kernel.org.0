Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5199438AD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJXRBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 13:01:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:39047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJXRBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635094731;
        bh=yyqnnF1pA1oiTEWv7jqmS1u+g29rW0YaZQRATIp5BBM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FWdSpG6JvGfsXFFIqKu/wHhWw2xv7aTzILC2+WJ4GtFMKMBS/I/2tTzPsewAuifoe
         63ok3Ww90ouUwJdRicdR1nsxYPG8DCcpdjBb7sbT6+qroIi5YRkouH82LlxQAc0/I2
         ciRfL89rNRTj4yaDwg6mtj3KHGzfdBvtfRELA3jA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1mwlsf0FdK-00ra88; Sun, 24
 Oct 2021 18:58:51 +0200
Date:   Sun, 24 Oct 2021 18:58:38 +0200
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
Message-ID: <20211024165838.GA2347@titan>
References: <20211023105414.7316-1-len.baker@gmx.com>
 <YXQbxSSw9qan87cm@casper.infradead.org>
 <20211024091328.GA2912@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024091328.GA2912@titan>
X-Provags-ID: V03:K1:+U3sdvB6WXlvapI04bmnM1r0ixdY76yc5bUl1lBzkoomXBfOdiU
 0uBM+LwV+/b8DsiddmrWcfYHvKUBa6mGbjS0rpXqF9nMFyJ0e4vxxz5CAGLDQG2lvLReQQz
 QajPx8XGzfqFZKtCLphSD0XU6nHBaxs3LCCO+w5URArsWmVlDLHkv7AM9lfIW6sW1Rci+kR
 LaujWFoCdkUE87vSt+xhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M/xM1uCOQts=:+3/dlM61TnUBnljTWWtdO1
 M9DcUAb91kJHkcY6AuK0t8Icescrmd423kB9FxPpcpq+EaU5I9Xkf9srNrFH97S0VFcKf/Oau
 WIwbRspeAAeNz8ps5TYUb1ZMwpk8tT7ARcqgg48xLI7KGIDeJzs8F3htzXp9kImDd2dAdswfN
 9/9uwl07jREODSuZyQY1kI8HmAZHkFc+dz0djV2SZujyc9TvTPAhVgjbK0pHnNm80wh6f3qiU
 m7xKIW5JjIETpV9D7gy0D9JSfgBV8LDBrkAPo8XHvvr0ZH2WC7qRI5s2t0S7kw0kaNLCGkUCj
 pGm9VT6L0huUKdSC6LwHbo93Nuw/ZREY+Beay5HiNjFkMDU1c9JOrKwswFCFRV6l8X/Umdqw6
 QDYakjy7Avr9c6Mur1L8OjTYXKYlSmu7zKjk10po5zoQ/Dxht9kvoglAqPptoKKj6w/Xx7klb
 y+lk3X7qXLdyrqFp1+fJU8GWDIphpgsQjqDe0YXlpLkOQ9BRnLGAD0SLqu4MYCo1mfSf6Rpq6
 xK5QPvYAt6PSXltX7gG3vZlVZkE4C5cF1ZfI8b4rPlKTUB6scnCCBqBLFqiGqsnV0DULwTNxS
 KbNBmwQW57VLdG2/VPOWGTPY5KKQwOiShui+8U+kEL/L8TVf7sZdF0T4qRhLTlDPJ6lTARL1T
 si+O/J5zoCxTuYkghz5aSbgWU88TTq7OHl4sWkRXQy6YT0KEnhak3fEg8jBVZC8JTe4EHj01f
 qRSqkufd1lICel8n2PKwAmX3Ab8RRTZS0BBNw9AJfHckglhj0mqJ4ZBnj4YYcOTJMMz9XPKn+
 Z0U5nIsilFiEIpXThOTebSK/GVEF1JTll3vZSc3eRTJiHAAKBWwBMOYgwsgZOFnPwNgwbWnFk
 3pqzPIB7+pr4df1ZHZOOu2D1fKJpezys8uExNKAgHykU5r7SOJ3GKp3T7XZrYp0T+c3t64v9J
 474TIFSUAqP7iP4FPwSfk4QhrUQc1j8WiX76Uwj4FV8XYwZ7vc75FtVk7QxCUebwbIRTJSyM/
 JXvMimibutoppPVSpSmkXmyrlfvdV7Ubt4tJb9WgLix2B5SqKJKmmAyFZOPl/TSWEAzpTO/iy
 Is9iZnSud4BbvQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all, some additions below :)

On Sun, Oct 24, 2021 at 11:13:28AM +0200, Len Baker wrote:
> Hi Matthew,
>
> thanks for looking at this. More below.
>
> On Sat, Oct 23, 2021 at 03:27:17PM +0100, Matthew Wilcox wrote:
> > On Sat, Oct 23, 2021 at 12:54:14PM +0200, Len Baker wrote:
> > > Changelog v1 -> v2
> > > - Remove the new_dir_size function and its use (Matthew Wilcox).
> >
> > Why do you think the other functions are any different?  Please
> > provide reasoning.
>
> I think it is better to be defensive. IMHO I believe that if the
> struct_size() helper could be used in this patch, it would be more
> easy to ACK. But it is not possible due to the complex memory
> layouts. However, there are a lot of code in the kernel that uses the
> struct_size() helper for memory allocator arguments where we know
> that it don't overflow. For example:
>
> 1.- Function imx8mm_tmu_probe()
>     Uses: struct_size(tmu, sensors, data->num_sensors)
>     Where: tmu has a sizeof(struct imx8mm_tmu) -> Not very big
             sensors is an array of struct tmu_sensor and the
	     sizeof(struct tmu_sensor) is small enough
>            data->num_sensors -> A little number
>
>     So, almost certainly it doesn't overflow.
>
> 2.- Function igb_alloc_q_vector()
>     Uses: struct_size(q_vector, ring, ring_count)
>     Where: q_vector has a sizeof(struct igb_q_vector) -> Not very big
             ring is an array of struct igb_ring and the
	     sizeof(struct igb_ring) is not small but also no very big.
>            ring_count -> At most two.
>
>     So, almost certainly it doesn't overflow.
>
> 3.- And so on...
>
> So, I think that these new functions for the size calculation are
> helpers like struct_size (but specific due to the memory layouts).
> I don't see any difference here. Also, I think that to be defensive
> in memory allocation arguments it is better than a possible heap
> overflow ;)
>
> Also, under the KSPP [1][2][3] there is an effort to keep out of
> code all the open-coded arithmetic (To avoid unwanted overflows).
>
> [1] https://github.com/KSPP/linux/issues/83
> [2] https://github.com/KSPP/linux/issues/92
> [3] https://github.com/KSPP/linux/issues/160
>
> Moreover, after writing these reasons and thinking for a while, I
> think that the v1 it is correct patch to apply. This is my opinion
> but I'm open minded. Any other solution that makes the code more
> secure is welcome.
>
> As a last point I would like to know the opinion of Kees and
> Gustavo since they are also working on this task.
>
> Kees and Gustavo, what do you think?
>
> Regards,
> Len
