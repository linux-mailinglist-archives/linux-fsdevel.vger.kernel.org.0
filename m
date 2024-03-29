Return-Path: <linux-fsdevel+bounces-15675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60088917F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F911C2291A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A123E80621;
	Fri, 29 Mar 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="belS+Yer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2627E764
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712148; cv=none; b=LQtQr0IBv81Q8e5r46lXx5mdTTZnUaL+1O1U8hwZp3UbUynOFFHA0YuyrVRrOc9Ay1WeRy0Wx5kQSrSpmC8Vv8tefOhOqWPnwrKSW4XAUn4fE2jzfN7665f3hqOiZ4csfxvZETFim37HbHJ/uR6Mf9QKpgCLIAWv26sIo0DPcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712148; c=relaxed/simple;
	bh=w7g9k9MR8Xt6HDVUb+s4+IDBIE7m2n+TUVkfDKgvr14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=D1UtscHagom4lXfimzLNg8qB8aLHRBH5VnCfBT5t6A2f7J4bqNPH/bllTIjAsEnjRKR9Y8s53kTCexQjfq6EOMzZcJc9/vs5pfkYIkuzrjiIs/V11u6xBz+Y+7FOAiAoZYGrWOakUqNuDXhJHLsVybQgij20jdelegunl8CVx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=belS+Yer; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240329113537epoutp04dac6ccd10a2145fe2a2b38b976ecb319~BOR69oiMF0926209262epoutp04-
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 11:35:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240329113537epoutp04dac6ccd10a2145fe2a2b38b976ecb319~BOR69oiMF0926209262epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711712137;
	bh=99LzP7voCnYh/Y4bbLzHy08uzA5E3NnCx/u2rSHwG+A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=belS+YeroG9oPdWWn8NXS3t1K1e3OdafX8Iz/KGC1lQUVROMOaRME2Uvgy1gWveSN
	 wX1Hqb5jMl+mZaZnQn64LeHNJCPAngu+VIYSwgai+rpGLoR3ERtPqH8LwE08ujdS+T
	 tbOnMPNsBNz34ws8e2K8XxuOkKGwJy1/4MPRDFdg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240329113537epcas5p4a5cb2aaf19ac7afc03a4c28fdb08c04c~BOR6knDZs1875118751epcas5p4t;
	Fri, 29 Mar 2024 11:35:37 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V5dd32n61z4x9Pv; Fri, 29 Mar
	2024 11:35:35 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.52.09665.787A6066; Fri, 29 Mar 2024 20:35:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240329113534epcas5p3b15f2cd8483d566eecc9791b8e1ed5c7~BOR4gif_t2394523945epcas5p36;
	Fri, 29 Mar 2024 11:35:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240329113534epsmtrp24702b0e67bc35ccef127e11a81010352~BOR4f0rMp2556625566epsmtrp2N;
	Fri, 29 Mar 2024 11:35:34 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-a8-6606a78768ad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.2C.08390.687A6066; Fri, 29 Mar 2024 20:35:34 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240329113533epsmtip23b41d1f50ad2a799cd12237e17aec7a5~BOR2_crAe1089810898epsmtip2E;
	Fri, 29 Mar 2024 11:35:33 +0000 (GMT)
