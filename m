Return-Path: <linux-fsdevel+bounces-34561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2259C646B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EFA284775
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562321A6EC;
	Tue, 12 Nov 2024 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="lqWAntY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9M0w1bl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A361193092;
	Tue, 12 Nov 2024 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451400; cv=none; b=X1TLS5jpuHK4Qhk/NhHic06D/KaseR/e/gNAnXwXoXe+Ko7n6xDXJMYwB8oGR3BlUQGUFCJ2fv2bI+jWwNc1qtUwyQNzm62DJuOEM2YsdUOstxpnBz3xp/pp0NwqXhYdIs7CBCcHc8i1lOjJziQ8ed58W45D/4kQdyzh9JbdZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451400; c=relaxed/simple;
	bh=S1wVcckIE3Q0p8inxdVqd18+qurxZlyg8uHDkd/BRsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWIKZfw4C6/1xfxo2steuXJ2VHctmtuNn8H5jSAX4VNqemno4onRGXs22Gnf0D9fPBUY3aF0+HPdaAUUjENGDj5BXBZVkZrkMY0rTLgTSKpmlCpW2h3f5I1W1ZZyGXfegE6sqPY43GSzkRpSXfRA1wM5LYIUUMvQL9yh0owMOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=lqWAntY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9M0w1bl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48AC51140145;
	Tue, 12 Nov 2024 17:43:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 17:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731451397;
	 x=1731537797; bh=S1wVcckIE3Q0p8inxdVqd18+qurxZlyg8uHDkd/BRsw=; b=
	lqWAntY6mKovS+JviRX59cWpH63iQfMzs4siON4EjJz45C4yawXsrNuH/wq9My8h
	/IUlSMY3LgQ9vRRgrvXj58DIESYsgHtt4nse54OVUjMgpQLu4R4jOMQjP/vqpF28
	DPt3bGHEc+srN0F+iGWRUwYMOZ29Bur3Q25aqw0d/qWGG6rS0I+XTUhUCrena/7s
	MxHhye745VRWV9GXFQvvolLdr0AUl1OTbShnOT44nL/7NnzjhYpL0THZcT/df211
	0EXYaNLQZMJ9ueeV6kvuAR4eFCdtY/rd21aAKAX7OnWccJD4bO73Y02NzBBDyIF6
	DkI49rImv1lVNYmyKqsZ5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731451397; x=
	1731537797; bh=S1wVcckIE3Q0p8inxdVqd18+qurxZlyg8uHDkd/BRsw=; b=A
	9M0w1blB1Ai5Vx4SfnjqvW/TEdS6fb9Pqg2abmwe1naST/hkYcaRH9oSaKNnyGbE
	UbN3V9dSKRc+rojkm3I+7GQSpWMrbHARaDzcPZI3VUJQnxxkZnFXLnv6F+wHVMci
	U3H2WHpnqPVw2vPAeAYE0tpQWQijEQothHdf5CabE9Sd1kqcV7zJslDAQ/TEPLd7
	CO9g7uLYntIWfFOQAvSAneC0cvbG796Zfvggy0ss4IZRqphf6w9gFyVeJQCvtpFl
	SzNnwQPCBezbl58jA9U6ehiu0so0+RppWllBpKNqYo6w9Ztt+L/34vv1Cqei12Mr
	nJZWjlkEvfdqG7UNGH4wQ==
X-ME-Sender: <xms:BNozZ0JulaS3GqPDq9tPND-LH8n4ED-cV5m6YkR0al64pfvntROkFQ>
    <xme:BNozZ0JafX3Laem0cxrx648tQcHYicd1rKhUyCBrqmBcExSplpV_8shcgfa_i7xi5
    QLX9Jas6sXCBV_ZKic>
X-ME-Received: <xmr:BNozZ0sSr3UjT-p4bJsfa2IxQODtI0YcIoSzElxJ-CCntA9mhzbvP1p1NFuNAaercwONIq3sBJ2DRTy__WqxZNX_RyM2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhgrhi
    htohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishhtihgrnhessghrrghunhgvrhdrihhopdhrtghpthhtohep
    phgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegslhhutggrseguvg
    gsihgrnhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomh
X-ME-Proxy: <xmx:BNozZxaYAZJGid20vzrSVz4LKQnf5mCV2-2N4OfVm9EWXY2SiDmv-Q>
    <xmx:BNozZ7ZJ3R1KiwkXF0J55Vl7_jpC6hbifDczoVwpYHAx192hPSl8RA>
    <xmx:BNozZ9CCINAI0u_YAAmP2mYvcNjfFH0Un8ZqAis2dbnm293BRL1Qkg>
    <xmx:BNozZxYkvD1wedQuHA0RIKBmG7irPuT-mPvK_bItyotXTAcmn4LeKw>
    <xmx:BdozZ1nqpFyCCqihm1OfKyzMhS5te6CRlszgERM-Ib6iX8uJ1RGa7o8h>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 17:43:14 -0500 (EST)
Message-ID: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
Date: Tue, 12 Nov 2024 23:43:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Content-Language: en-GB
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, paul@paul-moore.com, bluca@debian.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <45e2da5392c07cfc139a014fbac512bfe14113a7.camel@kernel.org>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <45e2da5392c07cfc139a014fbac512bfe14113a7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2024 14:57, Jeff Layton wrote:
> On Tue, 2024-11-12 at 14:10 +0100, Christian Brauner wrote:
> We should really just move to storing 64-bit inode numbers internally
> on 32-bit machines. That would at least make statx() give you all 64
> bits on 32-bit host.

I think that would be ideal from the perspective of exposing it to
userspace.
It does leave the question of going back from inode to pidfd unsolved
though.I like the name_to_handle_at/open_by_handle_at approach because
it neatly solves both sides of the problem with APIs we already have and
understand

> Hmm... I guess pid namespaces don't have a convenient 64-bit ID like
> mount namespaces do? In that case, stashing the pid from init_ns is
> probably the next best thing.

Not that I could identify, no; so stashing the PID seemed like the most
pragmatic
approach.

I'm not 100% sure it should be a documented property of the file handle
format; I
somewhat think that everything after the PID inode should be opaque to
userspace
and subject to change in the future (to the point I considered xoring it
with a
magic constant to make it less obvious to userspace/make it more obvious
that its
not to be relied upon; but that to my knowledge is not something that
the kernel
has done elsewhere).

- Erin


