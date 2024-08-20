Return-Path: <linux-fsdevel+bounces-26373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AED958BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4E6282ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BFD19E83F;
	Tue, 20 Aug 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMsljkim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E48195FE5
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170046; cv=none; b=UNBVNK19zvvFrSTNu8DRKF6UJL1VPedX8bDgWHAazAv7AXLyOconnoF5Mi2fN0WYDpsI/NTP3Nol50ShTgmjmQDSV/notVz7KtqJMXPoE1OVHrBzYpwJNbIgcAmtQLJYDL5dycGqfy+RBCNlQf0QXNGQEUJ4gINmOM+9YFy3BCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170046; c=relaxed/simple;
	bh=JzOgszMyRZu4ya/XA9J0pgOYhicdJbxVYhqllfjcWnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+tgg5B1yNZ+S/DZIl7Hgz+TTPSfUZLlFC1KldSO3qaucwqppRB1YrQokFkcIjJOOnygAddilqJDel8+Lz4W651KgmZRpdMJ5aV/PeJ8Y4EgioyQKpw1IYdfCi3ed71r4NL3Nl+R0k36peLQgjzHHxEoKSFSMf2gQEqzjekgqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMsljkim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7E4C4AF0E;
	Tue, 20 Aug 2024 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170043;
	bh=JzOgszMyRZu4ya/XA9J0pgOYhicdJbxVYhqllfjcWnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMsljkimux+aTBAkDasHsrT9UfP5FUyWErWpDU5+iaIL1zlydzVmpUryhK7pHaMRn
	 mb+eyccPLsvNzTpyku7SBugvRKZHC/Mk974ylnZ3RhYgQsxj96lY/jZqjYn5qbb7rf
	 koVYM0RqVNNQbRbe7ytob25Y2arCJKSjj4JnCCprM6oZzw9Fd3kH76gx/RQr2hBVrW
	 t4S+2TiXbILJtVEC7mjo4R/5eZjx9ulZmmYsXBMxVoZXN25KrDXZzMFzcj2i3lKeGJ
	 Gdp9w3x2Z4nQVkkPnGepR2EyIrxrANPAmgaXObhhKN1NFSIufDA9zt70HRx1110FkB
	 RwiauB3soAh5Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 0/5] inode: turn i_state into u32
Date: Tue, 20 Aug 2024 18:06:53 +0200
Message-ID: <20240820-work-i_state-v1-0-794360714829@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <CAHk-=wh4=w4pANpAPbx=Kw-jiExEabJ0pwYHFgAYXVaD0AJjrA@mail.gmail.com>
References:  <CAHk-=wh4=w4pANpAPbx=Kw-jiExEabJ0pwYHFgAYXVaD0AJjrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=721; i=brauner@kernel.org; h=from:subject:message-id; bh=JzOgszMyRZu4ya/XA9J0pgOYhicdJbxVYhqllfjcWnI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd2S9vezl2unNX8TODXoZK63l/2u2v/TwsXCt+ac77S 28bprfxd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk/zpGho0PzJceV5Kpb/nv 5LvWYmLI8sx/5t/5hCKktCzTbt++2s/I0BO7mlt9fccpNu9N5zW5vHlWhTuvX6EeVqXc/MH++B8 FBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

I've recently looked for some free space in struct inode again because
of some exec kerfuffle we recently had and while my idea didn't turn
into anything I noticed that we often waste bytes when using wait bit
operations. So I set out to switch that to another mechanism that would
allow us to free up bytes. So this is the attempt to turn i_state from
an unsigned long into an u32 using the address of the i_state bit in the
wait var event mechanism.

This survives LTP, xfstests on various filesystems, and will-it-scale.
It's possible I got it all wrong but I want to have the RFC out.

---
---
base-commit: 01e603fb789c75b3a0c63bddd42a42a710da7a52
change-id: 20240820-work-i_state-4e34db39bcf8


