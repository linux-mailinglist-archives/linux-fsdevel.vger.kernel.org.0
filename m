Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FC7440F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjF3ROM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjF3ROF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:14:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CED1DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 10:14:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-24.bstnma.fios.verizon.net [173.48.82.24])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35UHDgXR012238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688145225; bh=eRkiqUCEclG9KgZecVs1P0Wzt0tTZDVD/MSUDf9IzBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dFFHXNePbIQJpb2yYz32mHlzqBti0NQXFuVoitWpMlKrj4nhtfFzhBy+z18UrGMh+
         BStLvAxp8o+GwVDvCHXuVglZ47YUrqk3SZzk/Lrxt0tYZWYfrQ35XkufbYrRUDV+oF
         Ra4R/quxfVZ13jfAa30FiJTgSUcWVcll2SeaWiY8KOZn1ojO67BGq74sPTxrTHDmfp
         UqkvcoyjO/ckIP7HgvV+4M0X9Eipk36ne6EZnRSAaRKArqrLwDDTPoDZsn5GPxVBFd
         N9DYdrTU0R7XmPjr8CyiZ5ia0CKsverjzw/CPat5gsmuf/YDcAgWTctNV/h1ZHI/AX
         I85PBlKTpPrlA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36D6715C027F; Fri, 30 Jun 2023 13:13:42 -0400 (EDT)
Date:   Fri, 30 Jun 2023 13:13:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+94a8c779c6b238870393@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Howells <dhowells@redhat.com>
Subject: Re: [syzbot] [ext4?] general protection fault in
 ext4_put_io_end_defer
Message-ID: <20230630171342.GC591635@mit.edu>
References: <0000000000002a0b1305feeae5db@google.com>
 <20230629035714.GJ8954@mit.edu>
 <20230630074111.GB36542@sol.localdomain>
 <20230630074614.GC36542@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630074614.GC36542@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:46:14AM -0700, Eric Biggers wrote:
> > AF_ALG has existed since 2010.  My understanding that its original purpose was
> > to expose hardware crypto accelerators to userspace.  Unfortunately, support for
> > exposing *any* crypto algorithm was included as well, which IMO was a mistake.

+1000....

> > There are quite a few different userspace programs that use AF_ALG purely to get
> > at the CPU-based algorithm implementations, without any sort of intention to use
> > hardware crypto accelerator.  Probably because it seemed "easy".  Or "better"
> > because everything in the kernel is better, right?

Do we know if any to standard crypto libraries are using AF_ALG?  All
aside from whether it's a good idea for userspace programs to be using
kernel code because "everything is better in the kernel", I'm
wondering how solicitous we should be for programs who are very likely
rolling their own crypto, as opposed to using crypto library that has
been written and vetted and tested for vulnerability by experts...

> > It's controlled by the CONFIG_CRYPTO_USER_API_* options, with the hash support
> > in particular controlled by CONFIG_CRYPTO_USER_API_HASH.  Though good luck
> > disabling it on most systems, as systemd depends on it...
> > 
> 
> Actually it turns out systemd has finally seen the light:
> https://github.com/systemd/systemd/commit/2c3794f4228162c9bfd9e10886590d9f5b1920d7

Aside from those PCI-attached crypto accelerators where you have to go
through the kernel (although my experience has been that most of the
time, the overhead for key scheduling, etc., is such that unless
you're doing bulk crypto on large chunks of data, using external
crypto hardware acclerators no longer makes sense 99.99% of the time
in the 21st century), I wonder if we should consider having the kernel
print a warning, "WARNING: [comm] is using AF_ALG; please consider
using a real crypto library instead of rolling your own crypto".

(Only half kidding.)

					- Ted
