Return-Path: <linux-fsdevel+bounces-49660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30EBAC0632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 09:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A641168B77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6424E4C7;
	Thu, 22 May 2025 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="Nq0MZJoR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkRK9y7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234023F41A;
	Thu, 22 May 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900435; cv=none; b=JrrNeH3L57JLQ5fD4nldJfRMlCKzB82T8yEypo+HGKC4jxZm3sfGoAHxl+huW5G/ESZF0wUx6UYtYY0bCayIAJO94Hy1B/Td9w1p8I6ojCszn+FFIU2ThkC8+oWzlVZexCKAqBn0O2tcze9+XYq0DQEQSV8U9I70ZqYpgDk/UMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900435; c=relaxed/simple;
	bh=w92H/viKcKLDXuRMV9siSFbaU0pW7/eviJ0e7xX4IsQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uxvJde99YNEr2RNCmkCI9Lk+6NHZJP7ydtWvbJ8emzP5isGyNrN1UP0h74GlSFvUxpJQNxv3Ja6fB7d1W4VDYhdAgBZYFtMq7fYgpLc5rzMZa3UEX1ojAPxkcnQiaFOf3gLWw28hQAdrOHCoA4ITVPzRqINXeJcH2ZvfBZif5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=Nq0MZJoR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkRK9y7i; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B7CFE1380044;
	Thu, 22 May 2025 03:53:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 22 May 2025 03:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747900431;
	 x=1747986831; bh=8y+itVGGU0k47O61Xq18ziael4/xcoC+X099PMJEObg=; b=
	Nq0MZJoReNTRiMbVR/6oAcLq5XxEawCW99gk2XKIklaMX/ItD0ChTPned4aQIDNa
	7QlFZ0eHqEXG0laoydUHAMLwEbU8hnxD9lkEmMBHHqLFx6gEQiZeoAVekErKJNLC
	p4J7ZIig+hcm+vvRjBsztX5jeFU6VK5cfMZsxXOeiQyVQOnWAXvBenVamlTJmZRu
	jplwJhBuHAbSEQkHIgkKqbr+9PB8c7DTUAm+lkZiQb9PAaZKSsPuRcBQItLKG0El
	ZMw7caFEKe2c/KhXlgQeakIR2AAAVwqmJ7y1SOeNilyI7y83Z/DbIlk39MjZ3GGr
	hD1KEYsUtnHC86aezOSSSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747900431; x=
	1747986831; bh=8y+itVGGU0k47O61Xq18ziael4/xcoC+X099PMJEObg=; b=n
	kRK9y7i1YnQtjdWhctxm6K1+POSXfYwooF2pjPMbTOkWuoX4MC1WSdpoe2GzFYKi
	uaSbWJjr4M60uKV6tHAQ2xUshr+EKId3STbZNs/K8BKDs6zZSKbePwInZC8VzQpK
	jjTLyuQPoX9Aap969SJk74vPWKkdhJgr1ZCkAkQjRvNDcZxBzMClt/cXO8GVYPj1
	cRuvfnPicoNWduhxKbPC3sCiWDijlR2REjkGWfHud/bXxukbH59iyJv2LzJtHFbV
	VOrRrAgTF9H+hZEodpYPa8GFMBzwAA9KEjkO1QR8dJSvs9y253oMsBZIMq3Vd6qR
	QwsgZTlCt8UB3A1VJOsFw==
X-ME-Sender: <xms:DtguaO_NiekAFwDgBr1Mz1-tTXt4mLAI4zxCQd8LraJL-41wwypk5Q>
    <xme:DtguaOuE-6BoCwEJRplcHY6150GWwQ_Twzrzd9twVzxvAikywIIwd7CWS2zqGXbZE
    PFatgFhc3ZcayRerGc>
