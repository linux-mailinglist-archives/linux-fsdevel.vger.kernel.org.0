Return-Path: <linux-fsdevel+bounces-10775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5B84E322
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792531F2363B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23078B75;
	Thu,  8 Feb 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC05owvC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F278B5D
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402510; cv=none; b=Aros2Smk2sLiMWNUhlmP+Ls3FRB12T3nv3eaQANr4aXu89xKKk9SmOjlwKqODgA1czz4tn3Lxxq50fHKHs9R4MfejDyby/tE18cgqJEzvKUh4ZkAWPAuqrxplnUaOoB8Epes2zOlCnCcIurko6InnU9ttQQss1oQ/31BtJnUNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402510; c=relaxed/simple;
	bh=xPJxCtMIHPqfKZM5PHFmK17d0/dTW8HPx+GKoJoBaWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw5dfYlJ8ouNYI4FFbzpO9hgORNhWNyDa3lYs2RitabgmiEYVmdxVgQldosF9se6xX4icati165in/GvQxrlUB7EFVTlCjAiuxT+PkZ9QJLb95uejbKSppJYwuZ/4xTavH84+3QpYa7CG1x5tzpREplLD9QFjEIuaPm4f1ANEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YC05owvC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707402507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74WiF3KyvUKOTQcEC2aP6vHhzzlhPjVl2ZNugP1o30c=;
	b=YC05owvCvPeTLU4Guq9hnKoIxfo0R9FZu79y4c913WQ6Ul+D4u/xLSOycN3dYSTzdXRi50
	w/usVakBiwFCInmdjJiBmtQxZuBnNTjvrsLxr5HkOnpypg/IEknWK+y96mjRY7s/SNzCVO
	JendYbJDpKkRA5nAOfzOHEThP2LfMgw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ZfAxC9iMPZ-cT1pQC6tOIw-1; Thu, 08 Feb 2024 09:28:25 -0500
X-MC-Unique: ZfAxC9iMPZ-cT1pQC6tOIw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so1875670a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 06:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707402505; x=1708007305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74WiF3KyvUKOTQcEC2aP6vHhzzlhPjVl2ZNugP1o30c=;
        b=xNwnouiTqAw8t6u21v66Iw6dxfYMoMqCiCxdrDdvOwbqTJarYacocww9amQztLbekF
         Ynh3Rn/b94cXeKaqgnW7KrAI/JJnnuRKHpKt2tMOTMQQikCWGmprd/UoktlUUSqJAjee
         pZHImVNu2JszwJHyzf0TfNRJZdoNwh5mb+XXquwX7i1FSCx4w4xpKpmQ66kgFM/ZDxqF
         rwlcSmiYLcXUHjFwZvLJX0PvGYk47b24vIy/5598wUcocEUrE7ripXk1bkBxNAcwqBhq
         okBN4laPPjFO4mWWua7bdsyHuGluJoY+XoPGT+4TzR1DIZe1vys7Tqi8Z9uBY7ul3Cug
         W0Kg==
X-Gm-Message-State: AOJu0Yzw4BZe+dqtDoJkCFgGJupUCLWU5X1w3lms7cCUkjGuo6ykYJW+
	qdTk4DP0iSHNXt7Ykn3A6xUj+aEXZ9FkNC330M3WjjDywiVoOzMFAWFSdI81qVs2+WmJ/uu4kKe
	FhC76Z2T6aTls7G1vLyT6db5314tT9pNAXz/Gky+D2iFYifY+ASYtN/ftkICpnl99GGvulswPNe
	tWKB5yrqgGL+ckJ34ZJ6azbglihs7nSqH0qYZVKw==
X-Received: by 2002:a05:6a21:625:b0:19e:aaba:a6a5 with SMTP id ll37-20020a056a21062500b0019eaabaa6a5mr3069364pzb.40.1707402504966;
        Thu, 08 Feb 2024 06:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF2LGd/KxdCok0kT6RXYLD9byfDnzFAZn3yokoQhEBDz3MkBqU1AXNrEP/sKdKrm7sB8NR/C68BAnornfLA2Q=
X-Received: by 2002:a05:6a21:625:b0:19e:aaba:a6a5 with SMTP id
 ll37-20020a056a21062500b0019eaabaa6a5mr3069343pzb.40.1707402504572; Thu, 08
 Feb 2024 06:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
 <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org> <CAFqZXNv0e9JTd6EtB4F50WkZzNjY7--Rv6U1185dw0gS_UYf9A@mail.gmail.com>
In-Reply-To: <CAFqZXNv0e9JTd6EtB4F50WkZzNjY7--Rv6U1185dw0gS_UYf9A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 8 Feb 2024 15:28:13 +0100
Message-ID: <CAFqZXNs7wG7dwSV=h_1DWBjW5QDCHcK=XPFUoNOR6hbsbAgZ_A@mail.gmail.com>
Subject: Re: Calls to vfs_setlease() from NFSD code cause unnecessary
 CAP_LEASE security checks
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:31=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Fri, Feb 2, 2024 at 5:08=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Fri, 2024-02-02 at 16:31 +0100, Ondrej Mosnacek wrote:
> > > Hello,
> > >
> > > In [1] a user reports seeing SELinux denials from NFSD when it writes
> > > into /proc/fs/nfsd/threads with the following kernel backtrace:
> > >  =3D> trace_event_raw_event_selinux_audited
> > >  =3D> avc_audit_post_callback
> > >  =3D> common_lsm_audit
> > >  =3D> slow_avc_audit
> > >  =3D> cred_has_capability.isra.0
> > >  =3D> security_capable
> > >  =3D> capable
> > >  =3D> generic_setlease
> > >  =3D> destroy_unhashed_deleg
> > >  =3D> __destroy_client
> > >  =3D> nfs4_state_shutdown_net
> > >  =3D> nfsd_shutdown_net
> > >  =3D> nfsd_last_thread
> > >  =3D> nfsd_svc
> > >  =3D> write_threads
> > >  =3D> nfsctl_transaction_write
> > >  =3D> vfs_write
> > >  =3D> ksys_write
> > >  =3D> do_syscall_64
> > >  =3D> entry_SYSCALL_64_after_hwframe
> > >
> > > It seems to me that the security checks in generic_setlease() should
> > > be skipped (at least) when called through this codepath, since the
> > > userspace process merely writes into /proc/fs/nfsd/threads and it's
> > > just the kernel's internal code that releases the lease as a side
> > > effect. For example, for vfs_write() there is kernel_write(), which
> > > provides a no-security-check equivalent. Should there be something
> > > similar for vfs_setlease() that could be utilized for this purpose?
> > >
> > > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> > >
> >
> > Thanks for the bug report!
> >
> > Am I correct that we only want to do this check when someone from
> > userland tries to set a lease via fcntl? The rest of the callers are al=
l
> > in-kernel callers and I don't think we need to check for any of them. I=
t
> > may be simpler to just push this check into the appropriate callers of
> > generic_setlease instead.
> >
> > Hmm now that I look too...it looks like we aren't checking CAP_LEASE on
> > filesystems that have their own ->setlease operation. I'll have a look
> > at that soon too.
>
> I did briefly check this while analyzing the issue and all of the
> setlease fops implementations seemed to be either simple_nosetlease()
> or some wrappers around generic_setlease(), which should both be OK.
> But it can't hurt to double-check :)

To close the loop here - there is now a fix from Jeff in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D7b8001013d720c232ad9ae7aae0ef0e7c281c6d4

Thank you, Jeff, for taking care of it!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


