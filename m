Return-Path: <linux-fsdevel+bounces-52310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFCAE1987
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F75A7608
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9728A1F6;
	Fri, 20 Jun 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1UYH/jTm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4ReoX7H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4521283FEE;
	Fri, 20 Jun 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417385; cv=none; b=anVLUP/yThPWaJJq+1/hffJt/x1w9XIKfLShfQjlyljfzV0qdSowFpKdvWFpbvXcPFun4XxZ0hIryu1Miwfli1B7cLI6X4sqUYBYmyt2VvVT5vPEXWeaeJ73fm87T4QsYsn3DTcbU/m3xKgtys7joB04JljK15B92Kd9WM1aYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417385; c=relaxed/simple;
	bh=VyKy7ZblJIux9A8nr4UKOBkLEzekMiA4P1J54fnWw9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6zIATmspK97F5GwzCAInHx1yodyjZKAHdY3c5ZaUaeTLXukRDT7hPBB4uI6YgZIqy86M0X9ykEEC1RKr9DkIDxXnqpxNnDeMn7XGNU6fXnL0SzqPwxivmwnlolcDxm+Hwi70mLGnEGGZrArDmiOjMxBbJHe7VLwRQXKu3lgbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1UYH/jTm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4ReoX7H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750417379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oGBO/Bsd9Ek7GSchB/P0tD6LqkXEF7CldRyZjA/Vzn4=;
	b=1UYH/jTmoqNtisk0sd6H+kx4BMUL36RaQo3TE7OpOaUw0b5Na7GpkCvL2ZRMCBOKTvmGy9
	YZukfkqX1aUw05oJkVzmgo27Rq6CTXb7upgl81qsHiJ3Xd2kNGTPsJGTU3aJP+SnICrE0e
	A/LK6ZQaulEAv9qIhaF7MI7ZGvmvIItWtRwaTfbewMmGqzWF7phhDOZA75R2qFq2L1xbJ0
	Y99zE2Zv5/3w8PAqaTC1rEtk0Ej2tg4I3y+yL6krKXqxCCGWJnpUusoacDIkyQJ4nQ85T5
	vD3bD72YqPd/bV1Rb5rRDC/qnq8Etk18fUGY/H/JpWRtsEdoLRREClNoDBWGag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750417379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oGBO/Bsd9Ek7GSchB/P0tD6LqkXEF7CldRyZjA/Vzn4=;
	b=y4ReoX7HpOtcCFEmySKh4pv1Io1/H2aWd803okTb2PyIjrrl4hheYhuxdiRInoT8Q803gQ
	a8LinyR3edIM5UBA==
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] selftests/coredump: Fix "socket_detect_userspace_client" test failure
Date: Fri, 20 Jun 2025 13:02:52 +0200
Message-Id: <20250620110252.1640391-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The coredump.socket_detect_userspace_client test occasionally fails:
    #  RUN           coredump.socket_detect_userspace_client ...
    # stackdump_test.c:500:socket_detect_userspace_client:Expected 0 (0) !=
=3D WIFEXITED(status) (0)
    # socket_detect_userspace_client: Test terminated by assertion
    #          FAIL  coredump.socket_detect_userspace_client
    not ok 3 coredump.socket_detect_userspace_client

because there is no guarantee that client's write() happens before server's
close(). The client gets terminated SIGPIPE, and thus the test fails.

Add a read() to server to make sure server's close() doesn't happen before
client's write().

Fixes: 7b6724fe9a6b ("selftests/coredump: add tests for AF_UNIX coredumps")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/stackdump_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
index 9984413be9f06..68f8e479ac368 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -461,10 +461,15 @@ TEST_F(coredump, socket_detect_userspace_client)
 			_exit(EXIT_FAILURE);
 		}
=20
+		ret =3D read(fd_coredump, &c, 1);
+
 		close(fd_coredump);
 		close(fd_server);
 		close(fd_peer_pidfd);
 		close(fd_core_file);
+
+		if (ret < 1)
+			_exit(EXIT_FAILURE);
 		_exit(EXIT_SUCCESS);
 	}
 	self->pid_coredump_server =3D pid_coredump_server;
--=20
2.39.5


