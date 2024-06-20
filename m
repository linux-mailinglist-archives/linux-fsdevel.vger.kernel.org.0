Return-Path: <linux-fsdevel+bounces-21949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F58890FE0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 09:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AF91F22FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540451803A;
	Thu, 20 Jun 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VSD7g5Yb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJmwN0wa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBB54F8C;
	Thu, 20 Jun 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870025; cv=none; b=M41PvD4G/yeRDwY2pdrKJz2zlvjI4dfIxSbfvS2WsIwmR5rrM2XpBwIQNYsmbxCq4ABgClUtjbwRXA+jDDGIQg4gz5dBnhsbexnYWlZSe5oCjU6//y+yshcdeRyzCJt7eT4E/Hi7xS88s4yFvEruCC9divJt7NMyUKXt5kcIJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870025; c=relaxed/simple;
	bh=hyjUwqEc6gxyJBfvSnAM1gIpZjZ/aGGHuLR1CBy2jAY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Lto9JXDAoufSiDZHItJAl1AQL6ckGOI+D0b+rCTuCKQAkq3RvORrf+cwRbXgGuwsXv9EBFWIKCKtCvX4YxhKx/ml8QheOPHxo+yIRhoyvUAwCMSszHpKCdix+NzEqqA6cEnrXkFnWGN3XAN03iaS/X09c55AguKz6Agcruhm5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VSD7g5Yb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJmwN0wa; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0D2951C000CC;
	Thu, 20 Jun 2024 03:53:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 20 Jun 2024 03:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718870021; x=1718956421; bh=JHeenBGKjo
	00Vy0Wx71C86ZiG2/JTmE9tVuHD5MJIGk=; b=VSD7g5YbPKYvbulY+H627IMewJ
	S+zKo7lxSktkGbThFsKKNVcWFKUtZd/foreDwev/pCcboYVqMzg5kC2Iw/p5X/ka
	hSxV3fiKFDFW6mHgzsKC9DnknS5dsJ1nWodOHvD0YbsE6hnUfECajYGB7MSQ6yOx
	1GS5J6qhRAbMEpvtf0Y/AYIqijHaJ5iWxbgn54qbIfiTJQbqKJno536uaRINu5Vo
	YckPP5HmfVJtKQvGqqJdoF8Zxp0kvImXxJ7VdK+DQv9hLGQHXwePEw8kQvb1gx7U
	su1mrta0Eja8MWshos+8sc9PrsDTgJq5lY6baR+AvQ0DkUGJ5KtjRCtqnFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718870021; x=1718956421; bh=JHeenBGKjo00Vy0Wx71C86ZiG2/J
	TmE9tVuHD5MJIGk=; b=sJmwN0waefIXKVlS9ErM0QVu/7TH+k/XcfXRLRtwNAnR
	xhDTK09nxxe9FFVqbhUT8jtRDiVDqGSyMyy+ZrcWlmPxuGQd4Ss6/OjLXgjatBfq
	WtBimqZ5nCAXST5rLTYUZVyukGCk/R2Y8Z2Qcet0+dkOSNILj/8BgL4Io06A3nGH
	bq/uSi24hbPrJxTMPqzYmnhHduB/G5G25IF6hfkb6f8QTYWl6BUewSeuI7fltckp
	i2GV+OSTZlyWBNLDlf7Jb1H8vEGfSPUPySXsrK/W99RsY9uIJGdxLfC+BYuBnDBt
	He0rcqsJtH3vX6/TjJCA2dE+1voUvGCNZnzbL2QVCA==
X-ME-Sender: <xms:BeBzZrKzcjBNJ2D7__NVxUuuxTky0NMIRUBiQvZHoLwvvJ9A3b2i2A>
    <xme:BeBzZvKKVvpu1asPsegM4rsdpk4g21HLA3J0aB4MyrRpsRoji2MmrQbw0dGAzbacX
    aQC9ppZTccL9FC_70U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefuddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BeBzZjvtJkL2HZj6b8aCbSlmOzmrp_XB5mlLWkrgvxKetOTOcIWs5Q>
    <xmx:BeBzZkZw_UQQSYMGw5uqmU3RSE6Y7B6zqiMN362VZeH-UT6Rr0Pw4g>
    <xmx:BeBzZiZ2k4NWImSL7PMFZLgQ8DT2Udi6Dou84_aDYEQZTirwdE-_GQ>
    <xmx:BeBzZoAO3uFgPTKFG_fyNkgvjhFq5515LaxpsXNdul6S1SU5zetelA>
    <xmx:BeBzZq61IOVH689eS_bzwno3WyCR4KVp7aQnGzlPan68K8UPkkKDvrVl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0866FB6008D; Thu, 20 Jun 2024 03:53:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90b46873-f60f-4ece-bef6-b8eed3b68ac1@app.fastmail.com>
In-Reply-To: 
 <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
References: 
 <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Date: Thu, 20 Jun 2024 09:53:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>
Subject: Re: FYI: path walking optimizations pending for 6.11
Content-Type: text/plain

On Wed, Jun 19, 2024, at 22:25, Linus Torvalds wrote:
> The arm64-uaccess branch is just what it says, and makes a big
> difference in strncpy_from_user(). The "access_ok()" change is
> certainly debatable, but I think needs to be done for sanity. I think
> it's one of those "let's do it, and if it causes problems we'll have
> to fix things up" things.

I'm a bit worried about the access_ok() being so different from
the other architectures, after I previously saw all the ways
it could go wrong because of subtle differences.

I don't mind making the bit that makes the untagging
unconditional, and I can see how this improves code
generation. I've tried comparing your version against
the more conventional

static inline int access_ok(const void __user *p, unsigned long size)
{
        return likely(__access_ok(untagged_addr(p), size));
}

Using gcc-13.2, I see your version is likely better in all
cases, but not by much: for the constant-length case, it
saves only one instruction (combining the untagging with the
limit), while for a variable length it avoids a branch.

On a 24MB kernel image, I see this add up to a size difference
of 12KB, while the total savings from avoiding the conditional
untagging are 76KB.

Do you see a measurable performance difference between your
version and the one above?

On a related note, I see that there is one caller of
__access_ok() in common code, and this was added in
d319f344561d ("mm: Fix copy_from_user_nofault().").
I think that one should just go back to using access_ok()
after your 6ccdc91d6af9 ("x86: mm: remove
architecture-specific 'access_ok()' define"). In the
current version, it otherwise misses the untagging
on arm64.

    Arnd

