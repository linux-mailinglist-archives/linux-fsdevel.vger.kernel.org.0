Return-Path: <linux-fsdevel+bounces-60604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F90B49EA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 03:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44E81BC5320
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FF20102C;
	Tue,  9 Sep 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fb+JneoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47915A848;
	Tue,  9 Sep 2025 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381050; cv=none; b=l+5zAxHh9PHoDixS27Yleiq6E+qAIfRrG/g+fmpBwOBk0/eMVtoZY+vctYmLGuT1S840otg7yLLhIsi7RdkR+N/UNC3Aya7of6ILXdWSTC4o5T50dyySDypefsNu+/Q6VFqmHIaFD6PgEe76n4GdBDBorqtSR03x0yEugmJM770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381050; c=relaxed/simple;
	bh=9t2jjirqgihqXvU4UKP2Qi897S5wE8kf1WG1+WY/JJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UA6jS+7JhAMfpteIREWTuyUyPg0fj2Qc5EUOqAZcFDXSzXzxZWsrSXDKBeY6+E3osXGCo1q2JxiXNsJJlM6l8tXfxSmA/RzG5IORCKu1LG1CYlbo+yetDGfp7AZWljDGnDYtdTGOOP+PZm9Pkd93dO62plN4fwuZYWMlrcKVHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fb+JneoL; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757381039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zhR/uQdxVtluM9E+dpo+PTxBDDk8oslc9nOQJ4GqiME=;
	b=Fb+JneoLGkFqF7HXtsNbAGtn7XNJfh5jVBPDkWYJPdIFZD4+6xNPy/U3kJB0GxOGF79iQtknbnJeZrsXkRvlHvotmjGYWedFOCub/PB8ECFj57eKxV/PMl1AviXhZoCdK/3zS+ELjY/JlQqXmZkEe4lU3cR0j5xstpW9CjmBS+I=
