Return-Path: <linux-fsdevel+bounces-52255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1502AE0D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E381C201DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982D1F0992;
	Thu, 19 Jun 2025 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoGayEpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710430E84E;
	Thu, 19 Jun 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750358786; cv=none; b=HaTH6/WrfyPlZuk4uTMWgb4SGc+vhOFmOwXwroGcHQ6+nzkTu8W7Ga2Ok5/wBJgWrUxDdLkoLExhq0wu4vqQoBHQSV14uJqrlVQ657G9o+SJ33S/VtyihNTC5VchiUIVVoOo2CzRT/++jxA8j0CpuhnL1G8ZKAG7Qp9hlnGmFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750358786; c=relaxed/simple;
	bh=C2AKUFX0mM6/YU4jHzPDAaPY3tOQKEWVp0/A+MxRcjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At5E/kCHTdbpdffTQNYhtm9KeOZuV1MxyPwPV2ZZ4xYsRNgKthvdhCHNTYap5AAOyrQMpQmLm+F/yo1MZL5QWOSynuRpODz79IQml5kGUJC5Shzqun7dCezHiUm4goLNVrhRHLy3+j10/YbbDUoJ9nZpF70yz/i7dFmZbHvbPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoGayEpj; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-531a1fad7faso302595e0c.2;
        Thu, 19 Jun 2025 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750358784; x=1750963584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeVq00HdVoGRbDPLQhAs3mdL7Gnf/CARB+Q1SUgRL6w=;
        b=RoGayEpjyRIUFhdo5qZGMfLNxKcWV1BXk+RkpvCD0ZasbilotOSm+TbVKUcIe5NpQY
         LcGX6e8zMKePV9JOljAX7AH9H/6UsS3cdyqpD7ESfM7v6pk3iDA087l9WHFXNEGwuAIM
         hoE3Kk/i5y6zH8Q7C8l1r8sq8TgIh10Up637kgCbsb3T2pANro5prqx7BeiA9+lc/dKz
         DeFtrNki621hsWlrtYx3FIKuokDv7DI/fv6Fdbwudzv5LOAQ9LbJ4f9W81eoojfiq0GS
         5Z7kufHMWqMVbh2mDwUBOd1tRN2nUc3qyguXW02QSYAi9ts5vJgkS60IlFKpbHHtWOXj
         0SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750358784; x=1750963584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeVq00HdVoGRbDPLQhAs3mdL7Gnf/CARB+Q1SUgRL6w=;
        b=p3t7AuqZHtKWez+2subRB4hxyFjHC/T9Yz6lpWOQy0BgNuv/yJjkhgANITVrVf/kpr
         76nrvkfA5aIDoaDwn03mJUJ2jQDYf6SrmoNtzOTnnC5TPXCt8s6sHHzgAgFl5fe+XP/d
         t2aoGixYpNWqiiGnxYrnNLx4ey6VDUqP1t5FfjA0tiHjXxeaoo7WpirN5Y5V+saIlBaO
         AFLbvKB0oWGDhN/lt92MuomGHRcQEK7zEU3CSJA0tnqmaU0OA+RACRP2j46rzDHrwR7t
         axy2zEA3RwAwCDUpD9Ru5v+MYd81zoypRbgKUa44oTakGoOQnP3dvDj7pyEAs2fcDHfQ
         4lrA==
X-Forwarded-Encrypted: i=1; AJvYcCVDRJjHm2BvOGWesA79t10xQH0iQFD765cdfyzlItYKzAoDd41ycFtEVbL7P75xiDLWUVyszKZF7kAV1yLc@vger.kernel.org, AJvYcCWUEUAZecc5z8eTF4B+P3kf+H2+E/IsVb3SnJsL3o+qv2uPLn03lsA8vwzVd37tchU7WMHXRaDersSF6FJj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fJzYGMkXAU6CyWffOkjGyhsTiCa5YAxCRcoNwcZW+aN/WAp0
	H6yI5zTBO4WDKX4bXutTVLRidpsC2iJfi5bFEVk71Q3Xz2VmQgbMGX+gpSry2Fl6yei1zdaJVAt
	EDvGbbIo6hyyWGXjH62oRtgOx5fERwamhd5ZxHKo=
X-Gm-Gg: ASbGncuC0Ln9RIfb/P8nUWDbPkYlOPSnMpsND0iHTN4JXUgJQfIeYHQG0onIRCG1AN0
	xJrLKVNh3Hu40h0c/5I10BiJetLo282+Tg0jAILCwdnY1gcD5zlhWoTNuJS+x4+Lzd4lLjjMtqR
	qn4k6od+p3mgMFG1XDPqwsFS0PIEr2KPyohF/RfSJxsCHiIQIxfCc2aeEpwtTJNkbHrghufLLW0
	xh6HbYsY576G2T9
