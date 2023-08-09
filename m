Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC337751FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHIEfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHIEfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:35:06 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1941FDF
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 21:34:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d593a63e249so1891091276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 21:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691555697; x=1692160497;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTcwtqovj/n/LD3Icai5ShB8o9Zi6NmsgjgaBMH67ps=;
        b=vAzcYUsbMguHrchC9hn1CB5osMk/5YiGsgK2RYGkiVTG6y4+Y3oMgkq6hSzJnCK0io
         3Ip0koO49LOYhVedkmqMZB+RDZkLYAOLd2zPtQ4qwtftMWaGwkQQudBVKheQz+SLQaal
         ZsXqL1XPhXf09s7c2NmiwIIKjqFMqYoaOqVBJXWEdX/pg2dDzHCG+bKLqIJA6U7Q3MVN
         36liji+AHJWyLgr5x93GFh/6fl9PwkPArG8a5guP4Pz0Xkfg5yptXlr6sZyAaDLJECM7
         l0E2bsZWY4rLln97xOdUzijmTFxcPPrakoc/PcuKyj0ZZysgXgTO+H1G4WoQDiTqJQCF
         SG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555697; x=1692160497;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTcwtqovj/n/LD3Icai5ShB8o9Zi6NmsgjgaBMH67ps=;
        b=eSB0GI0xOAde3IznGEzWiEtEpDdhHaF97jlAzfmGap6zoNnlQb1HkMbFA1+KTBiPRB
         grKSwXuBVDRyNEh+EhM1eij0Q8sLL3+zvRazhIuykTuG/qUAFUatRDsTSq56e4RiocI6
         MCOaqwJm+9CnuD5KdFlTEKnMx+wHqmpsdh3XZwoKEOnEjavKy/li7PLcwFW3Zjg1wUS9
         MkkrVjIM5e2JaFzWoIOO6RfzoItYbkcRHjiDWj448XuBadLr2FZdkDwblDJAkLz1oiOO
         NXe4+S6x5OdkxCQDy+SlDTBPq9aF6W2HvptKK4A0G/dlJdztwQgtCqm/dJ0XDwWn9+Ax
         B2DA==
X-Gm-Message-State: AOJu0YyoODERWyuy3QVOud8B+K+L49XL8Y4c+Z+Mf2XR7LxbDVG1c5O4
        cSVIloNW0SOsFli8Iz6A6cX7lA==
X-Google-Smtp-Source: AGHT+IHKKV4hQ5vytluAdPVMcaWjO0NzAaMwo9dYu1hyneZrdnCvcm251k5acja++/q3pN0aSKgfDA==
X-Received: by 2002:a0d:e811:0:b0:576:d65d:2802 with SMTP id r17-20020a0de811000000b00576d65d2802mr1729866ywe.3.1691555697390;
        Tue, 08 Aug 2023 21:34:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y139-20020a0dd691000000b00570589c5aedsm3785800ywd.7.2023.08.08.21.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 21:34:57 -0700 (PDT)
Date:   Tue, 8 Aug 2023 21:34:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs 4/5] tmpfs: trivial support for direct IO
In-Reply-To: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
Message-ID: <7c12819-9b94-d56-ff88-35623aa34180@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Depending upon your philosophical viewpoint, either tmpfs always does
direct IO, or it cannot ever do direct IO; but whichever, if tmpfs is to
stand in for a more sophisticated filesystem, it can be helpful for tmpfs
to support O_DIRECT.  So, give tmpfs a shmem_direct_IO() method, of the
simplest kind: by just returning 0 done, it leaves all the work to the
buffered fallback (and everything else just happens to work out okay -
in particular, its dirty pages don't get lost to invalidation).

xfstests auto generic which were not run on tmpfs before but now pass:
036 091 113 125 130 133 135 198 207 208 209 210 211 212 214 226 239 263
323 355 391 406 412 422 427 446 451 465 551 586 591 609 615 647 708 729
with no new failures.

LTP dio tests which were not run on tmpfs before but now pass:
dio01 through dio30, except for dio04 and dio10, which fail because
tmpfs dio read and write allow odd count: tmpfs could be made stricter,
but would that be an improvement?

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7420b510a9f3..4d5599e566df 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2720,6 +2720,16 @@ shmem_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
+static ssize_t shmem_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	/*
+	 * Just leave all the work to the buffered fallback.
+	 * Some LTP tests may expect us to enforce alignment restrictions,
+	 * but the fallback works just fine with any alignment, so allow it.
+	 */
+	return 0;
+}
+
 static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;
@@ -4421,6 +4431,7 @@ const struct address_space_operations shmem_aops = {
 #ifdef CONFIG_TMPFS
 	.write_begin	= shmem_write_begin,
 	.write_end	= shmem_write_end,
+	.direct_IO	= shmem_direct_IO,
 #endif
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	= migrate_folio,
-- 
2.35.3

