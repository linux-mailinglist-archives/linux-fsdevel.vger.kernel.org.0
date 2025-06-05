Return-Path: <linux-fsdevel+bounces-50720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AAACEE5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE40E7A5302
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBB21770D;
	Thu,  5 Jun 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npGniAMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990E214815
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122077; cv=none; b=K/Ns+sI7uLFzEd9eKGiRICKSgTzRSEY8c2fplAzDQxHLXj0A/Yw+bHTO1p6RvbF5thE1B/b4IDYDM9NRvmxfZTn9c49OlBcnW1lJzuG+GAWL4Srys+UhVFS8HX3KMCaWWTm0Xy2S084Hi5LMHwmcyl90/C6cwqZwIwTTOTwsUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122077; c=relaxed/simple;
	bh=ODGsXoxXadIDknEzO7YYdthfevWy6as/rBpoBWMSqfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHEYM2ZYRvyQvQF4STP9mkAPQtovfEDfS3qj2yQt82fNJDZC5alvFE6jknF5Icgz5gKOcL97voW+GEVPd/EvLHLZKeZZKj6Z7tvhF0zfDU0hVb+ZaQWPUBv87eNxwSEeEc7LnTe687XnvWUh+hSNyOGzAUXadRtGoWQLH+6fTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npGniAMo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606bbe60c01so1414568a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749122074; x=1749726874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODGsXoxXadIDknEzO7YYdthfevWy6as/rBpoBWMSqfA=;
        b=npGniAMon9DJ/iaCK4slsPrPrI27f7SUnpx3EUO69gG8Ppw4K2Cwzi0bFs9VzG1Sfy
         f5DyTokXos/aMYsYcqyut7bAYmyIpuKVjxduvWdGDwpVaFVcRG1aIJTx8YIU2qRlX+3O
         G+nP/v36F0ce4JU5D88H3NjOO3A6V+3WfA/D9YOts+P5ih3QSajAcBtNAuHg7r9fcPR+
         KXFxd/Wl51UCBZHkFTy+jVfruh3aAQBr1ziCwPvHOnNcPgNhpG/lRdRNXywXOjM4dDtp
         WbHradEDavE5sovzIvGNEWQDiW79OJpbqhmNrjvBVVrIkVwLJkHEPYObm2y0kzaz5cco
         Uytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749122074; x=1749726874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODGsXoxXadIDknEzO7YYdthfevWy6as/rBpoBWMSqfA=;
        b=v+XGkeS7TJgtfqNzDB290PRm9IcugOjq1qhmw9G8BI7KhK5qQC78R1Dy43MYvLUOUm
         hvPvjaqIMkhUHHKIeBwLFUOYGilSDm0M2buJLK462swYloVY4WihpNsft9MG9TIbVgC0
         LD/IflLqu3VSj9J3VlmBKy3YjfSjSf30HJo2Mpw4ym+c/gsyaE0DzRJaoxTdALJHJKqy
         qeSu/2i5JK6ZIOujPglflrj2xZEk6PQu1zQ9SbFLiSapA+QI/KvuZGYnJFeEKKrbDtCo
         xJB+lTT5DjSvTCSofmELKcNK7W9kS6Kk+asJgQi+ghqUF7quX/pfOptEUi2sThiDoj56
         Cfig==
X-Forwarded-Encrypted: i=1; AJvYcCXoGpHtQYub1EqYZLPOUZxcGBiQd4vB7LKhH81UeI9UHafiy+IzJEzdyTZtAQaYoV6dP5Og0f2dMKM9mzBF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6271iDE0e537Akf7PDMJVeJF/buM6ROVFF02x+j41BWHD/Zbj
	qHIwUE+xMYgYh10TJxD2HH6qE4lgfjiMullOuh01YMW5bw7VdqY9rkq1icMmOfOcZcf2g4NTHCJ
	0UJlOORBdcW2awJ99IksUMLRes1cmELk=
X-Gm-Gg: ASbGncvZuw+kTlZzKR45kx841KIYtvMo3kJDZcVMvbwO0XHrAv8aAKf0zYVwH2SyLgK
	An0GFPw2Hzk0T25yQts7H60pxCoc3PMQ7SIy+XA6Hw7+nWe0PEMBgq6y02CFHd1snLzuI5Ah0he
	nSXnGu99S/UrXBK0LsN2cl9cwbJNKkjGHxsAfK/x7vZ1M=
X-Google-Smtp-Source: AGHT+IEK4UOHxe0ebd2nX3Vc/NhpCxXtmvew1+VTTVOpJx1haAtHdmDvQLEErJqaKQOkBsKIXp6qSovbCZD742ctFGI=
X-Received: by 2002:a17:907:7e9b:b0:adb:1b2b:fe1c with SMTP id
 a640c23a62f3a-addf8c91ec3mr600724366b.2.1749122073920; Thu, 05 Jun 2025
 04:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605101530.2336320-1-amir73il@gmail.com> <20250605-bogen-ansprachen-08f6b5554ad4@brauner>
In-Reply-To: <20250605-bogen-ansprachen-08f6b5554ad4@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Jun 2025 13:14:20 +0200
X-Gm-Features: AX0GCFulX8I2-7K4zLeBYIaSAnwDt2QeqgOsFgEgfiXr7t9UYYAcoLrMCAyGBMo
Message-ID: <CAOQ4uxgf+0B5vy1ObhLqeRNmW8JzdotqHAwG7qS3xBZmfAABvQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix regression caused for lookup helpers API changes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:00=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, 05 Jun 2025 12:15:30 +0200, Amir Goldstein wrote:
> > The lookup helpers API was changed by merge of vfs-6.16-rc1.async.dir t=
o
> > pass a non-const qstr pointer argument to lookup_one*() helpers.
> >
> > All of the callers of this API were changed to pass a pointer to temp
> > copy of qstr, except overlays that was passing a const pointer to
> > dentry->d_name that was changed to pass a non-const copy instead
> > when doing a lookup in lower layer which is not the fs of said dentry.
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>

Could you fix the grammatical mistake in my commit title:

s/caused for/caused by/

Thanks,
Amir.

