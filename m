Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EB140E82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAQQBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:01:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34606 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:01:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isU3Z-00ALHS-1l; Fri, 17 Jan 2020 16:01:09 +0000
Date:   Fri, 17 Jan 2020 16:01:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117160109.GL8904@ZenIV.linux.org.uk>
References: <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <364531.1579265357@warthog.procyon.org.uk>
 <448106.1579272445@warthog.procyon.org.uk>
 <18dad9903c4f5c63300048e9ed2a8706ad31bc73.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18dad9903c4f5c63300048e9ed2a8706ad31bc73.camel@hammerspace.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:56:05PM +0000, Trond Myklebust wrote:

> It sounds to me like we rather need a meta-topic about "How do we get
> simple things done in the Linux fs community?"
> 
> It shouldn't take a ticket to Palm Springs to perform something simple
> like adding a new flag to a syscall.

Sure - adding a new flag is trivial.  Coming up with sane semantics for
it, OTOH, can be rather non-trivial and in this case it is, unfortunately.
"something like link(2), only it tolerates the existing target and
atomically replaces it" does _not_ specify the semantics.  Try to sit
down for a few minutes and come up with the cases when behaviour is
undefined by the above; it won't take longer than that.

We can do it by asking the proponent to come up with full description to
be included into the proposal, then have at it on fsdevel/linux-abi (as
well as security lists).  Doable, but not a small amount of PITA for
original poster and dealing with questions/objections/etc. is certain
to grow a large thread with many branches (and lots of bikeshedding
thrown in) _and_ would include tons of roundtrips, so the latency
(especially early on, while the proposal is still raw) will be a factor.

It's not the question of how to implement it; it's what should it _do_.
And "we'll tweak the behaviour in corner cases later on" is good in
a lot of situations, but not for userland ABI.  I'd been guilty of
such fuckups several times and they are not cheap to fix afterwards ;-/
