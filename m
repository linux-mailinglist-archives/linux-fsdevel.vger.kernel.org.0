Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB11F5DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 23:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgFJVwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 17:52:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45621 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgFJVwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:52:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id n23so1561442pgb.12;
        Wed, 10 Jun 2020 14:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRf6W4oVEmwpsh0h+K1sCW7NaH3bq1FpwEBiNryS1Wo=;
        b=GVfmeToqAO9SEml7j9bByOpsYVyCsxug/bX6H9XLG7OC9NfuH5pjGiWLQEEZzTAsHM
         d7EpWSbJn/Qp+6FxhUkJQJFl6QYtMS/bpQEEfnihJR6WZlA/Yr5GZzXUcRKEgvsBTh3P
         pV6BYcZvb3atDdRmAqUaYlsLORSlWiJKVee239z+S7WD+KXNJaDxtw2j1uR7VPhNE5qr
         deNri2wUB9Ki+IZ9rUw0l1UUYyqaW3G1Giu6nx3HjuzSO5axDQIUbvvLaNXpBfTv7iTT
         /5eDvDQK7zHhjci9nk8KKZZnvOKIGC9XXKrky4lC+yGy3S9/Im0tyrobF0nx54nSP5J7
         JCTA==
X-Gm-Message-State: AOAM530EWaOzgQw5VdHOft0Yf0VERYq+euCqLCQV1dH+ZrcbR92iwMX7
        CLlaCKtU8S9M6uU6Z1w3ank=
X-Google-Smtp-Source: ABdhPJy992mUv5U8bhwojNTbIZ80dvsxUMVUFbzemXqKRntKpx7DGKHGnQxvq9NILxqv4J2ZE+scdw==
X-Received: by 2002:a63:4d5a:: with SMTP id n26mr4421932pgl.85.1591825936625;
        Wed, 10 Jun 2020 14:52:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n69sm854031pfd.171.2020.06.10.14.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:52:14 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 038B5403AB; Wed, 10 Jun 2020 21:52:13 +0000 (UTC)
Date:   Wed, 10 Jun 2020 21:52:13 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200610215213.GH13911@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
 <20200609173218.GA7968@infradead.org>
 <20200609175359.GR11244@42.do-not-panic.com>
 <20200610064234.GB24975@infradead.org>
 <20200610210917.GH11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610210917.GH11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So, upon updating the commit log, and moving the empty directory check
into another patch, I realized we might be able to simplify this now even
further still. Patch below. The key of the issue was that the use after free
happens when a recursive removal happens, and then later a specific
dentry removal happens. This happened for make_request block drivers
when using the whole disk, but since we *don't* have any other users of
the directory for the others cases, this in theory shuld not happen for
them either.

I'll try to shoot some bullets at this.

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7ff2ea5cd05e..5cea04c05e09 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -524,10 +524,16 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-	ret = -ENOENT;
-
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
+	/*
+	 * When tracing whole make_request drivers (multiqueue) block devices,
+	 * reuse the existing debugfs directory created by the block layer on
+	 * init. For request-based block devices, all partitions block devices,
+	 * and scsi-generic block devices we create a temporary new debugfs
+	 * directory that will be removed once the trace ends.
+	 */
+	if (queue_is_mq(q))
+		dir = q->debugfs_dir;
+	else
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
 	bt->dev = dev;
@@ -565,8 +571,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
