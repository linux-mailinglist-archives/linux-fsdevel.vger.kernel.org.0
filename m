Return-Path: <linux-fsdevel+bounces-22666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67F91AF10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6814B299D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C019AD6D;
	Thu, 27 Jun 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FlVezMTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAD199E93
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512897; cv=none; b=Z2n+7UPCDkuGQhv6sETSFwvWAMe7SvIss7JHQhpyBuKwPK1H53ZpuwnsTx4w8/jCwB3u6FZyag/Okd8pyLkrBC9TCMizcFC4UHv/+cqlQFHa9jBncU4rS+L3gWdDqBddAjCRvw5Pu7LhMksxqVzkbQOOpverFq3t0/2A5PLd8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512897; c=relaxed/simple;
	bh=znZYdAxiCH+A4HSUYxdQ4KMlHNsFqZCMj0c2MPydib8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvdrDG0FB86I+YBtRqP49mZw3CvmXM7Sdl5wWTUiNd4Uh4uL6x1naYoFTUbEbNTFuQLQXJDfvaJw9YL2rREDITrq0et2YFGDykHkruAYH6ohJ5ebA2rOZgm7zLjld6tkcGCTz9VzsXFhi2iphzYIhTtlQWisx+VQSQ13s410ELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FlVezMTI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6325b04c275so85161377b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719512895; x=1720117695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98TupyMqQC1h7iKyPO2OiBrTMZxN0LnlBq3D8HsG6iQ=;
        b=FlVezMTIJ/YQ4YAZO1HeMEoptpvxo2jXd8OtgBagb7MKfOcjl8UXlWsLccw9whwbDr
         WSd399nKg2hNajER0xXnqT9YoXVUd3RwfpWU+I6NXmOPNTyfEoIpTwfOUcFN54F6hI4r
         hwQsQ+/8n7RRqldW0MSDarJmxBVGQIGr4UkLsiMSt82FKSGYLCHJSnmSrDJGCM0HVANJ
         Z8ah9LT6y6hyt+xN4deOn0aOt05wUYyOb3HzMlD6h9er01atVnwb31RCidUH36D43Vyr
         LvZQUEylBWyJuIUkW96WsHQLl5PlZbwmHnrkJMNtXgUutatlzhleoSVoprWtvmrDsH3N
         jxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512895; x=1720117695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98TupyMqQC1h7iKyPO2OiBrTMZxN0LnlBq3D8HsG6iQ=;
        b=rRBq56PuXJJ63nJygCr8CRl1EFCMmMM09nzg7xRFdHHRNcpGcQI9Ho1asYm2zXEvmd
         axj7CVqD8wDeRLp+km63xOc9PgkwRR2YBvVj4JFsjcT4JI17vN3QxuptsWZ2MPJrm5HU
         JFLStwb73HdSoJZt4d5hX7XdnZtPi5CwjqIIsjN3BdmHxYB9SstOp5T7Wq3ejsa/x7ws
         fs697rUwUYZ3aULwxPZfmXxGIRDs/RKhkj+OzIFXvUQlPP8nVfHT7JTifQ6Ka8M3XXoB
         s1kB1kfgoKqzPEfkN4LGPT7tlP4DW9vz5RDlQcTP036Oid2MkQTNLcb1mVZEfrKFlwRP
         LnMg==
X-Forwarded-Encrypted: i=1; AJvYcCXE8mxNlPNbS3UZfPGZ+VBpbgjvmO7FlQcD2jisAOFs1TUY0t8tsqIgHlm+bXKDByRpCbJnzZ+NfN3UrOIR0VZ+Q5rF7rQQyN5hxCoBEg==
X-Gm-Message-State: AOJu0YwQ8K3UifFuLwBUA5NKsyVmshNcDmb12QeIkUXALQWvAV2p6niB
	/Jhag/LRO9v1QDkB64lYVDBEjzflkTdqxP0nsKm31qzaBQ83uzaKLWpHdkzhsydTvri3zW9Fq5m
	kIGvtyEA1Sjrp3tv3EK6/f+2ocl/hsz2LTu5Cg43GDfIRPzo9yg==
