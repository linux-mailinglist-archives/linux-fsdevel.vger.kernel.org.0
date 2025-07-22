Return-Path: <linux-fsdevel+bounces-55698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D7B0E033
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59202188BE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65372EA747;
	Tue, 22 Jul 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7ZNDan0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD7288C39
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197203; cv=none; b=eN+eGNYxUlnVKDzyI3CtZittCCFniSejJb3zm9zZrmN+irItUmy3svCm3AqbH8f7z5IGJFRwFT1VAyENNp/doMChjZnZwJlmfIpU2FuP59wR3p90x3ZnHOLtfrs3d6H+fQ4p+K5ffHLewHjZ+hsw86040A/X3Z+FM3+AKr7ip/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197203; c=relaxed/simple;
	bh=fYwF20+xr2ZYHXER0lV1awMoPzrODc1LIZKAJaSiTcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFNlz//2TwF518qGfqrODqCi24dtvdtGgwH8jxCEn3wueMuY3uQoX6udLWusB5J+NkUBV+fsiS7Udrmg8iHRUGFf3rulDZLYCTyEKfCL9aOo2bMVYjuI/ZCYzPWxsHySI7Vz2vHT+kEAw52tH6ZYtskH8sE48zuGHkJ5egBwVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7ZNDan0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so11265787a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197200; x=1753802000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y75kPyRF8jjqM9C4NEXghP3/E20FtSTsMK07pcdUF50=;
        b=l7ZNDan0UNy274DoB0uwQHjqElcB33/n2APrAftMs8nHqCxxOS+9HKRgcC7jWX66Z9
         kQTcwhV7Hdpjorz2miEs4LxsN2GDKt8r99a7ugjrkqNH7OukD7octVtt+8moq7nueAKK
         GlIDbQrIhqpzd0xh8y6ATxe+2qaWq6udHs3umxtNEF/r9iiwclY3I+AL4K30114jfdem
         RReJ5a9gd5dNKNaya6iKBnT/hbZC+9t47DwKNAItx0MI0pQiITXRnRoUtiFQIskatjvs
         FOLeymUBX8BDZ86ARFIJHLBXK90pAo/ot7ZcptRPWaxaNlIl87f8s7uwSn/FrnVd3tx0
         WYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197200; x=1753802000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y75kPyRF8jjqM9C4NEXghP3/E20FtSTsMK07pcdUF50=;
        b=Otn3HJ/QntT30oMva9YRrMBqwQDjsQvwrr7dsnsRjjh98Yh0m8CK6WcjvmcJ/ln6k+
         nn9FJbcHVQ9/aEdIC05zRmTf9fqrpOHams1qiwy6qLJCCVuXDbYgfFUaStwybp1mA4GY
         N9SdOtyLQDyotKah9EncYsyyMG2uCg9tXp67/kaGotgoKlApR01NOj/KNa2otCL7RuVZ
         WmFksw30K4j0oHgWmLF6LUHsz8HzsmdaQxuuGA5RbpwcN8KqdnGuzV6xWdWDrJDusj7o
         MN6sMG6WDGQfcC90OIxzhKlDPXp6k5c4h47AiqYk7kRQZrRZJfYJe9yMV3zffGTcqhRv
         mpkA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmV4PKu2e2KxDXid80YWIzPYVX88pPz7Mk+WuS6HRAGsR7OhyPrTlJGagvKDd8s9C5lMrqCMt0uOB1rlI@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTruC0iMqtZXhniQfZmqypx5eE+Th1X9gcou6bbafWJIh3fPE
	IA3StkGVO4jR2v9dmHUc0JWEOv7ofG9YXzCoF9NuzuqpZtZ7Jf2vdLhYsd8+SAOYggCtnMLTMMF
	A6mw14BOnYUBAkNqIurte4Ut9+IQcg5w=
X-Gm-Gg: ASbGncuuxge671LsWK00E9fznaoRotF6Wo6N2/bDyWoPWlL7rGpbFTg4p/gSwovJLFU
	bmfQTnKg1sAkNr3F0Lvd6gJ0ylduy1d/Ra//riYBv1+DybTQpVFUCe0kwkSBMqhcKV9BMcKHKy/
	O6Xs93y51YaBtCvy0fpZ5CLo4mnpC1yeF1y+Rm8FM81DQlj7bHIr3KRiiT2xRr85nJMilwJYLaR
	Exruv8=
X-Google-Smtp-Source: AGHT+IE4pqpruBKG+OgHu/7ifrOZfMN3noFtzY9I10K7nyYXTQIqyqW7qMVtzSTh1SzFJO8QiP4vDmT5jGSduZlFlek=
X-Received: by 2002:a17:907:3c82:b0:af2:31a9:c981 with SMTP id
 a640c23a62f3a-af231b948dfmr181237966b.23.1753197199089; Tue, 22 Jul 2025
 08:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
 <20250711183101.4074140-2-ibrahimjirdeh@meta.com> <zliib52glfaw3vaook5xvv6h5opvnnrdo2mfh6wg26mqfouslm@etramyyx6tjb>
In-Reply-To: <zliib52glfaw3vaook5xvv6h5opvnnrdo2mfh6wg26mqfouslm@etramyyx6tjb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 22 Jul 2025 17:13:07 +0200
X-Gm-Features: Ac12FXzHk7ATjIVTc01g2gb4QO2wSUqSW8cmDh7G09eYtWazqhvJSpyHlx2SD-o
Message-ID: <CAOQ4uxg66RuFpeVZoK8bp5S9LbcYHQxVW+uQ8LMJQzgNRu2KOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fanotify: add support for a variable length
 permission event
To: Jan Kara <jack@suse.cz>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> Sorry for a bit delayed reply I was busy with other work...
>
> On Fri 11-07-25 11:30:59, Ibrahim Jirdeh wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > In preparation for pre-content events that report fid info + name,
> > we need a new event type that is both variable length and can be
> > put on a user response wait list.
> >
> > Create an event type FANOTIFY_EVENT_TYPE_FID_NAME_PERM with is a
> > combination of the variable length fanotify_name_event prefixed
> > with a fix length fanotify_perm_event and they share the common
> > fanotify_event memeber.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> As a procedural note, this patch should have your Signed-off-by as well
> Ibrahim, when you resend it as part of your patch set.

Right, but I don't think Ibrahim needs those patches anymore,
because as you said FAN_RESTARTABLE_EVENTS do not require
a response id.

>
> Now to the content: Amir, this looks quite hacky to me and I think we can
> do better. How about:
>
> struct fanotify_perm_event {
>         struct fanotify_event fae;
>         const loff_t *ppos;             /* optional file range info */
>         size_t count;
>         u32 response;                   /* userspace answer to the event =
*/
>         unsigned short state;           /* state of the event */
>         int fd;         /* fd we passed to userspace for this event */
>         union {
>                 struct fanotify_response_info_header hdr;
>                 struct fanotify_response_info_audit_rule audit_rule;
>         };
>         union {
>                 struct path path;
>                 struct {
>                         __kernel_fsid_t fsid;
>                         struct fanotify_info info;
>                 };
>         };
> };
>
> This actually doesn't grow struct fanotify_perm_event and should make
> things more or less bussiness as usual.

Yeh, that's less hacky for sure.
My hacky patches were keeping the path alongside the variable fid,
but I agree that we can go for response_id for the pre-dir-access events.

However, unless it is urgent to Ibrahim, I am not going to pick this up bef=
ore
the end of August..

Thanks,
Amir.

