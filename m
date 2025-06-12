Return-Path: <linux-fsdevel+bounces-51457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D8AD70DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DEF3A7BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0923A58B;
	Thu, 12 Jun 2025 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMz5pTmq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC12367A6;
	Thu, 12 Jun 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732891; cv=none; b=Yzq+7nxyuZArIayJhqQsGYHv/IwngJYCXMTO+Ctz+JW5NCs6eliQc32sQm/JY+NRSf0q4pLaHzyM/6avqbVFunqgIgCmcjOKyoVzORB04iZysAj/yVU+8TnfJ3kpGA3Jfr/hICPAfgB2vBNdbv4nHFXo4c+V0hE3jU/bCIm/OC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732891; c=relaxed/simple;
	bh=Zq0lrCCiXiUhojkfiHzzmeHA3kZBZoUepM0b/4EzCj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+OZcfRhXzbEQ2SukYpC+oJ0+eJq1HRc60VxwBMPYIpGgH5PcZ4W9gajibRgDEu1Lrk1eTo1Bns61/BktDRLMXuVLzqyPjZ22hyiAMoD0UsusqZkYJzebOnIhJtu4Q5N9oglU66HkL0p9iQhUOLmjUL7y1OX39DXjA3/FzgrOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMz5pTmq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so964933a91.1;
        Thu, 12 Jun 2025 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749732889; x=1750337689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHnABvKVsDBY6SyMrUe2SPE4MCvlPn2ZYGsVW3qTK2g=;
        b=HMz5pTmqHC4zRUSEq9MIvRkLUlHM06/Czc7rt5p+WwEfTm9OLn6SZTimpTUJ7mrN6y
         QmsY0Mpkh8165OIel87uk3l/87/2CI3m9KbCzTNFinKgHhdAvh0MQPy815Oask0A60EX
         RSzVDJpBuo+0JI/BWw0BHWNj3lVKCYKLOyvFWxJAlaYIXktO4lZEO8LbJgcahC995DC2
         DhNJk4t/qWeaJL//A2+tAQaMgSQCYDnZ3/C9caHu/P+NqMWlhKe0WSRT0SNKUH9REMN+
         ElnmyHVgPwf8kt2QZx1Zv7QWUcJEVPWMHoYSmImeOK6a1v1du8UctWRtJObbu3TU9LiX
         r8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749732889; x=1750337689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHnABvKVsDBY6SyMrUe2SPE4MCvlPn2ZYGsVW3qTK2g=;
        b=pVml/EhIfOEJaUccEKae1+qFoE9BxdbFf9fPN7CIBk1/tt4jsEBdeb3zMb8ghLc1/2
         hqTjmci3/ObgBw6PKrF5IDLn+XNBnq5CD3HOvxd8DLISslmeDojAJSRw8lRnutqF2kv9
         cxvJYiGWDOBpOnQbU7SpV7DDaQ7HQvx22YA9sOw+n8h8qyqxJ52soyeECp5zTIsnxUlk
         XzARZHHxS/kGDDx3vC6nknKPPAKT7GhB9rmfJ8ROA61AtyQjtXV+GqjsFQI2bkz94Ycj
         L9/vkNbiUvqN4Jc9SELzNgq5gN4AV9j/k6dAzr/dEkhUIuuR091VaPFlWqk8jKX/J9Vb
         bPaA==
X-Forwarded-Encrypted: i=1; AJvYcCUUP+sleLXKJ1SZ/e8NJzfbEVLAFqKZXQLxvaR3ObFhy78bnBkiuA5HXpiPHnRsXDVM+xRQVEM9cA==@vger.kernel.org, AJvYcCXikei6fEdrdWtQp3sslQI7QigfxsjFsQYJIHQS735M6rnlkIX5xywYewNp7gJjy+InOZJVTBPdTNsEYcYk@vger.kernel.org, AJvYcCXqNLSgbHdbx2LgEJuwV/ONMLGMRohoyK6kTPfjG/8J6p5+3yzpQXU50W2uyR97BvONjK8PeGnS+BzpH/PM@vger.kernel.org
X-Gm-Message-State: AOJu0YwjyPeRAbtb0i3mSp2acDynntxbAJ/86F2k8Ikk0joUPiyWgpOB
	tUMDJ1pbVmVkWdY1zVLLMoN2moEnQdLvdFwGpt2gwpca4/UUeTB6twodFhnnJpap+aXYBqwmtN9
	q8NfYn8gTIANXV9AdXuNY1oHY+Jg9GVs=
