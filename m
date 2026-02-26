Return-Path: <linux-fsdevel+bounces-78447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA9iLHACoGl/fQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:21:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F801A2752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1B6300F967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E338BF8A;
	Thu, 26 Feb 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6p5g/8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127C389462;
	Thu, 26 Feb 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094055; cv=none; b=k5nZ3JqorSUHMhr6xFvmWr772sDaORL7Z+BrOM0lARR4o+J9NmquIMwI2JOMAP6xqt1U4uJaRXdtxQg7PyunXfnNpLYNNj2k7VdS23h98YdEldIWD4ws2plGyQKTnqEHZc6+YuTNrFjir97csFtPQu+C2Jj3pCT4zkK2+u6SIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094055; c=relaxed/simple;
	bh=5Bgww8crZJUOcEx2pZVoUDjtAQs4qmWpkfOAzDilPNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfANbJ/NyuyhkWyTKPETBsnXmeRWfOMTbem9epX4BBxDxOCI9l36IWWIR2zJmy4aWtXKncj1hO8OyM/m+OGbtVUpEgMt5pAptK8PD897xJXbcdfVB4Lh1YTk7xiuLI0BcTEvTv5BqR/5aRojmC81s64sxqEsO6LFazfDYSKZDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6p5g/8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54EDC19422;
	Thu, 26 Feb 2026 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772094055;
	bh=5Bgww8crZJUOcEx2pZVoUDjtAQs4qmWpkfOAzDilPNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6p5g/8J4XlZkRUMaZ1OvshbUrolet/m4ly+TVJJ2FQUoNNWSuToVmjNFFhlbCG+2
	 4JsliKSqA1a+y0mBJJpy3cgiYZCwcwgpKLALsWnF2RJpdiznVFdkJqwRH8xP5hG7GP
	 y2zT4o/m1/KWbunrQG9uoggiw392C22nSds44HT3q4O+ErR0HOr9UyhhLLjYeReEen
	 d7AwTjKB10gta8C9+Y8ch2e5KfGEyFUJgA68HVWo6bOY9/xOlkY0xM+d5nkydFlmIy
	 5WhVNrOivRHhkV+I5UPRb1EYiu9YPxHQWRe05HeoMd6FEBcCgAGmkzvB4wwgFFKTlW
	 s7n62DdvTCQqA==
Date: Thu, 26 Feb 2026 09:20:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Zachary M. Raines" <zachary.raines@canonical.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <jp.kobryn@linux.dev>
Subject: Re: PROBLEM: Duplicated entries in /proc/<pid>/mountinfo
Message-ID: <20260226-fliehen-dutzend-610cb4388bce@brauner>
References: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
 <20260129-geleckt-treuhand-4bb940acacd9@brauner>
 <DG1B2T5I7REV.30XR7YCI0RSZ4@canonical.com>
 <DGCD3NMVHDJQ.2J8WVPEBM4ZRS@canonical.com>
 <20260214-filmt-seepferdchen-c917d60205dc@brauner>
 <5a1f3e553f47a34b1cd6c30d9ec3649919d46585.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a1f3e553f47a34b1cd6c30d9ec3649919d46585.camel@kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78447-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47F801A2752
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:55:07AM -0500, Jeff Layton wrote:
> On Sat, 2026-02-14 at 13:28 +0100, Christian Brauner wrote:
> > On Wed, Feb 11, 2026 at 12:59:25PM -0600, Zachary M. Raines wrote:
> > > On Thu Jan 29, 2026 at 1:04 PM CST, Zachary M. Raines wrote:
> > > > On Thu Jan 29, 2026 at 8:28 AM CST, Christian Brauner wrote:
> > > > > On Wed, Jan 28, 2026 at 08:49:12AM -0600, Zachary M. Raines wrote:
> > > > > I suspect the issue is real though. I'm appending a patch as a proposed
> > > > > fix. Can you test that and report back, please? I'm traveling tomorrow
> > > > > so might take a little.
> > > 
> > > Just following up on the patch you sent and thanks again.
> > > 
> > > > Thank you for the quick turnaround on that patch. I applied it on top
> > > > of 6.19-rc7 and after about 3 hrs I haven't seen any duplicates, in
> > > > contrast to without the patch where they appear in under 10 minutes.
> > > > 
> > > > Let me know if there's any other testing that would help.
> > > 
> > > According to my testing, your patch resolves the issue. Do you plan to
> > > submit it upstream? Please let me know if there's anything
> > > I can do to help on that front.
> > 
> > It'll go upstream early next week. :) I deferred some pull requests.
> 
> I noticed that this still hasn't gone to Linus and it's marked for
> stable in your tree. Any reason you're waiting on it?

As mentioned off-line: we got our wires crossed and this went out as a
pull-request right before you sent the question here.
TL;DR it's upstream now.

