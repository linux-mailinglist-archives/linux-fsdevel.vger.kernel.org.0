Return-Path: <linux-fsdevel+bounces-19652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A138C8512
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849731F24809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECAB3B782;
	Fri, 17 May 2024 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="jzzlTSfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8aaZBQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow6-smtp.messagingengine.com (wflow6-smtp.messagingengine.com [64.147.123.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B13A8EF;
	Fri, 17 May 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942779; cv=none; b=gkOBvwbbKYOGn7/FQfhVjdabt+wWpH0m0eLw8juXtolqFCi/q5ve3uNtHXxV101SwqQk0HM81o1/5q/rXh1qbX9OydjTMYuTVl85l5xAPDsT/g8gBKtjFA+bQ3/tvYnTE6/OWkB7fxmtNZQqX3omxgS0XDCRHE3iiWdkjCWzaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942779; c=relaxed/simple;
	bh=Usv8FrNMyMA/e9bwDI/XPptjxA/X7snPzywB+T3VSws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjYrnYFrP7Wp2Q0E9q6uME1J1iK3o53rhCO+SSWIZLl9Dl3iWS96zepCXyC2MkAjbeFESWKph7bZCnRYmR8i++OerSqi8gC/eZYDXvkbug+vV7ERdNfCXga4RcasKGsjd2QpLSNPNoz1Qei7nfZwFOwMAe4ml+95ocZ7VfscRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=jzzlTSfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8aaZBQa; arc=none smtp.client-ip=64.147.123.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 9ACE52CC01B2;
	Fri, 17 May 2024 06:46:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 May 2024 06:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1715942775;
	 x=1715946375; bh=t6vROMqJIpuDwOB1qQz1P/6tRxrDcWWoZxr9yWTTUM0=; b=
	jzzlTSfliC7aJdxhlr8U2PaYNhESWNMCT5aBL2w+A90PrnXH2I0i10rsFJx9t9D0
	sF5ZTql9I06Il8rtHgu8Ffusc+FFdV5x+4ENwWwtNXt12bSZ3b3jLq1LnKeBX2mV
	iEWZOnubDMdAQYwN9lryqZcXAZ3HriQG8ocqSwKQ1VWp55I38wZ5NkPx3qXaiRgT
	ayTcwLxYywzfNbDxUPXRWW92h2qvslpTa07Qh6W3sVhqLdGnYHk5DOx2AwLLNlb5
	YKtMLmyM630PmwNf8N65ZsaLaj8AGZT1I/u0P3Qo+BQ0t6g8IicMGhnQ+/0p7Xgc
	/ZUcy9H7q89nOke8tingjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i76614979.fm3; t=
	1715942775; x=1715946375; bh=t6vROMqJIpuDwOB1qQz1P/6tRxrDcWWoZxr
	9yWTTUM0=; b=e8aaZBQaXu/jah8iqCXyY6FZKnj7y3GGKyqJrC8oOj6TLG3XOtb
	gc6GgTHLQQ/iB5x0J3eG3FOKgDybE25yY070f5vJKR2aJkmLJogydrWSz4Y6ETWH
	QxJ//M6+vNpY5t7WglbgN0SKFMdbSEgpDo0neP28cnQ67RatW1ZiyozQZMV7+GcG
	N4j6LbPKFXZzXhJjqk2pVnh15Dc9RTdl4N+X7SHrKthGVdRkobDbv/n1w56bA4/o
	2yMnSdl/C4ymfdQSRESrJLT4BY8mh2NsKc0nnnIszkQhJok5O5MAezxnXV1C5Vnp
	kSOVMpzffngSmxWweB83DfKbq0rJ95R3xdQ==
X-ME-Sender: <xms:djVHZsjkhqVsujms6Czt6anR5qrHKswYqBGJ2ls6ufpscgxMpyu9-A>
    <xme:djVHZlA1UUy7bO9bl-9pp1NV94Ih_BS2SI-SjtOPnB8zbtb0kPZPCzYGpH2LSyt88
    UWep3qscd9sK2oTjQU>
