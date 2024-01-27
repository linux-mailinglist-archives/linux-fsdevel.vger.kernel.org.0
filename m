Return-Path: <linux-fsdevel+bounces-9151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5F83E86C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263DA1F229AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2F64A;
	Sat, 27 Jan 2024 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ke2UJyvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08A370;
	Sat, 27 Jan 2024 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315112; cv=none; b=NGhg5sE8zy45c1oo8XsaMrVa0oGLHe/ymPLKPpWFvvpCPNl5LJzrPk2VmqnQs4pwEZZapUyIIC39Tj+airl20rZkrk4dZgyUsR51eqMFNhvfhfOwVv3UUdfnAcSXd8XAIR6lJkZEok/12Bs+R6MDaeDf0muyVAi0/ARN+LbycPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315112; c=relaxed/simple;
	bh=Pp2dkrvI3a+XAecsEBVlUohWyE+iC8npvaxRWXehryM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZ+sBwrhrb9xWxgFV1U4ydq0s0cIxZUAoGZaLVPV5IvHm7knPUhch+amXfrndXjkSJVJiLkqD4kAneWmlAPE67YHCGgJTBkbOzo+Op3yW8vcnibIqOu5zvsqg9YTLxYo8qU6Qm9Qv20y640skPzHSjF9CpTEIywXyrniC3ARtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ke2UJyvK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706315110; x=1737851110;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Pp2dkrvI3a+XAecsEBVlUohWyE+iC8npvaxRWXehryM=;
  b=Ke2UJyvKMtw3PhuCHfTiPhynLokxfdb7naMTs6xY0Tntrsiibwtl2dwv
   HrkWB+RvhRyj+OwKqqJU6PjJ35uGPJEleLfBIF7aTngv5igF/P/u6YqTo
   WrXibWd30x+Q/ubWgLVrMZ77wgCxFOOnm2uubTTqmbUKGZzeKDAeIfGdA
   HMGu8Ift/wuPZgOB6KgtqugVZ/3Q34XUIw+M1eTWfLxw9s7HViOQFxJqy
   CuquQ4ew9Z8LdvVqqzxmjhcvHOaYavn1NChpNRe8MiI3u08Dp5MQ/tnMh
   H2eQquNKkbSwHKE4YefGoc9xPWGo0hQYTaIBME1SqUfjynTkPz8COnd8l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15981078"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="15981078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930517372"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="930517372"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:25:08 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC v2 4/4] fs: Optimize credentials reference count for
 backing file ops
In-Reply-To: <CAOQ4uxi7MtVZECGXo-30YWjSU5ZFZP0AQzgBXLyowdOmNUc5DA@mail.gmail.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
 <20240125235723.39507-5-vinicius.gomes@intel.com>
 <CAOQ4uxi7MtVZECGXo-30YWjSU5ZFZP0AQzgBXLyowdOmNUc5DA@mail.gmail.com>
Date: Fri, 26 Jan 2024 16:25:08 -0800
Message-ID: <87mssr4o7v.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> For backing file operations, users are expected to pass credentials
>> that will outlive the backing file common operations.
>>
>> Use the specialized guard statements to override/revert the
>> credentials.
>>
>
> As I wrote before, I prefer to see this patch gets reviewed and merged
> before the overlayfs large patch, so please reorder the series.
>

Sure. Will do.

>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  fs/backing-file.c | 124 ++++++++++++++++++++++------------------------
>>  1 file changed, 60 insertions(+), 64 deletions(-)
>>
>> diff --git a/fs/backing-file.c b/fs/backing-file.c
>> index a681f38d84d8..9874f09f860f 100644
>> --- a/fs/backing-file.c
>> +++ b/fs/backing-file.c
>> @@ -140,7 +140,7 @@ ssize_t backing_file_read_iter(struct file *file, st=
ruct iov_iter *iter,
>>                                struct backing_file_ctx *ctx)
>>  {
>>         struct backing_aio *aio =3D NULL;
>> -       const struct cred *old_cred;
>> +       const struct cred *old_cred =3D ctx->cred;
>>         ssize_t ret;
>>
>>         if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
>> @@ -153,29 +153,28 @@ ssize_t backing_file_read_iter(struct file *file, =
struct iov_iter *iter,
>>             !(file->f_mode & FMODE_CAN_ODIRECT))
>>                 return -EINVAL;
>>
>> -       old_cred =3D override_creds(ctx->cred);
>> -       if (is_sync_kiocb(iocb)) {
>> -               rwf_t rwf =3D iocb_to_rw_flags(flags);
>> +       scoped_guard(cred, old_cred) {
>
> This reads very strage.
>
> Also, I see that e.g. scoped_guard(spinlock_irqsave, ... hides the local =
var
> used for save/restore of flags inside the macro.
>
> Perhaps you use the same technique for scoped_guard(cred, ..
> loose the local old_cred variable in all those functions and then the
> code will read:
>
> scoped_guard(cred, ctx->cred) {
>
> which is nicer IMO.

Most likely using DEFINE_LOCK_GUARD_1() would allow us to use the nicer ver=
sion.

>
>> +               if (is_sync_kiocb(iocb)) {
>> +                       rwf_t rwf =3D iocb_to_rw_flags(flags);
>>
>> -               ret =3D vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
>> -       } else {
>> -               ret =3D -ENOMEM;
>> -               aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL=
);
>> -               if (!aio)
>> -                       goto out;
>> +                       ret =3D vfs_iter_read(file, iter, &iocb->ki_pos,=
 rwf);
>> +               } else {
>> +                       ret =3D -ENOMEM;
>> +                       aio =3D kmem_cache_zalloc(backing_aio_cachep, GF=
P_KERNEL);
>> +                       if (!aio)
>> +                               goto out;
>>
>> -               aio->orig_iocb =3D iocb;
>> -               kiocb_clone(&aio->iocb, iocb, get_file(file));
>> -               aio->iocb.ki_complete =3D backing_aio_rw_complete;
>> -               refcount_set(&aio->ref, 2);
>> -               ret =3D vfs_iocb_iter_read(file, &aio->iocb, iter);
>> -               backing_aio_put(aio);
>> -               if (ret !=3D -EIOCBQUEUED)
>> -                       backing_aio_cleanup(aio, ret);
>> +                       aio->orig_iocb =3D iocb;
>> +                       kiocb_clone(&aio->iocb, iocb, get_file(file));
>> +                       aio->iocb.ki_complete =3D backing_aio_rw_complet=
e;
>> +                       refcount_set(&aio->ref, 2);
>> +                       ret =3D vfs_iocb_iter_read(file, &aio->iocb, ite=
r);
>> +                       backing_aio_put(aio);
>> +                       if (ret !=3D -EIOCBQUEUED)
>> +                               backing_aio_cleanup(aio, ret);
>> +               }
>
> if possible, I would rather avoid all this churn in functions that mostly
> do work with the new cred, so either use guard(cred, ) directly or split a
> helper that uses guard(cred, ) form the rest.
>

Yeah, I think what happened is that I tried to keep the scope of the
guard to be as close as possible to override/revert (as you said), and
that caused the churn.

Probably using guard() more will reduce these confusing code changes. I
am going to try that.

> Thanks,
> Amir.


Cheers,
--=20
Vinicius

