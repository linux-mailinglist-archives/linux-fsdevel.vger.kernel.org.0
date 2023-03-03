Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392006A9DD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCCRjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjCCRjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:39:15 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB84619F35;
        Fri,  3 Mar 2023 09:39:13 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id n27-20020a4ad63b000000b005252709efdbso548245oon.4;
        Fri, 03 Mar 2023 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677865153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml/fW6uXGZ8Kx6hmQHBX1K/9bVHlrFzX/LDTLTFj11g=;
        b=O1mais1ppI/17jnqGCgJc4Hp6kEaPm0/KdWJUtzWWgKpyrNHoPKVOP3mWL2lH28cOR
         bgskgNElQ+bX2ZUYledWouqqkloG97AKokQ21ACxm+fYP8W6P9aCrcNlnvitl9U523kr
         C1GMYtgfKfmnukPWeLxlR307mJk6yV4xmF/21cxr9NbOC2rCFv9WcGFdhxSigc8LzsDW
         B5q+LVn66YOfVpi2yCrKGCy/ag7CxVcGbq2vmOA1UU83nZZXymhruQ3daRcdiq2MHnIN
         o0p/V3B6ivt8Upkuo+xN0U4kEXsQjSEcF39m/A0Igm1wmesShJW5xh/ywRyaagvnqsVH
         ol0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677865153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml/fW6uXGZ8Kx6hmQHBX1K/9bVHlrFzX/LDTLTFj11g=;
        b=gRIKG/WIZE2nsiQvQG1UOcnr9cyOqXNe7dXQ+3y71KOToXvhNgGaDV1LAFmwB1/dEv
         7nd68xKKkyqGyVammskttOAbx12jNA7w8niKS1eOJoWpsxWTBkYddqmc99k3Ty2aBgTO
         ZPmsY8stAeYdiQwXLK9HEQRwQnFe8/F6HCjr/w4DJH/JTdYBUXBDWNzZnD/GNWVP0Omo
         aooJuqimmsCwvXSemxJMOctPIhm/S1fQ3Tc+2suB/j/DiLnuD8Yfyf6Pj18bPJP1/waY
         xPJffdDA4KvUw2Yj5EVYVdetgUK+sw5JU5tTuqWGcMpkqnKqqphvo7U8dp53kK5x5l0e
         wxxg==
X-Gm-Message-State: AO0yUKUvx+BsbAKPWgh5cY0z2ALRkQeYLZ+I9ZZHZW7c+tgQtY1iK3Nq
        j87Ri7BWUbAEuRq4rvWdsB/hieMT8+QnRdDgfOfiluCpNOc=
X-Google-Smtp-Source: AK7set8sOGXUffR2UWjf1aVlRLZsiZzZbbn35nJdWBr42oUE2+83OF2vMAST0UrhRIdxj/MkA1Pbap1mHikHKrJKxi0=
X-Received: by 2002:a4a:b101:0:b0:525:5f43:215a with SMTP id
 a1-20020a4ab101000000b005255f43215amr2449978ooo.1.1677865152922; Fri, 03 Mar
 2023 09:39:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:31f:b0:4c2:d201:fe1f with HTTP; Fri, 3 Mar 2023
 09:39:12 -0800 (PST)
