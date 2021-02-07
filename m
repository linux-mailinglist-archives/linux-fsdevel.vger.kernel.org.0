Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CBC312878
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 00:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBGX4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 18:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBGX4i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 18:56:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 662B664E2E;
        Sun,  7 Feb 2021 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612742157;
        bh=HWyvZKJfjuWNmgzJfzyCnofu5H0oIg85cEfM9lGL4SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdpTmVHY3NCYvqqLAz9bhRn3sTzyMPSe6DYyrkHOfhhowSOUmukC7P28nIR4vIyiK
         17VlzLCWpG66x8KpzLyEK28MH41sWFm2H6cvjLdICIQbeu80wsOO7zskgPYuepPCyw
         LvflBy5gwoq/9amDk3wwq+SOXKH4nZuWXi4hHoXIsDD5ECuenkJ8k9s3k0HcUrvFo8
         yhoj2MocnwOC+DsYVeqk4m6i3bp2AEkRFzbkeBEALvxZzVgXE3dOD2z5ac4WCZn3kg
         3WOBmwnXIWs4Ud9Fj6ynXAYEWt5KWqO9hCEUlprK/wF86eYS2TZ504QR7lUs5boYGO
         uZuMezGm13kXA==
Date:   Mon, 8 Feb 2021 01:55:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Howells <dhowells@redhat.com>, mchehab+huawei@kernel.org
Cc:     sprabhu@redhat.com, christian@brauner.io, selinux@vger.kernel.org,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] Add namespace tags that can be used for matching
 without pinning a ns
Message-ID: <YCB+BRp7WIa8YoO3@kernel.org>
References: <YByxkDi0Ruhb0AA8@kernel.org>
 <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
 <161246085966.1990927.2555272056564793056.stgit@warthog.procyon.org.uk>
 <2094924.1612513535@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2094924.1612513535@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:25:35AM +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > > + * init_ns_common - Initialise the common part of a namespace
> > 
> > Nit: init_ns_common()
> 
> Interesting.  The majority of code doesn't put the brackets in.
> 
> > I've used lately (e.g. arch/x86/kernel/cpu/sgx/ioctl.c) along the lines:
> > 
> > * Return:
> > * - 0:          Initialization was successful.
> > * - -ENOMEM:    Out of memory.
> 
> Actually, looking at kernel-doc.rst, this isn't necessarily the recommended
> approach as it will much everything into one line, complete with dashes, and
> can't handle splitting over lines.  You probably meant:
> 
>       * Return:
>       * * 0		- OK to runtime suspend the device
>       * * -EBUSY	- Device should not be runtime suspended

A line beginning with dash, lines up just as well, as one beginning with
an asterisk. I've also tested this with "make htmldocs".

This is Mauro's response to my recent patch:

https://lore.kernel.org/lkml/20210125105353.5c695d42@coco.lan/

So, what I can make up from this is that they are equally good
alternatives.

What I'm not still fully registering is the dash after the return value.

I mean double comma is used after parameter. Why this weird dash syntax
is used after return value I have no idea, and the kernel-doc.rst does
not provide any explanation.

> 
> > * Return:
> > * - 0:          Initialization was successful.
> > * - -ENOMEM:    Out of memory.
> > 
> > Looking at the implementation, I guess this is a complete representation of
> > what it can return?
> 
> It isn't.  It can return at least -ENOSPC as well, but it's awkward detailing
> the errors from functions it calls since they can change and then the
> description here is wrong.  I'm not sure there's a perfect answer to that.
> 
> David

What if you just add this as the last entry:

* * -errno:     Otherwise.

/Jarkko
