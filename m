Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E15BCA9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiISLY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiISLYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:24:47 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096C5B7FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 04:24:43 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 23218205158B;
        Mon, 19 Sep 2022 20:24:42 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 28JBOeA7126227
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 20:24:41 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 28JBOeMc380227
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 20:24:40 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 28JBOeQp380226;
        Mon, 19 Sep 2022 20:24:40 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
In-Reply-To: <20220919080717.mgn2noszguledsfn@wittgenstein> (Christian
        Brauner's message of "Mon, 19 Sep 2022 10:07:17 +0200")
References: <20220909093019.936863-1-brauner@kernel.org>
        <87czc4rhng.fsf@mail.parknet.co.jp>
        <20220909102656.pqlipjit2zlp4vdx@wittgenstein>
        <878rmsralz.fsf@mail.parknet.co.jp>
        <20220919080717.mgn2noszguledsfn@wittgenstein>
Date:   Mon, 19 Sep 2022 20:24:40 +0900
Message-ID: <87h713haiv.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Sep 09, 2022 at 09:33:12PM +0900, OGAWA Hirofumi wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>> 
>> Ah, I was expecting almost all convert patches goes at once via you or
>> vfs git.  However, if you want this goes via me, please let me know.
>
> The patch is standalone which is why it would be great if you could just
> take it. :)

Ok, Please queuing this patch, akpm.
Thanks.


From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] fat: port to vfs{g,u}id_t and associated helpers

A while ago we introduced a dedicated vfs{g,u}id_t type in commit
1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
over a good part of the VFS. Ultimately we will remove all legacy
idmapped mount helpers that operate only on k{g,u}id_t in favor of the
new type safe helpers that operate on vfs{g,u}id_t.

Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/fat/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 3e4eb3467cb4..8a6b493b5b5f 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -461,8 +461,9 @@ static int fat_allow_set_time(struct user_namespace *mnt_userns,
 {
 	umode_t allow_utime = sbi->options.allow_utime;
 
-	if (!uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
-		if (in_group_p(i_gid_into_mnt(mnt_userns, inode)))
+	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
+			    current_fsuid())) {
+		if (vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)))
 			allow_utime >>= 3;
 		if (allow_utime & MAY_WRITE)
 			return 1;

base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
-- 

2.34.1
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