In-Reply-To: <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 3 Mar 2023 18:39:12 +0100
Message-ID: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Alexander Potapenko <glider@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/23, Alexander Potapenko <glider@google.com> wrote:
> On Thu, Mar 2, 2023 at 9:11=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>>
>> On Thu, Mar 02, 2023 at 11:54:03AM -0800, Kees Cook wrote:
>> > On Thu, Mar 02, 2023 at 07:19:49PM +0000, Al Viro wrote:
>> > > On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
>> > > > On Thu, Mar 2, 2023 at 11:03=E2=80=AFAM Linus Torvalds
>> > > > <torvalds@linux-foundation.org> wrote:
>> > > > >
>> > > > > It might be best if we actually exposed it as a SLAB_SKIP_ZERO
>> > > > > thing,
>> > > > > just to make it possible to say - exactly in situations like thi=
s
>> > > > > -
>> > > > > that this particular slab cache has no advantage from
>> > > > > pre-zeroing.
>> > > >
>> > > > Actually, maybe it's just as well to keep it per-allocation, and
>> > > > just
>> > > > special-case getname_flags() itself.
>> > > >
>> > > > We could replace the __getname() there with just a
>> > > >
>> > > >         kmem_cache_alloc(names_cachep, GFP_KERNEL |
>> > > > __GFP_SKIP_ZERO);
>> > > >
>> > > > we're going to overwrite the beginning of the buffer with the path
>> > > > we
>> > > > copy from user space, and then we'd have to make people comfortabl=
e
>> > > > with the fact that even with zero initialization hardening on, the
>> > > > space after the filename wouldn't be initialized...
>> > >
>> > > ACK; same in getname_kernel() and sys_getcwd(), at the very least.
>> >
>> > FWIW, much earlier analysis suggested opting out these kmem caches:
>> >
>> >       buffer_head
>> >       names_cache
>> >       mm_struct
>> >       anon_vma
>> >       skbuff_head_cache
>> >       skbuff_fclone_cache
>>
>> I would probably add dentry_cache to it; the only subtle part is
>> ->d_iname and I'm convinced that explicit "make sure there's a NUL
>> at the very end" is enough.
>
> FWIW, a couple of years ago I was looking into implementing the
> following scheme for opt-out that I also discussed with Kees:
>
> 1. Add a ___GFP_SKIP_ZERO flag that is not intended to be used
> explicitly (e.g. disallow passing it to kmalloc(), add a checkpatch.pl
> warning). Explicitly passing an opt-out flag to allocation functions
> was considered harmful previously:
> https://lore.kernel.org/kernel-hardening/20190423083148.GF25106@dhcp22.su=
se.cz/
>
> 2. Define new allocation API that will allow opt-out:
>
>   struct page *alloc_pages_uninit(gfp_t gfp, unsigned int order, const
> char *key);
>   void *kmalloc_uninit(size_t size, gfp_t flags, const char *key);
>   void *kmem_cache_alloc_uninit(struct kmem_cache *, gfp_t flags,
> const char *key);
>
> , where @key is an arbitrary string that identifies a single
> allocation or a group of allocations.
>
> 3. Provide a boot-time flag that holds a comma-separated list of
> opt-out keys that actually take effect:
>
>   init_on_alloc.skip=3D"xyz-camera-driver,some_big_buffer".
>
> The rationale behind this two-step mechanism is that despite certain
> allocations may be appealing opt-out targets for performance reasons,
> some vendors may choose to be on the safe side and explicitly list the
> allocations that should not be zeroed.
>
> Several possible enhancements include:
> 1. A SLAB_NOINIT memcache flag that prohibits cache merging and
> disables initialization. Because the number of caches is relatively
> small, it might be fine to explicitly pass SLAB_NOINIT at cache
> creation sites.
> Again, if needed, we could only use this flag as a hint that needs to
> be acknowledged by a boot-time option.
> 2. No opt-out for kmalloc() - instead advise users to promote the
> anonymous allocations they want to opt-out to memory caches with
> SLAB_NOINIT.
> 3. Provide an emergency brake that completely disables
> ___GFP_SKIP_ZERO if a major security breach is discovered.
>
> Extending this idea of per-callsite opt-out we could generate unique
> keys for every allocation in the kernel (or e.g. group them together
> by the caller name) and decide at runtime if we want to opt them out.
> But I am not sure anyone would want this level of control in their distro=
.
>

I intended to write a longer e-mail concerning the entire
init-on-alloc situation along with some patches in not-so-distant
future, but the bare minimum I wrote previously already got numerous
people involved (unsurprisingly now that I look at it). I don't have
time to write the thing I wanted at the moment, but now that there is
traffic I think I should at least mention one other important bit.

I'm not going to argue for any particular level of granularity -- I'm
a happy camper as long as I can end up with names_cachep allocations
excluded without disabling the entire thing.

