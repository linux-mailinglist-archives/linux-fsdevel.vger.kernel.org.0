Return-Path: <linux-fsdevel+bounces-59319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93550B373AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D481BA3C76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11E36C089;
	Tue, 26 Aug 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kHX46aF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7932F617B;
	Tue, 26 Aug 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239216; cv=none; b=cQF9ip94JUGzgPAAIbjfoEH6Ku/pM/p1IkCJwyhT/g0jYJkJpfjg1op7zwnbHZ1ZzbWW/5N74nnqrijjCwTnvGNjBTGM7Wm7le6AKKicQ9VOOHIU85w4+0f2lamVaPThQXyM9C0FU09hiajhAyTJAytrBqU48y5fDyVE16X+K3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239216; c=relaxed/simple;
	bh=747eHocCfsCXBtIKywwzJa65EUHobTy67jD+hkex9J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP/yRXNjAjC0tc6Uhfe+8SFatzZhilczx7iIpbw/RBR1RpmIk1/Pe9QU5WHOO1tD4xZ8/gKdqT6zJHu9oiF4+zO4PY2LyuTJ8jPCiCw8KUfilhZvOLRQVZlm0Uzj42BtN4zWjxJ3RuRFRVU1QpoTNV4aTpoawdFXES0PQfQp8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kHX46aF+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WbaCLDq3PXrvsNvohX1K/gq1TVWTxamq6WGTMZzTmBk=; b=kHX46aF+2u+WkQVfm9d0FdJj+h
	G3gMrDcglY6O6Fb3C1uWOaSeZNIUWDqjW+9SbzwtkKF+pz2osuAD3SjaNcqDAzagPi2TBNDX6X+Oh
	VidiUBIRZhxuNABpSrXcJBvtEb8JjytWjzfB5nIrqay3biwH4L+JI+3ud+LIWTuRmoCI7L6uXwr4l
	mczfkDwaK/jssXbpo7O36VljUcCmRZxsZ8/lChl51S21EByti969HcAIPEjS7BEibmsfrg021IyKB
	JCsBb8RytB5EU4NbGHQ8xLGF6U2sVauXwmUyo/QN20S27XWO64L1u5kkRZgDB8i9PDOVxHYpZ11vn
	JfvJESFQ==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ur02s-0025Nu-Dq; Tue, 26 Aug 2025 22:13:30 +0200
Message-ID: <a29eec78-1e40-4ade-8b23-b44c3f72bee2@igalia.com>
Date: Tue, 26 Aug 2025 17:13:26 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ovl: Set case-insensitive dentry operations for
 ovl sb
To: Amir Goldstein <amir73il@gmail.com>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-6-8b6e9e604fa2@igalia.com>
 <87wm6r4pbf.fsf@mailhost.krisman.be>
 <CAOQ4uxjBcwhOfbR2cCmQgQFMLDwoxfiTMMBHtGejm=m5mtz-xg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxjBcwhOfbR2cCmQgQFMLDwoxfiTMMBHtGejm=m5mtz-xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Em 25/08/2025 12:34, Amir Goldstein escreveu:
> On Mon, Aug 25, 2025 at 1:24 PM Gabriel Krisman Bertazi
> <gabriel@krisman.be> wrote:
>>
>> André Almeida <andrealmeid@igalia.com> writes:
>>
>>> For filesystems with encoding (i.e. with case-insensitive support), set
>>> the dentry operations for the super block as ovl_dentry_ci_operations.
>>>
>>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>> ---
>>> Changes in v6:
>>> - Fix kernel bot warning: unused variable 'ofs'
>>> ---
>>>   fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>>> index b1dbd3c79961094d00c7f99cc622e515d544d22f..8db4e55d5027cb975fec9b92251f62fe5924af4f 100644
>>> --- a/fs/overlayfs/super.c
>>> +++ b/fs/overlayfs/super.c
>>> @@ -161,6 +161,16 @@ static const struct dentry_operations ovl_dentry_operations = {
>>>        .d_weak_revalidate = ovl_dentry_weak_revalidate,
>>>   };
>>>
>>> +#if IS_ENABLED(CONFIG_UNICODE)
>>> +static const struct dentry_operations ovl_dentry_ci_operations = {
>>> +     .d_real = ovl_d_real,
>>> +     .d_revalidate = ovl_dentry_revalidate,
>>> +     .d_weak_revalidate = ovl_dentry_weak_revalidate,
>>> +     .d_hash = generic_ci_d_hash,
>>> +     .d_compare = generic_ci_d_compare,
>>> +};
>>> +#endif
>>> +
>>>   static struct kmem_cache *ovl_inode_cachep;
>>>
>>>   static struct inode *ovl_alloc_inode(struct super_block *sb)
>>> @@ -1332,6 +1342,19 @@ static struct dentry *ovl_get_root(struct super_block *sb,
>>>        return root;
>>>   }
>>>
>>> +static void ovl_set_d_op(struct super_block *sb)
>>> +{
>>> +#if IS_ENABLED(CONFIG_UNICODE)
>>> +     struct ovl_fs *ofs = sb->s_fs_info;
>>> +
>>> +     if (ofs->casefold) {
>>> +             set_default_d_op(sb, &ovl_dentry_ci_operations);
>>> +             return;
>>> +     }
>>> +#endif
>>> +     set_default_d_op(sb, &ovl_dentry_operations);
>>> +}
>>> +
>>>   int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>>>   {
>>>        struct ovl_fs *ofs = sb->s_fs_info;
>>> @@ -1443,6 +1466,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>>>        if (IS_ERR(oe))
>>>                goto out_err;
>>>
>>> +     ovl_set_d_op(sb);
>>> +
>>
>> Absolutely minor, but fill_super is now calling
>> set_default_d_op(sb, &ovl_dentry_operations) twice, once here and once
>> at the beginning of the function.  You can remove the original call.
> 
> Good catch!
> 
> That was not my intention at all.
> I asked to replace the set_default_d_op() call with ovl_set_d_op()
> but I missed that in the review.
> 
> Will fix it in my tree.
> 

Ops, my bad. Thank you for the fix :)

> Thanks!
> Amir.


