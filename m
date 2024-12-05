Return-Path: <linux-fsdevel+bounces-36548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BF19E5A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 16:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA4E16A98B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900E18E362;
	Thu,  5 Dec 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmHD6kQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47F3A268;
	Thu,  5 Dec 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413675; cv=none; b=t/1o7nqvr77Bv4iQHha4kLK/1EmoBPbUUquzloYOGqluX8JGK2ois7PduZQVh1xI7zZqz/C+bPjdUzNEQFJP4VRRSShu5hvXuJG4EdmR3ngaFlDMCQwUFfqhkuczMWwD/Dtv3eNLN64WeNIp+V01cTpNsACVieg0NdncORXR3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413675; c=relaxed/simple;
	bh=I1x9yW5S/y62Mc4rTvJVhMN6bFDX247M8XyDnu4a0kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sN1pZG2YtPxabhshzZ+paxPDiBCGbNeFpztLZoZjVCaFUMGa3N2hdWlwcBPTbBNFdVY89nwz4QZ0Og/XqvKIx7Pgm17COHX2O8vnuSEyr+ozDyBTBhP7biHTyip2HTDupMRQPnF4ER4mlXtCut2Wna17JMwfZWpkQ5zJm51PJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmHD6kQI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0cfb9fecaso1628782a12.2;
        Thu, 05 Dec 2024 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413672; x=1734018472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eg6nDph4OWCpl24YCKXwc/7p8rG55c7/0CrIFRsw8w=;
        b=KmHD6kQI6loMLobDU6cO5tUnZvdNGNpc0Txju7y6CiyPTEUxrvkvCDMWsT1fKjTPGX
         QcrK9tuCtDyLqfA2BdGm1Z/YGrKVmMQwVaFGsWgGEzGx3QzOQHMTqUgKyTtBlha498s0
         gWLd0SHbHq6D0lZBmFS9opvjW+zrKeXTmZs9y6Ge1ChNsV65kKZkVI9IXMICdf+TXIcA
         ZRqvb1sKy0CJqZPk03vRdOqOGNlwhjZE/9YafWvr+PCTnI6GEtF3C5mKS6Ec1Cf9CFuA
         vtF/x5Bc9E7L75XNaLm0JbxICZC4mEYnPNJOijYI2NdpyoZIvP9mROXIUyTuIcCe2iKr
         Pshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413672; x=1734018472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eg6nDph4OWCpl24YCKXwc/7p8rG55c7/0CrIFRsw8w=;
        b=ocqEmy2+0+XMA9mfxa8TBlDEnTRq00jpVLhUtqVT4Z6AGBuV9EZUWV/O+S4EJhQSUn
         ubc3Pi99DeqAbonpE1Fsgsy3PiC8kThWPMIo9cO4XpVnCJ+ElFXuEGvE5p2NXr09cOaJ
         wtUuhQwrFxV33P6Q+4uAK6Gj7DrhPdst4F3cbTkafSB4Y4SWdbaUAEwd8Jw9KWH4GRVi
         JKSJU+43Y95DKJj38nXWml+b4YCcCCYutTrYyUpeMxbwUAAGWg+T/cbNuiZ5mnhDUw1p
         ifqfeeHE5LUAB5AWCzi2VKgJ42cbiJKjjn1lUHK8a5O7wCiVnc9Dcd+pp1niG96TTddw
         M4kg==
X-Forwarded-Encrypted: i=1; AJvYcCW9DyAAzH2RSvojYTIUq5I4aTzGoID0EWGb7I9J9ERYd2OV1eKyvR4lTDJqkhhtg2ZLPrKYpK/+sPmWA6nk@vger.kernel.org, AJvYcCWTPQqDJ/4s6svtBesfJBlVTl3ekmZ0srn9j9mW2gCCOkuIpR5shUcIt3OEyVP0qkrAfENVdo8XloXqidZY@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtO68T8OEvhEce7O6I1baN/Kz4HpHXF6mHlEkYabW+j74di9s
	5AJ1nrDVNB28Mose15WYBe0xpF8iUj87mlU3PcKFJxyyXEokSxum
X-Gm-Gg: ASbGncscKAmLb/aPRW0fP2mG7L+UiZApfdiXySn6PPlbThiQHQY3djo5l+VI3zrn2u3
	4TKFXTiRFnL1MnYuE7QcLjlAGdIqf7RhP+LkJ7Vp7D0NiOUyhu/TRUuP/frl1LmPdicgvNOZPDp
	rEAD8DdCEhIDulUROevEXOITnRnljipSGzpzz49pQraptnx1a9UvzRmUzfOEAAbnWDuIUx+ff1M
	tJG2uNpZz/FtraRMsbqCPE0v2g8zshf/JClvyPul0Jh38sEoRJKfOXaBTCpFO5RYw==
X-Google-Smtp-Source: AGHT+IGQ0HLLr+DORSyYYtXyjk1T69qFK2vfkzzbdE3R301sWx9QYZU2KfAfdIMHRVRS2zWXz7kWJQ==
X-Received: by 2002:a05:6402:210c:b0:5d2:73b0:81e8 with SMTP id 4fb4d7f45d1cf-5d273b08455mr1854981a12.9.1733413671433;
        Thu, 05 Dec 2024 07:47:51 -0800 (PST)
Received: from f.. (cst-prg-17-59.cust.vodafone.cz. [46.135.17.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a25d22sm932268a12.13.2024.12.05.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:47:50 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [MEH PATCH] fs: sort out a stale comment about races between fd alloc and dup2
Date: Thu,  5 Dec 2024 16:47:43 +0100
Message-ID: <20241205154743.1586584-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It claims the issue is only relevant for shared descriptor tables which
is of no concern for POSIX (but then is POSIX of concern to anyone
today?), which I presume predates standarized threading.

The comment also mentions the following systems:
- OpenBSD installing a larval file -- this remains accurate
- FreeBSD returning EBADF -- not accurate, the system uses the same
  idea as OpenBSD
- NetBSD "deadlocks in amusing ways" -- their solution looks
  Solaris-inspired (not a compliment) and I would not be particularly
  surprised if it indeed deadlocked, in amusing ways or otherwise

I don't believe mentioning any of these adds anything and the statement
about the issue not being POSIX-relevant is outdated.

dup2 description in POSIX still does not mention the problem.

Just shorten the comment and be done with it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I'm pretty sure the comment adds nothing in the current form, but I'm
not going to argue about it.

 fs/file.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index d065a24980da..ad8aabc08122 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1258,17 +1258,9 @@ __releases(&files->file_lock)
 
 	/*
 	 * We need to detect attempts to do dup2() over allocated but still
-	 * not finished descriptor.  NB: OpenBSD avoids that at the price of
-	 * extra work in their equivalent of fget() - they insert struct
-	 * file immediately after grabbing descriptor, mark it larval if
-	 * more work (e.g. actual opening) is needed and make sure that
-	 * fget() treats larval files as absent.  Potentially interesting,
-	 * but while extra work in fget() is trivial, locking implications
-	 * and amount of surgery on open()-related paths in VFS are not.
-	 * FreeBSD fails with -EBADF in the same situation, NetBSD "solution"
-	 * deadlocks in rather amusing ways, AFAICS.  All of that is out of
-	 * scope of POSIX or SUS, since neither considers shared descriptor
-	 * tables and this condition does not arise without those.
+	 * not finished descriptor.
+	 *
+	 * POSIX is silent on the issue, we return -EBUSY.
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-- 
2.43.0


