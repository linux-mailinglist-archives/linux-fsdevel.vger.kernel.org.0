Return-Path: <linux-fsdevel+bounces-23249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD2928EF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 23:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B51F23760
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD86169AD0;
	Fri,  5 Jul 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uECZ4stH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b8qnRk3N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uwT9WVFk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FkaB+8hU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7A145B03;
	Fri,  5 Jul 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216275; cv=none; b=WbS/fY4kiBKoL88ffTWd2FBLyzRV/tI+vV/aS8oKAuY8PYBwsyIR3JO8pO1pBKGhRVz5RlfSSfQPNZsBwO125R/+nqWTG6NNFxLiAEESWjN9o/EgRkZRpzhMqzPQ3sgsuMJRQMy+Ok6u/k8sSto4Y1wfQ54ZKGlnnJB/DhJVQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216275; c=relaxed/simple;
	bh=QRaqDzYEQUq9tiXQ/0s2hH/xBqwEhkM5klZH525/JWk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K0poWYcWjhmO52w+SfchPM5mm4tbKAp/wtujqwQwMyo65+BhHg51sM9x337nWaaVfw5S+xl/H33Bbprw/ogZN5khIw3c4x2BnT8+Qsh12C+3BHEOv97xUpQfBx4s+bwR4JcMDFd4hwT+poziBA/gYRWQjydGloTHtzwjMENQD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uECZ4stH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b8qnRk3N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uwT9WVFk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FkaB+8hU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D559021AAE;
	Fri,  5 Jul 2024 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720216272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyCosjYZowLgthiefSmgKAH8gA0MkEzux0epotkjl/o=;
	b=uECZ4stHhq50PoFSoEHvCmtvjhJTA36He2iZpXFAIp+QoF9mBGAMRIcPIXS14ikkUurS2K
	iG56DEGk2Mu8nSaFHlpmn071BrusF1ArgY7glkwkp+fcYzt2PMM035JIHDaZwz+ZS9NySf
	7IZqHRXe5AOhDwNpF3qhh13RCbEJpFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720216272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyCosjYZowLgthiefSmgKAH8gA0MkEzux0epotkjl/o=;
	b=b8qnRk3NibkpxUlTf76WjynwzilpJ+wgg9JlNX84B6GEZGLecTmHqHS50XM4p0osKf2bS9
	RGjELBCYYB3YEBBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uwT9WVFk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FkaB+8hU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720216270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyCosjYZowLgthiefSmgKAH8gA0MkEzux0epotkjl/o=;
	b=uwT9WVFk6QPE3+AW4Ffzcb13w62PoqsGzUojxEBbAjwyhycjXqehJ6tYoXBaH+fqnOPy/g
	m6spL7DbIbqkgTRdbhfYX/ez6JxcLkAGNbd7KgT9+ZCxeRFXEs8GmJ1OUaiCR0jG4IpNsH
	lsc3TO/woTUc7hnlqM4vIuyUxh1uaoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720216270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyCosjYZowLgthiefSmgKAH8gA0MkEzux0epotkjl/o=;
	b=FkaB+8hUqkq5ZtlLvg8K7+RLDLmJnEYk/1h1TLP0JYqhOYyhyE32NPyx/bwyxTSL2Inanf
	2TK3lS9PSJzJEUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AC2313889;
	Fri,  5 Jul 2024 21:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ann2L8pqiGaSDQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 05 Jul 2024 21:51:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: Security issue in NFS localio
In-reply-to: <ZocvhIoQfzzhp+mh@dread.disaster.area>
References: <>, <ZocvhIoQfzzhp+mh@dread.disaster.area>
Date: Sat, 06 Jul 2024 07:51:03 +1000
Message-id: <172021626347.11489.9592570650036340361@noble.neil.brown.name>
X-Rspamd-Queue-Id: D559021AAE
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,irix7.com:url,suse.de:email,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 05 Jul 2024, Dave Chinner wrote:
> On Thu, Jul 04, 2024 at 07:00:23PM +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Jul 3, 2024, at 6:24 PM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > 
> > > I've been pondering security questions with localio - particularly
> > > wondering what questions I need to ask.  I've found three focal points
> > > which overlap but help me organise my thoughts:
> > > 1- the LOCALIO RPC protocol
> > > 2- the 'auth_domain' that nfsd uses to authorise access
> > > 3- the credential that is used to access the file
> > > 
> > > 1/ It occurs to me that I could find out the UUID reported by a given
> > > local server (just ask it over the RPC connection), find out the
> > > filehandle for some file that I don't have write access to (not too
> > > hard), and create a private NFS server (hacking nfs-ganasha?) which
> > > reports the same uuid and reports that I have access to a file with
> > > that filehandle.  If I then mount from that server inside a private
> > > container on the same host that is running the local server, I would get
> > > localio access to the target file.
> 
> This seems amazingly complex for something that is actually really
> simple.  Keep in mind that I am speaking from having direct
> experience with developing and maintaining NFS client IO bypass
> infrastructure from when I worked at SGI as an NFS engineer.
> 
> So, let's look at the Irix NFS client/server and the "Bulk Data
> Service" protocol extensions that SGI wrote for NFSv3 back in the
> mid 1990s.  Here's an overview from the 1996 product documentation
> "Getting Started with BDSpro":
> 
> https://irix7.com/techpubs/007-3274-001.pdf

Interesting work.  Thanks for the pointer.

It appear to me that BDS uses a separate network protocol - possibly
over a separate TCP connection or even a separate fabric - to connect
client to server, and this protocol is tuned for high throughput data
transfer and nothing else.  Makes perfect sense.

It would seem to still use the IP address (or similar NFS-style
mechanism) to authenticate each party to the other and to establish a
path for the data to flow over.  This is the question facing localio in
the text of mine that you quote above.  We don't want a network data
flow.  We want to hand over a file descriptor (or 'struct file').  There
is no standard way to achieve this over an IP-connected channel.  So we
are creating one.

The proposed protocol is to send a unique number over the IP-connected
channel, and use that to achieve rendezvous between the in-kernel client
and the in-kernel server.  The interesting questions are around how
unique this number should be, which direction it should travel, and
whether anything else other than the file descriptor should be passed
through when the kernel sides rendezvous.

I don't think the documentation on BDS sheds any particular light on
this question.

Thanks,
NeilBrown

