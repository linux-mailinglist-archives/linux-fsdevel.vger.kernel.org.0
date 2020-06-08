Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9C1F2075
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgFHUHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 16:07:33 -0400
Received: from mout.web.de ([217.72.192.78]:40901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgFHUHc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591646834;
        bh=+0Mk1yjK2wsk8hwcppnDZZx+0at1p5J3/429MEPfwlM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rs+wl+2+QhEvRUQJl7Kseu+P5Nwrblm2QOo2lMJA9GDEi7nSkvgCd4bwrh+gUpmJh
         6nNg3+O+rnkJ7IXt/26rezBFS5afd8vqNhJSvAljmSDV/gbCjAzF+kafnHOT5UB07U
         uevSoE2GFXV642qFbp6qRjOVGUxRW9YN60OD1a1M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXHOz-1jUSBj22th-00WGq2; Mon, 08
 Jun 2020 22:07:14 +0200
Subject: Re: exfat: Fix use after free in exfat_load_upcase_table()
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>
References: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
 <20200608155243.GX19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6ae85a8e-2cb6-214c-0bd9-5dd1ee949437@web.de>
Date:   Mon, 8 Jun 2020 22:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200608155243.GX19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g14BF47LfRxhGuvST1c08xmKxLpdeylO+TjTPQO+iHwcbfZZI73
 zNWWC7ITk5bmhLWQ5bL85p6GZZ5Ztq05Y+0uo6m8C955jD1WPVG/PWz2etACf8RTP/A06lA
 L4s3GiAl3uiLFrSSW16JssXZb83b8OzUpLku6X/WTDatwODp7C/NeQJqa6xyVP4PuSxAkC1
 w0qn5i88+leOCmfc/GuGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RgD5NkDub88=:GM2w+DxrJBMNAK9t3TH6H4
 GtBAThPFeDb7O7DrRTRaMUoc/YF9Cjc0L11RcPIvra9KrU75LRL6BYQV9+6hufcyjhNqRDNzE
 IuLKPxqLJca8hiOFhSx5GA6uzvY8SX8AbTKn4oJwD9ipNZkD4nNprMHvo8PR7Kl+WzhXpSjnP
 t9e3HwUUe0R2Ob14slrAwIUeZ3heyLkS0dUtYGjqhmVJI/71lHx0GUGpTJG4HkO39J9VpUQP4
 niyqZ3yD6aV9Zz/fGk3n8EhhNjHlZYSZGpPOzeKRf/L7R/5kJyqSVajJtrxoM2Vc8P3GwXJeH
 lchQuLdAgFP6z9PrQEVpTJayy/RpUq5t6TltYfNchAYl173vkR/zYZE+WdIxyhs7Z9QpXhWGm
 s75591ZgWt3yz6mtx+JUuRRguPXPnHTwL09UBMgmhoNxdcL1j15hhk9RjoFtQqfJDtz0Ivc3Q
 gu9DtZbb9rdy3Kx1q3kQvL8ckUGbL5XrjH37lSowIF/pyAYz2Gn0KB18ktKWGLDn2tqjQR4B+
 wm8/YUXk3aIDV9X5WdrIIj3tCmM1wGXxcMusE9bgdi97izzkPm4yx9yuGn5s5SJ7WYjasXW5b
 YG47XBP5Al2CeccMOweL2+n5/mnhLB15nSvHmXUkB/UFkqcd8O4/nu16iysq7hDaQit8LrQ4J
 hhB4+ymeFvSQLZB7gVzoJE49Nag/wBZ1NjDr3hajnrxiBQhuGaqNW0o6JgeIYNYWhj1F4lkPK
 iRdiACIVs8Qfu2BOmAZ/m3DLZEi2FT37e5BefawWDdDrB6d0AJy88b6JIFNV3L3AaCkfQbCPr
 VcYVd7TE6Y+OXx4jwaM2KbNSggibCwOZD4t32W4gdrsahHWocai3Psfum0bXAXOS8QllrGZki
 PZFRCycUCPzbVbwlS9qt0ybUxuRPzrlhZQq6tvoT/38OqEVrW3NWxd5cniBA4jBs0ZKPwG2FQ
 7cjOjdaCrfD15FA1OoZucMH83DwKnfADJtgVOAn53HT/5eTetRIaVmI/srRP8MwBRXtoWnzkx
 SNVjDMFx/njLgI1O76tNRh/p4nRMVa0M98X9s/9wdza2I6SDDLUFvPvgxS36OUbcBhd7F6Mjt
 OldrbJe9E9XRKla+p4bB+vHcoO+9XAYDCaM21nLznbK82vIjxjGzyUZPTqDMws3IzBn6/i043
 /wm0JGgZE4m0UMiEJBm1PsEom64iQCF87DcKc2ii2szTB/WNW8blfccogfEaY410DwkXZs9KU
 bYRf+c4rvMzIeeVu+
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> The brelse() should just be moved down a line.
>>
>> How do you think about a wording variant like the following?
>>
>>    Thus move a call of the function =E2=80=9Cbrelse=E2=80=9D one line d=
own.
>>
>>
>> Would you like to omit a word from the patch subject so that
>> a typo will be avoided there?
>
> Markus, please go away.  This comment is entirely unhelpful.

I hope that other contributors can get also more positive impressions
(as it happened before).

Regards,
Markus
