Return-Path: <linux-fsdevel+bounces-26485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33695A207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59048B26EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5A1B2534;
	Wed, 21 Aug 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVJYTxVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F81B2515
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255272; cv=none; b=huTReXTj+dbqNO8xHk+OV9YNIqTo6uTcjUiX9JJ9WahP3KZeoSF/lvH1lHdM3Mk1I9No3ziRNqvWEOvqrc84uqw5w459dZMXhOHXvgg+SCQuKkz3Gvkf6tROZ7AXo/GJX1bwnA/JVa8mvIi/rFYdKb0lOyWLPJR0qTpWhJFMPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255272; c=relaxed/simple;
	bh=0oUreKNx0Pdw8S7qqAOwewKD13Uzadtr6SlTU6MvFI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MIqHrpt/4c4yVAABP2DJObtBSbxxpy61DcXqXNqOikm/guX+YbjR0qOb6C7WmTU2H4KiK2N8V6SenBrZtNgEJNOuyWed/nSKUWQiLAq/RHwBJPQ2ZC6Af8LO+OptK4qUTCaDtfmq2FV2XfwdHWThOh4A4S84e8aFcEeORVY+74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVJYTxVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD1BC32781;
	Wed, 21 Aug 2024 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255271;
	bh=0oUreKNx0Pdw8S7qqAOwewKD13Uzadtr6SlTU6MvFI4=;
	h=From:Subject:Date:To:Cc:From;
	b=DVJYTxVfT1nwNHxO1acFTgZxT5iRhDRAhO1zInnAQnyIASz5FRrEvAQ3FQmWOsX6a
	 g20WlWck3QebOtiqPKhZLmzHEzkTJN7zcibFy8s1a3fFNNIiWk42nyEL6DNA6+Abhg
	 0pQ6PZq2OKlVUVJmd/o6G0/QWcQALcTmjIE+FR6eqifMdCv8HVuiWTk7+hVE2952A7
	 wtdOLCyQmZSkkwfsymaEjhaNXu0+CXCK3+01n99tUGjZkQGRf0xk7FNPOtuwNmgyz8
	 TNzF1/Ge3WmOzfwxoVyba8U6VivOjbB2u5bR33o8ex1YCtzD5Kvzd3BqrQ1ILFhqwV
	 vIK7yTLEpDoaw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/6] inode: turn i_state into u32
Date: Wed, 21 Aug 2024 17:47:30 +0200
Message-Id: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMMxmYC/22NQQ6CMBREr2L+2pJSGgFXJiYewK0hpi0f+EFb0
 5KqIdzdwtrlm8y8mSGgJwxw3M3gMVIgZxOI/Q7MoGyPjNrEILiQvBKcvZ0fGd3DpCZkEgvZ6qL
 WpqsgTV4eO/psuhtcL2doUqhVQKa9smZYTbEL2ZOCWfsDhcn57/Ye8231/yjmjLOylsWBl7msR
 H0a0Vt8ZM730CzL8gM7AdnJyQAAAA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0oUreKNx0Pdw8S7qqAOwewKD13Uzadtr6SlTU6MvFI4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41F5f9V10TvdqvQ3wlGOS+1vXfmj5l8hfMu+dxmTT
 Gbqgx+zOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZybh7DH+7lU3mdfnhNDzgd
 aCpdmftI61fjQy0jr6P/5H41lzfkyTMyLGJIfv6f59fjoMDrx5sU///87Xv34Or5ZUenHHe2e6o
 swgoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

So first time I managed to send out my personal wip branch.
So for the record: The intention is to send what's in work.i_state on
vfs/vfs.git.

---
I've recently looked for some free space in struct inode again because
of some exec kerfuffle we recently had and while my idea didn't turn
into anything I noticed that we often waste bytes when using wait bit
operations. So I set out to switch that to another mechanism that would
allow us to free up bytes. So this is an attempt to turn i_state from
an unsigned long into an u32 using the individual bytes of i_state as
addresses for the wait var event mechanism (Thanks to Linus for that idea.).

This survives LTP, xfstests on various filesystems, and will-it-scale.

To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>

---
Changes in v2:
- Actually send out the correct branch.
- Link to v1: https://lore.kernel.org/r/20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org

---



---
base-commit: 01e603fb789c75b3a0c63bddd42a42a710da7a52
change-id: 20240820-work-i_state-4e34db39bcf8


