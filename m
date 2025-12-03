Return-Path: <linux-fsdevel+bounces-70585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF8CA1305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 19:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C59CB30014C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB030E0FA;
	Wed,  3 Dec 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZqcQOF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C0313539;
	Wed,  3 Dec 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788153; cv=none; b=uCJDSK6nB5aSPfCj5N2w1Fxe1kyEhFfz6ENiEb4IE41xX8Gmpj750AMp23hxiWcwL48f5TxnzfEPqmfbZdgqlPtmYmbr8YndeYa+1vW725B9zZI6SlENfB/Lta69Y2vMa3dNUH0vstCn/L6rhyPFnJcWiqXZ6mGaL3mUloDoLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788153; c=relaxed/simple;
	bh=jQMS3NQzr+p2aXh6XyCiJ8G2wYYZvv1umtIBcDq3BaA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GrF64hAjvT/114rkL5QDQqoSNOfg2bK/+AXv40dCIjaxkju/aQ5Ap1AuRuHCfTppL6Cx7mdLYHIa+aJKOvmmzRgR+YWL8zOrdlDN/rUyoFjbZbdV91DXbRGwGWrpWGYa46Qkcn5BuLVkpf8Y87HQzSJTTPe4XP9B9ReL9ydPe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZqcQOF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2757FC116B1;
	Wed,  3 Dec 2025 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764788152;
	bh=jQMS3NQzr+p2aXh6XyCiJ8G2wYYZvv1umtIBcDq3BaA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TZqcQOF+I6aRxKujGed3jAp4VIRfphCan4hw2fSnCB1ZhQvJ4lpSEqIWqNo+CUp9k
	 jbztNAvgH9K7nn7KgewgQHNI08Zh9xd79qPt/oQxQXBEOLIphqG1PXQ5wOH3J9kBoT
	 5AsaPf+HQ7D0DxnoZ5ssI38D78WxDmfBQBTNrRMg+FO5CnoOyUD22577AvPjVpseSz
	 KRPXn7ni2n8hd6NoC4SueSDt7JHr8fOBSjQK3AUEmYDHEz59AIhvTU+e/D9et8089Y
	 0rqZxE7LXgNr3CRuuzBgGpYgWg6kdZ9TQbSz0Goaiq2liBd+dZGvYuGncrcR3ZjFZF
	 Tb5o0cqeK3hpQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4196AF40078;
	Wed,  3 Dec 2025 13:55:51 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 13:55:51 -0500
X-ME-Sender: <xms:t4cwabNGgOsDyA4E-EOE3P_hdUQ6FLPfO1CNK7738_azQbKA7OeMOQ>
    <xme:t4cwaQzAtcfE1KbBjA1DIV8o0vtUO4Zfahz9ZPQEF_sej_xyFMzM-qsLJja0dUvx5
    se2Lrr5HW_KTpKlwrVjG25FblOf-M9z5K-3xa_4MDniRnp0qEJfzi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrhhinh
    hgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvthes
    lhifnhdrnhgvthdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehokhhorhhnihgvvhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:t4cwaWv70jGQradil0wlF1xTvGIHofPTrAD04fVAFSiybIn6iKMNQQ>
    <xmx:t4cwaXz43AJFi2JjiieHUtNUE3Rjhiy65Zb3_NaJHOKtEs_DNATcrw>
    <xmx:t4cwaTbXmhO8R9m5GxFnjUX01ReRRQY0MaL75IUyLwC4hBOgAK9JqA>
    <xmx:t4cwaeXkVPktNrDSSsufBMEmKKyjZIDgYMfWP_EOPP1eFpjxz83KYQ>
    <xmx:t4cwacHPyMouyAxj86agagUPThFUSLahwJ6JaYkJtS2rIjerP_Rkw09P>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1AAA5780054; Wed,  3 Dec 2025 13:55:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADz-FxCysAqg
