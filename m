Return-Path: <linux-fsdevel+bounces-75007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKwSJl78cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:30:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38D65469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 007046811FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C207310635;
	Thu, 22 Jan 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyOCHkrt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595A2222C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077095; cv=none; b=rTlg9+KZVYFRAqCzlguygLW8k/JAz8uFpfbuOrt3HsMlrJW25o8F0zJ5bb9/Im7HKowsMGDMnOQyNsYJ7wMbpjCHAbheOfrrkd9IFjZ9LgkZR9ytQDNyT6GBVO5H+NWGv5txIxCns5BK9zVeRctGJYK7AWa0jZ+25iykEtE6qK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077095; c=relaxed/simple;
	bh=9EIjkzJNA9E4VUPDTyu9hd8T5/zhI8edzp0B+c2y9jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyXQC6rn+4vMPy/3BGaYB4PWlVJIIcN21WhkcLSCO6/iQdMz1rpX4V7cZJJ4vRP6WmReLlyDxOafRyKYncr7bEdd1IoT7rteozeazUmEeIxcBEK65IPJrUBr3DBcy0PBECx+v5Gfmapv/Oswxv6K81oa6dtqcyMOCvXoNZ1NP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyOCHkrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F2EC116C6;
	Thu, 22 Jan 2026 10:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769077095;
	bh=9EIjkzJNA9E4VUPDTyu9hd8T5/zhI8edzp0B+c2y9jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyOCHkrtuz4ueSm5GPODxY6RTMZKIX0odUUuSvQV6ia30erM8gPotfwowOcRaY3LV
	 5l8zfyKbpHjw9LtdQVzgOT4SqqUFo10tOiV94PIAdBtYGzV1fyO2nYY1mQ/q1n0ozW
	 SwqNTIVpLy2oilpzohDdDtzhyXYo4mkVZgHJpPQo54QHgA81L4MkOTHdWZs/jmbknK
	 UeORy1uEGfhwvzJYaGORZnoqAGZ4F6wXw5KURAMmwPdZsAjWYRCaw0sUA0XLf0JBHD
	 /Maly3zGj28NVYHtA5Y7jhTfcpmdNxpg346IIHbcmOl9adYhV9QCjUFjrWTnRwYz4W
	 ibRVW6bCo1QhQ==
Date: Thu, 22 Jan 2026 11:18:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
Message-ID: <20260122-allrad-zirkel-9d519a7f12f3@brauner>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <6yefrqagwzxnyauuidtvzsaejowzrkh5u2cjrjwmn5ulbt27by@fy5fezgl4tsq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6yefrqagwzxnyauuidtvzsaejowzrkh5u2cjrjwmn5ulbt27by@fy5fezgl4tsq>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75007-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 3F38D65469
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 11:59:11AM +0100, Jan Kara wrote:
> On Tue 20-01-26 15:52:35, Christian Brauner wrote:
> > Mateusz reported performance penalties [1] during task creation because
> > pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
> > rhashtable to have separate fine-grained locking and to decouple from
> > pidmap_lock moving all heavy manipulations outside of it.
> > 
> > Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
> > protection to an rhashtable. This removes the global pidmap_lock
> > contention from pidfs_ino_get_pid() lookups and allows the hashtable
> > insert to happen outside the pidmap_lock.
> > 
> > pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
> > initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
> > inserts pid into rhashtable and is called outside pidmap_lock. Insertion
> > into the rhashtable can fail and memory allocation may happen so we need
> > to drop the spinlock.
> > 
> > To guard against accidently opening an already reaped task
> > pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
> > pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
> > it already went through pidfs_exit() aka the process as already reaped.
> > If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
> > the task has exited.
> > 
> > This slightly changes visibility semantics: pidfd creation is denied
> > after pidfs_exit() runs, which is just before the pid number is removed
> > from the via free_pid(). That should not be an issue though.
> > 
> > Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Looks very nice! Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I have just one question about the new PIDFS_ATTR_BIT_EXIT check.  AFAIU it
> protects from grabbing struct pid references for pids that are dying. But
> we can also call free_pid() from places like ksys_setsid() where
> PIDFS_ATTR_BIT_EXIT is not set. So this check only seems as a convenience
> rather than some hard guarantee, am I right?

Excellent question!

So the way this whole freeing works is weird. So when a task becomes a
session leader or process group leader __change_pid() detaches the task
from its old session/process group leader.

The old session leader/process group leader pid only ends up with
free_pid() called on it if it has already been reaped, i.e.,
pid_has_task() returns NULL.

But if the task has already been reaped then it will have already passed
pidfs_exit() and so the exit bit will be set.

So this only handles already dead pids.

