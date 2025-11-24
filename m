Return-Path: <linux-fsdevel+bounces-69720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F821C82C3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 00:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1EE84E3F67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20752F83AB;
	Mon, 24 Nov 2025 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgxGeEF1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fljg49im"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE282F6916
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025475; cv=none; b=sE0Ej7rhLDrXG3CIl+AtdLiezr9zYrVnS7W2UVtaF9p2+EvDSiWR8LwUgj5RXl65PEL/+CRSGOR/BzqiPnSH+zAcQ+fE0f4DlQtgxf/pXDwwZhMKG6uSijL7Tun+QLYV05FoHQdMWoh7R0IasAGffCR3frzC2Czm2EDE+/T9T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025475; c=relaxed/simple;
	bh=ujLtX6zlTlgE0nj4fhVmmtwxYAVcNkknREVz+IJurrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btwOB5ivhNpf/qthJrL7R4GdISGmDS46R4JxyvXDAUhCCBg4cYPt6/BP06M36MVPo3NLTWt1isg2rMg5PcG/5VBMsnulqC8Xo+bPdnTdWH0hPr+ujJucbS5jl1CsW36kk1scChAPA3TR5thnIjQ02gJgsBCu7KrCz+9sP+wFFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgxGeEF1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fljg49im; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764025472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pm9hZ7pSHexKzssljSb7GxpomwErYNIAgHvNKXZVQAc=;
	b=HgxGeEF1y6+Cf194CyzVyCyk57XaL7RsQm5d3bD6CKnTDoarIp4SjzSs4wfwuZLjWWBcrs
	sBr302MXrTGzLPF3Uy9GdFt4YjyMcZf4iAxRBmJ7xdHa45wnPEz80wtZ/L6QpY0kaeIIjF
	xWB7n6B14hhqFliJ2C8aWsQG/kQ9paQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jpO8kae_MfypO8TXQp8N6g-1; Mon, 24 Nov 2025 18:04:31 -0500
X-MC-Unique: jpO8kae_MfypO8TXQp8N6g-1
X-Mimecast-MFC-AGG-ID: jpO8kae_MfypO8TXQp8N6g_1764025470
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78a8110330aso67858347b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764025470; x=1764630270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm9hZ7pSHexKzssljSb7GxpomwErYNIAgHvNKXZVQAc=;
        b=fljg49imR0Pc66W9wSBRbOAoJ2TWoT4ih0+TE1PLYZUvBphwObec7lV0hHJhabGsxn
         /euO6JP789pj2/aKVlVUsDifteEi9x96vGXuU1sPfQBiPrec7Cl3qEeZGQQf2tC2QSFA
         HvmZBvdbnHMrn0+h1tbBqkycW0e3x0TlI5J2F0aOXJRZj37+HZf+SMZs/CPwE7uX03v8
         bLH3U3AmQ67PdiZa0ucUYCcYeobj4Nj2x4OBkWkbXsp/zpUKhRMmwrDyGYSA30Jy8/cN
         NRrpnLxD72xFYjXrykqWgd3JE8ZFWdOjX25KI6Om3hgN/bpt2Gwvx4nS+Q3yvyFe+KBl
         +a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764025470; x=1764630270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pm9hZ7pSHexKzssljSb7GxpomwErYNIAgHvNKXZVQAc=;
        b=CTW3W1vST34eFdPEfKV6Naimvin9Qhbc8TKNj7WVWtXtZkaUXFDqvodMRuvHqRH4CN
         jbdQc55ZLFEXa9cVwpJhHo7+YQtRL6rECuNH/TohNPf7/UkQesHHaQ1dtrAnt5377Ls1
         987ldm3zk4XPks+4iMRqFTEdtVpCTWG2v98p/DAKQqGkXjoEAcX73cegxbbiq3LdjAb9
         xbaFTfO1wS71d8JRtYouL4wPwzRoEKZsMJCIuVpqcZ2hdYyVTjbPBUAL3dapMhaUHyJk
         12kicyfSzWJczeEGHBpfHt5TcjG3vo91rCAGwPloqAUTDHIfM8e9fjkrnFHuunOjrJiZ
         r3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUiFdKB7EfkrXIIuGIoAn+5lYxgXGcNTHnATCDqTIg8A8sHbw5ppRy0r4f6UxzVyDQdXOy7CVY8NgncFp95@vger.kernel.org
