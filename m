Return-Path: <linux-fsdevel+bounces-23285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D255092A441
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318C3B21A26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB13139568;
	Mon,  8 Jul 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OO76dY1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225227713
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447366; cv=none; b=aFGZ0v6vSZq8pV9taKUd8xs7FWDNu0IfU5RiIsf+gOipCMRqj4nfnub4p6piwgk1NWXV/2rfEz77mdWFEyztbuHTBcGivP6HnJqAcbyf8PqHpm9j3pgs289M6Q13RYwL1IPq/7+6w3qjonyyzcToxgN9Mzh/V4dbuBKOTVqM4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447366; c=relaxed/simple;
	bh=3ZL+UxfHVTnQCW3P0TgjacZwLOPmj/zWG4mbdfo03w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLcQvvaDFDkrMTB2qgj0cqvJAmNkEdAkw0Vr0Ou03RDLyhxC021EaqtFrETo3XYWDZauaupNHvhV62Lr7vbQ5WSs5FCJi67BJEGM/QonLFtdDdCyufEAL7ULdu6CLw05KXeYf9o6OnM26pNEmCunva9R6DmfLlA+7V2K4vQZvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OO76dY1X; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHm671nD6zNXj;
	Mon,  8 Jul 2024 16:02:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720447359;
	bh=A84/Z2GsiV0zhoFzsTRv4BZHSh1D21rJmnJ84FxKGj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OO76dY1Xr79Tn2Ly+t1mUU/av2s/poE8AQFJu8y15CVae4nLKb5cW4zTZ9D9f2O7S
	 65+MiPdKYNdQP6r47OQRli2g+E08IvJt6CcEwmth+kFmAWo6MfrEjXeuyJSiULUiz6
	 DmGsYpnSS3Y0tuIO7I564spr3AmprAmFe6X6JykE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHm65438NzlH8;
	Mon,  8 Jul 2024 16:02:37 +0200 (CEST)
Date: Mon, 8 Jul 2024 16:02:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240708.hohNgieja0av@digikod.net>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <202406271019.BF8123A5@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202406271019.BF8123A5@keescook>
X-Infomaniak-Routing: alpha

