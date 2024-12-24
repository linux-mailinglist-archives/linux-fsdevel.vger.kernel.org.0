Return-Path: <linux-fsdevel+bounces-38086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8F9FB83C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 02:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA77164946
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81620322;
	Tue, 24 Dec 2024 01:20:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2418D;
	Tue, 24 Dec 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735003222; cv=none; b=Aia5n7LIJwQ49a3vShlRv5DnNckhhYffXqm+r/Vu0ae11fpy+Frd4o/jXdzjJQWatKBKM5VRRvSqvsJE4HVJIh3poVgVZcKfQrVAQh7ub6kuUHT3YLIHINXjgb/Qpn0ZnBeOe9vcXX/eEIssM31diYuzvQxr1mSPHGffT9WHl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735003222; c=relaxed/simple;
	bh=ZMH7vtWdAf6kYlZiBNdl2l15bBxAq14Y71aH/mjaxjc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TasgoI7UJgxLyeoA+zdeGYjkAyhqA/TBNUJZXqX0Cf6pFdhRcQH/p1BRNyQx+wBsHwdgNwosC9iMRgErUAb9AWzWabVpFzi/BPZSFwuni13EllkegMNFHoOMoB8aHoc7Icoke9KtNgBkzSsgGzlUhzhyc7a9dSSsLvrTMw9wT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YHH896TfVz21p6L;
	Tue, 24 Dec 2024 09:18:17 +0800 (CST)
Received: from kwepemf100011.china.huawei.com (unknown [7.202.181.225])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BDC51A0188;
	Tue, 24 Dec 2024 09:20:16 +0800 (CST)
Received: from kwepemd100026.china.huawei.com (7.221.188.98) by
 kwepemf100011.china.huawei.com (7.202.181.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Dec 2024 09:20:16 +0800
Received: from kwepemd100026.china.huawei.com ([7.221.188.98]) by
 kwepemd100026.china.huawei.com ([7.221.188.98]) with mapi id 15.02.1544.011;
 Tue, 24 Dec 2024 09:20:15 +0800
From: Nixiaoming <nixiaoming@huawei.com>
To: "arnd@arndb.de" <arnd@arndb.de>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "weiyongjun (A)"
	<weiyongjun1@huawei.com>, "Liuyang (Young,C)" <young.liuyang@huawei.com>
Subject: [RFC] RLIMIT_NOFILE: the maximum number of open files or the maximum
 fd index?
Thread-Topic: [RFC] RLIMIT_NOFILE: the maximum number of open files or the
 maximum fd index?
Thread-Index: AdtVoev4zwP9BO3zRfO8OhNn2n+8UA==
Date: Tue, 24 Dec 2024 01:20:15 +0000
Message-ID: <4731d54723b841599882a24f7aa73aaa@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I always thought that RLIMIT_NOFILE limits the number of open files, but wh=
en I
 read the code for alloc_fd(), I found that RLIMIT_NOFILE is the largest fd=
 index?
Is this a mistake in my understanding, or is it a code implementation error=
?

-----

alloc_fd code:

diff --git a/fs/file.c b/fs/file.c
index fb1011c..e47ddac 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -561,6 +561,7 @@ static int alloc_fd(unsigned start, unsigned end, unsig=
ned flags)
 	 */
 	error =3D -EMFILE;
 	if (unlikely(fd >=3D end))
+		// There may be unclosed fd between [end, max]. the number of open files=
 can be greater than RLIMIT_NOFILE.
 		goto out;
=20
	if (unlikely(fd >=3D fdt->max_fds)) {

-----

Test Procedure
1. ulimit -n 1024.
2. Create 1000 FDs.
3. ulimit -n 100.
4. Close all FDs less than 100 and continue to hold FDs greater than 100.
5. Open() and check whether the FD is successfully created,

If RLIMIT_NOFILE is the upper limit of the number of opened files, step 5 s=
hould fail, but step 5 returns success.

-----

test code:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/resource.h>
#include <errno.h>

int main(int argc, char *argv[])
{
	int fd, i;
	struct rlimit rl;
	rl.rlim_cur =3D 1024;
	rl.rlim_max =3D 1024;

	if (setrlimit(RLIMIT_NOFILE, &rl) =3D=3D -1) {
		perror("setrlimit");
		exit(EXIT_FAILURE);
	}

	for (i =3D 0; i < 1000; i++) {
		fd =3D open("/dev/null", O_RDWR | O_CLOEXEC);
		if (fd =3D=3D -1) {
			perror("open");
			exit(EXIT_FAILURE);
		}
	}

	rl.rlim_cur =3D 100;
	rl.rlim_max =3D 100;
	if (setrlimit(RLIMIT_NOFILE, &rl) =3D=3D -1) {
		perror("setrlimit");
		exit(EXIT_FAILURE);
	}

	for (i =3D 3; i < 100; i++) {
		close(i);
	}

	fd =3D open("/dev/null", O_RDWR | O_CLOEXEC);
	if (fd =3D=3D -1) {
		if (errno =3D=3D EMFILE) {
			printf("ok\n");
			return 0;
		} else {
			perror("open");
			exit(EXIT_FAILURE);
		}
	} else {
		printf("fail: {OPEN_MAX} file descriptors are currently open in the calli=
ng process, but open() still returns a success\n");
		return -1;
	}

	return 0;
}

----

Best regards,

Xiaoming Ni




