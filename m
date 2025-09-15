Return-Path: <linux-fsdevel+bounces-61407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A275B57DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D37170B82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1072327A19;
	Mon, 15 Sep 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO765AHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AD1F91D6;
	Mon, 15 Sep 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944066; cv=none; b=o9T2RnGZpBAoEIwtLpGQWNzY9UOOf0XxVBzMT5Iw9wsA33o9uBqqHl272tQc7WnBl1cF/GP0jr8aNJigqAGssYp4WK5gAZHLe2f/wkhX7jDaHbe+6f0gcHpGdnvNnGBi6V0NFfDOZYkGvCriipykczGAdP09EciNO8+1ohHbiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944066; c=relaxed/simple;
	bh=EKRXyuPv+Jg17gknHWC1AaM5Wujt+D7ZjacaXEH27Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuCE3Kc++mbIzr5yZLUKzbyByh03gAZlEWZ6CKSSik6+wKtTN9oA3INJJsi6RzqbxUFKW6ULRTk7sWmj+sSggIejO+9cVT50PIHv/YxoShtBq7BPQgvEPeQBh1V/1obGDi27fRs5u4NXLUNDJcKWRB94epipLrxEPVAhlS+egNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO765AHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C57FC4CEF1;
	Mon, 15 Sep 2025 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944065;
	bh=EKRXyuPv+Jg17gknHWC1AaM5Wujt+D7ZjacaXEH27Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pO765AHkxwjpF2BGA2EOjB/HkqFxpy/yNq40f1smNEPE3GYRoMafZJ9/UmWTCyf6i
	 jF1Ee3IyvtYp+a6r+axUA2YwqL0cfE61wsa2Fx0I82/EGm6AiMF7Vt5GPnXtKDMQW5
	 o9zShRV5EW6lSsF+Q1o+6q2llTEeDOkUBcdWXKLYgW+vDiO2pqPFfgRgx68ZSAWnDd
	 YYXs1VCTdjwRuHOq1J82uJdwnztZLyTdbaniACV6Pmg6MEcfd9cWhdPN3VwtQRIrLw
	 Qf7qSZnMs7YYRRVGMNqVQJslqZ9uS7vpKrHGplZfCMm+cTe1b2G48fSF3jRipXuUMQ
	 G9LbRAHLfgb/g==
Date: Mon, 15 Sep 2025 15:47:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 21/33] net: support ns lookup
Message-ID: <20250915-bildverarbeitung-unbeobachtet-80e2f149c434@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-21-1a247645cef5@kernel.org>
 <qdxj5g326tpu3sczuhveknkvcsn6a3rngfm6plmwmbq22oof6e@qcapgrdp4n3x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qdxj5g326tpu3sczuhveknkvcsn6a3rngfm6plmwmbq22oof6e@qcapgrdp4n3x>

On Mon, Sep 15, 2025 at 02:02:45PM +0200, Jan Kara wrote:
> On Fri 12-09-25 13:52:44, Christian Brauner wrote:
> > Support the generic ns lookup infrastructure to support file handles for
> > namespaces.
> > 
> > The network namespace has a separate list with different lifetime rules
> > which we can just leave in tact. We have a similar concept for mount
> > namespaces as well where it is on two differenet lists for different
> > purposes.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Just some nits below. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> > index 025a7574b275..42075748dff1 100644
> > --- a/include/net/net_namespace.h
> > +++ b/include/net/net_namespace.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/list.h>
> >  #include <linux/sysctl.h>
> >  #include <linux/uidgid.h>
> > +#include <linux/nstree.h>
> >  
> >  #include <net/flow.h>
> >  #include <net/netns/core.h>
> 
> Why this include?

Dropped.

> 
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index 5fb7bd8ac45a..169ec22c4758 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/uidgid.h>
> >  #include <linux/proc_fs.h>
> > +#include <linux/nstree.h>
> >  
> >  #include <net/aligned_data.h>
> >  #include <net/sock.h>
> > @@ -445,7 +446,7 @@ static __net_init int setup_net(struct net *net)
> >  	LIST_HEAD(net_exit_list);
> >  	int error = 0;
> >  
> > -	net->net_cookie = atomic64_inc_return(&net_aligned_data.net_cookie);
> > +	net->net_cookie = ns_tree_gen_id(&net->ns);
> 
> net_cookie seems to be unused now and can be deleted?

Yes. I planned to do this in a follow-up patch because it'll create some
churn in net/. I'd rather get that in early after the next mw.

