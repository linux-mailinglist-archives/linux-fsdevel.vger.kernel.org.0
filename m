Return-Path: <linux-fsdevel+bounces-76536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BzEFbOBhWnpCgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:52:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A0FA784
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D9FE300B462
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD522E54DE;
	Fri,  6 Feb 2026 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6JE9siL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C82E424F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357168; cv=none; b=TeKux/2uCCj3tdYGVB0xT7o0m4KJw4M9Mnujk46d8xqT1K1BfEkt4tqtteVQcq/ZHgqDZTuvieNh8tKKZ0rrsAfYbPo4WcNN0+3dElWYE/hr7rERybhCYrgNkemcOsdA8NePgcBpsxfslD7nj8FVDeKiqZgziFCIoLRh3lpmaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357168; c=relaxed/simple;
	bh=BYdW84yuducOLEtxIFDZr4UXKVg9ChFQA7+sOHfCR6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5oRZqmNGkLAYaz6IghBvbYBWX6ko1XMnUZQg6Ht3GOKlvxkb+aOCjSvpofNpVWMlbTVJR+/kxXYHiYqUe5/qrW5+vDk0t+8Rn5gQuf9r3C2rs6KQK0seBcoswFTVPM9I39NiCr+MvV51+gpq0yC87bAyH0m09tEahg02Igzy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6JE9siL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C32CC116C6;
	Fri,  6 Feb 2026 05:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770357168;
	bh=BYdW84yuducOLEtxIFDZr4UXKVg9ChFQA7+sOHfCR6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6JE9siLpwIBgvOCYz6uVpbwrGUQ/q6ngp7kPjH4z5i0sq9BJyYkQ7MFnEJ7xpliW
	 GxIPFp3pirHDlYtAnVABGr2RlEz8zR0IH0GpWST96VZAGh+CEx/QY6uqraFo6Sytzl
	 hLrX9DhFG0r/V4CBUWuJz6YxCqOIzOJbGfY39nRFkska1Tj6WfPRxfe4Cg4sp1n8GR
	 Y9YVmHUodihXUusJTcFrpaubjaVi7v2zQOzkPjUx6eE+/jz6IrDvbNffFz7LtaSHFR
	 P32S9UqRE/X8GPAUrZSs7wf1HT7dOHnZCc/4mFi3GIeAppInQ8kUC4LQI8YDsB/Vb7
	 IJ3v5JyHmprWA==
Date: Thu, 5 Feb 2026 21:52:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: john@groves.net, Miklos Szeredi <miklos@szeredi.hu>,
	"f-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260206055247.GF7693@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <aYQNcagFg6-Yz1Fw@groves.net>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
 <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76536-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[groves.net,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,bsbernd.com,igalia.com,birthelmer.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: E91A0FA784
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> On Thu, Feb 5, 2026 at 4:33 AM John Groves <john@jagalactic.com> wrote:
> >
> > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> >
> > [ ... ]
> >
> > > >  - famfs: export distributed memory
> > >
> > > This has been, uh, hanging out for an extraordinarily long time.
> >
> > Um, *yeah*. Although a significant part of that time was on me, because
> > getting it ported into fuse was kinda hard, my users and I are hoping we
> > can get this upstreamed fairly soon now. I'm hoping that after the 6.19
> > merge window dust settles we can negotiate any needed changes etc. and
> > shoot for the 7.0 merge window.

I think we've all missed getting merged for 7.0 since 6.19 will be
released in 3 days. :/

(Granted most of the maintainers I know are /much/ less conservative
than I was about the schedule)

> I think that the work on famfs is setting an example, and I very much
> hope it will be a good example, of how improving existing infrastructure
> (FUSE) is a better contribution than adding another fs to the pile.

Yeah.  Joanne and I spent a couple of days this week coprogramming a
prototype of a way for famfs to create BPF programs to handle
INTERLEAVED_EXTENT files.  We might be ready to show that off in a
couple of weeks, and that might be a way to clear up the
GET_FMAP/IOMAP_BEGIN logjam at last.

--D

> I acknowledge that doing the latter is way easier (not for vfs maintainers)
> and I very much appreciate your efforts working on the generic FUSE support
> that will hopefully serve the community and your users better in the long run.
> 
> Thanks,
> Amir.
> 

