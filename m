Return-Path: <linux-fsdevel+bounces-77374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA6eLcCVlGneFgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:22:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58F14E183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 17:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78259304E82E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920B36E496;
	Tue, 17 Feb 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="uQNjVCQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCu+80/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA121423C;
	Tue, 17 Feb 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345283; cv=none; b=B2sG2U21CmwAMWSdPOCx/wwiJfeDk+VeUu+j1yuaOtqaYr6d76TH8bo338ZdmrBiThj/C15fYsiL/hXw2UjzLvRQrSGg4Md3S81NKs82gGusFUXg8RzgsOOdR4X8awuqGhQa0B6UyfpZ2uylDisVp/06pvSNHX+Gyn0lgxM1kw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345283; c=relaxed/simple;
	bh=YIfrD1buDdUL/9uIoxgIBLpfc0E3QS9kkHD7Vo66888=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDd6V3JNmZ/kGRpajw9AvHEd1GMrMSsweyS9DQMk7aw54l17daEstQ2gWPcCVvprch7Z3PlI0eI8KQSuVsO8aX8H++CFzY0tHXhvrkCk1+hGG+izFSy05WsI/IfjPvse67CRZuySogh3Wu6Qix2JrUIhBTO48iS1zTCal5ixDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=uQNjVCQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCu+80/E; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1AED7A02EA;
	Tue, 17 Feb 2026 11:21:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 11:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771345281; x=1771431681; bh=TLUeZ5F3tO
	Y10JNA2p1BHXejENCtAykcv1Gn+DC81rE=; b=uQNjVCQC9X9F5StIFcthQyB+/2
	0eLnxGZfhCH22vl+jMjYUp+yjLLa3COMMLt2aQCP8csfgCPyg2kSOt0wSX/7Uadh
	61+WPDqgA+18YDsiDzkzgzaQsk7WlH8BKPWHTHDPtxd+YEUn7hwBm6O+stecCQon
	HALw0hlm9qmTQ4BhZvk9z2QXc2Kz1FqNNt1MI1CYjuXpymM8LrlysNqFbQNyQOYs
	jFJ/5v9PasfB4Z1FnU/T6dnzrm0VwsfVrO8wuI1Xx2Rdzk3b3Bj9iZhzBPNNP02O
	noXNSIZ43/umgD8Nzp+4rwYKgWCKd4XiONkCdeNmO6k2RGxK7IRMy7KKY7QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771345281; x=1771431681; bh=TLUeZ5F3tOY10JNA2p1BHXejENCtAykcv1G
	n+DC81rE=; b=VCu+80/EZiJyJBT9tjjOEtM6yFvMLCGv9EW1vd+W5dEciLbG6rP
	FfYTqCh8ditwkjQYLl1vUlRnvBXtAizzDw5eMX+l6gLtEDgL9Xj5/hL/NS5UM1r4
	rGa5gSTwuBA0DRycbwbwtEstGp88Po/0Jci3/vVwXaONvQAcPOtPD1QnPp3dfq18
	mojecoiiSWARNGKhdu5xsSykKn5ms/n78+7RylDa+NMMZe1hIZo8pz12YRTaM4nJ
	+KuTm2GstXT/M6pUMHOTrVS2V1KteDxT+RgBU3wnSGF/QBIEHnwSFgTmqkXI+nPT
	mhkpjDUcQp8IMGDJ+IZf7CRPFOXB1eednXw==
X-ME-Sender: <xms:gJWUaU8Ze8qUPt8xOQsz0Q9zLsszNKxxsnotLXScA29zgvvlBWSq-w>
    <xme:gJWUaToe3rphCXJLI3ZSfnYOHuxhHkjN1IAVByYkHeAxusxFhUEpQVYSQH-4N_TDv
    E9hKLXYMHJwI6xr47S3Jx9TORONtZsyEQg7h8Hp-lUbiPbdPmxA5A>
X-ME-Received: <xmr:gJWUafFMIvuHzz0E_aBccRd0yN-PPtysbCneUsPSY41WBNHFfizOIdKChobyeB2Y-RQJjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gJWUabmAnc-nIab0cp41AGUcRtQbP9_DCdFRKe_ySSkDIlyHWIr-DA>
    <xmx:gJWUaT_5oBp-1kCztHEfPRFd63ae6VEh3RqwH_ZjhRni7fmstEVSaw>
    <xmx:gJWUaUmRXtuzaj5Xo1WrTZjrcFY063eBpLHPxbZI_8ppooOk5dMnaQ>
    <xmx:gJWUaZm6Y84tWpETdgRGoX3r_vktvIvun1TJF7p66ovN3nU1NOqZpQ>
    <xmx:gZWUaVl15IfgmJQLO3oi-CdzG1EnzgkN23ZUr7-KzMej6UbqkYLnnVrH>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:21:20 -0500 (EST)
Date: Tue, 17 Feb 2026 11:21:20 -0500
From: Andres Freund <andres@anarazel.de>
To: Pankaj Raghav <pankaj.raghav@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, 
	hch@lst.de, ritesh.list@gmail.com, Luis Chamberlain <mcgrof@kernel.org>, 
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, 
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <ignmsoluhway2yllepl2djcjjaukjijq3ejrlf4uuvh57ru7ur@njkzymuvzfqf>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <4627056f-2ab9-4ff1-bca0-5d80f8f0bbab@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4627056f-2ab9-4ff1-bca0-5d80f8f0bbab@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-77374-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,anarazel.de:dkim]
X-Rspamd-Queue-Id: 1D58F14E183
X-Rspamd-Action: no action

Hi,

On 2026-02-17 13:42:35 +0100, Pankaj Raghav wrote:
> On 2/17/2026 1:06 PM, Jan Kara wrote:
> > On Mon 16-02-26 10:45:40, Andres Freund wrote:
> > > (*) As it turns out, it often seems to improves write throughput as well, if
> > > writeback is triggered by memory pressure instead of SYNC_FILE_RANGE_WRITE,
> > > linux seems to often trigger a lot more small random IO.
> > > 
> > > > So immediately writing them might be ok as long as we don't remove those
> > > > pages from the page cache like we do in RWF_UNCACHED.
> > > 
> > > Yes, it might.  I actually often have wished for something like a
> > > RWF_WRITEBACK flag...
> > 
> > I'd call it RWF_WRITETHROUGH but otherwise it makes sense.
> > 
> 
> One naive question: semantically what will be the difference between
> RWF_DSYNC and RWF_WRITETHROUGH? So RWF_DSYNC will be the sync version and
> RWF_WRITETHOUGH will be an async version where we kick off writeback
> immediately in the background and return?

Besides sync vs async:

If the device has a volatile write cache, RWF_DSYNC will trigger flushes for
the entire write cache or do FUA writes for just the RWF_DSYNC write. Which
wouldn't be needed for RWF_WRITETHROUGH, right?

I don't know if there will be devices that have a volatile write cache with
atomicity support for > 4kB, so maybe that's a distinction that's irrelevant
in practice for Postgres.  But for 4kB writes, the difference in throughput
and individual IO latency you get from many SSDs between using FUA writes /
cache flushes and not doing so are enormous.

Greetings,

Andres Freund

