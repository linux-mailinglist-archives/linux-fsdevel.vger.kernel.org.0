Return-Path: <linux-fsdevel+bounces-23467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D492CD42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F9FB23B02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9AB1474BE;
	Wed, 10 Jul 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Gxsmex4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrJBeQ9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253214535A;
	Wed, 10 Jul 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600730; cv=none; b=cHu5uDVTgVUmPeHV5hFBw1Nlqyt19OWdD7v/sadbNsu6F1h4nYxgDNjZFfBe3iVgjADlQjWxsozGJxwkV4hnSVIfSmaUqG6TK82jowflg1Z5kv1Crhf3Mv9Ye1MlWMYYKXICMmyRBfN1n+qYCbpHUNIVbAv5ZPahKgjFQZ+UUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600730; c=relaxed/simple;
	bh=gfDtRWhYk0t5bsEEguIzwobh+2zPF5zVrRMyEEQvRfk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BNuYc5u3z0bZXyWUTzxTuy2ouFd/cX+mnRGL4xi/vxdn4Nq2aaFxccUMz5HF4L8rIOWaBaFJzteUfyMwq39OFUGHqDXXrCabcOoCDkMpbPgdr1w3ro4UGkdnBfahuq188XpmdGiSt3m7PHbjlcymUIQ5FNMHacVvBTHm3KC6xLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Gxsmex4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrJBeQ9L; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 158011381E84;
	Wed, 10 Jul 2024 04:38:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 04:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720600728; x=1720687128; bh=69hv1M1ROq
	f8298u22/TUO59eY+uy73Z7ZOkyR9XYZs=; b=Gxsmex4cHupEXBzo0yMc/r3p8M
	RpxeO3o0pGWvvKgWNbf68d/LlaWG0NNEnz+orWNnmV8V42gHnJz8aNjHfXxTKPaE
	BhQOXgPTfWz1rzYB3PFRIntCuexmFKcyD3SgurfXOPOZ6srmkbfTeBHsru5eNA04
	Kir1CRANgusVHiMDuArE7xBXat86KwE5uTFJWhtb67SLujU8MEUhXOFE/uFLgYk0
	f8Bnui20z0efIAlmr6bmFqJCCHKeDAGfSRO+8Ted+Qza7NQAJp8/+XwSjRh3trGc
	dHHRWrOEf8h76j5hMZMOCFypQsHiETgny6D8rkfjTJ6hmsgYA5EqnwAQZ1XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720600728; x=1720687128; bh=69hv1M1ROqf8298u22/TUO59eY+u
	y73Z7ZOkyR9XYZs=; b=PrJBeQ9L3NL5R7DjqMDEU7TMVi4j/68Siigza5EIr7br
	PunZZ0f7OcJ0MA4krzrGXiTSdfaTrgNyxnxbOCazsrxJTB/B7lotEGfB8189pjlv
	oMK50VAxlEbYxoRM1Ic7NuL/D1ZeJCDunJ3ybK1nnKv7ZRINsA99C+DO2NdMMHE0
	aIuoftQV+leRDY3GTu9JNysi5H8F7eQtbPFvcUJXS36vuu1Gn6WLN7pIBuVQ+T8Z
	tOGwdw+zXwODQvSEqVT2VYEkwQ9/P0DdkTi8C8njYgqIC5ioMjLk6bTS6Dp+AL3P
	RBgtv0Ee49PoZH7359iY75Utq+GWjpnOJvdlMnsj+Q==
X-ME-Sender: <xms:lkiOZuzc64JkX3CQB896hVkeIvoiS527e0XAw-6XpBvgOdjvR54TZQ>
    <xme:lkiOZqQ0b0CXBUYWWGs3IFq1ZuRVHtlgzMfoc0PHbHvKc-q5luUPbiA20rUqDAxUg
    FuJA1W8zArQhbD4-G4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lkiOZgUaNQ9VZ2CJMHE528jiMsZ06Z-4v-u1y5K7vrmM_vPeYZBamQ>
    <xmx:lkiOZkj-e8bYRxgVBUeUJ4NH5ncaRdaNJQc-dhPUGDNTSp-u9ptk_A>
    <xmx:lkiOZgC54__9xRrTRd5MnvIialYoybn3RmCasyCIJoHd1gdqlUf1pQ>
    <xmx:lkiOZlJhEplBz81lkbsoT7xjRG8FAXQJ9jQ3zs2_Ejr8yUlencuu9A>
    <xmx:mEiOZj96aK8qeLOYs1KAJBCy1fvrJNCbwiIxyMttw5YmT3UPDi88IlPe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AF5FEB6008F; Wed, 10 Jul 2024 04:38:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3e1ebe1-79fa-438b-a196-3a1bff947bcd@app.fastmail.com>
In-Reply-To: <5c52194a8b449e695a1f22bf525b1fb1674cd2f8.camel@kernel.org>
References: <202407091931.mztaeJHw-lkp@intel.com>
 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
 <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
 <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
 <92726965-19a0-433b-9b49-69af84b25081@app.fastmail.com>
 <edd2d831320fb14333e605e77d4b284b1123eb86.camel@kernel.org>
 <c8e44728-6c09-4fbe-9583-1f8298c3ea39@app.fastmail.com>
 <5c52194a8b449e695a1f22bf525b1fb1674cd2f8.camel@kernel.org>
Date: Wed, 10 Jul 2024 10:38:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
Content-Type: text/plain

On Tue, Jul 9, 2024, at 20:27, Jeff Layton wrote:
> On Tue, 2024-07-09 at 19:06 +0200, Arnd Bergmann wrote:
>> On Tue, Jul 9, 2024, at 17:27, Jeff Layton wrote:
>> > On Tue, 2024-07-09 at 17:07 +0200, Arnd Bergmann wrote:
>
>
> Yes, I had considered it on an earlier draft, but my attempt was pretty
> laughable. You inspired me to take another look though...
>
> If we go that route, what I think we'd want to do is add a new floor
> value to the timekeeper and a couple of new functions:
>
> ktime_get_coarse_floor - fetch the max of current coarse time and floor
> ktime_get_fine_floor - fetch a fine-grained time and update the floor

I was thinking of keeping a name that is specific to the vfs
usage instead of the ktime_get_* namespace. I'm sure the timekeeping
maintainers will have an opinion on this though, one way or another.

> The variety of different offsets inside the existing timekeeper code is
> a bit bewildering, but I guess we'd want ktime_get_fine_floor to call
> timekeeping_get_ns(&tk->tkr_mono) and keep the latest return cached.
> When the coarse time is updated we'd zero out that cached floor value.

Why not update the cached value during the timekeeping update as well
instead of setting it to zero? That way you can just always use the
cached value for VFS and simplify the common code path for reading
that value.

> Updating that value in ktime_get_fine_floor will require locking or
> (more likely) some sort of atomic op. timekeeping_get_ns returns u64
> though, so I think we're still stuck needing to do a cmpxchg64.

Right, or atomic64_cmpxchg() to make it work on 32-bit.

     Arnd

