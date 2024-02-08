Return-Path: <linux-fsdevel+bounces-10774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F684E2F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A471C237C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 14:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA3B77F33;
	Thu,  8 Feb 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cpIHrnvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075A763F4
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401822; cv=none; b=Gvj+vgGSBc/heA7glCupsSWMxPHwbSOXpZbS3yl+98Xgr2o8Z5izq1vuJU46FqojM55tGtbaAq5TtYYlMFFpmWKY1slDXl87qgowstsAGkUCG20nV8QcNAi69Lv3EVscXpBJbLsLn7Cy3DcYmehv85ryBefSCAbAKKTbShuwgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401822; c=relaxed/simple;
	bh=ujj/RLFDfuqS7PIZP68+3l/KZkd1KHttxlgRuGySCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8gzT6/CA4688WxrOzup+HvX2qJejkgKuh3/eA2xDe0ogJlTAd0D83Bu8+3SD9L62k55fZrDg9FJ3HL7ETl3ehruonSVtPNe05CGJieO0KsL4PThOLNSTmbyqn/T3obJ8sZ/bqnAR20+t4z/90XcLCDAK19cioK930h2IabJPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cpIHrnvw; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed179f0faso691637276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 06:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707401819; x=1708006619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rHe4xV1s4X4NVlAmyq1Fqck0kWWWvVIv4qB+Ky5Oo4=;
        b=cpIHrnvwduqrSfAbUDvwcTPVwb8rM5uk1zLq3xwzi1+jkLLXKNesv/zHRV50VOFZaB
         mjlVz2xq0Xc8wRbbScpCr3Wh5pqRY9CZuD3kTn2yTGmzl+o8rE0z/xm05jjVGkOWGawM
         Xxxv8E2Gc9w3bLvEcWitgQLLWHaZUaDvduZSg9GuLo7L3cKhJ5uJxf6emmisiriIiips
         pdVU8EKnp07svFd9da5oSFwwvxUFKN4N4Lb4ISOGhVuRuy+FWj1WfqwXv6Nb3t+CYuAw
         QNYIU7wJoFpclTxaQAF4DVT9S3X15ml/BEDGJMv/ATW8HrjwHnYfPjXqKrRyICCe0GOf
         InRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401819; x=1708006619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rHe4xV1s4X4NVlAmyq1Fqck0kWWWvVIv4qB+Ky5Oo4=;
        b=NVRcAhdZmieqyc0KB07X+vkhJ589IdGCaE5naM9PoQQBbydaS1r3KWtquHMVKpnWUK
         15JM3mmFU6xowsOlVYn4EuPxWMvWqdlOk3xBIkT/i4wvip/CGGrFN2I4jPGDcihE3xRm
         QfkBR/iRO4+NxLNCp3HpPPQpPkrtvD+24AH+6ImT/YVGTIi3pDH5P0FfkC611/S1qAdb
         kSQrPpZj9aBql7aeaNL/ZXl9p0XZfIrlTyc7NJYbaovwFVVtgeKnMk9RbU4eNKBSS17p
         yEHfbruMlYfXB263rLNbyAfoFLxvhCNW6Acl+d0tP/Guwj3qIw/t1tP3JZWke6tZMV3U
         TEAg==
X-Forwarded-Encrypted: i=1; AJvYcCUuF7e/MirUlRBO4hAxI4sH6jj+MhAjbCTsQvH0wPSOkrM9ADx8/7gYqnITworoeUfDO0kZGFtKMF3JVSFBbp+vSna28Ll8oihyDGW2Ug==
X-Gm-Message-State: AOJu0YzX80x8pcQmpmrF6AlZmxsUNFFCiDgx9d2byjpzHU9ShBWBizQj
	lPDlwJCZCxPy76AuS5vhhyr/RQbMbjQuJNCS3oRSXrIHs5BUEy+TotjMpgETaL/6VQ+B+HcX9nG
	qe3RWh7obA8EEJAIC8lXjfhU9TzMgMogMFJdz
X-Google-Smtp-Source: AGHT+IF4KdKYv/i3KNL4LQkNiYFcff3UiechbnntE/n8lsxGtDCyAecpPgauuzlLRFB/79dZx13Kgoa30gmOFF58owY=
X-Received: by 2002:a25:7483:0:b0:dc6:c2ec:ff4c with SMTP id
 p125-20020a257483000000b00dc6c2ecff4cmr1925355ybc.6.1707401819151; Thu, 08
 Feb 2024 06:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <d54ca249c3071522218c7ba7b4984bab@paul-moore.com> <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
In-Reply-To: <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Feb 2024 09:16:48 -0500
Message-ID: <CAHC9VhRu-_v19zWS0Pm0-4E-PWONcfR1-=Ekz9ObuOAgL0Y+sA@mail.gmail.com>
Subject: Re: [PATCH v9 0/25] security: Move IMA and EVM to the LSM infrastructure
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:06=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2024-02-07 at 22:18 -0500, Paul Moore wrote:

...

> > I had some pretty minor comments but I think the only thing I saw that
> > I think needs a change/addition is a comment in the Makefile regarding
> > the IMA/EVM ordering; take a look and let me know what you think.
>
> Oh, I remember well, it is there but difficult to spot...
>
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -18,5 +18,6 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) +=3D platform_certs/l=
oad_ipl_s390.o
>  integrity-$(CONFIG_LOAD_PPC_KEYS) +=3D platform_certs/efi_parser.o \
>                                       platform_certs/load_powerpc.o \
>                                       platform_certs/keyring_handler.o
> +# The relative order of the 'ima' and 'evm' LSMs depends on the order be=
low.
>  obj-$(CONFIG_IMA)                      +=3D ima/
>  obj-$(CONFIG_EVM)                      +=3D evm/

Great, thanks for that.  Not sure how I missed that ... ?

> > Once you add a Makefile commane and we sort out the IMA/EVM approval
> > process I think we're good to get this into linux-next.  A while back
> > Mimi and I had a chat offline and if I recall everything correctly she
> > preferred that I take this patchset via the LSM tree.  I don't have a
> > problem with that, and to be honest I would probably prefer
> > that too, but I wanted to check with everyone that is still the case.
> > Just in case, I've added my ACKs/reviews to this patchset in case this
> > needs to be merged via the integrity tree.
>
> Ok, given that there is the comment in the Makefile, the last thing to
> do from your side is to remove the vague comment in the file_release
> patch.
>
> Other than that, I think Mimi wanted to give a last look. If that is
> ok, then the patches should be ready for your repo and linux-next.

If Mimi is okay with the patchset as-is, and both of you would prefer
this to in via the LSM tree, don't worry about the file_release
comment, I'll just remove that when merging.

--=20
paul-moore.com

