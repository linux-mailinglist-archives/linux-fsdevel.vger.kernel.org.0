Return-Path: <linux-fsdevel+bounces-71251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A384BCBB18C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 17:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C64E306A06D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4312DEA97;
	Sat, 13 Dec 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqoBCyuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBE2DE702;
	Sat, 13 Dec 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765644263; cv=none; b=hiihhFjLhIvoo9WUj6j5/Is2hIewfjrCRlI0Mk1cpUNDJvDMLEvxTPSnb2U0VPWd/YfPt+/c0nUwFt0gcUoDhC85mRSL4yHVCisx/lQDImil4ajPegJ3iyjFxQqGHgF1kKOvkRpY2eHF+Z2U25MIZ/qIbEd3muuDCNdRx6Z3YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765644263; c=relaxed/simple;
	bh=b8J5h6HSg83nN/DGs1yVUaowCJ6zEDpbJ6pePYqiUW0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SjQnW0wXObhTnEcb4QbBw7wCtJCZ14IAJs0tGknE6LKkRhgCGuhbY8C8xEvsNt8gtvrMFddKO+ZY/JMwJPtU8+XAYcZgyzW755kYt5rnObf58mD4Ee/WEEBLJHLVGifTKMsZA+EgNyXR/0WBato9eyf0t4S99isB6Rd+Tfm5k40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqoBCyuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3280C4AF0B;
	Sat, 13 Dec 2025 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765644262;
	bh=b8J5h6HSg83nN/DGs1yVUaowCJ6zEDpbJ6pePYqiUW0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RqoBCyuchWDMfGilc82XVw6C7ENgLvZ+nMjruIykWCz7orySDvOgRSHb+TddUlRDm
	 bmSES7tZ8fBQjQWB5K7qG98HZNgQoE/lsEd2HNumHnHAx9DSVxHdMSUE2wlvhVlJv0
	 Pd8OsVP1NQv6F9lsuy/OWQi8feLxV+oQrwZclG8jW2UUOLqa2K5jV9tCAjxVWph1z8
	 1usCy+LJrESiwZwQ8wg4/qSxbe59Fxr2yuYhpfzARrQ+kLPAjhAZ+9IRCZyZ2gfZUS
	 gwmglQ2y0nf7xJR8awS1SpwbwAVm8fahZAZ1pXUznWMPLUHReFFAT+w9sVK8x7+Lhv
	 uIpKyLGtKMrXw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C93EDF4007E;
	Sat, 13 Dec 2025 11:44:20 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 11:44:20 -0500
X-ME-Sender: <xms:5Jc9aQ9s3WSjqscs3b_GhuvpWTDBFPLeomV7JnLZpq183V0MIzsWbQ>
    <xme:5Jc9aThQv1wDtIqAKug0YBIZG4QbQWcDzycWHW1LaKOL4dKMTsUeQt0RjfU4unSKS
    Lndgs_exSbRlNJ6yQNN6UKL1pDSRaGnqviFtefZL0xAJjac1Mkx918>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprgguihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpthhtoh
    epsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhihhrohhfuhhmihesmhgrihhlrdhprg
    hrkhhnvghtrdgtohdrjhhppdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgt
    phhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhope
    grlhhmrgiirdgrlhgvgigrnhgurhhovhhitghhsehprghrrghgohhnqdhsohhfthifrghr
    vgdrtghomhdprhgtphhtthhopehvohhlkhgvrhdrlhgvnhguvggtkhgvsehsvghrnhgvth
    druggvpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:5Jc9aU7hctJEOAiUsVsqH58WprXxxFxXlnzVvvd8oYaNtgXHpE7pIw>
    <xmx:5Jc9aVUmpUTFVTn1YP8Hh-ORmlsctH_7BuzzeZ-7x_Zs9Cqcxe9bmA>
    <xmx:5Jc9aUi1SDuShbeHsVKgeQV7WyIIoqpgQLTEXv0GfFPTj8goA0CCsw>
    <xmx:5Jc9addS3lK73W93uxBjqOJyQZgysb8qFzaihfZcGhRAkJFxwZDpjQ>
    <xmx:5Jc9ab3fLThx8ZV10Sib7FVzybJXCsErzmVc1wK8aHEioKui-0-gxvJ_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A5355780054; Sat, 13 Dec 2025 11:44:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG4gnELdBCjJ
Date: Sat, 13 Dec 2025 11:43:48 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 "Volker Lendecke" <Volker.Lendecke@sernet.de>,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <c727e128-8778-4dec-8750-6c93bd0dda02@app.fastmail.com>
In-Reply-To: <20251212212354.GA88311@macsyma.local>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org> <20251211234152.GA460739@google.com>
 <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
 <20251212021834.GB65406@macsyma.local>
 <ed9d790a-fea8-4f3e-8118-d3a59d31107b@app.fastmail.com>
 <20251212212354.GA88311@macsyma.local>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 12, 2025, at 4:23 PM, Theodore Tso wrote:
> On Fri, Dec 12, 2025 at 10:08:18AM -0500, Chuck Lever wrote:
>> The unicode v. ascii case folding information was included just as
>> an example. I don't have any use case for that, and as I told Eric,
>> those specifics can be removed from the API.
>> 
>> The case-insensitivity and case-preserving booleans can be consumed
>> immediately by NFSD. These two booleans have been part of the NFSv3
>> and NFSv4 protocols for decades, in order to support NFS clients on
>> non-POSIX systems.
>
> I was worried that some clients might be using this information so
> they could do informed caching --- i,e., if they have "makefile"
> cached locally because the user typed "more < makefile" into their
> Windows Command.exe window, and then later on some program tries to
> access "Makefile" the client OS might decide that they "know" that
> "makefile" and "Makefile" are the same file.  But if that's the case,
> then it needs to have more details about whether it's ASCII versus
> Unicode 1.0 vs Unicode 17.0 case folding that be in use, or there
> might be "interesting" corner cases.

No current version of the NFS protocol can communicate any more than
whether or not filenames are case sensitive and case preserving. Thus
the unicode label idea is nothing NFSD can possibly take advantage of.


> Which is why I've gotten increasingly more sympathetic to Linus's
> position that case folding is Hot Trash.  If it weren't for the fact
> that I really wanted to get Android out of using wrapfs (which is an
> even greater trash fire), I'd be regretting the fact that I helped to
> add insensitive file name support to Linux...

Well I think "Hot Trash" is the general consensus. I'm not thinking
of adding more than the NFS protocol can support. I'm only suggesting
that more /could/ be done if someone has a use case for it.


-- 
Chuck Lever

