Return-Path: <linux-fsdevel+bounces-60651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3859AB4A92A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA5188A321
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910142C15BA;
	Tue,  9 Sep 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGOpn+Np"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A72D2495;
	Tue,  9 Sep 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411847; cv=none; b=rjsdNi7UosUyMegjeP0Emk63xOsmzbBFCMBm/CxQFHudo7PSGyHCh1g+umy/gV2e7/h6vt2Pa4ozwCujrH5jDefM+m3SqBBR7C7Wvc+P81aiZKl3UvkvQSsjSYP2xh0uwMgbw5KgKPoWDvXctOP19d5tiahj2Uu8RilPPCmaJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411847; c=relaxed/simple;
	bh=RAE17ZYZWlIDCZkrsAY+6DPY1arC89Zp2iFLktMJp94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M82jEnyv4sV8I/pGuhsmJNx4D5d7lTpE6Q6J80jBc67U+5JQeMzVpHs5nA8qoVXprM3X+ILH0xtzDSSu93Mp3rlpvAMRgoI3kVT65V3kT6UL/1gXV4TnkuQmG1bfBcblhUs2dWeBSHOTcd+6E8Y62vCgvP5yGvW01MfOgYBrMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGOpn+Np; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6229f5ed47fso4520830a12.1;
        Tue, 09 Sep 2025 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757411844; x=1758016644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAE17ZYZWlIDCZkrsAY+6DPY1arC89Zp2iFLktMJp94=;
        b=nGOpn+Np5D79mys8CaDDfxpy+EX8DVgSSzB+pU72mfTuSY/1z08YRp9QCjG5GnAtwA
         E6NHkjaBBgbkoIAGinDvHm3s28CTF3YhxrP963WMbTD5XBFY88/pDz6MDPj0FXjQE1uf
         +J/DvVecGzFtQjJUwU9TdARiYUbu/tYo8cC0uCgQL1f9zPXo3eRfPN+VpfGkzjD1r7sd
         BjfZPkO1nJAmopkd5BI+Vrq000iU9ATEXZiJ5apnxiepoVucTzjVGbuHHQrO5FE+s+xB
         otNjSljAY1Fkiv65gYEr70AHvtF8J9JgzgdfThWZmxAyHXv8tXqJ/jzk3IIrEoNsJL4N
         NOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411844; x=1758016644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAE17ZYZWlIDCZkrsAY+6DPY1arC89Zp2iFLktMJp94=;
        b=sB9IFwLs21+0qGu915SweMml6JBC+IyHvU8qfD8xDHRJnv1yFnlerRsKfYnhy7S2+Q
         X5jCACtI/z0F3ZiFozfGEOKDUf93dCZU0BEuK5KWnk4edIi4gS5MvQLQ0bIBUp1CLVCL
         KXmkXEvuAangbT4VfXdOEHSo7mxk6zgzWQ/tKBQomR1pneGvR/PAK9is6fd+LSEv9kUw
         ixZxEQ4iRIhu4tpXuK864tXORaEGBSAVk/palqg7kSbhn2/mZcpiN3076cIM85fujGVo
         FHOiyPuoEVf5kUXtdLVjxTnplFv3jL22ms0mRK6YjYgJ+wd5cNIyyNguXskDiWMtwOhQ
         E6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAzGwuiYALdko6IZOcsQaB8FYMSQExqN1znXBAHnoPhceLus2JP13a8X6UuoL3IdjHe0gFvklRnntku1D0@vger.kernel.org, AJvYcCVNUmwW19jurU2e/7DSUI6xfmB8tb/yS/T5v0yAYVN6CK1yzS8a2XhTWyLa5BHnFB/E4DK21UOOOoqN0VP0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aBZGD7Ve0nMY+WnXNVITCYglcNVYn6e90W/ZXFflIwLQCHNd
	ckAv1VUklcba46vTrlUosj8Tb/wL7hxqfaM6lGXwOBaGJWUmpZ5xHu7diR/qdLSU0w4MB01SoOf
	Ao04VGbYlGOgW+/kGxZUJmKiiC98/Rvo=
