Return-Path: <linux-fsdevel+bounces-75704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGpdAKnPeWnezgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:58:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508C9E866
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0972304D964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5F33ADB9;
	Wed, 28 Jan 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiNsTsjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F229A1;
	Wed, 28 Jan 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590442; cv=none; b=pqODf9Fr+XwzPgBCc/en9dsuZEdm0QnSwto1QI4kDdobsk3omjigA08sbGWdyv0VTcclu39tehcynIdyFJHYeKOPWpVynZPQMq/DZ5ls3gNpmBUDMGDnbmhDZGGs7CS9HlQ94OlLcKvRhfz51hf9gWlbQ0Kriw4cvOj16x0jbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590442; c=relaxed/simple;
	bh=sp8ZzgKfLYBf6n5dvtaPV7JJtZoVmZtARJEfnOlvgnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6ZvZr/5mQrosxadFsrLddvF4Vd1H49DEwSoGAr7XYrgEqQnyUbvBpkGWsWfYDxqvrTCXEyU1qUSyIV3vKOpz2WEFSHu0rgrgl56Zuy9kQvOHDqtKpnSBUXhya0AJ9MwrFCtCxl3JAeBBcHacgTynSBnpZh7F1Rf8v61DV6Q68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiNsTsjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B35C4CEF1;
	Wed, 28 Jan 2026 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769590442;
	bh=sp8ZzgKfLYBf6n5dvtaPV7JJtZoVmZtARJEfnOlvgnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiNsTsjt7/JJEy7yHNve/JooAIlH0pnM87ZGvmgdHepEWko5EVz56NLPJSRbmXI8w
	 sxKEPaOCpGXqDtQ0OHpQYWN7Mt9VjqvMvARm+eLYaHLPTNohEerYQif5fI9Qezgjy+
	 G4XDfI/hst0WjbqQ1xzHMsJI6EzUETgPfOt5Yvr0=
Date: Wed, 28 Jan 2026 09:53:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Samuel Wu <wusamuel@google.com>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com,
	android-kernel-team <android-kernel-team@google.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
Message-ID: <2026012812-jurist-whoops-0ef5@gregkh>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh>
 <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
 <20260127201454.GQ3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127201454.GQ3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75704-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9508C9E866
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 08:14:54PM +0000, Al Viro wrote:
> On Tue, Jan 27, 2026 at 10:39:04AM -0800, Linus Torvalds wrote:
> > On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> > > open/removal races") from the stable backports, as it was causing issues
> > > on the pixel devices it got backported to.  So perhaps look there?
> > 
> > Hmm. That commit is obviously still upstream, do we understand why it
> > caused problems in the backports?
> 
> This is all I've seen:
> 
> | It has been reported to cause test problems in Android devices.  As the
> | other functionfs changes were not also backported at the same time,
> | something is out of sync.  So just revert this one for now and it can
> | come back in the future as a patch series if it is tested.
> 
> My apologies for not following up on that one; Greg, could you give some
> references to those reports?

Sorry, all I got was a "this commit caused devices to fail" and was
found from bisection, on the 6.18.y tree.  Samuel has much more
information as to exactly what is happening here as he can see the test
results properly, I'll let him work through this, thanks!

greg k-h