X-Gm-Gg: ASbGncuMSo2TKMHg51NafDfqwouRmKjUgViIbExwCScNjovJqUFf71ExT5svs5eCBCQ
	2ri0QzMfdVoRHEU8Nc+bLDT6gjohCLZmE1GAPsYRLu2rxqspVnoEN5LLAhweu7ezU6x8RZM3io/
	mgXak7FcTKv2KT1qdeJw5p+LspncVXoYsFoYqCePPy7CU=
X-Google-Smtp-Source: AGHT+IHts7E3RAj7TCr+hRp+cA00Q8p93pOU3WQf5H9ve3/JcAHCTYeZyEvlYLxEZkNZnRd691nLH1Sv4u6uJgzE/34=
X-Received: by 2002:a17:90b:1f8f:b0:311:b0ec:135f with SMTP id
 98e67ed59e1d1-313bfc25216mr4132351a91.30.1749732889088; Thu, 12 Jun 2025
 05:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
 <87plfhsa2r.fsf@gmail.com> <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
 <20250611-gepunktet-umkurven-5482b6f39958@brauner> <CAHC9VhQYi2k3eamrn+kPkooZQpQ4cdsjs=nvntRVbz4=wz1rzA@mail.gmail.com>
 <20250612-trabant-erbost-3c1983e42085@brauner>
In-Reply-To: <20250612-trabant-erbost-3c1983e42085@brauner>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Jun 2025 08:54:38 -0400
X-Gm-Features: AX0GCFu-kC9603i_nVxgyo-iCQtX8rJy3LNrYxj-3CM_H6w2vd0JC3b85iWJuWg
Message-ID: <CAEjxPJ42xAueN2vvviH4iJEqi8AaTmhroHFHG6K+v-Yxxmvuiw@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Collin Funk <collin.funk1@gmail.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, eggert@cs.ucla.edu, 
	bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jun 11, 2025 at 11:45:03AM -0400, Paul Moore wrote:
> > On Wed, Jun 11, 2025 at 6:05=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Tue, Jun 10, 2025 at 07:50:10PM -0400, Paul Moore wrote:
> > > > On Fri, Jun 6, 2025 at 1:39=E2=80=AFAM Collin Funk <collin.funk1@gm=
ail.com> wrote:
> > > > > Paul Moore <paul@paul-moore.com> writes:
> > > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > > >> >
> > > > > >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to a=
lways
> > > > > >> > include security.* xattrs") failed to reset err after the ca=
ll to
> > > > > >> > security_inode_listsecurity(), which returns the length of t=
he
> > > > > >> > returned xattr name. This results in simple_xattr_list() inc=
orrectly
> > > > > >> > returning this length even if a POSIX acl is also set on the=
 inode.
> > > > > >> >
> > > > > >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > > > > >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail=
.com/
> > > > > >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > > > > >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D236956=
1
> > > > > >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to a=
lways include security.* xattrs")
> > > > > >> >
> > > > > >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.c=
om>
> > > > > >> > ---
> > > > > >> >  fs/xattr.c | 1 +
> > > > > >> >  1 file changed, 1 insertion(+)
> > > > > >>
> > > > > >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > > > >
> > > > > > Resending this as it appears that Stephen's original posting ha=
d a
> > > > > > typo in the VFS mailing list.  The original post can be found i=
n the
> > > > > > SELinux archives:
> > > > > >
> > > > > > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.s=
malley.work@gmail.com/
> > > > >
> > > > > Hi, responding to this message since it has the correct lists.
> > > > >
> > > > > I just booted into a kernel with this patch applied and confirm t=
hat it
> > > > > fixes the Gnulib tests that were failing.
> > > > >
> > > > > Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> > > > > Tested-by: Collin Funk <collin.funk1@gmail.com>
> > > > >
> > > > > Thanks for the fix.
> > > >
> > > > Al, Christian, are either of you going to pick up this fix to send =
to
> > > > Linus?  If not, any objection if I send this up?
> > >
> > > It's been in vfs.fixes for some time already and it'll go out with th=
e
> > > first round of post -rc1 fixes this week.
> >
> > Great, thanks.  I didn't see any replies on-list indicating that the
> > patch had been picked up, so I just wanted to make sure someone was
>
> Hm, odd. I did send a b4 ty I'm pretty sure.

I didn't receive any reply fwiw. But no worries - thanks for applying it!

