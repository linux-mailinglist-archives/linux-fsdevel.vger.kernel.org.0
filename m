Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F76E5EC786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiI0PWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiI0PW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:22:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC113D86F;
        Tue, 27 Sep 2022 08:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 798D9B81C5B;
        Tue, 27 Sep 2022 15:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE539C433D6;
        Tue, 27 Sep 2022 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664292145;
        bh=Rwu7lmP286mSyRCRHjUpHuXEGaRbO6W7Cm2TFtUPZyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsbjGzDIsdGgWkZcmVlfR+ysRYjobt9NaT34REsDbqk0MGHu166KLwVcoRzoBv9VA
         6r9HNFHd9GrrrlYDUCS5AJMqGmjWX6lJCMqmsjUCnrsdIS61cpdTPV2zF2HwTRwL0E
         9iTcMN/zkVR9b/LcDW2WkB8jpydi/2GoHFTKxaAQ=
Date:   Tue, 27 Sep 2022 17:22:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        =?iso-8859-1?Q?N=E1ndor_Istv=E1n_Kr=E1cser?= <bonifaido@gmail.com>,
        David Gow <davidgow@google.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v10 12/27] rust: add `kernel` crate
Message-ID: <YzMVLkr3ZlbENMcG@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-13-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-13-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:43PM +0200, Miguel Ojeda wrote:
> +unsafe impl GlobalAlloc for KernelAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // `krealloc()` is used instead of `kmalloc()` because the latter is
> +        // an inline function and cannot be bound to as a result.
> +        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }

This feels "odd" to me.  Why not just use __kmalloc() instead of
krealloc()?  I think that will get you the same kasan tracking, and
should be a tiny bit faster (1-2 less function calls).

I guess it probably doesn't matter right now, just curious, and not a
big deal at all.

Other minor comments:


> +/// Contains the C-compatible error codes.
> +pub mod code {
> +    /// Out of memory.
> +    pub const ENOMEM: super::Error = super::Error(-(crate::bindings::ENOMEM as i32));
> +}

You'll be adding other error values here over time, right?


> +/// A [`Result`] with an [`Error`] error type.
> +///
> +/// To be used as the return type for functions that may fail.
> +///
> +/// # Error codes in C and Rust
> +///
> +/// In C, it is common that functions indicate success or failure through
> +/// their return value; modifying or returning extra data through non-`const`
> +/// pointer parameters. In particular, in the kernel, functions that may fail
> +/// typically return an `int` that represents a generic error code. We model
> +/// those as [`Error`].
> +///
> +/// In Rust, it is idiomatic to model functions that may fail as returning
> +/// a [`Result`]. Since in the kernel many functions return an error code,
> +/// [`Result`] is a type alias for a [`core::result::Result`] that uses
> +/// [`Error`] as its error type.
> +///
> +/// Note that even if a function does not return anything when it succeeds,
> +/// it should still be modeled as returning a `Result` rather than
> +/// just an [`Error`].
> +pub type Result<T = ()> = core::result::Result<T, Error>;

What about functions that do have return functions of:
	>= 0 number of bytes read/written/consumed/whatever
	< 0  error code

Would that use Result or Error as a type?  Or is it best just to not try
to model that mess in Rust calls? :)

> +macro_rules! pr_info (
> +    ($($arg:tt)*) => (
> +        $crate::print_macro!($crate::print::format_strings::INFO, $($arg)*)
> +    )
> +);

In the long run, using "raw" print macros like this is usually not the
thing to do.  Drivers always have a device to reference the message to,
and other things like filesystems and subsystems have a prefix to use as
well.

Hopefully not many will use these as-is and we can wrap them properly
later on.

Then there's the whole dynamic debug stuff, but that's a different
topic.

Anyway, all looks sane to me, sorry for the noise:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
