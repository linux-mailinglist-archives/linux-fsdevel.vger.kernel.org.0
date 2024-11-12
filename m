Return-Path: <linux-fsdevel+bounces-34490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92439C5EB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3097B1F21DE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED4E2101BE;
	Tue, 12 Nov 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1fXQuC+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A47200CA7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431947; cv=none; b=UnXO7n6O3estpyznXGPf9wtIj3pOcoXzTtbyNNhTWDQaNcYZCpWjXko4sAX1whGTAvzJXy+hbg7IPOZE5stgW9OP4Gm7V7tpfp+USQFWyVV03QVEv+geyiL05yZkNDkElovX5W6Xylih+msWGaJF9Y1mYxndWPXMt9WYNnEmBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431947; c=relaxed/simple;
	bh=pDzD7M86hmb/Davpv+QCf7+0qfC44zYQb2N7ECQ7294=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TF/tqUOuHEn8XsgP4k/ifP0hg5M3cK/KVl415Ll3wECUHPGyy/jx4CwJ1NjC5BW1YOe+NxBOvkPJ5iOfo1Zffd+rXl3U31C3MeykO7Ow2PbuWUfSIbnfiz6F295Upfv6NQ+VnrEwHw4x5owEbUoM7scma2inRLINkRbDB1LYLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1fXQuC+f; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28c7f207806so2519007fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731431944; x=1732036744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EotR0bw+FAnHMrISS9FPE3lHhbs9IrDHabSVQGLPmwA=;
        b=1fXQuC+ffHBSt9yUs2C6C+ncL8aZxg224BEymJ0x/5uQ9rMbIuEylG/xJ+D3RU5gek
         cExCPPjm5Hd6dVBh3DXX7WkJP+rAmn/eoMJgUeBgv/E3ZriZt25pdXcecxCP3f9hVA/3
         jjb7ZPgQwZ5pL4SsvgS44B2VL95IUAlL3RePs7s8j3IU/ka6bbd9WzZuqtKsAn8kronC
         nugs165FjyiunM3pUwa0vNn0d6bjiji00zIq40I/WfDg3mhS12h3wfnxXrJ8G04/xL/j
         FHjvNt/Jxo9GBz9pydezM6jmX6xMHj2tbaB1laFSGcGB2z+RzA/gB2kW1xO3kYVGRPiV
         RIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431944; x=1732036744;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EotR0bw+FAnHMrISS9FPE3lHhbs9IrDHabSVQGLPmwA=;
        b=EBx3pH+exw7vfEGi1A/MOOIseeeVuybaWesTWBrEEaz/79doHbIJ0VCBfO2gnGIqmE
         V/FCZ7gSN9UkUUoOkwOMIhkj2y9mRitHQM5yjbgrYOPnrUiAEYEO365j5ZfnhlsbydTN
         DyG8gOyQFsdLtjrFQTLajnzeb4MWcbnNB5OekCMu1cavKVd8/48IXWaRmjnTvM2GiuZQ
         cQtGIXKAoYXbJbFBrjHCwdGQd/ZcKd9Ccat0qMZsy6M6/jU+iZvIFA/tOfKPuc04Rd60
         TFmM2gMIftBeJST3/FdmUvFu6wcEM619pTWeOOElpp4J6sluxDnJ+DIwHFRb6W/yCs55
         Y9fg==
X-Forwarded-Encrypted: i=1; AJvYcCVITfc/akhlRSJHcySC3ehSQ2Xsjqfq9bB8z8D0G372WmSy7mE31VKyK+ExRbBy2LkYgdwdvcaxK/wudvN/@vger.kernel.org
X-Gm-Message-State: AOJu0YyRevSwZ9ZEo+Dxme5FjXJzDxcThbFOQwuIuZ/RheW2WZTw7Js2
	OyNoicWQR0JxTMebVmW1AoSwnwxZFKT90MufJNiOQuneirq/I87meUyGUGadfvY=
X-Google-Smtp-Source: AGHT+IHgATCiN5pGkNIh40SG1qC/yKgG0COrPWw6RMy3oiE6zHQ4+BmWlr+9g37rnmPmCr9cWKuRFA==
X-Received: by 2002:a05:6870:9a95:b0:277:db7f:cfb2 with SMTP id 586e51a60fabf-295ccfd6b0emr3503409fac.14.1731431944532;
        Tue, 12 Nov 2024 09:19:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c42b3bsm3525410fac.9.2024.11.12.09.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:19:03 -0800 (PST)
Message-ID: <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk>
Date: Tue, 12 Nov 2024 10:19:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
From: Jens Axboe <axboe@kernel.dk>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <ZzIfwmGkbHwaSMIn@infradead.org>
 <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk> <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
