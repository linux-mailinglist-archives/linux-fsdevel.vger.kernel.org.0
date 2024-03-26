Return-Path: <linux-fsdevel+bounces-15323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E2688C2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA131F64002
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912F74420;
	Tue, 26 Mar 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TrSNZXgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2373177
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457601; cv=none; b=mRjeBcx9tuLg5j/8+ESek93LZEg/SOejnZX3OGnzYtxtnPOLXDKVBRH1QWXyevwEPCUXrVMkG3pJXUYofZZuS9+P4wsvitPh0bDYnl9cQiD63vdB0yBCTGqd0epJ3yTUiXQ4HxNj7255LpKR2uY3wKM/tnQaOwjWI2wj/DdBkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457601; c=relaxed/simple;
	bh=5XbquQmJKaNfWBjyEtOOSnqsLcETpU6DZOyNLjemzmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5SRK+SFZ2XEabgIy4+4VjIjTGKXEQ5GGLyXJegcnj+6wikHD047Z3L+zFFIVAQQL5Ww0THQVdLB6v8UP1st7t4fJo5UvDXxXm3UL3xmI/wROub5dcj1K1eaaIcUTJQvasWyHasb+F5AL+z6HMohe9We7fM/1UL28TYhvzIactw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TrSNZXgn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a0a54869bso44175737b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711457599; x=1712062399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0BhUuq6w2jcMHo0vnHZWTdWQ7YEJBXZjKotn4i2wHk=;
        b=TrSNZXgnFF7GvLHr6M+Rgew7GU+Wc6sqwMeSm/E9VbSWkoZE9GMg+Wl71y2gSnuWJI
         3NFtVETJjLs4IyW9BQR77EzSomQBRFS2IFOkfTYKRG0jNgDUhWWnV30AqBJCNeVmESEq
         czISs7cXGwoum4ATewhUj9UuAIU1vG32bY7qF+Ww7LB1txAIgVURulRKip8MlfZX0TBj
         rr7gdsJJ8M/ykHGK+KI164xZ8h3pgemvlntiQy05Zde07NWI178pm1wh5Gu8/PBx/WDq
         jLvMnhZBmsbSbgOLZpAx3CKkrMaCSZQhW413hzmV/TUd5/ssdMA6/tbShzvdszPIiykJ
         K0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457599; x=1712062399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0BhUuq6w2jcMHo0vnHZWTdWQ7YEJBXZjKotn4i2wHk=;
        b=uP0LtQ2w0cR1chQrCapCOukPgap6WcRf6KfkqdmZ7iBmHw97SP8A/Gj6w+clBOUPfe
         v2txF42HagaqzY3XFdIJt0uqZtnnontj6Ys3wBU8gC/nCdxnOlFkqqtUZI9VFNr0kTTG
         DFabWzNg8i6CAO6bgO76dlWulcUBOCw1wsnmRfX+ZuHTgf4dMx8TyOw+654FYfA6CoPX
         1QrtI1lP5eGGyuM1roX8uyCn9NQUtFa2DhVMBBa+9XsOQL3VYYagr5i6sq8XhWrNlKkL
         mZnDN8AmWooKJZSjYunhwstdFdQQ3D97qT6FChG85TFhOu0cAZ1lECicaX4QI24MTmfP
         5rxA==
X-Forwarded-Encrypted: i=1; AJvYcCWh1YMOrYChYgNKCme5MlHXckNR1eZiN8xrV8I5kmckVutuVqrKtDMwKN9G/R1jUchlQpcpdybKiK6jA9zv9mUrCLcrQy3Q1KGLmJOCKA==
X-Gm-Message-State: AOJu0Yy0UeKDWo4kfHXTlWshvEHfRFK8m1KfJKbI/mgut47eDo7/S6wy
	sxqc2cGyRaJSC5cM1sBoY8XxA2/nlz9AhGZgHfHjJcD/+fwnLaqSMPXvfSvwwYii8mbs/2D4sLp
	ob9jEYz9pCZpHSkBBuv6Z6wYP7LcqmfMA+2Ag
X-Google-Smtp-Source: AGHT+IH2Oz9Ij0xMEiUnRD6ybquNqgql6Kb2ocAG6nS4ykuQkyqgIotaRGNW/ASQAvSIwgHE/TxrVUinkjCFUqhPnQ8=
X-Received: by 2002:a05:690c:700f:b0:611:336d:c8f3 with SMTP id
 jf15-20020a05690c700f00b00611336dc8f3mr801016ywb.24.1711457598719; Tue, 26
 Mar 2024 05:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner> <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
In-Reply-To: <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 08:53:07 -0400
Message-ID: <CAHC9VhQg6Qhqjs7J+X6wZa+dP4cujcWPJMZONB0SB9aaaGvFDg@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Christian Brauner <brauner@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Steve French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:40=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> For bigger changes it's also worthwhile if the object that's passed down
> into the hook-based LSM layer is as specific as possible. If someone
> does a change that affects lifetime rules of mounts then any hook that
> takes a struct path argument that's unused means going through each LSM
> that implements the hook only to find out it's not actually used.
> Similar for dentry vs inode imho.

For bigger changes please always ensure that the LSM list, and any
related LSM implementation lists, are on the To/CC line.  While we
appreciate Christian's input (and Al's, and all the other VFS devs) on
VFS matters, there are often other considerations that need to be
taken into account when discussing LSM related issues.  Generally,
"specific as possible" is good input, but it isn't the only thing we
need to worry about, and sometimes other requirements mean that it
isn't the best choice.  Just as we want the VFS devs involved in
discussions about VFS related LSM hooks (these new IMA/EVM-related LSM
hooks were sent to, and reviewed by the VFS folks), I would hope the
VFS devs would want to include the LSM devs on any LSM related issues
and would try to avoid speaking on behalf of the LSM devs and
maintainers.

--=20
paul-moore.com

