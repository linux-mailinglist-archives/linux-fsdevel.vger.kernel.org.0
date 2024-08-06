Return-Path: <linux-fsdevel+bounces-25118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21B94947A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AB51F267B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331B2C697;
	Tue,  6 Aug 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnPee+tY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899402AF15;
	Tue,  6 Aug 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957948; cv=none; b=sRgqwqiJQ1LATK8vfa7TsWipogCOfVJOpYXYRKKyGkDpEaae92e31dEzjwEqMQcO5aMN+YaOqatxnhUG78GWXRFnDM/Z3H6S0q3dzPKx+KAQjvh/mqrX5TgUg8Ro+UwjZiVzU9Vbu9WnLb3WpVE0cqv7HpGxoRrGtQPpHQ4eicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957948; c=relaxed/simple;
	bh=Rmh4AODj37z/jUko7KcWkfppmyAE1QONjSLqYzxDW/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCmJhxcStCukDfJlR8oCfUU+2qt5cDXzf4qLoYev949UYqoiSobtPH9XtEDj+du1bQruh6Yrv2VJ+ZPAfwKknwReysnokfvjpZsF9u/o2nKiQ2nN6luArQ67uXJj7GK8y2y8WDV12eR/frfxQ4Brn1O+ADnBeN2KpEbIKSAq2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnPee+tY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso1195096e87.2;
        Tue, 06 Aug 2024 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722957945; x=1723562745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m27FS+iFZZcMfzqtEKgmZJZXnPD4GoUXx2UkGBaveHM=;
        b=lnPee+tYbQec9cu/jhCjMYfdoirRqvj7uSnPfxOs5kfdFQYhblQDcyz0WfLABhoaGA
         d2qd7PPrsUE1Jf1CNYmiC9aZuZehDkOtxNDWOBhamesWox0iRAK7WYhZHxvo2SHm6nxe
         TbOMorW3SLWqj/5i2HTyO3J+gNu/lw6S9xM+9qHzhJRO6Q/0Mx/8nys3tKKolqCNhwVA
         Ao6FEYweOAPtVvhxXzjEEk+5oGlJCQf4iIzlJzlchbBewFIHLeOU3cPH1zjBsvgOTIOZ
         pzsM4YkVhEr9uSUxz3TJSBOmH2GzB4G0uNGXnal3j0I4rdPFaGGqiQwjcnzqJ5fNq/va
         jXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722957945; x=1723562745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m27FS+iFZZcMfzqtEKgmZJZXnPD4GoUXx2UkGBaveHM=;
        b=t7dTrm4yf8mRj6Dh0QdQEuBTG03rfzCPEq6W6IXMZ7mqNY7bXiuh3LWaiYa+excjMo
         2QUThjPIxNFdr/Rghjj8iPJ0qgn9VTlWj1Z/xUeim/tK03JqEIRF58sKou6MFz7hz7ct
         Ew8FGZvwyUPcVRWYh5bSFxiiA9lvIOCbwnItCacCABsSieIKQzDkvUygmXT8dJzfwJVj
         ktTEXq/+hVIxDvTn5F3Xk5GkrO0S0tATWBrmuuQNjokhIaO1RwGLNfjqY1iOAUWJUC9Q
         qS7M/xQv1L/zhEQpE4Akzt5BAOd6RtvfAfoH25scp38GywSr0LmxtnWAieQBFqK27+XR
         Lg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZiM3gj7F8bY5eLpQ78Qs/9UJjYtOPxl3bBOFK+NIG2Zsle7Bsp9to0cSaTRC9ERISjxMDeX60j2PVsQO@vger.kernel.org, AJvYcCVD+claNtf/lO5pC8+Alw2nSbr7K4PTESFiuzqZyn/J/mhcNqMePgf/eqIVyJOL5JsKEbB7OQlOBLb7aqTd@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrgz3xALqKLsMulA9ncmaiG7cdyRvOMD+tGUFbkCKzPzuwbsz
	GSz+7GzLJv+0uyahfirhmJcgeeWw9RoegNMxCElfCdd1on0hIOo5t++ZFi4m/fwR1r1sxayYeXH
	Gm2CKjuJ0bqIVE+ORKGTHZ/pvIdM=
X-Google-Smtp-Source: AGHT+IHGVcU9Ki+vaSFy9KOMX1rF5GVrnN+c+58T87yRdtRcv0rBe1IAfqI/pCPzR5LtPylverKbo/pbtxxUwMkQvlY=
X-Received: by 2002:a05:6512:2201:b0:52e:76e8:e18e with SMTP id
 2adb3069b0e04-530bb363022mr10034969e87.7.1722957944057; Tue, 06 Aug 2024
 08:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
In-Reply-To: <20240806-openfast-v2-1-42da45981811@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 6 Aug 2024 17:25:30 +0200
Message-ID: <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:32=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Today, when opening a file we'll typically do a fast lookup, but if
> O_CREAT is set, the kernel always takes the exclusive inode lock. I
> assume this was done with the expectation that O_CREAT means that we
> always expect to do the create, but that's often not the case. Many
> programs set O_CREAT even in scenarios where the file already exists.
>
> This patch rearranges the pathwalk-for-open code to also attempt a
> fast_lookup in certain O_CREAT cases. If a positive dentry is found, the
> inode_lock can be avoided altogether, and if auditing isn't enabled, it
> can stay in rcuwalk mode for the last step_into.
>
> One notable exception that is hopefully temporary: if we're doing an
> rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing the
> dentry in that case is more expensive than taking the i_rwsem for now.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Here's a revised patch that does a fast_lookup in the O_CREAT codepath
> too. The main difference here is that if a positive dentry is found and
> audit_dummy_context is true, then we keep the walk lazy for the last
> component, which avoids having to take any locks on the parent (just
> like with non-O_CREAT opens).
>
> The testcase below runs in about 18s on v6.10 (on an 80 CPU machine).
> With this patch, it runs in about 1s:
>

