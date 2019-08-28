Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D738FA0B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1UYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 16:24:05 -0400
Received: from venus.catern.com ([68.183.49.163]:44628 "EHLO venus.catern.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfH1UYE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:24:04 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 16:24:03 EDT
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.206.19.101; helo=localhost; envelope-from=sbaugh@catern.com; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=catern.com; s=mail;
        t=1567023434; bh=0ywMFKjMwE/uBXqaIPb34y8Q/aLLCmGU3C97TLkQvwo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=REuwdRN9P9zoh6DHSLiK1nqu3i2wNZqBJCILEt+4b0yiKxgb0XYUJwKX2wRNDyDWc
         JukKo1pvC54OaIX4CqMGz3OuGJLGPRfZ0csrkVnGcnxMd6oby8HYrRP9EeNU+sPgW7
         McVdUazYCiNEMo/74xDeTcyWeiOv6iN9cpLaK4n8=
Received: from localhost (ec2-34-206-19-101.compute-1.amazonaws.com [34.206.19.101])
        by venus.catern.com (Postfix) with ESMTPSA id 0564E2C2971;
        Wed, 28 Aug 2019 20:17:13 +0000 (UTC)
From:   Spencer Baugh <sbaugh@catern.com>
To:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
In-Reply-To: <4da231cd52880991d8a038adb8fbb2ef3d724db9.camel@kernel.org>
References: <20190820033406.29796-1-cyphar@cyphar.com> <20190820033406.29796-8-cyphar@cyphar.com> <854l2366zp.fsf@catern.com> <4da231cd52880991d8a038adb8fbb2ef3d724db9.camel@kernel.org>
Date:   Wed, 28 Aug 2019 20:17:07 +0000
Message-ID: <85y2zd3v0c.fsf@catern.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:
> On Mon, 2019-08-26 at 19:50 +0000, sbaugh@catern.com wrote:
>> Aleksa Sarai <cyphar@cyphar.com> writes:
>> > To this end, we introduce the openat2(2) syscall. It provides all of the
>> > features of openat(2) through the @how->flags argument, but also
>> > also provides a new @how->resolve argument which exposes RESOLVE_* flags
>> > that map to our new LOOKUP_* flags. It also eliminates the long-standing
>> > ugliness of variadic-open(2) by embedding it in a struct.
>> 
>> I don't like this usage of a structure in memory to pass arguments that
>> would fit in registers. This would be quite inconvenient for me as a
>> userspace developer.
>> 
>> Others have brought up issues with this: the issue of seccomp, and the
>> issue of mismatch between the userspace interface and the kernel
>> interface, are the most important for me. I want to add another,
>> admittedly somewhat niche, concern.
>> 
>> This interfaces requires a program to allocate memory (even on the
>> stack) just to pass arguments to the kernel which could be passed
>> without allocating that memory. That makes it more difficult and less
>> efficient to use this syscall in any case where memory is not so easily
>> allocatable: such as early program startup or assembly, where the stack
>> may be limited in size or not even available yet, or when injecting a
>> syscall while ptracing.
>> 
>> A struct-passing interface was needed for clone, since we ran out of
>> registers; but we have not run out of registers yet for openat, so it
>> would be nice to avoid this if we can. We can always expand later...
>> 
>
> We can't really expand later like you suggest.
>
> Suppose in a couple of years that we need to add some new argument to
> openat2 that isn't just a new flag. If all these values are passed by
> individual arguments, you can't add one later without adding yet another
> syscall.

Sure we can. This new syscall doesn't need to use all 6 available
arguments. It can enforce that the unused ones are 0. Then if we
eventually run out of flags and need to switch to pass arguments via
struct, we can just use one of the unused arguments for that purpose.

Even if we used all 6 arguments, in the worst-case scenario, the last
flag we add could change the interpretation of some other argument so it
can be used to pass a pointer to a struct.
