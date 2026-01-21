Return-Path: <linux-fsdevel+bounces-74895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP7iFnchcWl8eQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:56:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF65BA27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975AB9EEC63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C83A901E;
	Wed, 21 Jan 2026 18:21:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71763101A9;
	Wed, 21 Jan 2026 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019711; cv=none; b=F0xOvkbOPHHC+N5WMNCC568mFXgIkivU9pWD0KMZi4oV/VGr1ZRLbN4RWkNFsPyNKudzfKwy/z64TLX12zdlMwkgUWZbSz/rMZoyFVfjvQdlugF/Jm4P+SfRracmDSgHMtbxeXm29hXu4fnbO16Z/Yc/vNy2PVCiNILbIinif6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019711; c=relaxed/simple;
	bh=TBjpqbHcnk4/Hh/KuB/Y/KF/MCwxFsWXjRBXBiaiu+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBlw1juOmcTkVOoXSVzHJkB+P0sMLHxyWxODaXA360HiCMVr0KAH7b1dZzrX07mnIDf3bw0kPQ63K8i+6VIoJiPpwGOtd/3yrgrnsrbZH/+IK33Ksm9fhThkxDgrj5TMB4c1U8YZ25ib8pN+Kmpo4D3z8+X3xsLd8mrE5dJ4MRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 75D08E08B0;
	Wed, 21 Jan 2026 19:16:34 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 21 Jan 2026 19:16:33 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aXEVjYKI6qDpf-VW@fedora>
References: <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp>
 <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
 <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bta26kj.fsf@wotan.olymp>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74895-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[bsbernd.com,ddn.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BDEF65BA27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luis,

On Wed, Jan 21, 2026 at 05:56:12PM +0000, Luis Henriques wrote:
> Hi Horst!
> 
> On Fri, Jan 09 2026, Horst Birthelmer wrote:
> 
> > On Fri, Jan 09, 2026 at 07:12:41PM +0000, Bernd Schubert wrote:
> >> On 1/9/26 19:29, Amir Goldstein wrote:
> >> > On Fri, Jan 9, 2026 at 4:56 PM Bernd Schubert <bschubert@ddn.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >> On 1/9/26 16:37, Miklos Szeredi wrote:
> >> >>> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
> >> >>>
> >> >>>> What about FUSE_CREATE? FUSE_TMPFILE?
> >> >>>
> >> >>> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.
> >> >>>
> >> >>> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
> >> >>> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
> >> >>>
> >> > 
> >> > I thought that the idea of FUSE_CREATE is that it is atomic_open()
> >> > is it not?
> >> > If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
> >> > it won't be atomic on the server, would it?
> >> 
> >> Horst just posted the libfuse PR for compounds
> >> https://github.com/libfuse/libfuse/pull/1418
> >> 
> >> You can make it atomic on the libfuse side with the compound
> >> implementation. I.e. you have the option leave it to libfuse to handle
> >> compound by compound as individual requests, or you handle the compound
> >> yourself as one request.
> >> 
> >> I think we need to create an example with self handling of the compound,
> >> even if it is just to ensure that we didn't miss anything in design.
> >
> > I actually do have an example that would be suitable.
> > I could implement the LOOKUP+CREATE as a pseudo atomic operation in passthrough_hp.
> 
> So, I've been working on getting an implementation of LOOKUP_HANDLE+STATX.
> And I would like to hear your opinion on a problem I found:
> 
> If the kernel is doing a LOOKUP, you'll send the parent directory nodeid
> in the request args.  On the other hand, the nodeid for a STATX will be
> the nodeid will be for the actual inode being statx'ed.
> 
> The problem is that when merging both requests into a compound request,
> you don't have the nodeid for the STATX.  I've "fixed" this by passing in
> FUSE_ROOT_ID and hacking user-space to work around it: if the lookup
> succeeds, we have the correct nodeid for the STATX.  That seems to work
> fine for my case, where the server handles the compound request itself.
> But from what I understand libfuse can also handle it as individual
> requests, and in this case the server wouldn't know the right nodeid for
> the STATX.
> 
> Obviously, the same problem will need to be solved for other operations
> (for example for FUSE_CREATE where we'll need to do a FUSE_MKOBJ_H +
> FUSE_STATX + FUSE_OPEN).
> 
> I guess this can eventually be fixed in libfuse, by updating the nodeid in
> this case.  Another solution is to not allow these sort of operations to
> be handled individually.  But maybe I'm just being dense and there's a
> better solution for this.
> 

You have come across a problem, that I have come across, too, during my experiments. 
I think that makes it a rather common problem when creating compounds.

This can only be solved by convention and it is the reason why I have disabled the default
handling of compounds in libfuse. Bernd actually wanted to do that automatically, but I think
that is too risky for exactly the reason you have found.

The fuse server has to decide if it wants to handle the compound as such or as a
bunch of single requests.

At the moment I think it is best to just not use the libfuse single request handling 
of the compound where it is not possible. 
As my passthrough_hp shows, you can handle certain compounds as a compound where you know all the information
(like some lookup, you just did in the fuse server) and leave the 'trivial' ones to the lib.

We could actually pass 'one' id in the 'in header' of the compound as some sort of global parent 
but that would be another convention that the fuse server has to know and keep.

> Cheers,
> -- 
> Luís

Horst