Date: Wed, 03 Dec 2025 13:55:19 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Jonathan Corbet" <corbet@lwn.net>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <9a6f7f4b-dc45-4288-a8ee-6dcaabd19eb9@app.fastmail.com>
In-Reply-To: <20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
 <20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org>
Subject: Re: [PATCH 1/2] filelock: add lease_dispose_list() helper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 1, 2025, at 10:08 AM, Jeff Layton wrote:
> ...and call that from the lease handling code instead of
> locks_dispose_list(). Remove the lease handling parts from
> locks_dispose_list().

The actual change here isn't bothering me, but I'm having trouble
understanding why it's needed. It doesn't appear to be a strict
functional prerequisite for 2/2.

A little more context in the commit message would be helpful.
Sample commit description:

  The lease-handling code paths always know they're disposing of leases,
  yet locks_dispose_list() checks flags at runtime to determine whether
  to call locks_free_lease() or locks_free_lock().

  Split out a dedicated lease_dispose_list() helper for lease code paths.
  This makes the type handling explicit and prepares for the upcoming
  lease_manager enhancements where lease-specific operations are being
  consolidated.

But that reflects only my naive understanding of the patch. You
might have something else in mind.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/fs/locks.c b/fs/locks.c
> index 
> 7f4ccc7974bc8d3e82500ee692c6520b53f2280f..e974f8e180fe48682a271af4f143e6bc8e9c4d3b 
> 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -369,10 +369,19 @@ locks_dispose_list(struct list_head *dispose)
>  	while (!list_empty(dispose)) {
>  		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>  		list_del_init(&flc->flc_list);
> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
> -			locks_free_lease(file_lease(flc));
> -		else
> -			locks_free_lock(file_lock(flc));
> +		locks_free_lock(file_lock(flc));
> +	}
> +}
> +
> +static void
> +lease_dispose_list(struct list_head *dispose)
> +{
> +	struct file_lock_core *flc;
> +
> +	while (!list_empty(dispose)) {
> +		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
> +		list_del_init(&flc->flc_list);
> +		locks_free_lease(file_lease(flc));
>  	}
>  }
> 
> @@ -1620,7 +1629,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> 
> -	locks_dispose_list(&dispose);
> +	lease_dispose_list(&dispose);
>  	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
>  						 list_empty(&new_fl->c.flc_blocked_member),
>  						 break_time);
> @@ -1643,7 +1652,7 @@ int __break_lease(struct inode *inode, unsigned 
> int flags)
>  out:
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> -	locks_dispose_list(&dispose);
> +	lease_dispose_list(&dispose);
>  free_lock:
>  	locks_free_lease(new_fl);
>  	return error;
> @@ -1726,7 +1735,7 @@ static int __fcntl_getlease(struct file *filp, 
> unsigned int flavor)
>  		spin_unlock(&ctx->flc_lock);
>  		percpu_up_read(&file_rwsem);
> 
> -		locks_dispose_list(&dispose);
> +		lease_dispose_list(&dispose);
>  	}
>  	return type;
>  }
> @@ -1895,7 +1904,7 @@ generic_add_lease(struct file *filp, int arg, 
> struct file_lease **flp, void **pr
>  out:
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> -	locks_dispose_list(&dispose);
> +	lease_dispose_list(&dispose);
>  	if (is_deleg)
>  		inode_unlock(inode);
>  	if (!error && !my_fl)
> @@ -1931,7 +1940,7 @@ static int generic_delete_lease(struct file 
> *filp, void *owner)
>  		error = fl->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> -	locks_dispose_list(&dispose);
> +	lease_dispose_list(&dispose);
>  	return error;
>  }
> 
> @@ -2726,7 +2735,7 @@ locks_remove_lease(struct file *filp, struct 
> file_lock_context *ctx)
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> 
> -	locks_dispose_list(&dispose);
> +	lease_dispose_list(&dispose);
>  }
> 
>  /*
>
> -- 
> 2.52.0

-- 
Chuck Lever

