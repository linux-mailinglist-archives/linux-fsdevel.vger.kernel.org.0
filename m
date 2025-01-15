Return-Path: <linux-fsdevel+bounces-39326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888CA12B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EBA3A59D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C211D63D5;
	Wed, 15 Jan 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pBGQXSkF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3L7E7O8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5619922A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967351; cv=none; b=XqOqkPXZ3IzCZ47PJPzR8kGsOc/DG+RlsGZ276+Qkt3i/LdOoX7HOHadYbGh3K/n7CF6xjySScVUNq3lFafFaTQ+Ldd8THFrMF7bIMMzzOLVKOuw1ChaX3FQ4HFm6lFEWCiNvOspzvLJKdN+00RUSqccOtArFWYdIEYpDY1kTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967351; c=relaxed/simple;
	bh=0KmddYUgBmXzMsS1DZ/nke+p3KeI0BTDkC6DScpFCLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nfw8vDGs7CVCmS0mS9NZdg0Wf2Dnfh5l8Xh4d9WsXfNvLO+EI6duZQibWRXJMKkX7QHwFjhn7D8zohK48Hc+jZLhDlN8+7hyJzhkLLQzgshg0wJw9NY2zA9ugw2NdFE/13dE166k9+Ucv1HQJ9ku1LQyuJTbNYQF6BbYV5xfkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pBGQXSkF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d3L7E7O8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3935C1380208;
	Wed, 15 Jan 2025 13:55:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 13:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1736967347; x=1737053747; bh=0KmddYUgBmXzMsS1DZ/nke+p3KeI0BTD
	kC6DScpFCLE=; b=pBGQXSkFKOau97NVHO85kZ5viWckbzWUnJF7o6h2KBBqKvNR
	HxIpgO4JJkdFdj9YFy6j//OPgVtFc9y/pW5A0TaU2ettm9RdNtRvS9G3Fc1i3xw8
	fQVIOKXQrG/UDSB0CBmX0pzdvMrhSfl3mdOmftBVLjl3HMwmCThkqUiHaV/cGVmy
	nYlmYOBWLh1Ee4bdJA8oQigzhc+wgkvT9uQSfz7AyOkH79DUzOauFX2kBCc35PJC
	pbYPvN5QIE/p6qkUtlhrodNc3sZfN2bFR398FsqfyyyF/iabomUKTD3S7E8hWo1P
	rGl1kXlPUpScpm9nfTNLckoSM1LTQoY6k//RQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736967347; x=
	1737053747; bh=0KmddYUgBmXzMsS1DZ/nke+p3KeI0BTDkC6DScpFCLE=; b=d
	3L7E7O8RHsOPG5DLx9znUJ4f0I9rq+WFBFPvqpBsnzgcNFr4L5AgqrVOYQ3eHTwT
	w7eywao/WCnHkW1wVc+c4Oq8m43llPxNylYJO/FbvKBASBN5sYYLddxIKNaitnZj
	8+yXP79GkSPPj6yjvSrOf4LZjtFKE7+FSXGgIKlUT4661atx1SMpw8Efz6x8Jd+b
	llEshd0I4KcnDSRQSWM4sy32tbCLeiGRbMyjrYjB3iHGyigRu3I6Jt+HxHaEXXEy
	pTlAQVzHzOVX2gMVQ34mbVMOfbcoU4R8F7P1EjZyIE+buBIrXU1B/xvNbLfdnp3F
	FXajwXM9jl1W+ycxM1ygw==
X-ME-Sender: <xms:sgSIZ_4oG0gPfMyqOtOfZE2U1lWLzX4v8dxIJrknDCe4TXPBwV2hcw>
    <xme:sgSIZ07EgnCT6bniqPcHPhwvV_CNhH9wsRdXFtWfrYIBPVAsd0IvvcaUjWxXJZx_o
    wVDeiE39Eq0uzONmSA>
X-ME-Received: <xmr:sgSIZ2cBVPd8tdccYTJ4g3ertYp1_VWBYkqRIW1nKU6wEg-ZSNDTHf7mUlbXs1In8lXlVtSxfJ8PnCvenI7XbVm7PTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepjeeukeethedtfeekhfdvue
    fgkedvvdelheefueduudduleeugffgudfgkedvleffnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrrghnrd
    hjrdguvghmvgihvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sgSIZwKP3qmAt-YnZHLdIPOmDvSTuP5xkixPw1X4klcArS6zwL2mZA>
    <xmx:swSIZzJ0WhboOMe7CdpNc4hb6fwZSCZbkMFj5CgPe4krmJkTayLlKQ>
    <xmx:swSIZ5wB58PNfRlkKUuT2PJ4dexmEWdHEmbK7o259pLx3RqQgdTGfA>
    <xmx:swSIZ_JoOyuG0zx8F5lPwOnunTDy7R3FnxzCH2TppWyI1E_ACfFQWw>
    <xmx:swSIZ6UV2aURmxz9Dn0WueX5qqS-ATSwoA69HqgYrSsGkfC3czvtmPGX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 13:55:46 -0500 (EST)
Date: Wed, 15 Jan 2025 10:56:08 -0800
From: Boris Burkov <boris@bur.io>
To: linux-fsdevel@vger.kernel.org
Cc: daan.j.demeyer@gmail.com
Subject: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250115185608.GA2223535@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

If we run the following C code:

unshare(CLONE_NEWNS);
int fd = open("/dev/loop0", O_RDONLY)
unshare(CLONE_NEWNS);

Then after the second unshare, the mount hierarchy created by the first
unshare is fully dereferenced and gets torn down, leaving the file
pointed to by fd with a broken dentry.

Specifically, subsequent calls to d_path on its path resolve to
"/loop0". I was able to confirm this with drgn, and it has caused an
unexpected failure in mkosi/systemd-repart attempting to mount a btrfs
filesystem through such an fd, since btrfs uses d_path to resolve the
source device file path fully.

I confirmed that this is definitely due to the first unshare mount
namespace going away by:
1. printks/bpftrace the copy_root path in the kernel
2. rewriting my test program to fork after the first unshare to keep
that namespace referenced. In this case, the fd is not broken after the
second unshare.


My question is:
Is this expected behavior with respect to mount reference counts and
namespace teardown?

If I mount a filesystem and have a running program with an open file
descriptor in that filesystem, I would expect unmounting that filesystem
to fail with EBUSY, so it stands to reason that the automatic unmount
that happens from tearing down the mount namespace of the first unshare
should respect similar semantics and either return EBUSY or at least
have the lazy umount behavior and not wreck the still referenced mount
objects.

If this behavior seems like a bug to people better versed in the
expected behavior of namespaces, I would be happy to work on a fix.

Thanks,
Boris