X-Gm-Message-State: AOJu0YwsM+U7NSOFE/Xod6anDkyR2KiYC3jffpmbYwP38k3GZIECftdB
	WfpQVbSrqtktwbde0a+BpipV4BG+JxuuwaXRShx29UuNwRnOdl60GCb/zfVaYFHmtef9TqNapPp
	MilnRoPyPB/A1Xff8jFIK5xfqmkNeFeCgKSPfeaz45D4OajQFBziMk2JEYdpicv4PwLJIJNFUHk
	9ieQBMFuYYBDXbhcSs1BSSPbMwDggoYR4m9l0a8RtJFw==
X-Gm-Gg: ASbGncuAk0YL/LbOUS82RqsrrIMR3Oxd13raKCavugnfNPnAxR6mukoWmXNmiW5c1vo
	lsoiVE+cd9zoGP4tuBifpQHH4nENUJM+Rww3YRIZHaZhMOGsQ1upKY4qe0ROUHHYB3Nac2t0HAd
	FGDo5dkxq/u9YhAmTARtNyVPO5Y6UalV3sa2A8jk1Nr5SPfaN/+RQHspZ3+q1gJntq
X-Received: by 2002:a05:690c:6188:b0:787:caf4:574b with SMTP id 00721157ae682-78a8b478085mr106993627b3.6.1764025465392;
        Mon, 24 Nov 2025 15:04:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5rhulRez1ZZLZ9H2rydm4Xv1Es2yTA2HudRkpfi1ztvqSzrul5asp9gS2iIk/Djr0lxIh8JAIfbFJnQqBydo=
X-Received: by 2002:a05:690c:6188:b0:787:caf4:574b with SMTP id
 00721157ae682-78a8b478085mr106993497b3.6.1764025465073; Mon, 24 Nov 2025
 15:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010221737.1403539-1-mjguzik@gmail.com> <20251124174742.2939610-1-agruenba@redhat.com>
 <CAGudoHF4PNbJpc5uUDA02d=TD8gL2J4epn-+hhKhreou1dVX5g@mail.gmail.com>
In-Reply-To: <CAGudoHF4PNbJpc5uUDA02d=TD8gL2J4epn-+hhKhreou1dVX5g@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 25 Nov 2025 00:04:14 +0100
X-Gm-Features: AWmQ_bk0Db3Yf8Wj4ztfJ2Hi41_fUWpr33oxkB4w7jxRqlzjN6lKwWImw8AY2DA
Message-ID: <CAHc6FU5aWPsv0ZfJAjLyziGjyem9SvWY2e+ZuKDhybOWS-roYQ@mail.gmail.com>
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 8:25=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On Mon, Nov 24, 2025 at 6:47=E2=80=AFPM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> >
> > On Sat, Oct 11, 2025 at 12:17=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > > +             *isnew =3D !!(inode_state_read(inode) & I_NEW);
> >
> > Nit: the not-nots here and in the other two places in this patch are no=
t
> > doing anything.  Please avoid that kind of thing.
> >
>
> Huh, it appears you are right. So happens I_NEW has the value of 0x1,
> so I tried out another flag:
>
> bool flagvar_de(struct inode *inode);
> bool flagvar_de(struct inode *inode)
> {
>         return !!(inode_state_read(inode) & I_CREATING);
> }
> EXPORT_SYMBOL(flagvar_de);
>
> bool flagvar(struct inode *inode);
> bool flagvar(struct inode *inode)
> {
>         return inode_state_read(inode) & I_CREATING;
> }
> EXPORT_SYMBOL(flagvar);
>
>     endbr64
>     call   22c9 <flagvar+0x9>
>     movzbl 0x91(%rdi),%eax
>     shr    $0x7,%al
>     jmp    22d8 <flagvar+0x18>
>
>     endbr64
>     call   699 <flagvar_de+0x9>
>     movzbl 0x91(%rdi),%eax
>     shr    $0x7,%al
>     jmp    6a8 <flagvar_de+0x18>
>
> Was that always a thing? My grep for '!!' shows plenty of hits in the
> kernel tree and I'm pretty sure this was an established pratice.

It depends on the data type. The non-not "operator" converts non-0
values into 1. For boolean values, that conversion is implicit. For
example,

  !!0x100 =3D=3D 1
  (bool)0x100 =3D=3D 1

but

  (char)0x100 =3D=3D 0

Andreas


