Return-Path: <linux-fsdevel+bounces-78425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIJHFU+bn2mucwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:01:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C319FB15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A3393038A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29C331A66;
	Thu, 26 Feb 2026 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="I+BIJN1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atfl/zZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B619CCFC;
	Thu, 26 Feb 2026 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067636; cv=none; b=qigQu+4fQ0oSat2WH36k2jm6io7hD8R3c4qagBG/fbHClzU+xOi/vmoFItc542rcFBMdnR3gzFlSd08LNsivj/rM4Nra0+USd2oNbOWMO6CV7fcLbKPQ93pSOSRgl/z66kU0xuNmBEYPGYvUrwsfoTC1qO8oapqi0e72if04ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067636; c=relaxed/simple;
	bh=UuhlsRU3Apnqq4x1acHZwRHsXblX91wrBF6b/0zE4Zg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DG06x84WE1hYMko6JRSoXSyPpNV3RBaLMqnaQtKJwcjOfDaYm0nLVoGaaJUFWmqujrJLJ2LWi5+1izNj4X+BNe1zSq1eeMgJLi77o6KZ0wc94UmS5j1CVSVdT/qWnO+MiBI0YKZS9Y72JajHnK7GiKQuSAf0qzP7EzFPgdisd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=I+BIJN1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=atfl/zZ4; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 073CD1301680;
	Wed, 25 Feb 2026 20:00:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 20:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1772067631; x=1772074831; bh=MIfXBGDQB4RR7qswdmhZCaPdgdKBr+0rVg2
	Ck+fxHVw=; b=I+BIJN1yBbaT7Ye9NnHRN7RVbmR/fZZLe0tXB8yF8zn9oXauu82
	DCQb8SWZsf2Eux70Szs13mXlKZJydWgAFhCkU613aKC6BynUEKyIJYvLWjNmMuTA
	Yq0Bel04MQ2ATiVCczLvA+HfXixsTYCDPFWHtIyj7HXmaFl79RWlvcQNTtQRyjKW
	n5tiq26wllB1dWR0649OQtna+Iy5678L6qs08lAcJa3Z3B3HDTKgCi/gKr/4VIor
	VkBT6VJH73t8vVvN4PYxGwKLBTT+RSR6OPcHfLTdfJvZgBLCBg4mjO5gc8q5UhoM
	HMaTnS0ufEBiNOLUkLQv/dD/A1ClZ8ZNc9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772067631; x=
	1772074831; bh=MIfXBGDQB4RR7qswdmhZCaPdgdKBr+0rVg2Ck+fxHVw=; b=a
	tfl/zZ4iH745WvQOalFyGLty4aVWIkMh/5MMH9bYfCswcXevMv3jQyYiqtpXnGm0
	9VcCLew1NcMO747wDJEtMVNQ/slb5OKeR+Joqkhh7wDujSxlj2Wp6IW9t7xowNf/
	aqpoX6qfp8uyrfHybhPw4IzMQpcoTCg44CYwdigB/NRFJpuj9UBFZNyzDHM6T4AK
	l76bogL7WO2pHeoii+bSfJGzoLsna2oDEEZJU/1hZH4m5OXcQI2vHka07AJjAqIi
	6vjtlGi2DPs1D8ve4/SN3TCKM7MpDT0Ae2GtBO8kKlulCA46U2SX3X9ge1X+M1ef
	kTjYg/6YC5VNwu8X/GqwA==
X-ME-Sender: <xms:LZufaftPMtWgdDkitaCZ4sVT-6XAkeOh-6kcN5Zc5X5JFt6vAvwgTg>
    <xme:LZufabQh5C40SDO2iOCH4SMcjda3hdy7bhGWpaBIDETm8zryjstVIDmbBjaZDBEQ8
    pIxyJJcpnlslY_9vr8-kPhc9XB3i99MK6LqlXp9BfqrVumcGQ>
