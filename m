Return-Path: <linux-fsdevel+bounces-75867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MACeHcx0e2mMEgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:55:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF6B131F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F15A301D30B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA5335562;
	Thu, 29 Jan 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4Trdntd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED52868B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698498; cv=none; b=RClRE4pNLQa8jtfnuRlTzmQD2oaQBqY5Jk60bw56aCgrT7WDKCKNoZvGxQj6sNWSJwyM+Oex+zYkXYQKL4YIX9HhOsapnyhHlrjoyZrTWpd5v9oENacy1tB44J/kKsroTqLFnHpA2EVImWQyAKtosTkgQ5d+wct4h87boaPZ21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698498; c=relaxed/simple;
	bh=JwsuFUvcV38W/nzp8OudayMuAd3zQXeogkZP0VuEVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcaE3s1MHAok2NoA+q/lYqvUG7tufzGre7CbVircpfsCNH0gq/ZchC4bb4tgVT6IAKTSv/mL/L4ER531n3MnuLIFB8shhwAo0T4ubj0D+2a+qvQhujykXTHKMbvC+D1A9iniOwsv17JbkvUWEfaLjOnBCSNuANYdaDSLVvfIlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4Trdntd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7D7C4CEF7;
	Thu, 29 Jan 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769698497;
	bh=JwsuFUvcV38W/nzp8OudayMuAd3zQXeogkZP0VuEVFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4TrdntdiiVQWBVL49NTbIB3BKB8DAWixzy5s09/Ws+q/Urdvny3xQ1UGGze9N4dF
	 1ILTogzmoP8nli53bc3mpfhYomvtcxda4/7reX5X0q63CaVUg6CCEtxppw0xIpH5YK
	 /9LAvpG/I1PR4+TPiYcJiZvk9TLDoI3ES9FRxGM9fTxXN9M4+xFwP/VZC4mzFN8p4q
	 jnTtcIqyZT19AhiA5rsKK+m935xPQ5TwUiV6Z8S/nO9RkkPqOu/fuuwSh8vQ1DIMva
	 ijc4vT1w3hR7xicp/T7M11zwIJBVw0jXxrouOpWgPruINCRGy//N3sEK93EJCqk4FJ
	 yQ+pze3YJQsUA==
Date: Thu, 29 Jan 2026 15:54:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Snaipe <me@snai.pe>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
Message-ID: <20260129-hummel-teilweise-43b0ba55723c@brauner>
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
 <20251105-rotwild-wartung-e0c391fe559a@brauner>
 <CACyTCKjojw0M=9NEzTpASd+OhgaPxU4hFRV2c6GEDFLZ8K2bWw@mail.gmail.com>
 <CACyTCKifDxhGBY0S9AYZBCw6S7-mf+0WYv=0VjBq_a+S0sWuiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACyTCKifDxhGBY0S9AYZBCw6S7-mf+0WYv=0VjBq_a+S0sWuiA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75867-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3EF6B131F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 02:39:19PM +0100, Snaipe wrote:
> Hi Christian,
> 
> I have time to look at this again. I'm however unclear on the
> permission model that should be applicable here.
> 
> My overarching motivation is to be able to have a process in a
> user+mount namespace pass file descriptors to another process in a
> different user+mount namespace, which then bind-mounts them. It seems
> to me that the only real checks here are that 1) the file descriptor
> points to a tree that is still mounted and 2) the caller has
> CAP_SYS_ADMIN in the user namespace that owns the mount namespace in
> which the caller operates, and both checks seem to be effective as of
> today.
> 
> It sounds like may_copy_tree should just be changed to this:
> 
> > @@ -2946,18 +2946,21 @@ static inline bool may_copy_tree(const struct path *path)
> >         if (!is_mounted(path->mnt))
> >                 return false;
> >
> > -       return check_anonymous_mnt(mnt);
> > +       return true;
> >  }
> 
> But the above worries me, because I do not think I understand enough
> may_copy_tree to warrant the deletion of check_anonymous_mnt, and the
> reason why the check is this way in the first place.
> 
> Any advice would be appreciated.

I think I might have even left a comment somewhere in the code...
The gist is something like:

diff --git a/fs/namespace.c b/fs/namespace.c
index ad35f8c961ef..e78aff6b3bf7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -961,8 +961,7 @@ static inline bool check_anonymous_mnt(struct mount *mnt)
        if (!is_anon_ns(mnt->mnt_ns))
                return false;

-       seq = mnt->mnt_ns->seq_origin;
-       return !seq || (seq == current->nsproxy->mnt_ns->ns.ns_id);
+       return ns_capable_noaudit(mnt->mnt_ns->user_ns, CAP_SYS_ADMIN);
 }

where we allow creating detached mounts or mounting on top of a detached
mount provided the caller is privileged over the owning userns of the
mount namespace.

But then the may_mount() check would also have to be changed so that a
caller unprivileged in their current mount namespace can still
created/attach detached mounts in anonymous mount namespaces they are
privileged over.

Even the check_mnt() checks should be relaxed for move_mount() so that
you can attach a detached mount in a mount namespace that you have
privilege over. I'd need to see it in patch form though.

