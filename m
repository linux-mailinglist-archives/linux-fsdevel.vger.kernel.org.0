Return-Path: <linux-fsdevel+bounces-52652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C069AE57D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 01:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18524189B813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CC22A4E5;
	Mon, 23 Jun 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="B0J1aNK9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLE7CQ89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3E1F8733;
	Mon, 23 Jun 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720621; cv=none; b=kiA1RCQjOocynjvGHBh/V+Z3b+BJZb3H2aGhZgjHF+YcbtgkMDf2W7VSGsmBncHKUHQsHLjwJRgaRWaO355e/U6YtxOyJK37ck5lNlyIc7QwV3IYAZ+LXX6t8WE6gsJTQ/avdC1yd7LA9ekPhKqpWMKXey/eOf8QyxASB+uSq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720621; c=relaxed/simple;
	bh=71pJsM3gzbp8rm6YAfsKW8tj2ctRBzo5ZmlWXm4OWJU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=azP1xgTwXYsMzUZrVZgVYmwBzRrA3QALkiReKLkZBz21pDrikfXJSx5wmq8CaEqljwOfZm86hDmKTMYPM8ZaSY25AtxyEMkb9NiaYbD/dZOCpqfGqygDqBSXv6ZE63nuff7giRfnWQu/MqUgnfdahKbKP49Zual5Nbb6CJxBBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=B0J1aNK9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLE7CQ89; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15F547A0129;
	Mon, 23 Jun 2025 19:16:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Jun 2025 19:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750720617;
	 x=1750807017; bh=YB4d3JNkqZQIjLYwtoIIAzTgwhFqF5uw4DddLQBZ8z4=; b=
	B0J1aNK9MfpJ0VOntaHqSrVdx3eI9Xo3zoZCAsLFFyhPik40MMgFLnBTgdWjopcK
	7HAP26odyvEUmFSxfElM1uECzOz8gsWP01IzBqxFdE5r627FjAtu5Vg3lCdevuit
	FSmqUlaChAfx3mv2jnYG2eFx3liTkCZ/sE54zogGk037czzlOxo2F1F0HOdk6DJ9
	Ba7HDh9SK4tAv2J8slzfU0L2vvS+7TvJ/Y1HdwqFGuVZSOM1ld4Chbsm/HMpEi3B
	RcDx8ZiUIzsRwEPLCpZciDyqry7UvlMRpCznmBtxI4cJfcUD8maqWUdkED/XXCCS
	dYheU6CEiXW/7UFHGQIytQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750720617; x=
	1750807017; bh=YB4d3JNkqZQIjLYwtoIIAzTgwhFqF5uw4DddLQBZ8z4=; b=L
	LE7CQ894Q0tAxxOwCD75QFXOIRc6oLLkGLQNdHI3JCbw2tcCJVFyBkEGBU2U/f4H
	kBuIhtFkvG2jADVbFJFjzxKs3321eqDjCBGu1CJQxo1DQDg4sN4NeKcrPA8v3W1E
	ToXfGo3YAuOK4g4mUXMMwbJvzgqGMBIuQkM1Jmng/obHovHu5nRfL9bMtvw8GClq
	GcUjGiFY7poxedMmv8n5MvSNSwl3wubpELZ6+6ze7qWY3zcs7WSfrmLlrLNubpeF
	edeyT+XkNWcuWwYA+LL7EIePbmlHm3NMZPNpPEhwGzVIowUHMWtSltRwgfbU0ikK
	uOkAfbP5yfWuaJ/rINR+g==
X-ME-Sender: <xms:aeBZaJS02kZJRNLpwB3bhwRtRBQGPsznKwFkPx_wHWc7bo-GOyKDiA>
    <xme:aeBZaCz3wcH_seW2ddiE1jMp1ZzCa4nxFgpYI98HJzn9fNZZdvwquQYmX-t4UEKGa
    9SNW8__-CtVRWqe9Nk>
