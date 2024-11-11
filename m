Return-Path: <linux-fsdevel+bounces-34342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F849C49EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B281F22F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F541C1F23;
	Mon, 11 Nov 2024 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2MPQRNY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142B15884A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368552; cv=none; b=iDyGrTHlfgniqs7DTHg9M8ERzb6scjzr3xGKi9ch6fTtBBItmuU0nhhhkm9w9dJEW48UA2j4WZHFlSV+wQ6TbXksbh6unhSdpkl32NLFNhN4zdidQ899zl9gfVp7BIcKLhX4OiRVDtRIl7ltyJ1Msw/Nd9vJ1xgEiA3eheOGy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368552; c=relaxed/simple;
	bh=G84W/6dBTneE85yh0jJsavDkjy8K8X2YQm7ZMk6DvWs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZCPg8NNReGd4Yn9uOCWY3S7vCoRXpwOg504tfbMUysvPHyjZhR1r/XIhKZ7S6G1m1D9XbXdgpQA3jCfbYW9Lt0r4pHfKuvLtpn5/jcfijqFp0g1Kwa5zYR8AAv3Y+6UIJAITLcxOLh8ZM0qjKP5LhK55Gb2aP9jZaqYTRLgR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2MPQRNY1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso3932094a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368547; x=1731973347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gm/1iww3q4pJXQNjE/AYvxT/eU9bUOSORBP12tvY0M4=;
        b=2MPQRNY1zSusLfG5e9o30affbCHDvKOvxsTQwaHrgN98DJBlZIYycQKWjz5F5AWfwa
         W8u0tqoWpVpIR0PT5Ui57wXY51NN00ITLmCu9NaakfZIFHRSaAhTmzaJFusAflwNG18u
         cYwiX0d6+J/7wzytFSSZScH9KESSsM/fb0q7A8MOVnDDIY+JaDUe5U9KOgzZ63m3y5os
         TzYy/9ok/fYL3fpdRaLvzKSvIAhiQ4q5pIv/6R6/t30Zsr92R24UCIiZ5YvILNO5XYTT
         voNawkqCxU41EqQPzu8nU0rnJQ5/14pA1H2sEnuYXr4RUhy9nVSjC3FzrMsOzEfL7VKv
         Tw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368547; x=1731973347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gm/1iww3q4pJXQNjE/AYvxT/eU9bUOSORBP12tvY0M4=;
        b=wM4scQQoCU/pahT1ODDXVv4VdJTQs+Z+4rycMOheeYo2m2ae+6IpAFgzIYtf0y3IVK
         qogdxTcX52jdHhhu6k40FZ2BFk1nEvHbxTZacWeUNuJAkfyr9GFwkYhoO0Hr09Xu4rmA
         n+Qhsbg8rqdjbvZ6/wtXaRGeYDWqny/h6kGTfhH0bpQuq6aniJvbBZKdIZxdJgeA+LUj
         ukWSHvNdSWzmy95kbl1RaW8v0Ng8T2IE/Lkp+Df0z47GhTX3wDu2snRH73Dpg+n/QoJB
         M/uUtF6WOPzPZgJTpuRMZvhOU4Wq2vsSI7xuutV4KpVlwl91CPG10xQ72c5nbrswxQVT
         u7dg==
X-Forwarded-Encrypted: i=1; AJvYcCVeh0iKix7EiDQuhEAdJ7Yw72O2oDtJ3cOJc1E84QDyKd8IbpJvKDA/m6v14oOyT5QxwtrKvNhqrS/oJzoA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1Etqix1H0D3p3itJL4kKYQAsVb/Jian4r03f73WuQwbSwcuQ
	lJjRVVXtoj68NTJZ/LuOFgVEv7K/P+kH7J3LNdjTIvXPG7GHPt3vTASQouLhzBE=
X-Google-Smtp-Source: AGHT+IFK47wsMbD6JnavKrqtn1wf/B0dvZrIHUHGrez6KFdfj6XRu1Jndy738VGhwzVW6y80u5uuEg==
X-Received: by 2002:a17:90b:2e07:b0:2e2:e6fa:cfef with SMTP id 98e67ed59e1d1-2e9b177fd34mr19568959a91.25.1731368547423;
        Mon, 11 Nov 2024 15:42:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5aa01sm80858605ad.211.2024.11.11.15.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:42:26 -0800 (PST)
Message-ID: <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
Date: Mon, 11 Nov 2024 16:42:25 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
Content-Language: en-US
In-Reply-To: <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 10:09 AM, Jens Axboe wrote:
> On 11/11/24 8:17 AM, Jens Axboe wrote:
>> On 11/11/24 8:16 AM, Christoph Hellwig wrote:
>>> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
>>>> Ok thanks, let me take a look at that and create a test case that
>>>> exercises that explicitly.
>>>
>>> Please add RWF_UNCACHED to fsstress.c in xfstests also.  That is our
>>> exerciser for concurrent issuing of different I/O types to hit these
>>> kinds of corner cases.
>>
>> Sure, can do.
> 
> Not familiar with fsstress at all, but something like the below? Will
> use it if available, if it gets EOPNOTSUPP it'll just fallback to
> using writev_f()/readv_f() instead.
> 
> Did give it a quick test spin and I see uncached reads and writes on the
> kernel that supports it.

