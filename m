Return-Path: <linux-fsdevel+bounces-40344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5FCA225A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703F21886E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785481E376E;
	Wed, 29 Jan 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HWIcm2I6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC71946A1;
	Wed, 29 Jan 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185983; cv=none; b=iEbiqEXTZLW6WEr3hrh7xZdr82Qauz28hk+xawu3oc/i4hlEeSsmwmvH9t4W4NZbExXJD+piDQoq7xJsWhwi27YtdCcrt9ucQiAlFeUNWjkHuvT+j5nv+vyKFkbMcL1DY+Dcz6MTG2WxXEoxyVRB/l1H2VfhNKD8tM+f9G/EgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185983; c=relaxed/simple;
	bh=byvzvZ4nrjtenuUX2lDK4vlgPILOmRf2eNio8SV79iM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m56z3JHV8rhXK/2RbgJgBKwxGcs9QVysCdtCOfsh2jiMY+8WxH95BJ10jqps3EIUyw9zqWQR0PYZxAHOL1/vTWOL/aVp9kfBE5sgzdRmKtqDJ0j27B4kGA9ZXYRuDGAR5NkEv5bDQN0IZ91HC+WGc6dNuhGVHg5FXR24k/dodHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HWIcm2I6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uiFP+ASZV/Dz+L0pnEo/cVSLCLFclGVt8Lwa+muaxSk=; b=HWIcm2I6bfgY58V7B67PhpBptQ
	wjvnbTVxQqTuZO7mV0HBV3mkMx5FsnWssRKh5bezQ0pMD3SwIDnPaQ+lezRvu4PzkvdiD56G4qIwj
	ekrMnQflqhlDi+KxCXzzQEiI5sxEmYuPwFTAjpKPti6zHYVESIX8f+I1kQ12/cgXsfEW54voUW742
	luAWM7bCYxDIHQSO2y5gshWsvRG/yaj4nP6Eei968sr1JohwlYC1TUz45lWtlloNX6h4CR0a0WCO7
	1bIdb0P4LXtJ+8QSYH93ELsXgrnyKw9Llj1aRpCLp8QhX3n+RqdwgI20bvWD0NRGVz/YRms/eSmZ7
	0z61h4Vg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tdFZY-000lpn-VB; Wed, 29 Jan 2025 22:26:14 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Teng Qin <tqin@jumptrading.com>
Subject: Re: [RFC PATCH] fuse: fix race in fuse_notify_store()
In-Reply-To: <efba1076-d14c-488b-954a-856e0427f917@bsbernd.com> (Bernd
	Schubert's message of "Wed, 29 Jan 2025 20:30:56 +0100")
References: <20250129184420.28417-1-luis@igalia.com>
	<efba1076-d14c-488b-954a-856e0427f917@bsbernd.com>
Date: Wed, 29 Jan 2025 21:26:14 +0000
Message-ID: <87ldut5n2h.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

On Wed, Jan 29 2025, Bernd Schubert wrote:

> Hi Luis,
>
> On 1/29/25 19:44, Luis Henriques wrote:
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 27ccae63495d..9a0cd88a9bb9 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1630,6 +1630,7 @@ static int fuse_notify_store(struct fuse_conn *fc,=
 unsigned int size,
>>  	unsigned int num;
>>  	loff_t file_size;
>>  	loff_t end;
>> +	int fgp_flags =3D FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
>>=20=20
>>  	err =3D -EINVAL;
>>  	if (size < sizeof(outarg))
>> @@ -1645,6 +1646,9 @@ static int fuse_notify_store(struct fuse_conn *fc,=
 unsigned int size,
>>=20=20
>>  	nodeid =3D outarg.nodeid;
>>=20=20
>> +	if (outarg.flags & FUSE_NOTIFY_STORE_NOWAIT)
>> +		fgp_flags |=3D FGP_NOWAIT;
>> +
>>  	down_read(&fc->killsb);
>>=20=20
>>  	err =3D -ENOENT;
>> @@ -1668,14 +1672,25 @@ static int fuse_notify_store(struct fuse_conn *f=
c, unsigned int size,
>>  		struct page *page;
>>  		unsigned int this_num;
>>=20=20
>> -		folio =3D filemap_grab_folio(mapping, index);
>> -		err =3D PTR_ERR(folio);
>> -		if (IS_ERR(folio))
>> -			goto out_iput;
>> +		folio =3D __filemap_get_folio(mapping, index, fgp_flags,
>> +					    mapping_gfp_mask(mapping));
>> +		err =3D PTR_ERR_OR_ZERO(folio);
>> +		if (err) {
>> +			if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT))
>> +				goto out_iput;
>> +			page =3D NULL;
>> +			/* XXX */
>
> What is the XXX for?=20

Right, I guess I should have added extra info there.  I just wanted to
point out that I'm not sure about the value to use for the min_t():

  - If we have a folio, I believe it's clear that we should use
    (offset will always be '0' except for the first iteration);
  - If we don't have a folio, I'm using PAGE_SIZE

I *think* that's the correct value.  But I may be wrong.

> Also, I think you want to go to "skip" only on -EAGAIN? And if so, need
> to unset err?=20

Ah, good point!  Thanks!  So, something like this should fix it:

		if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT) || err !=3D -EAGAIN)
			goto out_iput;

I'll wait until tomorrow before sending v2 because I was hoping to also
have some feedback on the idea of completely dropping the use of the
NOWAIT flag.  Not sure you have some opinion about it, or maybe Miklos, as
this patch was originally from him.

Cheers,
--=20
Lu=C3=ADs

>> +			this_num =3D min_t(unsigned int, num, PAGE_SIZE - offset);
>> +		} else {
>> +			page =3D &folio->page;
>> +			this_num =3D min_t(unsigned int, num,
>> +					 folio_size(folio) - offset);
>> +		}
>>=20=20
>> -		page =3D &folio->page;
>> -		this_num =3D min_t(unsigned, num, folio_size(folio) - offset);
>>  		err =3D fuse_copy_page(cs, &page, offset, this_num, 0);
>> +		if (!page)
>> +			goto skip;
>> +
>>  		if (!folio_test_uptodate(folio) && !err && offset =3D=3D 0 &&
>>  		    (this_num =3D=3D folio_size(folio) || file_size =3D=3D end)) {
>>  			folio_zero_segment(folio, this_num, folio_size(folio));
>> @@ -1683,7 +1698,7 @@ static int fuse_notify_store(struct fuse_conn *fc,=
 unsigned int size,
>>  		}
>>  		folio_unlock(folio);
>>  		folio_put(folio);
>> -
>> +skip:
>>  		if (err)
>>  			goto out_iput;
>>=20=20
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index e9e78292d107..59725f89340e 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -576,6 +576,12 @@ struct fuse_file_lock {
>>   */
>>  #define FUSE_EXPIRE_ONLY		(1 << 0)
>>=20=20
>> +/**
>> + * notify_store flags
>> + * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
>> + */
>> +#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
>> +
>>  /**
>>   * extension type
>>   * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
>> @@ -1075,7 +1081,7 @@ struct fuse_notify_store_out {
>>  	uint64_t	nodeid;
>>  	uint64_t	offset;
>>  	uint32_t	size;
>> -	uint32_t	padding;
>> +	uint32_t	flags;
>>  };
>>=20=20
>>  struct fuse_notify_retrieve_out {
>>=20
>
> Thanks,
> Bernd
>

