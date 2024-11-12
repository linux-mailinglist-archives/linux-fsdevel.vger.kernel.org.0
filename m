Return-Path: <linux-fsdevel+bounces-34563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95209C6593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FEDB2F403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E205C21B453;
	Tue, 12 Nov 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="BmZo0SjY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3eNB34l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC21531C4;
	Tue, 12 Nov 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452594; cv=none; b=Na5dsDMJ+JvVWyZE8Ii4riUcqKJwKfVw+sUds+jm6tVY27iAT9Y2fBhoCcwex8Eev89igWp/sPXABVnOAjXQ4tLZVL7DwmilM2dHCdnH5G3kIFGws79AlVhMFqUmyus0H9QGGIlCqvcwcW2+ZKuXsyESWIaKPrH2+k935QEgx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452594; c=relaxed/simple;
	bh=x+y8/UzMtqi36p1A9OnR8/J/5AGKh+xLS9ee6QQzDLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UD0Ztm0qwNQ1/lNJSLTOiFGh0us2QQgWyt53Bha370qFo/wWnMG62m5IIhMmBpDoB2mofmcPBRcfF9Iaq30xncj3sN+gk7sRlvOuRli7W+QFqzcPYlkUbnRqY/s5gn8xRshBeTKvQlImLvz/p5WeUcem4WL5ti8gh1a1Wns3ZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=BmZo0SjY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3eNB34l; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A0771380439;
	Tue, 12 Nov 2024 18:03:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 12 Nov 2024 18:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731452591;
	 x=1731538991; bh=/RtfmugiFxrOsJ4jjn0jMQET4n5c564vMOygL27bFDA=; b=
	BmZo0SjYdtFt9zs8tUBZIFdcbRsnZBw8Z7QbqGjMNbIX1aQ1nz+L4exzAtSAbivB
	jEXAE+JH8E5bpNB3zWHrLNwjeLsYXv+dBucoRPq/70Oc8t7IBKdZF/wL6+H5/ex6
	cFUOMonAgBbwOsddXovqET19YCvrx4DLbYMUEhsac0YcpuiKOg8dyQnuhXCIGxs4
	t4L72rCtBa0d5RPTUiKf8OMjTWhxqEAgx7akLyPkBgZ+JfxlQ3b08sdIZSrsTz8B
	Z+QVwsopT8+rip51h4L7aQNLfuFlhvEWzrhY+8GRERBTs29Cq1G5+Zl0kuVCWslG
	ZXWFkmZ6jTw7Ax1IpR5x/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731452591; x=
	1731538991; bh=/RtfmugiFxrOsJ4jjn0jMQET4n5c564vMOygL27bFDA=; b=c
	3eNB34lnOuuW5EPehWtIDY82cpC3/aMN2GJydOigHJO9k8BP4hddIt+tdFuRLQZi
	IkrJ7EjevuPLoMTjyLURAspchLmB2g4tvBaqyn8E9Fc/XpFUkmcBcD/9QGf9JDSj
	LsYTUPfd8F72BaxcR7Q80swJK2VdkZyBhmJ8LqZNj9w7Fzs7ZIuUDUeg8QwpXFg+
	doYYMIalZfq7zreT0fHBQgKTLNgS5fdZxfOBtc3+Oe9C1k9C52oF83baHho2xBJl
	hUBcCR5IKCDgTYj0HKzPqUc8vS9bmSySFMQyQBoF4H6Lcio9OSyRJGaF+fff+TT3
	bChyYZlruWTKXzripg+Xg==
X-ME-Sender: <xms:r94zZxH_B9vJEiQcwOUxnoDcTUTlMcezbaR5tRpdDKngPcdvkNhS3w>
    <xme:r94zZ2X8MpsP5TfXXw9kw4AyCdYa01qToOXyKGa80EEdKMrX7IC7esm04phZklUAk
    NA0xujaxd0mP22SnmM>
X-ME-Received: <xmr:r94zZzKN9B0e3mo9RKZpC80vzy6uHjp0UgH_rgc0pxkXQhm_5wFsRDD9cMFFWI8Qad7GN0h1rYhRiGGVDTe429YHsXuF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepgeeghfejjeegtdfgfefhtdfhuedvjedu
    leeflefhjeetleeikeejgeeggefggedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishhtihgrnhessghrrghunhgvrhdrihhopdhrtghpthhtohep
    phgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopegslhhutggrseguvg
    gsihgrnhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomh
