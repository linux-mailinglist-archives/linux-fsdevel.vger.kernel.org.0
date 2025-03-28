Return-Path: <linux-fsdevel+bounces-45223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39193A74E5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C3D189574E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A21DA0E0;
	Fri, 28 Mar 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keJjcRBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D11C2F2;
	Fri, 28 Mar 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178577; cv=none; b=Kx+F10m8eA9xPviNzr8H3hW4EGeYZjdsSUekAfwxQB+x3FJbOT+LaJQ4OFSQEqiElkLkCAI8tdVO+grJ8Yb9Z1BfLRdon8NCA/uuK50cYKvUgpRuPbp4ZsxeBpnbEeaRpn3z9B2z/eRTlCWa2cPP+MsPFMyFp5WIRK+5HZaDPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178577; c=relaxed/simple;
	bh=+afcA8O5+SrsVmIP4B3BzcgE1Zn6qTmmr4Wfy5vOLVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFvlgPWlD/Tr8aOKOuFmyZVCQAXBLCiUEEe5IrWhy7jmV6TFfz4Oa/hDrJoybz7IZ37dNiMHRX2NkNIJ9Zy987OMqIF7L2cFcLRjkQqTnkttNLgkuTyLyhGjrwfx/1sLeY2tqNAfP3f8IRLl9ZKKT2mUbADJ/3pSeh90bM2/61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keJjcRBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFE9C4CEE4;
	Fri, 28 Mar 2025 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743178574;
	bh=+afcA8O5+SrsVmIP4B3BzcgE1Zn6qTmmr4Wfy5vOLVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=keJjcRBevGQI1MvhY8oD8l3uQ+W/pxHTFVtv7q8r6SEAVl51onpRmWpqJRH84kW7K
	 FLWtg9i9M1gJx/AwFKTByrosq1m4gRUzNc8dE+HbPJfvEvDFctID0p7tF6Ym3QGzy9
	 cmHvXqEBxyLYeCsupHfLYK8wMP7GWwrsOtCbDLEQNAHo2oOdZGyYincnkJGyQ0MJYP
	 +m8v/auZlgA96BK5wCuQgUy7ZynH6vhREhHOM/M6kVP1eP5KeHtwATvQeh7Pf+JA0H
	 9ni8w4WM8kwA2qY8fyGTb7itMBUUOF7RXtaA84/vuYqy481gulm+N0qE8NFRjAA/V0
	 SARlPsATwhxuw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 0/6] Extend freeze support to suspend and hibernate
Date: Fri, 28 Mar 2025 17:15:52 +0100
Message-ID: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250328-estrich-kaleidoskop-c677a5a3f551@brauner>
References: <20250328-estrich-kaleidoskop-c677a5a3f551@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250328-work-freeze-0a446869cd62
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=brauner@kernel.org; h=from:subject:message-id; bh=+afcA8O5+SrsVmIP4B3BzcgE1Zn6qTmmr4Wfy5vOLVc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/O+14Kj2MX3npYc+vol/dmULVHVe0l3Z2cdc+/1t4J t2lhIuvo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKm0xj+1+i4r1OoLGM4+tRg 3UZ5jpOcAr2LZs+66bJ/2ifVGH6BUkaGZ5Wlr3Z0hdRXTfVTW9p80StiRc2dKz9v5x6MXnnMuX4 2DwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add the necessary infrastructure changes to support freezing for suspend
and hibernate.

Just got back from LSFMM so jetlag-increased possibility of bugs. This
should all that's needed to wire up power (minus the prep patches).

---
Christian Brauner (6):
      super: remove pointless s_root checks
      super: simplify user_get_super()
      super: skip dying superblocks early
      super: use a common iterator (Part 1)
      super: use common iterator (Part 2)
      super: add filesystem freezing helpers for suspend and hibernate

 fs/super.c         | 199 ++++++++++++++++++++++++++++++++---------------------
 include/linux/fs.h |   4 +-
 2 files changed, 125 insertions(+), 78 deletions(-)
---
base-commit: acb4f33713b9f6cadb6143f211714c343465411c
change-id: 20250328-work-freeze-0a446869cd62


