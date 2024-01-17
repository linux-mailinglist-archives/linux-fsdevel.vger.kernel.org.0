Return-Path: <linux-fsdevel+bounces-8161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5B8307C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0735CB24622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEBB208DC;
	Wed, 17 Jan 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk237/De"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63C208CE;
	Wed, 17 Jan 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500921; cv=none; b=M4mBlGovR1XlXHdNoquQnrVbxzZY4agJ6dhhRTRnsP0TPRmiMa/PSy4gT1Io/f5QGlIfrTI8xV2DGnLMyfIMAt/y2SaV17sxTRYN/6lB9nfgPm1NOxIBQVDQEtHaa3fGohUti7EQDJQHebys0pueZru1qsA65dM00FdFGe4m+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500921; c=relaxed/simple;
	bh=229ybtn/v1Wt84mslOwyNQIKkgzmnFSc5CFrNq2VHZ8=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:Received:In-Reply-To:
	 References:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type; b=iFZoj9IvZfXcs6XzzxMxV3Jf5b0ofFp02brvrJZ40zYMWcQcMbv1DHFhYDPyxKWT9H0wzUF99gOjO2bbDOzxUjpLiupzzymBSi3t924+55F2ePE7zpsM84Yd8PsHAy1nzZWP18ixmIW22j97tBmMHdxiMP+uFH8b8gYOUM0oePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk237/De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F1AC43390;
	Wed, 17 Jan 2024 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705500921;
	bh=229ybtn/v1Wt84mslOwyNQIKkgzmnFSc5CFrNq2VHZ8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Hk237/DellnsMfrJJ6LaHk6w5kkpEvxaPtVISmCQN9ul2k9NR/lWKXKAtvL6iILUF
	 X/F2NLrBH3e6eg1lMfRQznAwDZBzRa5y2ra/8RloZtUlOXdmsXSpAyHmPnfHy61Pew
	 TZNAKS6bil6z5uWa2VXqvn1hz8Ee52r56lzGRexLg2W9xLKaUNAeaXOMdaO9LTd/DW
	 lzhiHzQaap+1ap4yjaWzj94SXXI8rJOUzgTJVV3ZaOmNxbuJ2Qh8qFhx0gsJcSG3Vq
	 cNgMI6CFGdr1mBgWqp9nG/cVLkRzWzx267k2uZOPWRz8ILY1DQvYY6otgckxHz06Fi
	 JtCBN9rnzdM8Q==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5989407dd3cso2540349eaf.0;
        Wed, 17 Jan 2024 06:15:21 -0800 (PST)
X-Gm-Message-State: AOJu0YyPZHUPChQYPmLb0EdY2/iZ2v8F5YVA8XvcK1hzJkKH+UszTsqu
	KpwN8vKJFmVALJLzFK0/vr32+kp1itf+5gfiZO4=
X-Google-Smtp-Source: AGHT+IE7AVmkwh0NXjqx9lmuZkG025/vZj/hZ/goyW474Yc3KV8u36zO8NX39rtxQ4OfhdugHijiPNB+ButxPlzzjIo=
X-Received: by 2002:a05:6820:1ac1:b0:595:5276:5b1 with SMTP id
 bu1-20020a0568201ac100b00595527605b1mr4637077oob.19.1705500920304; Wed, 17
 Jan 2024 06:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6696:0:b0:513:8ad5:8346 with HTTP; Wed, 17 Jan 2024
 06:15:19 -0800 (PST)
In-Reply-To: <00000000000007728e060f127eaf@google.com>
References: <00000000000007728e060f127eaf@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 17 Jan 2024 23:15:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9NotSbDTrShmh_+rU1cFF=xHLCssPb7NP=CHc4PdVQog@mail.gmail.com>
Message-ID: <CAKYAXd9NotSbDTrShmh_+rU1cFF=xHLCssPb7NP=CHc4PdVQog@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
To: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

2024-01-17 1:19 GMT+09:00, syzbot
<syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>:
> Hello,
Hi,
>
> syzbot found the following issue on:
>
> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of
> git://git.ke..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=108ca8b3e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1558210be80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d39debe80000

Thanks for your report!
Can you test if this change fix this issue ?

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 522edcbb2ce4..65ac7b67c2da 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -501,7 +501,7 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb,
struct iov_iter *iter)
 	struct inode *inode = mapping->host;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	loff_t pos = iocb->ki_pos;
-	loff_t size = iocb->ki_pos + iov_iter_count(iter);
+	loff_t size = pos + iov_iter_count(iter);
 	int rw = iov_iter_rw(iter);
 	ssize_t ret;

@@ -525,11 +525,9 @@ static ssize_t exfat_direct_IO(struct kiocb
*iocb, struct iov_iter *iter)
 	 */
 	ret = blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
 	if (ret < 0) {
-		if (rw == WRITE)
+		if (rw == WRITE && ret != -EIOCBQUEUED)
 			exfat_write_failed(mapping, size);
-
-		if (ret != -EIOCBQUEUED)
-			return ret;
+		return ret;
 	} else
 		size = pos + ret;

-- 
2.25.1

