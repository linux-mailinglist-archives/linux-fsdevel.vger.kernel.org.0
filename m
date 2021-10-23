Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED26438336
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJWKfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 06:35:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:44215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhJWKfH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634985130;
        bh=qT3NtbfCTi3AEJuv6B84ArZWhlTcMOfhYfUyEQtSy4g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EMhWLveFjW2tOIe8v4GZGcQOv5NMhkOjcastfzyUfFi0LAXrpsV//+xAvgqqVb/xG
         zRsUVBoQHFCPmPmjet7goK/TsO6XdAbkF6W8RayH7ycgJ8JJo1cschhVRcncQnwtbb
         b1A0Wu3s2YAuZRaiZ1w4YgIpgCvnI/gywQr2LcXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzFx-1mMHxg3VOD-00HyIU; Sat, 23
 Oct 2021 12:32:10 +0200
Date:   Sat, 23 Oct 2021 12:31:58 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Avoid open coded arithmetic in memory allocator
 functions
Message-ID: <20211023103158.GA4145@titan>
References: <20211016152829.9836-1-len.baker@gmx.com>
 <YWr7UN1+RkayVWy2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWr7UN1+RkayVWy2@casper.infradead.org>
X-Provags-ID: V03:K1:YY+/NlKd1g8gSzmVe+dTBDJxFGAdShVkdSTX36o363A70qgUa+n
 mv4UuYm/ScEiNgTwBooSc/wAYnZWXo9zjzcoCdLOk23mRZHOPAJjv8SenZMGFhFEh+CHJqA
 rg9c35kHlflCKIEra2HLhP+Q+cU1eq47oF8LsVQ8tEpOHjkYzVwznoiMaaeMY2DMXeF0KY4
 DUZT+1kOIMGNM/89N2w8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qmta2Mq2klY=:GuB15on80GlDbDftI06/I/
 4gqkrrmcy2qlk8Kfl2OBcHDtvmfdY8ChEZ5/D9fTqFLH5Sp6WacaSllR3eVg7hKlJtORyWmFz
 +Wy3k+WaJnceK2fJSuXXQ8BV3SZyYDqt5oUe5H4raaD4+76C+fZZ/Or9pypxKYbzEva1ucehJ
 xAxq4knCChNECj6Fa6s95Jh/YJuG7ccH9LbKCp0lQJJ5GW5D9EZjr0OaS/U9db8S7fwUK+CdP
 M4ldQNFV8HlIR7UuYCcOgnkYjHuz+uwm3roT8HmrMtjJf3qRpTgasywofErHwiBcXg9EseN6r
 6EM9X49KDgz1bHBBwu4dvR29ioU32Ax+0TsNpVsWoELRd+xQn0/t1R/B6xE/C3TH2pNXCm03u
 Q3zxmL3Yi4EThUERjocbmpGW1X8rvFhaZuXShmemriCvZIzdWRNRqVv4J2I1fR4VFvZjgatOI
 bPk9f0XnF5/FSXybhbghTSuToHcXbB1RTMRBLo8FdqGSHL/8/HM0kMzrk0xnDWBwYGcB6p/sW
 /Asoy9nvDVjE3pphRj6WpRPBvz45MLMWOIJgfPzj+sSFDrlMbHKA1R+uSn0YetN72NPzsljKu
 vQj771XsHX2LoDFR7zmuz38/e920kjdowqucmAyn5+hx5w0IHwcKWGnt7d47CdP8/GeGHGvFX
 S1sUy0AbT3EUz5okYF63LBZ5ybAEbG/cQ3v0WWYNgWtaMLrfHBSTkCNY0FjNYuZlcEuj8Cgjj
 YYxTDxb6kNSw+aAv/vvTaltIypjvV9AJifqfRF638In1OQP7Yq9SMVtyqWTg8N7CAeDBTnWm6
 Y5JcUVjhyWKx1qV/fvQuZYoDvdlh8J996XI9rYImJdVo2K4RXolZoS4ESUJom4LVqdUmfMDyu
 GAsiH08AR+DI5UYTvuD966AAwPMegyBGqgT51IBwqkmRCn7+zFVvi8FFaQSn6nZs5s5Tcb60b
 KTArzQxcoRTdV/uROghasMmUIY0xE3l6HsGC8kQM+ggkpmcF/ovGlZi6T+k5FB7hKb9c3feLo
 Hd21deroQbYjJVSFh1yWly/yZLMfeernuUJRinhmfG6h96DtgDRIYCSD8Ehcno+l2GWfF6iFv
 32GFeOqtTcZpQY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Sat, Oct 16, 2021 at 05:18:24PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 16, 2021 at 05:28:28PM +0200, Len Baker wrote:
> > +static size_t new_dir_size(size_t namelen)
> > +{
> > +	size_t bytes;
> > +
> > +	if (check_add_overflow(sizeof(struct ctl_dir), sizeof(struct ctl_nod=
e),
> > +			       &bytes))
> > +		return SIZE_MAX;
> > +	if (check_add_overflow(bytes, array_size(sizeof(struct ctl_table), 2=
),
> > +			       &bytes))
> > +		return SIZE_MAX;
> > +	if (check_add_overflow(bytes, namelen, &bytes))
> > +		return SIZE_MAX;
> > +	if (check_add_overflow(bytes, (size_t)1, &bytes))
> > +		return SIZE_MAX;
> > +
> > +	return bytes;
> > +}
>
> I think this is overkill.  All these structs are small and namelen is
> supplied by the kernel, not specified by userspace.  It really complicat=
es
> the code, and I don't see the advantage.
>
Ok, understood. I will send a v2 without this function.

Thanks for the review,
Len
