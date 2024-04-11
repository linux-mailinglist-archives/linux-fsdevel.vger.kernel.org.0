Return-Path: <linux-fsdevel+bounces-16724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE48A1DDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF81F267EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01734757FC;
	Thu, 11 Apr 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymek0v+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144976034
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856635; cv=none; b=IR6YUWNNAY1Sotohf1fJgMGJu1nloOlKSM94PAFExdHgkI1e1aLPi2l1HGbudRDdcSzGHUDrXUrNfP2dzi3CrnLLeNn5gVval87mxPpEA4A/jHzC4sCUYOHOA5XqnpRfYep4hOC41GwcfZoguCcjuAGu2JTs1DlQSCa2jznSdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856635; c=relaxed/simple;
	bh=coXlODZfnq7h5xpUpn/o3CBsPtjfYjFFjiRQ4X0YcmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB7D8PuC1XKwV7r2qTx3QVJGlY/BaZi6pTYxAIL7zW9O4DZvS/f59qscOD3FNbvYcMKzmbpRpvaj2sUjqHRViVID5Rzsf1YGlQoCLxqyj3RHdGwBnDRBHIcKCl/aaKPv2XT+Nhsqy2KqrLfBAJxtmPgAU2bCPh8YBCf6++cYXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ymek0v+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712856632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JA70ylDgRN0gmRtnn7ierQ4wSnxSZyu6IwhBgJQKKoo=;
	b=Ymek0v+3ytoztHAEFzvrTGfuvrEq49geud+vj7Zx4ipmuh5MEXCK0hJRXu+5k1NRL+4Eyq
	mATTRuUw7qutxMNGNEmLdgxrPrUbxtaSb6BPwLyOFu9ZZfNFDMrlkPghcIeta65c/E9vq3
	gZni5MjprcJoDitHVQ/Hx4Te19rJW0c=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-TbBOPWC5PsKNja0D2SSwLg-1; Thu, 11 Apr 2024 13:30:21 -0400
X-MC-Unique: TbBOPWC5PsKNja0D2SSwLg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4db22df35f7so20378e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 10:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856611; x=1713461411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA70ylDgRN0gmRtnn7ierQ4wSnxSZyu6IwhBgJQKKoo=;
        b=I6tn/JUDE1dYAMvP3A+5enMYjf3AlJYxNPQnJmWIcRnIHP/+tIILKlmHCJf//0jvlK
         6LSZRINOHkFUaODOxzvtFx757u86QrX3oBN5jdEjikvZBs5RFCCQw/yU8iV11IlBQjqi
         npvEDuJ4JXcxh+xAWQDowg5YOwQdy1sJD2cisEmy13QpbXAf9FE4mlkkyBYUUKy9Js47
         bduDkNZvdAGKVh8nzG1SrldQfBos6Dk+KHUyUGWVBtL+9DhDVL4ElkAOd83fo3kOqG8D
         oeQp8E0YwT/MRiTZ2nF/sQL/czbYrFP5uu+RP2HMDH7UaVbH3Xwzmu8cO6EP1jX8r9y6
         rbYw==
X-Forwarded-Encrypted: i=1; AJvYcCUIvrVoSJ7gAxwWxbe0Fdy++RlxKWRkTv7WXrNmcdRyfMIKdQxXm9d09wOM2xUJ1ZHxWTRhrqoYgpJc7/6hfQ3z3d8bYRsBdYVkdYsnEg==
X-Gm-Message-State: AOJu0YyhOAfHte0LoGh8HyPVNctS8cQUI+7ewLsLkFeQG9FGedvZn4P6
	sjGZ4TQJMS9FviGxa0nxYKBfogrFHPd/0K5hmRC0iJuRDCKCvcEDsuwGrdYcYYttViFmywIud8n
	kvfmD/KGeEQOKdiTU5YMHYsSWJ/N0o/f6dvdZu77t8PgISn59B19swykuzuln1DXv8Y96D5w3KR
	wV/zYIQ4O6E8asfDJmoYWP9qZYWFVVmp6SdVZm3A==
