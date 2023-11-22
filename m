Return-Path: <linux-fsdevel+bounces-3490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B112E7F52A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C459281253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA121CABD;
	Wed, 22 Nov 2023 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a9T8JgpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811D1C686;
	Wed, 22 Nov 2023 21:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216ECC433C7;
	Wed, 22 Nov 2023 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700688829;
	bh=CCGiBp6ijIbiQN49IM0yNAMFM6x8RmE/GApUZ80sKhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9T8JgpHz5rCww2lmiWFAgJiYQz4lQnKLd+N/wJREBIzFj2s77dIv23vFbVfIT9GL
	 dYS5ISI7BaGwajylptbeE4CbFzWkGsDed74VdXV5ZAH6c7ZfBstkSddhZsFb82ORIs
	 +7sOq27xvaEWQzLNx0SteALC+cjD+zL6q9xcPca4=
Date: Wed, 22 Nov 2023 13:33:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com, Gregory Price
 <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-Id: <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 16:11:49 -0500 Gregory Price <gourry.memverge@gmail.com> wrote:

> The patch set changes task->mempolicy to be modifiable by tasks other
> than just current.
> 
> The ultimate goal is to make mempolicy more flexible and extensible,
> such as adding interleave weights (which may need to change at runtime
> due to hotplug events).  Making mempolicy externally modifiable allows
> for userland daemons to make runtime performance adjustments to running
> tasks without that software needing to be made numa-aware.

Please add to this [0/N] a full description of the security aspect: who
can modify whose mempolicy, along with a full description of the
reasoning behind this decision.

> 3. Add external interfaces which allow for a task mempolicy to be
>    modified by another task.  This is implemented in 4 syscalls
>    and a procfs interface:
>         sys_set_task_mempolicy
>         sys_get_task_mempolicy
>         sys_set_task_mempolicy_home_node
>         sys_task_mbind
>         /proc/[pid]/mempolicy

Why is the procfs interface needed?  Doesn't it simply duplicate the
syscall interface?  Please update [0/N] with a description of this
decision.

> The new syscalls are the same as their current-task counterparts,
> except that they take a pid as an argument.  The exception is
> task_mbind, which required a new struct due to the number of args.
> 
> The /proc/pid/mempolicy re-uses the interface mpol_parse_str format
> to enable get/set of mempolicy via procsfs.
> 
> mpol_parse_str format:
>             <mode>[=<flags>][:<nodelist>]
> 
> Example usage:
> 
> echo "default" > /proc/pid/mempolicy
> echo "prefer=relative:0" > /proc/pid/mempolicy
> echo "interleave:0-3" > /proc/pid/mempolicy

What do we get when we read from this?  Please add to changelog.

> Changing the mempolicy does not induce memory migrations via the
> procfs interface (which is the exact same behavior as set_mempolicy).
> 


