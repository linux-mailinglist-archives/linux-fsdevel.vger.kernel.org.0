Return-Path: <linux-fsdevel+bounces-55177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D8B07845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8623B356C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20BC25F998;
	Wed, 16 Jul 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+IlrLYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D8233156
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676720; cv=none; b=LC7FpWM0k3OrIkFrBfaqcOy/J3EoBM70HdNlkPteRq8VDpX3jagsQXZXl4SOSyyATnFEHVhZbI232DJxYO5Y0CaYUXxeXEhQqWal6Znsp+0LCri3SWDdJrTUVpJwIhzuY+NrbuTENc4kxzeuxUi6Ud+Tw2yg94xsd22f8SoOR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676720; c=relaxed/simple;
	bh=fEwyBD9zCqEXpn46h74QUriNhRgeE1cfi2HsWwNkHXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwygued4VvFEuohRZ8lj1hAklu7HpSdnL0MA3KBY8mKdQh2V57k9ftX+GMVAnCpBWGVlorGKoitk8y1glMSxuIYRpXSRRroevgvyuKIJYiM4UECA4EhuVUSJzy4RC9PjM0vJmPHesmkMgPgCCaS+mUNzpmrVrKbdV6thlB7Eje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+IlrLYS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70e767ce72eso62046327b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676718; x=1753281518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhcQjFBNlhjayD3fSHczSWZCPQ2aWrX+mQKIALmy0JA=;
        b=E+IlrLYSalBnaf5KzFJPMGU9IZ1ZjJS5PndrBBcZPgE0+0fspzxPoaST1l1C/RB4er
         ojifP/lxJAX4T0BjvjV1VUbNH3ngRcQkrP832aQ0yyGeee29bTwNSZp1CY+FwbeJ8nYO
         TkMgeu/0cAIOwml27Y4PYAoQh/BDakaRO4iuJMchG92T9DdMSWDDR30gNJr+AqWn84/U
         W8ct1YNeXOljzPK6eUKkE7FUAZg0U/Vz0d1++e+m7yFVIDDfzhMVAnbQS0zwvxxIUP2w
         uTywHddKPHJKu7B+EKF+uNsPNRyFiKbVv9rwJPAbkJyCurNQieJf8qOJmA6aERLx8Ixc
         jjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676718; x=1753281518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhcQjFBNlhjayD3fSHczSWZCPQ2aWrX+mQKIALmy0JA=;
        b=rf/4KGzFC+jvHB05BW94IlEYTYjmvOdWThHgFdQYHOqhmsSHVu1w/RoP7e0saoC9z/
         If6GxcQNnja3ibWP49GsATP1tGYeGVqQL9G52o2HSQ7SJJoPEpau9s1yQPZFFDNvbyCv
         mOBZaQswZvLlZdGi/cMX6zWyVjitymJRAOe8POXUkwItrBPCMrhQLnA4FV5O12EVSnYH
         +D0Qewbuyd03CM8i/EM9bWC8qlGIsrGWhju5UWDqzcCZ/+DE+55CuWXEUI0WPW9Xvt99
         tkTAgg9jEHd9cnrql710lgms5pDJOzvoY0LfciNkCxtgyQ++nLu1+fbUgn7nH7/UtnZb
         39Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW4EfjE/WQGV800OVFuFTxtDRdULT+KPVpfAVojoIg8GVKNU/I4j25Uhj9qCsIdHVlE+M5/Z1HCMyfM36VU@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtnymiNQFOnsKTMuhwNVmaGv3fiChRphDzHndMksXh4c7oJ+q
	Ru1jlZanMyOWo1RtmrG0Rvm07Qs4yJvDlKxMDjcgiTnF/VG5Lx4PcCC2yHTXf6ptSedIOAOQhFo
	k907ex/Xat+NBLeGFC7kW2f/4AmSDaY8=
