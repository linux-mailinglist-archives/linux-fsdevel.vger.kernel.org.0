Return-Path: <linux-fsdevel+bounces-42753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE52A47D34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 13:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410E0172A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB02376EA;
	Thu, 27 Feb 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd/EOY7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB522D7A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658257; cv=none; b=BzhjXlDh+ZpugFx4VtqYGS3/tv/sRKQJFHLEW8ZZIiHZUZS8P6b2EeFp/olGuZU0R6ah6+yugjsTn29OcMUDIRA2euaeptDiSzE+kTBxHgM2XwmSu78O2RYWqLaPB5XJ608i8n6rdtsU/1QCLlcMADzurQfKntgUgPuaeBRfxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658257; c=relaxed/simple;
	bh=aOkF1F5VMEPq7RaUIAlM3GQ8S/xjy7XnYVaX0fCj+0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOr7vG6eP0xKaNwMyFJlVfeCvS0gYls3DbwOfYVcbA+swweRsiJOwcr+Y9z/J8iv35oGAOMqEEor49pJ/GUG2A/m1Cmcl/j705972Bq46KbCwvmGr1zt1u/Q4pKZ6bSbI25jHDkC8WYW24QGKObk6LJl+B1Guapv3hzAf2oKrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gd/EOY7t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740658254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tj+zakv+J1GY4l7pCZIQYpsZc+lQol4w6bSNRx+tEoc=;
	b=Gd/EOY7tjFexIMviX9mMACpU98HjVukgiojYWHZyM22Qhso+vLo27okI1BUxHuZ8KWusAu
	af0Jb2PbhJdcFiiNgZqUZhVdlq4fI19eW8CI2a3uHIeox7d6nO/JdLdmOoIu2gOYApVRlK
	TVXZW/MG6iHVEvZ59k5BgutidmlR7eM=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-uzuhsQGbMDGH6Y4p8VPm5A-1; Thu, 27 Feb 2025 07:10:53 -0500
X-MC-Unique: uzuhsQGbMDGH6Y4p8VPm5A-1
X-Mimecast-MFC-AGG-ID: uzuhsQGbMDGH6Y4p8VPm5A_1740658252
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5209287f6ecso1869594e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 04:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658252; x=1741263052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj+zakv+J1GY4l7pCZIQYpsZc+lQol4w6bSNRx+tEoc=;
        b=EejnuCC3p1bprBATu4A+RtrPpsVDlrLhjcLgV/JmPqqJDFYXbJT5ARwSdat7kInnvi
         fDpjJ/rOV64a2JleTlMQpp4sOEL8bHznIdWdeKmM7UCYGxWHH2Zu11kCrXdDoe3Fqk9n
         gPvEYIVrUtyi+ENrUWGl1S09J1LTjAQu4Qk00awsRNeJYcGP+TV2/ZHuNu4MAq8lnjW4
         wW5OhLweP0MfTvCNXTLeJ/gyhgIUrqGTsXYKN5kxPuczYbO6lQHuMJjV+pIUBDD3nVO7
         1iF+fOgEhxQpf8NhARYZbq5B1hrkdI+ns7DoW7v0Ctnk5/SyRdGs6PXh1npEKy0f+oUa
         3Q6A==
X-Forwarded-Encrypted: i=1; AJvYcCVpd8uvJLfeM5xEW5Tbpo68tH5CZ/1jRVg50uO+HvRlj8HUvORhRnHzRiuAW50KYRwPWHVZPv7MEj34T+Wx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZEKPM1zB9rJIjdzwjhn79DPKoQs+fPL5KjmxjVz+Xr3K6KPa
	NpoNTrhHh08J8IRk2FzYVp5RvT/rCBPXFFeYK1v1SLXtIxS6MSKzndI/B+6aC7DnELQtrx40IxB
	d0i6pO4DrgV2bMCm/qGcDey8W3ohXS6VtD0CghkHfJVR9zj+GybHyhAZF0B808u8fsv8FyGX/Bo
	xslszytRy+MPSilVNReT6A6KrRPN7JwyvSIoiW0Q==
