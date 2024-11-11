Return-Path: <linux-fsdevel+bounces-34268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354369C4338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1031F2108D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A097E1A4E70;
	Mon, 11 Nov 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K6AMPVyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F761FD7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344961; cv=none; b=IJc6xwlxF9HKMFJRh9a7PuhdnzW24KyJ9FchgFSpSuVfh6oYJgtlQpxql9uG2AX++61TI/5yHY7MF9SABE6hZiys8rBWwOtcXgRTxhBHc734Ne14ewrybWInTYelctU0dNxaseV348wfl/x704LmeKmL6WbdOQ2usSAwlOuE220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344961; c=relaxed/simple;
	bh=FWFU++bHMwg8DYm85y0XjcNuvtTGRgPVpTC09F8Y7xE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OmOf30zBTfsgFIEQvv8zZwpIvhcOV16WX+KBlKguDFW92ShtAr4khmcnsHXe2yXeLV0G40zKk2myACMUPY3PaYxpyhQXUC7aeTACvqN/VKwvD1p5Nvy3JIhoRkfC91m8LECPpVef3XbDP/MP7VJq7y/96QOgHH9tzd8B6EhSQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K6AMPVyq; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71811aba576so2984536a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731344956; x=1731949756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6fLv7NDwAwgh2zTfiGl9xXcUzRaOQnOkOpbb/tKGe0=;
        b=K6AMPVyqy4twA+xwqmYbYJytw4z2hIsW+NQr4mbx7rDwRPZsc7P3UQzXYOiXxOq5vz
         XnHipzTeBHtAZ4NLD7DD3NVjGPdJSVG+5w9/M8KmNpvAxX0J/6D56QJCwzH8bo9RIXC1
         RjdzoihivyhdzLBock49IEDiK9K/D1UwDgT6p0nSdcc2cJxWdeJOAnvVijHqD7Z1QIVo
         qTaz8qanaTOUa2K87l9n4vw5pEHAGB0h1ubA64MA0kDtmTyQYek5/O25pB951VjmR35Z
         LwOO2k2vpmltuxR3uWFQj8R7IKSsq/qtuB82SQ4QMz8oxK9lo7vWbq2nP8U8rg0eyxq2
         cNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344956; x=1731949756;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6fLv7NDwAwgh2zTfiGl9xXcUzRaOQnOkOpbb/tKGe0=;
        b=ciwTSe4ZhFRx/axDKf30rB7fHjShWEml3BgT9SvRmA9vC/W7kRMvVMpsfDRec8I9eZ
         JJ32CB1bEXvgyI+GlTCn49ojhdF8GX4RsacwubIzm/8/3+W/ZX9d4Q+G1HkIJ1qRgP8N
         X5x9CLMSh9REzJMvjZg3BTUmUm0X/hQoJ5m85blVHJli1inurDqXdgOu6r5cEkNLdxOo
         5zAGiqXfxnnu8y1uh+A76To3kSeJME5ABfwUre3//hXgNELUTS/KBJESKoEk1WOmMHOG
         Sp3DH5p5EjREIg/njW5/GyQIvf/as5xA2lDyr870NJlPG8+cC0CocpwqtGJ7NmQndXz2
         BEuA==
X-Forwarded-Encrypted: i=1; AJvYcCU9SfgmEoUqHO5pZjPRU4lzE9AXomybkAsB6EpjP/hr6DTu3+eIsOhO++0MYUT5vSns4t1l8plEMwnFzkpM@vger.kernel.org
X-Gm-Message-State: AOJu0YxlclHK1xvFFeqg+oq75rhf//UrzkoH7kvE9H7UgZWhl2oLYDVU
	0ZtLf5H8TMNIWyC41kVQddN/bjEukMyeJAYBKD88UdiaiX0ilIOHd6Q5hZErC94=
X-Google-Smtp-Source: AGHT+IFNZamT2bZFDaSjw1Yl3jaxXvbQV8DNZNoPpnlYjKrFHE1JGXIOAPe3KflgKlcoZRhw+QrWwg==
X-Received: by 2002:a9d:4c12:0:b0:710:e1e4:1bc3 with SMTP id 46e09a7af769-71a1b013b2bmr6535107a34.6.1731344956471;
        Mon, 11 Nov 2024 09:09:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a107eb5desm2315700a34.3.2024.11.11.09.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:09:15 -0800 (PST)
Message-ID: <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
Date: Mon, 11 Nov 2024 10:09:14 -0700
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
Content-Language: en-US
In-Reply-To: <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:17 AM, Jens Axboe wrote:
> On 11/11/24 8:16 AM, Christoph Hellwig wrote:
>> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
>>> Ok thanks, let me take a look at that and create a test case that
>>> exercises that explicitly.
>>
>> Please add RWF_UNCACHED to fsstress.c in xfstests also.  That is our
>> exerciser for concurrent issuing of different I/O types to hit these
>> kinds of corner cases.
> 
> Sure, can do.

Not familiar with fsstress at all, but something like the below? Will
use it if available, if it gets EOPNOTSUPP it'll just fallback to
using writev_f()/readv_f() instead.

Did give it a quick test spin and I see uncached reads and writes on the
kernel that supports it.

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 3d248ee25791..6430f10efbc7 100644
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
 
@@ -4635,6 +4647,76 @@ readv_f(opnum_t opno, long r)
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
+
+	if (!have_rwf_uncached) {
+		readv_f(opno, r);
+		return;
+	}
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
+	e = preadv2(fd, &iov, 1, off, RWF_UNCACHED) < 0 ? errno : 0;
+	if (e == EOPNOTSUPP) {
+		have_rwf_uncached = 0;
+		e = 0;
+	}
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
@@ -5509,6 +5591,70 @@ writev_f(opnum_t opno, long r)
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
+
+	if (!have_rwf_uncached) {
+		writev_f(opno, r);
+		return;
+	}
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
+	e = pwritev2(fd, &iov, 1, off, RWF_UNCACHED) < 0 ? errno : 0;
+	free(iov.iov_base);
+	if (v)
+		printf("%d/%lld: write uncached %s%s [%lld,%d] %d\n",
+		       procid, opno, f.path, st, (long long)off,
+		       (int)iov.iov_len, e);
+	free_pathname(&f);
+	close(fd);
+	if (e == EOPNOTSUPP) {
+		writev_f(opno, r);
+		have_rwf_uncached = 0;
+	}
+}
+
 char *
 xattr_flag_to_string(int flag)
 {

-- 
Jens Axboe