So the key is: memset is underperforming at least on x86-64 for
certain sizes and the init-on-alloc thingy makes it used significantly
more, exacerbating the problem. Fixing it is worthwhile on its own and
will reduce the impact of the option, but the need for some form of
opt-out will remain.

I don't have any numbers handy nor time to produce them, so the mail
will be a little handwave-y. I only write it in case someone decides
to bench now what would warrant exclusion with the mechanism under
discussion. Should any of the claims below be challenged, I can
respond some time late next week with hard data(tm).

Onto the issue:
Most cpus in use today have the ERMS bit, in which case the routine is:

SYM_FUNC_START_LOCAL(memset_erms)
        movq %rdi,%r9
        movb %sil,%al
        movq %rdx,%rcx
        rep stosb
        movq %r9,%rax
        RET
SYM_FUNC_END(memset_erms)

The problem here is that instructions with the rep prefix have a very
high startup latency. Afair this remains true even on cpus with FSRM
in case of rep *stos* (what is helped by FSRM is rep *mov*, whereas
stos remains unaffected).

Interestingly looks like the problem was recognized in general --
memcpy and copy_{to,from}_user have hand rolled smaller copies. Apart
from that __clear_user relatively recently got a treatment of that
sort but it somehow never got implemented in memset itself.

If memory serves right, the least slow way to do it is to *NOT* use
rep stos below 128 bytes of size (and this number is even higher the
better the cpu). Instead, a 32-byte loop (as in 4 times movsq) would
do it as long as there is space, along with overlapping stores to take
care of whatever < 32 bytes.

__clear_user got rep stos if FSRM is present and 64 byte non-rep
treatment, with an 8 byte loop and 1 byte loop to cover the tail. As
noted above, this leaves perf on the table. Even then, it would be an
improvement for memset if transplanted over. Maybe this was mentioned
in the discussion concerning the func, I had not read the thread -- I
only see that memset remains unpatched.

memset, even with init-on-alloc disabled, is used *a lot* with very
small sizes. For that bit I do have data collected over 'make' in the
kernel directory.

bpftrace -e 'kprobe:memset { @ =3D lhist(arg2, 0, 128, 8); }'

[0, 8)           9126030 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       =
   |
[8, 16)           515728 |@@                                               =
   |
[16, 24)          621902 |@@                                               =
   |
[24, 32)          110822 |                                                 =
   |
[32, 40)        11003451 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@  |
[40, 48)             488 |                                                 =
   |
[48, 56)             164 |                                                 =
   |
[56, 64)         1493851 |@@@@@@                                           =
   |
[64, 72)          214613 |                                                 =
   |
[72, 80)           10468 |                                                 =
   |
[80, 88)           10524 |                                                 =
   |
[88, 96)             121 |                                                 =
   |
[96, 104)          81591 |                                                 =
   |
[104, 112)       1659699 |@@@@@@@                                          =
   |
[112, 120)          3240 |                                                 =
   |
[120, 128)          9058 |                                                 =
   |
[128, ...)      11287204 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|

note: i failed to figure out how to attach to memset on stock kernel,
thus the kernel was booted with the crappery below:

diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 6143b1a6fa2c..141d899d5f1d 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -45,9 +45,6 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)

-SYM_FUNC_ALIAS(memset, __memset)
-EXPORT_SYMBOL(memset)
-
 /*
  * ISO C memset - set a memory block to a byte value. This function uses
  * enhanced rep stosb to override the fast string function.
diff --git a/fs/open.c b/fs/open.c
index 4401a73d4032..6e11e95ad9c3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1564,3 +1564,11 @@ int stream_open(struct inode *inode, struct file *fi=
lp)
 }

 EXPORT_SYMBOL(stream_open);
+
+void *(memset)(void *s, int c, size_t n)
+{
+       return __memset(s, c, n);
+}
+
+EXPORT_SYMBOL(memset);

--=20
Mateusz Guzik <mjguzik gmail.com>
