Return-Path: <linux-fsdevel+bounces-41414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A6A2F293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36B818829D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703B724F599;
	Mon, 10 Feb 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="Fleujqiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hwDyZJzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991802451C3;
	Mon, 10 Feb 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203711; cv=none; b=s3y61L7Tb3Ye4edXTWcjVk8do+Rgot7zB/dBpeyoCWj4Da/rXiGZG4HyOlyhffskyRO7gg80jxHfZbP53pKdwmN/IsR3rEKoxhbbAuP3OmrFNoYOSRhDzolb2EWikGE1ZfmlSbCAK26crn6QSjU3G8xDrcjQRUcMAiDLLV0CwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203711; c=relaxed/simple;
	bh=7/N3ApYexJ1r7W6X12UmkGuxHbBnaVUPJA2U74dJ4+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eHaWrCQ2CXkYxAfM/8yFKLqh+AlTy72N0vg1MG3EclIUI9I7yad4FzvJYF636rUw1UajbY4a33bfMbSBgPvt4HKFstDQAQPblGF2WGzGGrueLj92BV7JAVKsctp5snGbVYfHMm0NvQ0JDuCrnFRlzhQH/DeAwZJpRI3pB9Bo8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=Fleujqiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hwDyZJzE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E91D114015E;
	Mon, 10 Feb 2025 11:08:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 10 Feb 2025 11:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739203708; x=1739290108; bh=JzKPtw2fgUvh5taA0kG4OvjEYLfehOFh
	/dM3hqPQhW8=; b=FleujqizzGq3xiM3FDALPqu7RLYrqqprmFq3kvG0MyNSEGS4
	aXKXG8WbGp0by+/rObKbvC6YJIqQleFWF/wKIVwL4jVy1KRqBK6j7xcsyuKpB8lb
	cUGNmG665qEwbyokq9eyimoZWEffz1XuIPbkZw65Ac+3cuha5ARUzlngSgTIyue7
	rpNKtK843kltIthxZLu6Pkp5Y1SYLatgDH2wY1VhMftZv/XYrVI0NZBvRLWmxkXK
	p1pDBFNhv76EutHkBZc5xfH9f0Y9ilKz07HVIqUvXGQBDmHgcakBU5SVPHVCZpD+
	i/q+0ACoXaKMCytIbOtr9d7T0V/wRZEOnQ4syw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739203708; x=
	1739290108; bh=JzKPtw2fgUvh5taA0kG4OvjEYLfehOFh/dM3hqPQhW8=; b=h
	wDyZJzEFSRtf1e0WYOkqpal/CDgTRnaMekkBD8UhUyBVR6gcqGLS2wM+jushD1jX
	gj5dk+88yJK13ud+AedryKqd17CHN7EKohd3+YGLdxeba5nCa7ehtoPrdbnZBH5P
	q3lOQSSC8Nr6fR6+7OPl8kZmK7ZJ2S/c0tJ0oPJyrVRIA1ejYBHDJHbNl/Ozpvw4
	znDTnoKT62UNLHwY8NafokBVXUTWuaY7lRu/6ScsrFe/ID6kDGKf9sVe3JOUlASm
	868lXZAKDfxI+eVhq2nyW8DBt97msUIsKoonWRrfit1qXqq19kCZGVAW8jEdy7bW
	QXlXTP/4jYF8+7yT4EdRg==
X-ME-Sender: <xms:eySqZ-zXD93FW3EfUwcLdaaphi8OFfK4H-Olil0Dpnl0BJ54KfGd5Q>
    <xme:eySqZ6QTQ1mj5sY6NFsZeEe3yloe4hFd7y5uDZtzF8DjFt3w9Ze1Wof1uQSpBEICz
    3oz_cCRnd5qE6_RIjw>
X-ME-Received: <xmr:eySqZwUNxY_sAWeNi-vTFSBK_OGi-qq6BYkMbA1wJj665mI464tLAHFmR6tfctMGCDhl3ku3glD2gCpLrsGxXafRcQ5Cuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttder
    jeenucfhrhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvg
    hrrdgtohhmqeenucggtffrrghtthgvrhhnpedvvdeifeegieeiffdtgeduiedtuefhieeu
    jeefkeegueehieetgfejtddtgfehffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghotggtihes
    ihhnrhhirgdrfhhrpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegurghk
    rheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    gh
X-ME-Proxy: <xmx:eySqZ0h1GNzkSHisLb1d6E5Bq5aR_CbatiGWRQyKcFz7Lk2mTNrBOg>
    <xmx:eySqZwBkbHoBjTTT9pcx046ZKa6NfRtnsxqUu8uM17PEGPcEwgbUVQ>
    <xmx:eySqZ1Iw5TINisdD-AN1nUxhUqdFgjh-yR8RQojwPXzi5pmIntwLfw>
    <xmx:eySqZ3DQNK8vChr9rsV5tXVRciJ8029uHqq_lqR1dwihuIGZ7IsFPA>
    <xmx:fCSqZwt41VSNqNUPgmhAuLdZBK0gra4vvyWcSKr9pgw2itB87AjPKWN2>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:08:26 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,  Danilo Krummrich
 <dakr@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>,  Christian
 Brauner <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  cocci@inria.fr,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle
 in debugfs API
