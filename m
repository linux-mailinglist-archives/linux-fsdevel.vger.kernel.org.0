Return-Path: <linux-fsdevel+bounces-74558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88ED3BB14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 23:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE1A3049C51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C32F6168;
	Mon, 19 Jan 2026 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ofY8Uvzx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fx0xk72+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B0258CD0;
	Mon, 19 Jan 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863549; cv=none; b=RA98U/4DavrNIhmAxMzVxKFgaIBkyiyRS+y273sQN5ifZPCMNqaWUhGE00c81eSlKgmumrxM03IRal7JH9yWitUdgvRSzP/GDKw+bdE9pP7d6p1zs0uNCjAHmJaPIOEdHSfYos8eFRE+ZfvcuvVGEUej2fheY5HIP674U17XCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863549; c=relaxed/simple;
	bh=RWZzL7YQJ/annm+jWFFRNMaS5ENVk6Sw607VKnmsqBA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CtxCN2bokGk0lBF1CBuEMa+8WDDPsJGJHOno4ISdayXRooxIoqaRMHKeV6stXujcAL6sObLOCox8Vp2mOl30969WEPvBV0zMhOZ6wRFTldrdhy3SZB265ArzIQIwWyNQEUVflvuvDhkt7hAashi6nKxHHB7tRCRp+CVvfranhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ofY8Uvzx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fx0xk72+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7100D7A056F;
	Mon, 19 Jan 2026 17:59:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 17:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768863545; x=1768949945; bh=bz2TewlI2uUm1dJzyRp4m6I64oFJRVivm0f
	KFmemrmc=; b=ofY8UvzxWOv8CAnkRYuBmsrlP4zkk/qTL+xcba9DMxqbyTrUjay
	9c3UNapDJhcWC6/Tp+H9OlO7vz87PM2RS1KFbJyUJa199T2fzBY+WRRrOv5ao1tT
	gPZM8vb/txWsCBaxAYJIoDw0Uas0QQ/o2RMFTeNz9S3mQ3THXc4jlPouJRF64ff7
	o9/A0c569GCzgwlI/3DiYvLOXitSc+6w1fady0Ih0vH//craKMpLV81o8i6EVYL+
	jsrN+ssP56pbEZtcnshjmu07zOVAL4uHljTSzCF/oBNf4alXOe+Ku7bdGFI+akfm
	zi0kBQsxAaQP2KLIThWwUT5KtVvKFMLyzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768863545; x=
	1768949945; bh=bz2TewlI2uUm1dJzyRp4m6I64oFJRVivm0fKFmemrmc=; b=f
	x0xk72+bPDBh7du/wt7s5slF6Q91i510qaUTJ3mvkNee109ou2dvRBQ0vPiRwaEC
	dKVhT/gXTIV+6wvRjeksZRn1XaoOFCfGpDnfDPECcQf3R6k4NlD0uOxhsk1e2FbM
	INVMwM9WIilfhdd1okUlSUUDboC3TYHz7oKdEVrUuc1p6Vv08rEr+qBgxez9Vvzl
	1ZM9cz/QIDnJLb/SesXCnDUlaxXqXrUN7VJ7VcGO8ENvipmj2m2fQxp2M9S5meyF
	On7EaBDrMPrUL/73eIL/X2ONcCWZ9oeMN550iPwCBuwWYggX60m39tsslTTtrvH/
	EJZJKtw9A2Ti4MP1u8/pQ==
X-ME-Sender: <xms:OLduaZo2fNVHrzRH1_u47SVwWyVeVhoWEd0rAp9PAMg99p1B34PEsA>
    <xme:OLduaTxt6IumXm67pvGk911NlUe8JqLM_SvkYA6rKRxZG28hTvrqZnUvQ26QpGcS9
    W-qtbHmiEQhBpUjE7BBgPNUJzkpbINnAyPd_bM_0lJGxqz2sw>
X-ME-Received: <xmr:OLduaVt4A-kf9olMlgTPj3eWKq_cTNWsyBQPRHiHNe7erJu8KjNfAdOSKxY4EtaHmNsSYbGiBQAur5GaeKwow-X11CGNDBYqrOQm4COA4moQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlvghnnhgrrhhtsehpohgvthhtvghrihhnghdrnhgvthdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OLduaU1_6oTMdJE1Z7gADrvjMQbczQVyFSjQg6G9i1knm9hgfLFfEQ>
    <xmx:OLduaVCDI-QeP5RFuVGUAGLJqZiVNoQFQBZ2XHisHENhRYoJjZBd8A>
    <xmx:OLduaaBoRt4WuOnXQsyYnMn8aV6vZvXjk3pqzlHydznhzRoe05yuKg>
    <xmx:OLduaelWZLK1ULGycjYfAqZCgwXvl5-f1xFCZygMgKQi0kZgakSRkA>
    <xmx:Obduaf2NSg7E0fPj495ZSa8kP6c_so4PlyC61LwSvSNcdjOfQM4eMJdh>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 17:59:01 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org, "Lennart Poettering" <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <937fea401a129217af5b6c7c5cb0b45f738456d6.camel@kernel.org>
References: <>, <937fea401a129217af5b6c7c5cb0b45f738456d6.camel@kernel.org>
Date: Tue, 20 Jan 2026 09:58:58 +1100
Message-id: <176886353801.16766.16781294574236684165@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 20 Jan 2026, Jeff Layton wrote:
> On Tue, 2026-01-20 at 08:06 +1100, NeilBrown wrote:
> > 
> > 
> > Thanks for the info.
> > 
> > I wonder if nfsd should refuse to export filesystems which have a
> > .permission function, as they clearly are something special.
> > 
> > 
> 
> That would exclude a lot of filesystems that are currently exportable
> (including NFS). I don't think we want to do that.

I was referring to the .permission function in export_operations, not
the one in inode_operations (and no, it isn't confusing at all that
both structs have the ops with the same name but different
function....).

NFS doesn't define .permission in export_operations.  Only pidfs and
nsfs do.

NeilBrown

> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


