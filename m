Return-Path: <linux-fsdevel+bounces-71197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DECB915E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 16:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4401630CB03B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC83246FE;
	Fri, 12 Dec 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFlc2zw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AD3242AD;
	Fri, 12 Dec 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552195; cv=none; b=NDrr1TcqW+YgWBF+mZZabGb5zVKtdxCv+vi6qc77r+yIUe9LdcjDoudG5Re+TRhAx+wwVdibzx1U/a/PEdbSNaAupoCJS3OrvKBFQx+EkcCF4zMM07VPK27jdxk4BRptPoqH4qwLhCi3AAnk1nfxxl4UjO1bATETifuglotyF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552195; c=relaxed/simple;
	bh=I+qP5oa35NoOJF+73V6wWh4dwUAPHcAldfi38uS5WuI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p/cgn9p7vyAx4QRS3J8owd0OFesNVbkPkFZT6zV6znm9Znykl060L0fZFOKEvpw/zbtpUTQpJSiM2+VZlc4cwB2bURzTbzMJogNycOeOtZ/qJNqin7Orq5VDXcDWuT26ncw1BC2MlNJ2jPt07HcTegul4hriFcH6pDo4IA/ZkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFlc2zw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE56AC16AAE;
	Fri, 12 Dec 2025 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765552195;
	bh=I+qP5oa35NoOJF+73V6wWh4dwUAPHcAldfi38uS5WuI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AFlc2zw2uucDYEetJfKb6XBj8TBwXASwMN9MPet0HvEcaanSlE7CFITn56A2NG0Ib
	 LoFG8vndRYLcbM6ivj35ZyuHl7Dl54SPU/dPhAUv42Ksl60fVNzCJWVkYgGoy11s5a
	 BNeo17SWZ+umGGp+2ixepMykt5a7BX77QjWbvy1e+qdonW9nhvOUmgbXP+WJ2nVNcS
	 EOVSjJ0g6UgRwf9qWwNqdT6EQiQQLovDE/JAddbONBvYdNp8XhzC8/Odi5NNcm/NIs
	 AT14mwe9DRWACSzFApxhaVxE0ZtWoeXsR7GlK6bQqbCiNqPlp0oafNMs4Mr8HXvwZg
	 9rLYAhv6iKaig==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BADCEF40072;
	Fri, 12 Dec 2025 10:09:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Dec 2025 10:09:53 -0500
X-ME-Sender: <xms:QTA8aUytefFxC2oGXmrPtewnnJ6B8_Or61aOCnsFzrIgWOZaKeHBOA>
    <xme:QTA8aTHlH6idpJ3_pm2MM2vNdMOk7tsA_MDPy9qIC5yQ5j62W55fqoGHxwv3x5hF7
    K-_fJsB__U7SHGzU8Gpu7NAabDJ3UZXbAY8w1ID2m5cbN8YI2i41es>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epleehteekvefhhfeuvdekuefftdffvdeufeekleehheekvdekjedviefghedtieelnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghr
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvd
    elkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    guihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhihhrohhfuhhmihesmhgrihhlrdhprghrkhhnvght
    rdgtohdrjhhppdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhope
    gthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrlhhmrgii
    rdgrlhgvgigrnhgurhhovhhitghhsehprghrrghgohhnqdhsohhfthifrghrvgdrtghomh
    dprhgtphhtthhopehvohhlkhgvrhdrlhgvnhguvggtkhgvsehsvghrnhgvthdruggvpdhr
    tghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QTA8aQsK8J2qgZIVIQpL0IU2tvEgcoBNSS-pcYB9aCNDNpVCS146Kw>
    <xmx:QTA8ac5Mxc9sC45MtvaVibuxvWHI83VyDcjf9hRiQBsxg605Qok5Xw>
    <xmx:QTA8ac3MFcDhqctl04FQyJ2MH7yxkLZd6RZUvPr3Cw8K79zESiXcMw>
    <xmx:QTA8aXjU7iWTbB8X2lQ8yM-rKYJ_vdqfhAdyjfiHmkvXweptVtUpOw>
    <xmx:QTA8aUq3Fwm0jIi3alstO43Q6A3IbUQhI-ALtJm_H-yLy2cjWJj3yYsN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9480578006C; Fri, 12 Dec 2025 10:09:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG4gnELdBCjJ
Date: Fri, 12 Dec 2025 10:08:18 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 Volker.Lendecke@sernet.de, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <ed9d790a-fea8-4f3e-8118-d3a59d31107b@app.fastmail.com>
In-Reply-To: <20251212021834.GB65406@macsyma.local>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org> <20251211234152.GA460739@google.com>
 <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
 <20251212021834.GB65406@macsyma.local>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Dec 11, 2025, at 9:18 PM, Theodore Tso wrote:
> On Thu, Dec 11, 2025 at 08:16:45PM -0500, Chuck Lever wrote:
>> 
>> > I see you're proposing that ext4, fat, and ntfs3 all set
>> > FILEATTR_CASEFOLD_UNICODE, at least in some cases.
>> >
>> > That seems odd, since they don't do the matching the same way.
>> 
>> The purpose of this series is to design the VFS infrastructure. Exactly what
>> it reports is up to folks who actually understand i18n.
>
> Do we know who would be receiving this information and what their needs 
> might be?

The unicode v. ascii case folding information was included just as
an example. I don't have any use case for that, and as I told Eric,
those specifics can be removed from the API.

The case-insensitivity and case-preserving booleans can be consumed
immediately by NFSD. These two booleans have been part of the NFSv3
and NFSv4 protocols for decades, in order to support NFS clients on
non-POSIX systems.

I'm told that Samba has to detect and expose file system case folding
behavior to its clients as well. Supporting Samba and other user
space file servers is why this series exposes case folding information
via a local user-space API. I don't know of any other category of
user-space application that requires access to case folding info.


The Linux NFS community has a growing interest in supporting NFS
clients on Windows and MacOS platforms, where file name behavior does
not align with traditional POSIX semantics.

One example of a Windows-based NFS client is [1]. This client
implementation explicitly requires servers to report
FATTR4_WORD0_CASE_INSENSITIVE = TRUE for proper operation, a hard
requirement for Windows client interoperability because Windows
applications expect case-insensitive behavior. When an NFS client
knows the server is case-insensitive, it can avoid issuing multiple
LOOKUP/READDIR requests to search for case variants, and applications
like Win32 programs work correctly without manual workarounds or
code changes.

Even the Linux client can take advantage of this information. Trond
merged patches 4 years ago [2] that introduce support for case
insensitivity, in support of the Hammerspace NFS server. In
particular, when a client detects a case-insensitive NFS share,
negative dentry caching must be disabled (a lookup for "FILE.TXT"
failing shouldn't cache a negative entry when "file.txt" exists)
and directory change invalidation must clear all cached case-folded
file name variants.

Hammerspace servers and several other NFS server implementations
operate in multi-protocol environments, where a single file service
instance caters to both NFS and SMB clients. In those cases, things
work more smoothly for everyone when the NFS client can see and adapt
to the case folding behavior that SMB users rely on and expect. NFSD
needs to support the case-insensitivity and case-preserving booleans
properly in order to participate as a first-class citizen in such
environments.

As a side note: I assumed these details were already well-known in
this community; otherwise I would have included it in the series
cover letter. I can include it when posting subsequent revisions.

-- 
Chuck Lever

[1] https://github.com/kofemann/ms-nfs41-client

[2] https://patchwork.kernel.org/project/linux-nfs/cover/20211217203658.439352-1-trondmy@kernel.org/

