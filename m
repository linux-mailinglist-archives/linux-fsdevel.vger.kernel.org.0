Return-Path: <linux-fsdevel+bounces-21845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A590B8DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4491C2338C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD29197A62;
	Mon, 17 Jun 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjAircoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0493195985;
	Mon, 17 Jun 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647164; cv=none; b=mOT4c/Cceka9lD9iuVAYkRnS8gClN4uFA2I0FjM8jTFdczQicdBk5vwGnTYGsbZu9BFIh0dzLa25c0CJlR/6p2FfeXq6DvkvDGVlxOIoiqvmjcPKLSru50LCbOh29/Y30ER58TecqaXzln/7nG7XbzlnFsuawnPxvpotJSbsQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647164; c=relaxed/simple;
	bh=lUHEdtcqE3uD/1h85n902b3EsrRrxk5Zx5OBaQ+EZPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZUo5g4GzdCHGQt/8U1CilXTYFKThzCZhTlVbWzQyr2mqZemI4Q4HsFyA6Bd4HsWzy9TfTmLvcLZjv9Oq/QQ4zkVzBLagngW0BdBRoFyajs/6bDhVRQwoHJ7GJfZR19eY1Lr4ITJAykAe8emcfQYYlnvfXTMTPiWL3g13iaXFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjAircoT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so6025084a12.2;
        Mon, 17 Jun 2024 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718647161; x=1719251961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbncuH76lbQhDfoV73q+vcfEohVXoRM4jKTBgQWFIW4=;
        b=OjAircoT0ZokNBZqIN1PBOnAD+5v1rG1DOalbyVHqAL4QvoJ9f/CChpYI901TngLKb
         eri5cVGjwBxxSiHcOdfdADjRgUCnqD/4FnpKcTCNBYuktGeKSIAfxjQNqiKC0JSv1Kqz
         j0HJrVsVPl64TgC385yZKCDl3Pg4bRk11b1vtxd7M0EBCMdNwXhxiZaXGCgWboeoajTf
         Rpml3xvtPu2oigpEm5v038vN1N3lYbGRmO00/DSYuu6fyBIgLGTMBwAY5Cn6EWkKylCq
         NvY23ZmMxDwO+d00q0liMwkHKHhnQ1ctn6h/E3dhQ7S+3cTfjq8xE/xCnydLv2XHGf06
         QirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647161; x=1719251961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbncuH76lbQhDfoV73q+vcfEohVXoRM4jKTBgQWFIW4=;
        b=mTKk9r3RIlpUrb3JISXQ9Iwl3Odz2VEPnUV2v4jj2tVILe60Ky7Jwl+O7d18RpDIFr
         VYox9k8e6zaZydVYjWBcQEiRCqo8ZshM24Qirb7Jx2zg/62gotYmu/Dm+KqxS1wGkl2B
         cW/4KmV+9jEkn5qD+8i/sJHs1NorjFMIecY4LSG4f/4R45sgql8WfSckvjzWYoXuBp7y
         rqwUkOXvdfkkYqBJJdU01RiWBMu0XgDQPgY/IUtEJzfwvW5XqafUPx3wUnGB702+TYSu
         aBQX9tVm4DnqANFPmPzrh9fhse7fcqZTiti6mdIqbBeTVKX7nBc2rgSGvpYJgB60PAp5
         FavQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5egSEG9QjDcDNptTKVU6fLS5ztVfcWaODy1oY5KX3d3OivRq6CnipYjlIPZiAtE7oFR5Q/2H4uSM9NGfm/qMyNoV4nOqbLq0hlnEMkiuSXJzhfJrSntuB6h+iJmKiE3iPGjv+NYv3lrJ4Og==
X-Gm-Message-State: AOJu0YzRLqLl5x/tQuScCIi2Vj6McQDjiXiy/ESpyKDXQ2ed/xmqXrHt
	JW1Bo3yNebSQ5/+jOmFPZnyl9RIi7Xh6sQ3xbvRXj9jBvPLUbfRRORwL3IM7TX5x+92HApxS2Pi
	QwAVk+Jh2eBqzPv+DBaxvZKQpne8=
X-Google-Smtp-Source: AGHT+IFZB44u72zR6xM1vDhBJ5c8bL87xGKYaKNA3BHHvG3K+sXNDBZJt70QxqPCFR6hte8YCDyAI/6DuK1/RUq982A=
X-Received: by 2002:a50:c346:0:b0:578:f472:d9d5 with SMTP id
 4fb4d7f45d1cf-57cbd906889mr6210379a12.37.1718647160664; Mon, 17 Jun 2024
 10:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
 <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx> <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