X-Received: by 2002:a05:6122:250e:b0:4d4:11a6:a4ff with SMTP id cl14-20020a056122250e00b004d411a6a4ffmr506653vkb.3.1712856610464;
        Thu, 11 Apr 2024 10:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGioIN4sX6H5w/uce8bUQd7RADoNIWXoYNWiGNhTkE+MvuXBmR+hfpEeNC1U/pe/bfWGLV+LDpHBplGVebCjmE=
X-Received: by 2002:a05:6122:250e:b0:4d4:11a6:a4ff with SMTP id
 cl14-20020a056122250e00b004d411a6a4ffmr506610vkb.3.1712856609810; Thu, 11 Apr
 2024 10:30:09 -0700 (PDT)
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
In-Reply-To: <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 11 Apr 2024 13:29:58 -0400
Message-ID: <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is an updated version of linus's patch that makes the check
namespace relative
---
 fs/namei.c            | 17 ++++++++++++-----
 include/linux/namei.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4e0de939fea1..2bcc10976ba7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2419,6 +2419,14 @@ static const char *path_init(struct nameidata
*nd, unsigned flags)
         if (!f.file)
             return ERR_PTR(-EBADF);

+        if (flags & LOOKUP_DFD_MATCH_CREDS) {
+            if (f.file->f_cred !=3D current_cred() &&
+                !ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH))=
 {
+                fdput(f);
+                return ERR_PTR(-ENOENT);
+            }
+        }
+
         dentry =3D f.file->f_path.dentry;

         if (*s && unlikely(!d_can_lookup(dentry))) {
@@ -4640,14 +4648,13 @@ int do_linkat(int olddfd, struct filename
*old, int newdfd,
         goto out_putnames;
     }
     /*
-     * To use null names we require CAP_DAC_READ_SEARCH
+     * To use null names we require CAP_DAC_READ_SEARCH or
+     * that the open-time creds of the dfd matches current.
      * This ensures that not everyone will be able to create
      * handlink using the passed filedescriptor.
      */
-    if (flags & AT_EMPTY_PATH && !capable(CAP_DAC_READ_SEARCH)) {
-        error =3D -ENOENT;
-        goto out_putnames;
-    }
+    if (flags & AT_EMPTY_PATH)
+        how |=3D LOOKUP_DFD_MATCH_CREDS;

     if (flags & AT_SYMLINK_FOLLOW)
         how |=3D LOOKUP_FOLLOW;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 74e0cc14ebf8..678ffe4acf99 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -44,6 +44,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_BENEATH        0x080000 /* No escaping from starting point.=
 */
 #define LOOKUP_IN_ROOT        0x100000 /* Treat dirfd as fs root. */
 #define LOOKUP_CACHED        0x200000 /* Only do cached lookup */
+#define LOOKUP_DFD_MATCH_CREDS    0x400000 /* Require that dfd creds
match current */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)

--=20
2.44.0

