Return-Path: <linux-fsdevel+bounces-13038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994186A655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 03:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3406BB2AC5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BFD22EF4;
	Wed, 28 Feb 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="Ssgtg48Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJid94uY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B302261D;
	Wed, 28 Feb 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085045; cv=none; b=cjZxWuA3BRdisCNFfXWz5ynIoYeu5pt10sCt2qyJjxgnKPTMZDRLIJwK8+qdfWabo4bVD/qW7VYbzbLxaOokY5Dy7XN9tq0QSggFnidZ618E3yk8B/7zh6TIzeVsN5kqjkzt5NYIyOgMcmh1cux3lUg+e68xe7UWb898nnBj31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085045; c=relaxed/simple;
	bh=Ke3aNtV9K73tJbsU9ct5uM62SlJIbsds7nBelkuc+ks=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=iyJgW6Z9MZWgIbVbzxWYcH8X7CvFD87A+mehGLFixMYDw7IdOmpQ1jyvDZRhJkcu3x4mbiW3wW6tY87rYr52pTPVNn0nxCKtEEIIdDr2yR8bE/v8ZtHuN6lo9cC5uTk0jOSUbrIkeEw/oaH7tSTdohSOUC3cOilRJaAYOcTNvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=Ssgtg48Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJid94uY; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 04A7A1C00078;
	Tue, 27 Feb 2024 20:50:41 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Tue, 27 Feb 2024 20:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709085041;
	 x=1709171441; bh=gULlgmZeqeQInffwbFCAbM0sD+atderJ/Pmd0JUBsHQ=; b=
	Ssgtg48QP+nKGFfC+jaUjmNF3Frb6w+hVYuqaItO5ArnM0vgbIdJlaxhpQOQ/SG1
	AAPrmOXrcqu5dsYS24wTBHiDqL49L5E6QszZ/rPdbiEClcnr3nEWJuQ73a1Suvba
	eqG3JOUPFPFJ2nKvx+qyOrdS+XVkH7/NORnpWgYfdjoxMlfn6lck1dICg2YVPacI
	eH/MIWjxkNqN/go5WLKZ35AQ75s4Yiam3umoSnzmhPY9mrbg2VQViremf2XjE8Y9
	qVC6BfIhKvp8Bo92CuNmefA3EnnULJ0VZxSi3YqAckeC92GYze/dXLHKIgMx6CCe
	HaVF3jDimrS4XrC5uJfmlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709085041; x=
	1709171441; bh=gULlgmZeqeQInffwbFCAbM0sD+atderJ/Pmd0JUBsHQ=; b=X
	Jid94uYZwKRKHD+orenuRFvzbfQu6LTPLN6Ufg7YKLWDc/wJEvo40f7Y2MEXn1D2
	oKHKItxqV0tNLArsx88iZVIjeGf8YkdP+nKyneripP9KvOMxYQy77rvLUSIqPbvn
	B72bqyluj1M49WJoTcag6foIplni93ScbWLKoaXcksbCMAmQztIHag1hbFJCS/B+
	dKGTo59i8E/ubOLogADXiCbuO6uvo1pMdUqGw1+y+GtjW0xqVCnEGXjAavLkm7KK
	h9JeMIDNnAx8CYYnFlDwzsL/eygV3FQ0mq0de3N86xE+7cTIIMgFtir/S5X0/DI7
	REUeQ39HpmmBFvkTwxxUA==
X-ME-Sender: <xms:cZHeZb7n2mgGpFLpUjCqU1UmpPKecU6Mc43QA8m6Ocko_osl8eKaKQ>
    <xme:cZHeZQ58hwBygs2r8LUp6SkSog825F-RSEY5tYbgMa_DWiSrmtacYxMzFR9Qf0y_m
    JIWH1bcDkJtidd_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduudfhhffhkedvteetgeevffejudejleejtedvfedugfefheef
    heetgfeiveejfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgs
    uhhmrdhorhhg
