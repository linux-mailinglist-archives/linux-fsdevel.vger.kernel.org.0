Return-Path: <linux-fsdevel+bounces-21319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C607901E7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B4D2837F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED97581D;
	Mon, 10 Jun 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="RabQY3O+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEIkqa0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E991DFD0;
	Mon, 10 Jun 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012463; cv=none; b=ZXcq+8u6IJt5XKh9lDmPCzr+QcIM0TFxEaiXTaO3/rDZOC8eP/bVRugA5cWlRaP2j3zMY2UpqPmPu1WoT9sEUnlfiaxGkp5qxqJ/7kNg4ngtdsgtf2BZyiswt1f7mm26Rp8Zza67mTem+wbB7T/e5SOx98nyZRSUMI60nt0oDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012463; c=relaxed/simple;
	bh=KNKCKklTuYVMpCezbUE7O/dEuK5srQjktU+JvcvNVFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ray4flBOg0A/9wGOjrVmFWjz2jI2hvpmFvY7YtQblUaTiWuvP/Cy9hNbDzk13ariUrL6gwx8JG9HtItIv95tzIMvwXUHeg+oYcrRdTZ0r9jToDgXVl0SyhhMrsyOuBzR6siQkq/Q1hxTR7tZUJK/HJLZJnw9vs4hnSdCCs1TrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=RabQY3O+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEIkqa0S; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id 963B22005E8;
	Mon, 10 Jun 2024 05:41:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 10 Jun 2024 05:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718012460;
	 x=1718016060; bh=+ir2CVbBvWnglzlujH/fXHt0aYyVxse9Z8DINg2urHY=; b=
	RabQY3O+4UNdZ0WFareLb30ij2ij24ABk6Lbynu1oSJqzBNhkIQQWgVpYAt6nxZs
	xtCHgP0hZbwR5BCOd3+A6byK5nCv8/C39etwGTzwROaBpProdCKhOoilOPHqfX4G
	9BPEw8rqUJ2b4bKJGD097P+GyZmNRYnlE9r5l/3qfgNTjwSIOS5iRdJ2/lcaKWol
	Ags4NKBIAEP4oDf6E5eP9xySuXZbbf3Rf+ZjrT1E/LFJ3zILwD3bPZl1TONdqocr
	gWE553KoKC/NxwfzjGl7vRY02Hm/52TNnjdQsoEmz4LyEbSX88ictmd9TYed7QO8
	Vi4saa1D9ANVTGK3GtTJ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718012460; x=
	1718016060; bh=+ir2CVbBvWnglzlujH/fXHt0aYyVxse9Z8DINg2urHY=; b=L
	EIkqa0ScrIZM+LbM+UQmyBMYTjnw/MyuAVysR6rU8V05ivy3cj/G/xnKynMg4RwD
	eolvhub/c6EaaAHYadJ+LHXze9kE8kbNYL8xHi+ro2PkwCbmS7v5nIj546/lDQk9
	yJwzxlK8VjIJ/0IDp2oqBanZ0aNkMNYqHjbhqleFLcoB499khNfsSlT1yTzGh7v9
	EmPyHRchH8a+BvKi2JzSqd9BNH9HaOU+crMxGt5PAY7FNdjtc9zGlv90XwpX/kNt
	z61R4Y3DicCu3qYARJku45VG37c3eRLbXkqD58xvt5HnwEavfIXbEfD+lINrb+ee
	2mSP7VhAJ0kfxhctfS5Hw==
X-ME-Sender: <xms:LMpmZkGE-eflvtIEwsg6gkccJ5iKsFDRlanTQlH5RisFANCJdKJnyA>
    <xme:LMpmZtXR8YOXh-iU4niksBMDtYtw-CmQPn8lCGVt2gaM45IzD-8NGWoyXDI4nWDoL
    kkOeYccTP4-FZd7dtM>
X-ME-Received: <xmr:LMpmZuINOI586a9DVmBFpEqsB_OfZXOtQGQ0GqS9akWHKky-9_zNVRIlXhBtNkRDHXLyNKqvefaOW-1i3zckVOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedutddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeetgedutdfggeetleefhfeuhedtheduteekieduvdeigeegvdev
    vddtieekiedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:LMpmZmFhkvdeqlm-6M4BTtRkSBGnJu2kqG8SVUIoAI2XSG7pv1KIXQ>
    <xmx:LMpmZqVggAwTWlvn6rCYXTiNLWrcaJIw9cfxq4zj3Pn-ofQbzZexnQ>
    <xmx:LMpmZpMAgFgbzUj73s7QZU5vvEe0Q_iTEiktwCD-tvDzkRrejVc9lg>
    <xmx:LMpmZh3iJSOiy9Hq-l1xA5WL35QxoPplcGdH5uexvRTvlDPFSPP6Sw>
    <xmx:LMpmZjUhtKFQlMDDlAkcUK3LjflnnZDUVoqCSrR42egFwU8ZMoeN9jzO>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 05:40:56 -0400 (EDT)
Date: Mon, 10 Jun 2024 02:46:06 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 	Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 	James Morris <jmorris@namei.org>, KP Singh <kpsingh@kernel.org>,
 	Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>,
 	Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 	Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 	Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, 	Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, 	Joel Granados <j.granados@samsung.com>,
 John Johansen <john.johansen@canonical.com>,
 	David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 	Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 	Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev,
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, apparmor@lists.ubuntu.com,
 	keyrings@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] capabilities: Add securebit to restrict userns
 caps
Message-ID: <svpbmv37f5n537seb3cfsylnlzi6ftuad4dqi5unoycylmcf7r@6knq7sibdw7w>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-3-jcalmels@3xx0.net>
 <20240610023301.GA2183903@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610023301.GA2183903@mail.hallyn.com>

On Sun, Jun 09, 2024 at 09:33:01PM GMT, Serge E. Hallyn wrote:
> On Sun, Jun 09, 2024 at 03:43:35AM -0700, Jonathan Calmels wrote:
> > This patch adds a new capability security bit designed to constrain a
> > task’s userns capability set to its bounding set. The reason for this is
> > twofold:
> > 
> > - This serves as a quick and easy way to lock down a set of capabilities
> >   for a task, thus ensuring that any namespace it creates will never be
> >   more privileged than itself is.
> > - This helps userspace transition to more secure defaults by not requiring
> >   specific logic for the userns capability set, or libcap support.
> > 
> > Example:
> > 
> >     # capsh --secbits=$((1 << 8)) --drop=cap_sys_rawio -- \
> >             -c 'unshare -r grep Cap /proc/self/status'
> >     CapInh: 0000000000000000
> >     CapPrm: 000001fffffdffff
> >     CapEff: 000001fffffdffff
> >     CapBnd: 000001fffffdffff
> >     CapAmb: 0000000000000000
> >     CapUNs: 000001fffffdffff
> 
> But you are not (that I can see, in this or the previous patch)
> keeping SECURE_USERNS_STRICT_CAPS in securebits on the next
> level unshare.  Though I think it's ok, because by then both
> cap_userns and cap_bset are reduced and cap_userns can't be
> expanded.  (Sorry, just thinking aloud here)

Right this is safe to reset, but maybe we do keep it if the secbit is
locked? This is kind of a special case compared to the other bits.

> > +	/* Limit userns capabilities to our parent's bounding set. */
> 
> In the case of userns_install(), it will be the target user namespace
> creator's bounding set, right?  Not "our parent's"?

Good point, I should reword this comment.

