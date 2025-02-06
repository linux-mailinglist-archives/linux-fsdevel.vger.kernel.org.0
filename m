Return-Path: <linux-fsdevel+bounces-41001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E2A29F62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7225E3A04A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99277DA7F;
	Thu,  6 Feb 2025 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrtPkwnD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700C46BF
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812624; cv=none; b=BUYyVHkxyuppZLH+vrWx5zrZoUxKooYbTfgXAeBZUd+uq9czaLToSFitVF1FFLJ3yH9Fy+6i62bHpJRuhbzLmj7aSmvhY4+dOHg/C9gI781lRzOrggM5vPK13HhWwNR37Uvj3UAG359lwGm7Hz3YOUVqz2W/m9u03Sg1phuaqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812624; c=relaxed/simple;
	bh=dCHR8/pVBcAWICeQl9NTLgU7Y2XEVYgBtTKVqdPu9OE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=myHBv0XGT6yfYDgC9gZtCSZia0gKLy7ZJIsuF/dTRds9L+W+fL/7GK9D3on4c+9mCtHX1NrLPT7Uxul88SwhoDMpChUZBZdCVmRNtDJtn8Ub1GxSPhSwij1+zYunO9FU5NjhM7Og4AyykkMiL5BEdGpO/no0fWTYlTN0pRrYgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrtPkwnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82416C4CED1;
	Thu,  6 Feb 2025 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738812623;
	bh=dCHR8/pVBcAWICeQl9NTLgU7Y2XEVYgBtTKVqdPu9OE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OrtPkwnDBZiSyVQFNmQNUak10mWa/jZGxOKlhiPDGOKEyPi4s7Ab0D6r4QitRRPdj
	 9X0JvWzGAXQJPM1Svam9G58ArR3RNxuUDyX3ttf6lEGfUlP0/fAp0vGK5IeOnxsNhX
	 4fn5Ta6tZivoxHxocVqyrclQdctGG65fVqGpUyNnZEexOEAVeRd4mf+CAbmXj+EYd5
	 a3K33TPywDbyC3GSYqE/Y5+e0mLnGAX5Km+9djbxJCLR1fW1DM5FjHt9rqNIuvMhp+
	 wX8kBNePoWrWOo1uja8U57IQ0xcSqmnIL6P9AWqL6zS7Ctf9rC7CttALAqQbV/ayOt
	 /a40pQeWRHESg==
Date: Wed, 05 Feb 2025 19:30:20 -0800
From: Kees Cook <kees@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org
CC: viro@zeniv.linux.org.uk, neilb@suse.de, ebiederm@xmission.com,
 tony.luck@intel.com
Subject: Re: [PATCH 1/4] pstore: convert to the new mount API
User-Agent: K-9 Mail for Android
In-Reply-To: <57a9557f-c895-466f-afaa-a40bf818e250@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com> <20250205213931.74614-2-sandeen@redhat.com> <DD66BE90-95CD-4F75-AD47-50E869460482@kernel.org> <57a9557f-c895-466f-afaa-a40bf818e250@redhat.com>
Message-ID: <FC784258-9C61-44C2-B24F-5EDA66EF0832@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 5, 2025 6:19:06 PM PST, Eric Sandeen <sandeen@redhat=2Ecom> wr=
ote:
>On 2/5/25 8:04 PM, Kees Cook wrote:
>>> @@ -431,19 +434,33 @@ static int pstore_fill_super(struct super_block =
*sb, void *data, int silent)
>>> 		return -ENOMEM;
>>>
>>> 	scoped_guard(mutex, &pstore_sb_lock)
>>> -		pstore_sb =3D sb;
>>> +	pstore_sb =3D sb;
>> Shouldn't scoped_guard() induce a indent?
>
>Whoops, not sure how that happened, sorry=2E
>
>Fix on commit or send V2?

If I should carry it in pstore, a v2 is appreciated=2E If you're taking it=
 via fs, fix on commit is fine by me=2E :)

>
>>> 	pstore_get_records(0);
>>>
>>> 	return 0;
>>> }
>>>
>>> -static struct dentry *pstore_mount(struct file_system_type *fs_type,
>>> -	int flags, const char *dev_name, void *data)
>>> +static int pstore_get_tree(struct fs_context *fc)
>>> +{
>>> +	if (fc->root)
>>> +		return pstore_reconfigure(fc);
>
>> I need to double check that changing kmsg_size out from under an active=
 pstore won't cause problems, but it's probably okay=2E (Honestly I've been=
 wanting to deprecate it as a mount option -- it really should just be a mo=
dule param, but that's a separate task=2E)
>
>Honestly I struggled with this for a while, not quite sure what's right=
=2E

I found the place I need to fix, but it's an existing problem and won't co=
nflict=2E I'll get it fixed=2E

-Kees

>
>> Reviewed-by: Kees Cook <kees@kernel=2Eorg>
>
>Thanks,
>-Eric
>
>> (Is it easier to take this via fs or via pstore?)
>>=20
>> -Kees
>

--=20
Kees Cook