Received: from 30.221.128.137(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WnbolA6_1757381036 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 09:23:57 +0800
Message-ID: <b9957de7-737c-454a-83b1-6cb2a4070fcf@linux.alibaba.com>
Date: Tue, 9 Sep 2025 09:23:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
 Mark Tinguely <mark.tinguely@oracle.com>, ocfs2-devel@lists.linux.dev,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, jlbec@evilplan.org,
 mark@fasheh.com, brauner@kernel.org, willy@infradead.org, david@fromorbit.com
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com>
 <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
 <CAGudoHHT=P_UyZZpx5tBRHPE+irh1b7PxFXZAHjdHNLcEWOxAQ@mail.gmail.com>
 <8ddcaa59-0cf0-4b7c-a121-924105f7f5a6@linux.alibaba.com>
 <rvavp2omizs6e3qf6xpjpycf6norhfhnkrle4fq4632atgar5v@dghmwbctf2mm>
 <f9014fdb-95c8-4faa-8c42-c1ceea49cbd9@linux.alibaba.com>
 <fureginotssirocugn3aznor4vhbpadhwy7fhaxzeullhrzp7y@bg5gzdv6mrif>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <fureginotssirocugn3aznor4vhbpadhwy7fhaxzeullhrzp7y@bg5gzdv6mrif>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/9/8 21:54, Jan Kara wrote:
> On Mon 08-09-25 20:41:21, Joseph Qi wrote:
>>
>>
>> On 2025/9/8 18:23, Jan Kara wrote:
>>> On Mon 08-09-25 09:51:36, Joseph Qi wrote:
>>>> On 2025/9/5 00:22, Mateusz Guzik wrote:
>>>>> On Thu, Sep 4, 2025 at 6:15 PM Mark Tinguely <mark.tinguely@oracle.com> wrote:
>>>>>>
>>>>>> On 9/4/25 10:42 AM, Mateusz Guzik wrote:
>>>>>>> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
>>>>>>> fine (tm).
>>>>>>>
>>>>>>> The intent is to retire the I_WILL_FREE flag.
>>>>>>>
>>>>>>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>>>>>>> ---
>>>>>>>
>>>>>>> ACHTUNG: only compile-time tested. Need an ocfs2 person to ack it.
>>>>>>>
>>>>>>> btw grep shows comments referencing ocfs2_drop_inode() which are already
>>>>>>> stale on the stock kernel, I opted to not touch them.
>>>>>>>
>>>>>>> This ties into an effort to remove the I_WILL_FREE flag, unblocking
>>>>>>> other work. If accepted would be probably best taken through vfs
>>>>>>> branches with said work, see https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.18.inode.refcount.preliminaries__;!!ACWV5N9M2RV99hQ!OLwk8DVo7uvC-Pd6XVTiUCgP6MUDMKBMEyuV27h_yPGXOjaq078-kMdC9ILFoYQh-4WX93yb0nMfBDFFY_0$
>>>>>>>
>>>>>>>   fs/ocfs2/inode.c       | 23 ++---------------------
>>>>>>>   fs/ocfs2/inode.h       |  1 -
>>>>>>>   fs/ocfs2/ocfs2_trace.h |  2 --
>>>>>>>   fs/ocfs2/super.c       |  2 +-
>>>>>>>   4 files changed, 3 insertions(+), 25 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
>>>>>>> index 6c4f78f473fb..5f4a2cbc505d 100644
>>>>>>> --- a/fs/ocfs2/inode.c
>>>>>>> +++ b/fs/ocfs2/inode.c
>>>>>>> @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
>>>>>>>
>>>>>>>   void ocfs2_evict_inode(struct inode *inode)
>>>>>>>   {
>>>>>>> +     write_inode_now(inode, 1);
>>>>>>> +
>>>>>>>       if (!inode->i_nlink ||
>>>>>>>           (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
>>>>>>>               ocfs2_delete_inode(inode);
>>>>>>> @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
>>>>>>>       ocfs2_clear_inode(inode);
>>>>>>>   }
>>>>>>>
>>>>>>> -/* Called under inode_lock, with no more references on the
>>>>>>> - * struct inode, so it's safe here to check the flags field
>>>>>>> - * and to manipulate i_nlink without any other locks. */
>>>>>>> -int ocfs2_drop_inode(struct inode *inode)
>>>>>>> -{
>>>>>>> -     struct ocfs2_inode_info *oi = OCFS2_I(inode);
>>>>>>> -
>>>>>>> -     trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
>>>>>>> -                             inode->i_nlink, oi->ip_flags);
>>>>>>> -
>>>>>>> -     assert_spin_locked(&inode->i_lock);
>>>>>>> -     inode->i_state |= I_WILL_FREE;
>>>>>>> -     spin_unlock(&inode->i_lock);
>>>>>>> -     write_inode_now(inode, 1);
>>>>>>> -     spin_lock(&inode->i_lock);
>>>>>>> -     WARN_ON(inode->i_state & I_NEW);
>>>>>>> -     inode->i_state &= ~I_WILL_FREE;
>>>>>>> -
>>>>>>> -     return 1;
>>>>>>> -}
>>>>>>> -
>>>>>>>   /*
>>>>>>>    * This is called from our getattr.
>>>>>>>    */
>>>>>>> diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
>>>>>>> index accf03d4765e..07bd838e7843 100644
>>>>>>> --- a/fs/ocfs2/inode.h
>>>>>>> +++ b/fs/ocfs2/inode.h
>>>>>>> @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
>>>>>>>   }
>>>>>>>
>>>>>>>   void ocfs2_evict_inode(struct inode *inode);
>>>>>>> -int ocfs2_drop_inode(struct inode *inode);
>>>>>>>
>>>>>>>   /* Flags for ocfs2_iget() */
>>>>>>>   #define OCFS2_FI_FLAG_SYSFILE               0x1
>>>>>>> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
>>>>>>> index 54ed1495de9a..4b32fb5658ad 100644
>>>>>>> --- a/fs/ocfs2/ocfs2_trace.h
>>>>>>> +++ b/fs/ocfs2/ocfs2_trace.h
>>>>>>> @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
>>>>>>>
>>>>>>>   DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
>>>>>>>
>>>>>>> -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
>>>>>>> -
>>>>>>>   TRACE_EVENT(ocfs2_inode_revalidate,
>>>>>>>       TP_PROTO(void *inode, unsigned long long ino,
>>>>>>>                unsigned int flags),
>>>>>>> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
>>>>>>> index 53daa4482406..e4b0d25f4869 100644
>>>>>>> --- a/fs/ocfs2/super.c
>>>>>>> +++ b/fs/ocfs2/super.c
>>>>>>> @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
>>>>>>>       .statfs         = ocfs2_statfs,
>>>>>>>       .alloc_inode    = ocfs2_alloc_inode,
>>>>>>>       .free_inode     = ocfs2_free_inode,
>>>>>>> -     .drop_inode     = ocfs2_drop_inode,
>>>>>>> +     .drop_inode     = generic_delete_inode,
>>>>>>>       .evict_inode    = ocfs2_evict_inode,
>>>>>>>       .sync_fs        = ocfs2_sync_fs,
>>>>>>>       .put_super      = ocfs2_put_super,
>>>>>>
>>>>>>
>>>>>> I agree, fileystems should not use I_FREEING/I_WILL_FREE.
>>>>>> Doing the sync write_inode_now() should be fine in ocfs_evict_inode().
>>>>>>
>>>>>> Question is ocfs_drop_inode. In commit 513e2dae9422:
>>>>>>   ocfs2: flush inode data to disk and free inode when i_count becomes zero
>>>>>> the return of 1 drops immediate to fix a memory caching issue.
>>>>>> Shouldn't .drop_inode() still return 1?
>>>>>
>>>>> generic_delete_inode is a stub doing just that.
>>>>>
>>>> In case of "drop = 0", it may return directly without calling evict().
>>>> This seems break the expectation of commit 513e2dae9422.
>>>
>>> generic_delete_inode() always returns 1 so evict() will be called.
>>> ocfs2_drop_inode() always returns 1 as well after 513e2dae9422. So I'm not
>>> sure which case of "drop = 0" do you see...
>>>
>> I don't see a real case, just in theory.
>> As I described before, if we make sure write_inode_now() will be called
>> in iput_final(), it would be fine.
> 
> I'm sorry but I still don't quite understand what you are proposing. If
> ->drop() returns 1, the filesystem wants to remove the inode from cache
> (perhaps because it was deleted). Hence iput_final() doesn't bother with
> writing out such inodes. This doesn't work well with ocfs2 wanting to
> always drop inodes hence ocfs2 needs to write the inode itself in
> ocfs2_evice_inode(). Perhaps you have some modification to iput_final() in
> mind but I'm not sure how that would work so can you perhaps suggest a
> patch if you think iput_final() should work differently? Thanks!
> 
I'm just discussing if generic_delete_inode() will always returns 1. And
if it is, I'm fine with this change. Sorry for the confusion.

Before commit 513e2dae9422, ocfs2_drop_inode() may return 1 and postpone
the work to orphan scan. So commit 513e2dae9422 make write_inode_now()
is determinately called by move it to drop_inode().

Now this patch move write_inode_now() down to evict(), and in iput_final()
it has:

if (!drop &&
    !(inode->i_state & I_DONTCACHE) &&
    (sb->s_flags & SB_ACTIVE)) {
	......
	return;
}

So we have to make sure the above condition is not true, otherwise it
breaks the case commit 513e2dae9422 describes.

Thanks,
Joseph


