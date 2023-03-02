Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0936A89C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCBTsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBTsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:48:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11811CC30;
        Thu,  2 Mar 2023 11:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE916B815AA;
        Thu,  2 Mar 2023 19:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE5FC433D2;
        Thu,  2 Mar 2023 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677786489;
        bh=U0sFMYQ2MZWrog+LxnDSE1NcCkdmkv+nWCNr4IpUImM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBcQY/JNf1hq0pLQUbEpDp/Gw1s463oB5s1idBbhH7KCdAXcLLI0Qng+ovbp/hIIb
         OGlJygi5HhYhpVizgKzUOKMflQAOgDme19sZAX9X2WAWnO+WOAYkmHmb97k8w+ghYa
         RVNvAjA5JXiraWNlc+w15Lo7cbYbheU4fyFgiZp1SQXDfToqGLjOLKh1Qfa98dTFyn
         JCUTKf36Xoj5JIkrJu+XLkMCnvNbJIKK5esMWznlI7VpNs0MZwOc8buZSn5Xa257zp
         d2FxyEAVUVLZzqe5iRtdopzdWk9jEN0dN4Sqbeti4C1pWfPfBCA6Oj73bwhn/Z4ALO
         4U4eF+C140KAA==
Date:   Thu, 2 Mar 2023 19:48:07 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZAD9d5P8bYVQ5qSs@gmail.com>
References: <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <6400fb4b.a70a0220.39788.048e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6400fb4b.a70a0220.39788.048e@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:38:50AM -0800, Kees Cook wrote:
> On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
> > On Thu, Mar 2, 2023 at 11:03 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
> > > just to make it possible to say - exactly in situations like this -
> > > that this particular slab cache has no advantage from pre-zeroing.
> > 
> > Actually, maybe it's just as well to keep it per-allocation, and just
> > special-case getname_flags() itself.
> > 
> > We could replace the __getname() there with just a
> > 
> >         kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO);
> > 
> > we're going to overwrite the beginning of the buffer with the path we
> > copy from user space, and then we'd have to make people comfortable
> > with the fact that even with zero initialization hardening on, the
> > space after the filename wouldn't be initialized...
> 
> Yeah, I'd love to have a way to safely opt-out of always-zero. The
> discussion[1] when we originally did this devolved into a guessing
> game on performance since no one could actually point to workloads
> that were affected by it, beyond skbuff[2]. So in the interest of not
> over-engineering a solution to an unknown problem, the plan was once
> someone found a problem, we could find a sensible solution at that
> time. And so here we are! :)
> 
> I'd always wanted to avoid a "don't zero" flag and instead adjust APIs so
> the allocation could include a callback to do the memory content filling
> that would return a size-that-was-initialized result. That way we don't
> end up in the situations we've seen so many times with drivers, etc,
> where an uninit buffer is handed off and some path fails to actually
> fill it with anything. However, in practice, I think this kind of API
> change becomes really hard to do.
> 

Having not been following init_on_alloc very closely myself, I'm a bit surprised
that an opt-out flag never made it into the final version.

Was names_cachep considered in those earlier discussions?  I think that's a
pretty obvious use case for an opt-out.  Every syscall that operates on a path
allocates a 4K buffer from names_cachep.

- Eric