X-ME-Received: <xmr:LZufaRDegemF-eP4MDBVSFtdh9LEkJuIrKSZ9lZKDOh7S31djt_Z4ATQLDS4pub-Eo6NKrGncaTY3GVvyfVkM5NQE6WLOWJkNritwUk6WLWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptggvphhhqdguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LZufadykdbrD4rR2UzHpn89Kimb0saqiyga-82ZaaSj3mwEb_7ZPHw>
    <xmx:LZufaZtalLykNeLq4-QIa8O1JMPOxcOCsJat4jMZ-skFRUgtkqvKCQ>
    <xmx:LZufaekgVJBUVEpjkNqsX17DKwx83aZM76pGrLOZgfcakE7MwkqAgQ>
    <xmx:LZufaWB1hCvkt45p98B7ynEJfQD-nJ6AzTvpQgc7kF1rq92_Ut6x3A>
    <xmx:L5ufaXim2lapcwkmze5KzM105VezEEs66Gr3kySkLij0WHxjT1xfbwxO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 20:00:21 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Carlos Maiolino" <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, netfs@lists.linux.dev,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: allow d_splice_alias() and d_add() to work on
 hashed dentries.
In-reply-to: <20250813050717.GD222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>,
 <20250812235228.3072318-9-neil@brown.name>, <20250813050717.GD222315@ZenIV>
Date: Thu, 26 Feb 2026 12:00:17 +1100
Message-id: <177206761798.7472.8904569543245678825@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78425-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,redhat.com,auristor.com,gmail.com,tyhicks.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,samba.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[31];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,brown.name:replyto,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: DC0C319FB15
X-Rspamd-Action: no action

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:11PM +1000, NeilBrown wrote:
> > Proposed locking changes will require a dentry to remain hashed during
> > all directory operations which are currently protected by i_rwsem, or
> > for there to be a controlled transition from one hashed dentry to
> > another which maintains the lock - which will then be on the dentry.
> > 
> > The current practice of dropping (unhashing) a dentry before calling
> > d_splice_alias() and d_add() defeats this need.
> > 
> > This patch changes d_splice_alias() and d_add() to accept a hashed
> > dentry and to only drop it when necessary immediately before an
> > alternate dentry is hashed.  These functions will, in a subsequent patch,
> > transfer the dentry locking across so that the name remains locked in
> > the directory.
> 
> The problem I have with that is the loss of information.  That is to
> say, "is it hashed here" is hard to deduce from code.  I would rather
> add d_splice_alias_hashed() and d_add_hashed(), and then see what's
> going on in specific callers.  
> 
> And yes, it requires analysis of places where we have d_drop()+d_add() -
> better have it done upfront than repeat it on every code audit *for*
> *each* *single* *call* *of* d_add(), including the ones that are currently
> obviously meant to be called for unhashed dentries.
> 
> I realize that it's no fun at all - in particular, I'd never been able
> to get ceph folks to explain what is and what is not possible there.
> 
> I would really hate to have that expand by order of magnitude - in
> effect, you make *all* calls of d_splice_alias() and d_add() similar
> mysteries.
> 

I'm picking this up at last ... only 6 months later.

d_add_hashed() would be much the same as d_instantiate(), and that
could be used for d_splice_alias() when the dentry is hashed.
There aren't any cases where d_splice_alias() is called with a directory
inode and a hashed dentry.

I think atomic_open is what makes this interesting.  It can be called
with a d_in_lookup() dentry, or a negative hashed dentry.  In the former
case, d_splice_alias() is appropriate.  In the latter, d_instantiate()
is best.

No filesystems makes that distinction clearly.

Most which provide atomic_open check for d_in_lookup() and perform a
lookup in that case, resulting in a hashed dentry - if positive they
just return it.

The exceptions are ceph, smb/client, and nfs.

They d_drop() (if unhashed for ceph, unconditionally for smb and nfs)
and then d_splice_alias().

So I could change these to:

 if (d_in_lookup(de))
    d_splice_alias(de, inode);
 else
    d_instantiate(de, inode);

or maybe we could have a new interface, though I can't think of a good
name.

Could we enhance d_instantiate to do d_splice_alias() in the case where
the dentry is d_in_lookup()?

Thanks,
NeilBrown

