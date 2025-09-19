Return-Path: <linux-fsdevel+bounces-62206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2925B88560
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66855673A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A40E305062;
	Fri, 19 Sep 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfJmdpWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C8303CB6;
	Fri, 19 Sep 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269320; cv=none; b=jBfu4uSjPAbLXxx6aenjUc4yrjVU34x9GotrDKa6GGHiFhg4gshZgV1WXdKmdvLMCl51TkKAsKBMkoBT88ydEmZ0nPDLQZlC9P2gP1zhOyTJ77wyNWaxQwcDlViXph63C1tIb22dEcoLDl3pTzWDV6u/htVyEObvvBG5thCG3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269320; c=relaxed/simple;
	bh=309VdB/dlRAmKQDRXcKVomPzNz0G9kwLcBfQswZ/fLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5tYByDbRyU0D9C8P5CbyCLbfH2UOqT11Wgv1cKinEzvoERDY8y4VBpR+NZQ3DsCB9M085zE8EEFxiA+Oyc2rBGud1Pt/r2ji3JslnkLlskG3S1RmmHSBAIjl5yGcygyknzgowcsZocE7xJ79akFxrUoqvJV8JkME3QqpnhPHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfJmdpWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F83BC4CEF0;
	Fri, 19 Sep 2025 08:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758269319;
	bh=309VdB/dlRAmKQDRXcKVomPzNz0G9kwLcBfQswZ/fLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfJmdpWVO/i0Klh9wFxFYR26vN7harEo2PL1CzpfY0MW/QOYu5TNtHj4fHUGrdiXm
	 NXHUCIGrpYQUbzh36uDRRDfGBoAO6v7Y7gLfk7XRir14+4ff0o58YVgw2kAhncAGn7
	 8lTH15Q0++/IDz7hrMqcEcrVdhZhSKee0u3nPztEXLxh/HehBe+HsKalu8PZ46692p
	 1HV6Pi/tYlil/uhxU07QgNVX+ns8ojOFM2QEHeB9qvx5UogRprwMKoQ4ZKbNW2Few9
	 Se0nHjZJpLDzTfRPl6ywDbryPtqzzPYq9VWvu+69wfLgbkZVC0NAzMWwNHJd531HLW
	 7mlv/BnmXX0nA==
Date: Fri, 19 Sep 2025 10:08:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 7/9] net: centralize ns_common initialization
Message-ID: <20250919-fanatiker-ethik-7a9bb32ee334@brauner>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-7-1b3bda8ef8f2@kernel.org>
 <kiyr4pnrw2a2oeoc3lavj73glvdg5llsfz2txfnn56bxmytfgw@o6weansm3iyi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kiyr4pnrw2a2oeoc3lavj73glvdg5llsfz2txfnn56bxmytfgw@o6weansm3iyi>

On Thu, Sep 18, 2025 at 11:42:38AM +0200, Jan Kara wrote:
> On Wed 17-09-25 12:28:06, Christian Brauner wrote:
> > Centralize ns_common initialization.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  net/core/net_namespace.c | 23 +++--------------------
> >  1 file changed, 3 insertions(+), 20 deletions(-)
> > 
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index a57b3cda8dbc..897f4927df9e 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -409,7 +409,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
> >  	ns_ops = NULL;
> >  #endif
> >  
> > -	ret = ns_common_init(&net->ns, ns_ops, false);
> > +	ret = ns_common_init(&net->ns, ns_ops, true);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -597,6 +597,7 @@ struct net *copy_net_ns(unsigned long flags,
> >  		net_passive_dec(net);
> >  dec_ucounts:
> >  		dec_net_namespaces(ucounts);
> > +		ns_free_inum(&net->ns);
> 
> This looks like a wrong place to put it? dec_ucounts also gets called when we
> failed to create 'net' and thus net == NULL. 
> 
> >  		return ERR_PTR(rv);
> >  	}
> >  	return net;
> > @@ -718,6 +719,7 @@ static void cleanup_net(struct work_struct *work)
> >  #endif
> >  		put_user_ns(net->user_ns);
> >  		net_passive_dec(net);
> > +		ns_free_inum(&net->ns);
> 
> The calling of ns_free_inum() after we've dropped our reference
> (net_passive_dec()) looks suspicious. Given how 'net' freeing works I don't
> think this can lead to actual UAF issues but it is in my opinion a bad
> coding pattern and for no good reason AFAICT.

All good points. I can't say I'm fond of the complexity in this specific
instance in general.

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 897f4927df9e..9df236811454 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -590,6 +590,7 @@ struct net *copy_net_ns(unsigned long flags,

        if (rv < 0) {
 put_userns:
+               ns_free_inum(&net->ns);
 #ifdef CONFIG_KEYS
                key_remove_domain(net->key_domain);
 #endif
@@ -597,7 +598,6 @@ struct net *copy_net_ns(unsigned long flags,
                net_passive_dec(net);
 dec_ucounts:
                dec_net_namespaces(ucounts);
-               ns_free_inum(&net->ns);
                return ERR_PTR(rv);
        }
        return net;
@@ -713,13 +713,13 @@ static void cleanup_net(struct work_struct *work)
        /* Finally it is safe to free my network namespace structure */
        list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
                list_del_init(&net->exit_list);
+               ns_free_inum(&net->ns);
                dec_net_namespaces(net->ucounts);
 #ifdef CONFIG_KEYS
                key_remove_domain(net->key_domain);
 #endif
                put_user_ns(net->user_ns);
                net_passive_dec(net);
-               ns_free_inum(&net->ns);
        }
        WRITE_ONCE(cleanup_net_task, NULL);
 }

