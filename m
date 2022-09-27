Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985305EC704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiI0O4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiI0O4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7EF979E8;
        Tue, 27 Sep 2022 07:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 566E2619E8;
        Tue, 27 Sep 2022 14:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437E1C433C1;
        Tue, 27 Sep 2022 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664290524;
        bh=aUKfoGvdKDzMOXhk0hJy8k35gYHkpZkep32NjUanwCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7t/c8uRme2jhzpK8riOPTNuNrQffCT9WLogKMaylDVTcRw2uwaNe2z7raw11OAbW
         d3NDCbdprubws4K+N2rONj6jjzvYjhi8c8B27jSsQz9r/eUpn7RZ5jIfMEO2Vm6lbh
         rFY/zJNfsPkN8mTEMjabMqTyDAH8m3a+U5iZolPU=
Date:   Tue, 27 Sep 2022 16:55:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 04/27] kallsyms: support "big" kernel symbols
Message-ID: <YzMO2jAHKNdSRltf@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-5-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-5-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:35PM +0200, Miguel Ojeda wrote:
> Rust symbols can become quite long due to namespacing introduced
> by modules, types, traits, generics, etc.
> 
> Increasing to 255 is not enough in some cases, therefore
> introduce longer lengths to the symbol table.
> 
> In order to avoid increasing all lengths to 2 bytes (since most
> of them are small, including many Rust ones), use ULEB128 to
> keep smaller symbols in 1 byte, with the rest in 2 bytes.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  kernel/kallsyms.c  | 26 ++++++++++++++++++++++----
>  scripts/kallsyms.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 7 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
