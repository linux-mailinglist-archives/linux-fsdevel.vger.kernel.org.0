Return-Path: <linux-fsdevel+bounces-34565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4D9C64EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4878285E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA021C168;
	Tue, 12 Nov 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnHJGbz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC421A6EC;
	Tue, 12 Nov 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453016; cv=none; b=pOBvKb3OSSHD487Y4EPcOnCoOD5Xxy6MQv4+kqElYP1QdFDTzdTvjnl7D+D7clXM+9XL56+G0zmTUJlGpAVHvaAzxZvgeJW7cOOxXg4ESKxgXnWPOqQgToPkPd4QHHkcIX/HvAgNnrWKTc/HeK+CL2hbM98A+af7pGT4Tixgo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453016; c=relaxed/simple;
	bh=+/GVDHlhcxMMbbyhM88+h7i00DClk7wy+rPYrTySRB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quQpmYGCIBEPiiorWswfrq/sykYoWZXs7E0ZGOXKzNoCGharhsxFLoB4ylnbUujXFXkp8dv9iYeQL15lDBWqoVC22MSLugIoix8em1s4aN6rpFg9kDaTJ3TZYsRjf8ZAcp8+7Th4O2U6L9su8bRHN8JK6awIgQSmhGJ4dMji/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnHJGbz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11487C4AF0C;
	Tue, 12 Nov 2024 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731453016;
	bh=+/GVDHlhcxMMbbyhM88+h7i00DClk7wy+rPYrTySRB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NnHJGbz6uGLEcym4/th6ycGiqotcUpQbA6RiHYEYFMeg7eVH0zCCEEqQUJh8G2gOv
	 U1eseakEvTh5Dn1SaRAjkQtDbugdiXFPniSuZoJnZzeyxqbfsGZeKdtz74ETACbh28
	 IADSB6ns4f6h1nl+wWBrjtYsuYoCoiIV7NZbf0ZKGeetR4/BaLrXX8k16m8nDwAhWj
	 4Bc32NySndzg1IuZlhqELOcFQO/lA7k2at1mu90MhfZAE23X6E+HGSR7JvgccJmaFy
	 3jZQIAiwLGQnTXP3JTFQk+0S4dzTTfTrZorcmQDz2qqa21AMja273/Yg5yA4tTEQiP
	 tbs/XqP0CDR7w==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso26577655ab.3;
        Tue, 12 Nov 2024 15:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6S0SMQ/YnypMBySRdkQM8QmUsSiCaGIun9rOdGObyk2qwRguAQMn/VI1r66+cIhuQrVUVp2+H/EUCANrGMAdN7PZWBlkz@vger.kernel.org, AJvYcCUPURv+4qdedeIeRbRJP+nx1BxHMKpSJfDA3nfOnAA2KHCONNE8kwQp9lVZ6/g76Ns/UEKyKkWYivBNcGKn@vger.kernel.org, AJvYcCV8O9MKWgiMNE5J1Nc2DBwSoTgL6kEXbdWnDg3EZLWLVnQOYNx0hUtEVKmSR9Js34Lr/2iCbINrwJ+56aGV@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6UPCmPI/S64loWU01HrQ1qAu+0q9unl4g4Gqg2Hm3wzcTBVY
	c+7CuiciiGTGX+o4bmJhkM9K30WZcmzvMWw3B7WoFC5L3Vci0BZe0/NWRDBpUvgkjTLduWJaRRE
	EtknOE2A7JDG5gaLOcsMADFFLUHw=
X-Google-Smtp-Source: AGHT+IEXmhz1rxonQxVF9WnrvL5ssfbjegUNS/LxNPZajWMp4pzlmmyDv6Gn+IormVUzECKOO/t/JZ3mNxf/pFz86cs=
X-Received: by 2002:a05:6e02:1a43:b0:3a6:b258:fcd with SMTP id
 e9e14a558f8ab-3a6f19a01c1mr198967205ab.1.1731453015412; Tue, 12 Nov 2024
 15:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112083700.356299-1-song@kernel.org> <20241112083700.356299-3-song@kernel.org>
 <2cb0cd4f-5d78-4b7f-b280-2a3377ffbc21@linux.dev>
In-Reply-To: <2cb0cd4f-5d78-4b7f-b280-2a3377ffbc21@linux.dev>
From: Song Liu <song@kernel.org>
Date: Tue, 12 Nov 2024 15:10:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4xEOhpU87kGvO45TBW0aLwCKvFi9hRfJ90FgGUq8OAcA@mail.gmail.com>
Message-ID: <CAPhsuW4xEOhpU87kGvO45TBW0aLwCKvFi9hRfJ90FgGUq8OAcA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:00=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 11/12/24 12:36 AM, Song Liu wrote:
> >   void __destroy_inode(struct inode *inode)
> >   {
> >       BUG_ON(inode_has_buffers(inode));
> > +     bpf_inode_storage_free(inode);
>
> Not sure if this is done in the rcu callback (i.e. after the rcu gp). Ple=
ase check.
>
> >       inode_detach_wb(inode);
> >       security_inode_free(inode);
> >       fsnotify_inode_delete(inode);
>
> [ ... ]
>
> > @@ -136,12 +119,7 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *=
, map, struct inode *, inode,
> >       if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> >               return (unsigned long)NULL;
> >
> > -     /* explicitly check that the inode_storage_ptr is not
> > -      * NULL as inode_storage_lookup returns NULL in this case and
> > -      * bpf_local_storage_update expects the owner to have a
> > -      * valid storage pointer.
> > -      */
> > -     if (!inode || !inode_storage_ptr(inode))
> > +     if (!inode)
> >               return (unsigned long)NULL;
>
> There is an atomic_read in this function:
>
>         /* only allocate new storage, when the inode is refcounted */
>         if (atomic_read(&inode->i_count) &&
>             flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
>
> If the bpf_inode_storage_free is not done after rcu gp, this will need a
> inc_not_zero like how the sk storage does. I think moving the storage_fre=
e to
> the inode rcu call back may be easier if it is not the case now.

This is a great catch!

I will move bpf_inode_storage_free to i_callback().

Thanks,
Song

