Return-Path: <linux-fsdevel+bounces-50317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C90ACADB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A843BCE01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB6212B2F;
	Mon,  2 Jun 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSxxIKlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713761FF2;
	Mon,  2 Jun 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865546; cv=none; b=UeKi/kY9VCEEi8UCDvEOyG39we5XlTkj67dP5sL4RxKnDIEZIwA1Ov10gcw4VFx18dmRQQ4lPemwDW0K4WrCS870+Q8ppCLN0Pv2qeb8KvEZYg9SUbBD7LgAK37qtkJDJ7nGUWqMhvhCYbT5O6M/3/qj3h/KzNZFzI+sbJOvW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865546; c=relaxed/simple;
	bh=TpDI5XOR5I/6jWjot3yczsMhrhON4AHkW0EPogUAsjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nz4G9PFc0qMKX4qFKiQ9XnRe1QPEgpUoxUzM6xCPBcgDV1tOpIwYxRvetToAFQfJ3608PxM0MAQA3kaILn1tgHH0ADc5RhxGxE+L44MYUiwXVpuD/JQSd9COThL48dAlTiFy/uDNOdeF7leWOcL1290pIFzyuAkEjXq+Jqya2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSxxIKlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A96EC4CEEB;
	Mon,  2 Jun 2025 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748865546;
	bh=TpDI5XOR5I/6jWjot3yczsMhrhON4AHkW0EPogUAsjg=;
	h=From:Date:Subject:To:Cc:From;
	b=YSxxIKlj+5Y+cnnKrr8LC4Tvt9iJEghTaJgDH6ZmrWgdOMrJGe5Ab5arazer7OGwc
	 sPAZ48FML3fg5Zvp0EwgQc2p/Fv1XCT1fRwvebS8/bHE/f0TfrkT2xEKF1yn/SLosd
	 bqXTdwnFW4IKWd4bqsWk+wvaVvnO7mF3NMTA9EIU8+OqN0EW2x0G+xoMcYiqbRVO3u
	 cCeue9rE0xNPPnd5rt34fs1oFdS7ET6roSjOFRwvK0U6oFMb7GkW0M4nDcsuR+Y4+4
	 UC+Qy49PxIOneUVOZuQvyKCzIs21Yx/m8P/z6ZSESa4CTA6QrOyb5wOZrMbH4V4hUs
	 CdVP3J/SPqkdg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 07:58:54 -0400
Subject: [PATCH] filelock: add new locks_wake_up_waiter() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-filelock-6-16-v1-1-7da5b2c930fd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP2RPWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwMj3bTMnNSc/ORsXTNdQzPdJHOLpNRE87Rky+REJaCegqLUtMwKsHn
 RsbW1AMV5xQRfAAAA
X-Change-ID: 20250602-filelock-6-16-b78bea7fc9ca
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TpDI5XOR5I/6jWjot3yczsMhrhON4AHkW0EPogUAsjg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPZIFKEJXSEftAYSB1rvIJwH4Po8283QihNbBj
 pdnqN6ktdCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2SBQAKCRAADmhBGVaC
 FQZzEADIHwomCo1kIIyzUoKhGgbx9idDqTpTd6opqyZJoBAmG6Cy5gLO5szgBAxSOU0mtzfcEgq
 d2iybUmCj0tk9O3LF/HcaxJMdWkhWHbAlWcbnnLhYjZIJ2dpJ5DrPJ5cP11QD7YeSz2VXKIazdT
 ScE0KJ9AgvpvKlxhbdu7cnv/pm1D4YX7+2hNtzgt2zfCCCwHtzw/Bpd0y8BCOrjUqPRXxueMMrU
 HHgwiNMn8N6mLfrljDWIJqaQzvd9oliXNO10msm+1EtESOhSbKnx4fJgQ6o+9387esUDnF9exBX
 etrjPeGk5jT2jh36d7lcKFLi28l1vLpolDX94AQq8mXcS0kEznvcj3+PcBwcDLyskjCuIHK9Bou
 j+lYkG3UQJg2OJ0KqFTOnV8Dd7+hJPEcA3XJ5GH1SydbqboqhlLevOdUzsnTXUJLSfg4dLfIWIr
 BDZ5my6SiBb+p0NUsSCMAftLPQ7m7IIauZ4hLXh7ovJC4brujASDzGh9VoUaTqi6low0m5YU9t2
 Fkxjj5/fLSs+za2pB2DJGW4CaLObVzyDH6Fnf6OnPnkWI9TYhzWa2zeyp72GQuji2n+9QCvft+x
 DHjp1DkgoiQLoyefNSi45LCTuQs7O4kaurzcdvk1HjJ8KPQwo75g79/6UjcSV/f7G9T6HyfJIeC
 jwTqauRRTbehLXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently the function that does this takes a struct file_lock, but
__locks_wake_up_blocks() deals with both locks and leases. Currently
this works because both file_lock and file_lease have the file_lock_core
at the beginning of the struct, but it's fragile to rely on that.

Add a new locks_wake_up_waiter() function and call that from
__locks_wake_up_blocks().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Christian, would you mind picking this up?
---
 fs/locks.c               | 2 +-
 include/linux/filelock.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1619cddfa7a4d799f0f84f0bc8f28458d8d280db..f96024feab176537b79be41e505e60ef92fb7d68 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -712,7 +712,7 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 		    fl->fl_lmops && fl->fl_lmops->lm_notify)
 			fl->fl_lmops->lm_notify(fl);
 		else
-			locks_wake_up(fl);
+			locks_wake_up_waiter(waiter);
 
 		/*
 		 * The setting of flc_blocker to NULL marks the "done"
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c412ded9171ed781ebe9e8d2e0426dcd10793292..c2ce8ba05d068b451ecf8f513b7e532819a29944 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -175,9 +175,14 @@ static inline bool lock_is_write(struct file_lock *fl)
 	return fl->c.flc_type == F_WRLCK;
 }
 
+static inline void locks_wake_up_waiter(struct file_lock_core *flc)
+{
+	wake_up(&flc->flc_wait);
+}
+
 static inline void locks_wake_up(struct file_lock *fl)
 {
-	wake_up(&fl->c.flc_wait);
+	locks_wake_up_waiter(&fl->c);
 }
 
 static inline bool locks_can_async_lock(const struct file_operations *fops)

---
base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224
change-id: 20250602-filelock-6-16-b78bea7fc9ca

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


