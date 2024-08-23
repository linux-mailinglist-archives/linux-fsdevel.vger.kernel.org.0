Return-Path: <linux-fsdevel+bounces-26902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D617E95CCC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C4F1C220CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B6185B46;
	Fri, 23 Aug 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCXbhJ+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE461849CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417274; cv=none; b=RHoZk9IqgaZ4zehhYbnz0H0nEQTviObSoecDCY6IoVwEyFEGSajIQoSYIX/uXdCCRH2roczIkSaJoiju7WHbb+egr3kVKNXNMszn19a8gTb9+KqaTlMEjFI6BrctaV2n+IgZdmEZrjjGYmQVhCuXfpM7njseiUDu5RZc1hc1EGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417274; c=relaxed/simple;
	bh=ffkoH8PrwxsCRV6T4V0MWbirbOdJ5/cCq3pt0LPGsns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ4jtApRt8U1OSGTgj6xe8jywdBDHPLo7FIDKnwNFe44mTeS+cwSKaW1dSCetOMev9zDDXjJS2j/zlM3eD3ePYJal3BwK3AtIuCv9pKTzBs9LAkuWgBI6dWAsbht3XLTQRkfdwAWFxm0JmrYdsAtGu+SScyGsK0/AMWQiw0Yne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCXbhJ+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E793C32786;
	Fri, 23 Aug 2024 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417273;
	bh=ffkoH8PrwxsCRV6T4V0MWbirbOdJ5/cCq3pt0LPGsns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCXbhJ+DrLX73xftC3W9PpmbGrf7R1Fw/C/zLVpODsyp4oi4HePKcKBIiX9CKp2Dh
	 8jFAHSiS0L0BKtQEy/OjOJPxuJRFt3D2sxnAHiBFAKiCNuOf/R76B3UWvEfvCXKpj0
	 T+gvJWTuwRkCbmOT+OQshpz1OY+p3a5hrQf/z915Ke65Ba8PF9iJpThDUIAU0vOehb
	 m3XGLg0/JnekBczHfruptK7dR98PplEpWHAOZCKNOgJHp8f7ibmvQ3/iJHDhwPW8Gd
	 kvxqKng1I7zKm5nzwz8P9zhxGFjn6HIxEp9ZC6enBABnqMrNxhJY8XdnqocEvIJ9k4
	 SuhXFO8xQxayw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/6] inode: turn i_state into u32
Date: Fri, 23 Aug 2024 14:47:34 +0200
Message-ID: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
References:  <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=brauner@kernel.org; h=from:subject:message-id; bh=ffkoH8PrwxsCRV6T4V0MWbirbOdJ5/cCq3pt0LPGsns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHl95fUusxWMNxfJC23YaBazeP6GnqCJjtn/dp7Kc WsOatjC01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRf3cY/mlleosqytS0fWbt MX2zrie/f02qS9Auv1VnK87uC3he3c7IcJmDnfPDztB3pt9eW+3de1Ph0GLP0ndrGjy+zxZMmxr BxwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

This is v3. I changed to manual barriers as requested and commented
them.

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
Changes in v3:
- Use manual barrier.
- Link to v2: https://lore.kernel.org/r/20240821-work-i_state-v2-0-67244769f102@kernel.org

Changes in v2:
- Actually send out the correct branch.
- Link to v1: https://lore.kernel.org/r/20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org

---



---
base-commit: 01e603fb789c75b3a0c63bddd42a42a710da7a52
change-id: 20240820-work-i_state-4e34db39bcf8