X-ME-Received: <xmr:DtguaEASh85IkTNYgxHIUcaIzyRcYwXHLmF_TQOJzkh58mDn25_LY6yz9HVjEoXiJkCRLvevX5H1MsFGlNpRLPJWTdaugO5Ulw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehgeduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffh
    vffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishhtohhphhgvrhcuufhnoh
    ifhhhilhhlfdcuoegthhhrihhssehkohguvgehgedrnhgvtheqnecuggftrfgrthhtvghr
    nhepieeltedujeffgeejgeffhffhhfekfeejgfdtudejheehveelveejjeffkeeikeevne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhi
    sheskhhouggvheegrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgrlhhtvgdrshgthhhrohgvuggvrhesthhngihiphdruggv
    pdhrtghpthhtohepjhhohhhnsehsthhofhhfvghlrdhorhhgpdhrtghpthhtohepkhgvnh
    htrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgtphhtthhopegrmhhirhej
    fehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsggtrggthhgv
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhn
    ihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhu
X-ME-Proxy: <xmx:DtguaGexy-EXG_WoVA_IhcPUuW8DMr2AJkc9hG70UUhLkidkm1QNlA>
    <xmx:DtguaDPXVD73d8Mc7E7J9fpfoWHPFiQ_-4OXvDPDlo0rTdiYJ7lAgw>
    <xmx:DtguaAkPYuFVT_5pQh84BlwFRSN3_5i7AZ7Kp8uhOUT7hdBu40BY9Q>
    <xmx:DtguaFsOLC0_KRwhenrNx0Wy7Sf3beez3l0uWvVD-pnDbPguLSibrQ>
    <xmx:D9guaLy9E6eGdpmZkGfmW6WRef3ey3eS8VHK0mWz7O5YJa47OKEn4R6F>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 03:53:50 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 May 2025 00:53:49 -0700
Message-Id: <DA2IZNYD4QH3.111ZX60XF1N58@kode54.net>
Cc: "Amir Goldstein" <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-unionfs@vger.kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
From: "Christopher Snowhill" <chris@kode54.net>
To: =?utf-8?q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>, "John
 Stoffel" <john@stoffel.org>, "Kent Overstreet" <kent.overstreet@linux.dev>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <26668.52908.574606.416955@quad.stoffel.home>
 <25234476-2011-4ade-affe-687d45dcbc3c@tnxip.de>
In-Reply-To: <25234476-2011-4ade-affe-687d45dcbc3c@tnxip.de>

On Wed May 21, 2025 at 4:26 AM PDT, Malte Schr=C3=B6der wrote:
> On 20/05/2025 20:49, John Stoffel wrote:
>>>>>>> "Kent" =3D=3D Kent Overstreet <kent.overstreet@linux.dev> writes:
>>> On Tue, May 20, 2025 at 04:03:27PM +0200, Amir Goldstein wrote:
>>>> On Tue, May 20, 2025 at 2:43=E2=80=AFPM Kent Overstreet
>>>> <kent.overstreet@linux.dev> wrote:
>>>>> On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
>>>>>> On Tue, May 20, 2025 at 2:25=E2=80=AFPM Kent Overstreet
>>>>>> <kent.overstreet@linux.dev> wrote:
>>>>>>> On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
>>>>>>>> On Tue, May 20, 2025 at 7:16=E2=80=AFAM Kent Overstreet
>>>>>>>> <kent.overstreet@linux.dev> wrote:
>>>>>>>>> This series allows overlayfs and casefolding to safely be used on=
 the
