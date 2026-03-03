Return-Path: <linux-fsdevel+bounces-79120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFYBMD6OpmnxRAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 08:31:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 523021EA312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3878C311258E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BC386550;
	Tue,  3 Mar 2026 07:26:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F1386545;
	Tue,  3 Mar 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522806; cv=none; b=TWMRnUFZTZp5OQtOLx1vvdsqWEH+5VTZlo8D/lj6Haa+2N5RQ+ubK9/voZ+ZVBfnltJ2tFO7HDh6yse3VBMEd5pWvjrKVXW1G7tPfOZbdZQ3q1d1Usfe7FagW6FHDhhtERj7L1UV52gZvX2M5W3yxk5krZKg+514LcJFZmMOEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522806; c=relaxed/simple;
	bh=M9Z9JZpWYC/naaqofbH0Exh6SxguCUFdevSoWAIr6BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq5lgW8tfZ5cvWZ41UJzSBhF2M/XG8eECbWsU+5Re7zYfX5bOfmLDRK2X8NxGCRALUvohr1il5TnYvtt8rlUuc8eTle3hSzFvKpAKL5SBErrxoHIVKEGtJ+1TKg79Ihj3fXYTQuiwGWW9ExKf9ufFgZqcVuOgDBJ4nk+C56x9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 7AA58E0546;
	Tue,  3 Mar 2026 08:26:35 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 3 Mar 2026 08:26:34 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
Message-ID: <aaaLoEFtmgRa5SqX@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box>
 <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box>
 <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com>
 <20260303050614.GO13829@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303050614.GO13829@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 523021EA312
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79120-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[ddn.com,gmail.com,birthelmer.com,szeredi.hu,igalia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.684];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,birthelmer.de:email,fedora.fritz.box:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:06:14PM -0800, Darrick J. Wong wrote:
> On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> > On 3/2/26 19:56, Joanne Koong wrote:
> > > On Sat, Feb 28, 2026 at 12:14 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> > >>
> > >> On Fri, Feb 27, 2026 at 10:07:20AM -0800, Joanne Koong wrote:
> > >>> On Fri, Feb 27, 2026 at 9:51 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >>>>
> > >>>> On Thu, Feb 26, 2026 at 11:48 PM Horst Birthelmer <horst@birthelmer.de> wrote:
> > >>>>>
> > >>>>> On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> > >>>>>> On Thu, Feb 26, 2026 at 8:43 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> > >>>>>>>
> > >>>>>>> From: Horst Birthelmer <hbirthelmer@ddn.com>
> > >>>>>>>
> > >>>>>>> The discussion about compound commands in fuse was
> > >>>>>>> started over an argument to add a new operation that
> > >>>>>>> will open a file and return its attributes in the same operation.
> > >>>>>>>
> > >>>>>>> Here is a demonstration of that use case with compound commands.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > >>>>>>> ---
> > >>>>>>>  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
> > >>>>>>>  fs/fuse/fuse_i.h |   4 +-
> > >>>>>>>  fs/fuse/ioctl.c  |   2 +-
> > >>>>>>>  3 files changed, 99 insertions(+), 18 deletions(-)
> > >>>>>>>
...
> > > 
> > > The overhead for the server to fetch the attributes may be nontrivial
> > > (eg may require stat()). I really don't think we can assume the data
> > > is locally cached somewhere. Why always compound the getattr to the
> > > open instead of only compounding the getattr when the attributes are
> > > actually invalid?
> > > 
> > > But maybe I'm wrong here and this is the preferable way of doing it.
> > > Miklos, could you provide your input on this?
> > 
> > Personally I would see it as change of behavior if out of the sudden
> > open is followed by getattr. In my opinion fuse server needs to make a
> > decision that it wants that. Let's take my favorite sshfs example with a
> > 1s latency - it be very noticeable if open would get slowed down by
> > factor 2.
> 
> I wonder, since O_APPEND writes supposedly reposition the file position
> to i_size before every write, can we enlarge the write reply so that the
> fuse server could tell the client what i_size is supposed to be after
> every write?  Or perhaps add a notification so a network filesystem
> could try to keep the kernel uptodate after another node appends to a
> file?
> 

Bernd already had that idea, that we add an optional getattr to a write
in a compound.
If the fuse server supports it, you would get that data.
I'm really not happy about that idea, since we would have to support 'pages' 
then for the compound.

Regarding the notification. Isn't that doable with the current code already?

> Just my unqualified opinion ;)
> 
> --D
> 
> > Thanks,
> > Bernd

Thanks,
Horst

