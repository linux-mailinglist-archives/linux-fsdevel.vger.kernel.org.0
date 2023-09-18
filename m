Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB377A4EEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjIRQbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIRQa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:30:56 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006321EBA;
        Mon, 18 Sep 2023 09:28:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 15E2B60186;
        Mon, 18 Sep 2023 18:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695054495; bh=Sm0N3ynWqQ46F7faVkeKStgJuGy+OLIzp7da6H/9Zos=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A6eDIFqGD/RANk157jMrthoNd5Vyl1ivTmeXy2HshUKuSUypams93vvaAjNzLV/D8
         G0UaEjKoGFKpoPAGmQx3d8Rnpxe6lalMA0csme6TOS9vSEsVz3pnZS4G9eB1qgkq6/
         oxjN4brhFuJsUPdeLksEqGBftC5Ja+jWnirPx10NCiTNprGar4Ltj6nLSmQ8IpVxtj
         MtYkUfOswHm8lR70M3cH6K6oKFJmzXZD+2YFzrV90hNPBY0WyFsWHImcrt30mM1udn
         7RUSJwVo7lKLVmiu1tN2vxR/ji4JnXiSnW51fbowwn2Kjh/QxHIChin76ToGcIQgc2
         BkWPz3MhPM4Nw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cjdwUePntF3d; Mon, 18 Sep 2023 18:28:12 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-14.adsl.net.t-com.hr [78.1.184.14])
        by domac.alu.hr (Postfix) with ESMTPSA id 1A08560174;
        Mon, 18 Sep 2023 18:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695054492; bh=Sm0N3ynWqQ46F7faVkeKStgJuGy+OLIzp7da6H/9Zos=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oppd2VHMDc56Z1aRno3gGAY6Uj+TdGlzVDwspfD2eUTe1IYkC3WB9WSfETVTLs/vG
         urr5C1KB4sDSPj6xlulLU6Eb/v3eXCfN0a8KgpQyLxy2ZRpMWStAGS4ynNnU7ln3Y/
         tG4c0NMOciPYs0nuf9DKUkWIyi6WP7mGW27JGNXxIB3evxBWbWC/9LI9T8oAOcYWgw
         uYH1yIm/M2l9QR1blJK+df8dBO1jiTj22PJhxaXX9udYMgM8u5BEpnf6A/PeyDSUbZ
         WWQ1owYvnDIJxMT3MXHA/QRcP+X7I/V0Al36lESp861x4KasuUHqmFUDS9DewUp1Gh
         0kJRUomDL13/Q==
