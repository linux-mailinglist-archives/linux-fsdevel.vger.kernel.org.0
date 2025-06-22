Return-Path: <linux-fsdevel+bounces-52395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18829AE308F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBDD3AFB94
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01C1EEA5F;
	Sun, 22 Jun 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="lPSC/sCy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gow1mpz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB6A29;
	Sun, 22 Jun 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750606975; cv=none; b=eTAFQpznUmS/Eaa/U0pflRTZbmeAa3JxF1fWnsHooRxdIAxgRoCFUJMCDfeuiJgrjv5J4OBs2SUgWzs4lzv2HocR+Lqr0QtvKMF2vVTcrFFK14tnjEK0aaGpVtqejghh8cVJ8etszMkBhZRQvKGM7HdbxEdIBaWKYImmvxp8tJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750606975; c=relaxed/simple;
	bh=DDNbQPrK/REqYVh41QqvXHp1MiOXi6xUKE+hniCyNUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOXEAPIelJMsEBN2vj4iZTvE6nWfkAQXxkU97NyI5zT6MK0+pnQ1ygHD8Xl3RMEPSL2p9Q0GLyltuTlZJKixCDjB8PrP+Nxq1qNQ3TKHtM5qvxnjN4DeILUsKzzmOUCB1+Sh+XKWkaYTkv0ajl7vLYuA05zCsG7UhuLwxH32J2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=lPSC/sCy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gow1mpz1; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0880E11400B7;
	Sun, 22 Jun 2025 11:42:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 22 Jun 2025 11:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750606971;
	 x=1750693371; bh=FepGB0srGgydDCOHwhq+mBC9m0BxCDLbJ5u6HsGyC9c=; b=
	lPSC/sCyhaUnM+IMc5YCLx+CSLdMXlGZJCP5rrCkElOF4nM/+mU58prhtKhHw5yD
	p4dmyOki20o+UJG8ra/tqPIxbmXDdMrg0GlaaOTu2QQX2ZS16teOfXlzRTSHD5bS
	Iv9ccGF9xNZ2+Yc2XXeSoGlUbbnNslC9JdVABgsBTbFcVzEEvBd20u1v7sW4/6qV
	PVhXvXrJVjpgJqUpmF8J4o3yOOD98jklAr3bQlda6FDegqCBbVLHZztoaKGYQIuU
	xE4OGXesrYvDUQeuGa/O2PuhKwM921SdDvIC0YkDOfu18BkyeOZW1kKWUT1E99bs
	hjf4TjyCXxxX9ucfm6neHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750606971; x=
	1750693371; bh=FepGB0srGgydDCOHwhq+mBC9m0BxCDLbJ5u6HsGyC9c=; b=g
	ow1mpz1nxO79aeQt0X1sS/UGuP2w/VXlAgJXPKl600BBHDl5hCatDSB7wN3bDWfx
	D0B7gcuo9uazLz5sT4YN8XZZE8fXRw76hBaPVB3PQpWexR8hzIerCArHnrOeqjnP
	fzJrE4vBLse18WadgXLJxF/ERLh7XjLwjlk7hwajVjWhVEqm9mvaP8bDaUHjswLm
	DebUm/N6+pbjxaI4uFFBqUnJxCjNOLu5TpQEoGBdu9K+JN3kjL42yogf993KiiR5
	5xlbNENC8RtVpGy74EbRQI6x8Y+D1auKY/jOZGQF8sBgd4I0+shvpbRlNM4CGPEV
	YRYAobYvu/M7Yy5Vx4LAA==
X-ME-Sender: <xms:eyRYaDAEK42pXqBqmKDzD-gZoIg9janvOB6TezUyTeDBI-7UO-trSQ>
    <xme:eyRYaJgESoVe16VKmGAhMdAo7LuzGnSc7E3uuV1Ie8UIk2bQnAvVGBhaY7cHQQ9vh
    -g769xC6abeeO1HMAQ>
X-ME-Received: <xmr:eyRYaOncJEQcO8pLxbG3exRqMBJ_QjO7rHCorNcj2nt0YXXI_D1foWP39l232XXBr5jqbPxV2MdPH4_O_SF9eOBe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddugeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeegke
    ffgeffuefhfeeitdejteeufeelleefudegkeevffdvvdejtddvvdeihffgjeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvg
    htpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhith
    ihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eyRYaFzR2hvbWt3CBXcilTRrgfEfn-60a8uVMnTB7tRp4DVwiI4y2w>
    <xmx:eyRYaISQV3nkzcKVSVnOOmEIAaGT2UVdQDtXHUCpPLeJ5cUsi27nkA>
    <xmx:eyRYaIa8tYiYC-Kl4t63pLh8pKdDsNnNHy7wQUIWXDykDVp-QEIZ-Q>
    <xmx:eyRYaJQ65-6YlAB2hNj7puMoFEwv7MNlzuLfGcdzpNGNtd5u1U5K5g>
    <xmx:eyRYaL-i3DBW_VGlv-mWtNToMMQHvAIz8AKEtiaKMt_xmi18NEL2M30s>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 11:42:50 -0400 (EDT)
