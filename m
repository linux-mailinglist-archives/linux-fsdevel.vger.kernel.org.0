Return-Path: <linux-fsdevel+bounces-16200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669489A023
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8728761B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327A516F29A;
	Fri,  5 Apr 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCkoDMMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23316EC1B;
	Fri,  5 Apr 2024 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328510; cv=none; b=lONL+vFAlwsDgTIV6a/GYGQIwYAGmyQpbnvQSTNA+i3yBOl9Q1MExJQvTQmSLOxTT9z9sTloppyT7qnhELL8xZJ89YtdZXPeNdRomMvDshPc6UzY7Tdl98hYVeBt7lad8b+YeTrwPOjTmUfATDklXgOedSn6hB0Rf8FJfOg8KkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328510; c=relaxed/simple;
	bh=0VQFXtDRSz4M6IrqXt9cEwJScvhuHkihccKjUXmXepU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4DeTF/Z5Z7jS7Gh20kemH5sY6V11pPzDE3yRagwI5svxZ75IKUEs7I+KtFt5BvrBMzffqCinYrV6QoZMYtL/YyxR52sKN5MxR1FwvO1M5A3MHHC75GGKTsoex+SyKaoflfuOHjzfWKiLwHwbPC+u7CS5CYHPg9z4tu96/vDqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCkoDMMQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e89c87a72eso1553437a34.0;
        Fri, 05 Apr 2024 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712328508; x=1712933308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKzek6Yxpsl4qXpk5d2XtdtZIpLAzQsbPQmoIKymGH4=;
        b=mCkoDMMQpL1BCvdQdNCr5ASS68lT2aOA7eVMeH8qnQedHqqMKeeGkW8n3yzH/SfT9W
         CflUAL5k3U/P6iccdFRLxERXqj6E6MWY7hrgj9syiQdryCz7hmo69/pvXQ6MsEuhMoQc
         6aBmQ1P0YMIwdZPIL6sqyzX3yIvbc0ZKpAmnE0V/RZ1QTPULaDTsdxSir0brBi6HZyI1
         jjFbKNXhvrc0tPQlLYsXVvm/oDMvykPXoU5wQsLGBV9QkUcPYCGwpJBUWU7AnsD8/cAZ
         A2SV5x1QiIn4cE7gBKKTE8KGHt/BPrB3SUwczJuO+cYOmAL+jwS9ozyLGCavoNsq7Y0j
         +ENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328508; x=1712933308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKzek6Yxpsl4qXpk5d2XtdtZIpLAzQsbPQmoIKymGH4=;
        b=pRPlXgZ7MLPCW7iMWS9kxfaEwwNDYpNaWUwYFjo3tar7Ey/iICbgNR+g9/LAwjEWq8
         t35cpSylZ9DvIvcO+pWT9oEgBqkTxue9XgZao+S8nuZoGykV16X5XlVNOVmdOuOOk7gN
         7Z32kDwKr4fnV+RbN7sXVMPTqjIf9on1V/DY1Hvb0X9pUYsRPsehVOHXuYVU11MBtLev
         lZKMMkDoQ7+R9NF4ZJtlIFwvlG0yOrkCGSdYqskB5SUE35osJkQIXBOxdSoh51sdq6nV
         msjjvtBZ6/sqOuWJm2SIKZnXsf8y8xMlT7pQmcYBCNEAAekMV5wmEFFa5+JSjEvC+8F2
         XfFg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z+omXjlALEaq0eD1C91pmVVVyVAkA2dZ7IX1z/mRFUWZB1k0dzlw0rJSLXb4b6fCB/vxpN4Fh8sk34hZpuwyY1GzJ4L+TXcPwBoHxYUAsjiEVtgYbe4zM4NfaP+8tr2nDuIvTABJtLgv9A==
X-Gm-Message-State: AOJu0YwoZ8mTPFxaMdm3ekvJKaUTtlYWBCV3Od7xmr7Qt3Da5xlUwqcr
	Cvdwpr0+0/Mg27KVd36f9PvUygUqVZWdJvJVkJBVYljuQmR8RowjMhCQcWOc3399z35Ha37wdH1
	rg8KXrLjhT5FPWY/fiMnyUjr+q48=
X-Google-Smtp-Source: AGHT+IFvfuAhJ3eeyIyRMcKMWX9PCOkhtxWoVIBPUmUnlj7V2N/+mzrWdjY83DsnGQIh08lIzGE0D/n+GUbaWvbe1E8=
X-Received: by 2002:a9d:7413:0:b0:6e7:548e:271a with SMTP id
 n19-20020a9d7413000000b006e7548e271amr1648002otk.17.1712328507996; Fri, 05
 Apr 2024 07:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV> <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com> <20240405-speerwerfen-quetschen-d3de254cf830@brauner>
