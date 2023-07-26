Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3607636D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjGZMy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 08:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjGZMxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100E10B;
        Wed, 26 Jul 2023 05:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA886173F;
        Wed, 26 Jul 2023 12:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A3AC433C9;
        Wed, 26 Jul 2023 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690375996;
        bh=sJaZr1EtZGmMfy8pOqJTpEvOTmMp/9ov8PWPEb9SnFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XszFAHj6mkRDzhEtllc9G12deNNS7xO33I0rufGCstmhQVUZwrGCezcpojynELGnw
         9P6Hwx1z9UiVVq06rc2uEnIIjVyVTs7KOq8/k0A+uyXcLWtGchHJ9TX9A4b5jS3jU3
         y0Oqsk5j2Hg3HCpKSiNklD9Akhh6pnfppJbeB3NP5BIsFa4bAG3r9bf5XZAnFT3g/i
         CaqRV5fZfk6fsPX0OngwbZ56SdWSNLRamo8VzP09ReYERoqdJP42ZCurUMJXI1SDVV
         FLkrKDQfuc0EAca1YTu3iHIn/hIwAuLMngBSVoZK6z7q6kxp9C1tUhPtNoGFnSmarV
         +mtgJFYWoH44g==
Date:   Wed, 26 Jul 2023 14:53:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230726-wehmut-komodowaran-1e45910515b4@brauner>
References: <790fbcff-9831-e5cf-2aaf-1983d9c2cffe@kernel.dk>
 <CAHk-=wgqLGdTs5hBDskY4HjizPVYJ0cA6=-dwRR3TpJY7GZG3A@mail.gmail.com>
 <20230724-geadelt-nachrangig-07e431a2f3a4@brauner>
 <CAHk-=wjKXJhW3ZYtd1n9mhK8-8Ni=LSWoytkx2F5c5q=DiX1cA@mail.gmail.com>
 <4b382446-82b6-f31a-2f22-3e812273d45f@kernel.dk>
 <CAHk-=wg8gY+oBoehMop2G8wq2L0ciApZEOOMpiPCL=6gxBgx=g@mail.gmail.com>
 <8d1069bf-4c0b-22be-e4c4-5f2b1eb1f7e8@kernel.dk>
 <CAHk-=whMEd2J5otKf76zuO831sXi4OtgyBTozq_wE43q92=EiQ@mail.gmail.com>
 <20230726-antik-abwinken-87647ff63ec8@brauner>
 <081f95b2428049999cc2c0f55a46075f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <081f95b2428049999cc2c0f55a46075f@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:31:07AM +0000, David Laight wrote:
> From: Christian Brauner
> > Sent: 26 July 2023 09:37
> ...
> > Yes, and to summarize which I tried in my description for the commit.
> > The getdents support patchset would have introduced a bug because the
> > patchset copied the fdget_pos() file_count(file) > 1 optimization into
> > io_uring.
> > 
> > That works fine as long as the original file descriptor used to register
> > the fixed file is kept. The locking will work correctly as
> > file_count(file) > 1 and no races are possible neither via getdent calls
> > using the original file descriptor nor via io_uring using the fixed file
> > or even mixing both.
> > 
> > But as soon as the original file descriptor is closed the f_count for
> > the file drops back to 1 but continues to be usable from io_uring via
> > the fixed file. Now the optimization that the patchset wanted to copy
> > over would cause bugs as multiple racing getdent requests would be
> > possible using the fixed file.
> 
> Could the io_uring code grab two references?
> That would stop the optimisation without affecting any
> normal code paths?

io_uring doesn't use fdget variants and can't for it's purposes as fdget
is for short term references while io_uring holds on to the file. This
whole thing was about the logic that was copied in a patchset not the
actual helper itself. I thought that was clear from "copied the [...]
optimization into io_uring". It should just not do that.
