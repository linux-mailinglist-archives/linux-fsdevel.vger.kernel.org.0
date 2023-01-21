Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AB16765C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 11:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjAUK5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 05:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUK5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:57:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAFC4DBD2;
        Sat, 21 Jan 2023 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674298637; bh=L/aJJn/riBYG9saLW8J+sSsBQJtwlVhELhY1kNywEKw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nnzt9ZppPiw/3D6ZRnJNFnZsDJjBpLxJF7g7N35RXr2SIodmoNUI7UchRHPug9srM
         /AU6UCnU1Rh2BxIOWJ7Wu0fv+gsGio62RKqhJxu6Hteny6w0I5L077afhNr9PVuDVu
         LHr4dYmhraGv9xZOvmIKzJ3oS1ny91lNWe8rRDq6PNqfJ8MXcRGU6+ZjcqPJw2aYmg
         rTyJKDStbqY1Aep0c+pq+n1gMKv9765nEDQFmuIOjSGNRGSmoUIvHfliwELWR5RCB/
         NxkPRjRPJrdoAER+XVro/RGj/IpZEDv7QpQQ8fi22q5Li1v3n8IAOnWT/DVdPaex+b
         /UmyZYr7To3wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.167.128]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1pFrfU45hM-00Vvkl; Sat, 21
 Jan 2023 11:57:17 +0100
Message-ID: <c08af0ee-fc12-7a3b-541d-677c3e562f56@gmx.de>
Date:   Sat, 21 Jan 2023 11:57:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-parisc@vger.kernel.org
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com> <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org> <Y8ocXbztTPbxu3bq@ZenIV>
 <Y8oem+z9SN487MIm@casper.infradead.org> <Y8ohpDtqI8bPAgRn@ZenIV>
 <Y8os8QR1pRXyu4N8@ZenIV> <99978295-6643-0cf2-8760-43e097f20dad@gmx.de>
 <63cb9ce63db7e_c68ad29473@iweiny-mobl.notmuch>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <63cb9ce63db7e_c68ad29473@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2CePjF77Ha7Q1nQOpmAu5Q3MyXKGyF6zxHSHI4OxB2M9T5p56Lw
 UEvfwBpr6ETXCOVcGweRFq4Nxm9W8kpBWQCrxHPjTko40l22JAIKQsyadL1jag3bA5r6oFm
 se/qfX8J5WfWjN+snHIGFVZ6k7V9KlN4ngPT6+5Y8q39SdbnwgHvGs79qCMoGCLubzTnywq
 bxMVJDT3UNE6wseKkypTA==
UI-OutboundReport: notjunk:1;M01:P0:FOIQGLWQYVA=;Wha5wQCPYkD5gaDFCBmkC/oTPGI
 qAtlkfX6VXbc4ciHNrGtzAHlW5tG7zpXbW8VgpjlWg4RrsQqt0WqO3uwzh9q8ODpUxj6glPYi
 QBS3hSaK4+/eY1721l6THgcYVE4Gq4xbdXBl187oEtVPHFVm72JAH70gJmEQzGLI+jeciYOT7
 A37XrVJ0daHVJy8hE5ZKzIG4WbcTE4Jg3wjeyytkO80eNXoIcPqeSdL+fJ707xth8AI7tBwxD
 dGxGacstA/Clz+JnYzsnmU7+8F5cJpZdPRkK3sHv+jM/oCKZ/+mBjF8gVy4EVEHdBBN5gZZc6
 0QHpOGdfRZ4yX2aQQzqI3AD6XOtmxOZWPYy9H26SXMkcekpacZAZ4G94CPFVQoeMw1JSjqO1q
 9nK9X5uCtLaoxPoecf76LOIlhLAVBLnTqYhGTWbv+n3OEihCnvGnxmkKnDYv1nIw3l9A9JNVz
 x9msqUj3wB4kvYL4Fs4fDLbznR74GOq6nMxhG+CT2Qr/F1HfKXjLmc6czJK+MSAOHnZhsuYpy
 quc3DSa1Ch1FnpIMiEGBEs2dMfdRuVeyIYfHTCafwxVJLdGJDOO6wUu64IjEG5tm3ydw8RksD
 TShJ1o6bX74Q/4kGZM26GpWdJU3t4uhabHQxZzd4cAOiYIrrTdks7bLC74mKnKXZMLg5BDmDc
 Kil6k2zLt77cLHosUnO+e8aUgYpo32clGsgnOdDzphBmLNOMAz0EWh7gSltVeIPJfP0TIKKkn
 0voVv4ylo/Ss6/mtqYvL26kWaMJ4eCz5mNZELcZuaVTE3tLAjDvt2uwL/Q5RkbKbfRjlBCV3F
 klcyZLOKmrbvfHRDeU1z2IPuklrBJkq12JeQAswadJImABEGvLMcvsSZEneXbZIGwSzLZ6j0b
 gpTzqQOTMhoyzbbaYsvaK6eZ118QOIrxPyuFnvZOIct5yeEzKirLrkfc49Q65gKSZeq0bEJhk
 7Nnm/LCJJ93hzMFchD1ojkMjvGY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/21/23 09:05, Ira Weiny wrote:
