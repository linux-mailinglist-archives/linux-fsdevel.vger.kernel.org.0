Return-Path: <linux-fsdevel+bounces-60455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9442DB47858
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 02:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B51B1B21433
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6FB676;
	Sun,  7 Sep 2025 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="ANf1U2hM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hT3F9hVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901928E7;
	Sun,  7 Sep 2025 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757203361; cv=none; b=GXs9bxiqr6FnQ+MKJx/SCjHXr04T2qn+dZoKPwikQiArV9Uh+JmMHpKSZMongCelqwgGJ/4NvZNrs53bqY33rg4l600fSPNBysR8Q17LuDBjHlI6mk9W6FHH2uHDDJhIdUGfZe9bMy0J2o0J6ePIve5C60B0weji6J1T1w2RZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757203361; c=relaxed/simple;
	bh=m2C39utGeSIjhO+u/pw1ybkJdZRkx3DlFtqGTKKJB7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=jTfAoaK+Ci44drvB83/aScYIk3hD4Ms+u7IVuMmgCGT+twitbgj4R749lSmISWaVC/5ZhuDa3h8IhIQ1aSYDoN9BzWfZdaUQ2Uz1HU2G3n2m+aIrygtDuChGLiJjZblWFHhqbJBq20KDyxGF6XZm12Jke7XV9+XXeNiID/YTFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=ANf1U2hM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hT3F9hVP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C3E61400045;
	Sat,  6 Sep 2025 20:02:38 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sat, 06 Sep 2025 20:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1757203358; x=1757289758; bh=FtuRzLCULGUQ93vPFbWETTnax8WUYLwb
	sIz9czNrpHU=; b=ANf1U2hMEpk8LsR/5iWUt+cvKr1oBPh8G9lkAqk26OWHgg+V
	YTYuIA3of0GafTgJraWX1P8mdv9p/QhMP8ENljMpf6YLvhdruCVbj9AsgnvYHUJK
	w0X28wGOJUOs8xgaHxlbz8U1aNdNfYdiyk3oAq+sCA41J1Rag2+4Lo722osem8Zp
	101qVCb17hSBNYgfEz29kHMI+13DPY6e0UULiQwxNMpKlHFRa+3k2zYh/h+pNEK4
	y6q2WHY+3Ke5BA3tUB1PQZo3XTSi7OzbJ9yKWssv/w6nLiY41LNKmX1VOxsoNKNP
	vo8hk4D+dmwCpanCgQK/k1cB9twg02C78t3KzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757203358; x=1757289758; bh=FtuRzLCULGUQ93vPFbWETTnax8WU
	YLwbsIz9czNrpHU=; b=hT3F9hVPsoJto7EgcpgbYCLDhPYvqDAQ0S3LzrzZvx7N
	P6XRjMWo3Z9IsQyuqvFI++1or+50utHeCMAws0wUuLvQiWEPO0FLj3MYIXNofwjP
	6SScrood1z8Ue9hkTv29PQR3dzsJuVzxf+zdCl6qNGZRAaBg/eef/MWI+BFLPsGe
	GbyRAvVxebMxne17PjK6IIfAiiV49Q56bfqkLnLlY1f1EQATvk9Mde8y0/qHl86n
	Zgp5fl9TfDqZMB6e5Y5F4qvl3slBBN69fFhAOT3MAMpUlDbeU1iWZmFRZnwxGWOw
	VVjS4tNkBc+MgUmSraLoaxdGyOZJcUP6rKyy3OGkQA==
