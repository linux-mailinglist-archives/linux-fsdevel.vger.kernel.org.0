Return-Path: <linux-fsdevel+bounces-78272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKtnF7a2nWlyRQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:33:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D53188681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFBB330470B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFC39B4A5;
	Tue, 24 Feb 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxV065U2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2948405C;
	Tue, 24 Feb 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943599; cv=none; b=M2Lzn4x0e07A9wfEocfcuxxYwGHS8jeprMNvN/R9OoORdwmklhMvn387YiCr40nllKOo/Hv7c0/sBqZ5KRT8pNgh2EyqOD5Q1buTqy0Nsk609FbzVl2ix1xEgeIWjo4CF4bTLKtMLCeixoyetb6w1ipL3aUZ5iE+in0VYwANPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943599; c=relaxed/simple;
	bh=GCvt8CSMBX2Qiv35I5lQiTRee1Kb/Fn2qrghMvy0YrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzoVVPSBi8SYhhGigeXWQ+XyXF6wl86+lXSxYHU2FbIIudPPLHtFQWMjc+tnCciWwtrOEOrZg5iQHjgEaVYguUPjdTbie6WDwkxhW5GCL/ZaxpKOowlZF/2cYNt1Sfm77ONZ4lBKp4+ZkotQWHhb6IO4gGmxzALvc6clf72h4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxV065U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06330C116D0;
	Tue, 24 Feb 2026 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771943598;
	bh=GCvt8CSMBX2Qiv35I5lQiTRee1Kb/Fn2qrghMvy0YrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxV065U2S9Sxtu8JdY1REylYwHLXFrlSGxuQHktKntLnjOZHwsoFDY07FEQ+v420+
	 C1vvKWN/niTtgk/49T5I2osc8VorDfsggJDLuP2XPOhJrhb5XxYO/Fy62PtyPdNjJ8
	 4kl/ebS3eWmKjm5q/3EHK4NOuUyALo1KS9sYkRSLgcjjoMCxVuHjYqjCp1xJp9EWjJ
	 qqrLaQ2S8LuKJsSq/zPgi/MiTqMMY331oDTRIdBASSrWd1GRK9c0h4LVfzVckuwd69
	 8xKlJCFQYGQ4cBOaeBIze6K2v+FEYmt2uR4zvJFPPv+m+wv8BcjEwiRW7hksxDVUtY
	 3mw3TW7bMoDFw==
Date: Tue, 24 Feb 2026 15:33:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-api@vger.kernel.org, rudi@heitbaum.com
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <20260224-kandidat-wohltat-ae8fb7a57738@brauner>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
 <lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
 <20260224-erbitten-kaufleute-6f14e3072c5d@brauner>
 <lhuv7fmxo8y.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhuv7fmxo8y.fsf@oldenburg.str.redhat.com>
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
	TAGGED_FROM(0.00)[bounces-78272-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,gmail.com,toxicpanda.com,suse.cz,cyphar.com,heitbaum.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sourceware.org:url]
X-Rspamd-Queue-Id: C9D53188681
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:30:37PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > On Tue, Feb 24, 2026 at 12:23:33PM +0100, Florian Weimer wrote:
> >> * Christian Brauner:
> >> 
> >> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> >> > index 5d3f8c9e3a62..acbc22241c9c 100644
> >> > --- a/include/uapi/linux/mount.h
> >> > +++ b/include/uapi/linux/mount.h
> >> > @@ -61,7 +61,8 @@
> >> >  /*
> >> >   * open_tree() flags.
> >> >   */
> >> > -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> >> > +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
> >> 
> >> This change causes pointless -Werror=undef errors in projects that have
> >> settled on the old definition.
> >> 
> >> Reported here:
> >> 
> >>   Bug 33921 - Building with Linux-7.0-rc1 errors on OPEN_TREE_CLONE
> >>   <https://sourceware.org/bugzilla/show_bug.cgi?id=33921>
> >
> > Send a patch to change it back, please.
> > Otherwise it might take a few days until I get around to it.
> 
> Rudi, could you post a patch?

I'm a bit confused though and not super happy that you're basically
asking us to be so constrained that we aren't even allowed to change 1
to 1 - just syntactically different.

