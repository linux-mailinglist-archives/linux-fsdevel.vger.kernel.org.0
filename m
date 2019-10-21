Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A58DE7DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfJUJSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:18:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44436 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfJUJSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so7401881pgd.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NjpvV8uwr5CMxSHQQg16F2wD3z2WNwbI9Jh+TD4XnXY=;
        b=vEk6Puhf0YPo+yAGy4lqVJHbL+tKXJEEvZvEtTFBubOEZwsz5yx/yjBzdATqReIk+F
         OMEqpCFZsfZSbMI+aAeTWr9OwkffaOe/VxkUAs9IkfHVxHNCXiYef/H90ebe9fQxszW1
         2oAbngOddMhzSIiZlDhmNUL+qTVM2flr+GjOXRc+LeZav0DcGjwhW33+D98OWGPxLGj2
         HE/yhuERMsd7MGJ2vUIp8En0nN1driDlotlMdVaGBB9VHo3hZ+hif3kaLCH8nOaBm+Ik
         M5TMMW1RV/Do6DLc2b0ggSai0x7YjF4xw0WLnwTs84s4RWlR7jDjWhumahmSEiXOhRhQ
         a8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NjpvV8uwr5CMxSHQQg16F2wD3z2WNwbI9Jh+TD4XnXY=;
        b=gchzV0a7XgFL6gI8nV0JmgqCbhdnWzXY2CK2MroWWRzcLzD+PpgQ60ZpF2lF2DDYQE
         tkyvrvp2PtLGZY4BRALc6SHRqart8/BVH7hvmO5McSX5a3YeSPMRfb5UHZrzINMrEe6u
         C1idhUbVFyKXzuxKOE4b6NVUd444J1ES+kB65LOhak/rw5SW7b9dQYzNjVGyBPCUrOH7
         IyLru6cIJ5nwqGgWCWM2TDpSBtV9ZPyh3Ibc2aqio0w7ORpp5zC+taMgLFA7PWO/Adpt
         ptow96LD1L5AqG86MzCLKGdlfva6vAtuOnoEIo4SPxBg57DVfJGLyeNZc0hOjj8Nhk++
         Ihhg==
X-Gm-Message-State: APjAAAWXvu4qemdwiq/inLucnvhjC9GR3+igjCgv7OhHbCdD+VgJfEpN
        aTmcKaXOQ2UoY9Tj6KYCWto+
X-Google-Smtp-Source: APXvYqwEFr/tpnDLFxiUVy6zHJBXdb2hzCZFChASd0HxRUn8LaueEWTrGobB/3Fp8IcRV0Lo8sp3fQ==
X-Received: by 2002:a62:b504:: with SMTP id y4mr12897974pfe.40.1571649532852;
        Mon, 21 Oct 2019 02:18:52 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id x72sm17185876pfc.89.2019.10.21.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:18:52 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:46 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 08/12] ext4: update direct I/O read to do trylock in
 IOCB_NOWAIT cases
Message-ID: <5ee370a435eb08fb14579c7c197b16e9fa0886f0.1571647179.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch updates the lock pattern in ext4_dio_read_iter() to only
perform the trylock in IOCB_NOWAIT cases.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6ea7e00e0204..8420686b90f5 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -52,7 +52,13 @@ static int ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	inode_lock_shared(inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
 	if (!ext4_dio_supported(inode)) {
 		inode_unlock_shared(inode);
 		/*
-- 
2.20.1

--<M>--
