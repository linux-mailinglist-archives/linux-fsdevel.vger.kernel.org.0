Return-Path: <linux-fsdevel+bounces-40544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C5A24CD4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 08:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7684D163D6A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A141D54D8;
	Sun,  2 Feb 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ela7RF0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D32AD11;
	Sun,  2 Feb 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482397; cv=none; b=gTm70PEQW+zLQrzBs2aB8BHT71QyXKozaTW85IKqHeC3k1znONtQqGlNRMDCMwUTNa+Ek6sMMYnbRkeVQ6DZG82VdV70NFXi48td93aNwIn6D7dVk2WYxc5bMhol1zEaJUsBzkzZ/Pl0CihYVEO1yzqiRjXRNSrV93srAhIARGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482397; c=relaxed/simple;
	bh=KPpRZb+XkmZNS30akoEPKssE6STRgNhMrtLh9sGnrZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0A+wxVm+LQxCpC6jeQOJ/IARrqAjjEskTEqbNASQew2ktzibf6ktLMYJN7z6BHKFgMYJ0k3d6LYCh0eWcjyydQi9RktHXofRX51DKAebay2CpXWqjU6F62fNzse01P6Cdwe5cjpvD4qCVOaw4dtd5v2GNLpMSVRiiZWLnstjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ela7RF0y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so4657104a12.2;
        Sat, 01 Feb 2025 23:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738482392; x=1739087192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkf3AnYzxtjJolWV6YY/aOb67PW9FbaNoOwrFtKSVa0=;
        b=ela7RF0yzFdSU3B0b25LHsH53kcaAbCxaaStqIgqjcVaSgS+hkBcmtnQVNhaMUGsgQ
         8qe+6xr6bruDbpzbgndT5mJ2K1Q2zVOAOO6z+2rgV+lG7ckUoqMqGgoGGimuMR+v0Mef
         90vwH19LhWbEnod00OE+MNkWl+kKavcj5xs410vTGVmLiMRGhA1xaYXjhzH3IvTg7ONS
         Y19dzIDcKm1hkLchGzu6FtkhS0ANBvQugw59YMQKh29dW28Wh0jvym41cN+QZVIXV70x
         5xKwTW3+/qSDjSuijVbSVChxoM8ttohixz1sWJD/x7vN6jLo7Q6tSn08r+cslLHdBy45
         HQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738482392; x=1739087192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkf3AnYzxtjJolWV6YY/aOb67PW9FbaNoOwrFtKSVa0=;
        b=Qa9iESBX6giZIH7iwcIW8HzzKcVPEkKzeD92omtqEvT+DACZdLuXnLyIxnZxoJbv2j
         DSp0lL8hCbIbq0epcS+SO/dLJNjF2MsNISHjRFtqW0XPu+ATzJErA7IrVOmzcJSuJjhp
         8R1WIdJ9AfETCOfoY/j+eMAjRKkhA6kTrDDPZSQyhwFP30m9e/bHd43ASsRldcR7fa/9
         IA3+Dp6g772RN/ByOM6Otmg7K5eTZnmgIBLn8XdnzL4wLE5QUKGRW1GfgRGf5RADhgso
         LA07BQuXGzjSG2XdENADk0WcuAfStlKqvN6dbadMV/TM96rGrmtR84uYHNaLu7HX/m2y
         iQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4/L9njha5Jf3psuZM1e/XtKrDVCjT7t+bb2ukJXbnvOjhdXSOND81UOk8py2MA/O9vFKAfHZ3+bAZ@vger.kernel.org, AJvYcCVTRZC9hw2URcc+ylKCEngkcqcf1aKffiTh7HXeGhMGVLw2pvfKlk7eUFconVQjdYYRebN7e4KYoEwWSMbW@vger.kernel.org, AJvYcCVbr/wVtvwxhb7kpE25ptcI1IH0TcffA1iV97B5MWNxrPq7MZGnmZlWnQNiZBRiQv5egEtjBdkx/cyanQ==@vger.kernel.org, AJvYcCWGyroGzw0PKsyGv2bJy5E2wEtSSUpvHsbDjX6U4g8mq+Fsqb3Qtb2R9K8u4WFFa9ZVXcFbsFrHG8MKrZ0=@vger.kernel.org, AJvYcCXMbAxHTX4XrcrrQLzJLxGsFDhS6EYk6whLVcEuWXyvbOI4PFadm2xxluesyhhMk0R6RBX29ojpuwI6ivrrFQ==@vger.kernel.org, AJvYcCXdW9rq9pGchahllYJT9xklgcJ3iwKkSidgrybvPLlslUU0xy7lSXJ387/YmpIDkMYq34M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpmsYKgurM12REUK1EEOtKF1f6+Hb26KNK7+TolFO3bfqkEou
	d6nX0SE+qrm9W2/fT7hsgkEdmA4uN5jf3inckgA+Rr+zYbgj4sg4paH3jjFjJj7ouvZ6Ce0T+im
	I+E2ksl+oXYlq+4+tX+wgOoKUmQs=