I don't have an opinion on the patch.

If your kernel does not use apparmor and the patch manages to dodge
refing the parent, then indeed this should be fully deserialized just
like non-creat opens.

Instead of the hand-rolled benchmark may I interest you in using
will-it-scale instead? Notably it reports the achieved rate once per
second, so you can check if there is funky business going on between
reruns, gives the cpu the time to kick off turbo boost if applicable
etc.

I would bench with that myself, but I temporarily don't have handy
access to bigger hw. Even so, the below is completely optional and
perhaps more of a suggestion for the future :)

I hacked up the test case based on tests/open1.c.

git clone https://github.com/antonblanchard/will-it-scale.git

For example plop into tests/opencreate1.c && gmake &&
./opencreate1_processes -t 70:

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>

char *testcase_description =3D "Separate file open/close + O_CREAT";

#define template        "/tmp/willitscale.XXXXXX"
static char (*tmpfiles)[sizeof(template)];
static unsigned long local_nr_tasks;

void testcase_prepare(unsigned long nr_tasks)
{
        int i;
        tmpfiles =3D (char(*)[sizeof(template)])malloc(sizeof(template)
* nr_tasks);
        assert(tmpfiles);

        for (i =3D 0; i < nr_tasks; i++) {
                strcpy(tmpfiles[i], template);
                char *tmpfile =3D tmpfiles[i];
                int fd =3D mkstemp(tmpfile);

                assert(fd >=3D 0);
                close(fd);
        }

        local_nr_tasks =3D nr_tasks;
}

void testcase(unsigned long long *iterations, unsigned long nr)
{
        char *tmpfile =3D tmpfiles[nr];

        while (1) {
                int fd =3D open(tmpfile, O_RDWR | O_CREAT, 0600);
                assert(fd >=3D 0);
                close(fd);

                (*iterations)++;
        }
}

void testcase_cleanup(void)
{
        int i;
        for (i =3D 0; i < local_nr_tasks; i++) {
                unlink(tmpfiles[i]);
        }
        free(tmpfiles);
}



> ---
>  fs/namei.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 53 insertions(+), 9 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 1e05a0f3f04d..2d716fb114c9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3518,6 +3518,47 @@ static struct dentry *lookup_open(struct nameidata=
 *nd, struct file *file,
>         return ERR_PTR(error);
>  }
>
> +static inline bool trailing_slashes(struct nameidata *nd)
> +{
> +       return (bool)nd->last.name[nd->last.len];
> +}
> +
> +static struct dentry *lookup_fast_for_open(struct nameidata *nd, int ope=
n_flag)
> +{
> +       struct dentry *dentry;
> +
> +       if (open_flag & O_CREAT) {
> +               /* Don't bother on an O_EXCL create */
> +               if (open_flag & O_EXCL)
> +                       return NULL;
> +
> +               /*
> +                * FIXME: If auditing is enabled, then we'll have to unla=
zy to
> +                * use the dentry. For now, don't do this, since it shift=
s
> +                * contention from parent's i_rwsem to its d_lockref spin=
lock.
> +                * Reconsider this once dentry refcounting handles heavy
> +                * contention better.
> +                */
> +               if ((nd->flags & LOOKUP_RCU) && !audit_dummy_context())
> +                       return NULL;
> +       }
> +
> +       if (trailing_slashes(nd))
> +               nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> +
> +       dentry =3D lookup_fast(nd);
> +
> +       if (open_flag & O_CREAT) {
> +               /* Discard negative dentries. Need inode_lock to do the c=
reate */
> +               if (dentry && !dentry->d_inode) {
> +                       if (!(nd->flags & LOOKUP_RCU))
> +                               dput(dentry);
> +                       dentry =3D NULL;
> +               }
> +       }
> +       return dentry;
> +}
> +
>  static const char *open_last_lookups(struct nameidata *nd,
>                    struct file *file, const struct open_flags *op)
>  {
> @@ -3535,28 +3576,31 @@ static const char *open_last_lookups(struct namei=
data *nd,
>                 return handle_dots(nd, nd->last_type);
>         }
>
> +       /* We _can_ be in RCU mode here */
> +       dentry =3D lookup_fast_for_open(nd, open_flag);
> +       if (IS_ERR(dentry))
> +               return ERR_CAST(dentry);
> +
>         if (!(open_flag & O_CREAT)) {
> -               if (nd->last.name[nd->last.len])
> -                       nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> -               /* we _can_ be in RCU mode here */
> -               dentry =3D lookup_fast(nd);
> -               if (IS_ERR(dentry))
> -                       return ERR_CAST(dentry);
>                 if (likely(dentry))
>                         goto finish_lookup;
>
>                 if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
>                         return ERR_PTR(-ECHILD);
>         } else {
> -               /* create side of things */
>                 if (nd->flags & LOOKUP_RCU) {
> +                       /* can stay in rcuwalk if not auditing */
> +                       if (dentry && audit_dummy_context())
> +                               goto check_slashes;
>                         if (!try_to_unlazy(nd))
>                                 return ERR_PTR(-ECHILD);
>                 }
>                 audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> -               /* trailing slashes? */
> -               if (unlikely(nd->last.name[nd->last.len]))
> +check_slashes:
> +               if (trailing_slashes(nd))
>                         return ERR_PTR(-EISDIR);
> +               if (dentry)
> +                       goto finish_lookup;
>         }
>
>         if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240723-openfast-ac49a7b6ade2
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>


--=20
Mateusz Guzik <mjguzik gmail.com>