Message-ID: <e6ec5771-5377-fcb4-7fb4-0858f8f1f0ac@samsung.com>
Date: Fri, 29 Mar 2024 17:05:32 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, lsf-pc@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <yq1sf0b4359.fsf@ca-mkp.ca.oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmlm77crY0g28H+SxW3+1ns1i5+iiT
	xZ+HhhaTDl1jtNh7S9tiz96TLBbzlz1lt9j3ei+zxfLj/5gcOD0uny312LSqk81j85J6j8k3
	ljN67L7ZwObx8ektFo8JmzeyenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCo
	a2hpYa6kkJeYm2qr5OIToOuWmQN0m5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWn
	wKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2P3uq+MBdN1Ky4tW8rYwDhBtouRk0NCwETiz4FF
	jF2MXBxCArsZJSbseQXlfGKUWPnqGCuE841R4tCe+awwLd8aJrCD2EICexklNkzggih6yyjx
	+cJRZpAEr4CdxPGeVkYQm0VAVWLBpQaouKDEyZlPWEBsUYFkiZ9dB9i6GDk4hAViJJ7tcwUJ
	MwuIS9x6Mp8JxBYRMJWY/GkrG8h8ZoHHTBIf+o8wgdSzCWhKXJhcClLDKWAs8a1zNjtEr7zE
	9rdzmEHqJQRWckis3HOaEeJoF4kv/b1sELawxKvjW9ghbCmJz+/2QsWTJS7NPMcEYZdIPN5z
	EMq2l2g91c8MspcZaO/6XfoQu/gken8/ATtHQoBXoqNNCKJaUeLepKfQoBKXeDhjCZTtIfHj
	8gk2SFDNZJKYs+gI8wRGhVlIoTILyfuzkLwzC2HzAkaWVYySqQXFuempxaYFxnmp5fD4Ts7P
	3cQITrla3jsYHz34oHeIkYmD8RCjBAezkgjvzqMsaUK8KYmVValF+fFFpTmpxYcYTYHRM5FZ
	SjQ5H5j080riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYGqTcPv/
	sGiqv1PBvmO/QozXM0RcNXijm/6yizdz8v3G3b/4dz1rYNzLUlEnrHiy9e872ZhPvGfy1I1f
	tsW7l/nd2dhuXXihW4zvKN8GZv56v97/uZVXP5fKNp3y1bhsXK/beWjNDa55ch9uruUI+bEv
	s07g3cyQiQv+GuTIyW00e7na7fZul/4dk0yW63JesOdumyRd9LVg6RH7c2wp7xouXL3o2rL6
	3+nAY8HT23s77L9vP5CqZeGSP7Ps8evzyXGKvWzzfm5b33LEppyT8eYM8WOXz9/MbNMT4qye
	I7v7K+v6TWZfjp/5FuZsc/Jk29KN5w7+SW7yfzBz8pXPEbnfPO8Zn39zmeO2yOb+PjElluKM
	REMt5qLiRACOJYi2QgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXrdtOVuawYHzuhar7/azWaxcfZTJ
	4s9DQ4tJh64xWuy9pW2xZ+9JFov5y56yW+x7vZfZYvnxf0wOnB6Xz5Z6bFrVyeaxeUm9x+Qb
	yxk9dt9sYPP4+PQWi8eEzRtZPT5vkgvgiOKySUnNySxLLdK3S+DK2L3uK2PBdN2KS8uWMjYw
	TpDtYuTkkBAwkfjWMIG9i5GLQ0hgN6PE3+W7WSES4hLN136wQ9jCEiv/PQezhQReM0qseAHW
	zCtgJ3G8p5URxGYRUJVYcKmBGSIuKHFy5hMWEFtUIFni5Z+JYL3CAjESe7etB4szA82/9WQ+
	E4gtImAqMfnTVjaI+GMmic0/PSAOmskk8ejGaqCDODjYBDQlLkwuBanhFDCW+NY5mx2i3kyi
	a2sXI4QtL7H97RzmCYxCs5CcMQvJullIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
	L10vOT93EyM4vrS0djDuWfVB7xAjEwfjIUYJDmYlEd6dR1nShHhTEiurUovy44tKc1KLDzFK
	c7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamBinm36e3XutFVNH9aeWlq18T6b7MK9GxJO
	soTmyP5gNz257nFHgIbcg6kdzxJMtb7PWaEc8jKi/uCbl1cvN/FXqHJ8ObzvftkWtXub/99W
	eSt3nvP3itUF5bfv3Rd1eiVgn/knZNfPexZ9DGrq8i+Zatc2Bu5wy9jGFraq+l3Q6w1zc4/e
	DnxaabL1gS7f07AElbj3G1M/MyfzaUVOu/9L3mzO470KztoH7ha1vnjQdudeEefmu25215qe
	rD5x1CMn+3PO7PLCaL9ba76e7rHWnVE8c45sV93a8GWVJmn3Hwtz2Tw69fbdtSvpDOkPrl+R
	zJSX8F9SqnBo8kdP2fl3Jum3PPudskQz9FqyM+dufiWW4oxEQy3mouJEAKsN0QYeAwAA
X-CMS-MailID: 20240329113534epcas5p3b15f2cd8483d566eecc9791b8e1ed5c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	<c196e634-7081-9d90-620c-002d3ff15dfc@samsung.com>
	<yq1sf0b4359.fsf@ca-mkp.ca.oracle.com>

On 3/28/2024 6:00 AM, Martin K. Petersen wrote:
> 
> Hi Kanchan!
> 
>> Not sure how far it is from the requirements you may have. Feedback
>> will help. Perhaps the interface needs the ability to tell what kind
>> of checks (guard, apptag, reftag) are desired. Doable, but that will
>> require the introduction of three new RWF_* flags.
> 
> I'm working on getting my test tooling working with your series.

If it helps somehow, here is a simple application for the interface [*].
It is devoid of guard (and stuff); for that fio is better.

> But
> yes, I'll definitely need a way to set the bip flags.

Just to be clear, I was thinking of three new flags that userspace can 
pass: RWF_CHK_GUARD, RWF_CHK_APPTAG, RWF_CHK_REFTAG.
And corresponding bip flags will need to be introduced (I don't see 
anything existing). Driver will see those and convert to protocol 
specific flags.
Does this match with you what you have in mind.


