Return-Path: <linux-fsdevel+bounces-27458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9446961967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091281C23192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521801D3643;
	Tue, 27 Aug 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z/q1tMk3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AvV4ECQf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2SOH9a5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ITG3snsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883613B293;
	Tue, 27 Aug 2024 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795379; cv=none; b=ad65nHO1Viy9G+1hMHiOpLQjMr9j2lHij020AaRIGbxaYbhLt0nNo1/nhUHBlocRPiiRLd04TFPF52mIChjgygqNzTyX9i9ROMQnyHUjFf60G0MTKMRgAq7/gjl1MX39Bh7hNsHM0lzzUi23yYmjayucgvhHLLSQ/Uf4OkovS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795379; c=relaxed/simple;
	bh=B7sZmacpgzBdweMQMqmOzpZAzaG7gEI1eo4Ip9oOJCE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uCi8n6dHbc8FGKwBMgqMSHl+bH2cTTACaHImv2mVZfYk0Vnt4gBO9KGiqRUh2sEcAb78wj+Jjf15Rm2gL2zDJNNkC0yrfrbuP+Iw4lX3366Poh++rYx92KC1JVedm89jtH2ZjWY5Qb0RWJKeEBw6PHKnLkgVa5MGL8+g2TykatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z/q1tMk3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AvV4ECQf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2SOH9a5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ITG3snsq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E48921FB92;
	Tue, 27 Aug 2024 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724795376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQKW3mrdfQdfWl0ZStsmgPzDkN4wb8bG0OXvas3Ewfo=;
	b=Z/q1tMk39Os2uKl+biGs4BUJanUGmq3eMIvZHzyMwqbkQcZHa0WDEQMgVSHXWUZyk9P5/y
	R+DKTNk+tV1uILpgSGZl4vn52aljkLPqtBgprKoceeZfSKUfy69y6HsCJy0dHEEeUNj5gX
	UO6wv/iFJFp6F/yy/+ykfB4yLqh+b08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724795376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQKW3mrdfQdfWl0ZStsmgPzDkN4wb8bG0OXvas3Ewfo=;
	b=AvV4ECQf6qDGbrOokOH7e/IgkQWfQ+42xlsTKxVbOyzUV7gS0fj21IjG4EzThcSLX+DL7f
	0kAqWQm7jSbT5KBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2SOH9a5d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ITG3snsq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724795374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQKW3mrdfQdfWl0ZStsmgPzDkN4wb8bG0OXvas3Ewfo=;
	b=2SOH9a5dx2RC7+xAXGHjMGi/zGWbF9s8PRAMEDL8+03e9m3KhaaKoEPtmPe0Ngbc1NCzyf
	H4Sx0JUxVSYfY2oMbD9uJKum2pkEP+5Ek42meFGJvsSJuagvrat2on7a455+EgW1JMtdxm
	hF4QgHJQSPQkbsZt9J7B6Zi4S8pmntI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724795374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQKW3mrdfQdfWl0ZStsmgPzDkN4wb8bG0OXvas3Ewfo=;
	b=ITG3snsq2WEEyMwYh6gMK2wOo3AQO63mHK+Ev1HC6WKrJlsAGFpRNS/URY8/6qQSZE2LbT
	f33ZPcs23dYUy8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84AD213A20;
	Tue, 27 Aug 2024 21:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /u3BDuxJzmbRGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Aug 2024 21:49:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "anna@kernel.org" <anna@kernel.org>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v13 19/19] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
In-reply-to: <85bc01d0e200ead4c20560db1ecb731f7800e918.camel@hammerspace.com>
References:
 <>, <85bc01d0e200ead4c20560db1ecb731f7800e918.camel@hammerspace.com>
Date: Wed, 28 Aug 2024 07:49:21 +1000
Message-id: <172479536130.11014.15773937499235867355@noble.neil.brown.name>
X-Rspamd-Queue-Id: E48921FB92
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 27 Aug 2024, Trond Myklebust wrote:
> > 
> > 
> > > On Aug 25, 2024, at 9:56 PM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > While I'm not advocating for an over-the-wire request to map a
> > > filehandle to a struct nfsd_file*, I don't think you can
> > > convincingly
> > > argue against it without concrete performance measurements.
> > 
> 
> What is the value of doing an open over the wire? What are you trying
> to accomplish that can't be accomplished without going over the wire?

The advantage of going over the wire is avoiding code duplication.
The cost is latency.  Obviously the goal of LOCALIO is to find those
points where the latency saving justifies the code duplication.

When opening with AUTH_UNIX the code duplication to determine the
correct credential is small and easy to review.  If we ever wanted to
support KRB5 or TLS I would be a lot less comfortable about reviewing
the code duplication.

So I think it is worth considering whether an over-the-wire open is
really all that costly.  As I noted we already have an over-the-wire
request at open time.  We could conceivably send the LOCALIO-OPEN
request at the same time so as not to add latency.  We could receive the
reply through the in-kernel backchannel so there is no RPC reply.

That might all be too complex and might not be justified.  My point is
that I think the trade-offs are subtle and I think the FAQ answer cuts
off an avenue that hasn't really been explored.

Thanks,
NeilBrown

