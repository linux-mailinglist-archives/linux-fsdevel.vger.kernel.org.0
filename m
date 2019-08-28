Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D990FA06B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfH1Pzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 11:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfH1Pzu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:55:50 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765322064A;
        Wed, 28 Aug 2019 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567007749;
        bh=tm23iPOHz5qNiVmbKBRthv6o0H14qpr8dY7bd4MTQKs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pqTccn5JcnucNCAhPvukewbhK7LnqfZiA1JhrrT1FDFY4mCrVB8AZyQ8GN7mLjP8y
         7s9EDdOPkKuIVFWDEaVrPbihjrm8teyPYUCsz+WciUJXkEpW4kr0ySk55f/ASUGrn8
         zpEFoJeA5Hy5XDMtaE0vrkdWUVKHa2wWQhJO2xxg=
Message-ID: <4da231cd52880991d8a038adb8fbb2ef3d724db9.camel@kernel.org>
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
From:   Jeff Layton <jlayton@kernel.org>
To:     sbaugh@catern.com, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Date:   Wed, 28 Aug 2019 11:55:47 -0400
In-Reply-To: <854l2366zp.fsf@catern.com>
References: <20190820033406.29796-1-cyphar@cyphar.com>
         <20190820033406.29796-8-cyphar@cyphar.com> <854l2366zp.fsf@catern.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-08-26 at 19:50 +0000, sbaugh@catern.com wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
> > To this end, we introduce the openat2(2) syscall. It provides all of the
> > features of openat(2) through the @how->flags argument, but also
> > also provides a new @how->resolve argument which exposes RESOLVE_* flags
> > that map to our new LOOKUP_* flags. It also eliminates the long-standing
> > ugliness of variadic-open(2) by embedding it in a struct.
> 
> I don't like this usage of a structure in memory to pass arguments that
> would fit in registers. This would be quite inconvenient for me as a
> userspace developer.
> 
> Others have brought up issues with this: the issue of seccomp, and the
> issue of mismatch between the userspace interface and the kernel
> interface, are the most important for me. I want to add another,
> admittedly somewhat niche, concern.
> 
> This interfaces requires a program to allocate memory (even on the
> stack) just to pass arguments to the kernel which could be passed
> without allocating that memory. That makes it more difficult and less
> efficient to use this syscall in any case where memory is not so easily
> allocatable: such as early program startup or assembly, where the stack
> may be limited in size or not even available yet, or when injecting a
> syscall while ptracing.
> 
> A struct-passing interface was needed for clone, since we ran out of
> registers; but we have not run out of registers yet for openat, so it
> would be nice to avoid this if we can. We can always expand later...
> 

We can't really expand later like you suggest.

Suppose in a couple of years that we need to add some new argument to
openat2 that isn't just a new flag. If all these values are passed by
individual arguments, you can't add one later without adding yet another
syscall.

Using a struct for this allows this to be extended later, OTOH. You can
extend it, and add a flag that tells the kernel that it can access the
new field. No new syscall required.
-- 
Jeff Layton <jlayton@kernel.org>

