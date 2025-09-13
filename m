Return-Path: <linux-fsdevel+bounces-61203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC7B55EAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 07:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C2F1C8329E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9492DF6F8;
	Sat, 13 Sep 2025 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="T8AJVgi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWybNC8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929615A8
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757742628; cv=none; b=Au1XWnFEGP+Dd3MVgeGiCX98FiNMmGm3zU3kq9u6zQDKFQscmTlSOX5nBqOxnq33Y6OLycIiZ6NJznncRNYqOWl5WK+Nik5Y5OVGtLG0ol+lH1bOa1mtjee+1t5uOG9YSsdMGbtWicoUdeeXbT1iu181WSW2YPmLe+DvmU76Gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757742628; c=relaxed/simple;
	bh=5IEg1hrdhyNDbV1xt9b3QnnrM5sSwmFU/TCKNQt0yZw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=o3+yFmWaqpUwM6W1ijcD4hTICdqHXWnrkZZsI0jLXzvFsP72HEZh401LyE394hTE+l+EyBSWXWm/5fMjFoCJDH6f8JKg2mCM26kWZh2U2g1U/C1HRabFSvG3H2Ve8b6pOdFGBH8tFZTeHTGFnhe+9zZnU9qR2LlI7R0Ky6G5DIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=T8AJVgi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWybNC8q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 86F901D0021D;
	Sat, 13 Sep 2025 01:50:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 13 Sep 2025 01:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757742625; x=1757829025; bh=d72EgG17vWv4hEGaMkMs1Vf3yF0y60tpCOz
	lckmUwRk=; b=T8AJVgi/UPk75yDvj+nug0sJJTDv1Ujw35YMYWmWWr/ARu0DP9R
	wGB/xZWMbkYpCOQAuj/pNMpcmGOQK+C+cMhKtj45Z9sVVItGbVM9fdyCWfgVPNpN
	lly/uWEhu2fcHK+jQ1DcsHyoI9TKabt9VeqSqTD0Qaj/lqGMdTvMR73RrfGCShJh
	2ORVxCoUHugaLVKJsWPbHTEqL1G5lxD3utkX8bN3PaRWwiQh4SZdKYVyP58e7+VC
	U7BEVtkUcR3NM11LM7+VmIw9g9z1K/A9sBsIv2cdWUJ17GOA2ND153kSbspv1OOc
	NNLD5LmYrk+trT9UihPLo96h16pqoZWkFng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757742625; x=
	1757829025; bh=d72EgG17vWv4hEGaMkMs1Vf3yF0y60tpCOzlckmUwRk=; b=B
	WybNC8qRrMWpFTBSkf6cnONz4vwFaoXwN7jRT0Dd6AkYFDJ2mhdsoNz9vgV0sN7p
	FRE05EgOk0KrZdbAA97ojqV74UHIi8MxGR8HsaiYpeRubdBxi3TpArOsrFm4lVBY
	AXS+V6zc9TgBOQBtGJj2Rhj2scmT6MaCNUd++d2Rdg5zXB2oR/CSgaM0L5rVCJGZ
	JsYXLEa3N4IP7lOFhsZiPj18urXuqHShEmAbhBzQf80mS0EtSX5NGLHB9SA0yz9/
	t6Zcx6rDfWl34YAY4ZJAIhFTM+a0eSHv5XnQJe2LA1hqOyIMUZ5EOSlM1PMVI3n6
	Nz0c6hZzaTgY4GEJvn2bw==
X-ME-Sender: <xms:IAbFaCumfaKQ0jvsO-7fHw4Cag-ZnY-eU5YUb3ptTO4BnNzLxhHZ1g>
    <xme:IAbFaPG9SADthCR2TpW4Fza6_5atDbbH1aj8_0G4lZhX2PzBD906bJYG-6zimvgKy
    hvtcGnLElg3aQ>
X-ME-Received: <xmr:IAbFaLZgNCCZ9eV0b5SkQ5hMJYanNo5WOQBTeHy-HeFRreMj7cLmMue2Jqtf3CEVjhbtEabNGaul_RVPFxlPDqxOz7Iwoa5TOZU9yhrnzykx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegsvghrnhgusegsshgsvghrnhgurdgtohhm
X-ME-Proxy: <xmx:IAbFaHVvhVRQzD5F5fKusULztUzN8TCdCXcHBcrwb-OVY23YgQaX9Q>
    <xmx:IAbFaJmwuIljqPHc64Y47_UEKbef7jF2dcGJMOjuDO7knuVPR2t2fA>
    <xmx:IAbFaKA1lzUKzJjWCWPSuV_n7bybnMn5_KIFvTqTDMAkfzsCukh1ug>
    <xmx:IAbFaAiTx7tDPuLOmd5ypR8RfQHG1jUMMkFeByIyCGDdk04zSSFd1A>
    <xmx:IQbFaCkGBNMquhoi-RupmnqRk0_RlqefrHQlyl46OwNoTlqaRd55OS0W>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 01:50:22 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>, "Bernd Schubert" <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
In-reply-to: <20250913050719.GD39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>,
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>,
 <20250910072423.GR31600@ZenIV>, <20250912054907.GA2537338@ZenIV>,
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>,
 <20250912182936.GY39973@ZenIV>,
 <175773460967.1696783.15803928091939003441@noble.neil.brown.name>,
 <20250913050719.GD39973@ZenIV>
Date: Sat, 13 Sep 2025 15:50:16 +1000
Message-id: <175774261622.1696783.17475774252572098177@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 13 Sep 2025, Al Viro wrote:
> On Sat, Sep 13, 2025 at 01:36:49PM +1000, NeilBrown wrote:
> 
> > > 	Umm...	Unless I'm misunderstanding you, that *would* change the
> > > calling conventions - dentry could bloody well be positive, couldn't it?
> > > And that changes quite a bit - without O_CREAT in flags you could get
> > > parent locked only shared and pass a positive hashed dentry attached
> > > to a directory inode to ->atomic_open().  The thing is, in that case it
> > > can be moved by d_splice_alias()...
> > 
> > Once we get per-dentry locking for dirops this will cease to be a
> > problem.  The dentry would be locked exclusively whether we create or
> > not and the lock would prevent the d_splice_alias() rename.
> 
> Umm...  Interesting, but... what would happen in such case, really?
> 
> You have one thread with allegedly directory dentry it had skipped
> verification for.  It tries to combine open with revalidation, and
> sends such request.  In the meanwhile, another thread has found the
> same thing in a different place - possibly because of fs corruption,
> possibly because the damn thing got moved on server, right after it has
> sent "OK, I've opened it" reply to the first thread.  What would you do?
> Have the second thread spin/fail with some error/something else?

If there is a race with d_splice_alias() wanting the move the directory
while open_atomic has it locked, -ESTALE will be returned and the lookup
will be retried with LOOKUP_REVAL which should allow the filesystem to
do any needed synchronisation.

If the directory has simply been moved on the server, then the
revalidate in atomic_open will notice this and invalidate the old dentry
and use lookup to create a new one.  Importantly it will have a stable
d_name so that it can do that.

This "invalidate and create a new one with the same name" will require
careful locking but should be achievable.

NeilBrown

