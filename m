Return-Path: <linux-fsdevel+bounces-32107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE49A0AA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BA61C2942C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD76206E96;
	Wed, 16 Oct 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEEtNfcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781D522A
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082750; cv=none; b=i0FRJGm7zHTuakOfecVyor7o/ZJKY6dQsaFWZH8z7L6ue45aIfZJRZmRvsEmMCHiqTqlV/qRv+Z2zoHHrsi9oXD49SzrUYAtj/X0/YifVRt+SPD3o6tlGfpVQDG1E/5BMxMXsXa4aLVAvZeYLQR+Rr9UJIKIWFLYZ3xC0f8SPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082750; c=relaxed/simple;
	bh=Ubwh6I9MbccjYuLzyJk31EG0U11GfI6WTSGxbd2kDTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVCh8o0CgZ1PGRWXCXcFTOAKqKS1nr2bF18pJGE+voSj+7fJq43SarvTpJIlMAe/a8jSQBlhvF/JtVrjYqfSg7WlrUrvhpLZcX1kOoQmFBC0Rtqa45yQO1Z4rXIVmnlO2+JPPdZCVQDhmc/51OHAEuWrvl4r0/gqkzlz2F+ab/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEEtNfcb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b10f2c24f0so720794285a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729082748; x=1729687548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAHuqbc9KTYwgU62dPE4CxsJTqsq6Mq24HC1D34g5jE=;
        b=iEEtNfcbZg7xzhsPQWgRvHEUSmI/NBxBE+jKVPOF4LVe+Ns6gfAv3k6vO7wcrCZvgA
         APeayhUnSdkECkLn4D1iMr4Rv2zznO7cOHskUkoEa320tkeLTf3GOty09338RB4ja2Rx
         WFMAH/W09Rpckll5IJsvpQYvgpqttDaaT5fe9P0NbqiSiuhCEKaLMPT0OhjhLTL85nBD
         5zkdTGRGMACK+YNdk05HuIfX/BwvFuA8WXeNNe9xEMxhFVAgSOMi85zSqDWB6BLwWTT2
         gPQvyDpdili9cTs9LalxzxP8YZA+AmvWWr1Ts6xRRAI06yDi35K24lw9bpCkFNCWSvv9
         KI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082748; x=1729687548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAHuqbc9KTYwgU62dPE4CxsJTqsq6Mq24HC1D34g5jE=;
        b=FGG2teaMVzgUPYih6f6Dt00GQtNMIEjMNqio6he9jwZFrS/RCgLEhlcLPqM3M/zqJ7
         niuT7AQvMkMKooibGzZvAS5Y5oBoUyQQg4y/lpMqJ5bMVu1J5jTeZ9ch/wGTX5Mj2oKX
         Tvr5YM87+if1n98+EOkGlSARNa2g1Rc4i2jUE4/KFwwAcz3vltaVJisQNRi/Bm/c2WEm
         Xj5iAuFgMbUThOpXoYY8MLlGTl7KvC0yRokYnthG2xx32k9w7fFqojBaLIVrFsJ0y3jk
         mCc5SpnNqBZUcJboHfl9bkya83q8uzrzwQ6iRTq3E1GhzNr72swPiH8M8kbYOKbUKLzX
         JoPw==
X-Forwarded-Encrypted: i=1; AJvYcCXZIQMV7rqJIPy1RkG4w9Bbol1NaDAB6+/DPMx+aKG5yVuGrlb9bED/2RPK+pBlr+q7IiRFCH0jtITaF+Dn@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqUdk809b0K9PX2EG0U6rQsXpfLLGkv9esLCgs4AO3wSgP4Ew
	rv8ynizye8XZKhrcnsaqjvNIGh6Q2gz2zTVpTJCJTb4NnLoASoVxky/FZr1mqqa/c23sy4DedZ8
	/cV5hkuDBQnpFQIvw9dlgyerhFeRJw/yvjj8=
