Return-Path: <linux-fsdevel+bounces-74359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF04D39C8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 03:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5618E300AB32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13B25C704;
	Mon, 19 Jan 2026 02:44:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D05258CE7;
	Mon, 19 Jan 2026 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790691; cv=none; b=l0ytFfMYKaZxrKsJNoEpOCBqOoac85opC5nChdGjPMV+H65HLv3UGpT5xEC81ql327jU7xiaBMLLObF5Hyt9T4yROY1XP0IviRR92NGOU1belAOPslTRIFSAKM39/Vzcp49d8EaR883dzaOK/Dho1w573rYaXdIj+2oIicohpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790691; c=relaxed/simple;
	bh=1pq5B8iZt7iPsn0QPduZZVv/i6wmpnh8rbCKZpSbTRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeSPWwKqQ2Vh9Jd99NB5HuoKier3n3DOs3YWpTLpSOw9Zw9lrwbKo98sLildti8WzOr9sjQ4Qx3wlzeL07Du/Em1ZkuI7HAgM3MTZ17zQjyS53Sjt4vKNVaEX8q+c8ADSWxGTcWPU381FWclbnJ/AvI00VlOxH+7sYGSFyYKdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [101.226.143.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 311583252;
	Mon, 19 Jan 2026 10:44:36 +0800 (GMT+08:00)
Message-ID: <7a7912f3-9362-4aad-99a8-625c920813c5@ustc.edu>
Date: Mon, 19 Jan 2026 10:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: add ioctl to cleanup all backing files
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260116142845.422-1-luochunsheng@ustc.edu>
 <20260116142845.422-2-luochunsheng@ustc.edu>
 <CAOQ4uxg13jAJyG8b3CpjKE8FXn3ce=yUCzw+Qc=k29si=FtXaQ@mail.gmail.com>
 <428db714-5ec8-4259-b808-b8784153d4f2@ustc.edu>
 <CAOQ4uxhgOk2Ati81vqEkgWFODkW_gkB7Z7wj0x1A8RX38wLSRA@mail.gmail.com>
 <2264748f-58f7-490e-be0b-257db08a761d@ustc.edu>
 <CAOQ4uxhbo8vkuNZmhpyOUnttakNmyqCdmiyQyLJakPmsReu3mg@mail.gmail.com>
 <CAOQ4uxhcj0Bu0WjkeHoi6Y3CL=gBKJRcsbSEb7DrteAfiZbBnw@mail.gmail.com>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <CAOQ4uxhcj0Bu0WjkeHoi6Y3CL=gBKJRcsbSEb7DrteAfiZbBnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd423d1da03a2kunm06194ea7302cb5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUgeVklCT01JHkxKSRgZGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+



On 1/19/26 1:08 AM, Amir Goldstein wrote:
> On Sun, Jan 18, 2026 at 6:07 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Sun, Jan 18, 2026 at 12:47 PM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>>
>>>
>>>
>>> On 1/18/26 1:00 AM, Amir Goldstein wrote:
>>>> On Sat, Jan 17, 2026 at 5:14 PM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 1/16/26 11:39 PM, Amir Goldstein wrote:
>>>>>> On Fri, Jan 16, 2026 at 3:28 PM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>>>>>>
>>>>>>> To simplify crash recovery and reduce performance impact, backing_ids
>>>>>>> are not persisted across daemon restarts. After crash recovery, this
>>>>>>> may lead to resource leaks if backing file resources are not properly
>>>>>>> cleaned up.
>>>>>>>
>>>>>>> Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
>>>>>>> and put backing files. When the FUSE daemon restarts, it can use this
>>>>>>> ioctl to cleanup all backing file resources.
>>>>>>>
>>>>>>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
>>>>>>> ---
>>>>>>>     fs/fuse/backing.c         | 19 +++++++++++++++++++
>>>>>>>     fs/fuse/dev.c             | 16 ++++++++++++++++
>>>>>>>     fs/fuse/fuse_i.h          |  1 +
>>>>>>>     include/uapi/linux/fuse.h |  1 +
>>>>>>>     4 files changed, 37 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
>>>>>>> index 4afda419dd14..e93d797a2cde 100644
>>>>>>> --- a/fs/fuse/backing.c
>>>>>>> +++ b/fs/fuse/backing.c
>>>>>>> @@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>>>>>>>            return err;
>>>>>>>     }
>>>>>>>
>>>>>>> +static int fuse_backing_close_one(int id, void *p, void *data)
>>>>>>> +{
>>>>>>> +       struct fuse_conn *fc = data;
>>>>>>> +
>>>>>>> +       fuse_backing_close(fc, id);
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int fuse_backing_close_all(struct fuse_conn *fc)
>>>>>>> +{
>>>>>>> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>>>>>>> +               return -EPERM;
>>>>>>> +
>>>>>>> +       idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>
>>>>>> This is not safe and not efficient.
>>>>>> For safety from racing with _open/_close, iteration needs at least
>>>>>> rcu_read_lock(),
>>>>>
>>>>> Yes, you're absolutely right. Additionally, calling idr_remove within
>>>>> idr_for_each maybe presents safety risks.
>>>>>
>>>>>> but I think it will be much more efficient to zap the entire map with
>>>>>> fuse_backing_files_free()/fuse_backing_files_init().
>>>>>>
>>>>>> This of course needs to be synchronized with concurrent _open/_close/_lookup.
>>>>>> This could be done by making c->backing_files_map a struct idr __rcu *
>>>>>> and replace the old and new backing_files_map under spin_lock(&fc->lock);
>>>>>>
>>>>>> Then you can call fuse_backing_files_free() on the old backing_files_map
>>>>>> without a lock.
>>>>>>
>>>>>> As a side note, fuse_backing_files_free() iteration looks like it may need
>>>>>> cond_resched() if there are a LOT of backing ids, but I am not sure and
>>>>>> this is orthogonal to your change.
>>>>>>
>>>>>> Thanks,
>>>>>> Amir.
>>>>>>
>>>>>>
>>>>>
>>>>> Thank you for your helpful suggestions. However, it cannot use
>>>>> fuse_backing_files_free() in the close_all implementation because it
>>>>> directly frees backing files without respecting reference counts. This
>>>>> function requires that no one is actively using the backing file (it
>>>>> even has WARN_ON_ONCE(refcount_read(&fb->count) != 1)), which cannot be
>>>>> guaranteed after a crash recovery scenario where backing files may still
>>>>> be in use.
>>>>
>>>> Right.
>>>>
>>>>>
>>>>> Instead, the implementation uses fuse_backing_put() to safely decrement
>>>>> the reference count and allow the backing file to be freed when no
>>>>> longer in use.
>>>>
>>>> OK.
>>>>
>>>>>
>>>>> Additionally, the implementation addresses two race conditions:
>>>>>
>>>>> - Race between idr_for_each and lookup: Uses synchronize_rcu() to ensure
>>>>> all concurrent RCU readers (i.e., in-flight fuse_backing_lookup() calls)
>>>>> complete before releasing backing files, preventing use-after-free issues.
>>>>
>>>> Almost. See below.
>>>>
>>>>>
>>>>> - Race with open/close operations: Uses fc->lock to atomically swap the
>>>>> old and new IDR maps, ensuring consistency with concurrent
>>>>> fuse_backing_open() and fuse_backing_close() operations.
>>>>>
>>>>> This approach provides the same as the RCU pointer suggestion, but with
>>>>> less code and no changes to the struct fuse_conn data structures.
>>>>>
>>>>> I've updated it and verified the implementation. Could you please review it?
>>>>>
>>>>>
>>>>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
>>>>> index 4afda419dd14..047d373684f9 100644
>>>>> --- a/fs/fuse/backing.c
>>>>> +++ b/fs/fuse/backing.c
>>>>> @@ -166,6 +166,45 @@ int fuse_backing_close(struct fuse_conn *fc, int
>>>>> backing_id)
>>>>>            return err;
>>>>>     }
>>>>>
>>>>> +static int fuse_backing_release_one(int id, void *p, void *data)
>>>>> +{
>>>>> +       struct fuse_backing *fb = p;
>>>>> +
>>>>> +       fuse_backing_put(fb);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +int fuse_backing_close_all(struct fuse_conn *fc)
>>>>> +{
>>>>> +       struct idr old_map;
>>>>> +
>>>>> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>>>>> +               return -EPERM;
>>>>> +
>>>>> +       /*
>>>>> +        * Swap out the old backing_files_map with a new empty one under
>>>>> lock,
>>>>> +        * then release all backing files outside the lock. This avoids long
>>>>> +        * lock hold times and potential races with concurrent open/close
>>>>> +        * operations.
>>>>> +        */
>>>>> +       idr_init(&old_map);
>>>>> +       spin_lock(&fc->lock);
>>>>> +       swap(fc->backing_files_map, old_map);
>>>>> +       spin_unlock(&fc->lock);
>>>>> +
>>>>> +       /*
>>>>> +        * Ensure all concurrent RCU readers complete before releasing
>>>>> backing
>>>>> +        * files, so any in-flight lookups can safely take references.
>>>>> +        */
>>>>> +       synchronize_rcu();
>>>>> +
>>>>> +       idr_for_each(&old_map, fuse_backing_release_one, NULL);
>>>>> +       idr_destroy(&old_map);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>
>>>> That's almost safe but not enough.
>>>> This lookup code is not safe against the swap():
>>>>
>>>>     rcu_read_lock();
>>>>     fb = idr_find(&fc->backing_files_map, backing_id);
>>>>
>>>> That is the reason you need to make fc->backing_files_map
>>>> an rcu referenced ptr.
>>>>
>>>> Instead of swap() you use xchg() to atomically exchange the
>>>> old and new struct idr pointers and for lookup:
>>>>
>>>>     rcu_read_lock();
>>>>     fb = idr_find(rcu_dereference(fc->backing_files_map), backing_id);
>>>>
>>>> Thanks,
>>>> Amir.
>>>>
>>>>
>>>
>>> Yes, swap() isn't atomic, it's just copying structs, so it's not safe
>>> when racing with lookup.
>>>
>>> I've updated the version to make fc->backing_files_map an rcu referenced
>>> ptr. Please review the attached patch.
>>
>> You can also use rcu_replace_pointer() to swap old_idr <-> new_idr,
>> but otherwise the patch looks fine to me.
>>
> 
> Feel free to add
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.
> 
> 

Ok, agree. Using rcu_replace_pointer is more concise.

Thanks,
Chunsheng Luo