Content-Type: multipart/mixed; boundary="------------SdM57NH5CFmGTcDmkBlkGKQN"
Message-ID: <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
Date:   Mon, 18 Sep 2023 18:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
To:     Jan Kara <jack@suse.cz>, Yury Norov <yury.norov@gmail.com>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad> <20230918155403.ylhfdbscgw6yek6p@quack3>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230918155403.ylhfdbscgw6yek6p@quack3>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------SdM57NH5CFmGTcDmkBlkGKQN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/23 17:54, Jan Kara wrote:
> On Mon 18-09-23 07:59:03, Yury Norov wrote:
>> On Mon, Sep 18, 2023 at 02:46:02PM +0200, Mirsad Todorovac wrote:
>>> --------------------------------------------------------
>>>   lib/find_bit.c | 33 +++++++++++++++++----------------
>>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/lib/find_bit.c b/lib/find_bit.c
>>> index 32f99e9a670e..56244e4f744e 100644
>>> --- a/lib/find_bit.c
>>> +++ b/lib/find_bit.c
>>> @@ -18,6 +18,7 @@
>>>   #include <linux/math.h>
>>>   #include <linux/minmax.h>
>>>   #include <linux/swab.h>
>>> +#include <asm/rwonce.h>
>>>   /*
>>>    * Common helper for find_bit() function family
>>> @@ -98,7 +99,7 @@ out:                                                                          \
>>>    */
>>>   unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>>>   {
>>> -       return FIND_FIRST_BIT(addr[idx], /* nop */, size);
>>> +       return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
>>>   }
>>>   EXPORT_SYMBOL(_find_first_bit);
>>>   #endif
>>
>> ...
>>
>> That doesn't look correct. READ_ONCE() implies that there's another
>> thread modifying the bitmap concurrently. This is not the true for
>> vast majority of bitmap API users, and I expect that forcing
>> READ_ONCE() would affect performance for them.
>>
>> Bitmap functions, with a few rare exceptions like set_bit(), are not
>> thread-safe and require users to perform locking/synchronization where
>> needed.
> 
> Well, for xarray the write side is synchronized with a spinlock but the read
> side is not (only RCU protected).
> 
>> If you really need READ_ONCE, I think it's better to implement a new
>> flavor of the function(s) separately, like:
>>          find_first_bit_read_once()
> 
> So yes, xarray really needs READ_ONCE(). And I don't think READ_ONCE()
> imposes any real perfomance overhead in this particular case because for
> any sane compiler the generated assembly with & without READ_ONCE() will be
> exactly the same. For example I've checked disassembly of _find_next_bit()
> using READ_ONCE(). The main loop is:
> 
>     0xffffffff815a2b6d <+77>:	inc    %r8
>     0xffffffff815a2b70 <+80>:	add    $0x8,%rdx
>     0xffffffff815a2b74 <+84>:	mov    %r8,%rcx
>     0xffffffff815a2b77 <+87>:	shl    $0x6,%rcx
>     0xffffffff815a2b7b <+91>:	cmp    %rcx,%rax
>     0xffffffff815a2b7e <+94>:	jbe    0xffffffff815a2b9b <_find_next_bit+123>
>     0xffffffff815a2b80 <+96>:	mov    (%rdx),%rcx
>     0xffffffff815a2b83 <+99>:	test   %rcx,%rcx
>     0xffffffff815a2b86 <+102>:	je     0xffffffff815a2b6d <_find_next_bit+77>
>     0xffffffff815a2b88 <+104>:	shl    $0x6,%r8
>     0xffffffff815a2b8c <+108>:	tzcnt  %rcx,%rcx
> 
> So you can see the value we work with is copied from the address (rdx) into
> a register (rcx) and the test and __ffs() happens on a register value and
> thus READ_ONCE() has no practical effect. It just prevents the compiler
> from doing some stupid de-optimization.
> 
> 								Honza

If I may also add, centralised READ_ONCE() version had fixed a couple of hundred of
the instances of KCSAN data-races in dmesg.

_find_*_bit() functions and/or macros cause quite a number of KCSAN BUG warnings:

  95 _find_first_and_bit (lib/find_bit.c:114 (discriminator 10))
  31 _find_first_zero_bit (lib/find_bit.c:125 (discriminator 10))
173 _find_next_and_bit (lib/find_bit.c:171 (discriminator 2))
655 _find_next_bit (lib/find_bit.c:133 (discriminator 2))
   5 _find_next_zero_bit

Finding each one find_bit_*() function and replacing it with find_bit_*_read_once()
could be time-consuming and challenging.

However, I will do both versions so you could compare, if you'd like.

Note, in the PoC version I have only implemented find_next_bit_read_once() ATM to see if
this works.

Regards,
Mirsad