On Thu, Apr 11, 2024 at 12:44=E2=80=AFPM Charles Mirabile <cmirabil@redhat.=
com> wrote:
>
> On Thu, Apr 11, 2024 at 12:15=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 11 Apr 2024 at 02:05, Christian Brauner <brauner@kernel.org> wr=
ote:
> > >
> > > I had a similar discussion a while back someone requested that we rel=
ax
> > > permissions so linkat can be used in containers.
> >
> > Hmm.
> >
> > Ok, that's different - it just wants root to be able to do it, but
> > "root" being just in the container itself.
> >
> > I don't think that's all that useful - I think one of the issues with
> > linkat(AT_EMPTY_PATH) is exactly that "it's only useful for root",
> > which means that it's effectively useless. Inside a container or out.
> >
> > Because very few loads run as root-only (and fewer still run with any
> > capability bits that aren't just "root or nothing").
> >
> > Before I did all this, I did a Debian code search for linkat with
> > AT_EMPTY_PATH, and it's almost non-existent. And I think it's exactly
> > because of this "when it's only useful for root, it's hardly useful at
> > all" issue.
> >
> > (Of course, my Debian code search may have been broken).
> >
> > So I suspect your special case is actually largely useless, and what
> > the container user actually wanted was what my patch does, but they
> > didn't think that was possible, so they asked to just extend the
> > "root" notion.
> >
> Yes, that is absolutely the case. When Christian poked holes in my
> initial submission, I started working on a v2 but haven't had a chance
> to send it because I wanted to make sure my arguments etc were
> airtight because I am well aware of just how long and storied the
> history of flink is. In the v2 that I didn't post yet, I extended the
> ability to link *any* file from only true root to also "root" within a
> container following the potentially suspect approach that christian
> suggested (I see where you are coming from with the unobvious approach
> to avoiding toctou though I obviously support this patch being
> merged), but I added a followup patch that checks for whether the file
> in question is an `__O_TMPFILE` file which is trivial once we are
> jumping through the hoops of looking up the struct file. If it is a
> tmpfile (i.e. linkcount =3D 0) I think that all the concerns raised
> about processes that inherit a fd being able to create links to the
> file inappropriately are moot. Here is an excerpt from the cover
> letter I was planning to send that explains my reasoning.
>
>  -  the ability to create an unnamed file, adjust its contents
> and attributes (i.e. uid, gid, mode, xattrs, etc) and then only give it a=
 name
> once they are ready is exactly the ideal use-case for a hypothetical `fli=
nk`
> system call. The ability to use `AT_EMPTY_PATH` with `linkat` essentially=
 turns
> it into `flink`, but these restrictions hamper it from actually being use=
d, as
> most code is not privileged. By checking whether the file to be linked is=
 a
> temporary (i.e. unnamed) file we can allow this useful case without allow=
ing
> the more risky cases that could have security implications.
>
>  - Although it might appear that the security posture is affected, it is =
not.
> Callers who open an extant file on disk in read only mode for sharing wit=
h
> potentially untrustworthy code can trust that this change will not affect=
 them
> because it only applies to temporary files. Callers who open a temporary =
file
> need to do so with write access if they want to actually put any data in =
it,
> so they will already have to reopen the file (e.g. by linking it to a pat=
h
> and opening that path, or opening the magic symlink in proc) if they want=
 to
> share it in read-only mode with untrustworthy code. As such, that new fil=
e
> description will no longer be marked as a temporary file and thus these c=
hanges
> do not apply. The final case I can think of is the unlikely possibility o=
f
> intentionally sharing read write access to data stored in a temporary fil=
e with
> untrustworthy code, but where that code being able to make a link would s=
till
> be deleterious. In such a bizarre case, the `O_EXCL` can and should be us=
ed to
> fully prevent the temporary file from ever having a name, and this change=
 does
> not alter its efficacy.
>
> > I've added Charles to the Cc.
> >
> > But yes, with my patch, it would now be trivial to make that
> >
> >         capable(CAP_DAC_READ_SEARCH)
> >
> > test also be
> >
> >         ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)
> >
> > instead. I suspect not very many would care any more, but it does seem
> > conceptually sensible.
> >
> > As to your patch - I don't like your nd->root  games in that patch at
> > all. That looks odd.
> >
> > Yes, it makes lookup ignore the dfd (so you avoid the TOCTOU issue),
> > but it also makes lookup ignore "/". Which happens to be ok with an
> > empty path, but still...
> >
> > So it feels to me like that patch of yours mis-uses something that is
> > just meant for vfs_path_lookup().
> >
> > It may happen to work, but it smells really odd to me.
> >
> >              Linus
> >