Content-Language: en-US
In-Reply-To: <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 10:06 AM, Jens Axboe wrote:
> On 11/12/24 9:39 AM, Brian Foster wrote:
>> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
>>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
>>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
>>>>> Here's the slightly cleaned up version, this is the one I ran testing
>>>>> with.
>>>>
>>>> Looks reasonable to me, but you probably get better reviews on the
>>>> fstests lists.
>>>
>>> I'll send it out once this patchset is a bit closer to integration,
>>> there's the usual chicken and egg situation with it. For now, it's quite
>>> handy for my testing, found a few issues with this version. So thanks
>>> for the suggestion, sure beats writing more of your own test cases :-)
>>>
>>
>> fsx support is probably a good idea as well. It's similar in idea to
>> fsstress, but bashes the same file with mixed operations and includes
>> data integrity validation checks as well. It's pretty useful for
>> uncovering subtle corner case issues or bad interactions..
> 
> Indeed, I did that too. Re-running xfstests right now with that too.

Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
for both the sync read/write and io_uring paths.


diff --git a/ltp/fsx.c b/ltp/fsx.c
index 41933354..104910ff 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -43,6 +43,10 @@
 # define MAP_FILE 0
 #endif
 
+#ifndef RWF_UNCACHED
+#define RWF_UNCACHED	0x80
+#endif
+
 #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
 
 /* Operation flags (bitmask) */
@@ -101,7 +105,9 @@ int			logcount = 0;	/* total ops */
 enum {
 	/* common operations */
 	OP_READ = 0,
+	OP_READ_UNCACHED,
 	OP_WRITE,
+	OP_WRITE_UNCACHED,
 	OP_MAPREAD,
 	OP_MAPWRITE,
 	OP_MAX_LITE,
@@ -190,15 +196,16 @@ int	o_direct;			/* -Z */
 int	aio = 0;
 int	uring = 0;
 int	mark_nr = 0;
+int	rwf_uncached = 1;
 
 int page_size;
 int page_mask;
 int mmap_mask;
-int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset);
+int fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags);
 #define READ 0
 #define WRITE 1
-#define fsxread(a,b,c,d)	fsx_rw(READ, a,b,c,d)
-#define fsxwrite(a,b,c,d)	fsx_rw(WRITE, a,b,c,d)
+#define fsxread(a,b,c,d,f)	fsx_rw(READ, a,b,c,d,f)
+#define fsxwrite(a,b,c,d,f)	fsx_rw(WRITE, a,b,c,d,f)
 
 struct timespec deadline;
 
@@ -266,7 +273,9 @@ prterr(const char *prefix)
 
 static const char *op_names[] = {
 	[OP_READ] = "read",
+	[OP_READ_UNCACHED] = "read_uncached",
 	[OP_WRITE] = "write",
+	[OP_WRITE_UNCACHED] = "write_uncached",
 	[OP_MAPREAD] = "mapread",
 	[OP_MAPWRITE] = "mapwrite",
 	[OP_TRUNCATE] = "truncate",
@@ -393,12 +402,14 @@ logdump(void)
 				prt("\t******WWWW");
 			break;
 		case OP_READ:
+		case OP_READ_UNCACHED:
 			prt("READ     0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
 			    lp->args[1]);
 			if (overlap)
 				prt("\t***RRRR***");
 			break;
+		case OP_WRITE_UNCACHED:
 		case OP_WRITE:
 			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
@@ -784,9 +795,8 @@ doflush(unsigned offset, unsigned size)
 }
 
 void
-doread(unsigned offset, unsigned size)
+__doread(unsigned offset, unsigned size, int flags)
 {
-	off_t ret;
 	unsigned iret;
 
 	offset -= offset % readbdy;
@@ -818,23 +828,39 @@ doread(unsigned offset, unsigned size)
 			(monitorend == -1 || offset <= monitorend))))))
 		prt("%lld read\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
 		    offset, offset + size - 1, size);
-	ret = lseek(fd, (off_t)offset, SEEK_SET);
-	if (ret == (off_t)-1) {
-		prterr("doread: lseek");
-		report_failure(140);
-	}
-	iret = fsxread(fd, temp_buf, size, offset);
+	iret = fsxread(fd, temp_buf, size, offset, flags);
 	if (iret != size) {
-		if (iret == -1)
-			prterr("doread: read");
-		else
+		if (iret == -1) {
+			if (errno == EOPNOTSUPP && flags & RWF_UNCACHED) {
+				rwf_uncached = 1;
+				return;
+			}
+			prterr("dowrite: read");
+		} else {
 			prt("short read: 0x%x bytes instead of 0x%x\n",
 			    iret, size);
+		}
 		report_failure(141);
 	}
 	check_buffers(temp_buf, offset, size);
 }
+void
+doread(unsigned offset, unsigned size)
+{
+	__doread(offset, size, 0);
+}
 