X-Google-Smtp-Source: AGHT+IG/woWDkG4D8U4SWbSQ5RKoLL9sUjtwu/x/NhdQkZ6lA6QQRMR+VgeBZUDXs+oo1biCCCarmenK+dvHSG8DRqY=
X-Received: by 2002:a05:620a:3712:b0:79f:67b:4fdc with SMTP id
 af79cd13be357-7b120fa7795mr2493379285a.2.1729082748015; Wed, 16 Oct 2024
 05:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
 <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
 <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com> <20241015-geehrt-kaution-c9b3f1381b6f@brauner>
In-Reply-To: <20241015-geehrt-kaution-c9b3f1381b6f@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Oct 2024 14:45:36 +0200
Message-ID: <CAOQ4uxj6ja4PN3=S9WxmZG0pLQOjBS-hNdwmGBzFjJ4GX64WCA@mail.gmail.com>
Subject: Re: fanotify sb/mount watch inside userns (Was: [PATCH RFC] :
 fhandle: relax open_by_handle_at() permission checks)
To: Lennart Poettering <lennart@poettering.net>, Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Containers <containers@lists.linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:01=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Oct 13, 2024 at 06:34:18PM +0200, Amir Goldstein wrote:
> > On Fri, May 24, 2024 at 2:35=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Fri, May 24, 2024 at 1:19=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > > > A current limitation of open_by_handle_at() is that it's currently =
not possible
> > > > to use it from within containers at all because we require CAP_DAC_=
READ_SEARCH
> > > > in the initial namespace. That's unfortunate because there are scen=
arios where
> > > > using open_by_handle_at() from within containers.
> > > >
> > > > Two examples:
> > > >
> > > > (1) cgroupfs allows to encode cgroups to file handles and reopen th=
em with
> > > >     open_by_handle_at().
> > > > (2) Fanotify allows placing filesystem watches they currently aren'=
t usable in
> > > >     containers because the returned file handles cannot be used.
> > > >
> >
> > Christian,
> >
> > Follow up question:
> > Now that open_by_handle_at(2) is supported from non-root userns,
> > What about this old patch to allow sb/mount watches from non-root usern=
s?
> > https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73il=
@gmail.com/
> >
> > Is it useful for any of your use cases?
> > Should I push it forward?
>
> Dammit, I answered that message already yesterday but somehow it didn't
> get sent or lost in some other way.
>
> I personally don't have a use-case for it but the systemd folks might
> and it would be best to just rope them in.

Lennart,

I must have asked this question before, but enough time has passed so
I am going to ask it again.

Now that Christian has added support for open_by_handle_at(2) by non-root
userns admin, it is a very low hanging fruit to support fanotify sb/mount
watches inside userns with this simple patch [1], that was last posted in 2=
011.

My question is whether this is useful, because there are still a few
limitations.
I will start with what is possible with this patch:
1. Watch an entire tmpfs filesystem that was mounted inside userns
2. Watch an entire overlayfs filesystem that was mounted [*] inside userns
3. Watch an entire mount [**] of any [***] filesystem that was
idmapped mounted into userns

Now the the fine prints:
[*] Overlayfs sb/mount CAN be watched, but decoding file handle in
events to path
     only works if overlayfs is mounted with mount option
nfs_export=3Don, which conflicts
     with mount option metacopy=3Don, which is often used in containers
(e.g. podman)
[**] Watching a mount is only possible with the legacy set of fanotify even=
ts
     (i.e. open,close,access,modify) so this is less useful for
directory tree change tracking
[***] Watching an idmapped mount has the same limitations as watching
an sb/mount
     in the root userns, namely, filesystem needs to have a non zero
fsid (so not FUSE)
     and filesystem needs to have a uniform fsid (so not btrfs
subvolume), although
     with some stretch, I could make watching an idmapped mount of
btrfs subvol work.

No support for watching btrfs subvol and overlayfs with metacopy=3Don,
reduces the attractiveness for containers, but perhaps there are still use =
cases
where watching an idmapped mount or userns private tmpfs are useful?

To try out this patch inside your favorite container/userns, you can build
fsnotifywait with a patch to support watching inside userns [2].
It's actually only the one lines O_DIRECTORY patch that is needed for the
basic tmpfs userns mount case.

Jan,

If we do not get any buy-in from potential consumers now, do you think that
we should go through with the patch and advertise the new supported use cas=
es,
so that users may come later on?

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_userns/
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/

