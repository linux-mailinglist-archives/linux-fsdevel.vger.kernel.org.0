Return-Path: <linux-fsdevel+bounces-56986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0683B1D83D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1826C170A0B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95A2550AD;
	Thu,  7 Aug 2025 12:49:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276B254AE4;
	Thu,  7 Aug 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570967; cv=none; b=lN7DyktE3E8aIQ6VTp8ILuRjnNjDELNxthFtwzy5iv0BNdyZ0IHTYrBfV54A3vPRO8AgxVYPWLcGNgNUrfFTw7apoHdOvItGDe/6ExghB2tJ+qfv9zY58l2j8NlpUhfmw0DC5ENpw5Rci8lqpSr3UYU6X7asEnlttA5OphCbOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570967; c=relaxed/simple;
	bh=udYbQBq4oTdJIHTWUSWuwtl5iRIbgNS8jwQDzABEPuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPH9/UCgK/b3LksfMARcySHs9pRAGqrbrzh4gDwIk/XHsj/MgY8hOGombK62zmtgtW+bgOcw4yqcaYf5q3dKLylnwZhbllv81AV8KsodGV8+1LYyqPo0d8L6S+7x19/L9Q/0Fz9jp6l8sI52vsEAEpa9qQwXwWF+hd+uYtmaIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.164])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ea3e602f;
	Thu, 7 Aug 2025 20:49:09 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: luis@igalia.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luochunsheng@ustc.edu,
	miklos@szeredi.hu,
	bernd@bsbernd.com
Subject: Re: [PATCH] fuse: Move same-superblock check to fuse_copy_file_range
Date: Thu,  7 Aug 2025 20:49:01 +0800
Message-ID: <20250807124909.781-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87bjorle20.fsf@wotan.olymp>
References: <87bjorle20.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98849403e603a2kunm31ed337a36832d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEsaVkoYT0xKQ0NPGE5OSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTU9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+

On Thu, Aug 07 2025,  Luis Henriques wrote:

>> The copy_file_range COPY_FILE_SPLICE capability allows filesystems to
>> handle cross-superblock copy. However, in the current fuse implementation,
>> __fuse_copy_file_range accesses src_file->private_data under the assumption
>> that it points to a fuse_file structure. When the source file belongs to a
>> non-FUSE filesystem, it will leads to kernel panics.
>
> I wonder if you have actually seen this kernel panic happening.  It seems
> like the code you're moving into fuse_copy_file_range() shouldn't be
> needed as the same check is already done in generic_copy_file_checks()
> (which is called from vfs_copy_file_range()).
> 
> Either way, I think your change to fuse_copy_file_range() could be
> simplified with something like:
> 
> 	ssize_t ret = -EXDEV;
> 
> 	if (file_inode(src_file)->i_sb == file_inode(dst_file)->i_sb)
> 		ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
> 					     len, flags);
> 
> 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
> 		ret = splice_copy_file_range(src_file, src_off, dst_file,
> 					     dst_off, len);
> 
> But again, my understanding is that this should never happen in practice
> and that the superblock check could even be removed from
> __fuse_copy_file_range().
> 
> Cheers,
> -- 
> Luís
>

Yes, now copy_file_range won't crash.

generic_copy_file_checks:
	/*
	 * We allow some filesystems to handle cross sb copy, but passing
	 * a file of the wrong filesystem type to filesystem driver can result
	 * in an attempt to dereference the wrong type of ->private_data, so
	 * avoid doing that until we really have a good reason.
	 *
	 * nfs and cifs define several different file_system_type structures
	 * and several different sets of file_operations, but they all end up
	 * using the same ->copy_file_range() function pointer.
	 */
	if (flags & COPY_FILE_SPLICE) {
		/* cross sb splice is allowed */
	} else if (file_out->f_op->copy_file_range) {
		if (file_in->f_op->copy_file_range !=
		    file_out->f_op->copy_file_range)
			return -EXDEV;
	} else if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb) {
		return -EXDEV;
	}

generic_copy_file_checks mentions that now allows some filesystems to handle cross-sb copy.

code: 
	} else if (file_out->f_op->copy_file_range) {
		if (file_in->f_op->copy_file_range !=
		    file_out->f_op->copy_file_range)
			return -EXDEV;
			
If the same filesystem is satisfied but the sb is not same, it will go to fuse_copy_file_range,
so fuse_copy_file_range needs to handle this situation.

Sorry, there is an mistake with my patch log description. __fuse_copy_file_range does not exist that
the source file is a NON-Fuse filesystem, so It can safely use ->private_data.

Therefore, this patch does not need.

Thanks
Chunsheng Luo

>>
>> To resolve this, move the same-superblock check from __fuse_copy_file_range
>> to fuse_copy_file_range to ensure both files belong to the same fuse
>> superblock before accessing private_data.
>>
>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
>> ---
>>  fs/fuse/file.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 95275a1e2f54..a29f1b84f11b 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -2984,9 +2984,6 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>>  	if (fc->no_copy_file_range)
>>  		return -EOPNOTSUPP;
>>  
>> -	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>> -		return -EXDEV;
>> -
>>  	inode_lock(inode_in);
>>  	err = fuse_writeback_range(inode_in, pos_in, pos_in + len - 1);
>>  	inode_unlock(inode_in);
>> @@ -3066,9 +3063,12 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
>>  {
>>  	ssize_t ret;
>>  
>> +	if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
>> +		return splice_copy_file_range(src_file, src_off, dst_file,
>> +					     dst_off, len);
>> +
>>  	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
>>  				     len, flags);
>> -
>>  	if (ret == -EOPNOTSUPP || ret == -EXDEV)
>>  		ret = splice_copy_file_range(src_file, src_off, dst_file,
>>  					     dst_off, len);
>> -- 
>> 2.43.0
>>