X-Google-Smtp-Source: AGHT+IHdojA7VEo4E8IieiCBlzs43e9mhEM3FcrEdMSuk9rz/qPmrAe1L7EGgy6z3Q3mtVzNgwMuMPsFxMM7O32oghQ=
X-Received: by 2002:a05:6122:658d:b0:52c:4eb0:118d with SMTP id
 71dfb90a1353d-531ad5a71f4mr16072e0c.4.1750358784118; Thu, 19 Jun 2025
 11:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619105117.106907-1-abinashsinghlalotra@gmail.com> <hzxqc3tbxc7bd6s3qv3hyocxvhuh4zszkvkqkvrmefhc5qrlez@5yroq663nxpj>
In-Reply-To: <hzxqc3tbxc7bd6s3qv3hyocxvhuh4zszkvkqkvrmefhc5qrlez@5yroq663nxpj>
From: Abinash <abinashlalotra@gmail.com>
Date: Fri, 20 Jun 2025 00:16:12 +0530
X-Gm-Features: Ac12FXwgPdwl46ouWcSvV-e23OqMaKKH8ZZxMHn58FSunXDV9g7azu6sJHmRmrI
Message-ID: <CAJZ91LB0Sq7X3QUhNOPRXNC8YDgCfZQaPvEn_AP8=JEcfXEe=A@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify: initialize destroy_next to avoid KMSAN
 uninit-value warning
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, avinashlalotra <abinashsinghlalotra@gmail.com>, 
	syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response.

You are right =E2=80=94 it doesn't make sense at first glance.

I went through the code again and tried to understand the connector's
lifecycle more clearly.
The destroy_next pointer is initialized when detaching the connector
from the inode and before the connector is destroyed.
This bug would only be possible if the connector allocated by
fsnotify_attach_connector_to_object() were to somehow
end up directly in the connector_destroy_list, which it does not.
Before reaching that list, in fsnotify_put_mark(), the function
fsnotify_detach_connector_from_object() nullifies the obj pointer.
After that, the destroy_next pointer is explicitly set to the head of
connector_destroy_list.

So there's no scenario where a connector from
fsnotify_attach_connector_to_object() can land
in connector_destroy_list without destroy_next being initialized...

This suggests that KMSAN might be confused, as the following loop:

while (conn) {
    free =3D conn;
    conn =3D conn->destroy_next;
    kmem_cache_free(fsnotify_mark_connector_cachep, free);
}

should not involve any uninitialized value access.


Thank You
regards
Abinash


On Thu, 19 Jun 2025 at 20:27, Jan Kara <jack@suse.cz> wrote:
>
> On Thu 19-06-25 16:21:17, avinashlalotra wrote:
> > KMSAN reported an uninitialized value use in
> > fsnotify_connector_destroy_workfn(), specifically when accessing
> > `conn->destroy_next`:
> >
> >     BUG: KMSAN: uninit-value in fsnotify_connector_destroy_workfn+0x108=
/0x160
> >     Uninit was created at:
> >      slab_alloc_node mm/slub.c:4197 [inline]
> >      kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4204
> >      fsnotify_attach_connector_to_object fs/notify/mark.c:663
> >
> > The struct fsnotify_mark_connector was allocated using
> > kmem_cache_alloc(), but the `destroy_next` field was never initialized,
> > leading to a use of uninitialized memory when the work function later
> > traversed the destroy list.
> >
> > Fix this by explicitly initializing `destroy_next` to NULL immediately
> > after allocation.
> >
> > Reported-by: syzbot+aaeb1646d01d0358cb2a@syzkaller.appspotmail.com
> > Signed-off-by: abinashlalotra <abinashsinghlalotra@gmail.com>
>
> This doesn't make sense. If you checked definition of
> fsnotify_mark_connector you'd see that destroy_next is in union with void
> *obj:
>
>         union {
>                 /* Object pointer [lock] */
>                 void *obj;
>                 /* Used listing heads to free after srcu period expires *=
/
>                 struct fsnotify_mark_connector *destroy_next;
>         };
>
> and we do initialize 'obj' pointer in
> fsnotify_attach_connector_to_object(). So this report was caused either b=
y
> some other memory corruption or KMSAN getting utterly confused...
>
>                                                                 Honza
>
> >
> > ---
> > v2: Corrected the syzbot Reported-by email address.
> > ---
> >  fs/notify/mark.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index 798340db69d7..28013046f732 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -665,6 +665,7 @@ static int fsnotify_attach_connector_to_object(fsno=
tify_connp_t *connp,
> >               return -ENOMEM;
> >       spin_lock_init(&conn->lock);
> >       INIT_HLIST_HEAD(&conn->list);
> > +     conn->destroy_next =3D NULL;
> >       conn->flags =3D 0;
> >       conn->prio =3D 0;
> >       conn->type =3D obj_type;
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