X-Gm-Gg: ASbGncum7aXoo7eLUxXGeadHvm/YFWNZ6CR37ayjBFJLqOdPsAZxhnce00SLoXTgxI8
	3bLy3tZJTZ35XcCkvKhJccs65ho++xu+IKKmOz81Vnr22zYwS4HbFxi0TSkOsEkzKUX+F+SvXoM
	bzCiuGHhyn+BvtDCFapzvW4/c5dqqgu5sXXsqMBN8NjptsICirY7zqzEKIzJeC66vc5xdzA+/Kh
	l3sFXc=
X-Google-Smtp-Source: AGHT+IFf/ZoRT5HaF6kxr9rOT2RZ/8rZlOcLf23MX89bg8+alXq2taVr5i1vpDSwq2raUZjmK7nkmcK3Ji+N/jYHCSo=
X-Received: by 2002:a05:6402:2794:b0:62b:2f0:974f with SMTP id
 4fb4d7f45d1cf-62b02f09bebmr3813819a12.15.1757411843927; Tue, 09 Sep 2025
 02:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com> <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
 <CAGudoHHT=P_UyZZpx5tBRHPE+irh1b7PxFXZAHjdHNLcEWOxAQ@mail.gmail.com>
 <8ddcaa59-0cf0-4b7c-a121-924105f7f5a6@linux.alibaba.com> <rvavp2omizs6e3qf6xpjpycf6norhfhnkrle4fq4632atgar5v@dghmwbctf2mm>
 <f9014fdb-95c8-4faa-8c42-c1ceea49cbd9@linux.alibaba.com> <fureginotssirocugn3aznor4vhbpadhwy7fhaxzeullhrzp7y@bg5gzdv6mrif>
 <CAGudoHGui53Ryz1zunmd=G=Rr9cZOsWPFW7+GGBmxN4U_BNE4A@mail.gmail.com>
 <tmovxjz7ouxzj5r2evjjpiujqeod3e22dtlriqqlgqwy4rnoxd@eppnh4jf72dq> <CAGudoHHNhf2epYMLwmna3WVvbMuiHFmPX+ByVbt8Qf3Dm4QZeg@mail.gmail.com>
In-Reply-To: <CAGudoHHNhf2epYMLwmna3WVvbMuiHFmPX+ByVbt8Qf3Dm4QZeg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 9 Sep 2025 11:57:11 +0200
X-Gm-Features: AS18NWDvNMnekQfsZG-s3JBWxVpGxDm3JdJDNsFjC1VMfTBR1aZ0-dcOy76lqUQ
Message-ID: <CAGudoHEBDA1XKu8WTPQ4Nn+GTUWg_FMUavcAddBQ=5doY1aQxw@mail.gmail.com>
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
To: Jan Kara <jack@suse.cz>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Mark Tinguely <mark.tinguely@oracle.com>, 
	ocfs2-devel@lists.linux.dev, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jlbec@evilplan.org, mark@fasheh.com, brauner@kernel.org, 
	willy@infradead.org, david@fromorbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:52=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Tue, Sep 9, 2025 at 11:51=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 08-09-25 17:39:22, Mateusz Guzik wrote:
> > > I think generic_delete_inode is a really bad name for what the routin=
e
> > > is doing and it perhaps contributes to the confusion in the thread.
> > >
> > > Perhaps it could be renamed to inode_op_stub_always_drop or similar? =
I
> > > don't for specifics, apart from explicitly stating that the return
> > > value is to drop and bonus points for a prefix showing this is an
> > > inode thing.
> >
> > I think inode_always_drop() would be fine...
>
> sgtm. unfortunately there are quite a few consumers, so I don't know
> if this is worth the churn and consequently I'm not going for it.
>
> But should you feel inclined... ;-)

Actually got one better: inode_just_drop(), so that it is clear this
is not doing anything else.

Perhaps something to do after the dust settles.
--=20
Mateusz Guzik <mjguzik gmail.com>

