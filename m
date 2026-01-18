Return-Path: <linux-fsdevel+bounces-74308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDED3948F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 12:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50DE53011186
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E9B28B4FD;
	Sun, 18 Jan 2026 11:47:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F4B640;
	Sun, 18 Jan 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768736878; cv=none; b=GwdfpCcZwQgmNYLAdv/7GVllipU91zmzCcyZeQmBrXwkaDh8dEBC03crk4UWG5A9ufQG0LqKpCBN9sIHqWHFImmJIgtq3zY4KU5TJFqI91R96tg0YOcmBSxSjLFQpy1ML1zDBsZy+bqHjH+vHnwlW3Tya3bkbAXjcT11JitQuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768736878; c=relaxed/simple;
	bh=EwUlR3ZQEzhHB4mzQvS8VvdYTLsJansFXVeUVczQsWQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=hLylictkUdZE7Bmbpiij7KIge8pm7WNwMgaIeqM8ATlVvIySKGfG6+ly3HxwS/w5PLC7DFHSGuLrfIOFRuZO2kWHJeAJkqrUnlk6Jd7mLVcg1BbnSxT0pwpK6yFYpruF/VmCX8JKZR384s/4dlVEb0tS0ch9E/1tV3C4Oqt3BOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [101.226.143.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3109dd592;
	Sun, 18 Jan 2026 19:47:48 +0800 (GMT+08:00)
Content-Type: multipart/mixed; boundary="------------Z0aCNwP067IC2oOOyTYD2kSj"
Message-ID: <2264748f-58f7-490e-be0b-257db08a761d@ustc.edu>
Date: Sun, 18 Jan 2026 19:47:48 +0800
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
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <CAOQ4uxhgOk2Ati81vqEkgWFODkW_gkB7Z7wj0x1A8RX38wLSRA@mail.gmail.com>
X-HM-Tid: 0a9bd0eec92303a2kunmedc6666a2dc1fe
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHU5IVhgeThpNQx8eGkxLTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+

This is a multi-part message in MIME format.
--------------Z0aCNwP067IC2oOOyTYD2kSj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/26 1:00 AM, Amir Goldstein wrote:
> On Sat, Jan 17, 2026 at 5:14 PM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>
>>
>>
>> On 1/16/26 11:39 PM, Amir Goldstein wrote:
>>> On Fri, Jan 16, 2026 at 3:28 PM Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>>>>
>>>> To simplify crash recovery and reduce performance impact, backing_ids
>>>> are not persisted across daemon restarts. After crash recovery, this
>>>> may lead to resource leaks if backing file resources are not properly
>>>> cleaned up.
>>>>
>>>> Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
>>>> and put backing files. When the FUSE daemon restarts, it can use this
>>>> ioctl to cleanup all backing file resources.
>>>>
>>>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
>>>> ---
>>>>    fs/fuse/backing.c         | 19 +++++++++++++++++++
>>>>    fs/fuse/dev.c             | 16 ++++++++++++++++
>>>>    fs/fuse/fuse_i.h          |  1 +
>>>>    include/uapi/linux/fuse.h |  1 +
>>>>    4 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
>>>> index 4afda419dd14..e93d797a2cde 100644
>>>> --- a/fs/fuse/backing.c
>>>> +++ b/fs/fuse/backing.c
>>>> @@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>>>>           return err;
>>>>    }
>>>>
>>>> +static int fuse_backing_close_one(int id, void *p, void *data)
>>>> +{
>>>> +       struct fuse_conn *fc = data;
>>>> +
>>>> +       fuse_backing_close(fc, id);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +int fuse_backing_close_all(struct fuse_conn *fc)
>>>> +{
>>>> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>>>> +               return -EPERM;
>>>> +
>>>> +       idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>
>>> This is not safe and not efficient.
>>> For safety from racing with _open/_close, iteration needs at least
>>> rcu_read_lock(),
>>
>> Yes, you're absolutely right. Additionally, calling idr_remove within
>> idr_for_each maybe presents safety risks.
>>
>>> but I think it will be much more efficient to zap the entire map with
>>> fuse_backing_files_free()/fuse_backing_files_init().
>>>
>>> This of course needs to be synchronized with concurrent _open/_close/_lookup.
>>> This could be done by making c->backing_files_map a struct idr __rcu *
>>> and replace the old and new backing_files_map under spin_lock(&fc->lock);
>>>
>>> Then you can call fuse_backing_files_free() on the old backing_files_map
>>> without a lock.
>>>
>>> As a side note, fuse_backing_files_free() iteration looks like it may need
>>> cond_resched() if there are a LOT of backing ids, but I am not sure and
>>> this is orthogonal to your change.
>>>
>>> Thanks,
>>> Amir.
>>>
>>>
>>
>> Thank you for your helpful suggestions. However, it cannot use
>> fuse_backing_files_free() in the close_all implementation because it
>> directly frees backing files without respecting reference counts. This
>> function requires that no one is actively using the backing file (it
>> even has WARN_ON_ONCE(refcount_read(&fb->count) != 1)), which cannot be
>> guaranteed after a crash recovery scenario where backing files may still
>> be in use.
> 
> Right.
> 
>>
>> Instead, the implementation uses fuse_backing_put() to safely decrement
>> the reference count and allow the backing file to be freed when no
>> longer in use.
> 
> OK.
> 
>>
>> Additionally, the implementation addresses two race conditions:
>>
>> - Race between idr_for_each and lookup: Uses synchronize_rcu() to ensure
>> all concurrent RCU readers (i.e., in-flight fuse_backing_lookup() calls)
>> complete before releasing backing files, preventing use-after-free issues.
> 
> Almost. See below.
> 
>>
>> - Race with open/close operations: Uses fc->lock to atomically swap the
>> old and new IDR maps, ensuring consistency with concurrent
>> fuse_backing_open() and fuse_backing_close() operations.
>>
>> This approach provides the same as the RCU pointer suggestion, but with
>> less code and no changes to the struct fuse_conn data structures.
>>
>> I've updated it and verified the implementation. Could you please review it?
>>
>>
>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
>> index 4afda419dd14..047d373684f9 100644
>> --- a/fs/fuse/backing.c
>> +++ b/fs/fuse/backing.c
>> @@ -166,6 +166,45 @@ int fuse_backing_close(struct fuse_conn *fc, int
>> backing_id)
>>           return err;
>>    }
>>
>> +static int fuse_backing_release_one(int id, void *p, void *data)
>> +{
>> +       struct fuse_backing *fb = p;
>> +
>> +       fuse_backing_put(fb);
>> +
>> +       return 0;
>> +}
>> +
>> +int fuse_backing_close_all(struct fuse_conn *fc)
>> +{
>> +       struct idr old_map;
>> +
>> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>> +               return -EPERM;
>> +
>> +       /*
>> +        * Swap out the old backing_files_map with a new empty one under
>> lock,
>> +        * then release all backing files outside the lock. This avoids long
>> +        * lock hold times and potential races with concurrent open/close
>> +        * operations.
>> +        */
>> +       idr_init(&old_map);
>> +       spin_lock(&fc->lock);
>> +       swap(fc->backing_files_map, old_map);
>> +       spin_unlock(&fc->lock);
>> +
>> +       /*
>> +        * Ensure all concurrent RCU readers complete before releasing
>> backing
>> +        * files, so any in-flight lookups can safely take references.
>> +        */
>> +       synchronize_rcu();
>> +
>> +       idr_for_each(&old_map, fuse_backing_release_one, NULL);
>> +       idr_destroy(&old_map);
>> +
>> +       return 0;
>> +}
>> +
> 
> That's almost safe but not enough.
> This lookup code is not safe against the swap():
> 
>    rcu_read_lock();
>    fb = idr_find(&fc->backing_files_map, backing_id);
> 
> That is the reason you need to make fc->backing_files_map
> an rcu referenced ptr.
> 
> Instead of swap() you use xchg() to atomically exchange the
> old and new struct idr pointers and for lookup:
> 
>    rcu_read_lock();
>    fb = idr_find(rcu_dereference(fc->backing_files_map), backing_id);
> 
> Thanks,
> Amir.
> 
> 

Yes, swap() isn't atomic, it's just copying structs, so it's not safe 
when racing with lookup.

I've updated the version to make fc->backing_files_map an rcu referenced 
ptr. Please review the attached patch.

Thanks,
Chunsheng Luo.
--------------Z0aCNwP067IC2oOOyTYD2kSj
Content-Type: text/plain; charset=UTF-8;
 name="0001-fuse-add-ioctl-to-cleanup-all-backing-files.patch"
Content-Disposition: attachment;
 filename="0001-fuse-add-ioctl-to-cleanup-all-backing-files.patch"
Content-Transfer-Encoding: base64

RnJvbSBiNjc0ZGNlZjRlNTgzMThjOTJiMDYxYzYyODk5ZDU1OTgyMDM1NDdlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHVuc2hlbmcgTHVvIDxsdW9jaHVuc2hlbmdAdXN0
Yy5lZHU+CkRhdGU6IE1vbiwgMTIgSmFuIDIwMjYgMTY6NTY6MzYgKzA4MDAKU3ViamVjdDog
W1BBVENIXSBmdXNlOiBhZGQgaW9jdGwgdG8gY2xlYW51cCBhbGwgYmFja2luZyBmaWxlcwoK
VG8gc2ltcGxpZnkgY3Jhc2ggcmVjb3ZlcnkgYW5kIHJlZHVjZSBwZXJmb3JtYW5jZSBpbXBh
Y3QsIGJhY2tpbmdfaWRzCmFyZSBub3QgcGVyc2lzdGVkIGFjcm9zcyBkYWVtb24gcmVzdGFy
dHMuIEFmdGVyIGNyYXNoIHJlY292ZXJ5LCB0aGlzCm1heSBsZWFkIHRvIHJlc291cmNlIGxl
YWtzIGlmIGJhY2tpbmcgZmlsZSByZXNvdXJjZXMgYXJlIG5vdCBwcm9wZXJseQpjbGVhbmVk
IHVwLgoKQWRkIEZVU0VfREVWX0lPQ19CQUNLSU5HX0NMT1NFX0FMTCBpb2N0bCB0byByZWxl
YXNlIGFsbCBiYWNraW5nX2lkcwphbmQgcHV0IGJhY2tpbmcgZmlsZXMuIFdoZW4gdGhlIEZV
U0UgZGFlbW9uIHJlc3RhcnRzLCBpdCBjYW4gdXNlIHRoaXMKaW9jdGwgdG8gY2xlYW51cCBh
bGwgYmFja2luZyBmaWxlIHJlc291cmNlcy4KClNpZ25lZC1vZmYtYnk6IENodW5zaGVuZyBM
dW8gPGx1b2NodW5zaGVuZ0B1c3RjLmVkdT4KLS0tCiBmcy9mdXNlL2JhY2tpbmcuYyAgICAg
ICAgIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiBmcy9m
dXNlL2Rldi5jICAgICAgICAgICAgIHwgMTYgKysrKysrKysKIGZzL2Z1c2UvZnVzZV9pLmgg
ICAgICAgICAgfCAgNSArKy0KIGZzL2Z1c2UvaW5vZGUuYyAgICAgICAgICAgfCAxMSArKyst
LS0KIGluY2x1ZGUvdWFwaS9saW51eC9mdXNlLmggfCAgMSArCiA1IGZpbGVzIGNoYW5nZWQs
IDk1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2Z1
c2UvYmFja2luZy5jIGIvZnMvZnVzZS9iYWNraW5nLmMKaW5kZXggNGFmZGE0MTlkZDE0Li4y
ZGEwMjRkYzAwM2QgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvYmFja2luZy5jCisrKyBiL2ZzL2Z1
c2UvYmFja2luZy5jCkBAIC0zMiwxOSArMzIsMjkgQEAgdm9pZCBmdXNlX2JhY2tpbmdfcHV0
KHN0cnVjdCBmdXNlX2JhY2tpbmcgKmZiKQogCQlmdXNlX2JhY2tpbmdfZnJlZShmYik7CiB9
CiAKLXZvaWQgZnVzZV9iYWNraW5nX2ZpbGVzX2luaXQoc3RydWN0IGZ1c2VfY29ubiAqZmMp
CitpbnQgZnVzZV9iYWNraW5nX2ZpbGVzX2luaXQoc3RydWN0IGZ1c2VfY29ubiAqZmMpCiB7
Ci0JaWRyX2luaXQoJmZjLT5iYWNraW5nX2ZpbGVzX21hcCk7CisJc3RydWN0IGlkciAqaWRy
OworCisJaWRyID0ga3phbGxvYyhzaXplb2YoKmlkciksIEdGUF9LRVJORUwpOworCWlmICgh
aWRyKQorCQlyZXR1cm4gLUVOT01FTTsKKwlpZHJfaW5pdChpZHIpOworCXJjdV9hc3NpZ25f
cG9pbnRlcihmYy0+YmFja2luZ19maWxlc19tYXAsIGlkcik7CisJcmV0dXJuIDA7CiB9CiAK
IHN0YXRpYyBpbnQgZnVzZV9iYWNraW5nX2lkX2FsbG9jKHN0cnVjdCBmdXNlX2Nvbm4gKmZj
LCBzdHJ1Y3QgZnVzZV9iYWNraW5nICpmYikKIHsKKwlzdHJ1Y3QgaWRyICppZHI7CiAJaW50
IGlkOwogCiAJaWRyX3ByZWxvYWQoR0ZQX0tFUk5FTCk7CiAJc3Bpbl9sb2NrKCZmYy0+bG9j
ayk7CisJaWRyID0gcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChmYy0+YmFja2luZ19maWxl
c19tYXAsCisJCQkJCWxvY2tkZXBfaXNfaGVsZCgmZmMtPmxvY2spKTsKIAkvKiBGSVhNRTog
eGFycmF5IG1pZ2h0IGJlIHNwYWNlIGluZWZmaWNpZW50ICovCi0JaWQgPSBpZHJfYWxsb2Nf
Y3ljbGljKCZmYy0+YmFja2luZ19maWxlc19tYXAsIGZiLCAxLCAwLCBHRlBfQVRPTUlDKTsK
KwlpZCA9IGlkcl9hbGxvY19jeWNsaWMoaWRyLCBmYiwgMSwgMCwgR0ZQX0FUT01JQyk7CiAJ
c3Bpbl91bmxvY2soJmZjLT5sb2NrKTsKIAlpZHJfcHJlbG9hZF9lbmQoKTsKIApAQCAtNTUs
MTAgKzY1LDEzIEBAIHN0YXRpYyBpbnQgZnVzZV9iYWNraW5nX2lkX2FsbG9jKHN0cnVjdCBm
dXNlX2Nvbm4gKmZjLCBzdHJ1Y3QgZnVzZV9iYWNraW5nICpmYikKIHN0YXRpYyBzdHJ1Y3Qg
ZnVzZV9iYWNraW5nICpmdXNlX2JhY2tpbmdfaWRfcmVtb3ZlKHN0cnVjdCBmdXNlX2Nvbm4g
KmZjLAogCQkJCQkJICAgaW50IGlkKQogeworCXN0cnVjdCBpZHIgKmlkcjsKIAlzdHJ1Y3Qg
ZnVzZV9iYWNraW5nICpmYjsKIAogCXNwaW5fbG9jaygmZmMtPmxvY2spOwotCWZiID0gaWRy
X3JlbW92ZSgmZmMtPmJhY2tpbmdfZmlsZXNfbWFwLCBpZCk7CisJaWRyID0gcmN1X2RlcmVm
ZXJlbmNlX3Byb3RlY3RlZChmYy0+YmFja2luZ19maWxlc19tYXAsCisJCQkJCWxvY2tkZXBf
aXNfaGVsZCgmZmMtPmxvY2spKTsKKwlmYiA9IGlkcl9yZW1vdmUoaWRyLCBpZCk7CiAJc3Bp
bl91bmxvY2soJmZjLT5sb2NrKTsKIAogCXJldHVybiBmYjsKQEAgLTc1LDggKzg4LDEzIEBA
IHN0YXRpYyBpbnQgZnVzZV9iYWNraW5nX2lkX2ZyZWUoaW50IGlkLCB2b2lkICpwLCB2b2lk
ICpkYXRhKQogCiB2b2lkIGZ1c2VfYmFja2luZ19maWxlc19mcmVlKHN0cnVjdCBmdXNlX2Nv
bm4gKmZjKQogewotCWlkcl9mb3JfZWFjaCgmZmMtPmJhY2tpbmdfZmlsZXNfbWFwLCBmdXNl
X2JhY2tpbmdfaWRfZnJlZSwgTlVMTCk7Ci0JaWRyX2Rlc3Ryb3koJmZjLT5iYWNraW5nX2Zp
bGVzX21hcCk7CisJc3RydWN0IGlkciAqaWRyID0gcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3Rl
ZChmYy0+YmFja2luZ19maWxlc19tYXAsIDEpOworCisJaWYgKGlkcikgeworCQlpZHJfZm9y
X2VhY2goaWRyLCBmdXNlX2JhY2tpbmdfaWRfZnJlZSwgTlVMTCk7CisJCWlkcl9kZXN0cm95
KGlkcik7CisJCWtmcmVlKGlkcik7CisJfQogfQogCiBpbnQgZnVzZV9iYWNraW5nX29wZW4o
c3RydWN0IGZ1c2VfY29ubiAqZmMsIHN0cnVjdCBmdXNlX2JhY2tpbmdfbWFwICptYXApCkBA
IC0xNjYsMTIgKzE4NCw1NyBAQCBpbnQgZnVzZV9iYWNraW5nX2Nsb3NlKHN0cnVjdCBmdXNl
X2Nvbm4gKmZjLCBpbnQgYmFja2luZ19pZCkKIAlyZXR1cm4gZXJyOwogfQogCitpbnQgZnVz
ZV9iYWNraW5nX2Nsb3NlX2FsbChzdHJ1Y3QgZnVzZV9jb25uICpmYykKK3sKKwlzdHJ1Y3Qg
aWRyICpvbGRfaWRyLCAqbmV3X2lkcjsKKwlzdHJ1Y3QgZnVzZV9iYWNraW5nICpmYjsKKwlp
bnQgaWQ7CisKKwlpZiAoIWZjLT5wYXNzdGhyb3VnaCB8fCAhY2FwYWJsZShDQVBfU1lTX0FE
TUlOKSkKKwkJcmV0dXJuIC1FUEVSTTsKKworCW5ld19pZHIgPSBremFsbG9jKHNpemVvZigq
bmV3X2lkciksIEdGUF9LRVJORUwpOworCWlmICghbmV3X2lkcikKKwkJcmV0dXJuIC1FTk9N
RU07CisKKwlpZHJfaW5pdChuZXdfaWRyKTsKKworCS8qCisJICogQXRvbWljYWxseSBleGNo
YW5nZSB0aGUgb2xkIElEUiB3aXRoIGEgbmV3IGVtcHR5IG9uZSB1bmRlciBsb2NrLgorCSAq
IFRoaXMgYXZvaWRzIGxvbmcgbG9jayBob2xkIHRpbWVzIGFuZCByYWNlcyB3aXRoIGNvbmN1
cnJlbnQKKwkgKiBvcGVuL2Nsb3NlIG9wZXJhdGlvbnMuCisJICovCisJc3Bpbl9sb2NrKCZm
Yy0+bG9jayk7CisJb2xkX2lkciA9IHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoZmMtPmJh
Y2tpbmdfZmlsZXNfbWFwLAorCQkJCQkgICAgbG9ja2RlcF9pc19oZWxkKCZmYy0+bG9jaykp
OworCXJjdV9hc3NpZ25fcG9pbnRlcihmYy0+YmFja2luZ19maWxlc19tYXAsIG5ld19pZHIp
OworCXNwaW5fdW5sb2NrKCZmYy0+bG9jayk7CisKKwkvKgorCSAqIEVuc3VyZSBhbGwgY29u
Y3VycmVudCBSQ1UgcmVhZGVycyBjb21wbGV0ZSBiZWZvcmUgcmVsZWFzaW5nIGJhY2tpbmcK
KwkgKiBmaWxlcywgc28gYW55IGluLWZsaWdodCBsb29rdXBzIGNhbiBzYWZlbHkgdGFrZSBy
ZWZlcmVuY2VzLgorCSAqLworCXN5bmNocm9uaXplX3JjdSgpOworCisJaWYgKG9sZF9pZHIp
IHsKKwkJaWRyX2Zvcl9lYWNoX2VudHJ5KG9sZF9pZHIsIGZiLCBpZCkKKwkJCWZ1c2VfYmFj
a2luZ19wdXQoZmIpOworCisJCWlkcl9kZXN0cm95KG9sZF9pZHIpOworCQlrZnJlZShvbGRf
aWRyKTsKKwl9CisKKwlyZXR1cm4gMDsKK30KKwogc3RydWN0IGZ1c2VfYmFja2luZyAqZnVz
ZV9iYWNraW5nX2xvb2t1cChzdHJ1Y3QgZnVzZV9jb25uICpmYywgaW50IGJhY2tpbmdfaWQp
CiB7CisJc3RydWN0IGlkciAqaWRyOwogCXN0cnVjdCBmdXNlX2JhY2tpbmcgKmZiOwogCiAJ
cmN1X3JlYWRfbG9jaygpOwotCWZiID0gaWRyX2ZpbmQoJmZjLT5iYWNraW5nX2ZpbGVzX21h
cCwgYmFja2luZ19pZCk7CisJaWRyID0gcmN1X2RlcmVmZXJlbmNlKGZjLT5iYWNraW5nX2Zp
bGVzX21hcCk7CisJZmIgPSBpZHIgPyBpZHJfZmluZChpZHIsIGJhY2tpbmdfaWQpIDogTlVM
TDsKIAlmYiA9IGZ1c2VfYmFja2luZ19nZXQoZmIpOwogCXJjdV9yZWFkX3VubG9jaygpOwog
CmRpZmYgLS1naXQgYS9mcy9mdXNlL2Rldi5jIGIvZnMvZnVzZS9kZXYuYwppbmRleCA2ZDU5
Y2JjODc3YzYuLmYwNWQ1NTMwMjU5OCAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kZXYuYworKysg
Yi9mcy9mdXNlL2Rldi5jCkBAIC0yNjU0LDYgKzI2NTQsMTkgQEAgc3RhdGljIGxvbmcgZnVz
ZV9kZXZfaW9jdGxfYmFja2luZ19jbG9zZShzdHJ1Y3QgZmlsZSAqZmlsZSwgX191MzIgX191
c2VyICphcmdwKQogCXJldHVybiBmdXNlX2JhY2tpbmdfY2xvc2UoZnVkLT5mYywgYmFja2lu
Z19pZCk7CiB9CiAKK3N0YXRpYyBsb25nIGZ1c2VfZGV2X2lvY3RsX2JhY2tpbmdfY2xvc2Vf
YWxsKHN0cnVjdCBmaWxlICpmaWxlKQoreworCXN0cnVjdCBmdXNlX2RldiAqZnVkID0gZnVz
ZV9nZXRfZGV2KGZpbGUpOworCisJaWYgKElTX0VSUihmdWQpKQorCQlyZXR1cm4gUFRSX0VS
UihmdWQpOworCisJaWYgKCFJU19FTkFCTEVEKENPTkZJR19GVVNFX1BBU1NUSFJPVUdIKSkK
KwkJcmV0dXJuIC1FT1BOT1RTVVBQOworCisJcmV0dXJuIGZ1c2VfYmFja2luZ19jbG9zZV9h
bGwoZnVkLT5mYyk7Cit9CisKIHN0YXRpYyBsb25nIGZ1c2VfZGV2X2lvY3RsX3N5bmNfaW5p
dChzdHJ1Y3QgZmlsZSAqZmlsZSkKIHsKIAlpbnQgZXJyID0gLUVJTlZBTDsKQEAgLTI2ODIs
NiArMjY5NSw5IEBAIHN0YXRpYyBsb25nIGZ1c2VfZGV2X2lvY3RsKHN0cnVjdCBmaWxlICpm
aWxlLCB1bnNpZ25lZCBpbnQgY21kLAogCWNhc2UgRlVTRV9ERVZfSU9DX0JBQ0tJTkdfQ0xP
U0U6CiAJCXJldHVybiBmdXNlX2Rldl9pb2N0bF9iYWNraW5nX2Nsb3NlKGZpbGUsIGFyZ3Ap
OwogCisJY2FzZSBGVVNFX0RFVl9JT0NfQkFDS0lOR19DTE9TRV9BTEw6CisJCXJldHVybiBm
dXNlX2Rldl9pb2N0bF9iYWNraW5nX2Nsb3NlX2FsbChmaWxlKTsKKwogCWNhc2UgRlVTRV9E
RVZfSU9DX1NZTkNfSU5JVDoKIAkJcmV0dXJuIGZ1c2VfZGV2X2lvY3RsX3N5bmNfaW5pdChm
aWxlKTsKIApkaWZmIC0tZ2l0IGEvZnMvZnVzZS9mdXNlX2kuaCBiL2ZzL2Z1c2UvZnVzZV9p
LmgKaW5kZXggN2YxNjA0OTM4N2QxLi5mNDVjNTA0MmUzMWEgMTAwNjQ0Ci0tLSBhL2ZzL2Z1
c2UvZnVzZV9pLmgKKysrIGIvZnMvZnVzZS9mdXNlX2kuaApAQCAtOTc5LDcgKzk3OSw3IEBA
IHN0cnVjdCBmdXNlX2Nvbm4gewogCiAjaWZkZWYgQ09ORklHX0ZVU0VfUEFTU1RIUk9VR0gK
IAkvKiogSURSIGZvciBiYWNraW5nIGZpbGVzIGlkcyAqLwotCXN0cnVjdCBpZHIgYmFja2lu
Z19maWxlc19tYXA7CisJc3RydWN0IGlkciBfX3JjdSAqYmFja2luZ19maWxlc19tYXA7CiAj
ZW5kaWYKIAogI2lmZGVmIENPTkZJR19GVVNFX0lPX1VSSU5HCkBAIC0xNTY5LDEwICsxNTY5
LDExIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZ1c2VfYmFja2luZyAqZnVzZV9iYWNraW5n
X2xvb2t1cChzdHJ1Y3QgZnVzZV9jb25uICpmYywKIH0KICNlbmRpZgogCi12b2lkIGZ1c2Vf
YmFja2luZ19maWxlc19pbml0KHN0cnVjdCBmdXNlX2Nvbm4gKmZjKTsKK2ludCBmdXNlX2Jh
Y2tpbmdfZmlsZXNfaW5pdChzdHJ1Y3QgZnVzZV9jb25uICpmYyk7CiB2b2lkIGZ1c2VfYmFj
a2luZ19maWxlc19mcmVlKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKTsKIGludCBmdXNlX2JhY2tp
bmdfb3BlbihzdHJ1Y3QgZnVzZV9jb25uICpmYywgc3RydWN0IGZ1c2VfYmFja2luZ19tYXAg
Km1hcCk7CiBpbnQgZnVzZV9iYWNraW5nX2Nsb3NlKHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCBp
bnQgYmFja2luZ19pZCk7CitpbnQgZnVzZV9iYWNraW5nX2Nsb3NlX2FsbChzdHJ1Y3QgZnVz
ZV9jb25uICpmYyk7CiAKIC8qIHBhc3N0aHJvdWdoLmMgKi8KIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IGZ1c2VfYmFja2luZyAqZnVzZV9pbm9kZV9iYWNraW5nKHN0cnVjdCBmdXNlX2lub2Rl
ICpmaSkKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvaW5vZGUuYyBiL2ZzL2Z1c2UvaW5vZGUuYwpp
bmRleCA4MTllNTBkNjY2MjIuLmI2M2EwNjdkNTBmOCAxMDA2NDQKLS0tIGEvZnMvZnVzZS9p
bm9kZS5jCisrKyBiL2ZzL2Z1c2UvaW5vZGUuYwpAQCAtMTAwMSw5ICsxMDAxLDYgQEAgdm9p
ZCBmdXNlX2Nvbm5faW5pdChzdHJ1Y3QgZnVzZV9jb25uICpmYywgc3RydWN0IGZ1c2VfbW91
bnQgKmZtLAogCWZjLT5uYW1lX21heCA9IEZVU0VfTkFNRV9MT1dfTUFYOwogCWZjLT50aW1l
b3V0LnJlcV90aW1lb3V0ID0gMDsKIAotCWlmIChJU19FTkFCTEVEKENPTkZJR19GVVNFX1BB
U1NUSFJPVUdIKSkKLQkJZnVzZV9iYWNraW5nX2ZpbGVzX2luaXQoZmMpOwotCiAJSU5JVF9M
SVNUX0hFQUQoJmZjLT5tb3VudHMpOwogCWxpc3RfYWRkKCZmbS0+ZmNfZW50cnksICZmYy0+
bW91bnRzKTsKIAlmbS0+ZmMgPSBmYzsKQEAgLTE0MzksOSArMTQzNiwxMSBAQCBzdGF0aWMg
dm9pZCBwcm9jZXNzX2luaXRfcmVwbHkoc3RydWN0IGZ1c2VfbW91bnQgKmZtLCBzdHJ1Y3Qg
ZnVzZV9hcmdzICphcmdzLAogCQkJICAgIGFyZy0+bWF4X3N0YWNrX2RlcHRoID4gMCAmJgog
CQkJICAgIGFyZy0+bWF4X3N0YWNrX2RlcHRoIDw9IEZJTEVTWVNURU1fTUFYX1NUQUNLX0RF
UFRIICYmCiAJCQkgICAgIShmbGFncyAmIEZVU0VfV1JJVEVCQUNLX0NBQ0hFKSkgIHsKLQkJ
CQlmYy0+cGFzc3Rocm91Z2ggPSAxOwotCQkJCWZjLT5tYXhfc3RhY2tfZGVwdGggPSBhcmct
Pm1heF9zdGFja19kZXB0aDsKLQkJCQlmbS0+c2ItPnNfc3RhY2tfZGVwdGggPSBhcmctPm1h
eF9zdGFja19kZXB0aDsKKwkJCQlpZiAoZnVzZV9iYWNraW5nX2ZpbGVzX2luaXQoZmMpID09
IDApIHsKKwkJCQkJZmMtPnBhc3N0aHJvdWdoID0gMTsKKwkJCQkJZmMtPm1heF9zdGFja19k
ZXB0aCA9IGFyZy0+bWF4X3N0YWNrX2RlcHRoOworCQkJCQlmbS0+c2ItPnNfc3RhY2tfZGVw
dGggPSBhcmctPm1heF9zdGFja19kZXB0aDsKKwkJCQl9CiAJCQl9CiAJCQlpZiAoZmxhZ3Mg
JiBGVVNFX05PX0VYUE9SVF9TVVBQT1JUKQogCQkJCWZtLT5zYi0+c19leHBvcnRfb3AgPSAm
ZnVzZV9leHBvcnRfZmlkX29wZXJhdGlvbnM7CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
bGludXgvZnVzZS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaAppbmRleCBjMTNlMWY5
YTJmMTIuLmU0ZmYyOGE0ZmY0MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2Z1
c2UuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvZnVzZS5oCkBAIC0xMTM5LDYgKzExMzks
NyBAQCBzdHJ1Y3QgZnVzZV9iYWNraW5nX21hcCB7CiAJCQkJCSAgICAgc3RydWN0IGZ1c2Vf
YmFja2luZ19tYXApCiAjZGVmaW5lIEZVU0VfREVWX0lPQ19CQUNLSU5HX0NMT1NFCV9JT1co
RlVTRV9ERVZfSU9DX01BR0lDLCAyLCB1aW50MzJfdCkKICNkZWZpbmUgRlVTRV9ERVZfSU9D
X1NZTkNfSU5JVAkJX0lPKEZVU0VfREVWX0lPQ19NQUdJQywgMykKKyNkZWZpbmUgRlVTRV9E
RVZfSU9DX0JBQ0tJTkdfQ0xPU0VfQUxMCV9JTyhGVVNFX0RFVl9JT0NfTUFHSUMsIDQpCiAK
IHN0cnVjdCBmdXNlX2xzZWVrX2luIHsKIAl1aW50NjRfdAlmaDsKLS0gCjIuNDEuMAoK

--------------Z0aCNwP067IC2oOOyTYD2kSj--