X-Gm-Gg: ASbGnctIcxViDlI73VPYr4ZYyGoOAB8tJfaa5QOTriO+nlqe501ErL4UQfw22cvG/xd
	W7dhou09GY2j+giWxn3hM7GTZfAIIb4nQhCXe5z+5ZPTDHi9y2YxjsO7voKjm7KkaXg6TIF4e
X-Received: by 2002:a05:6122:3718:b0:518:8753:34b0 with SMTP id 71dfb90a1353d-523496045cbmr1334333e0c.4.1740658252507;
        Thu, 27 Feb 2025 04:10:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJGa17hbL3NkPz5zxBEjKMW01JMqo4QqOpmITYprMDbHfl+cq1RqpIucpb1ERVN7ENLR2AbHoL2HW+HIuMFCw=
X-Received: by 2002:a05:6122:3718:b0:518:8753:34b0 with SMTP id
 71dfb90a1353d-523496045cbmr1334302e0c.4.1740658252180; Thu, 27 Feb 2025
 04:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226190515.314845-1-slava@dubeyko.com> <3148392.1740657038@warthog.procyon.org.uk>
In-Reply-To: <3148392.1740657038@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 27 Feb 2025 14:10:41 +0200
X-Gm-Features: AQ5f1Jpf1zukiRVhFjsTvRIc8-aq_RzDevwcME4IdutZG887rGmJUl8WZQfB-M4
Message-ID: <CAO8a2ShC4x+f1y5xUyQLCSzLrTnDWK_z4a6dpm6KaeXnVZKqMQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's something I asked for and Slava and I discussed.
In a complex system it just makes things tidier, and things explode
earlier when not working as planned.

On Thu, Feb 27, 2025 at 1:50=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> > This patch fixes the issue by means of locking
> > client->osdc.lock and client->monc.mutex before
> > the checking client->osdc.osdmap and
> > client->monc.monmap.
>
> You've also added clearance of a bunch of pointers into destruction and e=
rror
> handling paths (can I recommend you mention it in the commit message?).  =
Is
> that a "just in case" thing?  It doesn't look like the client can get
> resurrected afterwards, but I may have missed something.  If it's not jus=
t in
> case, does the access and clearance of the pointers need wrapping in the
> appropriate lock?
>
> > --- a/net/ceph/debugfs.c
> > +++ b/net/ceph/debugfs.c
> > @@ -36,18 +36,20 @@ static int monmap_show(struct seq_file *s, void *p)
> >       int i;
> >       struct ceph_client *client =3D s->private;
> >
> > -     if (client->monc.monmap =3D=3D NULL)
> > -             return 0;
> > -
> > -     seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
> > -     for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> > -             struct ceph_entity_inst *inst =3D
> > -                     &client->monc.monmap->mon_inst[i];
> > -
> > -             seq_printf(s, "\t%s%lld\t%s\n",
> > -                        ENTITY_NAME(inst->name),
> > -                        ceph_pr_addr(&inst->addr));
> > +     mutex_lock(&client->monc.mutex);
> > +     if (client->monc.monmap) {
> > +             seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
> > +             for (i =3D 0; i < client->monc.monmap->num_mon; i++) {
> > +                     struct ceph_entity_inst *inst =3D
> > +                             &client->monc.monmap->mon_inst[i];
> > +
> > +                     seq_printf(s, "\t%s%lld\t%s\n",
> > +                                ENTITY_NAME(inst->name),
> > +                                ceph_pr_addr(&inst->addr));
> > +             }
> >       }
> > +     mutex_unlock(&client->monc.mutex);
> > +
> >       return 0;
> >  }
> >
>
> You might want to look at using RCU for this (though not necessarily as p=
art
> of this fix).
>
> Apart from that:
>
> Reviewed-by: David Howells <dhowells@redhat.com>
>
> David
>


