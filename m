Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB014EBA13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiC3FX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 01:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiC3FXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A59F1480E8;
        Tue, 29 Mar 2022 22:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A2F615D9;
        Wed, 30 Mar 2022 05:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793BAC340EC;
        Wed, 30 Mar 2022 05:21:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EWx80GcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648617681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9uzCxmb6i4Vo8+AFdyD/kL3n4v054lqayW48puql9H8=;
        b=EWx80GcI7TD1DoS2Vm4HaYn+c5nAQrEiBRPse3R7LpWPaDc5V08VD/2P9H1JXT3PVH0BG9
        CYOz+fLf7jLdsKcCWhHI7SLGw5hFIkr+xQagOlsN4r0iA1DXdqzFf+Rem09E786EtjukJO
        jJ+vPNLgTJxTj2rdjk/88iGovmoCKzI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df7ade0d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 30 Mar 2022 05:21:21 +0000 (UTC)
Date:   Wed, 30 Mar 2022 01:21:20 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Message-ID: <YkPo0N/CVHFDlB6v@zx2c4.com>
References: <20220326114009.1690-1-aissur0002@gmail.com>
 <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67>
 <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Tue, Mar 29, 2022 at 03:18:56PM -0700, Linus Torvalds wrote:
> On Tue, Mar 29, 2022 at 2:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I will apply that ALIGN() thing since Christian could confirm it fixes
> > things, and try to add a few more comments about how bitmaps are
> > fundamentally in chunks of BITS_PER_LONG.
> 
> Ok, applied as commit 1c24a186398f ("fs: fd tables have to be
> multiples of BITS_PER_LONG").

This broke the WireGuard test suite, <https://www.wireguard.com/build-status/>,
on 32-bit archs with a line like:

[+] NS1: wg set wg0 private-key /dev/fd/63 listen-port 1 peer xb6I3yo5N/A9PXGeqSVdMywrogPz82Ug5vWTdqQJRF8= preshared-key /dev/fd/62 allowed-ips 192.168.241.2/32,fd00::2/128
fopen: No such file or directory

Those /dev/fd/63 and /dev/fd/62 are coming from bash process
redirection:

n1 wg set wg0 private-key <(echo "$key1") peer "$pub2" preshared-key <(echo "$psk") allowed-ips 192.168.241.2/32 endpoint 127.0.0.1:2

Peppering some printks, it looks like in `max_fds = ALIGN(max_fds,
BITS_PER_LONG);`, max_fds is sometimes 4294967295 before the call, and
that ALIGN winds up bringing it to 0.

Jason
