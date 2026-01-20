Return-Path: <linux-fsdevel+bounces-74614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBuVCixFcWlrfwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:29:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0755E0D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BD65746A73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28128413243;
	Tue, 20 Jan 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHnzrn5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952863563F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907432; cv=none; b=a60eJnSn9dyguPpSJkwFPruZJdKGuzKy26KheYEl12F6PNjAjRtii24xDEw9gs/sottSVlAVc40qWDJqK/2MjspINTM17Cc9cAu0JAgOq3dvZHKW6rEZaQkFasnaE8wQwY0Ef4Msr5ywA67WDa+dUoAEAa27a66JSbvFIPPQd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907432; c=relaxed/simple;
	bh=XT6rt1MHSB9VZRa3cWFZlAlUDdAFevN9enpf6JdkMOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyBZyphpqOYhL0HvSmJDtKaxgcNhiaBELPNsVpQq84MDGVJonX76M9G3nLG+HaCMcOmBPFepaPU2nxucbphAJ3UmgaftaE2ofu3D3a4a3NTvagvGtslSFK28IzPjyD5UtRpnc4vkafk5Jpk4mi8y79AdiZDbr1eB8ghOX+zQfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHnzrn5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37DEC19421;
	Tue, 20 Jan 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768907432;
	bh=XT6rt1MHSB9VZRa3cWFZlAlUDdAFevN9enpf6JdkMOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHnzrn5hRGZrDthm9n0wXgl6gV8hJwo3t+pLKMapDIvlgLehStie7fTEVLLWb811g
	 DylRw78AGuZD2syRpwC92J9UCcaT1AX1MPObOBEHz6anFsLoXg069b5YbLg/8iu1Cn
	 zEvwPBR1KMw5f6KauIgv5J8EJoZsJDopc2NHnT5wN2SgnzlLEETOw6f1nIbjt3p0Um
	 U8IGUGa3vsPXah99tj/Dpq898Q5yXOQNg+3UsvZqD6gWg2+nEzj7NJyX3X/KeAj7Hv
	 6hlmKS/RxmI8MG8vaK+QFZ52pNtSm/zMo6/C8JUlVfHi1ScLO5Ob16YQEWP9ASY+lh
	 G9lTXVgR+NlxQ==
Date: Tue, 20 Jan 2026 12:10:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] pidfs: convert rb-tree to rhashtable
Message-ID: <20260120-synergie-unlauter-d59700c86e57@brauner>
References: <20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org>
 <4v7ozybnizhbwyvbla7gbjwfixtsbme4qirndlo3x5buhkgluv@vxdkauy56mvv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4v7ozybnizhbwyvbla7gbjwfixtsbme4qirndlo3x5buhkgluv@vxdkauy56mvv>
X-Spamd-Result: default: False [3.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[34];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74614-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CC0755E0D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:47:03AM +0100, Jan Kara wrote:
> On Mon 19-01-26 16:05:54, Christian Brauner wrote:
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
> > The hashtable removal is deferred to the RCU callback to ensure safe
> > concurrent lookups.
> 
> This doesn't look correct to me. See below in the code for details...
> 
> > To guard against accidently opening an already
> > reaped task pidfs_ino_get_pid() uses additional checks beyond pid_vnr().
> > If pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd
> > or it already went through pidfs_exit() aka the process as already
> > reaped. If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out
> > whether the task has exited. Switch to refcount_inc_not_zero() to ensure
> > that the pid isn't about to be freed.
> > 
> > This slightly changes visibility semantics: pidfd creation is denied
> > after pidfs_exit() runs, which is just before the pid number is removed
> > from the via free_pid(). That should not be an issue though.
> > 
> > I haven't perfed this and I would like to make this Mateusz problem...
> 
> ;-) I guess this note means you want to have some perf data justifying this
> change. I agree that when replacing data structure like this we should have
> some measurements showing that the expected improvements indeed translate
> to a real improvements as well. It has happened to me more than once that
> a theoretical improvement didn't really work out in practice...

Moving this logic out of pidmap_lock is worth it if it means we
can stop dropping an reacquiring it.

Note that this is very much RFC so I don't expect it to work as is.
> > +static int pidfs_ino_ht_cmp(struct rhashtable_compare_arg *arg, const void *pidp)
> > +{
> > +	const u64 *ino = arg->key;
> > +	const struct pid *pid = pidp;
> > +
> > +	return pid->ino != *ino;
> > +}
> 
> I don't think this comparison function is really needed. rhashtable
> provides its own comparison function which is good enough for simple
> fixed-length keys (rhashtable_compare() is used if .obj_cmpfn is not
> provided).

Ah, thanks!

> > +	/*
> > +	 * If PIDFS_ATTR_BIT_EXIT is set the task has exited and we
> > +	 * should not allow new file handle lookups.
> > +	 */
> > +	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
> > +		return NULL;
> > +
> > +	if (!refcount_inc_not_zero(&pid->count))
> 
> If this ever sees zero pid->count we have a problem because it means we are
> reading freed memory, aren't we? I think RCU must be protecting from the
> last reference of struct pid being dropped and struct pid getting freed...
> 
> > +		return NULL;
> > +
> > +	return pid;
> >  }
> >  
> >  static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> ...
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index ad4400a9f15f..7da2c3e8f79c 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> ...
> > @@ -106,6 +104,7 @@ EXPORT_SYMBOL_GPL(put_pid);
> >  static void delayed_put_pid(struct rcu_head *rhp)
> >  {
> >  	struct pid *pid = container_of(rhp, struct pid, rcu);
> > +	pidfs_remove_pid(pid);
> >  	put_pid(pid);
> >  }
> >  
> > @@ -141,7 +140,6 @@ void free_pid(struct pid *pid)
> >  
> >  		idr_remove(&ns->idr, upid->nr);
> >  	}
> > -	pidfs_remove_pid(pid);
> >  	spin_unlock(&pidmap_lock);
> >  
> >  	call_rcu(&pid->rcu, delayed_put_pid);
> 
> I don't understand this. If you remove pid from the rhashtable after the
> rcu period expires, then there can be rcu readers of rhashtable accessing
> the freed object. So IMHO you need to keep the call to pidfs_remove_pid()
> before call_rcu().

Yes, you're absolutely right.

> 
> > @@ -315,7 +313,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
> >  	retval = -ENOMEM;
> >  	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
> >  		goto out_free;
> > -	pidfs_add_pid(pid);
> > +	pidfs_prepare_pid(pid);
> > +	spin_unlock(&pidmap_lock);
> > +
> > +	retval = pidfs_add_pid(pid);
> > +	if (retval)
> > +		goto out_free_idr;
> > +
> > +	spin_lock(&pidmap_lock);
> 
> The PIDNS_ADDING logic now looks suspicious to me. With this change you can
> check for PIDNS_ADDING here, then have another thread execute
> disable_pid_allocation() and then still add new pid to the ns here so
> AFAICT zap_pid_ns_processes() can miss the newly added entry? I'm sorry if
> I'm missing something, I don't really deeply understand this code.

The new version doesn't drop the lock at all anymore.

