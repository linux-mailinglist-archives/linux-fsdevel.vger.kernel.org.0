Return-Path: <linux-fsdevel+bounces-11175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80A851C56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0769284715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D934176D;
	Mon, 12 Feb 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LRiaR+iH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187841776
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760624; cv=none; b=noLesTIjdL+HvVeVYbSNdGQqaqFdZ0S8JxL+xC5J8X1Qr+/f02uUGa743GldCVwJ28DcZ9IeXKglhsSK2k9fbHYWTj2tVqNMLobVS8QeaEXbrUEgaHNnGdhqCJTHbFFL3IwF1k5cAtzZmjTn+AkU7cBZn2UqFkN13ZoOiqvFZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760624; c=relaxed/simple;
	bh=GO+XqADvFPujimGfIAAMQ9biA+SOVkTb0kZua4dtRds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF7cGxZrGjigl9ewY3MJSKtW0Mi5mz6z92GuIK6HcEzAECM9gyv2dq3y2s/qXrMx/Pr/kN188qap7Tps/B2SF2RmFZfC5tJ8fTTNOEWBFuSQKxAV9Rrobk8QxNQuNRPhhJlfKGFQl7bgOObnrOzZsk1TFIUsT6YnWXUz3AcGIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LRiaR+iH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60779014458so4117497b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707760621; x=1708365421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GywgT/kIpRIiEaoNj7SzkmI6fseY2YuE7XBhiV1W3IM=;
        b=LRiaR+iHlnh9kzMtOaWL8uSftEEFJ52PPgddWsecZFY4BgcuAlwZK4R4dL/SZh1mrE
         Y2w7AzzbskSyTKL8jhIgfcCH1JKlqWdBJlWj/6pLDwhsGSvJ7JPrbBN/CwPj5looxEM8
         lHZ/TNidgCuBjffnQET4rpNppKqx732X6YNmBP9YmEE6Nx0uqWgRwx5aZdrWcv/7bfLq
         S6kD2XXIyP+9wPD23o3fFt4nVhgPZe6OizA3ViMyaIA5hEaSQcPiCDVyBqqBaNJARkg+
         GEz0ooTgJSysfQSHZSy7xILJ+U8sJOILqkDOKoayxnGfmKzmn0lxKxGLankZqDCiZa/w
         RTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760621; x=1708365421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GywgT/kIpRIiEaoNj7SzkmI6fseY2YuE7XBhiV1W3IM=;
        b=r7PN+NWMdCw8FOHkJAEN1H/QiL1G39fCkpv4uAhdhqC3y5tuwMQGsXAGSThIGYoc8D
         qpV1JN/nyxcbUGWwManENnFVvv3euP38oUAiydBOhzRZJfsc7oabd3irbNq6uSLa4Bq3
         uBQgvJ0bTTQo71EdND9i8MZQ+ef3UdsH2EoCNFCYGS2hmG9kRfiabYUwO6FUQar0wO7N
         xZkldv4LKsshjbcysFxyWLQ6cJCy49kFKXxRui79HG4oovy9nPSLjur9NhhRkvUYvpWl
         3RJ/b0WAh8/I3KzNVwi/Pbtbvr0vwgeP6OyyxVSGrGbb/u3mRWgJ2HY27MRh2jek14qs
         8xJA==
X-Gm-Message-State: AOJu0Yx4bupFDErqbxmLT/WNtFsWOyer9JtHgJY7Y0JhMGWoHEITrn4l
	mrySU+1C1hArEsoebBSKz8oK4wNoCg2KDJo+ZXSd/GfPOdAs3zzmDceldp+4oC9KuPcRf9Sh/oS
	BVK3o6xgKIi9XXKcPopNXZgZC9y8kYmo/lwow
X-Google-Smtp-Source: AGHT+IGjhdaYUNjwcSJFIvuNyHx9uH/3Qz50J2Oo2Jf2sLDKqyYEZrikDyUgVsDTlP7Ry4VIyaFcE3Lr2B40t4UjJbg=
X-Received: by 2002:a81:d507:0:b0:5ff:aa34:7c5f with SMTP id
 i7-20020a81d507000000b005ffaa347c5fmr4677040ywj.46.1707760621630; Mon, 12 Feb
 2024 09:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-20-roberto.sassu@huaweicloud.com> <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
In-Reply-To: <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Feb 2024 12:56:50 -0500
Message-ID: <CAHC9VhTY=X7z5SRQZzFe25FGB2E3FBBkuZ_YYA1+ETyr7pv=tA@mail.gmail.com>
Subject: Re: [PATCH v9 19/25] integrity: Move integrity_kernel_module_request()
 to IMA
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	shuah@kernel.org, mic@digikod.net, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:48=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
> On 1/15/24 13:18, Roberto Sassu wrote:

...

> > +/**
> > + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
> > + * @kmod_name: kernel module name
> > + *
> > + * We have situation, when public_key_verify_signature() in case of RS=
A > + * algorithm use alg_name to store internal information in order to
> > + * construct an algorithm on the fly, but crypto_larval_lookup() will =
try
> > + * to use alg_name in order to load kernel module with same name.
> > + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel module=
s,
> > + * we are safe to fail such module request from crypto_larval_lookup()=
.
> > + *
> > + * In this way we prevent modprobe execution during digsig verificatio=
n
> > + * and avoid possible deadlock if modprobe and/or it's dependencies
> > + * also signed with digsig.
>
> This text needs to some reformulation at some point..

There is no time like the present.  If you have a suggestion I would
love to hear it and I'm sure Roberto would too.

--=20
paul-moore.com

