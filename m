Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A153C7B3DC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjI3DZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjI3DZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:25:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50956DE
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:25:55 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4195035800fso45085151cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044354; x=1696649154; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVLzPp93pZABCVKyWP1mAbidMk3rqNAWBwutzFqeRLc=;
        b=Wat29+YZTArt1KnqMhTCNVL7ZA4PFGfHCqdKzpMyMpyPEdeg6ccdV/GdIf+HA2UiL7
         HmeUuKAG0A6BgXPCGnO5kGwvl4sPe2FB6hUQ1hBbjv/DFCq2NYVaOttw9yoBPcogRwve
         EqoevETcpUIb/IROeh2xIZWxa17qB8YAEa6Nypf6pRBMiytlHQW1ZzO65Ft+3mcBQO43
         zNn31fVk4efAdyin9tctGJSCBATWj2UyLAb9e7f4TtXZUxfb1x3DHioQUnJehwtZZD33
         G6SRgtfq6lrMCOvg0tHcdNgeGvo+4jboinSCRi76IgPFkB6kOUd/TYRjPtQ61eKGeKN1
         xOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044354; x=1696649154;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVLzPp93pZABCVKyWP1mAbidMk3rqNAWBwutzFqeRLc=;
        b=JCr1XFV8R8OIBKe9HXsce3e/7MyCxC7PKXwDfBF9VwfO3jPP9pTamCo9nnZ3boIKbB
         SHxV6g0jctTefET/wHJXe6216arTbHtY7HneidF42J+cpr/hsF+8xkUdC+JjyDnacKk7
         sSksvOLWwRvWV1owqs8oJEUYCe+5VAicMKA7DmeSlrAhLC+gd+W0AAS/AO0/+zBqijY7
         fwrt5XWoxfBnnFCR3YAkEq9uyf7QbumSwyzCwB+z/T6OgorHskiLVFcoDK9H/I1vKn+a
         eWfVYJGnhYyv7qMPaOMxqryWSEYqovIgqA3HCH1x5PFvFlbEIdiF80H2FQ/E3OGc255O
         CGPA==
X-Gm-Message-State: AOJu0YyMAIZIuOMU4Z/y+vYZBGtg0CxZ3TexqX1gvXwInZq1HYvNP3l6
        XBcu0n+XdRqs9JKSX9xcRmDMeQ==
X-Google-Smtp-Source: AGHT+IHhuq7jvvojYgsSWl2axsjTICJmxo+Endia0QYqZtTKEsh/ozvTbnorz5ewJjnAk71pgSQv9w==
X-Received: by 2002:a05:620a:1a1d:b0:773:eb81:d043 with SMTP id bk29-20020a05620a1a1d00b00773eb81d043mr6501303qkb.52.1696044354298;
        Fri, 29 Sep 2023 20:25:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o7-20020a257307000000b00d43697c429esm5462075ybc.50.2023.09.29.20.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:25:53 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:25:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/8] shmem: shrink shmem_inode_info: dir_offsets in a union
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <86ebb4b-c571-b9e8-27f5-cb82ec50357e@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shave 32 bytes off (the 64-bit) shmem_inode_info.  There was a 4-byte
pahole after stop_eviction, better filled by fsflags.  And the 24-byte
dir_offsets can only be used by directories, whereas shrinklist and
swaplist only by shmem_mapping() inodes (regular files or long symlinks):
so put those into a union.  No change in mm/shmem.c is required for this.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/shmem_fs.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6b0c626620f5..2caa6b86106a 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -23,18 +23,22 @@ struct shmem_inode_info {
 	unsigned long		flags;
 	unsigned long		alloced;	/* data pages alloced to file */
 	unsigned long		swapped;	/* subtotal assigned to swap */
-	pgoff_t			fallocend;	/* highest fallocate endindex */
-	struct list_head        shrinklist;     /* shrinkable hpage inodes */
-	struct list_head	swaplist;	/* chain of maybes on swap */
+	union {
+	    struct offset_ctx	dir_offsets;	/* stable directory offsets */
+	    struct {
+		struct list_head shrinklist;	/* shrinkable hpage inodes */
+		struct list_head swaplist;	/* chain of maybes on swap */
+	    };
+	};
+	struct timespec64	i_crtime;	/* file creation time */
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
+	pgoff_t			fallocend;	/* highest fallocate endindex */
+	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
 	atomic_t		stop_eviction;	/* hold when working on inode */
-	struct timespec64	i_crtime;	/* file creation time */
-	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
 #ifdef CONFIG_TMPFS_QUOTA
 	struct dquot		*i_dquot[MAXQUOTAS];
 #endif
-	struct offset_ctx	dir_offsets;	/* stable entry offsets */
 	struct inode		vfs_inode;
 };
 
-- 
2.35.3