In-Reply-To: <20240405-speerwerfen-quetschen-d3de254cf830@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Apr 2024 17:48:15 +0300
Message-ID: <CAOQ4uxjydrmgk-z6wu5PtP_4GjWH0n75Cvz6oEUcfSuneA0Hag@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:47=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> > On Thu, Apr 4, 2024 at 11:21=E2=80=AFAM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Thu, Apr 04, 2024 at 09:11:22AM +0100, Al Viro wrote:
> > > > On Thu, Apr 04, 2024 at 09:54:35AM +0300, Amir Goldstein wrote:
> > > > >
> > > > > In the lockdep dependency chain, overlayfs inode lock is taken
> > > > > before kernfs internal of->mutex, where kernfs (sysfs) is the low=
er
> > > > > layer of overlayfs, which is sane.
> > > > >
> > > > > With /sys/power/resume (and probably other files), sysfs also
> > > > > behaves as a stacking filesystem, calling vfs helpers, such as
> > > > > lookup_bdev() -> kern_path(), which is a behavior of a stacked
> > > > > filesystem, without all the precautions that comes with behaving
> > > > > as a stacked filesystem.
> > > >
> > > > No.  This is far worse than anything stacked filesystems do - it's
> > > > an arbitrary pathname resolution while holding a lock.
> > > > It's not local.  Just about anything (including automounts, etc.)
> > > > can be happening there and it pushes the lock in question outside
> > > > of *ALL* pathwalk-related locks.  Pathname doesn't have to
> > > > resolve to anything on overlayfs - it can just go through
> > > > a symlink on it, or walk into it and traverse a bunch of ..
> > > > afterwards, etc.
> > > >
> > > > Don't confuse that with stacking - it's not even close.
> > > > You can't use that anywhere near overlayfs layers.
> > > >
> > > > Maybe isolate it into a separate filesystem, to be automounted
> > > > on /sys/power.  And make anyone playing with overlayfs with
> > > > sysfs as a layer mount the damn thing on top of power/ in your
> > > > overlayfs.  But using that thing as a part of layer is
> > > > a non-starter.
> >
> > I don't follow what you are saying.
> > Which code is in non-starter violation?
> > kernfs for calling lookup_bdev() with internal of->mutex held?
> > Overlayfs for allowing sysfs as a lower layer and calling
> > vfs_llseek(lower_sysfs_file,...) during copy up while ovl inode is held
> > for legit reasons (e.g. from ovl_rename())?
> >
> > >
> > > Incidentally, why do you need to lock overlayfs inode to call
> > > vfs_llseek() on the underlying file?  It might (or might not)
> > > need to lock the underlying file (for things like ->i_size,
> > > etc.), but that will be done by ->llseek() instance and it
> > > would deal with the inode in the layer, not overlayfs one.
> >
> > We do not (anymore) lock ovl inode in ovl_llseek(), see:
> > b1f9d3858f72 ovl: use ovl_inode_lock in ovl_llseek()
> > but ovl inode is held in operations (e.g. ovl_rename)
> > which trigger copy up and call vfs_llseek() on the lower file.
> >
> > >
> > > Similar question applies to ovl_write_iter() - why do you
> > > need to hold the overlayfs inode locked during the call of
> > > backing_file_write_iter()?
> > >
> >
> > Not sure. This question I need to defer to Miklos.
> > I see in several places the pattern:
> >         inode_lock(inode);
> >         /* Update mode */
> >         ovl_copyattr(inode);
> >         ret =3D file_remove_privs(file);
> > ...
> >         /* Update size */
> >         ovl_file_modified(file);
> > ...
> >         inode_unlock(inode);
> >
> > so it could be related to atomic remove privs and update mtime,
> > but possibly we could convert all of those inode_lock() to
> > ovl_inode_lock() (i.e. internal lock below vfs inode lock).
> >
> > [...]
> > > Consider the scenario when unlink() is called on that sucker
> > > during the write() that triggers that pathwalk.  We have
> > >
> > > unlink: blocked on overlayfs inode of file, while holding the parent =
directory.
> > > write: holding the overlayfs inode of file and trying to resolve a pa=
thname
> > > that contains .../power/suspend_stats/../../...; blocked on attempt t=
o lock
> > > parent so we could do a lookup in it.
> >
> > This specifically cannot happen because sysfs is not allowed as an
> > upper layer only as a lower layer, so overlayfs itself will not be writ=
ing to
> > /sys/power/resume.
>
> I don't understand that part. If overlayfs uses /sys/power/ as a lower
> layer it can open and write to /sys/power/resume, no?
>
> Honestly, why don't you just block /sys/power from appearing in any
> layer in overlayfs? This seems like such a niche use-case that it's so
> unlikely that this will be used that I would just try and kill it.

I do not want to special case /sys/power in overlayfs.

>
> If you do it like Al suggested and switch it to an automount you get

Not important enough IMO to make this change.

> that for free. But I guess you can also just block it without that.
>
> (Frankly, I find it weird that sysfs is allowed as a layer in any case. I
> completely forgot about this. Imho, both procfs and sysfs should not be
> usable as a lower layer - procfs is, I know - and then only select parts
> should be like /sys/fs/cgroup or sm where I can see the container people
> somehow using this to mess with the cgroup tree or something.)
>

I do not know if using sysfs as a lower layer is an important use case,
but I have a feeling that people already may do it, so I cannot regress it
without a good reason.

Al's suggestion to annotate writable kernfs files as a different class from
readonly kernfs files seems fine by me to silence lockdep false positive.

I will try to feed this solution to syzbot.

Thanks,
Amir.