X-Gm-Gg: ASbGncvesWoAWUZa584b7MLzr1V/D3qNWW8E1mtBiFkr/El3FzIldee3nYtDpf/vUsl
	w89P+ykFj0To1gVbvdCdCPgTdL697xCntAqdJnw1uG+yxJ+U49XbUcvFHXzHcYCHQYT8wpJMA
X-Google-Smtp-Source: AGHT+IE25ioY+88Ad0dzyJ05zZTY4tUCHqGHqVeBxZbL7pLFQn1rxv9eQSShAxQEMVL/CmIeX9bb7tDeZctmbYTQTWc=
X-Received: by 2002:a05:6402:274e:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5dc5efec007mr41206927a12.21.1738482392164; Sat, 01 Feb 2025
 23:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com> <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local> <20250201-legehennen-klopfen-2ab140dc0422@brauner>
 <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
In-Reply-To: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 2 Feb 2025 08:46:21 +0100
X-Gm-Features: AWEUYZnttHbNcopdkTaXe70ba9wJmxOXrUavrKaCPbqgXlhsWsN9pWLAIjMYcbA
Message-ID: <CAOQ4uxjVTir-mmx05zh231BpEN1XbXpooscZyfNUYmVj32-d3w@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 1:58=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org> wrote=
:
> >
> > Ok, but those "device fds" aren't really device fds in the sense that
> > they are character fds. They are regular files afaict from:
> >
> > vfio_device_open_file(struct vfio_device *device)
> >
> > (Well, it's actually worse as anon_inode_getfile() files don't have any
> > mode at all but that's beside the point.)?
> >
> > In any case, I think you're right that such files would (accidently?)
> > qualify for content watches afaict. So at least that should probably ge=
t
> > FMODE_NONOTIFY.
>
> Hmm. Can we just make all anon_inodes do that? I don't think you can
> sanely have pre-content watches on anon-inodes, since you can't really
> have access to them to _set_ the content watch from outside anyway..
>
> In fact, maybe do it in alloc_file_pseudo()?
>

The problem is that we cannot set FMODE_NONOTIFY -
we tried that once but it regressed some workloads watching
write on pipe fd or something.

and the no-pre-content is a flag combination (to save FMODE_ flags)
which makes things a bit messy.

We could try to initialize f_mode to FMODE_NONOTIFY_PERM
for anon_inode, which opts out of both permission and pre-content
events and leaves the legacy inotify workloads unaffected.

But, then code like this will not do the right thing:

        /* We refuse fsnotify events on ptmx, since it's a shared resource =
*/
        filp->f_mode |=3D FMODE_NONOTIFY;

We will need to convert all those to use a helper.
I am traveling today so will be able to look closer tomorrow.

Jan,

What do you think?

Amir.