--------------SdM57NH5CFmGTcDmkBlkGKQN
Content-Type: text/x-patch; charset=UTF-8; name="find_bit_read_once.diff"
Content-Disposition: attachment; filename="find_bit_read_once.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmluZC5oIGIvaW5jbHVkZS9saW51eC9maW5k
LmgKaW5kZXggNWU0ZjM5ZWYyZTcyLi4yYjdmOWYyNGNmZmIgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvZmluZC5oCisrKyBiL2luY2x1ZGUvbGludXgvZmluZC5oCkBAIC00MCw2ICs0
MCwzOCBAQCB1bnNpZ25lZCBsb25nIF9maW5kX25leHRfYml0X2xlKGNvbnN0IHVuc2lnbmVk
IGxvbmcgKmFkZHIsIHVuc2lnbmVkCiAJCQkJbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIG9m
ZnNldCk7CiAjZW5kaWYKIAordW5zaWduZWQgbG9uZyBfZmluZF9uZXh0X2JpdF9yZWFkX29u
Y2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIHVuc2lnbmVkIGxvbmcgbmJpdHMsCisJ
CQkJdW5zaWduZWQgbG9uZyBzdGFydCk7Cit1bnNpZ25lZCBsb25nIF9maW5kX25leHRfYW5k
X2JpdF9yZWFkX29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVuc2ln
bmVkIGxvbmcgKmFkZHIyLAorCQkJCQl1bnNpZ25lZCBsb25nIG5iaXRzLCB1bnNpZ25lZCBs
b25nIHN0YXJ0KTsKK3Vuc2lnbmVkIGxvbmcgX2ZpbmRfbmV4dF9hbmRub3RfYml0X3JlYWRf
b25jZShjb25zdCB1bnNpZ25lZCBsb25nICphZGRyMSwgY29uc3QgdW5zaWduZWQgbG9uZyAq
YWRkcjIsCisJCQkJCXVuc2lnbmVkIGxvbmcgbmJpdHMsIHVuc2lnbmVkIGxvbmcgc3RhcnQp
OwordW5zaWduZWQgbG9uZyBfZmluZF9uZXh0X29yX2JpdF9yZWFkX29uY2UoY29uc3QgdW5z
aWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIyLAorCQkJCQl1
bnNpZ25lZCBsb25nIG5iaXRzLCB1bnNpZ25lZCBsb25nIHN0YXJ0KTsKK3Vuc2lnbmVkIGxv
bmcgX2ZpbmRfbmV4dF96ZXJvX2JpdF9yZWFkX29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAq
YWRkciwgdW5zaWduZWQgbG9uZyBuYml0cywKKwkJCQkJIHVuc2lnbmVkIGxvbmcgc3RhcnQp
OworZXh0ZXJuIHVuc2lnbmVkIGxvbmcgX2ZpbmRfZmlyc3RfYml0X3JlYWRfb25jZShjb25z
dCB1bnNpZ25lZCBsb25nICphZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpOwordW5zaWduZWQg
bG9uZyBfX2ZpbmRfbnRoX2JpdF9yZWFkX29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRk
ciwgdW5zaWduZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIG4pOwordW5zaWduZWQgbG9u
ZyBfX2ZpbmRfbnRoX2FuZF9iaXRfcmVhZF9vbmNlKGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFk
ZHIxLCBjb25zdCB1bnNpZ25lZCBsb25nICphZGRyMiwKKwkJCQl1bnNpZ25lZCBsb25nIHNp
emUsIHVuc2lnbmVkIGxvbmcgbik7Cit1bnNpZ25lZCBsb25nIF9fZmluZF9udGhfYW5kbm90
X2JpdF9yZWFkX29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVuc2ln
bmVkIGxvbmcgKmFkZHIyLAorCQkJCQl1bnNpZ25lZCBsb25nIHNpemUsIHVuc2lnbmVkIGxv
bmcgbik7Cit1bnNpZ25lZCBsb25nIF9fZmluZF9udGhfYW5kX2FuZG5vdF9iaXRfcmVhZF9v
bmNlKGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIxLCBjb25zdCB1bnNpZ25lZCBsb25nICph
ZGRyMiwKKwkJCQkJY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjMsIHVuc2lnbmVkIGxvbmcg
c2l6ZSwKKwkJCQkJdW5zaWduZWQgbG9uZyBuKTsKK2V4dGVybiB1bnNpZ25lZCBsb25nIF9m
aW5kX2ZpcnN0X2FuZF9iaXRfcmVhZF9vbmNlKGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIx
LAorCQkJCQkgY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjIsIHVuc2lnbmVkIGxvbmcgc2l6
ZSk7CitleHRlcm4gdW5zaWduZWQgbG9uZyBfZmluZF9maXJzdF96ZXJvX2JpdF9yZWFkX29u
Y2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkciwgdW5zaWduZWQgbG9uZyBzaXplKTsKK2V4
dGVybiB1bnNpZ25lZCBsb25nIF9maW5kX2xhc3RfYml0X3JlYWRfb25jZShjb25zdCB1bnNp
Z25lZCBsb25nICphZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpOworCisjaWZkZWYgX19CSUdf
RU5ESUFOCit1bnNpZ25lZCBsb25nIF9maW5kX2ZpcnN0X3plcm9fYml0X2xlX3JlYWRfb25j
ZShjb25zdCB1bnNpZ25lZCBsb25nICphZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpOwordW5z
aWduZWQgbG9uZyBfZmluZF9uZXh0X3plcm9fYml0X2xlX3JlYWRfb25jZShjb25zdCAgdW5z
aWduZWQgbG9uZyAqYWRkciwgdW5zaWduZWQKKwkJCQkJbG9uZyBzaXplLCB1bnNpZ25lZCBs
b25nIG9mZnNldCk7Cit1bnNpZ25lZCBsb25nIF9maW5kX25leHRfYml0X2xlX3JlYWRfb25j
ZShjb25zdCB1bnNpZ25lZCBsb25nICphZGRyLCB1bnNpZ25lZAorCQkJCWxvbmcgc2l6ZSwg
dW5zaWduZWQgbG9uZyBvZmZzZXQpOworI2VuZGlmCisKICNpZm5kZWYgZmluZF9uZXh0X2Jp
dAogLyoqCiAgKiBmaW5kX25leHRfYml0IC0gZmluZCB0aGUgbmV4dCBzZXQgYml0IGluIGEg
bWVtb3J5IHJlZ2lvbgpAQCAtNjgsNiArMTAwLDMyIEBAIHVuc2lnbmVkIGxvbmcgZmluZF9u
ZXh0X2JpdChjb25zdCB1bnNpZ25lZCBsb25nICphZGRyLCB1bnNpZ25lZCBsb25nIHNpemUs
CiB9CiAjZW5kaWYKIAorI2lmbmRlZiBmaW5kX25leHRfYml0X3JlYWRfb25jZQorLyoqCisg
KiBmaW5kX25leHRfYml0X3JlYWRfb25jZSAtIGZpbmQgdGhlIG5leHQgc2V0IGJpdCBpbiBh
IG1lbW9yeSByZWdpb24KKyAqCQkJCXdpdGggZGF0YS1yYWNlIHByb3RlY3Rpb24KKyAqIEBh
ZGRyOiBUaGUgYWRkcmVzcyB0byBiYXNlIHRoZSBzZWFyY2ggb24KKyAqIEBzaXplOiBUaGUg
Yml0bWFwIHNpemUgaW4gYml0cworICogQG9mZnNldDogVGhlIGJpdG51bWJlciB0byBzdGFy
dCBzZWFyY2hpbmcgYXQKKyAqCisgKiBSZXR1cm5zIHRoZSBiaXQgbnVtYmVyIGZvciB0aGUg
bmV4dCBzZXQgYml0CisgKiBJZiBubyBiaXRzIGFyZSBzZXQsIHJldHVybnMgQHNpemUuCisg
Ki8KK3N0YXRpYyBpbmxpbmUKK3Vuc2lnbmVkIGxvbmcgZmluZF9uZXh0X2JpdF9yZWFkX29u
Y2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkciwgdW5zaWduZWQgbG9uZyBzaXplLAorCQkJ
CSAgICAgIHVuc2lnbmVkIGxvbmcgb2Zmc2V0KQoreworCWlmIChzbWFsbF9jb25zdF9uYml0
cyhzaXplKSkgeworCQl1bnNpZ25lZCBsb25nIHZhbDsKKworCQl2YWwgPSAqYWRkciAmIEdF
Tk1BU0soc2l6ZSAtIDEsIG9mZnNldCk7CisJCXJldHVybiB2YWwgPyBfX2Zmcyh2YWwpIDog
c2l6ZTsKKwl9CisKKwlyZXR1cm4gX2ZpbmRfbmV4dF9iaXRfcmVhZF9vbmNlKGFkZHIsIHNp
emUsIG9mZnNldCk7Cit9CisjZW5kaWYKKwogI2lmbmRlZiBmaW5kX25leHRfYW5kX2JpdAog
LyoqCiAgKiBmaW5kX25leHRfYW5kX2JpdCAtIGZpbmQgdGhlIG5leHQgc2V0IGJpdCBpbiBi
b3RoIG1lbW9yeSByZWdpb25zCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3hhcnJheS5o
IGIvaW5jbHVkZS9saW51eC94YXJyYXkuaAppbmRleCAxNzE1ZmQzMjJkNjIuLjZjMDRmMjEx
N2MwNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC94YXJyYXkuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3hhcnJheS5oCkBAIC0xNzE4LDE2ICsxNzE4LDggQEAgc3RhdGljIGlubGluZSB1
bnNpZ25lZCBpbnQgeGFzX2ZpbmRfY2h1bmsoc3RydWN0IHhhX3N0YXRlICp4YXMsIGJvb2wg
YWR2YW5jZSwKIAogCWlmIChhZHZhbmNlKQogCQlvZmZzZXQrKzsKLQlpZiAoWEFfQ0hVTktf
U0laRSA9PSBCSVRTX1BFUl9MT05HKSB7Ci0JCWlmIChvZmZzZXQgPCBYQV9DSFVOS19TSVpF
KSB7Ci0JCQl1bnNpZ25lZCBsb25nIGRhdGEgPSBSRUFEX09OQ0UoKmFkZHIpICYgKH4wVUwg
PDwgb2Zmc2V0KTsKLQkJCWlmIChkYXRhKQotCQkJCXJldHVybiBfX2ZmcyhkYXRhKTsKLQkJ
fQotCQlyZXR1cm4gWEFfQ0hVTktfU0laRTsKLQl9CiAKLQlyZXR1cm4gZmluZF9uZXh0X2Jp
dChhZGRyLCBYQV9DSFVOS19TSVpFLCBvZmZzZXQpOworCXJldHVybiBmaW5kX25leHRfYml0
X3JlYWRfb25jZShhZGRyLCBYQV9DSFVOS19TSVpFLCBvZmZzZXQpOwogfQogCiAvKioKZGlm
ZiAtLWdpdCBhL2xpYi9maW5kX2JpdC5jIGIvbGliL2ZpbmRfYml0LmMKaW5kZXggMzJmOTll
OWE2NzBlLi45MmE4ZTAwMTZhMjAgMTAwNjQ0Ci0tLSBhL2xpYi9maW5kX2JpdC5jCisrKyBi
L2xpYi9maW5kX2JpdC5jCkBAIC0xOCw2ICsxOCw3IEBACiAjaW5jbHVkZSA8bGludXgvbWF0
aC5oPgogI2luY2x1ZGUgPGxpbnV4L21pbm1heC5oPgogI2luY2x1ZGUgPGxpbnV4L3N3YWIu
aD4KKyNpbmNsdWRlIDxhc20vcndvbmNlLmg+CiAKIC8qCiAgKiBDb21tb24gaGVscGVyIGZv
ciBmaW5kX2JpdCgpIGZ1bmN0aW9uIGZhbWlseQpAQCAtMjY4LDMgKzI2OSwxNzIgQEAgRVhQ
T1JUX1NZTUJPTChfZmluZF9uZXh0X2JpdF9sZSk7CiAjZW5kaWYKIAogI2VuZGlmIC8qIF9f
QklHX0VORElBTiAqLworCisvKgorICogVGhlIHJlYWRfb25jZSBmbGF2b3VyIG9mIGZ1bmN0
aW9ucyB0byBhdm9pZCBkYXRhLXJhY2VzLgorICoKKyAqLworCisjaWZuZGVmIGZpbmRfZmly
c3RfYml0X3JlYWRfb25jZQorLyoKKyAqIEZpbmQgdGhlIGZpcnN0IHNldCBiaXQgaW4gYSBt
ZW1vcnkgcmVnaW9uLgorICovCit1bnNpZ25lZCBsb25nIF9maW5kX2ZpcnN0X2JpdF9yZWFk
X29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkciwgdW5zaWduZWQgbG9uZyBzaXplKQor
eworCXJldHVybiBGSU5EX0ZJUlNUX0JJVChSRUFEX09OQ0UoYWRkcltpZHhdKSwgLyogbm9w
ICovLCBzaXplKTsKK30KK0VYUE9SVF9TWU1CT0woX2ZpbmRfZmlyc3RfYml0X3JlYWRfb25j
ZSk7CisjZW5kaWYKKworI2lmbmRlZiBmaW5kX2ZpcnN0X2FuZF9iaXRfcmVhZF9vbmNlCisv
KgorICogRmluZCB0aGUgZmlyc3Qgc2V0IGJpdCBpbiB0d28gbWVtb3J5IHJlZ2lvbnMuCisg
Ki8KK3Vuc2lnbmVkIGxvbmcgX2ZpbmRfZmlyc3RfYW5kX2JpdF9yZWFkX29uY2UoY29uc3Qg
dW5zaWduZWQgbG9uZyAqYWRkcjEsCisJCQkJCSAgICBjb25zdCB1bnNpZ25lZCBsb25nICph
ZGRyMiwKKwkJCQkJICAgIHVuc2lnbmVkIGxvbmcgc2l6ZSkKK3sKKwlyZXR1cm4gRklORF9G
SVJTVF9CSVQoUkVBRF9PTkNFKGFkZHIxW2lkeF0pICYgUkVBRF9PTkNFKGFkZHIyW2lkeF0p
LCAvKiBub3AgKi8sIHNpemUpOworfQorRVhQT1JUX1NZTUJPTChfZmluZF9maXJzdF9hbmRf
Yml0X3JlYWRfb25jZSk7CisjZW5kaWYKKworI2lmbmRlZiBmaW5kX2ZpcnN0X3plcm9fYml0
X3JlYWRfb25jZQorLyoKKyAqIEZpbmQgdGhlIGZpcnN0IGNsZWFyZWQgYml0IGluIGEgbWVt
b3J5IHJlZ2lvbi4KKyAqLwordW5zaWduZWQgbG9uZyBfZmluZF9maXJzdF96ZXJvX2JpdF9y
ZWFkX29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkciwgdW5zaWduZWQgbG9uZyBzaXpl
KQoreworCXJldHVybiBGSU5EX0ZJUlNUX0JJVCh+UkVBRF9PTkNFKGFkZHJbaWR4XSksIC8q
IG5vcCAqLywgc2l6ZSk7Cit9CitFWFBPUlRfU1lNQk9MKF9maW5kX2ZpcnN0X3plcm9fYml0
X3JlYWRfb25jZSk7CisjZW5kaWYKKworI2lmbmRlZiBmaW5kX25leHRfYml0X3JlYWRfb25j
ZQordW5zaWduZWQgbG9uZyBfZmluZF9uZXh0X2JpdF9yZWFkX29uY2UoY29uc3QgdW5zaWdu
ZWQgbG9uZyAqYWRkciwgdW5zaWduZWQgbG9uZyBuYml0cywgdW5zaWduZWQgbG9uZyBzdGFy
dCkKK3sKKwlyZXR1cm4gRklORF9ORVhUX0JJVChSRUFEX09OQ0UoYWRkcltpZHhdKSwgLyog
bm9wICovLCBuYml0cywgc3RhcnQpOworfQorRVhQT1JUX1NZTUJPTChfZmluZF9uZXh0X2Jp
dF9yZWFkX29uY2UpOworI2VuZGlmCisKK3Vuc2lnbmVkIGxvbmcgX19maW5kX250aF9iaXRf
cmVhZF9vbmNlKGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6
ZSwgdW5zaWduZWQgbG9uZyBuKQoreworCXJldHVybiBGSU5EX05USF9CSVQoUkVBRF9PTkNF
KGFkZHJbaWR4XSksIHNpemUsIG4pOworfQorRVhQT1JUX1NZTUJPTChfX2ZpbmRfbnRoX2Jp
dF9yZWFkX29uY2UpOworCit1bnNpZ25lZCBsb25nIF9fZmluZF9udGhfYW5kX2JpdF9yZWFk
X29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVuc2lnbmVkIGxvbmcg
KmFkZHIyLAorCQkJCQkgICB1bnNpZ25lZCBsb25nIHNpemUsIHVuc2lnbmVkIGxvbmcgbikK
K3sKKwlyZXR1cm4gRklORF9OVEhfQklUKFJFQURfT05DRShhZGRyMVtpZHhdKSAmIFJFQURf
T05DRShhZGRyMltpZHhdKSwgc2l6ZSwgbik7Cit9CitFWFBPUlRfU1lNQk9MKF9fZmluZF9u
dGhfYW5kX2JpdF9yZWFkX29uY2UpOworCit1bnNpZ25lZCBsb25nIF9fZmluZF9udGhfYW5k
bm90X2JpdF9yZWFkX29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVu
c2lnbmVkIGxvbmcgKmFkZHIyLAorCQkJCQkgICAgICB1bnNpZ25lZCBsb25nIHNpemUsIHVu
c2lnbmVkIGxvbmcgbikKK3sKKwlyZXR1cm4gRklORF9OVEhfQklUKFJFQURfT05DRShhZGRy
MVtpZHhdKSAmIH5SRUFEX09OQ0UoYWRkcjJbaWR4XSksIHNpemUsIG4pOworfQorRVhQT1JU
X1NZTUJPTChfX2ZpbmRfbnRoX2FuZG5vdF9iaXRfcmVhZF9vbmNlKTsKKwordW5zaWduZWQg
bG9uZyBfX2ZpbmRfbnRoX2FuZF9hbmRub3RfYml0X3JlYWRfb25jZShjb25zdCB1bnNpZ25l
ZCBsb25nICphZGRyMSwKKwkJCQkJCSAgY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjIsCisJ
CQkJCQkgIGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIzLAorCQkJCQkJICB1bnNpZ25lZCBs
b25nIHNpemUsIHVuc2lnbmVkIGxvbmcgbikKK3sKKwlyZXR1cm4gRklORF9OVEhfQklUKFJF
QURfT05DRShhZGRyMVtpZHhdKSAmIFJFQURfT05DRShhZGRyMltpZHhdKSAmIH5SRUFEX09O
Q0UoYWRkcjNbaWR4XSksIHNpemUsIG4pOworfQorRVhQT1JUX1NZTUJPTChfX2ZpbmRfbnRo
X2FuZF9hbmRub3RfYml0X3JlYWRfb25jZSk7CisKKyNpZm5kZWYgZmluZF9uZXh0X2FuZF9i
aXRfcmVhZF9vbmNlCit1bnNpZ25lZCBsb25nIF9maW5kX25leHRfYW5kX2JpdF9yZWFkX29u
Y2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFk
ZHIyLAorCQkJCQkgICB1bnNpZ25lZCBsb25nIG5iaXRzLCB1bnNpZ25lZCBsb25nIHN0YXJ0
KQoreworCXJldHVybiBGSU5EX05FWFRfQklUKFJFQURfT05DRShhZGRyMVtpZHhdKSAmIFJF
QURfT05DRShhZGRyMltpZHhdKSwgLyogbm9wICovLCBuYml0cywgc3RhcnQpOworfQorRVhQ
T1JUX1NZTUJPTChfZmluZF9uZXh0X2FuZF9iaXRfcmVhZF9vbmNlKTsKKyNlbmRpZgorCisj
aWZuZGVmIGZpbmRfbmV4dF9hbmRub3RfYml0X3JlYWRfb25jZQordW5zaWduZWQgbG9uZyBf
ZmluZF9uZXh0X2FuZG5vdF9iaXRfcmVhZF9vbmNlKGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFk
ZHIxLCBjb25zdCB1bnNpZ25lZCBsb25nICphZGRyMiwKKwkJCQkJICAgICAgdW5zaWduZWQg
bG9uZyBuYml0cywgdW5zaWduZWQgbG9uZyBzdGFydCkKK3sKKwlyZXR1cm4gRklORF9ORVhU
X0JJVChSRUFEX09OQ0UoYWRkcjFbaWR4XSkgJiB+UkVBRF9PTkNFKGFkZHIyW2lkeF0pLCAv
KiBub3AgKi8sIG5iaXRzLCBzdGFydCk7Cit9CitFWFBPUlRfU1lNQk9MKF9maW5kX25leHRf
YW5kbm90X2JpdF9yZWFkX29uY2UpOworI2VuZGlmCisKKyNpZm5kZWYgZmluZF9uZXh0X29y
X2JpdF9yZWFkX29uY2UKK3Vuc2lnbmVkIGxvbmcgX2ZpbmRfbmV4dF9vcl9iaXRfcmVhZF9v
bmNlKGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIxLCBjb25zdCB1bnNpZ25lZCBsb25nICph
ZGRyMiwKKwkJCQkJICB1bnNpZ25lZCBsb25nIG5iaXRzLCB1bnNpZ25lZCBsb25nIHN0YXJ0
KQoreworCXJldHVybiBGSU5EX05FWFRfQklUKFJFQURfT05DRShhZGRyMVtpZHhdKSB8IFJF
QURfT05DRShhZGRyMltpZHhdKSwgLyogbm9wICovLCBuYml0cywgc3RhcnQpOworfQorRVhQ
T1JUX1NZTUJPTChfZmluZF9uZXh0X29yX2JpdF9yZWFkX29uY2UpOworI2VuZGlmCisKKyNp
Zm5kZWYgZmluZF9uZXh0X3plcm9fYml0X3JlYWRfb25jZQordW5zaWduZWQgbG9uZyBfZmlu
ZF9uZXh0X3plcm9fYml0X3JlYWRfb25jZShjb25zdCB1bnNpZ25lZCBsb25nICphZGRyLCB1
bnNpZ25lZCBsb25nIG5iaXRzLAorCQkJCQkgICAgdW5zaWduZWQgbG9uZyBzdGFydCkKK3sK
KwlyZXR1cm4gRklORF9ORVhUX0JJVCh+UkVBRF9PTkNFKGFkZHJbaWR4XSksIC8qIG5vcCAq
LywgbmJpdHMsIHN0YXJ0KTsKK30KK0VYUE9SVF9TWU1CT0woX2ZpbmRfbmV4dF96ZXJvX2Jp
dF9yZWFkX29uY2UpOworI2VuZGlmCisKKyNpZm5kZWYgZmluZF9sYXN0X2JpdF9yZWFkX29u
Y2UKK3Vuc2lnbmVkIGxvbmcgX2ZpbmRfbGFzdF9iaXRfcmVhZF9vbmNlKGNvbnN0IHVuc2ln
bmVkIGxvbmcgKmFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkKK3sKKwlpZiAoc2l6ZSkgewor
CQl1bnNpZ25lZCBsb25nIHZhbCA9IEJJVE1BUF9MQVNUX1dPUkRfTUFTSyhzaXplKTsKKwkJ
dW5zaWduZWQgbG9uZyBpZHggPSAoc2l6ZS0xKSAvIEJJVFNfUEVSX0xPTkc7CisKKwkJZG8g
eworCQkJdmFsICY9IFJFQURfT05DRShhZGRyW2lkeF0pOworCQkJaWYgKHZhbCkKKwkJCQly
ZXR1cm4gaWR4ICogQklUU19QRVJfTE9ORyArIF9fZmxzKHZhbCk7CisKKwkJCXZhbCA9IH4w
dWw7CisJCX0gd2hpbGUgKGlkeC0tKTsKKwl9CisJcmV0dXJuIHNpemU7Cit9CitFWFBPUlRf
U1lNQk9MKF9maW5kX2xhc3RfYml0X3JlYWRfb25jZSk7CisjZW5kaWYKKworI2lmZGVmIF9f
QklHX0VORElBTgorCisjaWZuZGVmIGZpbmRfZmlyc3RfemVyb19iaXRfbGVfcmVhZF9vbmNl
CisvKgorICogRmluZCB0aGUgZmlyc3QgY2xlYXJlZCBiaXQgaW4gYW4gTEUgbWVtb3J5IHJl
Z2lvbi4KKyAqLwordW5zaWduZWQgbG9uZyBfZmluZF9maXJzdF96ZXJvX2JpdF9sZV9yZWFk
X29uY2UoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkciwKKwkJCQkJCXVuc2lnbmVkIGxvbmcg
c2l6ZSkKK3sKKwlyZXR1cm4gRklORF9GSVJTVF9CSVQoflJFQURfT05DRShhZGRyW2lkeF0p
LCBzd2FiLCBzaXplKTsKK30KK0VYUE9SVF9TWU1CT0woX2ZpbmRfZmlyc3RfemVyb19iaXRf
bGVfcmVhZF9vbmNlKTsKKworI2VuZGlmCisKKyNpZm5kZWYgZmluZF9uZXh0X3plcm9fYml0
X2xlX3JlYWRfb25jZQordW5zaWduZWQgbG9uZyBfZmluZF9uZXh0X3plcm9fYml0X2xlX3Jl
YWRfb25jZShjb25zdCB1bnNpZ25lZCBsb25nICphZGRyLAorCQkJCQkgICAgICAgdW5zaWdu
ZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIG9mZnNldCkKK3sKKwlyZXR1cm4gRklORF9O
RVhUX0JJVCh+UkVBRF9PTkNFKGFkZHJbaWR4XSksIHN3YWIsIHNpemUsIG9mZnNldCk7Cit9
CitFWFBPUlRfU1lNQk9MKF9maW5kX25leHRfemVyb19iaXRfbGVfcmVhZF9vbmNlKTsKKyNl
bmRpZgorCisjaWZuZGVmIGZpbmRfbmV4dF9iaXRfbGVfcmVhZF9vbmNlCit1bnNpZ25lZCBs
b25nIF9maW5kX25leHRfYml0X2xlX3JlYWRfb25jZShjb25zdCB1bnNpZ25lZCBsb25nICph
ZGRyLAorCQkJCQkgIHVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWduZWQgbG9uZyBvZmZzZXQp
Cit7CisJcmV0dXJuIEZJTkRfTkVYVF9CSVQoUkVBRF9PTkNFKGFkZHJbaWR4XSksIHN3YWIs
IHNpemUsIG9mZnNldCk7Cit9CitFWFBPUlRfU1lNQk9MKF9maW5kX25leHRfYml0X2xlX3Jl
YWRfb25jZSk7CisKKyNlbmRpZgorCisjZW5kaWYgLyogX19CSUdfRU5ESUFOICovCg==

--------------SdM57NH5CFmGTcDmkBlkGKQN--
