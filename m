Return-Path: <linux-fsdevel+bounces-61266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B20B56E34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD8D189B9C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABB1F37D3;
	Mon, 15 Sep 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Cy32pKXS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TUaghd5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279D1DC988
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902567; cv=none; b=WlvukwQeutxJwmgn2Nu4qtOQZ03mGpirpIYfB2XyJspNRkOl6DLUreoKxwSjHUj5WBcWzVJ0+pscdMYIIoijSDMHsT62PUdKl36epqqnJ5HXr33uTjy6tbLxkEnBzPCGvelWUn8Axv9mmdGgl/tYuzOfUlf8P/qIiQJYTm7ISuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902567; c=relaxed/simple;
	bh=zQagBSRnpsL+JS15yEVzORCFV04MdIAbg+m84+NAlEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKgyMirW1p0p6qoqzk5WZSUVlbDY4KEJyWvJiQZiYQyyUsUoNTGd5Oa/w2YCz5oJVgupjIR46JHTsyGRP2JLUVeSg5+qGCQDY2QgzHEK+J6hZG+9BOrdY7akfb9IXzKCI3dAIRuYSSZ8tgKHNux9vSjdo8crJs9WIsxocHQmjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Cy32pKXS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TUaghd5g; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2472D7A00CB;
	Sun, 14 Sep 2025 22:16:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 22:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1757902559; x=1757988959; bh=zQagBSRnps
	L+JS15yEVzORCFV04MdIAbg+m84+NAlEY=; b=Cy32pKXSIpHcWQ3SJXHC3yGj5J
	dRMACjDf77JQIW70nquWIaQnasc2FlLIsOCbrCLXdRnWdknr9thvFffs+2j9P2NK
	ZGflM9eCvDWnN/HDrcjBkuEaetNij1kfpE0Dje2YEBHaWKuGhWA3apzKWFKh61g+
	dNGgUO48eJw9eKQz1JIbAhxdf6HF3hR/L8G4Oi1niG4sF8VeWNrkwdwIFoigO97g
	b9ZbMm6dqYxdiQCkYHmM4l29vu5Ldk8ytas8emIDazIpte1eO381lx+KeKy6TB9c
	re/nwPcPNowuRMHATWPgRcdKSKhddcZH3CGZOORp3b+ZWt2U6fmUQur/FMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757902559; x=1757988959; bh=zQagBSRnpsL+JS15yEVzORCFV04M
	dIAbg+m84+NAlEY=; b=TUaghd5g3cT/wEp2LjTN8WPQG+XJDX/yqAK5HiX0gJhK
	9OH8qAeSzK2gNvf/i9orrlDtHy8/6pi9GPpAvZliYUXXxqFSg3ETd+NtNfunfj86
	MBBkVAiTnpeC8rxFdSb5Mdy//X/K/lXofpcH2Ey7+38MgQcwtEhb9AbsKG+/tjWu
	Y7rDaTi71siI/cspq6eeb0d1okYOFJriQkqXVgmJ9ArDLymdHleiwFK/B0g5H/ZJ
	utkK2j/LUuOkR+GPhWOJVrXfZzSzRw4UcgJkbYYKl4h16HC3JyA7JmRIZTUfATqK
	lVmOqMcg5XYscBJs+wqwANvSUcocSPm0TNdD+kJQoQ==
X-ME-Sender: <xms:33bHaENn6klJPyQNRNxBE9wtflQM0x5YaDuNTMD8L95geZqjJ1bWwQ>
    <xme:33bHaCWgYGvmdo0B51nLuLcUrYH9xf-rj4tEulddDKaMq4Zo6eSw0XtcrCxutPX4a
    bD4ci-84DHiHw>
X-ME-Received: <xmr:33bHaA1y7z7MBJROLu1ihGOjUUAIX2xff05M3aeGSGYk1Hli1rV3-uPfBRl1fwFZ3kOaskHfUPoRkkmyFNRpvh0rissfQPUB61Se-iQEKx7t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegte
    efgedttddviefggeeuveefleellefgjeeufeeukedtleeiieekvedtleevleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:33bHaIoZq0GYsFrlzXD3J2q7NS9WjzKbNiVWmzhO8U5knNPbahRuNg>
    <xmx:33bHaPVJs3Tw58jMdfY12GW42A6lEtoNLQL5QlDUL3-EnfGpECU3jg>
    <xmx:33bHaLZvWbDRk552UDJmUxIztoC7oPwSgEEpNCRSMt7I9eDqluithQ>
    <xmx:33bHaEd0h5K7ta_ljP6xi9_c744XKr_BF19e0MPmlK8bf6JOjcIXLQ>
    <xmx:33bHaEHXnjAwPE6aqperbfLE6ATlGq4ie67FblgBxsrmlbVaQOgqkMKc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:15:57 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/6] VFS: more prep for change to directory locking
Date: Mon, 15 Sep 2025 12:13:40 +1000
Message-ID: <20250915021504.2632889-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a re-revised selection of cleanups and API renaming which continues
my work to centralise locking of create/remove/rename operations.

I've dropped the simple_end_creating etc changes which conflict with some of Al's work,
I've added a note to the first patch explaining that the linked list
does not need locking, and I've added a patch to rename start_creating() in debugfs
so the name can be used elsewhere in later patches.

Thanks,
NeilBrown

 [PATCH v3 1/6] VFS/ovl: add lookup_one_positive_killable()
 [PATCH v3 2/6] VFS: discard err2 in filename_create()
 [PATCH v3 3/6] VFS: unify old_mnt_idmap and new_mnt_idmap in
 [PATCH v3 4/6] VFS/audit: introduce kern_path_parent() for audit
 [PATCH v3 5/6] VFS: rename kern_path_locked() and related functions.
 [PATCH v3 6/6] debugfs: rename start_creating() to debugfs_start_creating()

