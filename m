Return-Path: <linux-fsdevel+bounces-78687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLoyFT1PoWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:01:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE421B432C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EE03058B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141B36C0B1;
	Fri, 27 Feb 2026 07:59:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC4224AF1;
	Fri, 27 Feb 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179156; cv=none; b=N80yYmTaC5c2x4hvUmDm8BOANbBzq87l9iYlCdrgNsy/tD7j84UckRrRT0gOf9q7bUdVSR7ON4z4dzU8Ah+9/mlxgnEinB7sOXOEZIzCklCZ6rbyUT+OP9O/LcjLjMt/dwOFClaBoxvNdF4KbyMCiIadp8e83DTX7SlOjmShxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179156; c=relaxed/simple;
	bh=bmau9RDs3mDfOg2ffgizp4vABJGxgaSC65euswtDGis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEWhIS5WWRJdyfqv79fjMgi54za7uuq1o6IYP+3XKoKgD1Fd+FgAr3Lefc2M9CyPFm8b9oOL0DLAHfvwCp0mKPRfxOn51i2EAu7StS82pvF7twGji4MlzldtDB5YTvjQQk042CfIOmi+HztRF8xIk4FjSCCFbR+b8RjhO5eGNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 7E4D1E02DD;
	Fri, 27 Feb 2026 08:59:12 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 27 Feb 2026 08:59:11 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Jim Harris <jiharris@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Konrad Sztyber <ksztyber@nvidia.com>, 
	Luis Henriques <luis@igalia.com>
Subject: Re: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT
 is set
Message-ID: <aaFNUF2ZhhsAte9G@fedora.fritz.box>
References: <20260220204102.21317-1-jiharris@nvidia.com>
 <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
 <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
 <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
 <aZyhkJSO7Ae7y1Pv@fedora.fritz.box>
 <CAJfpegvFhvbzTEjyPXP4jX26qPOVYCyvBmzrbkO3CWOmVCHhSw@mail.gmail.com>
 <6D884659-21B7-438D-8323-477EA22ACD43@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6D884659-21B7-438D-8323-477EA22ACD43@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78687-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.de:email]
X-Rspamd-Queue-Id: ACE421B432C
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:11:22PM +0000, Jim Harris wrote:
> 
> 
> > On Feb 24, 2026, at 8:33 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, 23 Feb 2026 at 19:55, Horst Birthelmer <horst@birthelmer.de> wrote:
> > 
> >> What is wrong with a compound doing LOOKUP + MKNOD + OPEN?
> >> If the fuse server knows how to process that 'group' atomically
> >> in one big step it will do the right thing,
> >> if not, we will call those in series and sort out the data
> >> in kernel afterwards.
> >> 
> >> If we preserve all flags and the real results we can do pretty
> >> much exactly the same thing that is done at the moment with just
> >> one call to user space.
> >> 
> >> That was actually what I was experimenting with.
> >> 
> >> The MKNOD in the middle is optional depending on the O_CREAT flag.
> > 
> > Okay, I won't stop you experimenting.
> > 
> > My thinking is that it's simpler as a separate op (dir handle and name
> > are the same for LOOKUP and MKNOD).   But adding this special "stop if
> > error or non-regular, else skip create if positive" dependency would
> > also work.
> > 
> > Thanks,
> > Miklos
> 
> Thanks for the feedback everyone. Sounds like compounds will be the way forward to optimize this path, once they are ready.
> 
> Do we think compounds will be land for 7.1? Or later?

I honestly have no idea. I'm going as fast as I can.
BTW, the post you are responding to, wasn't meant to reject the patch IMHO, but the change in behavior could actually
become a real problem.

I have the same fear for the compound of open+getattr, which actually solves a bug, but could be trouble for
people making the wrong assumptions in their fuse servers.

> 
> Best regards,
> 
> Jim
> 

Cheers,
Horst

