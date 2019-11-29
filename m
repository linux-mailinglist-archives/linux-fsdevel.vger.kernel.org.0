Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD510D0A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 04:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK2DfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 22:35:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39756 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfK2DfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 22:35:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so6658248wmh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 19:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QJ0BehjFJkWJyP8RtCONd9xszCsERb/O9WmeExTQd5k=;
        b=QfkEgP0LSNnXnXJcK7sI02htl820DB5bfsY47OwRNyzmGbQX/PzK/FxsZx3bI28akq
         LeDtDTO+1gBXwVGMvLEnATIxv7qa7CjbeB0ls0dcWEM78aKuIiAPgr2fcnEL7efCNIgQ
         KsbuiUjKC4h/6cCfw7Y+LWD+RHGWQS35wN2Dlb/F+3qx7SbAInmdwnRtQgCF33LeVFby
         RmHDDK6gVQpiZb+mqxjyG4hYbCTcncu3C3OlFxGou2TT8n/6sBG6aWB0dsQ5+iMuy8Jo
         Sa924LLfQY3/gWJ5RWOzAjTBjsgu5fS7Ti1KvcBpxmvI6r8ackcKQW+IabakzoOM3mZx
         ZSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QJ0BehjFJkWJyP8RtCONd9xszCsERb/O9WmeExTQd5k=;
        b=bM4/kbdVnuTc1E6/6aNdILgscpMnHnE7CnhYpLEzbkfIYLxQ7lcL1gkeGwcLgLDfdW
         t/uAyiWYJC+GfflFMUXFrsNomsPbBKLpgXmWtAJAILpBS/O30ftSlXPx/Ssmg/EpBWRv
         yRx8cWHgz9ybSe7nKbhId9xJPGO1fntAVUILrdFQMSc6myfxm6B4AgE2RShdtIBs5dfo
         l6qdDAYRe5icadz6B9VALD3ww9idJkx7sI04De7ClRG1kOdYSEJbO9/BCjjV8k/L76sQ
         uoSJPVSZmF7LH8d6P41vG+9d1oEyuQrgnhnXhJNcFkHwBFBkl9kvLOup8IeOMXdSnjoK
         EocA==
X-Gm-Message-State: APjAAAX6nm6hHbTkQOV5AGcOMYrVmtColyPcw/y/0SXJRd+TPWpN3tHm
        qlN69uw+pzntoGR4g1mbxaJiAw==
X-Google-Smtp-Source: APXvYqyY5Ag9efnLxT+G22Uef6sbiZvKYbuON7L6+paT+DCwuPK/MrDIWZduK2bBn25khLS06VtYyA==
X-Received: by 2002:a1c:3941:: with SMTP id g62mr11971950wma.165.1574998517292;
        Thu, 28 Nov 2019 19:35:17 -0800 (PST)
Received: from localhost (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id x9sm25131773wru.32.2019.11.28.19.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 19:35:16 -0800 (PST)
Date:   Fri, 29 Nov 2019 04:35:15 +0100
From:   Javier Gonzalez <javier@javigon.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] f2fs: Fix direct IO handling
Message-ID: <20191129033515.ehkdf65toblntkrq@MacBook-Pro.gnusmas>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.11.2019 15:44, Jaegeuk Kim wrote:
>On 11/26, Damien Le Moal wrote:
>> f2fs_preallocate_blocks() identifies direct IOs using the IOCB_DIRECT
>> flag for a kiocb structure. However, the file system direct IO handler
>> function f2fs_direct_IO() may have decided that a direct IO has to be
>> exececuted as a buffered IO using the function f2fs_force_buffered_io().
>> This is the case for instance for volumes including zoned block device
>> and for unaligned write IOs with LFS mode enabled.
>>
>> These 2 different methods of identifying direct IOs can result in
>> inconsistencies generating stale data access for direct reads after a
>> direct IO write that is treated as a buffered write. Fix this
>> inconsistency by combining the IOCB_DIRECT flag test with the result
>> of f2fs_force_buffered_io().
>>
>> Reported-by: Javier Gonzalez <javier@javigon.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  fs/f2fs/data.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 5755e897a5f0..8ac2d3b70022 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>  	int flag;
>>  	int err = 0;
>>  	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>> +	bool do_direct_io = direct_io &&
>> +		!f2fs_force_buffered_io(inode, iocb, from);
>>
>>  	/* convert inline data for Direct I/O*/
>>  	if (direct_io) {
>> @@ -1081,7 +1083,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>  			return err;
>>  	}
>>
>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>> +	if (do_direct_io && allow_outplace_dio(inode, iocb, from))
>
>It seems f2fs_force_buffered_io() includes allow_outplace_dio().
>
>How about this?
>---
> fs/f2fs/data.c | 13 -------------
> fs/f2fs/file.c | 35 +++++++++++++++++++++++++----------
> 2 files changed, 25 insertions(+), 23 deletions(-)
>
>diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>index a034cd0ce021..fc40a72f7827 100644
>--- a/fs/f2fs/data.c
>+++ b/fs/f2fs/data.c
>@@ -1180,19 +1180,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
> 	int err = 0;
> 	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>
>-	/* convert inline data for Direct I/O*/
>-	if (direct_io) {
>-		err = f2fs_convert_inline_inode(inode);
>-		if (err)
>-			return err;
>-	}
>-
>-	if (direct_io && allow_outplace_dio(inode, iocb, from))
>-		return 0;
>-
>-	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>-		return 0;
>-
> 	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
> 	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
> 	if (map.m_len > map.m_lblk)
>diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>index c0560d62dbee..6b32ac6c3382 100644
>--- a/fs/f2fs/file.c
>+++ b/fs/f2fs/file.c
>@@ -3386,18 +3386,33 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 				ret = -EAGAIN;
> 				goto out;
> 			}
>-		} else {
>-			preallocated = true;
>-			target_size = iocb->ki_pos + iov_iter_count(from);
>+			goto write;
>+		}
>
>-			err = f2fs_preallocate_blocks(iocb, from);
>-			if (err) {
>-				clear_inode_flag(inode, FI_NO_PREALLOC);
>-				inode_unlock(inode);
>-				ret = err;
>-				goto out;
>-			}
>+		if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>+			goto write;
>+
>+		if (iocb->ki_flags & IOCB_DIRECT) {
>+			/* convert inline data for Direct I/O*/
>+			err = f2fs_convert_inline_inode(inode);
>+			if (err)
>+				goto out_err;
>+
>+			if (!f2fs_force_buffered_io(inode, iocb, from))
>+				goto write;
>+		}
>+		preallocated = true;
>+		target_size = iocb->ki_pos + iov_iter_count(from);
>+
>+		err = f2fs_preallocate_blocks(iocb, from);
>+		if (err) {
>+out_err:
>+			clear_inode_flag(inode, FI_NO_PREALLOC);
>+			inode_unlock(inode);
>+			ret = err;
>+			goto out;
> 		}
>+write:
> 		ret = __generic_file_write_iter(iocb, from);
> 		clear_inode_flag(inode, FI_NO_PREALLOC);
>
>-- 
>2.19.0.605.g01d371f741-goog
>
This also addresses the original problem.

Tested-by: Javier González <javier@javigon.com>
