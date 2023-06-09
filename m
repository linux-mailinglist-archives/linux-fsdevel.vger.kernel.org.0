Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8152572A6DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 01:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFIXxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 19:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFIXw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:52:59 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32B4359C
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 16:52:56 -0700 (PDT)
Date:   Fri, 9 Jun 2023 19:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686354775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCKPXNbfuXiLkTq+8ViGBVnBlfhzGJ+dmPtv6KeJLyU=;
        b=q5Lowd7A0s9qPP8jzg8vr8fCvb8MAjYzkXWU/IngLXVc7DchIAX2RiPqlWPrRWHVuB4sjp
        Xpaon3ZIOCKUGHq0vCojG48qgKluyMDhIxhJ7WKAr9+umblXsFISgywWXr3Joy7DLDx4Nk
        LKv0l42RZQPJURcbW5Hrz/LInYL7yeE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ariel Miculas <amiculas@cisco.com>, linux-fsdevel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Message-ID: <ZIO7U4A1rkIXlDeO@moria.home.lan>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:36:29PM +0200, Christian Brauner wrote:
> On Fri, Jun 09, 2023 at 09:29:58AM +0300, Ariel Miculas wrote:
> > Hi all!
> > 
> > This is a proof of concept driver written for the PuzzleFS
> 
> Uhm, the PuzzleFS filesystem isn't actually sent to fsdevel? Yet I see
> tons of patches in there that add wrappers to our core fs data
> structures. I even see a ton of new files that all fall clearly into
> fsdevel territory:
> 
> create mode 100644 rust/kernel/cred.rs
> create mode 100644 rust/kernel/delay.rs
> create mode 100644 rust/kernel/driver.rs
> create mode 100644 rust/kernel/file.rs
> create mode 100644 rust/kernel/fs.rs
> create mode 100644 rust/kernel/fs/param.rs
> create mode 100644 rust/kernel/io_buffer.rs
> create mode 100644 rust/kernel/iov_iter.rs
> create mode 100644 rust/kernel/mm.rs
> create mode 100644 rust/kernel/mount.rs
> create mode 100644 rust/kernel/pages.rs
> 
> There's also quite a lot of new mm/ in there, no?
> 
> Any wrappers and code for core fs should be maintained as part of fs.
> Rust shouldn't become a way to avoid our reviews once you have a few
> wrappers added somewhere.

I'm of the opinion that Rust wrappers should generally live in the same
directories as the code they're wrapping. The Rust wrappers are unsafe
code that is intimately coupled with the C code they're creating safe
interfaces for, and the organizational structure should reflect that.

This'll be particularly important when mixing Rust and C in the same
module, as I intend to do in bcachefs in the not-too-distant future.
