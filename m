Return-Path: <linux-fsdevel+bounces-28802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4587496E659
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 01:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00580284F80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B771B2EE2;
	Thu,  5 Sep 2024 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="are+cdk1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nytqWQPO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xya2GHjB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RcqNl/50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58655381B;
	Thu,  5 Sep 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579273; cv=none; b=RorMlaVQIDcL2k1datCkneTNefRRtZDJBdNt++2SKKWbmITwT23CbIH33FGlzPS4JcK3Op9oSPOHxAB0GW3/Lszy27ZUYdnYJLWbINitAW6YybS4+AyA56AZl91cu9peHwNKhAkl1eFKFHClZTgRiqUjvMC9/GUSahHhOZMPB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579273; c=relaxed/simple;
	bh=Zfl/iSHMNbykgamPzLSOcwQDKFZqxn/Pr4gEIA7gFK0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XGPSqEuKCfUDocxkKtak7zsjU2zKcCOMkbF2KEEMcA3vzU8uJdpC6xcLpKd6RUPaZSQYiT7hOs1etyd2BATVI7fdAtKqdEoHYLei8qVPc3eJm1fDHn0XFihzSC7EMPxGqKKogKO71hkCyeKcR94O45cuEz2igSxtrTNQrd6GTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=are+cdk1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nytqWQPO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xya2GHjB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RcqNl/50; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E90DF1F844;
	Thu,  5 Sep 2024 23:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725579269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mPa4Al51mRDna1hBB3yArxBj7SBia8l3F7869RViAc=;
	b=are+cdk1xeS0F2IIPyLFJLX9TAbr5rS3v1MJ4ICAjLL5d6kAfDG0HqhxMCrfsdzzLePDFM
	ASie4xkZgzWr/ZbUg6LkAh/mt8rT8fGpbiPpfqjI/ZOB0sNjMXlDQvOS2zxNcXbWgrWy1k
	EfWgS7RrtJzJKG4ClOrdNlirDxDX5XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725579269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mPa4Al51mRDna1hBB3yArxBj7SBia8l3F7869RViAc=;
	b=nytqWQPOTMQcwKFX1zcZ8Q6Bq1XP8flpzAhOSeFOvTxdi+HO8bf6Oy1gC1TMzdCqKOlzoI
	ZbN4KKVpv401w1CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725579268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mPa4Al51mRDna1hBB3yArxBj7SBia8l3F7869RViAc=;
	b=xya2GHjBULU9tVkuA0R5IYghJf+vRkv6norCJ+VfBU9vFDC4bDhZUPymrircGHgvDQLQq8
	gI7hlnxlAmAI61jr3ln+VR7+SF+VAvPkUX5snFd2lvacRw6JF3S18iG6gVMaWcRHYZL/Qb
	fn4HeeRu6NkiTVekjahKTu7jRNdiuVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725579268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mPa4Al51mRDna1hBB3yArxBj7SBia8l3F7869RViAc=;
	b=RcqNl/50blCApKhaJylBr7MjnWzCjjrJOkuEVaaYJ7zOxSWM/JZpQ2GO4NVRAyuQtbHq25
	k0KKqxNg9KP5ZsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A6C013419;
	Thu,  5 Sep 2024 23:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id urs2DAJA2mY/LQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 05 Sep 2024 23:34:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
