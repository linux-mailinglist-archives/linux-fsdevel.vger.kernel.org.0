Return-Path: <linux-fsdevel+bounces-79721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGamJMiWrWn84gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 16:33:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF0230F59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 16:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FE02301411D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B72874FE;
	Sun,  8 Mar 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="M8oMLKHe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNdLk/p3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF523EAB7;
	Sun,  8 Mar 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772983997; cv=none; b=jv0jI0DcOhqz40YOoX7IDDmR598cMNgy6BWRWGSl4IKWj6WmofUO+Rz7rCcf7//9Qjm1DHjWZIjPIJGxI7i8lVrDVmpIoNEduTeVw012mJ+P9Tqh3O9iE6cuDA9BgT0d7dCtqjZFzf7+g8QL9GuAhJxekhWF9p2Y8XmUR1s9SN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772983997; c=relaxed/simple;
	bh=+TuBzpmKnTWYsMNcFOOQUsN6k4xfkhutUhWMIzW2MtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgpUou+wXjfDMjax5ORvDb2JCMfj/Ul/jn188SZkj03youYZrMlj1aIau5wxJTEvCPGwpWwC9Q4KEigfti7LiMlLkAdHnhYjpyviOcqA7zk/ZNITQ4wbpN2s014g2EMquhxhlQI3LISd+AOlYv296Cl132ykq6lQ8ravK8tyOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=M8oMLKHe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNdLk/p3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 93A821D0000E;
	Sun,  8 Mar 2026 11:33:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 08 Mar 2026 11:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772983993;
	 x=1773070393; bh=j67XtJ9OGsdlKsg8v+Rh/M0QEDVD7WMs+occTWtaidE=; b=
	M8oMLKHeJC1qqUKI5wl4oHJh7TlqciEYhO6kYd7RzJ2jC4XoEhFuubaAPWAGuit+
	3JE3EKayzXDkDwXkVn3Fcmfb7D7Gd2fd+ztdjiYLLvTFscp4rAOmHZWaCo8T/hfr
	VJ06mIg0Y1VsBea+wPPBr9aj7Qv2+J2ybCeeT/ssvq7J9iPRtHP+a7TScPE4WUzu
	/HyffTZTwKpCuFxA3cOnWZQJOrYdr2nnAFcuI75M8pb1Pccn1voqqxaCi/et3QK7
	f8N4bbfjThQn7VPdu/JPn5XWY49A6iYaV25sb66F807jxUOegh2qWk/9Ho9yEjvw
	8aG+NibXye1ZKyYbfZV1uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772983993; x=
	1773070393; bh=j67XtJ9OGsdlKsg8v+Rh/M0QEDVD7WMs+occTWtaidE=; b=r
	NdLk/p32TQDKOBkrSnPA2MnysyMVa1WS+6lXiU81IfyWLSXZ4m9MXaKyWwxOnZsh
	X6GSMd6Xw53CYtt5hUKoNi23Ldd/c7y9VEJ8SE7KVWRe/IL/cr0b25pZYndIlZIB
	gwi5DouetHBxepC9B+1HcM482KeTOXJWVxcWR+SveGzv7c8X3ZjsKn40LUihfA43
	T4tJ8FU4zmnQhAinCgLgUzZdQVLNo+fBieTrnZjcXgEY9sSTpwJvKHi8BPgnSzY5
	Kg9L+AxNIOqYxoA5sjOdVeOy3hBy7NfUg7Y9Iybw4UXRx42sfAaDyRVBrHJVVO3+
	DnT48ti0Pvq1lrRM/3s4w==
X-ME-Sender: <xms:t5ataVwCm1DrshxsYPYAjikWwiata3XhjybKXJVu9wRn8VF4pWedGw>
    <xme:t5ataRL48WYmaazofgmpoG9726ua1f2FnGRLyRl3X2r44PM6sT0Ve8CP0SRCI8PrH
    rGsE4wH2SluW0f_2AU8zhTgOeKKFW2Er6UQL2VfBzffOSDdyWtBag>
