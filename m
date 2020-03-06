Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BFF17BFEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCFOKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 09:10:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFOKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:10:33 -0500
Received: from b2b-5-147-251-51.unitymedia.biz ([5.147.251.51] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jADgL-0005aS-Uk; Fri, 06 Mar 2020 14:10:30 +0000
Date:   Fri, 6 Mar 2020 15:10:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        metze@samba.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Mark AT_* path flags as deprecated and add missing
 RESOLVE_ flags
Message-ID: <20200306141029.zon3nt7oxqywbzf6@wittgenstein>
References: <3774367.1583430213@warthog.procyon.org.uk>
 <20200306134116.qfa2gj6os4weru7o@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306134116.qfa2gj6os4weru7o@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 07, 2020 at 12:41:16AM +1100, Aleksa Sarai wrote:
> On 2020-03-05, David Howells <dhowells@redhat.com> wrote:
> > Do we want to do this?  Or should we duplicate the RESOLVE_* flags to AT_*
> > flags so that existing *at() syscalls can make use of them?
> > 
> > David
> > ---
> > commit 448731bf3b29f2b1f7c969d7efe1f0673ae13b5e
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Thu Mar 5 17:40:02 2020 +0000
> > 
> >     Mark AT_* flags as deprecated and add missing RESOLVE_ flags
> >     
> >     It has been suggested that new path-using system calls should use RESOLVE_*
> >     flags instead of AT_* flags, but the RESOLVE_* flag functions are not a
> >     superset of the AT_* flag functions.  So formalise this by:
> >     
> >      (1) In linux/fcntl.h, add a comment noting that the AT_* flags are
> >          deprecated for new system calls and that RESOLVE_* flags should be
> >          used instead.
> 
> I wouldn't say it that way -- the RESOLVE_* flags should be used by
> syscalls *where it makes sense to change the path resolution rules*. If
> it makes more sense for them to have their own flag set, they should
> arguably make a separate one (like renameat2 did -- though renameat2 can
> never take AT_EMPTY_PATH because it isn't sufficiently extensible).

Yeah, we should clearly state that they are not a replacement for
_all_ the AT_* flags. I think it makes sense to think of RESOLVE_* flags
as a superset of the path-resolution portions of AT_* flags.

Maybe in openat2.h:

/*
 * Flags available to syscalls wanting to modify how paths are resolved.
 * RESOLVE_* flags are intended to as a superset of those AT_* flags 
 * concerned with path resolution. All syscalls modifying their path
 * resolution behavior are expected to use RESOLVE_* flags.
 */

Something like this (Native speaker can probably do this way nicer.)?
