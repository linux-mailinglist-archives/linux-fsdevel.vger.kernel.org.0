Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3382CED19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 12:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgLDLdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 06:33:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60892 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgLDLdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:33:21 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kl9KJ-0007oZ-7k; Fri, 04 Dec 2020 11:32:39 +0000
Date:   Fri, 4 Dec 2020 12:32:38 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v3 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201204113238.bazik6j3p7v5g2ak@wittgenstein>
References: <20201118104746.873084-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118104746.873084-1-gscrivan@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:47:44AM +0100, Giuseppe Scrivano wrote:
> When the new flag is used, close_range will set the close-on-exec bit
> for the file descriptors instead of close()-ing them.
> 
> It is useful for e.g. container runtimes that want to minimize the
> number of syscalls used after a seccomp profile is installed but want
> to keep some fds open until the container process is executed.
> 
> v3:
> - fixed indentation
> - selftests: use ASSERT_EQ instead of EXPECT_EQ for hard failures
> 
> v2: https://lkml.kernel.org/lkml/20201019102654.16642-1-gscrivan@redhat.com/
> - move close_range(..., CLOSE_RANGE_CLOEXEC) implementation to a separate function.
> - use bitmap_set() to set the close-on-exec bits in the bitmap.
> - add test with rlimit(RLIMIT_NOFILE) in place.
> - use "cur_max" that is already used by close_range(..., 0).
> 
> v1: https://lkml.kernel.org/lkml/20201013140609.2269319-1-gscrivan@redhat.com/
> 
> Giuseppe Scrivano (2):
>   fs, close_range: add flag CLOSE_RANGE_CLOEXEC
>   selftests: core: add tests for CLOSE_RANGE_CLOEXEC
> 
>  fs/file.c                                     | 44 ++++++++---
>  include/uapi/linux/close_range.h              |  3 +
>  .../testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++
>  3 files changed, 111 insertions(+), 10 deletions(-)

I've picked this up and stuffed it into -next. This solves a real
problem and I don't want it to sit around another merge window. (If you
pick it up later I'll simply drop it, Al.)

Christian