X-ME-Sender: <xms:ncu8aAd5E7a3wjT-ZJOhy9ERgSM-MpeiB-639yM9SmbQtXBiHdX50A>
    <xme:ncu8aCPucPEJoqHpgBZs0WlNQo7PwGrUnUHRQMQAHbnvQc4sMeBVtNu6p8Zv9DTW4
    cqOakF9gG4e-nzrtdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhsucfo
    uhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfehjeejledvgeefgfettedtjeeuieeujeevudefjeevtedvfffg
    vedulefftddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgvrhhrvghllhhnsehfsg
    drtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsth
    hrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ncu8aABBL86b95KRx-sjbZ7OV4CFJBXvzG6k6dm6JyTKygHCMhjbJQ>
    <xmx:ncu8aAf1vYCylz1VLxU1BFxh21pmiglM43GD5n2p7MAEbvJLlKxnkg>
    <xmx:ncu8aF7f6mb2XxgM1ZUCnS4vYBv2EbX_D7gLL8E4JChq0Ovmx4xY6g>
    <xmx:ncu8aLXpGo5Lg1gqGEqvutZ_MZIY5eZWrQ49M4A7F3su_nFEKO8AGw>
    <xmx:nsu8aKRJ_1tK-DbOw7lqImqYU0QdTiq9GhJ0159vOxHMkNUIeBEE5eJ4>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8717418C0068; Sat,  6 Sep 2025 20:02:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 06 Sep 2025 20:01:59 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Cc: brauner@kernel.org, dsterba@suse.com, terrelln@fb.com,
 "Linux Devel" <linux-fsdevel@vger.kernel.org>
Message-Id: <e2179aaa-871f-4478-b72c-45f1410dff87@app.fastmail.com>
Subject: regression, btrfs mount failure when multiple rescue mount options used
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel with mount failures:
6.17.0-0.rc4.36.fc43.x86_64
6.16.4-200.fc42.x86_64
6.15.11-200.fc42.x86_64


# mount -o ro,rescue=usebackuproot,nologreplay,ibadroots /dev/loop0 /mnt
mount: /mnt: fsconfig system call failed: btrfs: Unknown parameter 'nologreplay'.
       dmesg(1) may have more information after failed mount system call.
# mount -o ro,rescue=usebackuproot /dev/loop0 /mnt
# umount /mnt
# mount -o ro,rescue=usebackuproot,ibadroots /dev/loop0 /mnt
# mount: /mnt: fsconfig system call failed: btrfs: Unknown parameter 'ibadroots'.
       dmesg(1) may have more information after failed mount system call.
# mount -o ro,rescue=ibadroots /dev/loop0 /mnt
#

There are no kernel messages for the failures.

Looks like single rescue options work, but multiple rescue options separated by comma fail.

Any rescue option after the first comma, results in an fsconfig complaint.  Since it looks like fsconfig migration fallout, I'll cc some additional folks, and fs-devel.

---

I get different results with kernel 6.14.11-300.fc42.x86_64 but I think some of the bugs are fixed in later kernels hence the different behavior. And in any case it's EOL so I won't test any further back than this kernel.

# mount -o ro,rescue=usebackuproot,nologreplay,ibadroots /dev/loop0 /mnt
mount: /mnt: fsconfig system call failed: btrfs: Unknown parameter 'ibadroots'. 
       dmesg(1) may have more information after failed mount system call.

Notice the complaint is about ibadroots, not nologreplay. And there is a kernel message this time.

Sep 06 19:44:38 fnuc.local kernel: BTRFS warning: 'nologreplay' is deprecated, use 'rescue=nologreplay' instead


But there's more. All of these commands result in mount succeeded, but kernel messages don't indicate they were used.

# mount -o ro,rescue=ibadroots /dev/loop0 /mnt
# umount /mnt
# mount -o ro,rescue=usebackuproot /dev/loop0 /mnt
# umount /mnt
# mount -o ro,rescue=nologreplay /dev/loop0 /mnt

This one has yet another different  outcome, I don't know why.

# mount -o ro,rescue=idatacsum /dev/loop0 /mnt
mount: /mnt: fsconfig system call failed: btrfs: Bad value for 'rescue'.
       dmesg(1) may have more information after failed mount system call.



--
Chris Murphy

