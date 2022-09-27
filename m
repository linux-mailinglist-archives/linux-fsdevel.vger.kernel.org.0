Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84FC5EC71C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiI0PAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiI0PAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:00:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD53E772;
        Tue, 27 Sep 2022 08:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2ECCCE19C1;
        Tue, 27 Sep 2022 15:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89289C433D6;
        Tue, 27 Sep 2022 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664290830;
        bh=81ZggzcRDYREEiyZAFfZf2iNyEU4c2S22a/8ksdHrNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRHFUkWcjtW1f8LNpABWTRojamUqeeFWLivk6u2qJM62I9cJd+jLVzW4WorsvDMKL
         Xn7K85RmCPx/aKZKXtdJx/CkiaOgcFYMsjErIJr1YTpZpOmN5SBMJhMbByOubDkSPr
         xw6YpD8uBOotEou4j6qEveRxrbsUgXjmmukBth14=
Date:   Tue, 27 Sep 2022 17:00:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 14/27] vsprintf: add new `%pA` format specifier
Message-ID: <YzMQCwxYr3rMxa5U@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-15-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-15-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:45PM +0200, Miguel Ojeda wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This patch adds a format specifier `%pA` to `vsprintf` which formats
> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> format to the internal buffer of `printf`, so we do not have to use
> a temporary buffer on the stack to pre-assemble the message on
> the Rust side.
> 
> This specifier is intended only to be used from Rust and not for C, so
> `checkpatch.pl` is intentionally unchanged to catch any misuse.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/core-api/printk-formats.rst | 10 ++++++++++
>  lib/vsprintf.c                            | 13 +++++++++++++
>  2 files changed, 23 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
