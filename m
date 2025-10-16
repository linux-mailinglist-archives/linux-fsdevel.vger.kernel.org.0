Return-Path: <linux-fsdevel+bounces-64381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFCBE4345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCEA3508A4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518B343D86;
	Thu, 16 Oct 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="g7vdsqko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666850276;
	Thu, 16 Oct 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628168; cv=none; b=M6jF3cA1EJkn3076qA5JCN9KwsoUF0TRbACES1cAgwaglgRyC4L/IUqWrqGC5Y4i8BfaLheQyjes26xLtvqB9PQTd03bSUbH/ycxMAUQdOrm3YrDzitb6XGmPk3hY/es8n1I+zsK8XgVAglRuaFwZTEPgL27bNZZBht8zi0y/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628168; c=relaxed/simple;
	bh=iE+5oLR5+fHIc0aaDtyQ1X84qdWIqbh6Kn79N0lB3Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHs80fF0E04f9lYv+kUXf7cnRfgj0372hLiMG2HspRoXc/Err/qu24qIS2Guy+l1UoHxc/JW9oeETs5DNP6xaASFhLQUkhf1h5Vxs3VjgFWG5/spOSDvAoIKZceagbezwGtRTq3dnU0d1+ADzkZsWRbtt4pEZYoYjnLz89g92nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=g7vdsqko; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTP id C6C6F40762D8;
	Thu, 16 Oct 2025 15:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C6C6F40762D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760628156;
	bh=k31hMYi4EBGG84ORPgHjW2xsh6Q8pv4v6szMsNIRaTw=;
	h=From:To:Cc:Subject:Date:From;
	b=g7vdsqkoid2/acl9B9uHWglYRd8M1tcYHzROY4fCBXcoWONYODrxOu68UiHg6irVA
	 4HOaYiw+XMZ8wzZl2g4F0lFbD2uZqWnPeeWoD7Di+Q59mEpZdtIU/9dapF63b7FFhl
	 CUc484FY4fVwcLj/pbgcdoVzUoDtfl9ka8Gz3FzE=
From: Alexander Monakov <amonakov@ispras.ru>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] man/man2/flock.2: Mention non-atomicity w.r.t close
Date: Thu, 16 Oct 2025 18:22:36 +0300
Message-ID: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ideally one should be able to use flock to synchronize with another
process (or thread) closing that file, for instance before attempting
to execve it (as execve of a file open for writing fails with ETXTBSY).

Unfortunately, on Linux it is not reliable, because in the process of
closing a file its locks are dropped before the refcounts of the file
(as well as its underlying filesystem) are decremented, creating a race
window where execve of the just-unlocked file sees it as if still open.

Linux developers have indicated that it is not easy to fix, and the
appropriate course of action for now is to document this limitation.

Link: <https://lore.kernel.org/linux-fsdevel/68c99812-e933-ce93-17c0-3fe3ab01afb8@ispras.ru/>

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 man/man2/flock.2 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man/man2/flock.2 b/man/man2/flock.2
index b424b3267..793eaa3bd 100644
--- a/man/man2/flock.2
+++ b/man/man2/flock.2
@@ -245,6 +245,21 @@ .SH NOTES
 and occurs on many other implementations.)
 .\" Kernel 2.5.21 changed things a little: during lock conversion
 .\" it is now the highest priority process that will get the lock -- mtk
+.P
+Release of a lock when a file descriptor is closed
+is not sequenced after all observable effects of
+.BR close (2).
+For example, if one process writes a file while holding an exclusive lock,
+then closes that file, and another process blocks placing a shared lock
+on that file to wait until it is closed, it may observe that subsequent
+.BR execve (2)
+of that file fails with
+.BR ETXTBSY ,
+and
+.BR umount (2)
+of its underlying filesystem fails with
+.BR EBUSY ,
+as if the file is still open in the first process.
 .SH SEE ALSO
 .BR flock (1),
 .BR close (2),

Range-diff against v0:
-:  --------- > 1:  181d56186 man/man2/flock.2: Mention non-atomicity w.r.t close
-- 
2.49.1