Here's the slightly cleaned up version, this is the one I ran testing
with.

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 3d248ee25791..a06ba300a1d7 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -82,6 +82,12 @@ static int renameat2(int dfd1, const char *path1,
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
 #endif
 
+#ifndef RWF_UNCACHED
+#define RWF_UNCACHED		0x80
+#endif
+
+static int have_rwf_uncached = 1;
+
 #define FILELEN_MAX		(32*4096)
 
 typedef enum {
@@ -117,6 +123,7 @@ typedef enum {
 	OP_COLLAPSE,
 	OP_INSERT,
 	OP_READ,
+	OP_READ_UNCACHED,
 	OP_READLINK,
 	OP_READV,
 	OP_REMOVEFATTR,
@@ -143,6 +150,7 @@ typedef enum {
 	OP_URING_READ,
 	OP_URING_WRITE,
 	OP_WRITE,
+	OP_WRITE_UNCACHED,
 	OP_WRITEV,
 	OP_EXCHANGE_RANGE,
 	OP_LAST
@@ -248,6 +256,7 @@ void	zero_f(opnum_t, long);
 void	collapse_f(opnum_t, long);
 void	insert_f(opnum_t, long);
 void	unshare_f(opnum_t, long);
+void	read_uncached_f(opnum_t, long);
 void	read_f(opnum_t, long);
 void	readlink_f(opnum_t, long);
 void	readv_f(opnum_t, long);
@@ -273,6 +282,7 @@ void	unlink_f(opnum_t, long);
 void	unresvsp_f(opnum_t, long);
 void	uring_read_f(opnum_t, long);
 void	uring_write_f(opnum_t, long);
+void	write_uncached_f(opnum_t, long);
 void	write_f(opnum_t, long);
 void	writev_f(opnum_t, long);
 void	exchangerange_f(opnum_t, long);
@@ -315,6 +325,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_COLLAPSE]	   = {"collapse",      collapse_f,	1, 1 },
 	[OP_INSERT]	   = {"insert",	       insert_f,	1, 1 },
 	[OP_READ]	   = {"read",	       read_f,		1, 0 },
+	[OP_READ_UNCACHED] = {"read_uncached", read_uncached_f,	1, 0 },
 	[OP_READLINK]	   = {"readlink",      readlink_f,	1, 0 },
 	[OP_READV]	   = {"readv",	       readv_f,		1, 0 },
 	/* remove (delete) extended attribute */
@@ -346,6 +357,7 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	1, 1 },
 	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
 	[OP_WRITEV]	   = {"writev",	       writev_f,	4, 1 },
+	[OP_WRITE_UNCACHED]= {"write_uncaced", write_uncached_f,4, 1 },
 	[OP_EXCHANGE_RANGE]= {"exchangerange", exchangerange_f,	2, 1 },
 }, *ops_end;
 
@@ -4635,6 +4647,71 @@ readv_f(opnum_t opno, long r)
 	close(fd);
 }
 
+void
+read_uncached_f(opnum_t opno, long r)
+{
+	int		e;
+	pathname_t	f;
+	int		fd;
+	int64_t		lr;
+	off64_t		off;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+	struct iovec	iov;
+	int flags;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%lld: read - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_RDONLY);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%lld: read - open %s failed %d\n",
+				procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%lld: read - fstat64 %s failed %d\n",
+				procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	if (stb.st_size == 0) {
+		if (v)
+			printf("%d/%lld: read - %s%s zero size\n", procid, opno,
+			       f.path, st);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	lr = ((int64_t)random() << 32) + random();
+	off = (off64_t)(lr % stb.st_size);
+	iov.iov_len = (random() % FILELEN_MAX) + 1;
+	iov.iov_base = malloc(iov.iov_len);
+	flags = have_rwf_uncached ? RWF_UNCACHED : 0;
+	e = preadv2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
+	if (have_rwf_uncached && e == EOPNOTSUPP)
+		e = preadv2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
+	free(iov.iov_base);
+	if (v)
+		printf("%d/%lld: read uncached %s%s [%lld,%d] %d\n",
+		       procid, opno, f.path, st, (long long)off,
+		       (int)iov.iov_len, e);
+	free_pathname(&f);
+	close(fd);
+}
+
 void
 removefattr_f(opnum_t opno, long r)
 {
@@ -5509,6 +5586,65 @@ writev_f(opnum_t opno, long r)
 	close(fd);
 }
 
+void
+write_uncached_f(opnum_t opno, long r)
+{
+	int		e;
+	pathname_t	f;
+	int		fd;
+	int64_t		lr;
+	off64_t		off;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+	struct iovec	iov;
+	int flags;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGm, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%lld: write - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_WRONLY);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%lld: write - open %s failed %d\n",
+				procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%lld: write - fstat64 %s failed %d\n",
+				procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	lr = ((int64_t)random() << 32) + random();
+	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	off %= maxfsize;
+	iov.iov_len = (random() % FILELEN_MAX) + 1;
+	iov.iov_base = malloc(iov.iov_len);
+	memset(iov.iov_base, nameseq & 0xff, iov.iov_len);
+	flags = have_rwf_uncached ? RWF_UNCACHED : 0;
+	e = pwritev2(fd, &iov, 1, off, flags) < 0 ? errno : 0;
+	if (have_rwf_uncached && e == EOPNOTSUPP)
+		e = pwritev2(fd, &iov, 1, off, 0) < 0 ? errno : 0;
+	free(iov.iov_base);
+	if (v)
+		printf("%d/%lld: write uncached %s%s [%lld,%d] %d\n",
+		       procid, opno, f.path, st, (long long)off,
+		       (int)iov.iov_len, e);
+	free_pathname(&f);
+	close(fd);
+}
+
 char *
 xattr_flag_to_string(int flag)
 {

-- 
Jens Axboe

