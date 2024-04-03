Return-Path: <linux-fsdevel+bounces-16040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405D897354
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F6D1C2803F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA941146D62;
	Wed,  3 Apr 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GMcWIfYr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB43149DE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156586; cv=none; b=PYN7AByf/zwIy3ikHKCg4npamCH+eW1FKlBhdhGvHKE3NQu0clz7wVxew/H5aqIhs56z7R0f3YXdQd1xavtFkSkLjL2j7kwmI65Kt/mNfoQfOmBPIHPDKbqF+O87ZNq0sQKMgjNTNtV/iiw1MrxFh0kTDikp2GphXph1AuOVn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156586; c=relaxed/simple;
	bh=a7mNqaALJyPq3YdKVXicKQwMMqVLcFYOt4aFmY79KZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHw9ZFAJNp45wf0AJnDOaL8Sor+eCcT/9CYRUwI8rDSSvV8PnG3AsT7y+X4CWkyQSoaFivKnWacNuJZxtbV2sQXETqeN/GEixieGI5CRPC4VgyocsKS/ZdPp6H2gX0mDLeeHmObuF/x5uKFBdHqn3BMey/RCRWTKLiNtN/4Zso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GMcWIfYr; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6421248276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712156584; x=1712761384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB/QZCIJNsw+4xmf5zobnrRWsDWTsJXOON4ReH8dtVg=;
        b=GMcWIfYrscgAst0DD1198oNQcsFMfoJUezrKRuFuSkBeRfUlhe12r/FugLlhXrhjeu
         kVcDqPEqIJjtPihBsbmlxgtpqxFdeAS8D2EFqLTdvi+V/MTKMlJFWDTV+NxXb3Urstno
         uHlDgkqMs9Py7j+iWmqbI7uTWyplzVeREnbJSH/hzqEUBusyomTt1uikCuT7VIIC2d1J
         ZCOhc352kmpbiZNf+/IPd5HgyMPOcDEEBP5Ki7v8Y8I4K8j8jgs25mAVXv6c34bMHG31
         D8MOcddtf/gRfQB4MxTLnLUarjmPwHenM+wRP/AlZk1tMTTjjU6rrOrdnN3EQr7ZMfpD
         Y9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156584; x=1712761384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB/QZCIJNsw+4xmf5zobnrRWsDWTsJXOON4ReH8dtVg=;
        b=m+pFKkBi1OzRSe+l5beNKbaNMKLcOt2Rk4ZMABgNQ2jtr/XzBZ0wF1Kg2c4UkoQgwG
         pIhg1e8N+u06ya92UFeb87SW5BIHywZvYs8swXpZV9oQAyzlC5WYixVbtvZPuN41iOUC
         khGgN39/P0w5GZU2QxGijz7Ulk8yOiMDH1N0E7EJeVsNySgCjCHI8UIIPbopBEJGBcN1
         l2SJxIkGlPvejaThAQru+nRe0ODkbx6RUlMKA75DzUANtPhHdBJLTCeb9c6NRC8+1bmO
         aiJYEVtYNFZ4D8vmF97YCelVJ+JcQkqlvkNQOdOu3M+jo8Oj8ucyW/kZOY78FsGRyvPY
         /b7A==
X-Forwarded-Encrypted: i=1; AJvYcCWGwaNtkTWXS8jQpfeVU8P+Izjd4MJ2vvPFupVQpVtQ+D/UW9ezbRlsMT/oxDj1GE7c1Po5nDLCG9FMhCjHiqZQxHNIu5fdk7sVdw4CbA==
X-Gm-Message-State: AOJu0YyKhVneNE39gnKi1DHhx9WBK9uDKyPiryW7I48jvnwr+fv/0RxP
	nAnJwQGSUNiqjc/w2IrKSWjGY2NVirYLIqs9z+mQJ3cbPQoe7XHK1TZLsjrNLGxQq4Wk8ti2alC
	4LuX91EsNCDYVxAz7Tx8XotH5TaQasq8m69dV
X-Google-Smtp-Source: AGHT+IFT4d6bpRvDAVa07rux2sG1s5ZKLWz6hKyaoKXTEtvPIEVh93oEV7NIJATmjfw8W0YvP4+xkMNiV5GnCLoztN0=
X-Received: by 2002:a05:6902:2b87:b0:dca:c369:fac8 with SMTP id
 fj7-20020a0569022b8700b00dcac369fac8mr3635102ybb.1.1712156583732; Wed, 03 Apr
 2024 08:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com> <6d3b9d8a5f5a2ca010a5a701d7826e47912fec89.camel@linux.ibm.com>
In-Reply-To: <6d3b9d8a5f5a2ca010a5a701d7826e47912fec89.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Apr 2024 11:02:53 -0400
Message-ID: <CAHC9VhQjcvRBo30Y346p5Tbo3pspxnnmrLj6nvv1g=e_52SQUg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, pc@manguebit.com, 
	torvalds@linux-foundation.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:11=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Wed, 2024-04-03 at 11:07 +0200, Roberto Sassu wrote:
> >
> > However, as reported by VFS maintainers, successful mknod operation doe=
s
> > not mean that the dentry always has an inode attached to it (for exampl=
e,
> > not for FIFOs on a SAMBA mount).
> >
> > If that condition happens, the kernel crashes when
> > security_path_post_mknod() attempts to verify if the inode associated t=
o
> > the dentry is private.
>
> This is an example of why making the LSM hook more generic than needed di=
dn't
> work.  Based on the discussion there is no valid reason for making the ho=
ok more
> generic.

I agree, I think we all do, but I don't think we want to get into
process discussions in the patch description.  The description
explains the original motivation for the buggy commit, the problem it
caused, and the solution; that's enough IMHO.

--=20
paul-moore.com

