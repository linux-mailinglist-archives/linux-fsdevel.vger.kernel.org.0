Return-Path: <linux-fsdevel+bounces-77389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PFCLbC2lGlMHQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:42:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5BC14F474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400CB301496B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FF374170;
	Tue, 17 Feb 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="suxc0XKu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9Uqrm69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBA280A29;
	Tue, 17 Feb 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353766; cv=none; b=jSDOCPmoVeYfWCt4O4RpuoxS5kQ3ZZJ3ppouEVBCmkrCjy+pCn/E0y/yhnhfpK8Bd5Rnfa1JGv/mDwGy4Fox1JTPu9MSp7AYaUN788AwrkveDIooOxSl1OXNgEu8B71X2gLZcRNZGkvV14XughVi+BF2IR/5Tc2VG9kipjRK0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353766; c=relaxed/simple;
	bh=Tim9+xAAp38GkPqFll5dGAwqa6OafgbrbBgQCgOaUR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqjRbTHg9d30wR2LG6fh+4WQ4B+o5KPA5xTWVaE/LHil8woEG4utvA8wO9zFY/GramNj6Jbr7elFCYYWCmFUb/nO33+u124wnJU3kUXh5vH30qJ5pKAjS2OhE+1Ef9MllIH0pSfU3ZGyvgsOCj3zijP1JpA3QUfxjBN9VrCDqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=suxc0XKu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9Uqrm69; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 15F84EC0321;
	Tue, 17 Feb 2026 13:42:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Feb 2026 13:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771353763; x=1771440163; bh=Tim9+xAAp3
	8GkPqFll5dGAwqa6OafgbrbBgQCgOaUR4=; b=suxc0XKuCX70QWE+Btruduu0mw
	sdm0uZN2FdjPKboJId6Lten3F3JJ9YZjIA7+dRWm4X/BZwEAmSJha0+RbYngVYkU
	tD62n2wzXjLTvVMLb+vovFtoBVYpNfI7jNEnjstEczIf9DrKYFuP6d9pLb12D17Z
	+SLzKQy+61uJNwjJw9mfDyU4JZLha+mLbiZkJ9kpcv7S28nL9OvXbBer0Ec1QQLI
	Jzh0gPygg0PAH8r2MMhz5C+SsppC3CN5X4sYRpe05zbxViTlZXYWKXjExwhBqV50
	nPTwVjXJlA2/Cmz/bRpDprGKN3+Sbqxw8fQL/yjp0d5GrnDnvCLSwVfdNCFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771353763; x=1771440163; bh=Tim9+xAAp38GkPqFll5dGAwqa6OafgbrbBg
	QCgOaUR4=; b=s9Uqrm69JkPh2X5OWT4A/0fQv1Gkbi2P2fTVZpNwU2hWHBRAvSY
	mDFRjy2fY01WAXVBwuQyIZg4RIab8dAMlkEU4qM4NWZA9EhziaOLIWOvXK5f5UUK
	+g3kA3lvZ4QsIMZMZDpFvp8viggvcsug8C2HziP0a6PuQIXNjh4Eh10FRZu4nLs6
	N0Iyo/ofn9Sm7kDaAnPJOL7rwja9wi1SQxK8G6Nr8U07cFKgx6SwEcbVGwF2Ug+A
	tGadeu+SYuaSTux3ojXE4S5RcWFiSV0QT/5zZ82zbsxuZzxo+oR6+9zlNFPs54Qz
	TASitGk/Z9h0LhwwNolO/k1dyxeNEhxhdmg==
X-ME-Sender: <xms:obaUac8jc8fMlE0yBod8v8xZNKZ6xzodK47LDrhrRtH_8OCJczJvqQ>
    <xme:obaUabqW6fdBwP0V13T8wtVWVaaOVPeQMewQqezSIbGK8xnGE8RCkCIlY2coZ1yxp
    A17H2BW5PDPg42cO7UOXFZmNbwiiG_3h_NxQIR54omzhWbJ7Y-7xg>
X-ME-Received: <xmr:obaUaXGbR10xinrEaNbvyFmnyDB-J0UKbdAKHsooyJ3GpfaOV8RnAe_1FLuAK5WKvNtMVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddthedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:obaUaTntBnx6rpqiHG9owA7Jy49X7iSEow-kxj5DbDtpfIKn4Jq9OQ>
    <xmx:obaUab8r_0CTVNWWlJ0bdAj3kehesx_tkQ3WRiIfHvsC3FPaqOMWZw>
    <xmx:obaUackR2WCzPIsXU-LmvctkKyz0kkvsi4pBsiUNI94d__4P10h10A>
    <xmx:obaUaRlx_yjIQRUjhWYZGkBATvKc_khebU0JAcF1PU8doWiObfwvOQ>
    <xmx:o7aUadldnWuydphqbxA0KBJbD5iQb4jYh5mXbY_wDBW1W-6VQaYcip6R>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:42:41 -0500 (EST)
Date: Tue, 17 Feb 2026 13:42:41 -0500
From: Andres Freund <andres@anarazel.de>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <pankaj.raghav@linux.dev>, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, 
	hch@lst.de, ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>, 
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, 
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <yamn4f3oympcvc4otmzrrjgwxd5xanvk5j376dojky76lrkfgv@agfxv32zyfvr>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
 <aZSzJs3WIuV4SQJp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZSzJs3WIuV4SQJp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anarazel.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anarazel.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77389-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,linux.dev,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andres@anarazel.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[anarazel.de:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anarazel.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E5BC14F474
X-Rspamd-Action: no action

Hi,

On 2026-02-17 23:57:50 +0530, Ojaswin Mujoo wrote:
> From my mental model and very high level understanding of Postgres' WAL
> model [1] I am under the impression that for moving from full page
> writes to RWF_ATOMIC, we would need to ensure that the **disk** write IO
> of any data buffer should go in an untorn fashion.

Right.


> Now, coming to your example, IIUC here we can actually tolerate to do
> the 2nd write above non atomically because it is already a sort of full
> page write in the journal.
>
> So lets say if we do something like:
>
> 0. Buffer has some initial value on disk
> 1. Write new rows into buffer
> 2. Write the buffer as RWF_ATOMIC
> 3. Overwrite the complete buffer which will journal all the contents
> 4. Write the buffer as non RWF_ATOMIC
> 5. Crash
>
> I think it is still possible to satisfy my assumption of **disk** IO
> being untorn. Example, here we can have an RWF_ATOMIC implementation
> where the data on disk after crash could either be in initial state 0.
> or be the new value after 4. This is not strictly the old or new
> semantic but still ensures the data is consistent.

The way I understand Jan is that, unless we are careful with the write in 4),
the write for 0) could still be in progress, with the copy from userspace to
the pagecache from 4 happening in the middle of the DMA for the write from 0),
leading to a torn page on-disk, even though the disk actually behaved
correctly.


> My naive understanding says that as long as disk has consistent/untorn
> data, like above, we can recover via the journal.

Yes, if that were true, we could recover. But if my understanding of Jan's
concern is right, that'd not necessarily be guaranteed.

Greetings,

Andres Freund

