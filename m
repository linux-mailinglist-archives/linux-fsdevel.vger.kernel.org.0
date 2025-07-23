Return-Path: <linux-fsdevel+bounces-55800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6BB0EFB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538D31C26447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D19828C2A8;
	Wed, 23 Jul 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2zRS/3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0928B4FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266307; cv=none; b=MVOgkCvKfdCjHshjv2bFYlXHmjLULGEi5hXFBFm6OQNpWaB0veqnWpoLUIxa3qfXdiYHGx3c0AXnjQBJOLSAwvJkn43yTSksPrvbJ2GOh3Ydo9TrKhLt5Rwj3PCjnNq3lO75ckqJFnsW+FgBeCagRUaTs6HXykOqe1ulUVvoees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266307; c=relaxed/simple;
	bh=iCj8P4WJGimc9JwGjHjjSmoPwXi5E4NeeswVuTGnIWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPP9ZvNrac0uHpvTpjgKTw23s6+Ea7jAuvpmlSp12IMJdOYAXwZ2Xm3yB18o20xw0xKTio429P8HWsj3iZTcSCKw5mGn7O9TAhUu68Gai2Q0JNq1iQ7XpF7WR04vpNUPEn1TgIiFP18hz9iATjdDfOZCe4l3wUTZ6jPCVhOaILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2zRS/3c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so1089744866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753266303; x=1753871103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCj8P4WJGimc9JwGjHjjSmoPwXi5E4NeeswVuTGnIWw=;
        b=O2zRS/3cSrkHmniKA08eLHb/dT75usE776cfGoBySwGSwijEiTDmbf87HrJepY5pOV
         8pvSGjyG//T8CD9odB+T9nKzO9JuQ2AdsMldBe52/nB8nn+iCMYMqEB/64Tt0Mi+Bi7I
         nfzRv8cy+Y1r2sMKCK6qf0PqNx+YZCE8b3VFfBYf81Xx7DpKj8ZtpFVlZQDv1bDv42lq
         Z7uc1w6v4uIvsmKU1cxITXwiUfuw8iETNXrWEfK/X+ya0KMJEEbOleFxNsdw32qFVQN0
         mLzkmFrEzm7cqAEra+XEJqvXWK6YLrmo7ww6LOd/L6+KZHC1vZFI7w2KFBjpA1hXljJi
         AmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266303; x=1753871103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCj8P4WJGimc9JwGjHjjSmoPwXi5E4NeeswVuTGnIWw=;
        b=gpHtsJKg5MlxZ/drF4KuoNVhKgAUFedo6qaKrh8jQ8ygzs4GPW992ee9y5RjZU5vsm
         Jzo8oFPSH8bZMsXfNbFZUxa85dJ+tgcKOdhjgpAzeb9fblAkwHdaXUB+K/90gSfujZ1X
         RGlsivON2Voz/cEN1psJaFwOoy1Spyyfyn1AUtdxeRNGG4IMsg9HB0ln3TBx86UWtfPR
         1EaAT3ZVoVvbJTbLkR1iefW/IN3ZKyelokpND6peO4HyG0yeUTWBx3BHqfjTx9xbMxrZ
         lBso+BkOxwJYwX1qWuEqdO/hxYXrCeX5Mjj9btqycdOF/TaumDMkI1rYA1W0vOKGkzx0
         aDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsCvrCFFMtw0E3mmjbU+8FwyyovrD7ieaZ7xACeVX7TMQIqiLNx7olDwjFlFlotOHLfO1fI8y1nuVu2cyw@vger.kernel.org
X-Gm-Message-State: AOJu0YwivIv9O2ShmK6V8JBGaK932zUVCOnbfXApw7UKTcbxJkIrzgZS
	jCXhOuLi7Ge2gd7iWBI5ggRe784kNFipPVVwLUw6BltPNyaZvq2GRBoCLspxLrxREuYfMwa09sC
	oWPnpko5HHF2URQf+kY7UOcpsNJsVu8vaIDsHbcw=