X-Google-Smtp-Source: AGHT+IHPccPItdwbPf9SbuGTEOB2ovjw2eaRKM0smvqTd0DyTnkstyegr0fB3+Bwc6TtmPyuyZGZolGjCRz5Cl5ngm8=
X-Received: by 2002:a25:7d47:0:b0:df7:8dca:1ef2 with SMTP id
 3f1490d57ef6-e0303f34dd7mr14761280276.34.1719512894883; Thu, 27 Jun 2024
 11:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net> <20240627.Voox5yoogeum@digikod.net>
In-Reply-To: <20240627.Voox5yoogeum@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Jun 2024 14:28:03 -0400
Message-ID: <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:34=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> I didn't find specific issues with Landlock's code except the extra
> check in hook_inode_free_security().  It looks like inode->i_security is
> a dangling pointer, leading to UAF.
>
> Reading security_inode_free() comments, two things looks weird to me:
>
> > /**
> >  * security_inode_free() - Free an inode's LSM blob
> >  * @inode: the inode
> >  *
> >  * Deallocate the inode security structure and set @inode->i_security t=
o NULL.
>
> I don't see where i_security is set to NULL.

The function header comments are known to be a bit suspect, a side
effect of being detached from the functions for many years, this may
be one of those cases.  I tried to fix up the really awful ones when I
moved the comments back, back I didn't have time to go through each
one in detail.  Patches to correct the function header comments are
welcome and encouraged! :)

> >  */
> > void security_inode_free(struct inode *inode)
> > {
>
> Shouldn't we add this check here?
> if (!inode->i_security)
>         return;

Unless I'm remembering something wrong, I believe we *should* always
have a valid i_security pointer each time we are called, if not
something has gone wrong, e.g. the security_inode_free() hook is no
longer being called from the right place.  If we add a NULL check, we
should probably have a WARN_ON(), pr_err(), or something similar to
put some spew on the console/logs.

All that said, it would be good to hear some confirmation from the VFS
folks that the security_inode_free() hook is located in a spot such
that once it exits it's current RCU critical section it is safe to
release the associated LSM state.

It's also worth mentioning that while we always allocate i_security in
security_inode_alloc() right now, I can see a world where we allocate
the i_security field based on need using the lsm_blob_size info (maybe
that works today?  not sure how kmem_cache handled 0 length blobs?).
The result is that there might be a legitimate case where i_security
is NULL, yet we still want to call into the LSM using the
inode_free_security() implementation hook.

> >       call_void_hook(inode_free_security, inode);
> >       /*
> >        * The inode may still be referenced in a path walk and
> >        * a call to security_inode_permission() can be made
> >        * after inode_free_security() is called. Ideally, the VFS
> >        * wouldn't do this, but fixing that is a much harder
> >        * job. For now, simply free the i_security via RCU, and
> >        * leave the current inode->i_security pointer intact.
> >        * The inode will be freed after the RCU grace period too.
>
> It's not clear to me why this should be safe if an LSM try to use the
> partially-freed blob after the hook calls and before the actual blob
> free.

I had the same thought while looking at this just now.  At least in
the SELinux case I think this "works" simply because SELinux doesn't
do much here, it just drops the inode from a SELinux internal list
(long story) and doesn't actually release any memory or reset the
inode's SELinux state (there really isn't anything to "free" in the
SELinux case).  I haven't checked the other LSMs, but they may behave
similarly.

We may want (need?) to consider two LSM implementation hooks called
from within security_inode_free(): the first where the existing
inode_free_security() implementation hook is called, the second inside
the inode_free_by_rcu() callback immediately before the i_security
data is free'd.

... or we find a better placement in the VFS for
security_inode_free(), is that is possible.  It may not be, our VFS
friends should be able to help here.

> >        */
> >       if (inode->i_security)
> >               call_rcu((struct rcu_head *)inode->i_security,
> >                        inode_free_by_rcu);
>
> And then:
> inode->i_security =3D NULL;

According to the comment we may still need i_security for permission
checks.  See my comment about decomposing the LSM implementation into
two hooks to better handle this for LSMs.

> But why call_rcu()?  i_security is not protected by RCU barriers.

I believe the issue is that the inode is protected by RCU and that
affects the lifetime of the i_security blob.

--=20
paul-moore.com

