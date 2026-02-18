Return-Path: <linux-fsdevel+bounces-77567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMYsDGiylWkHUAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:36:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD91156621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEDDE3024A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED031A04F;
	Wed, 18 Feb 2026 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3dIbMAd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOPvrSFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F132D9EF3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418196; cv=pass; b=Ds0Quvwol4OWLxeWlabbip7L9OW2M5P6++v0cH89LIJHcvuocRrm4CCxdexLiVeQ9PcPvMkiCRS0SOyezYuLumOqawj+icmnCTmvpOP0ajrMTR7qxQpktpqhnzAvGeZ0F+gWZJPaOUAaQONYPOo8F3y5PMymI0aRwfAf8zGB0yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418196; c=relaxed/simple;
	bh=0fG8sI+zWvMFlOr7IghYSSJ1KnweFDqAywl+kGXxNz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mi2xZ9yKACH3K9XgxC0gc8A46DUZAprWH2pwJoirPxjeCUCgykOAQpPLWW0Fh/sRrmhun+xtXwTOwk3Gla9XgQ1et+s1SEBG8ulUbqaRWvqC8V8oRrOFU/ypM3d2toJ6ghP7YkLoFnSEK8a/5pZDCz0zvKphq6r2TampU0IkhLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3dIbMAd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOPvrSFF; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771418193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
	b=R3dIbMAdE1WDrVuzn8p7w4oEVLiUat2W5aWGrBr59Aa+aEK9/DIe3HoeOVVDLKrWC/rufG
	L0zr6XAzzq9N+XPVplX8QxlTHZShIFaYF6/R6r8r9C+vzOeipaKyq+FTEMrHhCoVzNoLpv
	OCrEyu3cEV8pn5VjI3bJ5sSLv1Pzn1w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-M5VgczWqNfaKbN4FVPQ7vQ-1; Wed, 18 Feb 2026 07:36:32 -0500
X-MC-Unique: M5VgczWqNfaKbN4FVPQ7vQ-1
X-Mimecast-MFC-AGG-ID: M5VgczWqNfaKbN4FVPQ7vQ_1771418191
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a92a3f5de9so36661435ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 04:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771418191; cv=none;
        d=google.com; s=arc-20240605;
        b=gugtChVFQYtOl7D3esBEqTD+vrnDaO12fzezDtjBsMZEIWcrcOxTfZVMUIpjSk0cl+
         0XQ39KMz2PPkndT2KN63K3wg+ywmhL5OiiuALnP3X7UJuRFvmdLPsUQaqOWeZpGhjDLr
         z9+1QCQvZz7MJgnf1XYQ/EP0hM+bHnU3zm5LupyC09NIzHv8niovVvC/wxxR6agu+xGh
         XIgW5K/TnkVFR96NLac8DYYq70vCwldaQhhq0+Bx4U24Noi6vr1HQoAT/uYAqwGNs3v8
         hCLHpdBUEuJQwXdURjkyUvfIkoUFK3coHUmXtCK1Btec5/uOmUzfMqpJrCeKlrEZpLjz
         4lLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        fh=AkhKhwO3ih/NZvZCLvMbSdbda4JPU2PACAgIxGFgreA=;
        b=bjVIL9jSxLpOS6t/MecRjF2ltF9/DO4lL9kmelVUVwKrlo9xRpyOMS6v6Bt+aN81YG
         z5P1rm2FeYt7EYNjGZigFS+ig3xhlPM/ii0+lMBLRbrvH3N6OyXUcLh7ZHi7CsKaX5hG
         /e/2Kq37e4/kRyqSDQ8/Jz0VLEp6Zf2a3WwiX+iYqlTXHxgGGLvoxAXhjpvpcWcQqEWS
         dylShsJAMYtmSfBZCF3uuf+rECxwyemqrN0XhKdwJdvZoEMo84sp46SIy3+gMYzBL6MH
         X2Av6q3Ri3m8NI7IrKQXyJ5bS0L5Ch/UjbjFrfeQqRbKNfRWcNsupW8wHFgbO0xlvYh5
         5AnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771418191; x=1772022991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        b=FOPvrSFF8bzz1Ja+OiZEv+rXfuVir/toA3cAmiieNqo1OgDIlCdscjGZKV9DnluXtT
         KkRkT8Weg1vgmFhTagcYY17mLgRXBP9mSyHuycCDkasVyh19FUeqnLhylWRGjtPF0tGA
         ypszko3iyjVMYLOBQQ4Mz6ivTUatho5zNWtgIV6tt8KtsXvnSzs+J4mZ339oqLLrGxr+
         4fwW3AO+5aAy/9uVXbMtxXpW4eHuyg3YVlmOGPY/vM/tiiQWfGhLQnLiGKwjhIPYI/+R
         YWS6P4d8e+TUc1LT/enVZuHOFv7JnOZHXoz4zlpj6ygw82Q9Iy7wUqoR0j244cUxr7cE
         Nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418191; x=1772022991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        b=FVhG2BOg0P68vWqFSM/shRQ3frQ3PLW7QSxbQs9vvilKXiUllrJbHXVv/QYh/eboQM
         rHFZVBj3Mfl55htxaOd/4P/e62igbegkXEkyCeVpYbUeXJu2ek2r6e2GYGfrnPrzwr/H
         3sIC4nXiS0l4DPTfMC4Maegll+bzYcwwJeOAIl/+Xhmfic3N3zZ+4bjtq/qJFHDF1Lmw
         2L8s0XgKKpk7Ra2j52/R44e+FYxXVsOz3ybaN8PVeWXuvm1rwR8kbiw9I10ZiHbinTtb
         8SXb+AM7sxYc3A/N7kEILbEsgDrmiBEDHv4SbEVJNyl/nivwl3QtWMAjeasx05TP1rNk
         nhcA==
