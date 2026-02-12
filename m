Return-Path: <linux-fsdevel+bounces-77066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGiPOghojmlPCAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:53:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF3131D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 285303084BCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BC2F1FE2;
	Thu, 12 Feb 2026 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htv2usbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B31A8F97;
	Thu, 12 Feb 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940416; cv=none; b=EcnSyzEQ8gox+iL8YDJckAO5chZxUg1Z+aME5XheDFYlVZvxMQSbybYd/Q/nNVEJDIZcBTSGNUDNs5avtzXJVNzcflFmrg9eae8Hk8jSGkIDGi2j4yGQGjKDmjvyhvPbUacz8iDAMwD/WqY/CeWcyWsOprvunLjrG6fnCHD0e7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940416; c=relaxed/simple;
	bh=7ylnb5ynWTDR1dFA48S7QJY3cFKZlh8+h3w7rMjeS64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/s1wsa8HX/vM3yOpr0b9KY4tJovNp+bmlRL2YZH019bG+lO/3r375K6Dey3ekAuHUIn6vF28YyrJTakrs32mMZn22I6gETVfLMMd9y7cNEvS7wkgQkbJm7El7+aS/Iio+uyQGMEzaYhtsLa9CW+PDxcvyvt4vRlSKS8WEGR2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htv2usbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5155BC4CEF7;
	Thu, 12 Feb 2026 23:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770940416;
	bh=7ylnb5ynWTDR1dFA48S7QJY3cFKZlh8+h3w7rMjeS64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Htv2usbBoStdACDrjbA/zXR9xkocBdtNNcQ5L79lRDrv0Rx3cLQLhmvwOrSSDgAXv
	 4t/aG2Eo0BfncaZBH+xWtd18RRtWSu1/7O+CwAI2J4EspSsgW2pfMIqiqifqpnJDS4
	 oY3zMJHRPHv4WshFj33munWouGyLJbBbsWN2UIZKUCA/drjl1WBW22ZG6d+TfrGuI5
	 IXZlath0Pfl6YI7eJit9ugK6BeicQNe/0e28TyAGjEu0d1G53eZUpm7D4AGd1/yjYL
	 ob+/SFIuqTQgJgNY38IouC+DOVtg6kvD3TZ0X8Co3lgc1cHdaRmI1dk04utFOhvKo7
	 hjYb93vsik1zw==
Date: Thu, 12 Feb 2026 15:53:35 -0800
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
Message-ID: <202602121552.C2AFE712@keescook>
References: <20260209190605.1564597-1-avagin@google.com>
 <20260209190605.1564597-4-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209190605.1564597-4-avagin@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77066-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CBF3131D5F
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 07:06:04PM +0000, Andrei Vagin wrote:
> The mm->saved_auxv array stores the auxiliary vector, which can be
> modified via prctl(PR_SET_MM_AUXV) or prctl(PR_SET_MM_MAP). Previously,
> accesses to saved_auxv were not synchronized. This was a intentional
> trade-off, as the vector was only used to provide information to
> userspace via /proc/PID/auxv or prctl(PR_GET_AUXV), and consistency
> between the auxv values left to userspace.
> 
> With the introduction of hardware capability (HWCAP) inheritance during
> execve, the kernel now relies on the contents of saved_auxv to configure
> the execution environment of new processes.  An unsynchronized read
> during execve could result in a new process inheriting an inconsistent
> set of capabilities if the parent process updates its auxiliary vector
> concurrently.
> 
> While it is still not strictly required to guarantee the consistency of
> auxv values on the kernel side, doing so is relatively straightforward.
> This change implements synchronization using arg_lock.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/exec.c      |  8 ++++++--
>  fs/proc/base.c | 12 +++++++++---
>  kernel/fork.c  |  7 ++++++-
>  kernel/sys.c   | 29 ++++++++++++++---------------
>  4 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 7401efbe4ba0..d7e3ad8c8051 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1793,6 +1793,7 @@ static int bprm_execve(struct linux_binprm *bprm)
>  
>  static void inherit_hwcap(struct linux_binprm *bprm)
>  {
> +	struct mm_struct *mm = current->mm;
>  	int i, n;
>  
>  #ifdef ELF_HWCAP4
> @@ -1805,10 +1806,12 @@ static void inherit_hwcap(struct linux_binprm *bprm)
>  	n = 1;
>  #endif
>  
> +	spin_lock(&mm->arg_lock);
>  	for (i = 0; n && i < AT_VECTOR_SIZE; i += 2) {
> -		long val = current->mm->saved_auxv[i + 1];
> +		unsigned long type = mm->saved_auxv[i];
> +		unsigned long val = mm->saved_auxv[i + 1];

Ah, I see the signed/unsigned is fixed here. :)

I don't see anything in here that is fast-path, so the locking seems
fine to me.

-- 
Kees Cook

