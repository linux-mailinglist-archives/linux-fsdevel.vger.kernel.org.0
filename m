Return-Path: <linux-fsdevel+bounces-48573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD944AB114D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BD24C5785
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734128F527;
	Fri,  9 May 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9/C2rp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC521A434
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788228; cv=none; b=OdySRGbdUXE3MqPsoDkkvvTSwq+hz+sY+Upd5fWGCk9ceO141j0jBM4vJZuKkoqOMQmWVVjnsDYO+I4OW4Q/qY+pH365+t5PPpGV8pUEL6WVyvXojwRYKb+oWa3on21w7UBKmUFxEJoWCN/FlRYwhIKpHoNR1+t9wkBeUPTfLCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788228; c=relaxed/simple;
	bh=850pJdfy0yNLYeRcqBmJuIXBRpogsnYVOhr2fLfDQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWGhTUxs582oGDl7IdsXRP+O8UrB3EAMRaoZdLUHFWKsKsiuozVBgbdGil+hwvktpguWbvWTeOJ3Q5CKUbanLwR3zgR7P3sLsRs+5aVj8GFZ9h07zNQ4a5LtiYjQvuHKAf63B9YxOIAxb5nkmbqH8ASSp8vQ8jxpb9q7PbFr/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9/C2rp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC7AC4CEE4;
	Fri,  9 May 2025 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788227;
	bh=850pJdfy0yNLYeRcqBmJuIXBRpogsnYVOhr2fLfDQLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9/C2rp0wHbd8G339TzfIvmMgnBqa8k8XaP9hIk09LSNvm0YkoqSavTziTMBpDWSn
	 GKvDcfy0k18b5oXJ123BZBvIvTi2QPK0e18jM+H2UpKpy6m3QJFSG6glDeKFKCh6QO
	 4peNQIBShvALOPPdQ1YsWbaSXbDxJH9dd0Ds8l800SxIiR8OjaPAWMaURl4xvgvYoO
	 0m7HZ18Cr9/UEzF4SBUMvWrFG7fjUrgC0PNkLIWpPz26/XgGoAOjpCgc6wb+GaH2Ci
	 SU6fAXTRmHtySdf//OWusVIA3FEVtuKsJdoc7xkMKBRoCXFNXDwbmJo++B+rHjVw/x
	 vvrk99TnTHRmQ==
Date: Fri, 9 May 2025 12:57:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 2/5] selftests/fs/statmount: build with tools include dir
Message-ID: <20250509-verhielt-hecht-4850ff585c31@brauner>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-3-amir73il@gmail.com>
 <ad3c6713-1b4b-47e4-983b-d5f3903de4d0@nvidia.com>
 <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxin2B+wieUaAj=CeyEn4Z0xGUvBj5yOawKiuqPp+geSGg@mail.gmail.com>

On Thu, May 08, 2025 at 01:36:09PM +0200, Amir Goldstein wrote:
> Forgot to CC Miklos (now added)
> 
> On Thu, May 8, 2025 at 9:31 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 5/7/25 1:42 PM, Amir Goldstein wrote:
> > > Copy the required headers files (mount.h, nsfs.h) to the
> > > tools include dir and define the statmount/listmount syscalls
> > > for x86_64 to decouple dependency with headers_install for the
> > > common case.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> ...
> > > -CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
> > > +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> >
> > Yes. :)
> >
> > > +
> > >   TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
> > >
> > >   include ../../lib.mk
> > > diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
> > > index a7a5289ddae9..e84d47fadd0b 100644
> > > --- a/tools/testing/selftests/filesystems/statmount/statmount.h
> > > +++ b/tools/testing/selftests/filesystems/statmount/statmount.h
> > > @@ -7,6 +7,18 @@
> > >   #include <linux/mount.h>
> > >   #include <asm/unistd.h>
> > >
> > > +#ifndef __NR_statmount
> > > +#if defined(__x86_64__)
> > > +#define __NR_statmount       457
> > > +#endif
> > > +#endif
> > > +
> > > +#ifndef __NR_listmount
> > > +#if defined(__x86_64__)
> > > +#define __NR_listmount       458
> > > +#endif
> > > +#endif
> >
> > Yes, syscalls are the weak point for this approach, and the above is
> > reasonable, given the situation, which is: we are not set up to recreate
> > per-arch syscall tables for kselftests to use. But this does leave the
> > other big arch out in the cold: arm64.
> >
> > It's easy to add, though, if and when someone wants it.
> 
> I have no problem adding || defined(__arm64__)
> it's the same syscall numbers anyway.
> 
> Or I could do
> #if !defined(__alpha__) && !defined(_MIPS_SIM)
> 
> but I could not bring myself to do the re-definitions that Christian
> added in mount_setattr_test.c for
> __NR_mount_setattr, __NR_open_tree, __NR_move_mount
> 
> Note that there are stale definitions for __ia64__ in that file
> and the stale definition for __NR_move_mount is even wrong ;)
> 
> Christian,
> 
> How about moving the definitions from mount_setattr_test.c into wrappers.h
> and leaving only the common !defined(__alpha__) && !defined(_MIPS_SIM)
> case?
> 
> Thanks for the review!

For new system calls this covers all arches and is what I usually use:

#ifndef __NR_open_tree
        #if defined __alpha__
                #define __NR_open_tree 538
        #elif defined _MIPS_SIM
                #if _MIPS_SIM == _MIPS_SIM_ABI32        /* o32 */
                        #define __NR_open_tree 4428
                #endif
                #if _MIPS_SIM == _MIPS_SIM_NABI32       /* n32 */
                        #define __NR_open_tree 6428
                #endif
                #if _MIPS_SIM == _MIPS_SIM_ABI64        /* n64 */
                        #define __NR_open_tree 5428
                #endif
        #elif defined __ia64__
                #define __NR_open_tree (428 + 1024)
        #else
                #define __NR_open_tree 428
        #endif
#endif

where the ia64 stuff can obviously be removed now.

