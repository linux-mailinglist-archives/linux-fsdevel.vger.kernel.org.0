Return-Path: <linux-fsdevel+bounces-41133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6188A2B4D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 23:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57213A9296
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52222FF43;
	Thu,  6 Feb 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+WePZI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1A22FF37;
	Thu,  6 Feb 2025 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879859; cv=none; b=ObZ7YOfhbFfxemOfns3iUClK0Symy3VyV8VsYCVMO2hzlUfUc4zzEe7RDYeihFavGuUPy/OmAAi4eCu00j7XG0GV8b4y1yjnWkgwO0cVDniMCU5d3o4c/CVZtXTBVHp0mDhyjnfF3Vzs+kT2QKdzLVGWZMTayCmlA9iJfQah4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879859; c=relaxed/simple;
	bh=2Y70HzxcQTGQ8pp24im9o2oCo4aDLht1LZCb/OG3xJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO17+d3+gQVoF7hoh/HErxnyn++Iz8wrS/IPBp3Y5wAyqPxu6lz98fCiEnsrVhQGteiqf1OPEq5xbUt8Aoeqmo97NvdSLV656NS90wKBqXpwACDBwBz/2vLSvqNViS9mXnxx8jvyr1X2US7Zh9XHAfBW/l2phpK3Sn2ktfYUhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+WePZI6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dc82e38c10so3075054a12.3;
        Thu, 06 Feb 2025 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738879856; x=1739484656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW4K88ZRfCDR2jOA2UBUFxi/kKP7aoGmXehZOk8p2EA=;
        b=f+WePZI6w8ASafkII/yohWm+YErgbqA2iHQrd54JvpYBD3VdhlZQAQqcKibG8k4IQL
         Ai8NOcPNL7rmNS5palle1ieR9s9/2xPAolxAVvb7bWAnNAncFLYINZ6JAH4qubopKFoP
         sFK5HLnvbigouYoS/e7Cuz9gtI42ifMpt77SN8GQH0DkB0AbZwSWYOhovny1blPCLnS3
         G+c/7bGZw72QHaKLI10u3PocjecuW6qSnCAyh3ExqBTyVNTf315hqeKkklJyhZ5Jyo6r
         WnQPRjCzWaPeb9tRFRvu65AH5sPLeSNLhw4DAnkNPc/OF/TOuGpH/s0faz7QTqtWhyAT
         K7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879856; x=1739484656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW4K88ZRfCDR2jOA2UBUFxi/kKP7aoGmXehZOk8p2EA=;
        b=QGEHCGRnxSEnsA0Rk6URgDdeObgD+i6BhFpcz07uQQAzT/IGGP2NmeIAIUhD2KaRpj
         I1umMvpKAB1uHIudZc7ACZpWxTEJksW7hwr9fMQBKmk9TJMjFfcO1PV4VbHMECvHMY2z
         Rn6jFBBj16j2zasFLSoGhwmHcKJm8eU+m0PZbwt8DfQrM75/C7XM0yuXcmfq5zO6A31a
         DEuzB1tiZECj9Fc6n2a7BDLdYMVS4tsXwX5M9eZwILQXTceM5Y6R54gcI/+1abGeyBWx
         SK6n0XiYKx6LmEdj4yV5AmJ/vl8CniI9V1fDng05rplHtFRD2BR5rqvHdLul+PQghFbN
         t6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU5sysSxJ83I8j5xglgY+T+4b9/iMZoCTKAFnyDircVohdpv6mFBrOybBhvEkN56Iuv8zhUA==@vger.kernel.org, AJvYcCWki5Nj29ALCqrCkoPWB8mYFQ/0Zs/u9RUGqkB2jqfj1gaWA/3Ygx/vrMqQxQFx371iyjUd+nIJSLCuCFyu@vger.kernel.org, AJvYcCXgJ92Qv4QRydKxnun2t+YyTiBCHoSp2fFK4/LQzUjfBgGHNm890IYt7atS2Xp56JLp+23pJa+Lqv0Lziys9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkudiHjCZk407f+0vfci1eqGrnZloQfWIqd33wy8XFD8vIMT4
	o2TLtt73vNdHjOeXfOrenTPtTAB1jNDkJsIqaah5GAx0QReyhhPLcJVAAtpCUzbauIUhiRD0AEm
	kRuzz/PKpCnEZKi+HWYxUnvFQ9gM=