In-Reply-To: <2025021048-thieving-failing-7831@gregkh> (Greg Kroah-Hartman's
	message of "Mon, 10 Feb 2025 08:08:19 +0100")
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 08:08:25 -0800
Message-ID: <86ldud3hqe.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>
> First off, many thanks for attempting this, I didn't think it was ready
> to even be attempted, so it's very nice to see this.
>

No problem, and thank you for taking a look!

> That being said, I agree with Al, we can't embed a dentry in a structure
> like that as the lifecycles are going to get messy fast.
>

Ack, I'll do something different in v2.

For my own education: what goes wrong with lifecycles with this embed?
Feel free to point me at a doc or something.

Also, Al and Greg, would wrapping a pointer be fine?

	struct debugfs_node {
		struct dentry *dentry;
	};

I was trying to do the simplest thing possible so the bulk of the change
was mechanical. Wrapping a pointer is slightly more complicated because
we have to deal with memory allocation, but it is still totally doable.

> Also, your replacement of many of the dentry functions with wrappers
> seems at bit odd, ideally you would just return a dentry from a call
> like "debugfs_node_to_dentry()" and then let the caller do with it what
> it wants to, that way you don't need to wrap everything.
>

Understood. I considered exposing the underlying dentry as a "dirty
backdoor" around the opaque wrapper, so I was trying to minimize it :)
I'm happy to undo some of these wrappers though, it will make the change
simpler.

> And finally, I think that many of the places where you did have to
> convert the code to save off a debugfs node instead of a dentry can be
> removed entirely as a "lookup this file" can be used instead.  I was
> waiting for more conversions of that logic, removing the need to store
> anything in a driver/subsystem first, before attempting to get rid of
> the returned dentry pointer.
>

Yeah this is a great idea, and could even be done in a few patches
outside of this large migration patch series if necessary. I'll
investigate.

> As an example of this, why not look at removing almost all of those
> pointers in the relay code?  Why is all of that being stored at all?
>

I'll take another look at the relay code as well and see if I can remove
the pointers.

> Oh, also, all of those forward declarations look really odd, something
> feels wrong with needing that type of patch if we are doing things
> right.  Are you sure it was needed?
>

I agree with this sentiment, and I discussed this in the cover letter a
bit under the section "#includes and #defines". The need for peppering
temporary #defines (for intermediate commits) and forward declarations
around is my least favorite part of this patch series.

I am indeed sure they are needed in most cases. I'll give a few examples
for both the temporary #defines Coccinelle adds and the forward
declarations that replace the #defines in the last commit:

1. If you remove the forward declaration (or the corresponding temporary
   #define in the Coccincelle commit) in
   drivers/gpu/drm/xe/xe_gsc_debugfs.h, you get this compilation error:

   drivers/gpu/drm/xe/xe_gsc_debugfs.h:12:57: error: =E2=80=98struct debugf=
s_node=E2=80=99 declared inside parameter list will not be visible outside =
of this definition or declaration [-Werror]
      12 | void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct debugfs_=
node *parent);

   gcc does not like implicitly-defined types inside of function
   arguments. As far as I can tell, we only get this error for function
   arguments; this is apparently okay for a top-level declaration, like:

   struct debugfs_node *my_root_node;


2. In the Coccinelle commit, if you remove the #define debugfs_node from
   include/linux/fault-inject.h, you get errors of this sort:

   mm/fail_page_alloc.c:55:13: error: assignment to =E2=80=98struct dentry =
*=E2=80=99 from incompatible pointer type =E2=80=98struct debugfs_node *=E2=
=80=99 [-Werror=3Dincompatible-pointer-types]
      55 |         dir =3D fault_create_debugfs_attr("fail_page_alloc", NUL=
L,
         |             ^

   Because the #define is not in scope, the compiler is assuming we are
   implicitly defining a new type.


The Coccinelle script adds a forward declaration of struct debugfs_node
wherever there was one for struct dentry. This is just a heuristic I
found that seemed to do the job and was easy to automate.

I originally did this whole patch series in reverse, where we
immediately make struct debugfs_node, migrate debugfs internals, and
migrate all users of the API, but that leads to one very large commit
and appeared harder to review to me. I went with this intermediate
#define idea so the commits could be split up and each commit would
compile, but I don't like the little bit of extra complexity it adds.

I'm open to any other migration ideas folks have! I'm not tied to these
two plans at all.

Thanks,
David Reaver

