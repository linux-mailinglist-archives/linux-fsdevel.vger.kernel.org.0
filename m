Return-Path: <linux-fsdevel+bounces-20938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C48FAFC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 12:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1A01C22489
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499B1448C9;
	Tue,  4 Jun 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="E/w4AguI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2D38B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496520; cv=none; b=A7pXLOzDoI1OOb6c6qD++qXk+EDadE+X8UcsbrU7llsTKoKUFKVwhgBgJTCI3gmlxbmzVrG+gQ8kXdyi/KnF0aaYjONuTkfJo0LCDI13SHI/cAO6rNG386iserT8ZepVWPDztg+Lq8CKVyK+hs0hCDohq4XYZu0PX6rXrcK0tzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496520; c=relaxed/simple;
	bh=Imn+HUcKStZTO4Jr2J5KWbiLkL4epXPMwCj3OeOmXAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o58KTwJnMvz58AB692Qdeo3BPs9ZveAXjXQiy1xUAeRNMRIXdqoGceQalFvfz8dOjHRkQdDWFKGDZeSGBFXAt4RAq524AVOeL6mJHsd6cPSUPXrqNiKTj3FxUsCR0cXabFhIKw8intRCDpo4apTUdblR8sPg0iHWim+6Eq9FmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=E/w4AguI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b93370ad0so3977341e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717496516; x=1718101316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QmDmNFZ1TQLcn13Q/ifhWND/gu9EuhB43OgA74WF09Q=;
        b=E/w4AguIy0Jg8uo3Feki5658UjVBj6FrNueJoBztO6vKECNcIzGZY1RW+lTdzzWE40
         v5TcypZkI99afF6oWRUeGgu3+SNkqKjbjhX7YXbZr5IW/89+lez1bn4kN/OpBM1PMigs
         DvaJpVybjnJ5w4TmWSNhDvrU61LECC07VoVXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496516; x=1718101316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmDmNFZ1TQLcn13Q/ifhWND/gu9EuhB43OgA74WF09Q=;
        b=Vt9IHYy2rwLZVodgQzJk06enVGxOrWXSTZgCjpSr9RHTXKydsuKR1866zMqYbvlDZp
         F62u1beX5mqvF4kDhPPywfaft8N0p8IQft4vP5lIzYeETdJGGlN6zxPzZsrEW+8CBccq
         Fylsx+rOEeaxxAWm168Kd/yhhGmdItPx5hZaFGan5/S+TDroNpzP+XfGYipWOXE+uKrz
         SGz+qDbco2oreNSmxEIiVbu1whMlnCUPogWDUB4wNnQo8Koks3ddhy5Cn9P6AoBacOCF
         kd+ruyDd59CN4IE8OCMHLabxTCAzwAGZJbt5TfuBbBtycum2nhXgEGg3O84LjVICvIDD
         MHNA==
X-Forwarded-Encrypted: i=1; AJvYcCWaeK4VBcWxISbFk9HqRn3Q4YbzGMsktkanIgQVzZuR6g5iwArmBf2cDAbuKHGyAy8AoUluo3RToNFbW6NEA5wMKn4IblWdefzwjqIyQw==
X-Gm-Message-State: AOJu0YwSQ+N2QgxpQ3NFKMmLJkNLmIV/7ST2zmE1hWEVuH4l4fVhdOAi
	pwaGSEPCwafdf9ThL9tHIfMmCt6v8ZX3YWfIT5I9V0gpqiL0oYNyelPUa3Rpp7Kc7AcX08Lq0FF
	yqkg39+hZ55rwFdyFLcWfvESOD2pSx09TBg7NyA==
X-Google-Smtp-Source: AGHT+IESGKfjCZ/d7YQhVr4w9aHXy92y636qjmWLXH+R9HsoasnS99cNnuJIq1czHCghZavoE+Bq3PaKnRQ8RjpkIrs=
X-Received: by 2002:ac2:4d83:0:b0:52b:fb4:1283 with SMTP id
 2adb3069b0e04-52b8954e82cmr9897134e87.15.1717496516433; Tue, 04 Jun 2024
 03:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com> <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
 <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com>
 <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
 <CAJfpegu3kwv9y1+Yz=Ad_eJt7-fNJbxgJ8m2_B=Su+Lg6EskGQ@mail.gmail.com> <8c28a7f83f66a30de13380c9b5f48b64d7c7c17f.camel@nvidia.com>
In-Reply-To: <8c28a7f83f66a30de13380c9b5f48b64d7c7c17f.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 12:21:44 +0200
Message-ID: <CAJfpeguhUYhtVu83fG6OhZvi6hGSOAfSztH7Aq=p0r2y=n0_2Q@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: Idan Zach <izach@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 11:31, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:
>
> On Tue, 2024-06-04 at 11:18 +0200, Miklos Szeredi wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, 4 Jun 2024 at 11:08, Peter-Jan Gootzen <pgootzen@nvidia.com>
> > wrote:
> >
> > > Option 2 is detectable if fuse_init_out.minor < CANON_ARCH_MINOR,
> > > not
> > > sure yet what we could do with that knowledge (maybe useful in error
> > > logging?).
> >
> > Using the version for feature detection breaks if a feature is
> > backported.  So this method has been deprecated and not used on new
> > features.
> Oh that is very good to know. So for new features, feature detection is
> only done through the flags?
>
> If so, then in this case (and correct me if I'm wrong),
> if the client doesn't set the FUSE_CANON_ARCH flag, the server/device
> should not read the arch_id.

Since reserved fields are zeroed, it's possible to check for arch_id
being zero (meaning the client has unknown arch).

So if the client sets the arch but doesn't set FUSE_CANON_ARCH, it
would mean that it does not support translation for this particular
architecture.   The server can still check to see if the arches match,
continue if so, and error out otherwise.

> As this is in some sense a bug-fix for certain systems, would this new
> feature qualify for backporting?

Certainly.

Thanks,
Miklos

