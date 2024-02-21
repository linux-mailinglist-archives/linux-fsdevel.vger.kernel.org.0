Return-Path: <linux-fsdevel+bounces-12204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A35E85CDCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 03:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0F21F2676E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054D5CA1;
	Wed, 21 Feb 2024 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuOyfaD1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nSCnqiZo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuOyfaD1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nSCnqiZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DA4C8A;
	Wed, 21 Feb 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481726; cv=none; b=YheMwqHxkbYf+8nXduSfMiIwjc1U4BX/pOwYaeXviybY6xiy5RiSb2VKrF47kZMD7e84+A2ECE7gS0A0Lo/ZaJ63yzGjEW+eIYI7ZshHGTHYs3wgVy4CpyBIaLpkVl6ry15BCenmYz2ZAG+ZZNsoQj9OY3i6l+nJSPXhItX6xBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481726; c=relaxed/simple;
	bh=q5LTf7mdfsCVsV/WDnsC313bKj8Juks5lEPrZD/cjcM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FqifROdc+udU04CgN/J4iu9wBiXrJ9LxXj5TsoB/5hIrbj1Q0KOESTqn/LgwPm5V761l0ZyOC0jrC/icAjLMoSx4QmGkgrHGjLucEdqRpfkAkg0VhgJevIyAhvkU7IkOBuf4M2CEV+SD+TVe9dKLoWvo/t+f49YQ1Hgj4CAfwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuOyfaD1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nSCnqiZo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuOyfaD1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nSCnqiZo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BD4B1F889;
	Wed, 21 Feb 2024 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708481722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsV9jHwuIWpVRNglZYRAxztbyndApUNiw5FdxICdsok=;
	b=nuOyfaD1GdXkG0edoeq9YGbRXPIzHgIPCa50tQZYnRTiuiQXUogvyys2HAPwDl+Y5qCq//
	j+6gmNjcQWLVw2kRfkDXCvRh5j2Hxr/lVlxHI4bj9sfyFy2RupLXRQziFYYQff+KVtyzV2
	MDDfhRi6CXt8Ve1AabM1rv1NL1U8zBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708481722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsV9jHwuIWpVRNglZYRAxztbyndApUNiw5FdxICdsok=;
	b=nSCnqiZop5Q2SjDAcmGPdZCWVteYOl2OO+3zHFa/bpK8I8p1U1PXhPVBY8dwEPz8MoSW44
	iNjEvQiDID3pIeAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708481722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsV9jHwuIWpVRNglZYRAxztbyndApUNiw5FdxICdsok=;
	b=nuOyfaD1GdXkG0edoeq9YGbRXPIzHgIPCa50tQZYnRTiuiQXUogvyys2HAPwDl+Y5qCq//
	j+6gmNjcQWLVw2kRfkDXCvRh5j2Hxr/lVlxHI4bj9sfyFy2RupLXRQziFYYQff+KVtyzV2
	MDDfhRi6CXt8Ve1AabM1rv1NL1U8zBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708481722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsV9jHwuIWpVRNglZYRAxztbyndApUNiw5FdxICdsok=;
	b=nSCnqiZop5Q2SjDAcmGPdZCWVteYOl2OO+3zHFa/bpK8I8p1U1PXhPVBY8dwEPz8MoSW44
	iNjEvQiDID3pIeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8554B13A76;
	Wed, 21 Feb 2024 02:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tljQDrdc1WWJWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 21 Feb 2024 02:15:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lsf-pc@lists.linux-foundation.org, "Christian Brauner" <christian@brauner.io>
 =?utf-8?q?=2C?= =?utf-8?q?St=C3=A9phane?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
In-reply-to: <ZdVQb9KoVqKJlsbD@casper.infradead.org>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>,
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>,
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>,
 <ZdVQb9KoVqKJlsbD@casper.infradead.org>
Date: Wed, 21 Feb 2024 13:15:12 +1100
Message-id: <170848171227.1530.1796367124497204056@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nuOyfaD1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nSCnqiZo
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3BD4B1F889
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

On Wed, 21 Feb 2024, Matthew Wilcox wrote:
> On Tue, Feb 20, 2024 at 07:25:58PM -0500, Kent Overstreet wrote:
> > But there's real advantages to getting rid of the string <-> integer
> > identifier mapping and plumbing strings all the way through:
> > 
> >  - creating a new sub-user can be done with nothing more than the new
> >    username version of setuid(); IOW, we can start a new named subuser
> >    for e.g. firefox without mucking with _any_ system state or tables
> > 
> >  - sharing filesystems between machines is always a pita because
> >    usernames might be the same but uids never are - let's kill that off,
> >    please
> 
> I feel like we need a bit of a survey of filesystems to see what is
> already supported and what are desirable properties.  Block filesystems
> are one thing, but network filesystems have been dealing with crap like
> this for decades.  I don't have a good handle on who supports what at
> this point.

NFSv4 uses textual user and group names.  With have an "idmap" service
which maps between name and number on each end.
This is needed when krb5 is used as kerberos identities are names, not
numbers.

But in my (admittedly limited) experience, when krb5 isn't used (and
probably also when it is), uids do match across the network. 
While the original NFSv4 didn't support it, and addendum allows
usernames made entirely of digits to be treated as numerical uids, and
that is what (almost) everyone uses.

It is certainly useful to mount "my" files from some other machine and
have them appear to have "my" uid locally which might be different from
the remote uid.  I think when two different machines both have two or
more particular users, it is extremely likely that a central uid data
base will be in use (ldap?) and so all uids will match.  No mapping
needed. 

(happy to be prove wrong...)

NeilBrown


> 
> As far as usernames being the same ... well, maybe.  I've been willy,
> mrw103, wilma (twice!), mawilc01 and probably a bunch of others I don't
> remember.  I don't think we'll ever get away from having a mapping
> between different naming authorities.
> 
> 


