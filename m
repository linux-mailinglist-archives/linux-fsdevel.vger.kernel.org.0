Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D86A896E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCBTUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBTUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:20:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B181EBDD;
        Thu,  2 Mar 2023 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=bkzoc/tUK4PrSpc0Zzz+weifcs/tyweKIYQNyK6abeM=; b=Di2PLfsCLVWUTD/DT2zMiuIUf8
        dZGRXyjXeB1f9lgY66JvT48GRj1ZPgWzBfzMuhAB557MFT/0zGVEFtJme8YsxjezQWqgjBjXJ3d/s
        drF62qiDAvRTj3GEQBvwTTvobBq51eKyMFmkq5EFAivqNcxwh2hhmwZB5soKWCvfP4QjK8CTU0RFV
        sl24sDnWiIwzfj5jUKqGPO/IKvgKVfKz0Vrmr5t2WrFMlRKTmCrQmk5FKaVwDwrHrbpB0Hw67yOCR
        1tmbUv0h7ThsxblsUvacdEwLl4j5a1ZbqGje8bThbz2I7285PdXjJeYHYyks/YCsQBqustAWnN+y3
        DKJNOW9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXoSz-00DNar-1U;
        Thu, 02 Mar 2023 19:19:49 +0000
Date:   Thu, 2 Mar 2023 19:19:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZAD21ZEiB2V9Ttto@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
> On Thu, Mar 2, 2023 at 11:03 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> > just to make it possible to say - exactly in situations like this -
> > that this particular slab cache has no advantage from pre-zeroing.
> 
> Actually, maybe it's just as well to keep it per-allocation, and just
> special-case getname_flags() itself.
> 
> We could replace the __getname() there with just a
> 
>         kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);
> 
> we're going to overwrite the beginning of the buffer with the path we
> copy from user space, and then we'd have to make people comfortable
> with the fact that even with zero initialization hardening on, the
> space after the filename wouldn't be initialized...

ACK; same in getname_kernel() and sys_getcwd(), at the very least.