+void
+doread_uncached(unsigned offset, unsigned size)
+{
+	if (rwf_uncached) {
+		__doread(offset, size, RWF_UNCACHED);
+		if (rwf_uncached)
+			return;
+	}
+	__doread(offset, size, 0);
+}
+	
 void
 check_eofpage(char *s, unsigned offset, char *p, int size)
 {
@@ -870,7 +896,6 @@ check_contents(void)
 	unsigned map_offset;
 	unsigned map_size;
 	char *p;
-	off_t ret;
 	unsigned iret;
 
 	if (!check_buf) {
@@ -885,13 +910,7 @@ check_contents(void)
 	if (size == 0)
 		return;
 
-	ret = lseek(fd, (off_t)offset, SEEK_SET);
-	if (ret == (off_t)-1) {
-		prterr("doread: lseek");
-		report_failure(140);
-	}
-
-	iret = fsxread(fd, check_buf, size, offset);
+	iret = fsxread(fd, check_buf, size, offset, 0);
 	if (iret != size) {
 		if (iret == -1)
 			prterr("check_contents: read");
@@ -1064,9 +1083,8 @@ update_file_size(unsigned offset, unsigned size)
 }
 
 void
-dowrite(unsigned offset, unsigned size)
+__dowrite(unsigned offset, unsigned size, int flags)
 {
-	off_t ret;
 	unsigned iret;
 
 	offset -= offset % writebdy;
@@ -1101,18 +1119,18 @@ dowrite(unsigned offset, unsigned size)
 			(monitorend == -1 || offset <= monitorend))))))
 		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\n", testcalls,
 		    offset, offset + size - 1, size);
-	ret = lseek(fd, (off_t)offset, SEEK_SET);
-	if (ret == (off_t)-1) {
-		prterr("dowrite: lseek");
-		report_failure(150);
-	}
-	iret = fsxwrite(fd, good_buf + offset, size, offset);
+	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
 	if (iret != size) {
-		if (iret == -1)
+		if (iret == -1) {
+			if (errno == EOPNOTSUPP && flags & RWF_UNCACHED) {
+				rwf_uncached = 0;
+				return;
+			}
 			prterr("dowrite: write");
-		else
+		} else {
 			prt("short write: 0x%x bytes instead of 0x%x\n",
 			    iret, size);
+		}
 		report_failure(151);
 	}
 	if (do_fsync) {
@@ -1126,6 +1144,22 @@ dowrite(unsigned offset, unsigned size)
 	}
 }
 
+void
+dowrite(unsigned offset, unsigned size)
+{
+	__dowrite(offset, size, 0);
+}
+
+void
+dowrite_uncached(unsigned offset, unsigned size)
+{
+	if (rwf_uncached) {
+		__dowrite(offset, size, RWF_UNCACHED);
+		if (rwf_uncached)
+			return;
+	}
+	__dowrite(offset, size, 0);
+}
 
 void
 domapwrite(unsigned offset, unsigned size)
@@ -2340,11 +2374,21 @@ have_op:
 		doread(offset, size);
 		break;
 
+	case OP_READ_UNCACHED:
+		TRIM_OFF_LEN(offset, size, file_size);
+		doread_uncached(offset, size);
+		break;
+
 	case OP_WRITE:
 		TRIM_OFF_LEN(offset, size, maxfilelen);
 		dowrite(offset, size);
 		break;
 
+	case OP_WRITE_UNCACHED:
+		TRIM_OFF_LEN(offset, size, maxfilelen);
+		dowrite_uncached(offset, size);
+		break;
+
 	case OP_MAPREAD:
 		TRIM_OFF_LEN(offset, size, file_size);
 		domapread(offset, size);
@@ -2702,7 +2746,7 @@ uring_setup()
 }
 
 int
-uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
 {
 	struct io_uring_sqe     *sqe;
 	struct io_uring_cqe     *cqe;
@@ -2733,6 +2777,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 		} else {
 			io_uring_prep_writev(sqe, fd, &iovec, 1, o);
 		}
+		sqe->rw_flags = flags;
 
 		ret = io_uring_submit_and_wait(&ring, 1);
 		if (ret != 1) {
@@ -2781,7 +2826,7 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 }
 #else
 int
-uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
 {
 	fprintf(stderr, "io_rw: need IO_URING support!\n");
 	exit(111);
@@ -2789,19 +2834,21 @@ uring_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
 #endif
 
 int
-fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
+fsx_rw(int rw, int fd, char *buf, unsigned len, unsigned offset, int flags)
 {
 	int ret;
 
 	if (aio) {
 		ret = aio_rw(rw, fd, buf, len, offset);
 	} else if (uring) {
-		ret = uring_rw(rw, fd, buf, len, offset);
+		ret = uring_rw(rw, fd, buf, len, offset, flags);
 	} else {
+		struct iovec iov = { .iov_base = buf, .iov_len = len };
+
 		if (rw == READ)
-			ret = read(fd, buf, len);
+			ret = preadv2(fd, &iov, 1, offset, flags);
 		else
-			ret = write(fd, buf, len);
+			ret = pwritev2(fd, &iov, 1, offset, flags);
 	}
 	return ret;
 }


-- 
Jens Axboe