X-ME-Received: <xmr:aeBZaO0dmL-oGvBnzBzPHOpEP4oRFsO-NouCkHqKpZBvmJfPZAdtbVUzl1TxoP83Ie4nBlJ0lwJBDUCOQVjrHC28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejfe
    fggefhjeeuhfehieegvdetteduiedufeevhfehgffgfffhtedufeetveduffenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvg
    htpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhith
    ihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aeBZaBAYB6CVv4XWrZgPYHhGR738gnBbauzkFxMEm7JdX9u3T6wHrQ>
    <xmx:aeBZaChjp813BFmr4tAf4ee-13TV_jSArL7YJsImdNzA0GIboSsumQ>
    <xmx:aeBZaFrEIY2vAGqO7pInpPdYeqJcmKGQpoBoltrTSJsgUchtg8LQnw>
    <xmx:aeBZaNgHX-8tx_BYANk60HAqOTdNl25dUcNsEv39MdZcwJYVpUi_CA>
    <xmx:aeBZaJNBYey6P8kKq6EOFq6SfA6GtRLbnm6yrzHyxFEddKichYGnMBrH>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 19:16:56 -0400 (EDT)
Message-ID: <351dd18f-5c17-4477-a9b9-23075e8722fa@maowtm.org>
Date: Tue, 24 Jun 2025 00:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
 <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
 <20250623.kaed2Ovei8ah@digikod.net>
Content-Language: en-US
In-Reply-To: <20250623.kaed2Ovei8ah@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/25 20:40, Mickaël Salaün wrote:
> On Sun, Jun 22, 2025 at 04:42:49PM +0100, Tingmao Wang wrote:
>> On 6/19/25 12:38, Mickaël Salaün wrote:
>>> On Sat, Jun 14, 2025 at 07:25:02PM +0100, Tingmao Wang wrote:
>>>> [...]
>>>>
>>>> This might need more thinking, but maybe if one of the operands is
>>>> disconnected, we can just let it walk until IS_ROOT(dentry), and also
>>>> collect access for the other path until IS_ROOT(dentry), then call
>>>> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
>>>> this case is_access_to_paths_allowed will not do any walking and just make
>>>> an access decision.)
>>>
>>> If one side is in a disconnected directory and not the other side, the
>>> rename would be denied by the VFS,
>>
>> Not always, right? For example in the path_disconnected_rename test we did:
> 
> Correct, only the mount point matter.
> 
>>
>> 5051.  ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
>>                              ^^^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
>>                              Disconnected              Connected
>>
>> (and it also has the other way)
>>
>> So looks like as long as they are still reached from two fds with two
>> paths that have the same mnt, it will be allowed.  It's just that when we
>> do parent walk we end up missing the mount.  This also means that for this
>> refer check, if after doing the two separate walks (with the disconnected
>> side walking all the way to IS_ROOT), we then walk from mnt again, we
>> would allow the rename if there is a rule on mnt (or its parents) allowing
>> file creation and refers, even if the disconnected side technically now
>> lives outside the file hierarchy under mnt and does not have a parent with
>> a rule allowing file creation.
>>
>> (I'm not saying this is necessary wrong or needs fixing, but I think it's
>> an interesting consequence of the current implementation.)
> 
> Hmm, that's indeed a very subtle side effect.  One issue with the
> current implementation is that if a directory between the mount
> point and the source has REFER, and another directory not part of the
> source hierarchy but part of the disconnected directory's hierarchy has
> REFER and no other directory has REFER, and either the source or the
> destination hierarchy is disconnected between the mount point and the
> directory with the REFER, then Landlock will still deny such
> rename/link.  A directory with REFER initially between the mount point
> and the disconnected directory would also be ignored.  There is also the
> case where both the source and the destination are disconnected.

Sorry, I'm having trouble following this.  Can you maybe give a more
specific example, perhaps with commands?