X-ME-Received: <xmr:t5ataa2yko-EbDXivTKMVyzLWK43LK26FoGPv6CJraasA3aXJR4fBsPMXTCiAL68ncoEVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeehheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedtleelvdfgjedvffeiueekfeeuleffhfegfffhgfffkeevueehieehhfei
    gffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvgdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
    dprhgtphhtthhopehrihhtvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegujhifohhngh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    hprghnkhgrjhdrrhgrghhhrghvsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjrghs
    fihinheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlshhfqdhptgeslhhish
    htshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:t5atabdr7P5wMdbGIgFdb3ItIOC2ChWHV7AMfKIRxqK1W48aO0FLSQ>
    <xmx:t5atae7_j236xrkK0fKiAb7qogWk8a7ApPSSz1SSbBwZmBaL5IoZAQ>
    <xmx:t5atae9iAxo7ei6UuV1V5whjymcmGSwjfJspj-VputDXUjfJik0psA>
    <xmx:t5ataVL7cZ6ttfoZ9QCbSAFcajRLT-wbNEyIjafmvuPb5m9qassYdA>
    <xmx:uZataaeyBP_MPNczw099JYvNBOlN3bTUpmojFbk_LjJMiR9yZYqA1_33>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 11:33:11 -0400 (EDT)
Date: Sun, 8 Mar 2026 11:33:10 -0400
From: Andres Freund <andres@anarazel.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	Pankaj Raghav <pankaj.raghav@linux.dev>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, jack@suse.cz, ojaswin@linux.ibm.com, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <pyyeaqzjdpgkpjfyxkrlzawwwj6elzvidubtq73toufr7wgoec@prv4u3o5ixjy>
References: <v7f6u19i.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <v7f6u19i.ritesh.list@gmail.com>
X-Rspamd-Queue-Id: 31CF0230F59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79721-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lst.de,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anarazel.de:dkim,anarazel.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

Hi,

On 2026-03-08 14:49:21 +0530, Ritesh Harjani wrote:
> Andres Freund <andres@anarazel.de> writes:
> > On 2026-02-17 10:23:36 +0100, Amir Goldstein wrote:
> >> On Tue, Feb 17, 2026 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> >> >
> >> > I think a better session would be how we can help postgres to move
> >> > off buffered I/O instead of adding more special cases for them.
> >
> > FWIW, we are adding support for DIO (it's been added, but performance isn't
> > competitive for most workloads in the released versions yet, work to address
> > those issues is in progress).
> >
>
> Is postgres also planning to evaluate the performance gains by using DIO
> atomic writes available in upstream linux kernel? What would be
> interesting to see is the relative %delta with DIO atomic-writes v/s
> DIO non atomic writes.

For some limited workloads that comparison is possible today with minimal work
(albeit with some safety compromises, due to postgres not yet verifying that
the atomic boundaries are correct, but it's good enough for experiments), as
you can just disable the torn-page avoidance with a configuration parameter.


The gains from not needing full page writes (postgres' mechanism to protect
against torn pages) can be rather significant, as full page writes have
substantial overhead due to the higher journalling volume. The worst part of
the cost is that the cost decreases between checkpoints (because we don't need
to repeatedly log a full page images for the same page), just to then increase
again when the next checkpoint starts.  It's not uncommon that in the phase
just after the start of a checkpoint, WAL is over 90% of full page writes
(when not having full page write compression enabled), while later the same
workload only has a very small percentage of the overhead.  The biggest gain
from atomic writes will be the more even performance (important for real world
users), rather than the absolute increase in throughput.


Normal gains during the full page intensive phase are probably on the order of
20-35% for workload with many small transactions, bigger for workloads with
larger transactions. But if the increase in WAL volume pushes you above the
disk write throughput, the gains can be almost arbitrarily larger. E.g. on a
cloud disk with 100MB/s of write bandwidth, the difference between WAL
throughput of 50MB/s without full page writes and the same workload with full
page images generating ~300MB/s of WAL will obviously mean that you'll get
about < 1/3 of the transaction throughput while also not having any spare IO
capacity for anything other than WAL writes.


The reason I say limited workloads above is that upstream postgres does not
yet do smart enough write combining with DIO for data writes, I'd expect that
to be addressed later this year (but it's community open source, as you
presumably know from experience, that's not always easy to predict /
control). If the workload has a large fraction of data writes, the overhead of
that makes the DIO numbers too unrealistic.


Unfortunately all this means that the gains from atomic writes, be it for
buffered or direct IO, will very very heavily depend on the chosen workload
and by tweaking the workload / hardware you can inflate the gains to an almost
arbitrarily large degree.


This is also about more than throughput / latency, as the volume of WAL also
impacts the cost of retaining the WAL - often that's done for a while to allow
point-in-time-recovery (i.e. recovering an older base backup up to a precise
point in time, to recover from application bugs or operator errors).


Greetings,

Andres Freund

