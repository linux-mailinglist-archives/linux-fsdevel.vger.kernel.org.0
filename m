Return-Path: <linux-fsdevel+bounces-16725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D596C8A1DED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031C31C230FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A57FBB4;
	Thu, 11 Apr 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5wT765g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E87F7F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856932; cv=none; b=IacC9/SNy8e1SqFWxbqpNskqT9v3uoY+ad+gTEOFwOfG0oWDo8ZXbSK+/SAQytdp7NCmtfpUau8VkoPwh0uZN69QAZbZ4WGHjPI1jUCzjqnt4RVc1tbveO5C6Zi9FBtNgDSQgMuuevmsDx5d2nBLhewo8klSn/pptj55yTHys+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856932; c=relaxed/simple;
	bh=J7LR5Hf7+dDBQteFZMOyJrJ4NUxjAlwCJgIikvGQaAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxPJ+wb4MqDPwDgC6yplrmtY/b70VvBlHM5g6tUyGe31VVKhuD7Pk87GBaeYi/R0O7x9rb2tvUKw0loWMB9LL8bVdW6VJzJadDXmBexxSR43ic8EJ60tAOx7oKanLOsa8EDgUZG6zKGNUxRjf5egoHySv6cM8SYs3C607HZtRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5wT765g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712856929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waiQo/S/fV/3q254XNynpxfakfB0+xsUplfr9uR6x9Q=;
	b=T5wT765gbGveAc3i5nQB1sMq1CEbUep9Xjbui6Gev3LU+BY4KHuxWaK5veA2e1cAI2Krit
	FYAiydGeA4QzKPHtH99k8+hLNkaknL1GipBoUEuqjXNtADnswcWjWL46z+hHr1uO06MCSR
	9nYsqWrT/MFBjc3sOrEpPmEbe9EQ54c=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-w-GBr-eSPRiIfRoagi-Png-1; Thu, 11 Apr 2024 13:35:28 -0400
X-MC-Unique: w-GBr-eSPRiIfRoagi-Png-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4dad39cfe6bso21082e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 10:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856927; x=1713461727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waiQo/S/fV/3q254XNynpxfakfB0+xsUplfr9uR6x9Q=;
        b=WkNqcfIQYxrCayY/zIgXdXv+gY9SGkyNJuty2RC3Q1DV9eBLUKCMslONKo9aoJzi/B
         REcBsYW5O/BbgaHomCLEEMwn47srO+pe413y1tOW0GC1x38q3B3B+EViMlfpk7uIB7V4
         JQRL9d2xKwUHG/eGayw14GNgNcU5swQAsIyapqTqcCqTQEaW9xd2+3FlmYRDU+Nqv4b2
         TfTlgX6Bw6L0spJJhdIGCdcK5H8t89ICnzVGm6Brc+irPzs1SEJaSJFOReIVY8tA6mlR
         ImZP7a2A5opRirg4JI5+oUu48w4n6xrwnZm1z+SZxEj1iwrDO7zpPDERGKlPEBn/i0q1
         Feew==
X-Forwarded-Encrypted: i=1; AJvYcCV9VId9GT6mcXEo5kHHCB1MnN+CrxmjGgAktvX+JWJwXOK/1luBVTslRxhgLoVDWoA4RnXJQwzl59rOD0dIuGZxoC+KPYPExr/UElsFvQ==
X-Gm-Message-State: AOJu0YwO2zWius4YlZ34xp/+pTxsjujzzvxJw72hdfhbDJUTXz3cHnWI
	M/QjaKU06ptKki/5Wr9OnXTjYjeyoMqWzjnzUhhatYN4s8sYoSjUS4D/4RTMpC/vL36HRzZaSts
	omC/a3paoe5nZJK2H/oK1xZUbaZCvFvlzlNVSsCTK7iLnBFCc0JcqL6/TRq+KUGlO8cCPIps+kg
	5wFHwId7IJsWVoReDePFrAfEebLB6pqIvMJ3m9eA==
X-Received: by 2002:a05:6122:308c:b0:4c9:f704:38c with SMTP id cd12-20020a056122308c00b004c9f704038cmr583015vkb.11.1712856927589;
        Thu, 11 Apr 2024 10:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHpuw4cnXxBkdHR16+5jrVeWHz5XxjiP8Qo797YNvzFb9J14GqTwjxbpXyeQMu0B0yZh66S5GfW1/lgJxc9B4=