In-reply-to: <Ztm-TbSdXOkx3IHn@kernel.org>
References: <>, <Ztm-TbSdXOkx3IHn@kernel.org>
Date: Fri, 06 Sep 2024 09:34:08 +1000
Message-id: <172557924809.4433.12586767127138915683@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 06 Sep 2024, Mike Snitzer wrote:
> On Wed, Sep 04, 2024 at 09:47:07AM -0400, Chuck Lever wrote:
> > On Wed, Sep 04, 2024 at 03:01:46PM +1000, NeilBrown wrote:
> > > On Wed, 04 Sep 2024, NeilBrown wrote:
> > > >=20
> > > > I agree that dropping and reclaiming a lock is an anti-pattern and in
> > > > best avoided in general.  I cannot see a better alternative in this
> > > > case.
> > >=20
> > > It occurred to me what I should spell out the alternate that I DO see so
> > > you have the option of disagreeing with my assessment that it isn't
> > > "better".
> > >=20
> > > We need RCU to call into nfsd, we need a per-cpu ref on the net (which
> > > we can only get inside nfsd) and NOT RCU to call
> > > nfsd_file_acquire_local().
> > >=20
> > > The current code combines these (because they are only used together)
> > > and so the need to drop rcu.=20
> > >=20
> > > I thought briefly that it could simply drop rcu and leave it dropped
> > > (__releases(rcu)) but not only do I generally like that LESS than
> > > dropping and reclaiming, I think it would be buggy.  While in the nfsd
> > > module code we need to be holding either rcu or a ref on the server else
> > > the code could disappear out from under the CPU.  So if we exit without
> > > a ref on the server - which we do if nfsd_file_acquire_local() fails -
> > > then we need to reclaim RCU *before* dropping the ref.  So the current
> > > code is slightly buggy.
> > >=20
> > > We could instead split the combined call into multiple nfs_to
> > > interfaces.
> > >=20
> > > So nfs_open_local_fh() in nfs_common/nfslocalio.c would be something
> > > like:
> > >=20
> > >  rcu_read_lock();
> > >  net =3D READ_ONCE(uuid->net);
> > >  if (!net || !nfs_to.get_net(net)) {
> > >        rcu_read_unlock();
> > >        return ERR_PTR(-ENXIO);
> > >  }
> > >  rcu_read_unlock();
> > >  localio =3D nfs_to.nfsd_open_local_fh(....);
> > >  if (IS_ERR(localio))
> > >        nfs_to.put_net(net);
> > >  return localio;
> > >=20
> > > So we have 3 interfaces instead of 1, but no hidden unlock/lock.
> >=20
> > Splitting up the function call occurred to me as well, but I didn't
> > come up with a specific bit of surgery. Thanks for the suggestion.
> >=20
> > At this point, my concern is that we will lose your cogent
> > explanation of why the release/lock is done. Having it in email is
> > great, but email is more ephemeral than actually putting it in the
> > code.
> >=20
> >=20
> > > As I said, I don't think this is a net win, but reasonable people might
> > > disagree with me.
> >=20
> > The "win" here is that it makes this code self-documenting and
> > somewhat less likely to be broken down the road by changes in and
> > around this area. Since I'm more forgetful these days I lean towards
> > the more obvious kinds of coding solutions. ;-)
> >=20
> > Mike, how do you feel about the 3-interface suggestion?
>=20
> I dislike expanding from 1 indirect function call to 2 in rapid
> succession (3 for the error path, not a problem, just being precise.
> But I otherwise like it.. maybe.. heh.
>=20
> FYI, I did run with the suggestion to make nfs_to a pointer that just
> needs a simple assignment rather than memcpy to initialize.  So Neil's
> above code becames:
>=20
>         rcu_read_lock();
>         net =3D rcu_dereference(uuid->net);
>         if (!net || !nfs_to->nfsd_serv_try_get(net)) {
>                 rcu_read_unlock();
>                 return ERR_PTR(-ENXIO);
>         }
>         rcu_read_unlock();
>         /* We have an implied reference to net thanks to nfsd_serv_try_get =
*/
>         localio =3D nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
>                                              cred, nfs_fh, fmode);
>         if (IS_ERR(localio))
>                 nfs_to->nfsd_serv_put(net);
>         return localio;
>=20
> I do think it cleans the code up... full patch is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=
=3Dnfs-localio-for-next.v15-with-fixups&id=3De85306941878a87070176702de687f27=
79436061
>=20
> But I'm still on the fence.. someone help push me over!

I think the new code is unquestionable clearer, and not taking this
approach would be a micro-optimisation which would need to be
numerically justified.  So I'm pushing for the three-interface version
(despite what I said before).

Unfortunately the new code is not bug-free - not quite.
As soon as nfs_to->nfsd_serv_put() calls percpu_ref_put() the nfsd
module can be unloaded, and the "return" instruction might not be
present.  For this to go wrong would require a lot of bad luck, but if
the CPU took an interrupt at the wrong time were would be room.

[Ever since module_put_and_exit() was added (now ..and_kthread_exit)
 I've been sensitive to dropping the ref to a module in code running in
 the module]

So I think nfsd_serv_put (and nfsd_serv_try_get() __must_hold(RCU) and
nfs_open_local_fh() needs rcu_read_lock() before calling
nfs_to->nfsd_serv_put(net).



>=20
> Tangent, but in the related business of "what are next steps?":
>=20
> I updated headers with various provided Reviewed-by:s and Acked-by:s,
> fixed at least 1 commit header, fixed some sparse issues, various
> fixes to nfs_to patch (removed EXPORT_SYMBOL_GPL, switched to using
> pointer, updated nfs_to callers). Etc...
>=20
> But if I fold those changes in I compromise the provided Reviewed-by
> and Acked-by.. so I'm leaning toward posting a v16 that has
> these incremental fixes/improvements, see the 3 topmost commits here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=3D=
nfs-localio-for-next.v15-with-fixups
>=20
> Or if you can review the incremental patches I can fold them in and
> preserve the various Reviewed-by and Acked-by...

I have reviewed the incremental patches and I'm happy for all my tags to
apply to the new versions of the patches.

NeilBrown

