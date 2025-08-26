Return-Path: <linux-fsdevel+bounces-59317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBBB3738C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BDE2004DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1472633;
	Tue, 26 Aug 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B/vczwbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D131A566;
	Tue, 26 Aug 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238481; cv=none; b=kG+MnqnvATMS2caRZ4PmMm6BB4fLmPQhpdmBY3RZydXmd+Q55QkTx1Mc9K1/7N2tKI8sOuT27LduI7mfF1xRSakJCIWasImzqIxRnIBZSPMvYkLchcscSCeqYGgmns9fFdETkphTPUb6qo7zQeJGzPOn2WlwaUxNUPLYZXDZMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238481; c=relaxed/simple;
	bh=nvWmE0L+CqbnD+3woBmrE9Ez4Z0DSKHJp2HK8pxIgik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBHbqwZvYiaPp6XtrH5q2p88W1oN0w+M0BK1zkZ6nj4AH5ia9lMU0ZSmWDbCKsmzra9fOOv92XgVHCKY3o/8BnH1SsdpsUpzKDTlJBzLi/LNd3kzMwwBgW+UeWVcfT6+pmyyICZiPuHIQwrlybgKcNOpj6eTp0iMLxWjWUhnHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B/vczwbJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yz0WT7+MFdn0cVk7m9jriBnNSHFCYh7NiswtBG3pBBE=; b=B/vczwbJx0HfM6+GUAo8MqBN5W
	/p+a2cDqh2lGoFjUK3MfZI9h2xfzYbNdvHfDNbG2+bO66YTIOX7ZrT16kBQEmu1ZhGVjFd2oGXhhE
	3mam41OWU1J9PUUwnyh3247Vn54o9JHiJKAQ7eE+43KbtSBmAsflQEhpbBApv+FXzE7uBw5+CNtbF
	PUPK83uL09P/d1+zMdnBUQMaEgk9tOnIysfL3TAVI8MeZlLc7YGVU09Ke1uywxJTTrFzgEgY3n5kW
	8Pf/mztLELxzuPb8rhnZvKKDFRj5xsGnjd+s3EyV2P6aGQj7nKorTXgreLpPHk8l/mJaKCX8CNK8Y
	KgTx3c2Q==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uqzqw-00258D-D6; Tue, 26 Aug 2025 22:01:10 +0200
Message-ID: <9aeb7da4-0b94-4b53-9573-9f7fdcf142cc@igalia.com>
Date: Tue, 26 Aug 2025 17:01:06 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
To: Amir Goldstein <amir73il@gmail.com>,
 Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
 <875xeb64ks.fsf@mailhost.krisman.be>
 <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
 <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
 <871poz4983.fsf@mailhost.krisman.be> <87plci3lxw.fsf@mailhost.krisman.be>
 <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 26/08/2025 04:19, Amir Goldstein escreveu:
> On Tue, Aug 26, 2025 at 3:34 AM Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>>
>> Gabriel Krisman Bertazi <gabriel@krisman.be> writes:
>>
>>> Amir Goldstein <amir73il@gmail.com> writes:
>>>
>>>> On Mon, Aug 25, 2025 at 5:27 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>
>>>>> On Mon, Aug 25, 2025 at 1:09 PM Gabriel Krisman Bertazi
>>>>> <gabriel@krisman.be> wrote:
>>>>>>
>>>>>> André Almeida <andrealmeid@igalia.com> writes:
>>>>>>
>>>>>>> To add overlayfs support casefold layers, create a new function
>>>>>>> ovl_casefold(), to be able to do case-insensitive strncmp().
>>>>>>>
>>>>>>> ovl_casefold() allocates a new buffer and stores the casefolded version
>>>>>>> of the string on it. If the allocation or the casefold operation fails,
>>>>>>> fallback to use the original string.
>>>>>>>
>>>>>>> The case-insentive name is then used in the rb-tree search/insertion
>>>>>>> operation. If the name is found in the rb-tree, the name can be
>>>>>>> discarded and the buffer is freed. If the name isn't found, it's then
>>>>>>> stored at struct ovl_cache_entry to be used later.
>>>>>>>
>>>>>>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>>>>>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>>>>>> ---
>>>>>>> Changes from v6:
>>>>>>>   - Last version was using `strncmp(... tmp->len)` which was causing
>>>>>>>     regressions. It should be `strncmp(... len)`.
>>>>>>>   - Rename cf_len to c_len
>>>>>>>   - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
>>>>>>>   - Remove needless kfree(cf_name)
>>>>>>> ---
>>>>>>>   fs/overlayfs/readdir.c | 113 ++++++++++++++++++++++++++++++++++++++++---------
>>>>>>>   1 file changed, 94 insertions(+), 19 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
>>>>>>> index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf14991e97cee169400d823b 100644
>>>>>>> --- a/fs/overlayfs/readdir.c
>>>>>>> +++ b/fs/overlayfs/readdir.c
>>>>>>> @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>>>>>>>        bool is_upper;
>>>>>>>        bool is_whiteout;
>>>>>>>        bool check_xwhiteout;
>>>>>>> +     const char *c_name;
>>>>>>> +     int c_len;
>>>>>>>        char name[];
>>>>>>>   };
>>>>>>>
>>>>>>> @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>>>>>>>        struct list_head *list;
>>>>>>>        struct list_head middle;
>>>>>>>        struct ovl_cache_entry *first_maybe_whiteout;
>>>>>>> +     struct unicode_map *map;
>>>>>>>        int count;
>>>>>>>        int err;
>>>>>>>        bool is_upper;
>>>>>>> @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
>>>>>>>        return rb_entry(n, struct ovl_cache_entry, node);
>>>>>>>   }
>>>>>>>
>>>>>>> +static int ovl_casefold(struct unicode_map *map, const char *str, int len, char **dst)
>>>>>>> +{
>>>>>>> +     const struct qstr qstr = { .name = str, .len = len };
>>>>>>> +     int cf_len;
>>>>>>> +
>>>>>>> +     if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len))
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     *dst = kmalloc(NAME_MAX, GFP_KERNEL);
>>>>>>> +
>>>>>>> +     if (dst) {
> 
> Andre,
> 
> Just noticed this is a bug, should have been if (*dst), but anyway following
> Gabriel's comments I have made this change in my tree (pending more
> strict related changes):
> 
> static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, int len,
>                          char **dst)
> {
>          const struct qstr qstr = { .name = str, .len = len };
>          char *cf_name;
>          int cf_len;
> 
>          if (!IS_ENABLED(CONFIG_UNICODE) || !rdd->map || is_dot_dotdot(str, len))
>                  return 0;
> 
>          cf_name = kmalloc(NAME_MAX, GFP_KERNEL);
>          if (!cf_name) {
>                  rdd->err = -ENOMEM;
>                  return -ENOMEM;
>          }
> 
>          cf_len = utf8_casefold(rdd->map, &qstr, *dst, NAME_MAX);
>          if (cf_len > 0)
>                  *dst = cf_name;
>          else
>                  kfree(cf_name);
> 
>          return cf_len;
> }

