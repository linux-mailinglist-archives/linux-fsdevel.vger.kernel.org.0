Return-Path: <linux-fsdevel+bounces-42111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D191A3C6E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768C81892411
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79682147E6;
	Wed, 19 Feb 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe9EkqaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAB214230
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987939; cv=none; b=qvl0O5epFuVfj7aZqhrwrQrxglgahgMu3VeC2N9P0nRMZ/bNbNmVtBpycG2KxmYuInpEzefHyz3rqaxl3q6y9XY63ZV5m/jwKPypvZOhE2OzUD8BCeSr15U4DGiDJBRw7PnQh/xxeQTLEpFe0nQPEsmBt6fVBH8k8qpkyrpeGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987939; c=relaxed/simple;
	bh=qeVZZCl70fo92RGRX0CxSyUEL18jKIx+OWPU9Z2cSTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eifw9wY5KAbsCVQ/oSXzLxrj47hFQQ8Mggag1TpEDWSFa1t9SNvvjX9pek50C2NhP+B2lre0oJIP5roYmBANlQ8BROdVwyY9znqqrR+yXRpPjg6zluG7BodU7867e2vf/PiBfY9nilFDs+o9Te2Ob0+ZqbM8ImJ712sEC09HIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe9EkqaZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so11920646a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 09:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739987936; x=1740592736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4DqovM4Ou0UcJY5/Qp8ERIFvHMLB5AQH/4HoGU6zwY=;
        b=Qe9EkqaZoSY+eWShX/S5954jPBa33UF8OjnWiurrSRh5emDtnTD9fut9xrNV2zBIen
         Yt3KCICHq+EuetreKp6F281MLMYFqfWFd4fae63JqD+ef3lQb4/0wJ8jZkk3gunzhNvp
         vYYrAI1MZs+1XDVj50jlRF0LRCyraQhfvBDRExxJfa3RNdG83ME1PgZacxlnw5LkiAF1
         RuII2ntds1iGDWncCNYn41qnpjMdnguTVwzOPppf8CQDHbRKDESasIX0sT5K0FG9EVKW
         wKhsh+NmNkqBn7EiT1kSI1i0jODpxBuQhAK3zvL+CgqM1UIR+I87AQ1Tljn7TftuOhh9
         aAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987936; x=1740592736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4DqovM4Ou0UcJY5/Qp8ERIFvHMLB5AQH/4HoGU6zwY=;
        b=ERf66TeBfxA/F/crno1LpOecIbMyntBUexR4sj4OcKjrOUOiNksoRhixqUdB/zaAjl
         FOndDJymfmDC7T6SjaSVW9x3d69oqDVv4Dzxp1zq838hEf+k5x+cDeSX51T/IW1Ne6fx
         ZbdNSzOyfBSJWcKOvPWPBTFF+dOpc8xo3dhc6BfMsI8OAUxFFKfPp8PDKZEfaQZYa6nD
         7ZkG0jrpLhg1ag4HlbFRy1ZQ+TmwXT/p98OgLImsaYHukafpwdsX8eIU9FYR8kZjPvb0
         N9gCbzaaVV83wAo/UTKUpBQ69cEBOQJvBTYkIpp+AJRkhBOeCV2LzdVUi32jVHDs8pmD
         clvg==
X-Forwarded-Encrypted: i=1; AJvYcCVvGaBqRpWysU9onosW0IMnikyzYq1dB+j7ZVMz9QXV8TiqtdKx8pXeZr2e/f6vXHTmd1YLf5luqDPNYSXS@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMN4Li2m6te28u1EA5R1L23gfqsnlkqb2QHmsxoSGYsr7WVzw
	bOUB8hUlPRzMk/D8H1H6b7StU5iCZZ/Suoj2GtCKKGqt3oA15ovEA6+iY/R1KD9rqh1G/WNO1uA
	Ms4nrkJs5mJAPPKtvzVjDkoNwG60=
X-Gm-Gg: ASbGncs/dV4Oje+16WOKtAO6ooo7aM0RYfYxeBGLmEVMP4pKETfHbwn5MOfvwexF9E4
	C+WFRFL0UcuzkIhStvMMJG3ZRfRQUXgIU//+D0PmC5/+fl6szPwNMIfFGnWxZCi6V8LHF/I21
X-Google-Smtp-Source: AGHT+IG93GVdgzPX9ZdwmOFV8Uf6c6MNSkc8SUwaEixJk//FsuJ1LhBRkLijKAirWCWSqZ/Kyc4N3Xi6n2SDf4JUF4o=
X-Received: by 2002:a05:6402:34c6:b0:5e0:4408:6bab with SMTP id
 4fb4d7f45d1cf-5e089524924mr4050562a12.19.1739987935166; Wed, 19 Feb 2025
 09:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com> <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Feb 2025 18:58:43 +0100
X-Gm-Features: AWEUYZnOzQNz-FJuWsfPmeGuSBDTPOkzpthsuawIgy7fmi1_65O43jVZS8zJHQY
Message-ID: <CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZQzzjygaH3TjH7Uc4+Q@mail.gmail.com>
Subject: Re: LOOKUP_HANDLE and FUSE passthrough (was: Persistent FUSE file handles)
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Hanna Reitz <hreitz@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 11, 2022 at 12:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote=
:
> >
> > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > LOOKUP except it takes a {variable length handle, name} as input and
> > returns a variable length handle *and* a u64 node_id that can be used
> > normally for all other operations.
> >
> > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > based fs) would be that userspace need not keep a refcounted object
> > around until the kernel sends a FORGET, but can prune its node ID
> > based cache at any time.   If that happens and a request from the
> > client (kernel) comes in with a stale node ID, the server will return
> > -ESTALE and the client can ask for a new node ID with a special
> > lookup_handle(fh, NULL).
> >
> > Disadvantages being:
> >
> >  - cost of generating a file handle on all lookups
> >  - cost of storing file handle in kernel icache
> >
> > I don't think either of those are problematic in the virtiofs case.
> > The cost of having to keep fds open while the client has them in its
> > cache is much higher.
> >
>
> I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> implementation of persistent file handles for FUSE.
>

Hi Miklos,

I circled back to this. I don't suppose you know of any patches
in the works?

I was thinking about LOOKUP_HANDLE in the context of our
discussion at Plumbers on readdirplus passthrough.

What we discussed is that kernel could instantiate some FUSE inodes
(populated during readdirplus passthrough) and at some later time,
kernel will notify server about those inodes via FUSE_INSTANTIATE
or similar command, which will instantiate a fuse server inode with
pre-defined nodeid.

My thinking was to simplify a bit and require a 1-to-1 mapping
of kernel-server inode numbers to enable the feature of
FUSE_PASSTHOUGH_INODE (operations), meaning that
every FUSE inode has at least a potential backing inode which
reserves its inode number.

But I think that 1-to-1 mapping of ino is not enough and to avoid
races it is better to have 1-to-1 mapping of file handles so
FUSE_INSTANTIATE would look a bit like LOOKUP_HANDLE
but "found" server inode must match the kernel's file handle.

Is any of this making any sense to you?
Do you think that the 1-to-1 ino mapping restriction is acceptable
for the first version of inode operations passthrough?

Thanks,
Amir.

