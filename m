Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4B59B65C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiHUUry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiHUUrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:47:53 -0400
X-Greylist: delayed 166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Aug 2022 13:47:51 PDT
Received: from p3plwbeout27-05.prod.phx3.secureserver.net (p3plsmtp27-05-2.prod.phx3.secureserver.net [216.69.139.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1390C20BE4
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Aug 2022 13:47:50 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id ProboEfJTcJUJProcoSTLo; Sun, 21 Aug 2022 13:45:02 -0700
X-CMAE-Analysis: v=2.4 cv=MIylJOVl c=1 sm=1 tr=0 ts=6302994f
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=biHskzXt2R4A:10 a=lZFbU4aQAAAA:8 a=LdWFK9ksAAAA:20
 a=-XaZqyIsTfI_AlyWR7QA:9 a=yKZbCDypxrTF-tGext6c:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  ProboEfJTcJUJ
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oProa-0001kp-Pc; Sun, 21 Aug 2022 21:45:01 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     lists@colorremedies.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: 6.0-rc1 BUG squashfs_decompress, and sleeping function called from invalid context at include/linux/sched/mm.h
Date:   Sun, 21 Aug 2022 21:44:16 +0100
Message-Id: <20220821204416.22346-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <73ea63fe-0c8e-412b-9fb2-94c08933180a@www.fastmail.com>
References: <73ea63fe-0c8e-412b-9fb2-94c08933180a@www.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfDGz5n5pvFEQKfYiNOfbmtMEpAmcYAvCqEmKXZYbpRiDM0gWmKIxLLMM7x4V86gWd0vRF54QuDEBC2KC2zL0S3LGa0osRHRoxR0EM/6CjNIU7FuXc4q+
 IJPpNqy6ZXfRqCoByO9t0XWdddTHXEuOK3J1L8eWoYSL6qt7WoHqn91unTICS+fUG3ZhrlzRU0iSqcAzeaGDAVWAIK6VlSJThkw1zmyqzPXCTlNngnbHTti3
 i+8ULbk6EzgQZFZNNogmpw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/08/2022, Chris Murphy <lists@colorremedies.com> wrote:

>Seeing the following on every boot with kernel 6.0-rc1, when booting a Fedora Rawhide Live ISO with qemu-kvm. Full dmesg at:

>https://drive.google.com/file/d/15u38HZD9NSihIvz4P9M0W3dx6FZWq0MX/view?usp=sharing

My fault, it should be fixed with the following patch (untested).

I'll test and send the official patch out tomorrow.

Phillip

diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
index b23b780d8f42..48c988e3f5d2 100644
--- a/fs/squashfs/page_actor.c
+++ b/fs/squashfs/page_actor.c
@@ -68,20 +68,9 @@ static void *handle_next_page(struct squashfs_page_actor *actor)
 
 	if ((actor->next_page == actor->pages) ||
 			(actor->next_index != actor->page[actor->next_page]->index)) {
-		if (actor->alloc_buffer) {
-			void *tmp_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
-
-			if (tmp_buffer) {
-				actor->tmp_buffer = tmp_buffer;
-				actor->next_index++;
-				actor->returned_pages++;
-				return tmp_buffer;
-			}
-		}
-
 		actor->next_index++;
 		actor->returned_pages++;
-		return ERR_PTR(-ENOMEM);
+		return actor->alloc_buffer ? actor->tmp_buffer : ERR_PTR(-ENOMEM);
 	}
 
 	actor->next_index++;
@@ -96,11 +85,10 @@ static void *direct_first_page(struct squashfs_page_actor *actor)
 
 static void *direct_next_page(struct squashfs_page_actor *actor)
 {
-	if (actor->pageaddr)
+	if (actor->pageaddr) {
 		kunmap_local(actor->pageaddr);
-
-	kfree(actor->tmp_buffer);
-	actor->pageaddr = actor->tmp_buffer = NULL;
+		actor->pageaddr = NULL;
+	}
 
 	return handle_next_page(actor);
 }
@@ -121,6 +109,16 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_
 	if (actor == NULL)
 		return NULL;
 
+	if (msblk->decompressor->alloc_buffer) {
+		actor->tmp_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+		if (actor->tmp_buffer == NULL) {
+			kfree(actor);
+			return NULL;
+		}
+	} else
+		actor->tmp_buffer = NULL;
+
 	actor->length = length ? : pages * PAGE_SIZE;
 	actor->page = page;
 	actor->pages = pages;
@@ -128,7 +126,6 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_
 	actor->returned_pages = 0;
 	actor->next_index = page[0]->index & ~((1 << (msblk->block_log - PAGE_SHIFT)) - 1);
 	actor->pageaddr = NULL;
-	actor->tmp_buffer = NULL;
 	actor->alloc_buffer = msblk->decompressor->alloc_buffer;
 	actor->squashfs_first_page = direct_first_page;
 	actor->squashfs_next_page = direct_next_page;
-- 
2.35.1