X-ME-Received: <xmr:djVHZkHrmfETrJrmj1JbNHYGnhXwvW3kSK1GV5XbyDqyT1q3KtwrVj8Odh2JAwV1Yp6ZM-CXuqJUyLai0lD7ltE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeetgedutdfggeetleefhfeuhedtheduteekieduvdeigeegvdev
    vddtieekiedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:djVHZtT8tKpB0YwfwFdvbIMCK_Lx9ylbTqHPhrKsZBaQd0Ycr9p2zA>
    <xmx:djVHZpzi6XHWQtZ6JLh6O2gg2xySSm9ILCMrLroqynQo6YjSqAwspQ>
    <xmx:djVHZr5A5FJ6AjCrgofiB93uhjrI8iSL4QyfeCjvOR6rRYAwE4htPg>
    <xmx:djVHZmzWH0OgtQkzOyD62fqrWWI5Rfd6-jQeOixgJIrCyihu9j20NQ>
    <xmx:dzVHZphiCg2eM012AMibbr1TZeelQKIqYrExPad6dfKJhQ7fgrR8R7O->
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 06:46:12 -0400 (EDT)
Date: Fri, 17 May 2024 03:51:14 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: John Johansen <john.johansen@canonical.com>
Cc: brauner@kernel.org, ebiederm@xmission.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Serge Hallyn <serge@hallyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
Message-ID: <jwuknxmitht42ghsy6nkoegotte5kxi67fh6cbei7o5w3bv5jy@eyphufkqwaap>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
 <641a34bd-e702-4f02-968e-4f71e0957af1@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <641a34bd-e702-4f02-968e-4f71e0957af1@canonical.com>

On Thu, May 16, 2024 at 03:07:28PM GMT, John Johansen wrote:
> agreed, though it really is application dependent. Some applications handle
> the denial at userns creation better, than the capability after. Others
> like anything based on QTWebEngine will crash on denial of userns creation
> but handle denial of the capability within the userns just fine, and some
> applications just crash regardless.

Yes this is application specific, but I would argue that the latter is
much more preferable. For example, having one application crash in a
container is probably ok, but not being able to start the container in
the first place is probably not. Similarly, preventing the network
namespace creation breaks services which rely on systemd’s
PrivateNetwork, even though they most likely use it to prevent any
networking from being done.

> The userns cred from the LSM hook can be modified, yes it is currently
> specified as const but is still under construction so it can be safely
> modified the LSM hook just needs a small update.
> 
> The advantage of doing it under the LSM is an LSM can have a richer policy
> around what can use them and tracking of what is allowed. That is to say the
> LSM has the capability of being finer grained than doing it via capabilities.

Sure, we could modify the LSM hook to do all sorts of things, but
leveraging it would be quite cumbersome, will take time to show up in
userspace, or simply never be adopted.
We’re already seeing it in Ubuntu which started requiring Apparmor profiles.

This new capability set would be a universal thing that could be
leveraged today without modification to userspace. Moreover, it’s a
simple framework that can be extended.
As you mentioned, LSMs are even finer grained, and that’s the idea,
those could be used hand in hand eventually. You could envision LSM
hooks controlling the userns capability set, and thus enforce policies
on the creation of nested namespaces without limiting the other tasks’
capabilities.

> I am not opposed to adding another mechanism to control user namespaces,
> I am just not currently convinced that capabilities are the right
> mechanism.

Well that’s the thing, from past conversations, there is a lot of
disagreement about restricting namespaces. By restricting the
capabilities granted by namespaces instead, we’re actually treating the
root cause of most concerns.

Today user namespaces are "special" and always grant full caps. Adding a
new capability set to limit this behavior is logical; same way it's done
for usual process transitions.
Essentially this set is to namespaces what the inheritable set is to
root.

> this should be bounded by the creating task's bounding set, other wise
> the capability model's bounding invariant will be broken, but having the
> capabilities that the userns want to access in the task's bounding set is
> a problem for all the unprivileged processes wanting access to user
> namespaces.

This is possible with the security bit introduced in the second patch.
The idea of having those separate is that a service which has dropped
its capabilities can still create a fully privileged user namespace.
For example, systemd’s machined drops capabilities from its bounding set,
yet it should be able to create unprivileged containers.
The invariant is sound because a child userns can never regain what it
doesn’t have in its bounding set. If it helps you can view the userns
set as a “namespace bounding set” since it defines the future bounding
sets of namespaced tasks.

> If I am reading this right for unprivileged processes the capabilities in
> the userns are bounded by the processes permitted set before the userns is
> created?

Yes, unprivileged processes that want to raise a capability in their
userns set need it in their permitted set (as well as their bounding
set). This is similar to inheritable capabilities.
Recall that processes start with a full set of userns capabilities, so
if you drop a userns capability (or something else did, e.g.
init/pam/sysctl/parent) you will never be able to regain it, and
namespaces you create won't have it included.
Now, if you’re root (or cap privileged) you can always regain it.

> This is only being respected in PR_CTL, the user mode helper is straight
> setting the caps.

Usermod helper requires CAP_SYS_MODULE and CAP_SETPCAP in the initns so
the permitted set is irrelevant there. It starts with a full set but from
there you can only lower caps, so the invariant holds.

