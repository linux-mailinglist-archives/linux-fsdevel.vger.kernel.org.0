Return-Path: <linux-fsdevel+bounces-47361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA7A9C85B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBFB9E3666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C324E4A4;
	Fri, 25 Apr 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVg7g6w9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E824BC1D;
	Fri, 25 Apr 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582240; cv=none; b=uKQT/b9vmdkJEC0pSsTaHLBwVCVvsGveZoVmDahBkwXOC0g7KVf0yde1W4bYgeW6uPJ9/2yBK9HCCjyH0V/1t1/rdSVwGRwiMNk0Tox1ARt9Hs6xaXmvhVN00Q8BOXDgB8O7DbtL0+B3RxDElqobdgh0dARDNVYtDRynmRCEXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582240; c=relaxed/simple;
	bh=KMQeJ0Hp8WHAWUQDAWMTEpOv2mG7Q43RvElIe/5zzzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg7jGiF58pyxoz8idY83bQtm5sun2dkJprlmsiQ/zs7aCkqbbkZA+FdTA4KED981SwSokaNZ4LybuvyZXyMvSRVzP55W1QtZmKbseg2YWoxthWokgu+haPe0oQjc/z6xb8brHUruzRZVhSnGXC7EHXQooxiEIOax51r1V5zX/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVg7g6w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B936C4CEE4;
	Fri, 25 Apr 2025 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745582238;
	bh=KMQeJ0Hp8WHAWUQDAWMTEpOv2mG7Q43RvElIe/5zzzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVg7g6w95ov7UsAVceaf3qBOt1aIlp6V3lsMltPBk53vDGvXL7WJ+dHkE96QqeiFE
	 7FyHDc0bcow8unfeGUbtFUFMNQ0zy4A7Wg1n1UU1b0Wc86TMwnlU44AlorZtdm7fxa
	 IWZfGLlClL0IDXCor5RC9uZvsghsC8KuUQkXca1iitSrAf5i6l6HvfmOLJW+swE7b3
	 lpv6hq7ZEhW26vxuMf8dlzLkHb8VLIjttlwfXeTUlGG3Jfyu2YR94c4Ag03Md3RUu9
	 O+Hka3QUdXRuf2tN910dtCHDkyOoifZE0ziNMWMvmDBbXObXRHUV700FViAFw//buA
	 DZp98X6c7lEAA==
Date: Fri, 25 Apr 2025 13:57:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Drung <benjamin.drung@canonical.com>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250425-eskapaden-regnen-4534af2aef11@brauner>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
 <ee1263a1bcb7510f2ec7a4c34e5c64b3a1d21d7a.camel@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee1263a1bcb7510f2ec7a4c34e5c64b3a1d21d7a.camel@canonical.com>

On Fri, Apr 25, 2025 at 01:31:56PM +0200, Benjamin Drung wrote:
> Hi,
> 
> On Mon, 2025-04-14 at 15:55 +0200, Christian Brauner wrote:
> > Give userspace a way to instruct the kernel to install a pidfd into the
> > usermode helper process. This makes coredump handling a lot more
> > reliable for userspace. In parallel with this commit we already have
> > systemd adding support for this in [1].
> > 
> > We create a pidfs file for the coredumping process when we process the
> > corename pattern. When the usermode helper process is forked we then
> > install the pidfs file as file descriptor three into the usermode
> > helpers file descriptor table so it's available to the exec'd program.
> > 
> > Since usermode helpers are either children of the system_unbound_wq
> > workqueue or kthreadd we know that the file descriptor table is empty
> > and can thus always use three as the file descriptor number.
> > 
> > Note, that we'll install a pidfd for the thread-group leader even if a
> > subthread is calling do_coredump(). We know that task linkage hasn't
> > been removed due to delay_group_leader() and even if this @current isn't
> > the actual thread-group leader we know that the thread-group leader
> > cannot be reaped until @current has exited.
> > 
> > Link: https://github.com/systemd/systemd/pull/37125 [1]
> > Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/coredump.c            | 59 ++++++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/coredump.h |  1 +
> >  2 files changed, 56 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 9da592aa8f16..403be0ff780e 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -43,6 +43,9 @@
> >  #include <linux/timekeeping.h>
> >  #include <linux/sysctl.h>
> >  #include <linux/elf.h>
> > +#include <linux/pidfs.h>
> > +#include <uapi/linux/pidfd.h>
> > +#include <linux/vfsdebug.h>
> >  
> >  #include <linux/uaccess.h>
> >  #include <asm/mmu_context.h>
> > @@ -60,6 +63,12 @@ static void free_vma_snapshot(struct coredump_params *cprm);
> >  #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
> >  /* Define a reasonable max cap */
> >  #define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
> > +/*
> > + * File descriptor number for the pidfd for the thread-group leader of
> > + * the coredumping task installed into the usermode helper's file
> > + * descriptor table.
> > + */
> > +#define COREDUMP_PIDFD_NUMBER 3
> >  
> >  static int core_uses_pid;
> >  static unsigned int core_pipe_limit;
> > @@ -339,6 +348,27 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
> >  			case 'C':
> >  				err = cn_printf(cn, "%d", cprm->cpu);
> >  				break;
> > +			/* pidfd number */
> > +			case 'F': {
> > +				/*
> > +				 * Installing a pidfd only makes sense if
> > +				 * we actually spawn a usermode helper.
> > +				 */
> > +				if (!ispipe)
> > +					break;
> > +
> > +				/*
> > +				 * Note that we'll install a pidfd for the
> > +				 * thread-group leader. We know that task
> > +				 * linkage hasn't been removed yet and even if
> > +				 * this @current isn't the actual thread-group
> > +				 * leader we know that the thread-group leader
> > +				 * cannot be reaped until @current has exited.
> > +				 */
> > +				cprm->pid = task_tgid(current);
> > +				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
> > +				break;
> > +			}
> >  			default:
> >  				break;
> >  			}
> > 
> 
> I tried this change with Apport: I took the Ubuntu mainline kernel build
> https://kernel.ubuntu.com/mainline/daily/2025-04-24/ (that refers to
> mainline commit e54f9b0410347c49b7ffdd495578811e70d7a407) and applied
> these three patches on top. Then I modified Apport to take the
> additional `-F%F` and tested that on Ubuntu 25.04 (plucky). The result
> is the coredump failed as long as there was `-F%F` on

I have no clue what -F%F is and whether that leading -F is something
specific to Apport but the specifier is %F not -F%F. For example:

        > cat /proc/sys/kernel/core_pattern
        |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %F

And note that this requires the pipe logic to be used, aka "|" needs to
be specified. Without it this doesn't make sense.

