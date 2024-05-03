Return-Path: <linux-fsdevel+bounces-18668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C38BB3A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D7E1C225E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92214A0A3;
	Fri,  3 May 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW5AyI2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285941C72
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763073; cv=none; b=fp1lgltwbKVUOvgbiG93yRMxQIYa/XSQV/oMEl1JwTr/kTWJu78yubrUbAp2cG5cC7zb6gevKtR0GB0zSHJtwnTIVdwAtaFTmyCM/ty6HOTIgEYnko/u3yI5a0s5P0GqiyLAle8sWGUS8H0XqrRydt4FM14cKQcVHu58A4kwn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763073; c=relaxed/simple;
	bh=VlYGvg30VXjOnYOnvFtFihmydrnqz0GOaYXR3PXcftQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De6LLggDNHaDcc6Dw9kWVHDD2Upn3/HD16TKRMoqFFAeneFFYLgMcue1zbW/fDdGOVbKOXVbJx6jWD7M7GrJr/nnXDRbZm9FUfO5Fsnslz/YyeGd/a7vbuAKo5EwCFBvV5UKmsQYEXbyBTzceGsbBivhQQKZW+sGrzJdy7c4lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LW5AyI2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714763070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6ovhXrSwasBCa/uuGPOrNPHzs8EL5HuNVawLpdIDNM=;
	b=LW5AyI2xBbNcZFhXd2VvhSw7hbEgdGzy0zK8hhusXhn60B2la8bYZafFdFDZ0VBsZ4zQo2
	0BbV0JQ+71WwFZAAqy2jU2WTiQ/lVXaiKNu3f8hcTrqpjYcvgbkld98sNuGdQMBfGTdNQT
	w5We4ara+ZECxCkr+4idDZ8m8hYNEgQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-jlSSGvreN2S6XVexFpfI-g-1; Fri, 03 May 2024 15:04:29 -0400
X-MC-Unique: jlSSGvreN2S6XVexFpfI-g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6089c86e4d9so410a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 12:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763067; x=1715367867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6ovhXrSwasBCa/uuGPOrNPHzs8EL5HuNVawLpdIDNM=;
        b=eVOaIeVuWBfiq9hEaede/fg2VsvSpEREIJTXZFanf4pVU9wnDFOQYq7bZ/BvsiOkDu
         +5vDSFpgf6lyh1fPpm6+szENIWBadHZVWTCshm3/ej9IfQbirNdDGTWVIXhr4zsJTshW
         iga4jukmaGNXkuA3sHwNU7jhJQfkrh5OLHfne1TYE3fcTx7W+l0SgzBChwTk+bezzQXA
         lrjw3CliyejY/+WzjKwVojn9YRsqKn1vcbaMh5qpbMc0t9i6dChVGcW+OaknvTipSHmu
         TprHCBu0a3EUK0qQKI97at4pzBwSU08WppXoqOQ4nh+Yc9v/35U5Do2n1r3JISdGNgy/
         uF1A==
X-Gm-Message-State: AOJu0YzmZdDnwjh4hh1dJB+lZPCII5/Kh4Q19Aq1doZ5eZfpiFjmQrJ9
	bpvcc/81xu9ztRw8scxGWgXBJVHwTO/4GBVsXcsj2X2hBc2JlqgM0e6kXwyCXoCd5sv1mC9n7aS
	rt/pYSG3emRTC+xrlpSo3MkVXl8OgydhQNDEc365cMO6RJXCEBLaLdttxCUBlynkc0CkCo++Xfv
	N0t5cQSFLqGAfagWSf6aUG8miwajHHU2wA2lvXUWQoGEO7HA==
X-Received: by 2002:a17:902:db04:b0:1e0:b562:b229 with SMTP id m4-20020a170902db0400b001e0b562b229mr4212431plx.47.1714763067206;
        Fri, 03 May 2024 12:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2FgJeIsYYkRQ3inPysisa/T31GJfL7VK1Q1r8SBkYFgkFKg36TVOUAeigYb5lnnmZ40CoxuAdAcqC+HyAx6E=
X-Received: by 2002:a17:902:db04:b0:1e0:b562:b229 with SMTP id
 m4-20020a170902db0400b001e0b562b229mr4212404plx.47.1714763066839; Fri, 03 May
 2024 12:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403172400.1449213-1-willy@infradead.org> <20240403172400.1449213-3-willy@infradead.org>
 <CAHc6FU6gdBq5+GYqcxUEfvypTokAsoGWSEt19jJUyBpVXW5myw@mail.gmail.com> <ZjUtSAxhcMnQ71fO@casper.infradead.org>
In-Reply-To: <ZjUtSAxhcMnQ71fO@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 3 May 2024 21:04:15 +0200
Message-ID: <CAHc6FU4c6+Bz+1fzj-anNGm8TQhvLSGHMnd37S58kG_FeM88rw@mail.gmail.com>
Subject: Re: [PATCH 2/4] gfs2: Add a migrate_folio operation for journalled files
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 8:30=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Thu, May 02, 2024 at 10:23:41PM +0200, Andreas Gruenbacher wrote:
> > On Wed, Apr 3, 2024 at 7:24=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > For journalled data, folio migration currently works by writing the f=
olio
> > > back, freeing the folio and faulting the new folio back in.  We can
> > > bypass that by telling the migration code to migrate the buffer_heads
> > > attached to our folios.
> >
> > This part sounds reasonable, but I disagree with the following assertio=
n:
> >
> > > That lets us delete gfs2_jdata_writepage() as it has no more callers.
> >
> > The reason is that the log flush code calls gfs2_jdata_writepage()
> > indirectly via mapping->a_ops->writepage. So with this patch, we end
> > up with a bunch of Oopses.
> >
> > Do you want to resend, or should I back out the gfs2_jdata_writepage
> > removal and add the remaining one-liner?
>
> Ugh, I see.  If you could just add the one-liner for now, and I'll
> come back with a better proposal next for merge window?

Sure, pushed to for-next.

Thanks again,
Andreas


