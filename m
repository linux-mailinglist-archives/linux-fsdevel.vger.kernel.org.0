Return-Path: <linux-fsdevel+bounces-10048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DDC8474C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAA9B2B3B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF0148300;
	Fri,  2 Feb 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4svFKOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE401487D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891483; cv=none; b=cDjQxWzkahDcbhyUEfJkSc7G9N2b2oJqSGsQlofm5l4MgNav/71RaFZhPf9wfuBE0b2BvtsXUsEuZBF8IarG1t1dl+yskT77FdT3XsKtRYpUkQzXE+FPf0Gysa7j51t3WzhoNxR/2B0fKdfQfLTm2yo7Vc3ef1L2EmDzKLRXSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891483; c=relaxed/simple;
	bh=L5XX9q9Bgwmes5VChQaRo0wPdr/Y43FELw3URgsUbfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmnhiQmyq1lLBk/tTArWgjVQVK0KOnnwd0yQXPsjSpSWMOVS4vQkpfHbnwRnbHZWEzBHyV02aMn+hseN6lWvCqepzghNZ5qc0MVgH7iebZ3j0FViPsHotkUyR275nEuAHRWCmFEn+CxhxGQJH+wIR78WV4hofrV5AzbEBORKY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4svFKOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk0HlDLODgfQxPi8eQL+hYbTQD1mb0Iz4J6bjfS5DyY=;
	b=h4svFKOaebvP76eqv/sADPODuqPB5PspAX7MnsqYwCepVDngD9Y1R9Z2CjqtZwrtCpNXBl
	oTMlgLnu8VIcATfgxvEspOmDUZhpdnZdfYn/hqOpIQyeGuFLZKanKumgww5H6qdNJlwccT
	ESYvmH+aEsi6MYOPe5q8ucCoUoW4TqM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-DiVkSj9CNVKTfyIIAXemOg-1; Fri, 02 Feb 2024 11:31:17 -0500
X-MC-Unique: DiVkSj9CNVKTfyIIAXemOg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ddded741bfso1685516b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891476; x=1707496276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk0HlDLODgfQxPi8eQL+hYbTQD1mb0Iz4J6bjfS5DyY=;
        b=BaBsyfuLSIEa6Vh9etqf0ClxI3rco/hu09WfzpkiRJXs6MXkneNF4+3vXIyuimI3FM
         yuQsSmfXl4Y2yoO/+yCC0oKZWEYZu6+79p+pYTFRcADFgiPTpD/MkBwprd0tX2lNETXr
         pPrBbO98+0SyjxvGIibNshUdJt0hyehx24dn3MlheUsuJMFl9R34l+dlqt+4tDwjy1mg
         Qw5C5Nil/rdLmUHa6k0QZ+buHOUGvlmC43EpbP5yp+u6zUuALNEgrQNT7n0LN8cH/q97
         rmL/uJ0OmZDIHGkxGh+/5IUAQ4MIVZKtLQu5Ztoj4cYsq2Akqa7ABAczNyJuOnTMQ6Kw
         u6Bw==
X-Gm-Message-State: AOJu0Yz5W7jQ7yCByT8hsTbKO14J7Lrk2NCXCNNRa6r0q3pAB622aRZ0
	hZ81gqhtrWQlKxKrY9UA4hEFtoek9vquTX/jbN6TppCKcvFo1eV4CfqIQ0enBjA6JfQ+/32ulDp
	EvpuSV9P2oV662ry4yhZFuTc2439N6rwkxjkyuiaAZmYFyR7/x3/Ak750fu0z0X7dlWEim0qZB1
	XeiPOgu/q+P103gbrvPY1MYct9ikkhGLz4llM5Zg==
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id eb19-20020a056a004c9300b006dfe0355549mr9341740pfb.15.1706891476158;
        Fri, 02 Feb 2024 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgHoeBG2Xdr20yw3gJ0WYTkapLgzV5sN33Vdcc74VwBIGKGFLCt2pM0mIE0OOYW6PvCilVy3VKGPphO9s59cw=
X-Received: by 2002:a05:6a00:4c93:b0:6df:e035:5549 with SMTP id
 eb19-20020a056a004c9300b006dfe0355549mr9341683pfb.15.1706891475565; Fri, 02
 Feb 2024 08:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
 <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org>
In-Reply-To: <41edca542d56692f4097f54b49a5543a81dea8ae.camel@kernel.org>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 2 Feb 2024 17:31:04 +0100
Message-ID: <CAFqZXNv0e9JTd6EtB4F50WkZzNjY7--Rv6U1185dw0gS_UYf9A@mail.gmail.com>
Subject: Re: Calls to vfs_setlease() from NFSD code cause unnecessary
 CAP_LEASE security checks
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:08=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Fri, 2024-02-02 at 16:31 +0100, Ondrej Mosnacek wrote:
> > Hello,
> >
> > In [1] a user reports seeing SELinux denials from NFSD when it writes
> > into /proc/fs/nfsd/threads with the following kernel backtrace:
> >  =3D> trace_event_raw_event_selinux_audited
> >  =3D> avc_audit_post_callback
> >  =3D> common_lsm_audit
> >  =3D> slow_avc_audit
> >  =3D> cred_has_capability.isra.0
> >  =3D> security_capable
> >  =3D> capable
> >  =3D> generic_setlease
> >  =3D> destroy_unhashed_deleg
> >  =3D> __destroy_client
> >  =3D> nfs4_state_shutdown_net
> >  =3D> nfsd_shutdown_net
> >  =3D> nfsd_last_thread
> >  =3D> nfsd_svc
> >  =3D> write_threads
> >  =3D> nfsctl_transaction_write
> >  =3D> vfs_write
> >  =3D> ksys_write
> >  =3D> do_syscall_64
> >  =3D> entry_SYSCALL_64_after_hwframe
> >
> > It seems to me that the security checks in generic_setlease() should
> > be skipped (at least) when called through this codepath, since the
> > userspace process merely writes into /proc/fs/nfsd/threads and it's
> > just the kernel's internal code that releases the lease as a side
> > effect. For example, for vfs_write() there is kernel_write(), which
> > provides a no-security-check equivalent. Should there be something
> > similar for vfs_setlease() that could be utilized for this purpose?
> >
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> >
>
> Thanks for the bug report!
>
> Am I correct that we only want to do this check when someone from
> userland tries to set a lease via fcntl? The rest of the callers are all
> in-kernel callers and I don't think we need to check for any of them. It
> may be simpler to just push this check into the appropriate callers of
> generic_setlease instead.
>
> Hmm now that I look too...it looks like we aren't checking CAP_LEASE on
> filesystems that have their own ->setlease operation. I'll have a look
> at that soon too.

I did briefly check this while analyzing the issue and all of the
setlease fops implementations seemed to be either simple_nosetlease()
or some wrappers around generic_setlease(), which should both be OK.
But it can't hurt to double-check :)

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


