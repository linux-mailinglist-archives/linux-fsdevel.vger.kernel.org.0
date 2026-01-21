Return-Path: <linux-fsdevel+bounces-74898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OEoLQIrcWniewAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:37:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 554955C517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA647A66AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48063B8BC2;
	Wed, 21 Jan 2026 18:37:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5573B8BA8;
	Wed, 21 Jan 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020626; cv=none; b=CUL8RMXz1P59dSR/cIbTvt8ZjQpyGr9AYL1PcYHuYg+yAXt2Gm9alY4fA5xm+RnhFmN4HQKYLXonrr0plXSQaaaIBTRAkQYkmbTUDEJstG9Jgx7K7HptXyj/F3+Uz2hsu+bj4p7Sm4Xh8CcQC0JDH27ZMzayMbN3bLYpSd/DpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020626; c=relaxed/simple;
	bh=495ypfu2mS7153OpYPETY3wlHkR04T16ObxppEaZlMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKePSv9zxkkwUq8Mra8AgsxUuOgE28FIW3+gtWXaPLyPTEaynaIrMJijGn+VsTUmWv12ENHYvRzUyJoCsmTW3+fUBCKzuZK0uAgbAbu2u+6LkyoLbX24QnvR8aOhkiCe2wGJYXabauSacDqeCTQdJz62c4OWq4D1vONqh/Z5pKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 73E31E0337;
	Wed, 21 Jan 2026 19:36:54 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 21 Jan 2026 19:36:53 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aXEbnMNbE4k6WI7j@fedora>
References: <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
 <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp>
 <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74898-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[igalia.com,ddn.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ddn.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 554955C517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:28:43PM +0100, Bernd Schubert wrote:
> On 1/21/26 19:16, Horst Birthelmer wrote:
> > Hi Luis,
> > 
> > On Wed, Jan 21, 2026 at 05:56:12PM +0000, Luis Henriques wrote:
> >> Hi Horst!
> >>
> >> On Fri, Jan 09 2026, Horst Birthelmer wrote:
> >>
> >>> On Fri, Jan 09, 2026 at 07:12:41PM +0000, Bernd Schubert wrote:
> >>>> On 1/9/26 19:29, Amir Goldstein wrote:
> >>>>> On Fri, Jan 9, 2026 at 4:56 PM Bernd Schubert <bschubert@ddn.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 1/9/26 16:37, Miklos Szeredi wrote:
> >>>>>>> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
> >>>>>>>
> >>>>>>>> What about FUSE_CREATE? FUSE_TMPFILE?
> >>>>>>>
> >>>>>>> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.
> >>>>>>>
> >>>>>>> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
> >>>>>>> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
> >>>>>>>
> >>>>>
> >>>>> I thought that the idea of FUSE_CREATE is that it is atomic_open()
> >>>>> is it not?
> >>>>> If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
> >>>>> it won't be atomic on the server, would it?
> >>>>
> >>>> Horst just posted the libfuse PR for compounds
> >>>> https://github.com/libfuse/libfuse/pull/1418
> >>>>
> >>>> You can make it atomic on the libfuse side with the compound
> >>>> implementation. I.e. you have the option leave it to libfuse to handle
> >>>> compound by compound as individual requests, or you handle the compound
> >>>> yourself as one request.
> >>>>
> >>>> I think we need to create an example with self handling of the compound,
> >>>> even if it is just to ensure that we didn't miss anything in design.
> >>>
> >>> I actually do have an example that would be suitable.
> >>> I could implement the LOOKUP+CREATE as a pseudo atomic operation in passthrough_hp.
> >>
> >> So, I've been working on getting an implementation of LOOKUP_HANDLE+STATX.
> >> And I would like to hear your opinion on a problem I found:
> >>
> >> If the kernel is doing a LOOKUP, you'll send the parent directory nodeid
> >> in the request args.  On the other hand, the nodeid for a STATX will be
> >> the nodeid will be for the actual inode being statx'ed.
> >>
> >> The problem is that when merging both requests into a compound request,
> >> you don't have the nodeid for the STATX.  I've "fixed" this by passing in
> >> FUSE_ROOT_ID and hacking user-space to work around it: if the lookup
> >> succeeds, we have the correct nodeid for the STATX.  That seems to work
> >> fine for my case, where the server handles the compound request itself.
> >> But from what I understand libfuse can also handle it as individual
> >> requests, and in this case the server wouldn't know the right nodeid for
> >> the STATX.
> >>
> >> Obviously, the same problem will need to be solved for other operations
> >> (for example for FUSE_CREATE where we'll need to do a FUSE_MKOBJ_H +
> >> FUSE_STATX + FUSE_OPEN).
> >>
> >> I guess this can eventually be fixed in libfuse, by updating the nodeid in
> >> this case.  Another solution is to not allow these sort of operations to
> >> be handled individually.  But maybe I'm just being dense and there's a
> >> better solution for this.
> >>
> > 
> > You have come across a problem, that I have come across, too, during my experiments. 
> > I think that makes it a rather common problem when creating compounds.
> > 
> > This can only be solved by convention and it is the reason why I have disabled the default
> > handling of compounds in libfuse. Bernd actually wanted to do that automatically, but I think
> > that is too risky for exactly the reason you have found.
> > 
> > The fuse server has to decide if it wants to handle the compound as such or as a
> > bunch of single requests.
> 
> Idea was actually to pass compounds to the daemon if it has a compound
> handler, if not to handle it automatically. Now for open+getattr
> fuse-server actually not want the additional getattr - cannot be handle
> automatically. But for lookup+stat and others like this, if fuse server
> server does not know how to handle the entire compound, libfuse could
> still do it correctly, i.e. have its own handler for known compounds?

We could definitely provide a library of compounds that we 'know' in libfuse,
of course. No argument there.

The problem Luis had was that he cannot construct the second request in the compound correctly
since he does not have all the in parameters to write complete request.

BTW, I forgot in my last mail to say that we have another problem, where we need 
some sort of convention where we will bang our heads sooner or later.
If the fuse server does not support the given compound it should 
return EOPNOTSUP in my opinion.
IIRC this is not implemented correctly so far.

> 
> > 
> > At the moment I think it is best to just not use the libfuse single request handling 
> > of the compound where it is not possible. 
> > As my passthrough_hp shows, you can handle certain compounds as a compound where you know all the information
> > (like some lookup, you just did in the fuse server) and leave the 'trivial' ones to the lib.
> > 
> > We could actually pass 'one' id in the 'in header' of the compound as some sort of global parent 
> > but that would be another convention that the fuse server has to know and keep.
> > 
> 
> 
> Thanks,
> Bernd

Horst

