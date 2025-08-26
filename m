Return-Path: <linux-fsdevel+bounces-59318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBBB373A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD4E1BA3B96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B4350D4F;
	Tue, 26 Aug 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qaFzo/Pk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A4255F39;
	Tue, 26 Aug 2025 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239175; cv=none; b=S1X6mJfsCSYJCZm9HwOWu5/AHaAB2N5d2aimo3xFgoPiKoe/EQSudHcoierRcAikqZsjKVy0IGSjP+mVKfLRBCFEdAPD/ywgVwtkM/WM6Ds986JJG+WoVjtfy8AokBeyxxiMQAX3awIhHLZA32aS4mcAsiyOSxTIb/h+sH4jx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239175; c=relaxed/simple;
	bh=8BDrteIu6RKGvehoR5t9k19e43gTXbjPoGrqQ9bHSOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1UzkMNf8g8J5wK7cxvMRIjw/GEeklXHGKSi0qqKYZO83EvNPevmC5oq23MRGt0JzPBbqdxEuvKcnu+SO4sXH0nH6H/fzGCbt6lTx6BCUjPss97YxZXS4fYhvBDJJr6y/wGxDg8nWzpAyv4PgMXOe6H/whkYUuxYTMW4vRZbPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qaFzo/Pk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZqnQ4tD//8si1T3YEohZAEVIA7Jzki5KAKeWQZFL33k=; b=qaFzo/PkK8QIuoFULthbe1gPgu
	Ur2NbWIIk+gsQ7h0TcViqcYLbai6IUrTDVubuFktSzl187MO42FKkpTIA6kuJ4Xlh966JTQc57Ocf
	c885wiApqIk3/YjhxSVKuK8k3PpPN9lPn2NJu1KHjT7xmsjKhvA/lpwf3yxXmX6C8eP7Veh8kg3CM
	C/i0mwoR+nyfauVFwoEXilKPpD/bMOSHpj6/VjlS/Jbu89etL1UeeDDzaMdZ7OjoE8Pq8d6I569kM
	SLrHIfvyv0fAD+OSBKDl7UO72sbWfvRLZ787iMwR0Bxd1MoRLtWpuaPI1nuymcp/5lp+EzZN87dx3
	ODutHuEQ==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ur02A-0025Mt-SZ; Tue, 26 Aug 2025 22:12:47 +0200
Message-ID: <bcc8ad0c-669f-4f0d-a795-ec55bb498ef7@igalia.com>
Date: Tue, 26 Aug 2025 17:12:43 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] ovl: Ensure that all layers have the same encoding
To: Amir Goldstein <amir73il@gmail.com>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-5-8b6e9e604fa2@igalia.com>
 <871poz647l.fsf@mailhost.krisman.be>
 <CAOQ4uxjexmFyfGuzuVsCmheqM_2drVsLUm3Fifv1we5u39WveA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxjexmFyfGuzuVsCmheqM_2drVsLUm3Fifv1we5u39WveA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Em 25/08/2025 12:32, Amir Goldstein escreveu:
> On Mon, Aug 25, 2025 at 1:17 PM Gabriel Krisman Bertazi
> <gabriel@krisman.be> wrote:
>>
>> André Almeida <andrealmeid@igalia.com> writes:
>>
>>> When merging layers from different filesystems with casefold enabled,
>>> all layers should use the same encoding version and have the same flags
>>> to avoid any kind of incompatibility issues.
>>>
>>> Also, set the encoding and the encoding flags for the ovl super block as
>>> the same as used by the first valid layer.
>>>
>>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>> ---
>>>   fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>>> index df85a76597e910d00323018f1d2cd720c5db921d..b1dbd3c79961094d00c7f99cc622e515d544d22f 100644
>>> --- a/fs/overlayfs/super.c
>>> +++ b/fs/overlayfs/super.c
>>> @@ -991,6 +991,18 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
>>>        return ofs->numfs;
>>>   }
>>>
>>> +/*
>>> + * Set the ovl sb encoding as the same one used by the first layer
>>> + */
>>> +static void ovl_set_encoding(struct super_block *sb, struct super_block *fs_sb)
>>> +{
>>> +#if IS_ENABLED(CONFIG_UNICODE)
>>> +     if (sb_has_encoding(fs_sb)) {
>>> +             sb->s_encoding = fs_sb->s_encoding;
>>> +             sb->s_encoding_flags = fs_sb->s_encoding_flags;
>>> +     }
>>> +#endif
>>> +}
>>>
>>>   static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
>>>                          struct ovl_fs_context *ctx, struct ovl_layer *layers)
>>> @@ -1024,6 +1036,9 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
>>>        if (ovl_upper_mnt(ofs)) {
>>>                ofs->fs[0].sb = ovl_upper_mnt(ofs)->mnt_sb;
>>>                ofs->fs[0].is_lower = false;
>>> +
>>> +             if (ofs->casefold)
>>> +                     ovl_set_encoding(sb, ofs->fs[0].sb);
>>>        }
>>>
>>>        nr_merged_lower = ctx->nr - ctx->nr_data;
>>> @@ -1083,6 +1098,16 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
>>>                l->name = NULL;
>>>                ofs->numlayer++;
>>>                ofs->fs[fsid].is_lower = true;
>>> +
>>> +             if (ofs->casefold) {
>>> +                     if (!ovl_upper_mnt(ofs) && !sb_has_encoding(sb))
>>> +                             ovl_set_encoding(sb, ofs->fs[fsid].sb);
>>> +
>>> +                     if (!sb_has_encoding(sb) || !sb_same_encoding(sb, mnt->mnt_sb)) {
>>
>> Minor nit, but isn't the sb_has_encoding()  check redundant here?  sb_same_encoding
>> will check the sb->encoding matches the mnt_sb already.
> 
> Maybe we did something wrong but the intention was:
> If all layers root are casefold disabled (or not supported) then
> a mix of layers with fs of different encoding (and fs with no encoding support)
> is allowed because we take care that all directories are always
> casefold disabled.
> 

We are going to reach this code only if ofs->casefold is true, so that 
means that ovl_dentry_casefolded() was true, and that means that 
sb_has_encoding(dentry->d_sb) is also true... so I think that Gabriel is 
right, if we reach this part of the code, that means that casefold is 
enabled and being used by at least one layer, so we can call 
sb_same_encoding() to check if they are consistent for all layers.

For the case that we don't care about the layers having different 
encoding, the code will already skip this because of if (ofs->casefold)

> Thanks,
> Amir.


