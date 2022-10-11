Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A55FADF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJKIFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJKIFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:05:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5904D276;
        Tue, 11 Oct 2022 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u50EcsTI9Wk9/nFFcEKJjzHJXjNQpjwE8MEPj/c61bk=; b=jRN7B6Bjxy2MH05q0VSH4fvQvY
        +TydedfMaV9P6yrvHLi8GPvH4QZqoYXkd0Nu2oZ4lFt2wsdeLOhD6zhyxXHFDg0mjdlmn01cqTeeu
        KcPMPeOeWFcSILoeKQ61er9iX3EIBXx1gDLuAcu/WeCW634UldSWDwlzIYeGUAiNC6BcGc/gYgHVO
        ykcKWqOtKkIbA+aYGKQRqzXaINp2SoQO6GNlbGVAGQ2mHB7m8oFFsVdDMmqvYUYEwswJ7V6YeCYlu
        SWG5BbfQxgPLGVdnp9qp+wQUeQhCYsgrELuKqMkXPb6VIKu9RZHUj+9EpXekIiUE5A6rhA53FIdZH
        tRibQBQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiAFo-002Wc3-Tn; Tue, 11 Oct 2022 08:04:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D982D3001CB;
        Tue, 11 Oct 2022 10:04:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF85020D7E1AB; Tue, 11 Oct 2022 10:04:43 +0200 (CEST)
Date:   Tue, 11 Oct 2022 10:04:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <Y0Ujm6a6bV3+FWM3@hirez.programming.kicks-ass.net>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
 <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 10, 2022 at 04:15:33PM -0700, Sami Tolvanen wrote:
> On Fri, Oct 7, 2022 at 10:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 27, 2022 at 03:14:56PM +0200, Miguel Ojeda wrote:
> > > Note that only x86_64 is covered and not all features nor mitigations
> > > are handled, but it is enough as a starting point and showcases
> > > the basics needed to add Rust support for a new architecture.
> >
> > Does it fail the build if required options are missing? Specifically are
> > things like kCFI and IBT enabled? Silently not handling those will
> > result in an unbootable image.
> 
> Rust supports IBT with -Z cf-protection=branch, but I don't see this
> option being enabled in the kernel yet. Cross-language CFI is going to
> require a lot more work though because the type systems are not quite
> compatible:

Right; so where does that leave us? Are we going to force disable rust
when kCFI is selected ?