>>>>>>>>> same filesystem by providing exclusion to ensure that overlayfs n=
ever
>>>>>>>>> has to deal with casefolded directories.
>>>>>>>>>
>>>>>>>>> Currently, overlayfs can't be used _at all_ if a filesystem even
>>>>>>>>> supports casefolding, which is really nasty for users.
>>>>>>>>>
>>>>>>>>> Components:
>>>>>>>>>
>>>>>>>>> - filesystem has to track, for each directory, "does any _descend=
ent_
>>>>>>>>>   have casefolding enabled"
>>>>>>>>>
>>>>>>>>> - new inode flag to pass this to VFS layer
>>>>>>>>>
>>>>>>>>> - new dcache methods for providing refs for overlayfs, and filesy=
stem
>>>>>>>>>   methods for safely clearing this flag
>>>>>>>>>
>>>>>>>>> - new superblock flag for indicating to overlayfs & dcache "files=
ystem
>>>>>>>>>   supports casefolding, it's safe to use provided new dcache meth=
ods are
>>>>>>>>>   used"
>>>>>>>>>
>>>>>>>> I don't think that this is really needed.
>>>>>>>>
>>>>>>>> Too bad you did not ask before going through the trouble of this i=
mplementation.
>>>>>>>>
>>>>>>>> I think it is enough for overlayfs to know the THIS directory has =
no
>>>>>>>> casefolding.
>>>>>>> overlayfs works on trees, not directories...
>>>>>> I know how overlayfs works...
>>>>>>
>>>>>> I've explained why I don't think that sanitizing the entire tree is =
needed
>>>>>> for creating overlayfs over a filesystem that may enable casefolding
>>>>>> on some of its directories.
>>>>> So, you want to move error checking from mount time, where we _just_
>>>>> did a massive API rework so that we can return errors in a way that
>>>>> users will actually see them - to open/lookup, where all we have are =
a
>>>>> small fixed set of error codes?
>>>> That's one way of putting it.
>>>>
>>>> Please explain the use case.
>>>>
>>>> When is overlayfs created over a subtree that is only partially case f=
olded?
>>>> Is that really so common that a mount time error justifies all the vfs
>>>> infrastructure involved?
>>> Amir, you've got two widely used filesystem features that conflict and
>>> can't be used on the same filesystem.
>> Wait, what?  How many people use casefolding, on a per-directory
>> basis?  It's stupid.  Unix/Linux has used case-sensitive filesystems
>> for years.  Yes, linux supports other OSes which did do casefolding,
>> but yikes... per-directory support is just insane.  It should be
>> per-filesystem only at BEST. =20
>>
>>> That's _broken_.
>> So?  what about my cross mounting of VMS filesystems with "foo.txt;3"
>> version control so I can go back to previous versions?  Why can't I do
>> that from my Linux systems that's mounting that VMS image?  =20
>>
>> Just because it's done doesn't mean it's not dumb. =20
>>
>>> Users hate partitioning just for separate /boot and /home, having to
>>> partition for different applications is horrible. And since overlay
>>> fs is used under the hood by docker, and casefolding is used under
>>> the hood for running Windows applications, this isn't something
>>> people can predict in advance.
>> Sure I can, I don't run windows applications to screw casefolding.
>> :-)
>>
>> And I personally LIKE having a seperate /boot and /home, because it
>> gives isolation.  The world is not just single user laptops with
>> everything all on one disk or spread across a couple of disks using
>> LVM or RAID or all of the above. =20
>>
>> I also don't see any updates for the XFS tests, or any other
>> filesystem tests, that actually checks and confirms this decidedly
>> obtuse and dumb to implement idea. =20
>>
>>
>> John
>>
> Hi there,
>
> would you partition different subdirs of your /home? So there is
> .local/share/containers where users put their container-stuff (at least
> podman does). Then there is .wine where case-folding-craziness lives.
> And then there is the mess that is Steam, which does all kinds of
> containery case-foldy stuff. As much as I would like to keep these
> things apart, it is not feasible. Not for me as a "power user", and
> certainly far out of reach for average Joe user.
>
> Just my 2 ct, greets

"But just disable it globally" How about no. Sure, ext4 has that flag,
but bcachefs by design does not. And a change that already made it into
6.15 has made it trip overlayfs as it is now, unconditionally. The
purpose of this new implementation is to make it work, and satisfy the
condition that overlayfs is guaranteed no casefolding in its tree, and
that nobody may create a new folder inside that tree and suddenly turn
on casefolding on it.

And this change also makes it possible to use it with ext4 with the
global casefolding flag enabled. It shouldn't be necessary to have a
global killswitch, these features should be able to live together on the
same filesystem as long as they're not touching each other, and aren't
allowed to touch each other.

>
> /Malte


