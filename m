Return-Path: <linux-fsdevel+bounces-77798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEmOE7V+mGlMJQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:33:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C77168E9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89E06307B206
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246AB342C8B;
	Fri, 20 Feb 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXNhPjGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242A20D4FC;
	Fri, 20 Feb 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601571; cv=none; b=oXMinaPxJoREmTS2+L2Sv7nfo94deKzMf/jgdMb3jp6FfQFTJbVC7BK0AGLSrdElYXRjrt04kl7CD4YXsjVir32/TEdF9hbCj1lo8xSMBHdtmc37i4g5PXIMFtTRSQOb2sS9f5l3GoUQ+lNsxnY/JrkbOQlZDtQXWeAHsTBx7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601571; c=relaxed/simple;
	bh=fDGKx15Hxqu+IAN7+rfHjM/yq650i7Sc39dis0PLF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovF74aNiiPSaa4IHMjhQqwyBf0RaxJM9QYADPxmEW1Zr/iJKApB/NfJDBp23a6hxAyvaCWyvl2m7zbZkylVx71bZr0+Oyk3vi9gn7YJqwXx8mUPZ+eSlSzMxLtl6vX5m55/4YaXPO7AJdM0Vl9zBbIkZ7pBRX1cNYhnOE4GheWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXNhPjGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB33C116D0;
	Fri, 20 Feb 2026 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601571;
	bh=fDGKx15Hxqu+IAN7+rfHjM/yq650i7Sc39dis0PLF/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXNhPjGQ5QYdl2bepA45yrtfCNKVLOylDAjxOF/AapIKqvwIuSWKCdEnAq/ROa/vL
	 /vAOR/A2XkzziqUbY0+z5TKG5+JuI6+1iEzQj7RPwwmkYsx3ZkExH2hLM1/tD/Opyj
	 uc9hwq131dSEDzwcPWTODZ9ToJuWyq2eVltFZ2zczZh5yB3+5zYb+iYTBWilhChA/I
	 cI78u1BZB8rKMcUhhawofYf8MYo0c0b72ZPffmYlGaXjZC4OcXNKiMfQ/3yQDkcSkh
	 eALixBppGk8Z5U+FBqU7mq5zsnvO/j40psyEG2XLkL4+ejYhXzDpWfXoJ02gSxvsry
	 Dmd1AA7UlewNA==
Date: Fri, 20 Feb 2026 05:32:50 -1000
From: Tejun Heo <tj@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
Message-ID: <aZh-orwoaeAh52Bf@slm.duckdns.org>
References: <20260220055449.3073-1-tjmercier@google.com>
 <20260220055449.3073-3-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220055449.3073-3-tjmercier@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77798-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: A1C77168E9F
X-Rspamd-Action: no action

Hello,

On Thu, Feb 19, 2026 at 09:54:47PM -0800, T.J. Mercier wrote:
> Currently some kernfs files (e.g. cgroup.events, memory.events) support
> inotify watches for IN_MODIFY, but unlike with regular filesystems, they
> do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> removed. This means inotify watches persist after file deletion until
> the process exits and the inotify file descriptor is cleaned up, or
> until inotify_rm_watch is called manually.
> 
> This creates a problem for processes monitoring cgroups. For example, a
> service monitoring memory.events for memory.high breaches needs to know
> when a cgroup is removed to clean up its state. Where it's known that a
> cgroup is removed when all processes die, without IN_DELETE_SELF the
> service must resort to inefficient workarounds such as:
>   1) Periodically scanning procfs to detect process death (wastes CPU
>      and is susceptible to PID reuse).
>   2) Holding a pidfd for every monitored cgroup (can exhaust file
>      descriptors).
> 
> This patch enables IN_DELETE_SELF and IN_IGNORED events for kernfs files
> and directories by clearing inode i_nlink values during removal. This
> allows VFS to make the necessary fsnotify calls so that userspace
> receives the inotify events.
> 
> As a result, applications can rely on a single existing watch on a file
> of interest (e.g. memory.events) to receive notifications for both
> modifications and the eventual removal of the file, as well as automatic
> watch descriptor cleanup, simplifying userspace logic and improving
> efficiency.
> 
> There is gap in this implementation for certain file removals due their
> unique nature in kernfs. Directory removals that trigger file removals
> occur through vfs_rmdir, which shrinks the dcache and emits fsnotify
> events after the rmdir operation; there is no issue here. However kernfs
> writes to particular files (e.g. cgroup.subtree_control) can also cause
> file removal, but vfs_write does not attempt to emit fsnotify events
> after the write operation, even if i_nlink counts are 0. As a usecase
> for monitoring this category of file removals is not known, they are
> left without having IN_DELETE or IN_DELETE_SELF events generated.

Adding a comment with the above content would probably be useful. It also
might be worthwhile to note that fanotify recursive monitoring wouldn't work
reliably as cgroups can go away while inodes are not attached.

> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

