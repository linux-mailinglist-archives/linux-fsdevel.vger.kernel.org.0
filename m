Return-Path: <linux-fsdevel+bounces-8534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E35838C38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670171F25FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6735C8E9;
	Tue, 23 Jan 2024 10:36:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B965C5FE;
	Tue, 23 Jan 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006217; cv=none; b=H63gukVfL//yMl7FaRIFoiYaqXDb7egxkbNp/OwNeXeGLdnwG8+fgu3/z+Pqx2aPjcWIe3in4o63DRUajiSCIudz038X1HSz2mc1+4wDJw/CVvqhYvtXKutMuIehFKKIMFJqGidHQ3++41kjlQUNcIXajTJruep0vP+feCgsiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006217; c=relaxed/simple;
	bh=OHMPBpMkRqRTtzuPUOHleKonJtQqLM0DT27ysBZkSiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeY1VQulZ8vsen1b+8Lj9LDXkN3YVY7PwleFMj9vNrTlYeaXTOc1UuFiikFik3ttlBxRr5ebfd2ZE3JHL/gadSDDZbdvPXiyznXC4p/bYQafjwQpiGbm+kTLLBbka4ugoV4gipmFDavwomG3aPEnprU3xGtnhwh6zraTFYE2XWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.CY5fk_1706006204;
Received: from 30.221.145.142(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.CY5fk_1706006204)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 18:36:45 +0800
Message-ID: <5ff0fceb-96aa-41b2-bee8-95cf393ac582@linux.alibaba.com>
Date: Tue, 23 Jan 2024 18:36:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: disable support for file handle when
 FUSE_EXPORT_SUPPORT not configured
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
 <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/24 6:17 PM, Amir Goldstein wrote:
> On Tue, Jan 23, 2024 at 11:37 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> I think this is more of an issue reporter.
>>
>> I'm not sure if it's a known issue, but we found that following a
>> successful name_to_handle_at(2), open_by_handle_at(2) fails (-ESTALE,
>> Stale file handle) with the given file handle when the fuse daemon is in
>> "cache= none" mode.
>>
>> It can be reproduced by the examples from the man page of
>> name_to_handle_at(2) and open_by_handle_at(2) [1], along with the
>> virtiofsd daemon (C implementation) in "cache= none" mode.
>>
>> ```
>> ./t_name_to_handle_at t_open_by_handle_at.c > /tmp/fh
>> ./t_open_by_handle_at < /tmp/fh
>> t_open_by_handle_at: open_by_handle_at: Stale file handle
>> ```
>>
>> After investigation into this issue, I found the root cause is that,
>> when virtiofsd is in "cache= none" mode, the entry_valid_timeout is
>> configured as 0.  Thus the dput() called when name_to_handle_at(2)
>> finishes will trigger iput -> evict(), in which FUSE_FORGET will be sent
>> to the daemon.  The following open_by_handle_at(2) will trigger a new
>> FUSE_LOOKUP request when no cached inode is found with the given file
>> handle.  And then the fuse daemon fails the FUSE_LOOKUP request with
>> -ENOENT as the cached metadata of the requested inode has already been
>> cleaned up among the previous FUSE_FORGET.
>>
>> This indeed confuses the application, as open_by_handle_at(2) fails in
>> the condition of the previous name_to_handle_at(2) succeeds, given the
>> requested file is not deleted and ready there.  It is acceptable for the
>> application folks to fail name_to_handle_at(2) early in this case, in
>> which they will fallback to open(2) to access files.
>>
>>
>> As for this RFC patch, the idea is that if the fuse daemon is configured
>> with "cache=none" mode, FUSE_EXPORT_SUPPORT should also be explicitly
>> disabled and the following name_to_handle_at(2) will all fail as a
>> workaround of this issue.
> 
> This will probably regress NFS export of (many) fuse servers that do
> not have FUSE_EXPORT_SUPPORT, even though you are right to point
> out that those NFS exports are of dubious quality.

Yeah, the RFC itself is just for describing the problem, while the final
fix (if any) needs further discussion.  We even add an extra optional
mount option, e.g "-o no_file_handle" to explicitly disable support for
file handle in our internal product.


> 
> Not only can an NFS client get ESTALE for evicted fuse inodes, but it
> can also get a completely different object for the same file handle
> if that fuse server was restarted and re-exported to NFS.
> 
>>
>> [1] https://man7.org/linux/man-pages/man2/open_by_handle_at.2.html
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/inode.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 2a6d44f91729..9fed63be60fe 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1025,6 +1025,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
>>  static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>>                            struct inode *parent)
>>  {
>> +       struct fuse_conn *fc = get_fuse_conn(inode);
>>         int len = parent ? 6 : 3;
>>         u64 nodeid;
>>         u32 generation;
>> @@ -1034,6 +1035,9 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>>                 return  FILEID_INVALID;
>>         }
>>
>> +       if (!fc->export_support)
>> +               return -EOPNOTSUPP;
>> +
>>         nodeid = get_fuse_inode(inode)->nodeid;
>>         generation = inode->i_generation;
>>
> 
> If you somehow find a way to mitigate the regression for NFS export of
> old fuse servers (maybe an opt-in Kconfig?), your patch is also going to
> regress AT_HANDLE_FID functionality, which can be used by fanotify to
> monitor fuse.
> 
> AT_HANDLE_FID flag to name_to_handle_at(2) means that
> open_by_handle_at(2) is not supposed to be called on that fh.
> 
> The correct way to deal with that would be something like this:
> 
> +static const struct export_operations fuse_fid_operations = {
> +       .encode_fh      = fuse_encode_fh,
> +};
> +
>  static const struct export_operations fuse_export_operations = {
>         .fh_to_dentry   = fuse_fh_to_dentry,
>         .fh_to_parent   = fuse_fh_to_parent,
> @@ -1529,12 +1533,16 @@ static void fuse_fill_attr_from_inode(struct
> fuse_attr *attr,
> 
>  static void fuse_sb_defaults(struct super_block *sb)
>  {
> +       struct fuse_mount *fm = get_fuse_mount_super(sb);
> +
>         sb->s_magic = FUSE_SUPER_MAGIC;
>         sb->s_op = &fuse_super_operations;
>         sb->s_xattr = fuse_xattr_handlers;
>         sb->s_maxbytes = MAX_LFS_FILESIZE;
>         sb->s_time_gran = 1;
> -       sb->s_export_op = &fuse_export_operations;
> +       if (fm->fc->export_support)
> +               sb->s_export_op = &fuse_export_operations;
> +       else
> +               sb->s_export_op = &fuse_fid_operations;
>         sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>         if (sb->s_user_ns != &init_user_ns)
>                 sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
> 
> ---
> 
> This would make name_to_handle_at() without AT_HANDLE_FID fail
> and name_to_handle_at() with AT_HANDLE_FID to succeed as it should.
> 
> Thanks,
> Amir.

-- 
Thanks,
Jingbo

