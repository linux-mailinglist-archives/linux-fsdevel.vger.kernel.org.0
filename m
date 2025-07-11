Return-Path: <linux-fsdevel+bounces-54619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41AB01AA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340935855AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F428C00E;
	Fri, 11 Jul 2025 11:36:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D68146585;
	Fri, 11 Jul 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233775; cv=none; b=nmSe9v/NEXTU4aL12ZoJO7u0B7ByiexI7kTf2kLtSM4JgYg7N/nG7dpISXREeDBG2VupAtvQTj7HqGHsR/zxWj7X47EKZr9r30k1MIK28G6ot3CKQd894xO1BTWo2Fo6sVqL639qUGeICOWaoWlj80WSoyPlxAmEdlnR0Dpl0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233775; c=relaxed/simple;
	bh=PkVmWijxIcb7J2bR8KJZd6f6Zt0pBeplT/ckojlUg+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lhQvwYjNePS5nBI2RZdv5t++ZhHjYog+XVn1v8Ta2bYjMDOZ8JkVHEXTlVcH6iHaf937MzPGZPh1GiPdI+mtWzQmfsASuIRpbNoH7GZnaDlUPedU6GqI7mikAW8FdAXzfXqeA+Z2wEzxHKBI6vNt/vQbZsRujTRfoOXaYThvSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56BBZiSV056479;
	Fri, 11 Jul 2025 20:35:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56BBZijP056476
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 11 Jul 2025 20:35:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <244c8da9-4c5e-42ed-99c7-ceee3e039a9c@I-love.SAKURA.ne.jp>
Date: Fri, 11 Jul 2025 20:35:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
 <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
 <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2025/07/10 7:03, Tetsuo Handa wrote:
> On 2025/07/10 3:33, Viacheslav Dubeyko wrote:
>> My worry that we could have a race condition here. Let's imagine that two
>> threads are trying to call __hfsplus_setxattr() and both will try to create the
>> Attributes File. Potentially, we could end in situation when inode could have
>> not zero size during hfsplus_create_attributes_file() in one thread because
>> another thread in the middle of Attributes File creation. Could we double check
>> that we don't have the race condition here? Otherwise, we need to make much
>> cleaner fix of this issue.
> 
> I think that there is some sort of race window, for
> https://elixir.bootlin.com/linux/v6.15.5/source/fs/hfsplus/xattr.c#L145
> explains that if more than one thread concurrently reached
> 
> 	if (!HFSPLUS_SB(inode->i_sb)->attr_tree) {
> 		err = hfsplus_create_attributes_file(inode->i_sb);
> 		if (unlikely(err))
> 			goto end_setxattr;
> 	}
> 
> path, all threads except one thread will fail with -EAGAIN.
> 

Do you prefer stricter mount-time validation shown below?
Is vhdr->attr_file.total_blocks == 0 when sbi->attr_tree exists and is empty?

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..f6324a0458f3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -482,13 +482,17 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto out_close_ext_tree;
 	}
 	atomic_set(&sbi->attr_tree_state, HFSPLUS_EMPTY_ATTR_TREE);
-	if (vhdr->attr_file.total_blocks != 0) {
-		sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
-		if (!sbi->attr_tree) {
-			pr_err("failed to load attributes file\n");
-			goto out_close_cat_tree;
+	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
+	if (sbi->attr_tree) {
+		if (vhdr->attr_file.total_blocks != 0) {
+			atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
+		} else {
+			pr_err("found attributes file despite total blocks is 0\n");
+			goto out_close_attr_tree;
 		}
-		atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
+	} else if (vhdr->attr_file.total_blocks != 0) {
+		pr_err("failed to load attributes file\n");
+		goto out_close_cat_tree;
 	}
 	sb->s_xattr = hfsplus_xattr_handlers;
 


