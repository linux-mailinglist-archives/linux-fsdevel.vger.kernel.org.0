Return-Path: <linux-fsdevel+bounces-77620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCjyBGQplmnxbQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:04:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51277159C34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B6EC300A586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011A34A76A;
	Wed, 18 Feb 2026 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="Bh/39XMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plf5A42Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48103311C32;
	Wed, 18 Feb 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448668; cv=none; b=Z+ts1KX6ED99hf16pNfwwB/naNdRfOWWIrGujF0339VQe6wnXFYM8ilCqKSozH5GZG6X2sAkUeQN59FYS/aZa1B+pG4HUoHh5b2R1M78xNGWQtjCNIjtpn2oxagA+8eHq2YycKY6Zr8S1xaSsgECNamM/TtJNFJatIcxF+6CqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448668; c=relaxed/simple;
	bh=//ZHD8C3KycWAjKcIrQijg9JtgcpYF5hca65+1F+vQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK/wK6GmpRBxr1Pq/3yulDYk0TITUqyESTcst1E2QIK1u7lRr0KhCCvL6nB4s11yv7kxXTbVpxeAuCg9qEWS7mThh66lCbjm+FZlowT4Cbfv3BMymf3l7IDfQ5B7RKgvDb9oI3lgd+zFT8rR6iIXiH9tGSTHxEIZtaR1znvmNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=Bh/39XMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=plf5A42Q; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A844D1D0009F;
	Wed, 18 Feb 2026 16:04:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 18 Feb 2026 16:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771448664; x=1771535064; bh=79/kJXt6NE
	qGLpu83/22II9pOyL9CJZBDcnxuiTjByE=; b=Bh/39XMQnn30o0s4flayPigsyj
	iLSxJdJxnt6/OODgLrfYAwvsthfWVN2ZOXNvgyDVSojr+mdYCSWiPNqvusO/gdzo
	mZi8PK7rtcRUiwDiFNO1/EE7Hc1H3RlYEOA2qwNlAtI3Us3/Tx7IPSrZWEeqoe2Q
	J4IxytiWUqW12hyDSwUbqYMPUkiRblqQN8oXKHA9RTSDi70NMyWSjTzoset4usrl
	kqlSMlrC762jp16JSib047e0xN2pnHd74QyGofVXuYIemOrKRQYxJYCjsnBS3woR
	6g0nIwHjv6W4dqfWOydiby7HNp0VPFLdHXAf+X1JuT7OoILI/YVsYNBGhH7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771448664; x=1771535064; bh=79/kJXt6NEqGLpu83/22II9pOyL9CJZBDcn
	xuiTjByE=; b=plf5A42Q+m2vLEDVo+GEDFNfNo6E6+Kl88RUWt1TW+yNjqFpFhq
	gVKwHjP7+u7UT3QocF0auccylkpWDVBRxsNPXuDR21sEz9ZPXKytOzZjxM0cTD94
	P80ZRl6lXdMy3qopRIBEg23FwwugIBxc76xaIdbfx1dV2Vvby0htIK4Le5QpoKse
	+O3bPhTOiP/oJLjoEjRV2cTNNbTU1tetxgoO/DVoezX/0cAMbvM+DU+/h6kvUT3r
	hvtrc9GYtNws2N1rUfjnNztclxf8UiUrJZyehzPiHzTLiKObVRgSBTAhp9AJOTxo
	D3An0tniQvkFjfNwc/23grTv1DcMEqWsnkA==
X-ME-Sender: <xms:VymWaSrIzlXjCsnAYGCr6xdql40_0LTWNqWB6zX29PQhU9nFGKQqug>
    <xme:VymWaXlTfFj0KZGeV51jL5MXBHrcX8spy7EBb9yo8qxBYpV2BmfCUjJ4uwnnza98G
    cnR6iMmXjjsb6iy6Vy4QrJz5V8WHncpvO2h4UTPQaO_tttzrXgJJYU>
X-ME-Received: <xmr:VymWacSSafM0PsnWDUm7AgS2Msq20DMBattPcZ0xsxwdl4ZQo7y-FymK3Cmi_dTfK8xDvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepfeffgfelvdffgedtveelgfdtgefghfdvkefggeetieevjeekteduleevjefh
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnughrvghssegrnhgrrhgriigvlhdruggvpdhnsggprhgtphhtthhopeduledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhhithgvshhhrdhlihhsthesghhmrghilhdrtg
    homhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmtghgrhhofheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
    pdhrtghpthhtohepphgrnhhkrghjrdhrrghghhgrvheslhhinhhugidruggvvhdprhgtph
    htthhopehojhgrshifihhnsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhs
    fhdqphgtsehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtph
    htthhopehhtghhsehlshhtrdguvg
X-ME-Proxy: <xmx:VymWaZDNNedCP64l0E46dD9lLg36JpqYO1KPIWLHsYjbPIdv7y8wBg>
    <xmx:VymWacratkOjQM04gQdZl7bQRkeBFvXaU9-a_pdTCR0cXQhb_NnDQQ>
    <xmx:VymWaXh7dngNuF9kHXhZqnN1wxk8YQCeueKRXygZR8STS22FLxsaCw>
    <xmx:VymWaZyqTNM_2DYBW_uaObIxNOusgXnfMG2JPmTodyw7HkpAbGlJvg>
    <xmx:WCmWabh5bbTPfYVpP0IyJzPD9TpaBT-GGaehkCixY6X7M7HwcpitLldk>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 16:04:23 -0500 (EST)
Date: Wed, 18 Feb 2026 16:04:22 -0500
From: Andres Freund <andres@anarazel.de>
To: Jan Kara <jack@suse.cz>
Cc: Pankaj Raghav <pankaj.raghav@linux.dev>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, ritesh.list@gmail.com, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <vr6xl5ntbgh3ou6uahu425xknlseclqj5aweb2ntvyedrgree6@uwbqiqamzec6>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
 <umq2nlgxqp4xbrp23zjiajwd6ombed4dfwbajuh35xd4vphyee@26g2y6a4rdnu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <umq2nlgxqp4xbrp23zjiajwd6ombed4dfwbajuh35xd4vphyee@26g2y6a4rdnu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77620-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,anarazel.de:dkim]
X-Rspamd-Queue-Id: 51277159C34
X-Rspamd-Action: no action

Hi,

On 2026-02-18 18:37:45 +0100, Jan Kara wrote:
> On Tue 17-02-26 11:13:07, Andres Freund wrote:
> > Hm. It's somewhat painful to not know when we can write in what mode again -
> > with DIO that's not an issue. I guess we could use
> > sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) if we really needed to know?
> > Although the semantics of the SFR flags aren't particularly clear, so maybe
> > not?
> 
> If you used RWF_WRITETHROUGH for your writes (so you are sure IO has
> already started) then sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) would
> indeed be a safe way of waiting for that IO to complete (or just wait for
> the write(2) syscall itself to complete if we make RWF_WRITETHROUGH wait
> for IO completion as Dave suggests - but I guess writes may happen from
> multiple threads so that may be not very convenient and sync_file_range(2)
> might be actually easier).

For us a synchronously blocking RWF_WRITETHROUGH would actually be easier, I
think.

The issue with writes from multiple threads actually goes the other way for us
- without knowing when the IO actually completes, our buffer pool's state
cannot reflect whether there is ongoing IO for a buffer or not. So we would
always have to do sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) before doing
further IO.

Not knowing how many writes are actually outstanding also makes it harder for
us to avoid overwhelming the storage (triggering e.g. poor commit latency).

Greetings,

Andres Freund