>> Right. This can work for the case when host does not need to pass the
>> buffer (meta-size is equal to pi-size). But when meta-size is greater
>> than pi-size, the meta-buffer needs to be allocated. Some changes are
>> required so that Block-integrity does that allocation, without having
>> to do read_verify/write_generate.
> 
> Not sure I follow. Do you want the non-PI metadata to be passed in from
> userland but the kernel or controller to generate the PI?
> 

No, this has no connection with userland. Seems concurrent discussion 
(with the user-interface topic) will cause the confusion. Maybe this is 
better to be discussed (after some time) along with its own RFC.

[*]

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/io_uring.h>
#include "liburing.h"

/* write data/meta. read data/meta. compare data/meta buffers */
/* prerequisite: format namespace with 4KB + 8b, pi_type = 0 */

#define DATA_LEN 4096
#define META_LEN 8

int main(int argc, char *argv[])
{
         struct io_uring ring;
         struct io_uring_sqe *sqe = NULL;
         struct io_uring_cqe *cqe = NULL;
         void *wdb,*rdb;
         char wmb[META_LEN], rmb[META_LEN];
         char *data_str = "data buffer";
         char *meta_str = "meta";
         int fd, ret, blksize;
         struct stat fstat;
         unsigned long long offset = 0;

         if (argc != 2) {
                 fprintf(stderr, "Usage: %s <block-device>", argv[0]);
                 return 1;
         };

         if (stat(argv[1], &fstat) == 0) {
                 blksize = (int)fstat.st_blksize;
         } else {
                 perror("stat");
                 return 1;
         }

         if (posix_memalign(&wdb, blksize, DATA_LEN)) {
                 perror("posix_memalign failed");
                 return 1;
         }
         if (posix_memalign(&rdb, blksize, DATA_LEN)) {
                 perror("posix_memalign failed");
                 return 1;
         }

         strcpy(wdb, data_str);
         strcpy(wmb, meta_str);

         fd = open(argv[1], O_RDWR | O_DIRECT);
         if (fd < 0) {
                 printf("Error in opening device\n");
                 return 0;
         }

         ret = io_uring_queue_init(8, &ring, 0);
         if (ret) {
                 fprintf(stderr, "ring setup failed: %d\n", ret);
                 return 1;
         }

         /* write data + meta-buffer to device */
         sqe = io_uring_get_sqe(&ring);
         if (!sqe) {
                 fprintf(stderr, "get sqe failed\n");
                 return 1;
         }

         io_uring_prep_write(sqe, fd, wdb, DATA_LEN, offset);
         sqe->opcode = IORING_OP_WRITE_META;
         sqe->meta_addr = (__u64)wmb;
         sqe->meta_len = META_LEN;
         /*
          * TBD: Flags to ask for guard/apptag/reftag checks
          * sqe->rw_flags = RWF_CHK_GUARD | RWF_CHK_APPTAG | RWF_CHK_REFTAG;
          */
         ret = io_uring_submit(&ring);
         if (ret <= 0) {
                 fprintf(stderr, "sqe submit failed: %d\n", ret);
                 return 1;
         }

         ret = io_uring_wait_cqe(&ring, &cqe);
         if (!cqe) {
                 fprintf(stderr, "cqe is NULL :%d\n", ret);
                 return 1;
         }
         if (cqe->res < 0) {
                 fprintf(stderr, "write cqe failure: %d", cqe->res);
                 return 1;
         }

         io_uring_cqe_seen(&ring, cqe);

         /* read dat + meta-buffer back from device */
         sqe = io_uring_get_sqe(&ring);
         if (!sqe) {
                 fprintf(stderr, "get sqe failed\n");
                 return 1;
         }

         io_uring_prep_read(sqe, fd, rdb, DATA_LEN, offset);
         sqe->opcode = IORING_OP_READ_META;
         sqe->meta_addr = (__u64)rmb;
         sqe->meta_len = META_LEN;

         ret = io_uring_submit(&ring);
         if (ret <= 0) {
                 fprintf(stderr, "sqe submit failed: %d\n", ret);
                 return 1;
         }

         ret = io_uring_wait_cqe(&ring, &cqe);
         if (!cqe) {
                 fprintf(stderr, "cqe is NULL :%d\n", ret);
                 return 1;
         }

         if (cqe->res < 0) {
                 fprintf(stderr, "read cqe failure: %d", cqe->res);
                 return 1;
         }
         io_uring_cqe_seen(&ring, cqe);

         if (strncmp(wmb, rmb, META_LEN))
                 printf("Failure: meta mismatch!, wmb=%s, rmb=%s\n", 
wmb, rmb);

         if (strncmp(wdb, rdb, DATA_LEN))
                 printf("Failure: data mismatch!\n");

         io_uring_queue_exit(&ring);
         free(rdb);
         free(wdb);
         return 0;
}

