Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77615EC78F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiI0PXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI0PXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:23:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC905160E66;
        Tue, 27 Sep 2022 08:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F977B81B2B;
        Tue, 27 Sep 2022 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B573EC433C1;
        Tue, 27 Sep 2022 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664292211;
        bh=LyIAB0lF9FCQiumvTQTwbtjhCItevMYwMDFfh2e4kzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOGV6xrrWAqcDC+CEV28UP2bfyMDvzxOt3CAOBGkG1KmY04WzaTIdt41JgaFCjaw3
         ROFQzJPwOcDzk+uevNtwmnIR8iu8Jgqm2ApKmuWTtuUcPQWQXgYJKWNdj9o9mHbnid
         IGLJBo2OErm4CHBOoKAi5rn8PTOl99aLs39T9994=
Date:   Tue, 27 Sep 2022 17:23:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v10 11/27] rust: add `bindings` crate
Message-ID: <YzMVcM/TxIA7S/1B@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-12-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927131518.30000-12-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:42PM +0200, Miguel Ojeda wrote:
> This crate contains the bindings to the C side of the kernel.
> 
> Calling C (in general, FFI) is assumed to be unsafe in Rust
> and, in many cases, this is accurate. For instance, virtually
> all C functions that take a pointer are unsafe since, typically,
> it will be dereferenced at some point (and in most cases there
> is no way for the callee to check its validity beforehand).
> 
> Since one of the goals of using Rust in the kernel is precisely
> to avoid unsafe code in "leaf" kernel modules (e.g. drivers),
> these bindings should not be used directly by them.
> 
> Instead, these bindings need to be wrapped into safe abstractions.
> These abstractions provide a safe API that kernel modules can use.
> In this way, unsafe code in kernel modules is minimized.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/bindings/bindings_helper.h | 13 ++++++++
>  rust/bindings/lib.rs            | 53 +++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 rust/bindings/bindings_helper.h
>  create mode 100644 rust/bindings/lib.rs

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