X-Gm-Gg: ASbGncv9R+C0Zt6IDbzZn0kLgu6ep9o/qG6RxPTqR+q/kM9SabUZBg7QlPJsdK8KlO8
	6tmINz0ndtEHrtKJTSXhYGdJqOuLVRuTvHpcVThK7Mkg2VI0IL337HiCCMwkQp7844EgpzbrqSj
	afdh8nuJl3fSzn9Gk5yM9UJcuFQh33PAJ64MSmgfKgCshqOgj0bsN7fgOAoM+3RwStGSXhKPakG
	0fll9vfmg==
X-Google-Smtp-Source: AGHT+IERFUSvc/25Bal7wiLrTZp7YAi91jAOxvoJ3JJxwSwFFZMAgwRW59DBHY5ZqkEFUfL5m/1DmPFFZcNOL7Sh6iA=
X-Received: by 2002:a05:690c:dc1:b0:70e:326:6ae8 with SMTP id
 00721157ae682-71836cab40emr46122597b3.2.1752676717626; Wed, 16 Jul 2025
 07:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
 <20250716131250.GC2580412@ZenIV> <CAKawSAmp668+zUcaThnnhMtU8hmyTOKifHqxfE02WKYYpWxVHg@mail.gmail.com>
 <aHesCjzSInq8w757@casper.infradead.org> <CAKawSAkQd_V9wJn6fiQQWVguTB0e7vDNnQqjuZRUZ1VwzXuvog@mail.gmail.com>
 <aHev2X8439xaamsX@casper.infradead.org>
In-Reply-To: <aHev2X8439xaamsX@casper.infradead.org>
From: Alex <alex.fcyrx@gmail.com>
Date: Wed, 16 Jul 2025 22:38:26 +0800
X-Gm-Features: Ac12FXwN7R8G3PHsDxOXu9DQZ83ftwYkM2Xyx9ZzLfLZnvubAPZMSEDPFzo1kzU
Message-ID: <CAKawSAk6heeCBCnaeBmfMWaiUPqk91KV26v=WdkkpHOv_iziag@mail.gmail.com>
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, paulmck@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jul 16, 2025 at 09:44:31PM +0800, Alex wrote:
> > On Wed, Jul 16, 2025 at 9:41=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 09:28:29PM +0800, Alex wrote:
> > > > On Wed, Jul 16, 2025 at 9:12=E2=80=AFPM Al Viro <viro@zeniv.linux.o=
rg.uk> wrote:
> > > > >
> > > > > On Wed, Jul 16, 2025 at 08:53:04PM +0800, Alex wrote:
> > > > > > The logic is used to protect load/store tearing on 32 bit platf=
orms,
> > > > > > for example, after i_size_read returned, there is no guarantee =
that
> > > > > > inode->size won't be changed. Therefore, READ/WRITE_ONCE suffic=
e, which
> > > > > > is already implied by smp_load_acquire/smp_store_release.
> > > > >
> > > > > Sorry, what?  The problem is not a _later_ change, it's getting t=
he
> > > > > upper and lower 32bit halves from different values.
> > > > >
> > > > > Before: position is 0xffffffff
> > > > > After: position is 0x100000000
> > > > > The value that might be returned by your variant: 0x1ffffffff.
> > > >
> > > > I mean the sequence lock here is used to only avoid load/store tear=
ing,
> > > > smp_load_acquire/smp_store_release already protects that.
> > >
> > > Why do you think that?  You're wrong, but it'd be useful to understan=
d
> > > what misled you into thinking that.
> >
> > smp_load_acquire/smp_store_release implies READ_ONCE/WRITE_ONCE,
> > and READ_ONCE/WRITE_ONCE avoid load/store tearing.
> >
> > What am I missing here?
>
> They only avoid tearing for sizes <=3D word size.  If you have a 32-bit
> CPU, they cannot avoid tearing for 64-bit loads/stores.

You=E2=80=99re right, I got that wrong.

Thanks for the clarification!

