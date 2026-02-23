Return-Path: <linux-fsdevel+bounces-78011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INryNa/UnGkJLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:29:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94717E58E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844A6303790F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01537AA88;
	Mon, 23 Feb 2026 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0AE6S8S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAC36F427;
	Mon, 23 Feb 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885740; cv=none; b=ij2CVRfNEfnD17aHRavgaZPzzbPAntkw0KSn0laa4anRXw9UOXCOqCsAD4PJL4fAzpvbAI0iwOR44XbBm8mS+6KBXPLRcf5PldZKZMj1hk/n4JxY/KaiviX/yVIk8km+bb68QQBHpZcM3YKLmd6MLbAJa93+F5xbksGoRI4iDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885740; c=relaxed/simple;
	bh=9rMeHiSNAtJk2NgmJptISn2xhvOOSYJ3+ZDMUHV0gRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr9EQtypLUkzWzCxi07n0I8PzePYQKM46u7bktowUuF4r1T4eAMqQCtqZnvnvzLmFrB7En0pDVZXAI0kbRObwqmX+1lHO88pdnEvXuw8OxvnXKGvfh3PUIUMAT8GLPsNr+oZZTqK9ySqzb8YtOR5rvXmnM7UnyxpDskXYXA1zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0AE6S8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79C3C116C6;
	Mon, 23 Feb 2026 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885739;
	bh=9rMeHiSNAtJk2NgmJptISn2xhvOOSYJ3+ZDMUHV0gRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0AE6S8SLcePt2dotW2vBCvk7LcxEiOCdweEhNwBS2jfdGn8FCo0Tm20b43MsUoIN
	 I1oZIH17J97MQ5hINoxSpHoirGgVXyeQhgB+tRkM22EjBb+xYksPnlENl/TYp4ky7e
	 MuRamCV4itnPJSpEPDB1OyTKQrlOpQMUCWoRrMI+GgNvaNMUOK05h01Iwq8I7kHpWD
	 8O55s2Lo5H+vcux4HozO0MKos86b8AFw0oNDkoMRQbIIWtDmHDge+kGfi2YzspBNOZ
	 wjQ/l4CZW/pUscPF+mLtcdQ0OlwrFuoYTpdj+v4iMicAHx16ZlzMg/nKXw8CNiNQdC
	 t+EnzsBT0kK5w==
Date: Mon, 23 Feb 2026 14:28:59 -0800
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@gmail.com>
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
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH 0/4 v4] exec: inherit HWCAPs from the parent process
Message-ID: <202602231428.CAF9D1B913@keescook>
References: <20260217180108.1420024-1-avagin@google.com>
 <CANaxB-wNJWhyM7JUKT3y0Wp73=+8XZRnSkdudxqDwEo2FaJpwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-wNJWhyM7JUKT3y0Wp73=+8XZRnSkdudxqDwEo2FaJpwQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78011-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B94717E58E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:29:00AM -0800, Andrei Vagin wrote:
> On Tue, Feb 17, 2026 at 10:01 AM Andrei Vagin <avagin@google.com> wrote:
> >
> > This patch series introduces a mechanism to inherit hardware capabilities
> > (AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
> > modified via prctl.
> >
> > To support C/R operations (snapshots, live migration) in heterogeneous
> > clusters, we must ensure that processes utilize CPU features available
> > on all potential target nodes. To solve this, we need to advertise a
> > common feature set across the cluster.
> >
> > Initially, a cgroup-based approach was considered, but it was decided
> > that inheriting HWCAPs from a parent process that has set its own
> > auxiliary vector via prctl is a simpler and more flexible solution.
> >
> > This implementation adds a new mm flag MMF_USER_HWCAP, which is set when the
> > auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve() is
> > called, if the current process has MMF_USER_HWCAP set, the HWCAP values are
> > extracted from the current auxiliary vector and inherited by the new process.
> >
> > The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
> > in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.
> >
> > The second patch implements the core inheritance logic in execve().
> >
> > The third patch adds a selftest to verify that HWCAPs are correctly
> > inherited across execve().
> >
> > v4: minor fixes based on feedback from the previous version.
> 
> Kees,
> 
> I think it is ready to be merged. Let me know if you have any other
> comments/concerns/questions.

Yeah, I think it's looking good. I'll land this in for-next/execve after
rc2 (a week from now).

Thanks!

-- 
Kees Cook

