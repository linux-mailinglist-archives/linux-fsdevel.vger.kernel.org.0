Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4F674DE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjATHTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 02:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjATHSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:18:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2741632C;
        Thu, 19 Jan 2023 23:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674199043; bh=80y1MrhjmMjLHjFUtuMNBWfKyaa5GeSPeR9E2iNImV0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PKQEzm3apQCB5altG0YYIdc821vvm/YhBkp1eS4J3LAm9L6c74Jw7NGLgH0XfmKWg
         6FZiJpZsMR3ZbeAU88wiq/c0pSlVAspy562ArvvgfnoOEaHoQgWxnsZ0U0QJauzYy8
         v+2pmH7Hf9rtQ6Y2IMDnpRt9jOfCp5UhRQc7Yd1aixOuKuGv9iEzqhwnbrduaWa/Ux
         vHj/EOpsnJnQr+jFlmEOpFrOam0WgFQqXzmNLewl7ck+BszgHcilPW/WjJf2gZrKNO
         zaDAI/xa2hS9WrrtoQsPvxGpn1Ec8v3Ud2SuBgmO07BLmOtPwP2LcMtJxlLJ33qnhZ
         BuAt2iU7fuNiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.164.19]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1ozBX81ku9-00K9Dm; Fri, 20
 Jan 2023 08:17:23 +0100
Message-ID: <99978295-6643-0cf2-8760-43e097f20dad@gmx.de>
Date:   Fri, 20 Jan 2023 08:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, linux-parisc@vger.kernel.org
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com> <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org> <Y8ocXbztTPbxu3bq@ZenIV>
 <Y8oem+z9SN487MIm@casper.infradead.org> <Y8ohpDtqI8bPAgRn@ZenIV>
 <Y8os8QR1pRXyu4N8@ZenIV>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y8os8QR1pRXyu4N8@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+rmzJQ5b+xbugZINHznwY3UUHSojPeB+BilcGK98fBl7vz4Lfba
 iF3HC4OPJOe6erEFY0NK3DhA02ne0dkrSalCae7DlODKbJZdt0FwqseJSuSDZEzRHWm2A6F
 BtlKEW9MUN3StmM5S0RIyip94mwwNig/THjTYXm9W6LJsOf+T9l/J+JxLfCjvsm+rrJZ8yY
 6RLl38O48SWF8zy43ArxA==
UI-OutboundReport: notjunk:1;M01:P0:8we8Y/B4Vl8=;I1kvAezwExFQ6c1Bx712wbIOTzV
 U8RKMVDD4nSPPLHjiL0+UGEsH545QWmAw6VTyGlr3yFSdAaINoJpl7Tfjcq5OhzAvyJqofuTr
 RZ3BFVfSKQlVN6+/5uB3aaCBxLgX3wlwzeEw8d9ChZF+MKMycPWHlyApIGwpK7SDECtkK3CmU
 yIY87bsmACWBExNTgD4Facv1mAgI5cag1sdlh3QaynlEjvMuRGDUvsrnUXUZpHhIuQjLQk6kh
 DlPKfqaUEYc5982Pm1V0sZsaOFMJBXXOhFpvWq3IZlBJSmvGFOhgusGfH7bIFaLxdmZpQEhoC
 LNzJP8xrEB39fLJmFp3vHnp5KwAzVDIMiq/FQPhfFm1yjiHSbHoJaPxs+CN9a9xstH/rKp99v
 OGmOxyPRmcfz5WnJqX25gJQaqyIV4zmpPT5LAYLpoSFZp4YTYm4khOf31v84QhiNIO+SkfOB0
 P+zykH/EAcuoLsmdeD1QrvsJQTZYHhREAWr5devw2+kSx4XVcBc1T5/YjQWTCK8D2mRHruJmx
 XfESR/FiWsR8Em3uE18KawNoVvNPf8Rqv4n+bHpiFtO1Ka9ofvmtqX5Ww9SKLv5XW/UrgROAk
 nfNSggDW4XP1b3TiSW/5mjMR7PVrWjIW3b4XEtTHWvJJrcgWudNI4QRQe8ty3X5HMBEpbv6AZ
 JEbd4bQ+Zirb3xlUZUmPC1EHF+kVlI1Ab23Q2ktVLUY9+iCK1tE8TFIxLoZkXLhEWQT0QLIv3
 Ud0RdbdfqQbJAUiPYrY7GDFFygvXimIZVvo9B9ekKxA/Q5owirLzsf7slXQGdTZYSDeMuPNUl
 VUYQz5jVDHsGWL/ZJitE0wywushk5Pia7Vw7ybuDI+cAiJ2vkoFtj+W3K77ZtUf+BFcobs40F
 JYaghDR3Z8nLpb7C+/94PkeBTwNBxA1852t7Jwj0T1ynj6Af9KZvW8RWg7/j/AJwo29dYqd0T
 0Z9NBw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/20/23 06:56, Al Viro wrote:
> On Fri, Jan 20, 2023 at 05:07:48AM +0000, Al Viro wrote:
>> On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:
>>
>>>> Sure, but... there's also this:
>>>>
>>>> static inline void __kunmap_local(const void *addr)
>>>> {
>>>> #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>>>>          kunmap_flush_on_unmap(addr);
>>>> #endif
>>>> }
>>>>
>>>> Are you sure that the guts of that thing will be happy with address t=
hat is not
>>>> page-aligned?  I've looked there at some point, got scared of parisc =
(IIRC)
>>>> MMU details and decided not to rely upon that...
>>>
>>> Ugh, PA-RISC (the only implementor) definitely will flush the wrong
>>> addresses.  I think we should do this, as having bugs that only manife=
st
>>> on one not-well-tested architecture seems Bad.
>>>
>>>   static inline void __kunmap_local(const void *addr)
>>>   {
>>>   #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>>> -       kunmap_flush_on_unmap(addr);
>>> +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
>>>   #endif
>>>   }
>>
>> PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?
>
> 	Anyway, that's a question to parisc folks; I _think_ pdtlb
> quietly ignores the lower bits of address, so that part seems
> to be safe, but I wouldn't bet upon that.

No, on PA2.0 (64bit) CPUs the lower bits of the address of pdtlb
encodes the amount of memory (page size) to be flushed, see:
http://ftp.parisc-linux.org/docs/arch/parisc2.0.pdf (page 7-106)
So, the proposed page alignment with e.g. PTR_ALIGN_DON() is needed.

Helge