X-ME-Proxy: <xmx:r94zZ3F29kLupuw7xpTsAB_qSUr-bl4nKYmGEKn7UfyZ95agci3_Yg>
    <xmx:r94zZ3W4yVvs3eCgzEKo5eF2dWr_dmKYkKy53QFEgfaiA4VX3LJoAA>
    <xmx:r94zZyNEX1MWJCyTZrIsT48MEvJyxrTaVgQgEBscyQZ2UV-xeVxm6A>
    <xmx:r94zZ20GqbM4J7Rqvn4cgJbpKtJy78gjrJLmPdYvJGAPW6A2rPrwgA>
    <xmx:r94zZ3QVyhWe7XdmpffAoLTMatIBM5m-899lk9khzlkhtssGYNMa-8Tw>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 18:03:09 -0500 (EST)
Message-ID: <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu>
Date: Wed, 13 Nov 2024 00:03:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, paul@paul-moore.com, bluca@debian.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241112-banknoten-ehebett-211d59cb101e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/11/2024 14:10, Christian Brauner wrote:
> Sorry for the delayed reply (I'm recovering from a lengthy illness.).
No worries on my part, and I hope you're feeling better!
> I like the idea in general. I think this is really useful. A few of my
> thoughts but I need input from Amir and Jeff:
>
> * In the last patch of the series you already implement decoding of
>   pidfd file handles by adding a .fh_to_dentry export_operations method.
>
>   There are a few things to consider because of how open_by_handle_at()
>   works.
>
>   - open_by_handle_at() needs to be restricted so it only creates pidfds
>     from pidfs file handles that resolve to a struct pid that is
>     reachable in the caller's pid namespace. In other words, it should
>     mirror pidfd_open().
>
>     Put another way, open_by_handle_at() must not be usable to open
>     arbitrary pids to prevent a container from constructing a pidfd file
>     handle for a process that lives outside it's pid namespace
>     hierarchy.
>
>     With this restriction in place open_by_handle_at() can be available
>     to let unprivileged processes open pidfd file handles.
>
>     Related to that, I don't think we need to make open_by_handle_at()
>     open arbitrary pidfd file handles via CAP_DAC_READ_SEARCH. Simply
>     because any process in the initial pid namespace can open any other
>     process via pidfd_open() anyway because pid namespaces are
>     hierarchical.
>
>     IOW, CAP_DAC_READ_SEARCH must not override the restriction that the
>     provided pidfs file handle must be reachable from the caller's pid
>     namespace.

The pid_vnr(pid) == 0 check catches this case -- we return an error to the
caller if there isn't a pid mapping in the caller's namespace

Perhaps I should have called this out explicitly.

>   - open_by_handle_at() uses may_decode_fh() to determine whether it's
>     possible to decode a file handle as an unprivileged user. The
>     current checks don't make sense for pidfs. Conceptually, I think
>     there don't need to place any restrictions based on global
>     CAP_DAC_READ_SEARCH, owning user namespace of the superblock or
>     mount on pidfs file handles.
>
>     The only restriction that matters is that the requested pidfs file
>     handle is reachable from the caller's pid namespace.

I wonder if this could be handled through an addition to export_operations'
flags member?

>   - A pidfd always has exactly a single inode and a single dentry.
>     There's no aliases.
>
>   - Generally, in my naive opinion, I think that decoding pidfs file
>     handles should be a lot simpler than decoding regular path based
>     file handles. Because there should be no need to verify any
>     ancestors, or reconnect paths. Pidfs also doesn't have directory
>     inodes, only regular inodes. In other words, any dentry is
>     acceptable.
>
>     Essentially, the only thing we need is for exportfs_decode_fh_raw()
>     to verify that the provided pidfs file handle is resolvable in the
>     caller's pid namespace. If so we're done. The challenge is how to
>     nicely plumb this into the code without it sticking out like a sore
>     thumb.

Theoretically you should be able to use PIDFD_SELF as well (assuming that
makes its way into mainline this release :-)) but I am a bit concerned about
potentially polluting the open_by_handle_at logic with pidfd specificities.

>   - Pidfs should not be exportable via NFS. It doesn't make sense.

Hmm, I guess I might have made that possible, though I'm certainly not
familiar enough with the internals of nfsd to be able to test if I've done
so.

I guess probably this case calls for another export_ops flag? Not like we're
short on them

Thanks,
    - Erin