On Thu, Jun 27, 2024 at 11:12:43AM -0700, Kees Cook wrote:
> On Thu, Jun 27, 2024 at 03:34:41PM +0200, Mickaël Salaün wrote:
> > I didn't find specific issues with Landlock's code except the extra
> > check in hook_inode_free_security().  It looks like inode->i_security is
> > a dangling pointer, leading to UAF.
> > 
> > Reading security_inode_free() comments, two things looks weird to me:
> > > /**
> > >  * security_inode_free() - Free an inode's LSM blob
> > >  * @inode: the inode
> > >  *
> > >  * Deallocate the inode security structure and set @inode->i_security to NULL.
> > 
> > I don't see where i_security is set to NULL.
> 
> Yeah, I don't either...
> 
> > >  */
> > > void security_inode_free(struct inode *inode)
> > > {
> > 
> > Shouldn't we add this check here?
> > if (!inode->i_security)
> > 	return;
> 
> Probably, yes. The LSMs that check for NULL i_security in the free hook
> all do so right at the beginning...
> 
> > 
> > > 	call_void_hook(inode_free_security, inode);
> > > 	/*
> > > 	 * The inode may still be referenced in a path walk and
> > > 	 * a call to security_inode_permission() can be made
> > > 	 * after inode_free_security() is called. Ideally, the VFS
> > > 	 * wouldn't do this, but fixing that is a much harder
> > > 	 * job. For now, simply free the i_security via RCU, and
> > > 	 * leave the current inode->i_security pointer intact.
> > > 	 * The inode will be freed after the RCU grace period too.
> > 
> > It's not clear to me why this should be safe if an LSM try to use the
> > partially-freed blob after the hook calls and before the actual blob
> > free.
> 
> Yeah, it's not clear to me what the expected lifetime is here. How is
> inode_permission() being called if all inode reference counts are 0? It
> does seem intentional, though.
> 
> The RCU logic was introduced in commit 3dc91d4338d6 ("SELinux: Fix possible
> NULL pointer dereference in selinux_inode_permission()"), with much
> discussion:
> https://lore.kernel.org/lkml/20140109101932.0508dec7@gandalf.local.home/
> (This commit seems to remove setting "i_security = NULL", though, which
> the comment implies is intended, but then it also seems to depend on
> finding a NULL?)
> 
> LSMs using i_security are:
> 
> security/bpf/hooks.c:   .lbs_inode = sizeof(struct bpf_storage_blob),
> security/integrity/evm/evm_main.c:      .lbs_inode = sizeof(struct evm_iint_cache),
> security/integrity/ima/ima_main.c:      .lbs_inode = sizeof(struct ima_iint_cache *),
> security/landlock/setup.c:      .lbs_inode = sizeof(struct landlock_inode_security),
> security/selinux/hooks.c:       .lbs_inode = sizeof(struct inode_security_struct),
> security/smack/smack_lsm.c:     .lbs_inode = sizeof(struct inode_smack),
> 
> SELinux is still checking for NULL. See selinux_inode() and
> selinux_inode_free_security(), as do bpf_inode() and
> bpf_inode_storage_free(). evm and ima also check for NULL.
> 
> landlock_inode() does not, though.
> 
> Smack doesn't hook the free, but it should still check for NULL, and it's not.
> 
> So I think this needs fixing in Landlock and Smack.
> 
> I kind of think that the LSM infrastructure needs to provide a common
> helper for the "access the blob" action, as we've got it repeated in
> each LSM, and we have 2 implementations that are missing NULL checks...
> 
> > 
> > > 	 */
> > > 	if (inode->i_security)
> > > 		call_rcu((struct rcu_head *)inode->i_security,
> > > 			 inode_free_by_rcu);
> > 
> > And then:
> > inode->i_security = NULL;
> > 
> > But why call_rcu()?  i_security is not protected by RCU barriers.
> 
> I assume it's because security_inode_free() via __destroy_inode() via
> destroy_inode() via evict() via iput_final() via iput() may be running
> in interrupt context?
> 
> But I still don't see where i_security gets set to NULL. This won't fix
> the permissions hook races for Landlock and Smack, but should make
> lifetime a bit more clear?

It should not change anything.  I don't see how inode->i_security can be
NULL and when such an inode can be passed to an LSM hook.

> 
> 
> diff --git a/security/security.c b/security/security.c
> index 9c3fb2f60e2a..a8658ebcaf0c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1613,7 +1613,8 @@ static void inode_free_by_rcu(struct rcu_head *head)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -	call_void_hook(inode_free_security, inode);
> +	struct rcu_head *inode_blob = inode->i_security;
> +
>  	/*
>  	 * The inode may still be referenced in a path walk and
>  	 * a call to security_inode_permission() can be made
> @@ -1623,9 +1624,11 @@ void security_inode_free(struct inode *inode)
>  	 * leave the current inode->i_security pointer intact.
>  	 * The inode will be freed after the RCU grace period too.
>  	 */
> -	if (inode->i_security)
> -		call_rcu((struct rcu_head *)inode->i_security,
> -			 inode_free_by_rcu);
> +	if (inode_blob) {
> +		call_void_hook(inode_free_security, inode);
> +		inode->i_security = NULL;

If a path walk is ongoing, couldn't this lead to an LSM's security check
bypass?  Shouldn't we call all the inode_free_security() hooks in
inode_free_by_rcu()?  That would mean to reserve an rcu_head and then
probably use inode->i_rcu instead.

I think your patch is correct though.  Could you please send a full
patch?

> +		call_rcu(inode_blob, inode_free_by_rcu);
> +	}
>  }

