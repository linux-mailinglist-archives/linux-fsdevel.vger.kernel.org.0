Return-Path: <linux-fsdevel+bounces-63821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704ABCEBF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 01:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2E214E2AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23D27E7EC;
	Fri, 10 Oct 2025 23:19:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD94BA3F;
	Fri, 10 Oct 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138353; cv=none; b=UP41s1cyDuj+zINvZ+OeODeKbCA/ixLKu+h5v7AzQ8M/Wh+oupzkrhM5SF6vrHEySjFd6+SfdMG8vE/gFflPi5q0AU1j3eyodXwnvPUJ/8mYIqIX4dnpmwE6wFiU6sOMavHZ35SVfDBWMye13KqFejxdyo39a26Ezh2qzM4/3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138353; c=relaxed/simple;
	bh=XpAUF3CK+cqHUsynEWxOV3uIQoO0hyuPytYImFMAUHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFjIfISmcYHyPnzGQ8OpDPniL99jl3bnaHaTvagzU3ZszeHR+LyecV76uWUG0+gd1UEDs0mdusBycBAaGosbrq55iblVfMN3MI7Oq9PFhMEdUWCEeTghpbykm9vZu2wtvVYY4U/aSQ5lCCu9aky7CmAbt2fDqpxQEWTqinNb0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59ANJ6Ul072199;
	Sat, 11 Oct 2025 08:19:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59ANJ6q0072196
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 11 Oct 2025 08:19:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <340c759f-d102-4d46-b1f2-a797958a89e4@I-love.SAKURA.ne.jp>
Date: Sat, 11 Oct 2025 08:19:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
 <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
 <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

Thank you for responding quickly.

On 2025/10/11 1:06, Tigran Aivazian wrote:
> On Fri, 10 Oct 2025 at 16:44, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
>> Thank you, but logically this code should simply be inside the "else"
>> clause of the previous checks, which already check for BFS_VDIR and
>> BFS_VREG, I think.
> 
> Actually, I would first of all print the value of vtype, because that
> is where the
> corruption comes from, and print i_mode as %07o, not %04o. So, I would
> suggest a patch like this.

Changing what to print is fine. But

> Thank you, but logically this code should simply be inside the "else"
> clause of the previous checks, which already check for BFS_VDIR and
> BFS_VREG, I think.

the reason I didn't choose the "else" clause is that since inode->i_mode is
initially masked by 0x0000FFFF (which can make inode->i_mode & S_FMT != 0),

	inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);

setting the S_FMT bits like inode->i_mode |= S_IFDIR or
inode->i_mode |= S_IFREG can make bogus S_FMT values.

	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
		inode->i_mode |= S_IFDIR;
		inode->i_op = &bfs_dir_inops;
		inode->i_fop = &bfs_dir_operations;
	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG) {
		inode->i_mode |= S_IFREG;
		inode->i_op = &bfs_file_inops;
		inode->i_fop = &bfs_file_operations;
		inode->i_mapping->a_ops = &bfs_aops;
	}

If we do

-	inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
+	inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);

then we can choose the "else" clause but we can't catch invalid
file types when (0x0000F000 & le32_to_cpu(di->i_mode)) != 0.

If we do

-	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
-		inode->i_mode |= S_IFDIR;
+	if (le32_to_cpu(di->i_vtype) == BFS_VDIR && S_ISDIR(inode->i_mode)) {

-	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG) {
-		inode->i_mode |= S_IFREG;
+	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG && S_ISREG(inode->i_mode)) {

then we can choose the "else" clause but we can't accept
le32_to_cpu(di->i_vtype) == BFS_VDIR && (inode->i_mode & S_FMT) == 0 case and
le32_to_cpu(di->i_vtype) == BFS_VREG && (inode->i_mode & S_FMT) == 0 case.

I don't know whether (inode->i_mode & S_FMT) == 0 was historically valid in BFS
like HFS+ did ( https://lkml.kernel.org/r/d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp ).
If (inode->i_mode & S_FMT) == 0 was always invalid in BFS, we can choose the

-	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
-		inode->i_mode |= S_IFDIR;
+	if (le32_to_cpu(di->i_vtype) == BFS_VDIR && S_ISDIR(inode->i_mode)) {

-	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG) {
-		inode->i_mode |= S_IFREG;
+	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG && S_ISREG(inode->i_mode)) {

+       } else {
+               brelse(bh);
+               printf("Bad file type vtype=%u mode=0%07o %s:%08lx\n",
+                       le32_to_cpu(di->i_vtype), inode->i_mode, inode->i_sb->s_id, ino);
+               goto error;

approach.

Which pattern (just adding a new "if", or adding "else" with "if" and "else if" updated,
or replace the 0x0000FFFF mask with 0x00000FFF) do you prefer?


