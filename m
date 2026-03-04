Return-Path: <linux-fsdevel+bounces-79354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDyEMlIuqGlPpQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:06:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827432000B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AEEE3061529
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3826F291;
	Wed,  4 Mar 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUIK8MgA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95C1DEFE0;
	Wed,  4 Mar 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629553; cv=none; b=YYXGidQjD4ByKYxOA2DveAYB3JjRhalBlCXEZfbqR9kFC0ApaMcj91EUMyu7Q+DxHIV8jXxC5ae4xvkOech2VjINv7SQvl6MlyVkpS2GpPIvA0iNjF16MXuEcpFluRg/+vhXFUZiwQSlRFEdcoLOG/SiUCrboWmfy6bJSAM5cl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629553; c=relaxed/simple;
	bh=sAZHSXg/Be+oJJsHWSs3WSwZYlPzTKpJZfIGcEDYo10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn+nvRAF46csDuUzofokQpk/0EWxEFlMYJsjacMmnFv+5WSonH8e8EpxwJZ4GabIpuw7E5BZ9MwhyVJBe3c1dl9mXIDyNHu1Faktx1uKw9Z+vgMynnzlIRP0VpcVMfAhD/O240D2CFV5qNz+jkBxzen6dnjYInBMxc50NebMlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUIK8MgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF40C2BC87;
	Wed,  4 Mar 2026 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772629553;
	bh=sAZHSXg/Be+oJJsHWSs3WSwZYlPzTKpJZfIGcEDYo10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUIK8MgAcoH1zIYpc5f3SDv8Y5laSL5KmVwfql3dOAIhTS4U2AHYyvvwOnPdDOA9L
	 RK2EM1CI3uQm9Rb7tdxy8y68ixzPjuYV3m+V58t0lxM5oWNsaD1s7stzJxA7NSRfRl
	 4nhrOXj0KeZAYruV+3kCq90JSL5/c6VaWh1qKpr/3ZxcbG6c66j2ED+aTSeanCk4uW
	 FwHgbZ/6u39pDdq9d5NPlmxT1dJ3oa2mualPKEqgCQekKJVb2KfPOu/av3v/hdBNOD
	 akvUhgQpdpnFc7Y52nMv++su85d1ca/TQDnc17SCj8futudao7Vtn5XMMB0ZiUzsuH
	 DL5cEoNAn42nw==
Date: Wed, 4 Mar 2026 14:05:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
Message-ID: <20260304-leitbild-erhielten-49507b3a6f59@brauner>
References: <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
 <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>
 <177248378665.7472.10406837112182319577@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177248378665.7472.10406837112182319577@noble.neil.brown.name>
X-Rspamd-Queue-Id: 827432000B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79354-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,suse.cz,suse.com,kernel.org,redhat.com,talpey.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 07:36:26AM +1100, NeilBrown wrote:
> On Tue, 03 Mar 2026, Chuck Lever wrote:
> > On 3/2/26 8:57 AM, Chuck Lever wrote:
> > > On 3/1/26 11:09 PM, NeilBrown wrote:
> > >> On Mon, 02 Mar 2026, Chuck Lever wrote:
> > >>>
> > >>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> > >>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
> > >>>>> Perhaps that description nails down too much implementation detail,
> > >>>>> and it might be stale. A broader description is this user story:
> > >>>>>
> > >>>>> "As a system administrator, I'd like to be able to unexport an NFSD
> > >>>>
> > >>>> Doesn't "unexporting" involve communicating to nfsd?
> > >>>> Meaning calling to svc_export_put() to path_put() the
> > >>>> share root path?
> > >>>>
> > >>>>> share that is being accessed by NFSv4 clients, and then unmount it,
> > >>>>> reliably (for example, via automation). Currently the umount step
> > >>>>> hangs if there are still outstanding delegations granted to the NFSv4
> > >>>>> clients."
> > >>>>
> > >>>> Can't svc_export_put() be the trigger for nfsd to release all resources
> > >>>> associated with this share?
> > >>>
> > >>> Currently unexport does not revoke NFSv4 state. So, that would
> > >>> be a user-visible behavior change. I suggested that approach a
> > >>> few months ago to linux-nfs@ and there was push-back.
> > >>>
> > >>
> > >> Could we add a "-F" or similar flag to "exportfs -u" which implements the
> > >> desired semantic?  i.e.  asking nfsd to release all locks and close all
> > >> state on the filesystem.
> > > 
> > > That meets my needs, but should be passed by the linux-nfs@ review
> > > committee.
> > 
> > Discussed with the reporter. -F addresses the automation requirement,
> > but users still expect "exportfs -u" to work the same way for NFSv3 and
> > NFSv4: "unexport" followed by "unmount" always works.
> > 
> > I am not remembering clearly why the linux-nfs folks though that NFSv4
> > delegations should stay in place after unexport. In my view, unexport
> > should be a security boundary, stopping access to the files on the
> > export.
> 
> At the time when the API was growing, delegations were barely an
> unhatched idea.
> 
> unexport may be a security boundary, but it is not so obvious that it is
> a state boundary.
> 
> The kernel is not directly involved in whether something is exported or
> not.  That is under the control of mountd/exportfs.  The kernel keeps a
> cache of info from there.  So if you want to impose a state boundary, it
> really should involved mountd/exportfs.
> 
> There was once this idea floating around that policy didn't belong in
> the kernel.

Very much agree.