In-Reply-To: <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 17 Jun 2024 19:59:07 +0200
Message-ID: <CAGudoHGhJF3OPw9S=gNb7wLeci=r7jFzDWmh2G7rcvL2Dev4fQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to put_unused_fd()
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:55=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Sat, 2024-06-15 at 07:07 +0200, Mateusz Guzik wrote:
> > On Sat, Jun 15, 2024 at 06:41:45AM +0200, Mateusz Guzik wrote:
> > > On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
> > > > alloc_fd() has a sanity check inside to make sure the FILE object m=
apping to the
> > >
> > > Total nitpick: FILE is the libc thing, I would refer to it as 'struct
> > > file'. See below for the actual point.
> > >
> > > > Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read imp=
roved by
> > > > 32%, write improved by 15% on Intel ICX 160 cores configuration wit=
h v6.8-rc6.
> > > >
> > > > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > > > ---
> > > >  fs/file.c | 14 ++++++--------
> > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/fs/file.c b/fs/file.c
> > > > index a0e94a178c0b..59d62909e2e3 100644
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned e=
nd, unsigned flags)
> > > >   else
> > > >           __clear_close_on_exec(fd, fdt);
> > > >   error =3D fd;
> > > > -#if 1
> > > > - /* Sanity check */
> > > > - if (rcu_access_pointer(fdt->fd[fd]) !=3D NULL) {
> > > > -         printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > > > -         rcu_assign_pointer(fdt->fd[fd], NULL);
> > > > - }
> > > > -#endif
> > > >
> > >
> > > I was going to ask when was the last time anyone seen this fire and
> > > suggest getting rid of it if enough time(tm) passed. Turns out it doe=
s
> > > show up sometimes, latest result I found is 2017 vintage:
> > > https://groups.google.com/g/syzkaller-bugs/c/jfQ7upCDf9s/m/RQjhDrZ7AQ=
AJ
> > >
> > > So you are moving this to another locked area, but one which does not
> > > execute in the benchmark?
> > >
> > > Patch 2/3 states 28% read and 14% write increase, this commit message
> > > claims it goes up to 32% and 15% respectively -- pretty big. I presum=
e
> > > this has to do with bouncing a line containing the fd.
> > >
> > > I would argue moving this check elsewhere is about as good as removin=
g
> > > it altogether, but that's for the vfs overlords to decide.
> > >
> > > All that aside, looking at disasm of alloc_fd it is pretty clear ther=
e
> > > is time to save, for example:
> > >
> > >     if (unlikely(nr >=3D fdt->max_fds)) {
> > >             if (fd >=3D end) {
> > >                     error =3D -EMFILE;
> > >                     goto out;
> > >             }
> > >             error =3D expand_files(fd, fd);
> > >             if (error < 0)
> > >                     goto out;
> > >             if (error)
> > >                     goto repeat;
> > >     }
> > >
> >
> > Now that I wrote it I noticed the fd < end check has to be performed
> > regardless of max_fds -- someone could have changed rlimit to a lower
> > value after using a higher fd. But the main point stands: the call to
> > expand_files and associated error handling don't have to be there.
>
> To really prevent someone from mucking with rlimit, we should probably
> take the task_lock to prevent do_prlimit() racing with this function.
>
> task_lock(current->group_leader);
>

It's fine to race against rlimit adjustments.

The problem here is that both in my toy refactoring above and the
posted patch the thread can use a high fd, lower the rlimit on its own
and not have it respected on calls made later.

>
> >
> > > This elides 2 branches and a func call in the common case. Completely
> > > untested, maybe has some brainfarts, feel free to take without credit
> > > and further massage the routine.
> > >
> > > Moreover my disasm shows that even looking for a bit results in
> > > a func call(!) to _find_next_zero_bit -- someone(tm) should probably
> > > massage it into another inline.
> > >
> > > After the above massaging is done and if it turns out the check has t=
o
> > > stay, you can plausibly damage-control it with prefetch -- issue it
> > > immediately after finding the fd number, before any other work.
> > >
> > > All that said, by the above I'm confident there is still *some*
> > > performance left on the table despite the lock.
> > >
> > > >  out:
> > > >   spin_unlock(&files->file_lock);
> > > > @@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
> > > >  }
> > > >  EXPORT_SYMBOL(get_unused_fd_flags);
> > > >
> > > > -static void __put_unused_fd(struct files_struct *files, unsigned i=
nt fd)
> > > > +static inline void __put_unused_fd(struct files_struct *files, uns=
igned int fd)
> > > >  {
> > > >   struct fdtable *fdt =3D files_fdtable(files);
> > > >   __clear_open_fd(fd, fdt);
> > > > @@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struc=
t *files, unsigned int fd)
> > > >  void put_unused_fd(unsigned int fd)
> > > >  {
> > > >   struct files_struct *files =3D current->files;
> > > > + struct fdtable *fdt =3D files_fdtable(files);
> > > >   spin_lock(&files->file_lock);
> > > > + if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
> > > > +         printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n",=
 fd);
> > > > +         rcu_assign_pointer(fdt->fd[fd], NULL);
> > > > + }
> > > >   __put_unused_fd(files, fd);
> > > >   spin_unlock(&files->file_lock);
> > > >  }
> >
>


--=20
Mateusz Guzik <mjguzik gmail.com>