X-Gm-Gg: ASbGnct1sqcEkNioMQ1x+DejEvlQw9vBS7HP1ceWW8H784RFXWp81QwSR1WIcfNk79V
	sIFLwOoliQk+0HT2Xp3V+n2wiiFn29x9CDuIRfOjxD08wFz8xBrtUfH0TTsMK4UcTtOMpOb5v
X-Google-Smtp-Source: AGHT+IG2oWQwkRpCjysgqfuWiM97pMeIC+nGnB0ZEcQS+BxA5ZSw1JZItpWr/Qw3z8w7GeyebbtowgqSYSm9aozev1c=
X-Received: by 2002:a05:6402:5290:b0:5dc:74fd:ac0a with SMTP id
 4fb4d7f45d1cf-5de45046dc3mr1016725a12.8.1738879855385; Thu, 06 Feb 2025
 14:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFLnmp3tQHOwUAFBKxrno=ejxHmJXta=sTxVMtN9L1T9w@mail.gmail.com>
 <956b43574bcb149579ecac7a3ab98ad29dddc275.camel@kernel.org> <CAGudoHGqYKTM979s13SAP7fukeAd4NHGTMsxnRWN7A5BpYaCzw@mail.gmail.com>
In-Reply-To: <CAGudoHGqYKTM979s13SAP7fukeAd4NHGTMsxnRWN7A5BpYaCzw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Feb 2025 23:10:41 +0100
X-Gm-Features: AWEUYZknvE-HOGP2RWK6mr0JD4I7AL0JTBX-Up_kPyHMEtp0w9NL4G3eskO-d6c
Message-ID: <CAGudoHH8Rg=UA+gSDywkVCNHDofpAQCgJuiecZxrTa_7otrx-w@mail.gmail.com>
Subject: Re: audit_reusename in getname_flags
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:34=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Thu, Feb 6, 2025 at 9:24=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Thu, 2025-02-06 at 20:07 +0100, Mateusz Guzik wrote:
> > > You added it in:
> > > commit 7ac86265dc8f665cc49d6e60a125e608cd2fca14
> > > Author: Jeff Layton <jlayton@kernel.org>
> > > Date:   Wed Oct 10 15:25:28 2012 -0400
> > >
> > >     audit: allow audit code to satisfy getname requests from its name=
s_list
> > >
> > > Do I read correctly this has no user-visible impact, but merely tries
> > > to shave off some memory usage in case of duplicated user bufs?
> > >
> > > This is partially getting in the way of whacking atomics for filename
> > > ref management (but can be worked around).
> > >
> > > AFAIU this change is not all *that* beneficial in its own right, so
> > > should not be a big deal to whack it regardless of what happens with
> > > refs? Note it would also remove some branches in the common case as
> > > normally audit either has dummy context or there is no match anyway.
> >
> >
> > (cc'ing audit folks and mailing list)
> >
> > IIRC, having duplicate audit_names records can cause audit to emit
> > extra name records in this loop in audit_log_exit():
> >
> >         list_for_each_entry(n, &context->names_list, list) {
> >                 if (n->hidden)
> >                         continue;
> >                 audit_log_name(context, n, NULL, i++, &call_panic);
> >         }
> >
> >
> > ...which is something you probably want to avoid.
>
> Well in this case I would argue the current code is buggy, unless I'm
> misunderstanding something.
>
> audit_log_name in particular logs:
>   1550 =E2=94=82       if (n->ino !=3D AUDIT_INO_UNSET)
>   1551 =E2=94=82               audit_log_format(ab, " inode=3D%lu dev=3D%=
02x:%02x
> mode=3D%#ho ouid=3D%u ogid=3D%u rdev=3D%02x
>   1552 =E2=94=82                                n->ino,
>   1553 =E2=94=82                                MAJOR(n->dev),
>   1554 =E2=94=82                                MINOR(n->dev),
>   1555 =E2=94=82                                n->mode,
>   1556 =E2=94=82                                from_kuid(&init_user_ns, =
n->uid),
>   1557 =E2=94=82                                from_kgid(&init_user_ns, =
n->gid),
>   1558 =E2=94=82                                MAJOR(n->rdev),
>   1559 =E2=94=82                                MINOR(n->rdev));
>
> As in it grabs the properties of the found inode.
>
> Suppose the 2 lookups of the same path name found 2 different inodes
> as someone was mucking with the filesystem at the same time.
>
> Then this is going to *fail* to record the next inode.
>
> So if any dedup is necessary, it should be done by audit when logging imo=
.
>

I did more digging, audit indeed *does* handle it later in
__audit_inode(), so this does work after all.

I'm going to have to chew on it what to do here then.

--=20
Mateusz Guzik <mjguzik gmail.com>

