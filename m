Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7137BE84F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377428AbjJIRhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJIRhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:37:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E89494;
        Mon,  9 Oct 2023 10:37:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F2AC433CA;
        Mon,  9 Oct 2023 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696873023;
        bh=BW2UXyZrvXyT/FZW+LrBqggagNr5D5MBdlmAiZdBZHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8NkldTqlYjXAwPgzwSb89ZPTQnyDof4SI3tlaYG99WZSrp5QrGoEhumwJzN5ZtZK
         Z7kQmdB1MEZO39b4QGLSseg2+P1TNcvf4++UwpMBg/D3Tys23SK2POEaI0NNPPiVnI
         3UQmZwZApjsaLVdRjXh2JiRtifgw9pyaa7El88b8=
Date:   Mon, 9 Oct 2023 19:37:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rcvalle@google.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
Message-ID: <2023100909-disperser-washable-4cbe@gregkh>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
 <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
 <CANiq72khuwOrAGN=CrFUX85UmPdJiZ2yM7_9_su_Zp951BHMMA@mail.gmail.com>
 <CAGSQo00gJsE+mQObeK4NNGDYLpZDDAZsREr15JcjD8Fo0E4pkw@mail.gmail.com>
 <CANiq72kK6ppBE7j=z7uua1cJMKaLoR5U3NUAZXT5MrNEs9ZhfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kK6ppBE7j=z7uua1cJMKaLoR5U3NUAZXT5MrNEs9ZhfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:31:13PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 9, 2023 at 6:01 PM Matthew Maurer <mmaurer@google.com> wrote:
> >
> > If the IBT part would be helpful by itself immediately, I can split
> > that out - it's only the KCFI portion that won't currently work.
> 
> Thanks Matthew. I don't think we are in a rush, but if it is not too
> much work to split it, that would be great, instead of adding the
> restriction.
> 
> For retthunk, by the way, I forgot to mention to Greg above that (in
> the original discussion with PeterZ) that I did a quick test back then
> to hack the equivalent of `-mfunction-return=thunk-extern` into
> `rustc` to show that the compiler could use it via LLVM (by passing
> the attribute in the IR). At least at a basic level it seemed to work:
> I got a userspace program to count the times that it went through the
> return thunk. I didn't try to do anything on the kernel side, but at
> least for the compiler side, it seemed OK. So it may be way easier (on
> the compiler side) than the CFI work?

It should hopefully be much easier than CFI, it was a much simpler
change to gcc and clang when it landed.

thanks,

greg k-h