X-Received: by 2002:a05:6122:308c:b0:4c9:f704:38c with SMTP id
 cd12-20020a056122308c00b004c9f704038cmr582991vkb.11.1712856927252; Thu, 11
 Apr 2024 10:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com> <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
In-Reply-To: <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 11 Apr 2024 13:35:16 -0400
Message-ID: <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And a slightly dubious addition to bypass these checks for tmpfiles
across the board.

I don't like putting the details of this in the path lookup code, but
it is definitely nicer here than
looking up the fd twice, once here and again in do_linkat

These changes not strictly necessary, because the existing patch
allows unprivileged
tmpfile flink as long as the creds don't change, but I do think that
my reasoning is sound
that linking a tmpfile should always be ok whether or not creds have change=
d

---
 fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index 2bcc10976ba7..5c9fabc39481 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2421,6 +2421,7 @@ static const char *path_init(struct nameidata
*nd, unsigned flags)

                if (flags & LOOKUP_DFD_MATCH_CREDS) {
                        if (f.file->f_cred !=3D current_cred() &&
+                           !(f.file->f_flags & __O_TMPFILE) &&
                            !ns_capable(f.file->f_cred->user_ns,
CAP_DAC_READ_SEARCH)) {
                                fdput(f);
                                return ERR_PTR(-ENOENT);

On Thu, Apr 11, 2024 at 1:29=E2=80=AFPM Charles Mirabile <cmirabil@redhat.c=
om> wrote:
>
> Here is an updated version of linus's patch that makes the check
> namespace relative
> ---
>  fs/namei.c            | 17 ++++++++++++-----
>  include/linux/namei.h |  1 +
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 4e0de939fea1..2bcc10976ba7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2419,6 +2419,14 @@ static const char *path_init(struct nameidata
> *nd, unsigned flags)
>          if (!f.file)
>              return ERR_PTR(-EBADF);
>
> +        if (flags & LOOKUP_DFD_MATCH_CREDS) {
> +            if (f.file->f_cred !=3D current_cred() &&
> +                !ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH=
)) {
> +                fdput(f);
> +                return ERR_PTR(-ENOENT);
> +            }
> +        }
> +
>          dentry =3D f.file->f_path.dentry;
>
>          if (*s && unlikely(!d_can_lookup(dentry))) {
> @@ -4640,14 +4648,13 @@ int do_linkat(int olddfd, struct filename
> *old, int newdfd,
>          goto out_putnames;
>      }
>      /*
> -     * To use null names we require CAP_DAC_READ_SEARCH
> +     * To use null names we require CAP_DAC_READ_SEARCH or
> +     * that the open-time creds of the dfd matches current.
>       * This ensures that not everyone will be able to create
>       * handlink using the passed filedescriptor.
>       */
> -    if (flags & AT_EMPTY_PATH && !capable(CAP_DAC_READ_SEARCH)) {
> -        error =3D -ENOENT;
> -        goto out_putnames;
> -    }
> +    if (flags & AT_EMPTY_PATH)
> +        how |=3D LOOKUP_DFD_MATCH_CREDS;
>
>      if (flags & AT_SYMLINK_FOLLOW)
>          how |=3D LOOKUP_FOLLOW;
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 74e0cc14ebf8..678ffe4acf99 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -44,6 +44,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  #define LOOKUP_BENEATH        0x080000 /* No escaping from starting poin=
t. */
>  #define LOOKUP_IN_ROOT        0x100000 /* Treat dirfd as fs root. */
>  #define LOOKUP_CACHED        0x200000 /* Only do cached lookup */
> +#define LOOKUP_DFD_MATCH_CREDS    0x400000 /* Require that dfd creds
> match current */
>  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
>  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
>
> --
> 2.44.0
>
> On Thu, Apr 11, 2024 at 12:44=E2=80=AFPM Charles Mirabile <cmirabil@redha=
t.com> wrote:
> >
> > On Thu, Apr 11, 2024 at 12:15=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, 11 Apr 2024 at 02:05, Christian Brauner <brauner@kernel.org> =
wrote:
> > > >
> > > > I had a similar discussion a while back someone requested that we r=
elax
> > > > permissions so linkat can be used in containers.
> > >
> > > Hmm.
> > >
> > > Ok, that's different - it just wants root to be able to do it, but
> > > "root" being just in the container itself.
> > >
> > > I don't think that's all that useful - I think one of the issues with
> > > linkat(AT_EMPTY_PATH) is exactly that "it's only useful for root",
> > > which means that it's effectively useless. Inside a container or out.
> > >
> > > Because very few loads run as root-only (and fewer still run with any
> > > capability bits that aren't just "root or nothing").
> > >
> > > Before I did all this, I did a Debian code search for linkat with
> > > AT_EMPTY_PATH, and it's almost non-existent. And I think it's exactly
> > > because of this "when it's only useful for root, it's hardly useful a=
t
> > > all" issue.
> > >
> > > (Of course, my Debian code search may have been broken).
> > >
> > > So I suspect your special case is actually largely useless, and what
> > > the container user actually wanted was what my patch does, but they
> > > didn't think that was possible, so they asked to just extend the
> > > "root" notion.
> > >
> > Yes, that is absolutely the case. When Christian poked holes in my
> > initial submission, I started working on a v2 but haven't had a chance
> > to send it because I wanted to make sure my arguments etc were
> > airtight because I am well aware of just how long and storied the
> > history of flink is. In the v2 that I didn't post yet, I extended the
> > ability to link *any* file from only true root to also "root" within a
> > container following the potentially suspect approach that christian
> > suggested (I see where you are coming from with the unobvious approach
> > to avoiding toctou though I obviously support this patch being
> > merged), but I added a followup patch that checks for whether the file
> > in question is an `__O_TMPFILE` file which is trivial once we are
> > jumping through the hoops of looking up the struct file. If it is a
> > tmpfile (i.e. linkcount =3D 0) I think that all the concerns raised
> > about processes that inherit a fd being able to create links to the
> > file inappropriately are moot. Here is an excerpt from the cover
> > letter I was planning to send that explains my reasoning.
> >
> >  -  the ability to create an unnamed file, adjust its contents
> > and attributes (i.e. uid, gid, mode, xattrs, etc) and then only give it=
 a name
> > once they are ready is exactly the ideal use-case for a hypothetical `f=
link`
> > system call. The ability to use `AT_EMPTY_PATH` with `linkat` essential=
ly turns
> > it into `flink`, but these restrictions hamper it from actually being u=
sed, as
> > most code is not privileged. By checking whether the file to be linked =
is a
> > temporary (i.e. unnamed) file we can allow this useful case without all=
owing
> > the more risky cases that could have security implications.
> >
> >  - Although it might appear that the security posture is affected, it i=
s not.
> > Callers who open an extant file on disk in read only mode for sharing w=
ith
> > potentially untrustworthy code can trust that this change will not affe=
ct them
> > because it only applies to temporary files. Callers who open a temporar=
y file
> > need to do so with write access if they want to actually put any data i=
n it,
> > so they will already have to reopen the file (e.g. by linking it to a p=
ath
> > and opening that path, or opening the magic symlink in proc) if they wa=
nt to
> > share it in read-only mode with untrustworthy code. As such, that new f=
ile
> > description will no longer be marked as a temporary file and thus these=
 changes
> > do not apply. The final case I can think of is the unlikely possibility=
 of
> > intentionally sharing read write access to data stored in a temporary f=
ile with
> > untrustworthy code, but where that code being able to make a link would=
 still
> > be deleterious. In such a bizarre case, the `O_EXCL` can and should be =
used to
> > fully prevent the temporary file from ever having a name, and this chan=
ge does
> > not alter its efficacy.
> >
> > > I've added Charles to the Cc.
> > >
> > > But yes, with my patch, it would now be trivial to make that
> > >
> > >         capable(CAP_DAC_READ_SEARCH)
> > >
> > > test also be
> > >
> > >         ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)
> > >
> > > instead. I suspect not very many would care any more, but it does see=
m
> > > conceptually sensible.
> > >
> > > As to your patch - I don't like your nd->root  games in that patch at
> > > all. That looks odd.
> > >
> > > Yes, it makes lookup ignore the dfd (so you avoid the TOCTOU issue),
> > > but it also makes lookup ignore "/". Which happens to be ok with an
> > > empty path, but still...
> > >
> > > So it feels to me like that patch of yours mis-uses something that is
> > > just meant for vfs_path_lookup().
> > >
> > > It may happen to work, but it smells really odd to me.
> > >
> > >              Linus
> > >


