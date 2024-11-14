Return-Path: <linux-fsdevel+bounces-34787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B99C8B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9812E28478A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D31FB3F3;
	Thu, 14 Nov 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="tDnp5pJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Foivi3xs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555218C32C;
	Thu, 14 Nov 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589992; cv=none; b=YFiliuat1lWpnOm7tiLqK8YAfm9s28J9gBmJLNSRpPphml4GlHUYdhwjufwcik+me9wR6nDABlwF72Mykn+ka4Yfmxu29WNsv17rjeV6hTAUjqNl6NJbJPpKNPsQhbwx1RwcyTvBq8WpdxdYI2Ve+lvJaJnu9XbS0hRQv0wrccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589992; c=relaxed/simple;
	bh=tM7ySo6Kpn7vyWqvzCyes2cnKVrtqHXCS71zGmGW0U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXH6ldxnw4DvGfrWztBzzNiu5cPsO58owIlO2lCs8oTD11gLi+dLxrGo0J6hQ/HggB5ciE9CfolmzjI+g7UKP4BUQWiL+VrevTsnVyg8chVDyCCJLYGE6Ndq1T6GLBFUAEnPDBV11keVNm8JyvbNp37d61NHM4Q5eGdr/Wk7gnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=tDnp5pJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Foivi3xs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04C051140175;
	Thu, 14 Nov 2024 08:13:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 14 Nov 2024 08:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731589990;
	 x=1731676390; bh=7S9abD+K8DEBZg7raKlMOuNnC0tcP4JK5OHXv9HNbfY=; b=
	tDnp5pJmemKCVICDGl2+a5A6f7VQ8utdFAY6U1xQqRHZhAtLYrU5DIqoKKXWVFwD
	Z5PhVDD0gnxKiVRh/ArMwlhwJkPq2idvK5/meJVDK1NwF3fjrXXgnWBz/UNKskK+
	p1keSY1SzDeAbFSPO77xvBEBuyohmMBf3rGkfzRPWWEu7BUTdR0+J5KgsAxven4g
	MXFBQG1z5QdgA8oO8tsg/bXyhVO43Y9m/NIF3ZtGbM5JjVEouUTA6FXmKIV3GT3g
	FkL2wi9Rnmzs9ktWxOpoF+/BXlzGPkIJZo8/JzJ+J6qwWyTtxKVECMFABhCwRzRa
	3DczdMrFjnaR/+iFznrRDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731589990; x=
	1731676390; bh=7S9abD+K8DEBZg7raKlMOuNnC0tcP4JK5OHXv9HNbfY=; b=F
	oivi3xsGqB3JEISos9OkQLWiIeipfjzd0whibN5tIF1AefRf6G16XypdWtudyaUN
	5i5qITwdx7g0ArVGoXyXh97VOnsLrRpBS9YrnbCzEIZdyE5kq7sREY004C+uyq4S
	8rC8AlHxpWWWeAXG6XWEp7llag1N+etJoxsi03wrNLK9o/qGQQkqrTubpAotK+0H
	lUavjVV8waypgpF3eoTPoD8DMDVQW1wRaQv24Q7TLInBpVZRTsHPRmr7/2XetXoe
	gqnfeSjovOmsY13XyvBFN3GvN82G22lweLEVCqR5xwPT+2EUtwSq61zv4kiRBGj3
	EEdcuKKkMfu9cPcNplMqA==
X-ME-Sender: <xms:Zfc1Z9kM0SNEAFCB9D8iZ5eg3kIIcJ1afdm9qBE7iNevtMUA_CDktg>
    <xme:Zfc1Z42Kj1_7tbAEcxNH5UBuDrynAYmKO94SBLPTE1pJUZ7Ay-aKu3Yx-DgvNuUDx
    QOioYf0ydZTixA_qew>
X-ME-Received: <xmr:Zfc1ZzoE9Z2hIajZzEENFsPndf44gtlxVjmOaaTroStwdQ10YX5VeivHQnT4ijpDyAeYPOUHfUtwfSWCjMKOf0PpWlmZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhi
    nhhugidrohhrghdruhhkpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpth
    htoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilh
    esghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Zfc1Z9lUetkFbml3IrSX00CcS_h5QH7BL7QUBCnSt6UKvzn9tiGx-A>
    <xmx:Zfc1Z73aoCOn2QcQLazibybt5OSIbRqaS9dHtvbAeY9_puseyGcivA>
    <xmx:Zfc1Z8uMJb0zvljPT5_d0Pi46wxmPP7gWMtNZbLRu47dOyJepw3YrA>
    <xmx:Zfc1Z_XlPI0o4aF6a8HxsyFQ4gsLU8pY2KCpCS3vWFVtvusIjo1rTQ>
    <xmx:Zfc1Z9xdIhx9KhflPZxvPc9UqbGOFSsFaBdOZdBxn3sDwuw1JBtbfENP>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 08:13:07 -0500 (EST)
Message-ID: <1128f3cd-38de-43a0-981e-ec1485ec9e3b@e43.eu>
Date: Thu, 14 Nov 2024 14:13:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
 <20241114-erhielten-mitziehen-68c7df0a2fa2@brauner>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241114-erhielten-mitziehen-68c7df0a2fa2@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2024 13:52, Christian Brauner wrote:

> I think you need at least something like the following completely
> untested draft on top:
>
> - the pidfs_finish_open_by_handle_at() is somewhat of a clutch to handle
>   thread vs thread-group pidfds but it works.
>
> - In contrast to pidfd_open() that uses dentry_open() to create a pidfd
>   open_by_handle_at() uses file_open_root(). That's overall fine but
>   makes pidfds subject to security hooks which they aren't via
>   pidfd_open(). It also necessitats pidfs_finish_open_by_handle_at().
>   There's probably other solutions I'm not currently seeing.

These two concerns combined with the special flag make me wonder if pidfs
is so much of a special snowflake we should just special case it up front
and skip all of the shared handle decode logic?

> - The exportfs_decode_fh_raw() call that's used to decode the pidfd is
>   passed vfs_dentry_acceptable() as acceptability callback. For pidfds
>   we don't need any of that functionality and we don't need any of the
>   disconnected dentry handling logic. So the easiest way to fix that is
>   to rely on EXPORT_OP_UNRESTRICTED_OPEN to skip everything. That in
>   turns means the only acceptability we have is the nop->fh_to_dentry()
>   callback for pidfs.

With the current logic we go exportfs_decode_fh_raw(...) ->
find_acceptable_alias(result) -> vfs_dentry_acceptable(context, result).


vfs_dentry_acceptable immediately returns 1 if ctx->flags is 0, which will
always be the case if EXPORT_OP_UNRESTRICTED_OPEN was set, so we immediately
fall back out of the call tree and return result.

So I'm not 100% sure we actually need this special case but I'm not opposed.

> - This all really needs rigorous selftests before we can even think of
>   merging any of this.

