Return-Path: <linux-fsdevel+bounces-49706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F2DAC1AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1471C1B65B87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 03:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAD221FB6;
	Fri, 23 May 2025 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj/rQ3Gi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F82DCBE7;
	Fri, 23 May 2025 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972128; cv=none; b=V/GJYdjkgJ1URUx13vfsZbxu0EW8Sr5jm7Ti5iu4TTuiqv2G3ryukSNzbfN4YG8g2azA8owWVeGxg4RFOmCOSyigk6ATscVbTErzH+yQHBNbdqE+sKL735hSPR5AG7+grdh7SpEMs9mIfLA36IkY6hUTS/GKOuatfV2TfXyusz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972128; c=relaxed/simple;
	bh=hU4E11daZQRWPop+eXf7dItbrTLSr07eegr9d9rLyLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/Ih2cb3aAAm/oUm+8JcqiLAK6YAKsQIDSndyLFlzvZgQcUEJgyApO6XvZy44UmzVFcZFygQoOHUk0g2Igt0p4uiY7R+3g98y4HL1w+o3VmQHbuDLlDK1x1Uecmr8IOVd+Xr4mYLuu1j/+nTCN4BxtyaajUed3DPzKnUxOsjobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj/rQ3Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC07C4CEE9;
	Fri, 23 May 2025 03:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747972127;
	bh=hU4E11daZQRWPop+eXf7dItbrTLSr07eegr9d9rLyLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lj/rQ3GiGLdiau+P57zmneGhBgAfMwOjMvBLctFhT75R1EPvZ5B+giVnFwI5eHxa9
	 RiMiquG8Ahu7fzGgL53Px/BnaD5MqSe+XkulE8WW3VtGLO3jgYvTq7mHJmnXO8HT0k
	 IVlm+pa2SWgRZfx0S+157FDTqcymr66Laaajra42Cmav0gUZ5rF4VwxfkSUBOljdMj
	 Zu+1bGtmcY67IjZpTYe/CyKwnE1FIQawVg8S5ZD4PBl0KY2UIPvReTE3pKq0rTvPqd
	 l4BA/NIs6ebHPA4YP0vqH8f8LYR9cjI9h0XPmOzzN1clAgzBOWk0XqocxYh+JpDqIl
	 CK9+q1olWtQ9g==
Date: Thu, 22 May 2025 20:48:44 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] exec: Add support for 64 byte 'tsk->comm_ext'
Message-ID: <202505222041.B639D482FB@keescook>
References: <20250521062337.53262-1-bhupesh@igalia.com>
 <20250521062337.53262-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521062337.53262-4-bhupesh@igalia.com>

On Wed, May 21, 2025 at 11:53:37AM +0530, Bhupesh wrote:
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> 
> To fix the same, Linus suggested in [1] that we can add the
> following union inside 'task_struct':
>        union {
>                char    comm[TASK_COMM_LEN];
>                char    comm_ext[TASK_COMM_EXT_LEN];
>        };

I remain unconvinced that this is at all safe. With the existing
memcpy() and so many places using %s and task->comm, this feels very
very risky to me.

Can we just make it separate, instead of a union? Then we don't have to
touch comm at all.

> and then modify '__set_task_comm()' to pass 'tsk->comm_ext'
> to the existing users.

We can use set_task_comm() to set both still...

-- 
Kees Cook

