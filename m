Return-Path: <linux-fsdevel+bounces-14277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3587A5CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FC9282B74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF9B39AF5;
	Wed, 13 Mar 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g43HuWZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91039AE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325559; cv=none; b=CtUttSOZdp8VQz+sJdK8pHooRdHybpRe8acMoWMkt3f5ZtAddnYsGhfbS8n/YgdyRictE79HZsSWiosF/9PXGmtAqjxKsI12oanDeXxbJGV7k1Qu/3Jy/7vnLbV7g6cWnltKikUYp+o3ALr8icrdJ3VoFxB59WuRhquFiWWlh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325559; c=relaxed/simple;
	bh=BBtZtOWt8cUtv3lD2J5Ae/vginJ6oSrGuF5hy3aUU9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAV17HSyd0bRDFLVlPJy3kxss2BD22h13dWx63hxmki/HDSBMaLWE2iM8uXu2JKa3PUh3rTyAcUa8ntc4Fxmm+Efv5dXVvblM2k2EBkP1300f3Ge1baGuyqSXFf6W/m3BdNIkN+jkSnLJHxIf7WNyhsqzldTESgJTMbWHumZPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g43HuWZT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5683093ffbbso7798437a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710325555; x=1710930355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=567JpjZP+kkENm5KcIuOP6nL+yKhUXSoWQJZiE4eB7A=;
        b=g43HuWZTk00aPEaFc6BhRZ5DBmDyjJ8rccRRnmwB9oM/4roHYlRoGEAQl77x7YTxgM
         36SoSvDPjXwkBQ1Z9l7dHTjBPgqfKiUDMp09HpmXRAe7jB8DB2phNtOPTStlxOlAbtrA
         CWDHv/i2Dd3fF/VBurIYQJjWD2hTOVIEKpKEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325555; x=1710930355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=567JpjZP+kkENm5KcIuOP6nL+yKhUXSoWQJZiE4eB7A=;
        b=EQCbKsToJl4DefA4hSRRX/+JdKSDKzJIdchKnHSPIFehp8PyUEM0x61/bFSZavqMfz
         ftsWlRq2hM4SvWjwIFClIEVYbYBFCDiMj764mxnSQvysGWITicw5lCMUHpqioNtboIgU
         8jtCfmrD7qfyTO5MleZp/Yzvl3jKMJNt4nclYbQiYkj++oc8J7qRm7pTBrhzUPkl4NDs
         Em0hQkOdBnHF5Yy/6rJkRVDDY1Q9mnwiy+sZ3TjW20KBZ5f/b0oqoSckXaQgbhhZAc37
         oiFaSNbOshHffvp+/QX0nDj9CwlBtd4c8Cvp4UHrFh647oYEOqeQ9ULFSyapCsIG7aK4
         bFgw==
X-Forwarded-Encrypted: i=1; AJvYcCWTRPzZ+9YtKAEn3m4HAPJm2xTrY713Gs8Q0fXW6etlZPvIzov+0VLfpxrF6pWLxIKggfxEC6K0g6LjXmYS/1aZZ4bZMOqroIfbkUnNAQ==
X-Gm-Message-State: AOJu0YzYwiuPu77sm800S8K4bz0vHOD+wojjajO5QonOg6h3eSN0euYv
	bTAbihnMj3v5yBaZThe2vLD16AJugmY4xC3gqBTPQlV8fYJnEx5QSttgNFFx8gZxe/xbHLj6dxI
	Awj9rmL73uoaLnyXNGdjPmMEU/D5kAtTDw2E=
X-Google-Smtp-Source: AGHT+IGDb4MI2mdW3BzQzNPQvdCt8gc47Be8C8GUVhaGjK2unCDITzA56A0jQVHL0B/55UDSHsd7o76KWMvqLXWUa1I=
X-Received: by 2002:a17:907:a095:b0:a46:127a:61a7 with SMTP id
 hu21-20020a170907a09500b00a46127a61a7mr7786708ejc.72.1710325555317; Wed, 13
 Mar 2024 03:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023183035.11035-3-bschubert@ddn.com> <20240123084030.873139-1-yuanyaogoog@chromium.org>
 <20240123084030.873139-2-yuanyaogoog@chromium.org> <337d7dea-d65a-4076-9bac-23d6b3613e53@fastmail.fm>
 <CAOJyEHYK7Agbyz3xM3_hXptyYVmcPWCaD5TdaszcyJDhJcGzKQ@mail.gmail.com> <46e6e9df-1240-411d-9640-51d36d7e2da3@fastmail.fm>
In-Reply-To: <46e6e9df-1240-411d-9640-51d36d7e2da3@fastmail.fm>
From: Yuan Yao <yuanyaogoog@chromium.org>
Date: Wed, 13 Mar 2024 19:25:43 +0900
Message-ID: <CAOJyEHZNnKj-qxnYMQoH3h07=7_jSRnuFJ5znPkarQXjdMZjBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: bschubert@ddn.com, brauner@kernel.org, dsingh@ddn.com, hbirthelmer@ddn.com, 
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Thank you for taking time to review this issue.

I'm writing to inquire about any recent updates or plans for atomic
open threads?
It will help a lot if the negative d_entry issue could be solved.

Best,
Yuan

On Mon, Feb 19, 2024 at 8:37=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/9/24 08:46, Yuan Yao wrote:
> > Hi Bernd,
> >
> > Thank you for taking a look at this patch! I appreciate it a lot for
> > adding this patch to the next version. However, I just found that
> > there=E2=80=99s a bug with my patch. The *BUG_ON(!d_unhashed(dentry));*=
 in
> > d_splice_alias() function will be triggered when doing the parallel
> > lookup on a non-exist file.
> >
> >> struct dentry *d_splice_alias(struct inode *inode, struct dentry *dent=
ry)
> >> {
> >>    if (IS_ERR(inode))
> >>        return ERR_CAST(inode);
> >>
> >>    BUG_ON(!d_unhashed(dentry));
> >
> > This bug can be easily reproduced by adding 3 seconds sleep in fuse
> > server=E2=80=99s atomic_open handler, and execute the following command=
s in
> > fuse filesystem:
> > cat non-exist-file &
> > cat non-exist-file &
> >
> > I think this bug can be addressed by following two approaches:
> >
> > 1. adding check for d_in_lookup(entry)
> > -----------------------------------------------------------------------
> >        if (outentry.entry_valid) {
> > +            if (d_in_lookup(entry)) {
> >                 inode =3D NULL;
> >                 d_splice_alias(inode, entry);
> >                fuse_change_entry_timeout(entry, &outentry);
> > +          }
> >             goto free_and_no_open;
> >         }
> >
> > 2. adding d_drop(entry)
> > -----------------------------------------------------------------------
> >         if (outentry.entry_valid) {
> >              inode =3D NULL;
> > +           d_drop(entry)
> >              d_splice_alias(inode, entry);
> >              fuse_change_entry_timeout(entry, &outentry);
> >             goto free_and_no_open;
> >         }
> >
> > But I'm not so sure which one is preferable, or maybe the handling
> > should be elsewhere?
> >
>
> Sorry for my terribly late reply, will look into it in the evening.
>
>
> Thanks,
> Bernd

