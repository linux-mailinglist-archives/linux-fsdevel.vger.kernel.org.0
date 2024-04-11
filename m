Return-Path: <linux-fsdevel+bounces-16745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B718A1FE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534C7288282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC717BD8;
	Thu, 11 Apr 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5iyWW3r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0D17BCC
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866116; cv=none; b=uMMau2jMOnjzmaNlIgLm3BHc9Acb6508iMjIDWFYcraEHUbPSuHA0oR/j1qWchvX57pe7imYCufTzxtRZRks+SS4IRQ2EkSdGaUgwxtRdvsHAsgXfoPejQaR50Yn8LvPyY70mdQ3kJ5PVN5VEGBt3/hmOGjFdJCAEegZHR2vXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866116; c=relaxed/simple;
	bh=l+PB/X/jZM3qJjqtjIgT7OoU8QEgAnESwOLn2wQcnWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4UaIpVW54vxtMGoYAnqcwUULgztxTkA3GrE7jWj/N5ZpS+mH3lI28ilaLP8XiqpIT8w7ixnpZy4OEEFs5VGUL6P5o2hSrPxqNX90EpyGrM9wAI3i/NwoIctLCnXkZ69DuUsczC9L+FYcVFIWc89CtMoA7MdjldLiMOEX8lkup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5iyWW3r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712866113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15OsQdeGUPPIY8R4FO9J86rTE+tpV49YjQLRrYO/E4U=;
	b=V5iyWW3rMXCi9Y9JFFinguFLC1stJmdPdO+IjKtwd2VTEIyCX2pHjL7+N23Stmd+kK8ESL
	iSmPQDYcmu/VhsBbiOORDciEQodhoB2b4UgINUWraYRkYribi0cq3wMZOpKQcRkPSpFdHn
	lujqpRUlsO0RYBVwokiXq/lLZHU7L3k=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-DwC89BwhPXmbxugyYUI_FQ-1; Thu, 11 Apr 2024 16:08:32 -0400
X-MC-Unique: DwC89BwhPXmbxugyYUI_FQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4da97346aa4so92012e0c.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866112; x=1713470912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15OsQdeGUPPIY8R4FO9J86rTE+tpV49YjQLRrYO/E4U=;
        b=mdXw/LyKj7n4sVrJTu8VDbPGJzlu3YsiRXaZmeOH7ruDb0WLgoUBziPfdUJ9Txom0W
         3IHXH8cOv4itdPuor0iLus2msveDpd2SVeq/K3znJNrE+cxHMjLePLzbOcGUvCFBhQtO
         turzvJBAZxvXDbUWwFXOERvmU5EqR9rp42WKuKrgxXJcWqQ9vACLg328khe96h/CiVCq
         w8m0RBjWmYP323FcieVzCZ0IU7dJqxR1WReaLhun1x7tdt9RxDKtgX82KYtHMz2REGc9
         bg4B9jaOrXIQe1IkWUB4VYGKPINZFFgLABvW0cuAlT3CJF6NPaQKr3juUPPPvQMzwdP1
         xU1A==
X-Forwarded-Encrypted: i=1; AJvYcCXC+KCMyKvye3b2pdeUf4O7hCd4cHlk+IbZI6SpY4vyh8ip85mgRH3YUoSZtoSjarS3zfdSmUMjTb1P6q+jUHhAbKBwS5qPj7HEknnnlA==
X-Gm-Message-State: AOJu0YwHPVncnAnBknhjRF8fVERlzkC7YKu8Kav6FwJkAzy+5oLLKAWD
	b1+Jth/5yOcwT3tjuZ4EnbkKjn+dicGQPC0NT+QZyWr7KmD7mvhFFaj0Ym0U29OYrScBUsoxVIt
	XWLoX+g28mfmZlnmAoY+KeGObjiwXUpNX8pNWd+fEgDK5hYE6Wgl6yS71DpfR3gQwoJLm1UW47n
	DgJ/DM3nlOYtn7jL0riLP6JcVUZPGWp1tKo0nzYQ==