X-Gm-Gg: ASbGncufBwW7W7f91S3HFfTypWMxs3JX51uqvSttMfLcEbCe4LK7dZGX140Mq9+k4TO
	eS/QnYOyOKItkWIdujrKHGUXdIPqqxJKfaE8FFjP3Y40Ks3tLPBjIkGJ0NVJSEfQxrpk0yllAnw
	NgrTkVman0qezaFAxIWkMXg6VQejhPljhRc2BEmBvKu0IGrxkSisVMZmsRqyAAUz6P7fNNxA7sl
	m4vZ6LJr47bzFjAuA==
X-Google-Smtp-Source: AGHT+IHD7TqtUzJjYPznziwyWtEyEqCqYa0irCyiCGGDOojBE5zsnm1cyK+oTYtic3ljchi1ZpQfAIQkR4UEKVP7NKU=
X-Received: by 2002:a17:907:6d0e:b0:ae3:69a8:8da4 with SMTP id
 a640c23a62f3a-af2f66d4f13mr196704966b.9.1753266303004; Wed, 23 Jul 2025
 03:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
 <20250711183101.4074140-2-ibrahimjirdeh@meta.com> <zliib52glfaw3vaook5xvv6h5opvnnrdo2mfh6wg26mqfouslm@etramyyx6tjb>
 <CAOQ4uxg66RuFpeVZoK8bp5S9LbcYHQxVW+uQ8LMJQzgNRu2KOA@mail.gmail.com> <kxsaemqmcvwrhk3f63kdzda7uef7bvuo5mqu4qy2duud4m44vb@oy2cfejdccqu>
In-Reply-To: <kxsaemqmcvwrhk3f63kdzda7uef7bvuo5mqu4qy2duud4m44vb@oy2cfejdccqu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Jul 2025 12:24:51 +0200
X-Gm-Features: Ac12FXw-8dqG3bYh7l7OQm892tJLWbVq82Bm77gxmeEP7zrXqXqWdFREgshp_f4
Message-ID: <CAOQ4uxiJU3PjM3fcUgJMSb0AU+ekXUMbUwyns08Q08zhwej9KQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fanotify: add support for a variable length
 permission event
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 9:43=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 22-07-25 17:13:07, Amir Goldstein wrote:
> > On Tue, Jul 22, 2025 at 4:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > Sorry for a bit delayed reply I was busy with other work...
> > >
> > > On Fri 11-07-25 11:30:59, Ibrahim Jirdeh wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > In preparation for pre-content events that report fid info + name,
> > > > we need a new event type that is both variable length and can be
> > > > put on a user response wait list.
> > > >
> > > > Create an event type FANOTIFY_EVENT_TYPE_FID_NAME_PERM with is a
> > > > combination of the variable length fanotify_name_event prefixed
> > > > with a fix length fanotify_perm_event and they share the common
> > > > fanotify_event memeber.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > As a procedural note, this patch should have your Signed-off-by as we=
ll
> > > Ibrahim, when you resend it as part of your patch set.
> >
> > Right, but I don't think Ibrahim needs those patches anymore,
> > because as you said FAN_RESTARTABLE_EVENTS do not require
> > a response id.
>
> Right, I've lost track a bit of who needs what :). So nobody is currently
> striving to get the response ID changes merged? Just that I don't waste
> time reviewing changes nobody is interested in at this point...

Yeh, it's hard to keep track, but IIUC, no need for respose_id patch
or my prep patch for FAN_CLASS_PRE_CONTENT_FID for now.
If you have time, it would be great if you could take a high-level peek at
https://github.com/amir73il/linux/commits/fan_pre_dir_access/
but as I wrote, I won't be getting back to that before end of August and
when I do, it is likely that I will pick up Ibrahim's response_id patch
and make those events fd-less.

Thanks,
Amir.