Message-ID: <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
Date: Sun, 22 Jun 2025 16:42:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250619.yohT8thouf5J@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/19/25 12:38, Mickaël Salaün wrote:
> On Sat, Jun 14, 2025 at 07:25:02PM +0100, Tingmao Wang wrote:
>> This adds a test for the edge case discussed in [1], and in addition also
>> test rename operations when the operands are through disconnected paths,
>> as that go through a separate code path in Landlock.
>>
>> [1]: https://lore.kernel.org/linux-security-module/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org/
>>
>> This has resulted in a WARNING, due to collect_domain_accesses() not
>> expecting to reach a different root from path->mnt:
>>
>> 	#  RUN           layout1_bind.path_disconnected ...
>> 	#            OK  layout1_bind.path_disconnected
>> 	ok 96 layout1_bind.path_disconnected
>> 	#  RUN           layout1_bind.path_disconnected_rename ...
>> 	[..] ------------[ cut here ]------------
>> 	[..] WARNING: CPU: 3 PID: 385 at security/landlock/fs.c:1065 collect_domain_accesses
>> 	[..] ...
>> 	[..] RIP: 0010:collect_domain_accesses (security/landlock/fs.c:1065 (discriminator 2) security/landlock/fs.c:1031 (discriminator 2))
>> 	[..] current_check_refer_path (security/landlock/fs.c:1205)
>> 	[..] ...
>> 	[..] hook_path_rename (security/landlock/fs.c:1526)
>> 	[..] security_path_rename (security/security.c:2026 (discriminator 1))
>> 	[..] do_renameat2 (fs/namei.c:5264)
>> 	#            OK  layout1_bind.path_disconnected_rename
>> 	ok 97 layout1_bind.path_disconnected_rename
> 
> Good catch and thanks for the tests!  I sent a fix:
> https://lore.kernel.org/all/20250618134734.1673254-1-mic@digikod.net/
> 
>>
>> My understanding is that terminating at the mountpoint is basically an
>> optimization, so that for rename operations we only walks the path from
>> the mountpoint to the real root once.  We probably want to keep this
>> optimization, as disconnected paths are probably a very rare edge case.
> 
> Rename operations can only happen within the same mount point, otherwise
> the kernel returns -EXDEV.  The collect_domain_accesses() is called for
> the source and the destination of a rename to walk to their common mount
> point, if any.  We could maybe improve this walk by doing them at the
> same time but because we don't know the depth of each path, I'm not sure
> the required extra complexity would be worth it.  The current approach
> is simple and opportunistically limits the walks.
> 
>>
>> This might need more thinking, but maybe if one of the operands is
>> disconnected, we can just let it walk until IS_ROOT(dentry), and also
>> collect access for the other path until IS_ROOT(dentry), then call
>> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
>> this case is_access_to_paths_allowed will not do any walking and just make
>> an access decision.)
> 
> If one side is in a disconnected directory and not the other side, the
> rename would be denied by the VFS,

Not always, right? For example in the path_disconnected_rename test we did:

5051.  ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
                             ^^^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
                             Disconnected              Connected

(and it also has the other way)

So looks like as long as they are still reached from two fds with two
paths that have the same mnt, it will be allowed.  It's just that when we
do parent walk we end up missing the mount.  This also means that for this
refer check, if after doing the two separate walks (with the disconnected
side walking all the way to IS_ROOT), we then walk from mnt again, we
would allow the rename if there is a rule on mnt (or its parents) allowing
file creation and refers, even if the disconnected side technically now
lives outside the file hierarchy under mnt and does not have a parent with
a rule allowing file creation.

(I'm not saying this is necessary wrong or needs fixing, but I think it's
an interesting consequence of the current implementation.)

> but Landlock should still log (and then deny) the side that would be
> denied anyway.
> 
>>
>> Letting the walk continue until IS_ROOT(dentry) is what
>> is_access_to_paths_allowed() effectively does for non-renames.
>>
>> (Also note: moving the const char definitions a bit above so that we can
>> use the path for s4d1 in cleanup code.)
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
> 
> I squashed your patches and push them to my next branch with some minor
> changes.  Please let me know if there is something wrong.

Thanks for the edits!  I did notice two things:

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fa0f18ec62c4..c0a54dde7225 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4561,6 +4561,17 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 FIXTURE(layout1_bind) {};
 /* clang-format on */
 
+static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
+static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
+/* Moved targets for disconnected path tests. */
    ^^^^^^^^^^^^^
    I had "Move targets" here as a noun (i.e. the target/destinations of
    the renames)

+static const char dir_s4d1[] = TMP_DIR "/s4d1";
+static const char file1_s4d1[] = TMP_DIR "/s4d1/f1";
...

Also, I was just re-reading path_disconnected_rename and I managed to get
confused (i.e. "how is the rename in the forked child allowed at all (i.e.
how did we get EXDEV instead of EACCES) after applying layer 2?").  If you
end up amending that commit, can you add this short note:

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index c0a54dde7225..84615c4bb7c0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4936,6 +4936,8 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 		},
 		{}
 	};
+
+	/* This layer only handles LANDLOCK_ACCESS_FS_READ_FILE only. */
 	const struct rule layer2_only_s1d2[] = {
 		{
 			.path = dir_s1d2,

Wish I had caught this earlier.  I mean neither of the two things are
hugely important, but I assume until you actually send the merge request
you can amend stuff relatively easily?  If not then it's also alright :)

>
> [...]

Ack to all suggestions, thanks!

Best,
Tingmao