X-ME-Proxy: <xmx:cZHeZSe-bGtbe6SQHA9Oqll9Ff6XSIP25s5Nyny0KS3bgxIR8gsj1A>
    <xmx:cZHeZcJs-9LsgFWMfK4Gl7KBXl626O8PclbTIw8Qz4RaxLCkzeMQlw>
    <xmx:cZHeZfJe33OWNs6bUcuuXvWuWwyyaXgtFewsaTXEzN5l8aOHeli_LA>
    <xmx:cZHeZX2qLlhxKNxAuwajVUdPtMZ5AWS9_wIszcok4xQdssoei3Hf-UJaij0>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2AE8D2A20090; Tue, 27 Feb 2024 20:50:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <87961163-a4b9-4032-aa06-f5126c9c8ca2@app.fastmail.com>
In-Reply-To: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
Date: Tue, 27 Feb 2024 20:50:20 -0500
From: "Colin Walters" <walters@verbum.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
 "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Feb 26, 2024, at 9:18 PM, Darrick J. Wong wrote:
> Hi all,
>
> This series creates a new FIEXCHANGE_RANGE system call to exchange
> ranges of bytes between two files atomically.  This new functionality
> enables data storage programs to stage and commit file updates such th=
at
> reader programs will see either the old contents or the new contents in
> their entirety, with no chance of torn writes.  A successful call
> completion guarantees that the new contents will be seen even if the
> system fails.
>
> The ability to exchange file fork mappings between files in this manner
> is critical to supporting online filesystem repair, which is built upon
> the strategy of constructing a clean copy of a damaged structure and
> committing the new structure into the metadata file atomically.
>
> User programs will be able to update files atomically by opening an
> O_TMPFILE, reflinking the source file to it, making whatever updates
> they want to make, and exchange the relevant ranges of the temp file
> with the original file.=20

It's probably worth noting that the "reflinking the source file" here
is optional, right?  IOW one can just:

- open(O_TMPFILE)
- write()
- ioctl(FIEXCHANGE_RANGE)

I suspect the "simpler" non-database cases (think e.g. editors
operating on plain text files) are going to be operating on an
in-memory copy; in theory of course we could identify common ranges
and reflink, but it's not clear to me it's really worth it at the
tiny scale most source files are.

> The intent behind this new userspace functionality is to enable atomic
> rewrites of arbitrary parts of individual files.  For years, applicati=
on
> programmers wanting to ensure the atomicity of a file update had to
> write the changes to a new file in the same directory

More sophisticated tools already are using O_TMPFILE I would say,
just with a final last step of materializing it with a name,
and then rename() into place.  So if this also
obviates the need for
https://lore.kernel.org/linux-fsdevel/364531.1579265357@warthog.procyon.=
org.uk/
that seems good.

>        Exchanges  are  atomic  with  regards to concurrent file opera=E2=
=80=90
>        tions, so no userspace-level locks need to be taken  to  obtain
>        consistent  results.  Implementations must guarantee that read=E2=
=80=90
>        ers see either the old contents or the new  contents  in  their
>        entirety, even if the system fails.

But given that we're reusing the same inode, I don't think that can *rea=
lly* be true...at least, not without higher level serialization.

A classic case today is dconf in GNOME is a basic memory-mapped database=
 file that is atomically replaced by the "create new file, rename into p=
lace" model.  Clients with mmap() view just see the old data until they =
reload explicitly.  But with this, clients with mmap'd view *will* immed=
iately see the new contents (because it's the same inode, right?) and th=
at's just going to lead to possibly split reads and undefined behavior -=
 without extra userspace serialization or locking (that more proper data=
bases) are going to be doing.

Arguably of course, dconf is too simple and more sophisticated tools lik=
e sqlite or LMDB could make use of this.  (There's some special atomic w=
rite that got added to f2fs for sqlite last I saw...I'm curious if this =
could replace it)

But still...it seems to me like there's going to be quite a lot of the "=
potentially concurrent reader, atomic replace desired" pattern and since=
 this can't replace that, we should call that out explicitly in the man =
page.  And also if so, then there's still a need for the linkat(AT_REPLA=
CE) etc.

>            XFS_EXCHRANGE_TO_EOF

I kept reading this as some sort of typo...would it really be too onerou=
s to spell it out as XFS_EXCHANGE_RANGE_TO_EOF e.g.?  Echoes of unix "cr=
eat" here =3D)