X-Forwarded-Encrypted: i=1; AJvYcCWOxAXqAGqwWODmnUCVI29s4wUUyOdmMCOEkWlPNzBRU+sZtXPaLbXNG3Fmu12gJDUc+qSYYSJbWzf0tCQ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPH9cENgFMiaI/L6kdj6GpR5RAEIrEkGlYJ3Yf/6fA1vVOdCn
	Dno36RVJRPQzxXiAAr/HbkjXLb4vG6/FMKy7oFAUVw0KqBHa5ngwlzE6sSm7awfVJuEmztPvOZt
	udzIX4ZwrZK08aAW6y8iMCsgP0zLhQ6YZ0GIrXYJ8/AmWXMYRUDB2QZeQ4L/50TmNKYyXJd3wqM
	LUN/ThFCK4EosEO3bJ11/ocSN447FXvDl1MRrycLnk3g==
X-Gm-Gg: AZuq6aJ+Hg/fTKZAFlaGk1ZuVg7SM1zMLAwM5aAUUtpoIzSxjasIlRXycWoRTYLCrJQ
	mzOqlQqduyW0AV+y/78GwyR199QbI5+AaofVm2PiFqnkfn9ToEtJtY32cxhb02i9gcnFcshHoz7
	RQltgFoz2bTajvFXr00SxmOEZsZMItNPLJrWyz+rMYQKwKeNQGGknRXr6AJ+gcz/ZDIo7HpQ86c
	GO/
X-Received: by 2002:a17:903:1a10:b0:29d:a26c:34b6 with SMTP id d9443c01a7336-2ad50fbc316mr16329945ad.50.1771418191223;
        Wed, 18 Feb 2026 04:36:31 -0800 (PST)
X-Received: by 2002:a17:903:1a10:b0:29d:a26c:34b6 with SMTP id
 d9443c01a7336-2ad50fbc316mr16329765ad.50.1771418190809; Wed, 18 Feb 2026
 04:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
In-Reply-To: <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 18 Feb 2026 13:36:18 +0100
X-Gm-Features: AaiRm51HYWR6w0-EcsphJc410XncNKnjGKv9rOIgL6E3XvZhdcve7uAr9h1HcsM
Message-ID: <CAFqZXNswp_bKq_78PgVpToK1Zm36ZL4atqiid2Lstaqa0sKnBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fanotify: avid some premature LSM checks
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77567-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8FD91156621
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 12:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-02-26 16:06:23, Ondrej Mosnacek wrote:
> > Restructure some of the validity and security checks in
> > fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
> > denials in the audit log where hey shouldn't be.
> >
> > Ondrej Mosnacek (2):
> >   fanotify: avoid/silence premature LSM capability checks
> >   fanotify: call fanotify_events_supported() before path_permission()
> >     and security_path_notify()
> >
> >  fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 27 deletions(-)
>
> The series looks good to me as well. Thanks! I'll commit the series to my
> tree once the merge window closes and fixup the comment formatting on
> commit. No need to resend.

Great, thanks!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


