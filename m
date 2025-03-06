Return-Path: <linux-fsdevel+bounces-43362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35DA54DA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2E7A8D44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17C1624ED;
	Thu,  6 Mar 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELd1dBKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFE14F9FF
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271072; cv=none; b=MN/6EcJWx50LJSlPBqdKY7z9HeGOXB3f4XXRWq7/TB3fmB3f8GF4pwyK9kmw/mxFXGH9mZ4+168gvaV+VtbttB01tl/bWLEyxcrIb+p+h05ktdFYKLglLf4e85vVv+e/Uwv0qhNnLokIqDZE1YWI/oqbJ8cFx/JhB2ajiGBfrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271072; c=relaxed/simple;
	bh=4cRnfMrXNgP74AhMUv1DDwM0g0qby4EqWt0I0z8eUz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6jLiaHaP/xoICA7cH4xBj2dh+tezte0qfftVpu7Hm7NzRV1w4QCdjo4fOw6n+4V/HHyBd94mSVbqdN+Dvmks8fFjWHDVQx6tZob1XSnK4IeIRJN57wktGNpLiIIDK8cZuPAmHyvN2hKjBN7Nq3oGVeTx1HJTmdtwiQpArAv9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELd1dBKa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741271070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+nfX7BA5sGs6XnEIq4XvE0XeVuE0RvvxaHJszvCt4E=;
	b=ELd1dBKaeLHxLCnX4izC8Q42/hic0V1/wG1gdkobgGpy7egMYDyAEL34DeZReH8WkXT3zg
	rHjPOhQa9N+b9FGRQ6kXhC+1XiPP2hX+Cr7kZdeAhm8rPdhG9qXZYoQZnD1fu8wGyxaoBd
	r5R3lwy9M3hCwRlkU7eEv2lyEE2HAg4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-8cIJ3wftO0Cn-ukVPuBISA-1; Thu, 06 Mar 2025 09:23:26 -0500
X-MC-Unique: 8cIJ3wftO0Cn-ukVPuBISA-1
X-Mimecast-MFC-AGG-ID: 8cIJ3wftO0Cn-ukVPuBISA_1741271006
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523da152dbfso149768e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 06:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271006; x=1741875806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+nfX7BA5sGs6XnEIq4XvE0XeVuE0RvvxaHJszvCt4E=;
        b=vEAf91eFEPeHL446Z3pMDMOq7z0UJwdlh5HV4iH1DkZJByOxonIAcR6UlbbTPaetC3
         /hOVSIrlC7m5K6Xp5XzaNiRYz1mwVxWMy4W6qUh/2KperL7/5ttAno19IVBpNY/VLj5n
         sPrrXfVdAYcOvJzTW1DVbH4DNKRRP1ViAAaXr9WuWyB4wXn14vi7BpB89lAwnnE5gGnP
         abu1Qy83EDBv7w/kbfSej0a1JFQk6R9qbhnQtOx8NAScixnvD4YZxsZRv/jmuAG6gS4s
         Mm2o+xJ4uS0DUNw9QCOJIZ9Nzsp76Zl+VLEx8az8VYww+85GisR7Lo7TXqCXc+fz/wJV
         BBDw==
X-Forwarded-Encrypted: i=1; AJvYcCXgPaCDXfskOiRs5hS4s/kFurZKMmNMWRZxXAP2m53tFZAw4XJNAqrhjq6DPPratIf0Cp1YxHguu8hN0s8/@vger.kernel.org
X-Gm-Message-State: AOJu0YwBp48xJ0sMtS4FeIdHJJdZvkLj4KGUUIj+7LoWaEXIQ7O/56rf
	ko8dMtE7Ye8h1hLSaJeMrGDFsowX4JO8LU1VGWGKXmML52b0lDQz22oyGzd9nsEswy4czQcflEN
	Grlpa5spdVf66lB777vqgBVPFBAmFKRLMKxJVNq4qgBRr39YK89OaIBjxNRuMIEGCQdYpBjquXF
	Zf6q9cVgHqTRX5T2dU5HG3BJNlLub7WbGny8qengV1xDZ8CQ==
X-Gm-Gg: ASbGnctZD3qWtJvTzuiBwCfDsatBUOvReyxLWNBwDRqgOC/Fz9xY3vA77I05U3KPZWN
	Ii8Uz8eQ9FMqMeVbjzsV4PzbzmG8IanKHzusm5PSJY807giXQdCpo1CQVHNmcZYD6og18Xkue
X-Received: by 2002:a05:6122:3543:b0:523:a88b:a100 with SMTP id 71dfb90a1353d-523c625956dmr4740553e0c.6.1741271006276;
        Thu, 06 Mar 2025 06:23:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVtr9AvTdUbotRfqs+82ZfKfpB2lA9Qt1Ki2tmjlpkAJqqa6nz22ssPNDQkUZJFq++aFAEU6yXyv7SXQ3yJn4=
X-Received: by 2002:a05:6122:3543:b0:523:a88b:a100 with SMTP id
 71dfb90a1353d-523c625956dmr4740524e0c.6.1741271006018; Thu, 06 Mar 2025
 06:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com> <128444.1741270391@warthog.procyon.org.uk>
In-Reply-To: <128444.1741270391@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Mar 2025 16:23:15 +0200
X-Gm-Features: AQ5f1Jq_ryt2aasTBoPxa3bwyGoKVzt6gn9_fb4UHa2K0kNZYORUSPftWl9IxOI
Message-ID: <CAO8a2SjLjejmEHFybLJYST4cNf+YyNyCHZKq_5pwsenqkjPrSQ@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Gregory Farnum <gfarnum@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's best to rely on protocol specific error codes rather than system
error codes in these cases for sure.

I'll make a refactor.

On Thu, Mar 6, 2025 at 4:13=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Venky Shankar <vshankar@redhat.com> wrote:
>
> > > That's a good point, though there is no code on the client that can
> > > generate this error, I'm not convinced that this error can't be
> > > received from the OSD or the MDS. I would rather some MDS experts
> > > chime in, before taking any drastic measures.
> >
> > The OSDs could possibly return this to the client, so I don't think it
> > can be done away with.
>
> Okay... but then I think ceph has a bug in that you're assuming that the =
error
> codes on the wire are consistent between arches as mentioned with Alex.  =
I
> think you need to interject a mapping table.
>
> David
>


