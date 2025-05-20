Return-Path: <linux-fsdevel+bounces-49499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1357ABD84A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EB81B664D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C41A314C;
	Tue, 20 May 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4nCJbdO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B2DDAB;
	Tue, 20 May 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744822; cv=none; b=jB6f7PiPktb0XRSAOtAO9diTL4MD10AnnXU81j4K4LqMekHjr0T5jeBabkDPBaWzo70ZUyUMzcJNKEMKBiZKLkYOd5Ek10AmmdcH7pc3nQSo3R7BvvqCIvrKx5qTHvK7f68x3KSapaVfCFpVGcXxPBlFhQqrlnOOkS7O1Tk+qN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744822; c=relaxed/simple;
	bh=ATYacQzOSN+D3qKstMSJ9/0jNFcPqEoH9o4IEJcPRjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta6JVosucHNO6NwTPaNSK4aqupNGAlX9liGx0Pw/n0Q0ih2AVzMTQCr2gn8nhiWFepH7Nwrbm4Jm9uNkif/np77JQSWOtg+XOplYthyn2Pq559l9JmOAVCnNqdheYtyHcvpGT9Fo5z3xFE2vBmk7Nmo2SNSUqnFy5rY+aIjvWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4nCJbdO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad572ba1347so269487066b.1;
        Tue, 20 May 2025 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747744819; x=1748349619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jl+c2q+Ung+HT/OYN3z/VcGpR80c0US6Yin5H+E6eI=;
        b=L4nCJbdOsRcn/7KQPVzMAq3Cn/eq2CcTmZOyCguLrL+jvg+Vm3OddiRFT+c/9RdEWB
         zDwm9T/qBxq49m3RcuXBuuKi/p8uQ+UmLnYY0oS45D7yP6CZ9BXvTzEkV0ozq3zkVoVy
         GyfA2K3Ya5EXffR6riIvvf6uPiKd9xoUbc8BBw4O7pPwzxcaWX/OgXoGZlja4XXAUNP5
         37svqpDQy3IUreTdyTOaVciRp06jgWnNXwhMYlxU/0HWAGdgSADqukRSxHPRbtpKTEyj
         f6WSWNT5+XALyzlVeP0J1Bi90iZiPz9ER3qra2d4Fr+USVVTHB+KndZilQfxlH2QMmYb
         E+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744819; x=1748349619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jl+c2q+Ung+HT/OYN3z/VcGpR80c0US6Yin5H+E6eI=;
        b=pO+sYHtkUIfBJAYHNtJ23eSZJQ9aM2JbRvHjnhr7Ph+ra8n4+lzzyf0Ngc6xm9NrVp
         84LRbENX6fUuEl2KBjc+caq3TIr2uoOeDUn5hsU4cx7BxThYmdgthNt4yaW4/TmgCG4V
         QH5G0TTF0iMCBinukZhcxgjKQeodIhNKm+a0veZ0WRQe3RXAPwWOgml3lTEMCyNscPU0
         2ecwCbuBHIvf5jAPeaup18WGDOmPEFpyMrxQu9V1WhebX7tslnKlH+3kP0EVnYGSUOE8
         r/XDoAsRFiwLzJuuQY0fM05wkXiNuQCgSyCQ2QviTAolCqOU4PLed7yD5/Oe6R/RdS2W
         U8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUTzHKy/90tqw3RBeBVoRUDNjWndtZtllW3rqqbujCT1nTVBesJZeCLU+LmdHLFJdnces6ZH8EO0voD6RUXJg==@vger.kernel.org, AJvYcCXNculZJ+6NMNgTM50QTEsOudknd7WAPqy0KitrN0gWsx+L2vze+2RTjkf9oQPFF7i1P8aPdR8tsUutu7Va@vger.kernel.org, AJvYcCXVdScY+19jmAXCxVrVtTsVtbC2EOq/tDHgfeDiKvnJq7tcUsx4jtMhAm4JrbxGjz4MCM3cZHpeoSZ1v/17YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPEgcOKopVkYW7KWth0ioUYJlLvIKrpGloL7EahTPJjG+eQTg
	uY5uLapX1xZRZCENS9D8EA4tjr1Bz5cj4ZLmbhjc8jlMGJgui0foo8Kp51/nEe47j/cAl39mCuz
	/Dp8HokGDRsHfj/HtV04ohwBwFzrvwRw=
X-Gm-Gg: ASbGnctbQZxO0B+Q2J547l7Hb3x9FyHViz4MqiFfKmVRo5EHXGwjhKrT2JhzfPNcZ74
	br2FMsU5vxfed2NWH9yK2n6W5/CRuXBx3nal+sDtCNy7KfFPLpo5FolYP1VUfrfXjn0l3FvW2E1
	fyrX91YrLfGRJ+A0W/nqVl4hDUUDcMJoVW
X-Google-Smtp-Source: AGHT+IH5bUvnBxRxXybMjRDoEeYe3bPA/LSHsUGIEwJlRwCiBFI36+/QdNM/UouWlg6Q+ELdsoDk7HXXHta80d4O7yI=
X-Received: by 2002:a17:907:e915:b0:ad5:1e70:7150 with SMTP id
 a640c23a62f3a-ad52d443a03mr1516742866b.2.1747744818984; Tue, 20 May 2025
 05:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com> <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
In-Reply-To: <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 May 2025 14:40:07 +0200
X-Gm-Features: AX0GCFuJIxA9Wv-He4w9A6tRHOYc4zkEtD6DXI93Cz2XPfD5o9cWDaYraN4RDjc
Message-ID: <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:25=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
> > On Tue, May 20, 2025 at 7:16=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > This series allows overlayfs and casefolding to safely be used on the
> > > same filesystem by providing exclusion to ensure that overlayfs never
> > > has to deal with casefolded directories.
> > >
> > > Currently, overlayfs can't be used _at all_ if a filesystem even
> > > supports casefolding, which is really nasty for users.
> > >
> > > Components:
> > >
> > > - filesystem has to track, for each directory, "does any _descendent_
> > >   have casefolding enabled"
> > >
> > > - new inode flag to pass this to VFS layer
> > >
> > > - new dcache methods for providing refs for overlayfs, and filesystem
> > >   methods for safely clearing this flag
> > >
> > > - new superblock flag for indicating to overlayfs & dcache "filesyste=
m
> > >   supports casefolding, it's safe to use provided new dcache methods =
are
> > >   used"
> > >
> >
> > I don't think that this is really needed.
> >
> > Too bad you did not ask before going through the trouble of this implem=
entation.
> >
> > I think it is enough for overlayfs to know the THIS directory has no
> > casefolding.
>
> overlayfs works on trees, not directories...

I know how overlayfs works...

I've explained why I don't think that sanitizing the entire tree is needed
for creating overlayfs over a filesystem that may enable casefolding
on some of its directories.

Thanks,
Amir.

