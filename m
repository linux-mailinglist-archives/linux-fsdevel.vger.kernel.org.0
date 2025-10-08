Return-Path: <linux-fsdevel+bounces-63581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D83CFBC4896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A80F04EB9FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A52F49F0;
	Wed,  8 Oct 2025 11:22:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED2224B09
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922536; cv=none; b=Kdy5DfNOFn3usZqkzucjNyd/Kpe8yqwxkwSqz1/1vmhlwJ81/lg7HRZYI/mkTDH5/aOcOlqpFabjgdANFdNJ59JtbQt9ywty3i0/CZ2WD2Xy+rP9UuwGYwJ2SIORAm7tbXqyULjogVNSvQ/E7ZK2toqFf+wAZwWeVcRzihoN1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922536; c=relaxed/simple;
	bh=glsf2hgk7VrLBPq7g/Y8F1E+T2MBIhu5S0mfIC4m5pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d92eLXCh+tT/blkOk3YyKgAR5c83CUvUHUijZFYsBgr2CbVIe/TcH+ws42qVnmrxW+gESi3IvgMeYKJwGgDrQMJnOEO139p/v8SaTK8JrzzXCmjM+DGJjXOq6V9YEhNFbv3wBIQFMZzmIYaSD2lUO11qg4W/MzZWujSum/JuA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 598BLvFW094461;
	Wed, 8 Oct 2025 20:21:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 598BLv4B094456
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 8 Oct 2025 20:21:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp>
Date: Wed, 8 Oct 2025 20:21:55 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: Verify inode mode when loading from disk
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
 <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/10/07 23:22, Viacheslav Dubeyko wrote:
>> @@ -558,9 +558,15 @@ int hfsplus_cat_read_inode(struct inode *inode,
>> struct hfs_find_data *fd)
>>  			inode->i_op =
>> &page_symlink_inode_operations;
>>  			inode_nohighmem(inode);
>>  			inode->i_mapping->a_ops = &hfsplus_aops;
>> -		} else {
>> +		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode-
>>> i_mode) ||
>> +			   S_ISFIFO(inode->i_mode) ||
>> S_ISSOCK(inode->i_mode)) {
> 
> As far as I can see, we operate by inode->i_mode here. But if inode
> mode has been corrupted on disk, then we assigned wrong value before.
> And HFS+ has hfsplus_get_perms() method that assigns perms->mode to
> inode->i_mode. So, I think we need to rework hfsplus_get_perms() for
> checking the correctness of inode mode before assigning it to inode->
> i_mode.

Then, can you give us an authoritative explanation, with historical part
fully understood?



While we can change the return value of hfsplus_get_perms() from "void" to
"int", the intent of what hfsplus_get_perms() wants to accept is unclear.

Commit bc107a619f02 ("squashfs: verify inode mode when loading from disk") was
clear because there is a format specification explaining that the value of the
permission field must not contain file type.

But what hfsplus_get_perms() is doing is quite puzzling, possibly due to historical
reasons which I don't know. (I'm not a Mac user.)
https://developer.apple.com/library/archive/technotes/tn/tn1150.html#HFSPlusPermissions
has a bit of explanation about MacOS version dependent behavior which are more than 25
years ago. I don't know whether the historical part (case for 0 value intentionally
stored) and fuzz testings (cases for random values intentional stored) are compatible.
Maybe we should discard historical part if you want to rework hfsplus_get_perms() for
checking the correctness of inode mode...


When dir == 1 (i.e. hfs_bnode_read_u16() returned HFSPLUS_FOLDER),
the S_IFMT field is unconditionally set to S_IFDIR, for

  mode = mode ? (mode & S_IALLUGO) : (S_IRWXUGO & ~(sbi->umask))

always makes the S_IFMT field == 0 and therefore

  mode |= S_IFDIR;

always makes the S_IFMT field == S_IFDIR. But this means that the S_IFMT
field is set to S_IFDIR even if the S_IFMT field in "mode" is not S_IFDIR
(either 0 or some random values). What is the intent of this "ignore the
S_IFMT field" ? Were old MacOS versions writing to disk with the S_IFMT
field == 0 even if the created file was a directory? But how can we tell
whether the value is correct (legitimate 0 due to historical reason or
invalid some random values due to fuzz testing) ?

When dir == 0 (i.e. hfs_bnode_read_u16() returned HFSPLUS_FILE), the S_IFMT
field is set to S_IFREG only when file->permissions.mode == 0. That is, if
file->permissions.mode != 0, we are currently unconditionally trusting that
the S_IFMT field is set to one of S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/S_IFIFO/
S_IFSOCK. This allows fuzzers to assign random S_IFMT field values (including
S_IFDIR itself) when hfs_bnode_read_u16() returned HFSPLUS_FILE. But how can we
tell whether the value is correct (legitimate 0 due to historical reason or
invalid some random values due to fuzz testing) ?

My patch simply checks that the result of hfsplus_get_perms() is one of
S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/S_IFIFO/S_IFSOCK, by ignoring whether the
value is legitimate 0 or not.


Also, it seems that the HFS+ filesystem defines S_IFWHT file type which is not
supported by Linux. Commit 4e8011ffec79 ("ntfs3: pretend $Extend records as
regular files") decided to assign S_IFREG for irregular files where the file
type was previously 0, for operations such as read(), truncate() are not
possible even if S_IFREG is assigned. But when HFS+ filesystem is mounted in
Linux environment, what file type should we assign for HFS+ files which have
S_IFWHT file type? Can we simply return -EIO for S_IFWHT files?