By "mount point" do you mean the bind mount? If a path has became
disconnected because the directory moved away from under the mountpoint,
and is therefore not covered by any REFER (you said "either the source or
the destination hierarchy is disconnected between the mount point and the
directory with the REFER") wouldn't it make sense for the rename to be
denied?

> 
> I didn't consider such cases with collect_domain_accesses().  I'm
> wondering if this path walk gap should be fixed (instead of applying
> https://lore.kernel.org/all/20250618134734.1673254-1-mic@digikod.net/ )
> or not.  We should not rely on optimization side effects, but I'm not
> sure which behavior would make more sense...  Any though?

I didn't quite understand your example above and how is it possible for us
to end up denying something that should be allowed.  My understanding of
the current implementation is, when either operands are disconnected, it
will walk all the way to the current filesystem's root and stop there.
However, it will then still do the walk from the original bind mount up to
the real root (/), and if there is any REFER rules on that path, we will
still allow the rename.  This means that if the rename still ends up being
denied, then it wouldn't have been allowed in the first place, even if the
path has not become disconnected.

An interesting concrete example I came up with:

/# uname -a
Linux 5610c72ba8a0 6.16.0-rc2-dev #43 SMP ...
/# mkdir /a /b
/# mkdir /a/a1 /b/b1
/# mount -t tmpfs none /a/a1
/# mkdir /a/a1/a11
/# mount --bind /a/a1/a11 /b/b1
/# mkdir /a/a1/a11/a111
/# tree /a /b
/a
`-- a1
    `-- a11
        `-- a111
/b
`-- b1
    `-- a111

7 directories, 0 files
/# cd /b/b1/a111/
/b/b1/a111# mv /a/a1/a11/a111 /a/a1/a12
/b/b1/a111# ls ..  # we're disconnected now
ls: cannot access '..': No such file or directory
/b/b1/a111 [2]# touch /a/a1/a12/file

/b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer ls
Executing the sandboxed command...
file

/b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer mv -v file file2
Executing the sandboxed command...
mv: cannot move 'file' to 'file2': Permission denied
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# This fails because for same dir rename we just use is_access_to_path_allowed,
# which will stop at /a/a1 (and thus never reach either /b/b1 or /).

/b/b1/a111 [1]# mkdir subdir
/b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/b/b1  /sandboxer mv -v file subdir/file2
Executing the sandboxed command...
[..] WARNING: CPU: 1 PID: 656 at security/landlock/fs.c:1065 ...
renamed 'file' -> 'subdir/file2'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# This works because now we restart walk from /b/b1 (the bind mnt)

/b/b1/a111# mv subdir/file2 file
/b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/a  /sandboxer mv -v file subdir/file2
Executing the sandboxed command...
mv: cannot move 'file' to 'subdir/file2': Permission denied
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# This is also not allowed, but that's OK since even though technically we're
# actually moving /a/a1/a12/file to /a/a1/a12/subdir/file2, we're not doing it
# through /a (we're walking into a12 via /b/b1, so rules on /a shouldn't
# apply anyway)

/b/b1/a111 [1]# LL_FS_RO=/:/a/a1 LL_FS_RW=/b  /sandboxer mv -v file subdir/file2
Executing the sandboxed command...
renamed 'file' -> 'subdir/file2'
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# And this works because we walk from /b/b1 after doing collect_domain_accesses

I think overall this is just a very strange edge case and people should
not rely on the exact behavior whether it's intentional or optimization
side-effect (as long as it deny access / renames when there is no rules at
any of the reasonable upper directories).  Also, since as far as I can
tell this "optimization" only accidentally allows more access (i.e.  rules
anywhere between the bind mountpoint to real root would apply, even if
technically the now disconnected directory belongs outside of the
mountpoint), I think it might be fine to leave it as-is, rather than
potentially complicating this code to deal with this quite unusual edge
case?  (I mean, it's not exactly obvious to me whether it is more correct
to respect rules placed between the original bind mountpoint and root, or
more correct to ignore these rules (i.e. the behaviour of non-refer access
checks))

It is a bit weird that `mv -v file file2` and `mv -v file subdir/file2`
behaves differently tho.

If you would like to fix it, what do you think about my initial idea?:
> This might need more thinking, but maybe if one of the operands is
> disconnected, we can just let it walk until IS_ROOT(dentry), and also
> collect access for the other path until IS_ROOT(dentry), then call
> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
> this case is_access_to_paths_allowed will not do any walking and just make
> an access decision.)

This will basically make the refer checks behave the same as non-refer
checks on disconnected paths - walk until IS_ROOT, and stop there.