Right, that makes sense to me. I was unsure what to do regarding 
allocation fails, but this seems the right direction. Thanks!

> 
>>>>>>> +             cf_len = utf8_casefold(map, &qstr, *dst, NAME_MAX);
>>>>>>> +
>>>>>>> +             if (cf_len > 0)
>>>>>>> +                     return cf_len;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     kfree(*dst);
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I should just note this does not differentiates allocation errors from
>>>>>> casefolding errors (invalid encoding).  It might be just a theoretical
>>>>>> error because GFP_KERNEL shouldn't fail (wink, wink) and the rest of the
>>>>>> operation is likely to fail too, but if you have an allocation failure, you
>>>>>> can end up with an inconsistent cache, because a file is added under the
>>>>>> !casefolded name and a later successful lookup will look for the
>>>>>> casefolded version.
>>>>>
>>>>> Good point.
>>>>> I will fix this in my tree.
>>>>
>>>> wait why should we not fail to fill the cache for both allocation
>>>> and encoding errors?
>>>>
>>>
>>> We shouldn't fail the cache for encoding errors, just for allocation errors.
>>>
>>> Perhaps I am misreading the code, so please correct me if I'm wrong.  if
>>> ovl_casefold fails, the non-casefolded name is used in the cache.  That
>>> makes sense if the reason utf8_casefold failed is because the string
>>> cannot be casefolded (i.e. an invalid utf-8 string). For those strings,
>>> everything is fine.  But on an allocation failure, the string might have
>>> a real casefolded version.  If we fallback to the original string as the
>>> key, a cache lookup won't find the entry, since we compare with memcmp.
> 
> Just to make it clear in case the name "cache lookup" confuses anyone
> on this thread - we are talking about ovl readdir cache, not about the vfs
> lookup cache, the the purpose of ovl readdir cache is twofold:
> 1. plain in-memory readdir cache
> 2. (more important to this discussion) implementation of "merged dir" content
> 
> So I agree with you that with non-strict mode, invalid encoded names
> should be added to readdir cache as is and not in the case of allocation
> failure.
> 
>>
>> I was thinking again about this and I suspect I misunderstood your
>> question.  let me try to answer it again:
>>
>> Ext4, f2fs and tmpfs all allow invalid utf8-encoded strings in a
>> casefolded directory when running on non-strict-mode.  They are treated
>> as non-encoded byte-sequences, as if they were seen on a case-Sensitive
>> directory.  They can't collide with other filenames because they
>> basically "fold" to themselves.
>>
>> Now I suspect there is another problem with this series: I don't see how
>> it implements the semantics of strict mode.  What happens if upper and
>> lower are in strict mode (which is valid, same encoding_flags) but there
>> is an invalid name in the lower?  overlayfs should reject the dentry,
>> because any attempt to create it to the upper will fail.
> 
> Ok, so IIUC, one issue is that return value from ovl_casefold() should be
> conditional to the sb encoding_flags, which was inherited from the layers.
> 
> Again, *IF* I understand correctly, then strict mode ext4 will not allow
> creating an invalid-encoded name, but will strict mode ext4 allow
> it as a valid lookup result?
> 
>>
>> André, did you consider this scenario?
> 
> In general, as I have told Andre from v1, please stick to the most common
> configs that people actually need.
> 
> We do NOT need to support every possible combination of layers configurations.
> 
> This is why we went with supporting all-or-nothing configs for casefolder dirs.
> Because it is simpler for overlayfs semantics and good enough for what
> users need.
> 
> So my question is to you both: do users actually use strict mode for
> wine and such?
> Because if they don't I would rather support the default mode only
> (enforced on mount)
> and add support for strict mode later per actual users demand.
> 

I agree with Gabriel, no need to add this for Wine. We can refuse to 
mount to make things easier.

>> You can test by creating a file
>> with an invalid-encoded name in a casefolded directory of a
>> non-strict-mode filesystem and then flip the strict-mode flag in the
>> superblock.  I can give it a try tomorrow too.
> 
> Can the sb flags be flipped in runtime? while mounted?
> I suppose you are talking about an offline change that requires
> re-mount of overlayfs and re-validate the same encoding flags on all layers?
> 
> Andre,
> 
> Please also add these and other casefold functional tests to fstest to
> validate correctness of the merge dir implementation with different
> casefold variants in different layers.
> 

Ok, I will add a test case to stress mounting layers with different 
encoding versions, flags and etc.