X-Received: by 2002:a05:6122:d9d:b0:4d3:37d1:5a70 with SMTP id bc29-20020a0561220d9d00b004d337d15a70mr1015170vkb.7.1712866112011;
        Thu, 11 Apr 2024 13:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUkpeZPdl+9XB0K3wqFbYhfySrBjKq5GwEQWeFlW5WQ+7YEepZDRFXCzVBaekpO51v410ufvYyJwpPShSXxG4=
X-Received: by 2002:a05:6122:d9d:b0:4d3:37d1:5a70 with SMTP id
 bc29-20020a0561220d9d00b004d337d15a70mr1015153vkb.7.1712866111667; Thu, 11
 Apr 2024 13:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com> <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
In-Reply-To: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 11 Apr 2024 16:08:20 -0400
Message-ID: <CABe3_aEccnYHm6_pvXKNYkWQ98N9q4JWXTbftgwOMMo+FrmA0Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:14=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 11 Apr 2024 at 10:35, Charles Mirabile <cmirabil@redhat.com> wrot=
e:
> >
> > And a slightly dubious addition to bypass these checks for tmpfiles
> > across the board.
>
> Does this make sense?
>
> I 100% agree that one of the primary reasons why people want flink()
> is that "open tmpfile, finalize contents and permissions, then link
> the final result into the filesystem".
>
> But I would expect that the "same credentials as open" check is the
> one that really matters.

Certainly. I think that in almost all cases, the pattern of preparing
a file and then using linkat to give it its final name will occur
without changing creds and as such your patch will fix it. When
combined with making the CAP_DAC_READ_SEARCH override aware of
namespaces, I think that covers almost all of the remaining edges
cases (i.e. if the difference in creds was actually you becoming more
privileged and not less, then sure  you can do it).

The only possibility that remains is a difference in creds where the
new creds are not privileged. This is the maybe scary situation that
has blocked flink in the past. All I am suggesting is that you can
decompose this niche situation still further into the case where the
file was opened "ordinarily" in some sense which is the case that is
really concerning (oops, when I forked and dropped privileges before
exec, I forgot to set cloexec on one of my fds that points to
something important, and even though I opened it with O_RDONLY, the
unprivileged code is able to make a new link to it in a directory
they control and re-open with O_RDWR because the mode bits allow say
o+w (extremely bizarre and honestly hypothetical in my opinion, but
ok)) and other special situations.

Those situations namely being O_PATH and O_TMPFILE where by
specifying these special flags during open you are indicating that
you intend to do something special with the file descriptor. I think
if either of these flags are present in the file flags, then we are
not in the concerning case, and I think it could be appropriate to
bypass the matching creds check.

>
> And __O_TMPFILE is just a special case that might not even be used -
> it's entirely possible to just do the same with a real file (ie
> non-O_TMPFILE) and link it in place and remove the original.
>
> Not to mention that ->tmpfile() isn't necessarily even available, so
> the whole concept of "use O_TMPFILE and then linkat" is actually
> broken. It *has* to be able to fall back to a regular file to work at
> all on NFS.
>
> So while I understand your motivation, I actually think it's actively
> wrong to special-case __O_TMPFILE, because it encourages a pattern
> that is bad.

The problem with this is that another process might be able to access
the file during via that name during the brief period before it is
unlinked. If I am not using NFS, I am always going to prefer using
O_TMPFILE. I would rather be able to do that without restriction even
if it isn't the most robust solution by your definition.

In my opinion I think it is more robust in the sense that it is truly
atomic and making a named file is the kludge that you have to do to
work around NFS limitations, but I agree that this is a tiny detail
that I certainly do not want to block this patch over because it
already solves the problem I was actually dealing with. Whether or
not it solves this hypothetical problem is less important.

>
>                     Linus
>