> Helge Deller wrote:
>> On 1/20/23 06:56, Al Viro wrote:
>>> On Fri, Jan 20, 2023 at 05:07:48AM +0000, Al Viro wrote:
>>>> On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:
>>>>
>>>>>> Sure, but... there's also this:
>>>>>>
>>>>>> static inline void __kunmap_local(const void *addr)
>>>>>> {
>>>>>> #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>>>>>>           kunmap_flush_on_unmap(addr);
>>>>>> #endif
>>>>>> }
>>>>>>
>>>>>> Are you sure that the guts of that thing will be happy with address=
 that is not
>>>>>> page-aligned?  I've looked there at some point, got scared of paris=
c (IIRC)
>>>>>> MMU details and decided not to rely upon that...
>>>>>
>>>>> Ugh, PA-RISC (the only implementor) definitely will flush the wrong
>>>>> addresses.  I think we should do this, as having bugs that only mani=
fest
>>>>> on one not-well-tested architecture seems Bad.
>>>>>
>>>>>    static inline void __kunmap_local(const void *addr)
>>>>>    {
>>>>>    #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>>>>> -       kunmap_flush_on_unmap(addr);
>>>>> +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
>>>>>    #endif
>>>>>    }
>>>>
>>>> PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?
>>>
>>> 	Anyway, that's a question to parisc folks; I _think_ pdtlb
>>> quietly ignores the lower bits of address, so that part seems
>>> to be safe, but I wouldn't bet upon that.
>>
>> No, on PA2.0 (64bit) CPUs the lower bits of the address of pdtlb
>> encodes the amount of memory (page size) to be flushed, see:
>> http://ftp.parisc-linux.org/docs/arch/parisc2.0.pdf (page 7-106)
>> So, the proposed page alignment with e.g. PTR_ALIGN_DON() is needed.
>>
>
> I'm not sure I completely understand.
>
> First, arn't PAGE_ALIGN_DOWN(addr) and PTR_ALIGN_DOWN(addr, PAGE_SIZE) t=
he
> same?

Yes, they are.

> align.h
> #define PTR_ALIGN_DOWN(p, a)    ((typeof(p))ALIGN_DOWN((unsigned long)(p=
), (a)))
>
> mm.h:
> #define PAGE_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PAGE_SIZE)
>
> Did parisc redefine it somewhere I'm not seeing?

No, there is nothing special in this regard on parisc.

> Second, if the lower bits encode the amount of memory to be flushed is i=
t
> required to return the original value returned from page_address()?

No.
If the lower bits are zero, then the default page size (4k) is used for th=
e tlb purge.
So, if you simply strip the lower bits (by using PAGE_ALIGN_DOWN() or ALIG=
N_DOWN())
you are fine.

Helge
