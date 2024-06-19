Return-Path: <linux-fsdevel+bounces-21916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9462B90E7D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A559F1C21883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBB824B2;
	Wed, 19 Jun 2024 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgCB0dWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CB7EF10;
	Wed, 19 Jun 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791563; cv=none; b=ZsuKkDXGDk3/mxSSSaSdkbKKP7iymkipdz84KXK8W7RH0rgpoGzZhVebQtOnG6YDxkmNVrZODngEA+x/Os00OvaPaNv9PwnGi6x3lv40PLZd4p+1IQaHLVmjFCIu7I2fdEvtIBXNb9JtGtpT9FpyEmnwK8lP+AjjWFRV9sf0ZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791563; c=relaxed/simple;
	bh=M8O2ZleOspcNvXLIPxKWdRrT+5epAIdqSMjAu1gRlk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xy/zS53WCDVQdWx2t0BnIHqSNV2Uj9QPvCYTY69nYdCrqGYvh1IT8FiAgzc17Ce+uJNzgWXf8sujVGycLz84mkTeEyVN2YBL4GjqwjQ7+Wbq/M04a+L4lXzPPfII0JJte0W7Jyjvl5VJYrxMguuhaD30+yDimYI09TxIqEv4SFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgCB0dWH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso7368501a12.3;
        Wed, 19 Jun 2024 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718791560; x=1719396360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGVdWJRxqHq1+ANBeJwa7C5d0bUBnLj7/VyDF7sqFco=;
        b=dgCB0dWHeaImxXdS2i+J+XZsTl6vrasHwd4soKb49G9Q1ZQruA0WQWwi29UE80tvJM
         9g9U6Z4NVECrN/JaHJeVRyA7j4unPxV7d1r8buxN1M4NxpHEv/vgg+bLJ6SPJK92InN6
         UG0yKcZZrYDrK5xovaqNcMxu9LAjdNTx8gUYbbxpEu5myhcnUpTtVwNWD4SHzQK8eN55
         5bxMVdSeQrJL9WVCejoaUn+I8+gY0iclx9NZ+LCpZurfRxircq0BYkKNa792zliDLgBh
         ZcZRnNpor/zUnV6srxFny75Iv+lkLhuXH5z0vw5LiICoYqad9H6JNbLnzmxHmspB+XBn
         JJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791560; x=1719396360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGVdWJRxqHq1+ANBeJwa7C5d0bUBnLj7/VyDF7sqFco=;
        b=gLATUk6sBBNw98mVKGwfwATg8ep8qnr3nABJOMaOaP7sUwVzRu+ULfxD7uUeRne5KY
         aP1s+BfLuN6VbW9BD7kdZyFi3bMpa8cuWxGHQKr8zMGPAD11lqypT/BDeC1XR/129gFw
         3nQQV+lDZHwU9jLOuff/hBSLH9u08s6yMeL4y6UfDgTomyBpLVEcx5jwWAeQV1InE26Y
         RLS1moN0QtsZPqhIYBsh4OHEwG7YVbdHEyK+0oElkzamsiweWRr3rUL0IwkCvjD0FMU6
         ceWV3nXMMrxQkmObtU2v1aBV6Nw93w9oVQQMsElpbwZ+DZC18OTp4P+YzMsqklERtFvz
         xUPg==
X-Forwarded-Encrypted: i=1; AJvYcCWU25GyXH3zXdah9voj6NvGjPCaeNIXRxF/lhyVACZwCAkwF2l17ons4l/yaPekCmC0HLg8NjbzMMT/AQmDh4LlKCqNbyT3OUmkNBg1LERiDNOr8/LQIHLkgdQ3NHEoURZqbPNz4ZA7Vg==
X-Gm-Message-State: AOJu0Yz+tEQhhd16+z7jtelD+cN/fI1JEeaLse+2dHbeztu3k+oyg6VE
	bS6+Ej1YZhE1ItewVJSZ2CAFvw+0UD/WE/iplIZIFPJ5et/dCUzeoAkpwIJvnj8zDHWV25j7sNA
	OjQM9BAMSnbxfMfnick6pn21JWSc=
X-Google-Smtp-Source: AGHT+IHUq7SUykk6pc3JEyx6NeJ12PYNSLlfOm35nDTu9OogrfcQKJFOTmUs1fR4OkynF7fhrU+7nhrC7kJ2OVrAf94=
X-Received: by 2002:a50:d5dd:0:b0:578:649e:e63e with SMTP id
 4fb4d7f45d1cf-57d07e43795mr1072199a12.16.1718791559826; Wed, 19 Jun 2024
 03:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618113505.476072-1-sunjunchao2870@gmail.com>
 <20240618162327.GE103034@frogsfrogsfrogs> <CAHB1NajUvCmPK_fTVgpdXz--Qn69Ttx5W4k9Xbq18MbarzUfVA@mail.gmail.com>
 <ZnG7DJrVov5n6O5m@casper.infradead.org>
In-Reply-To: <ZnG7DJrVov5n6O5m@casper.infradead.org>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Wed, 19 Jun 2024 18:05:48 +0800
Message-ID: <CAHB1NaiSX6R3Xyem2XeNdYa3bM7WPyOqbOfiQ7Z7jhgqU5idqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] xfs: reorder xfs_inode structure elements to remove
 unneeded padding.
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chandan.babu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=89 00:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 18, 2024 at 12:40:23PM -0400, JunChao Sun wrote:
> > Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=BA=8C 12:23=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Jun 18, 2024 at 07:35:04PM +0800, Junchao Sun wrote:
> > > > By reordering the elements in the xfs_inode structure, we can
> > > > reduce the padding needed on an x86_64 system by 8 bytes.
> > >
> > >
> > > > Does this result in denser packing of xfs_inode objects in the slab
> > > > page?
> >
> > No. Before applying the patch, the size of xfs_inode is 1800 bytes
> > with my config, and after applying the patch, the size is 1792 bytes.
> > This slight reduction does not result in a denser packing of xfs_inode
> > objects within a single page.
>
>
> > The "config dependent" part of this is important though.  On my
> > laptop running Debian 6.6.15-amd64, xfs_inode is exactly 1024 bytes,
> > and slab chooses to allocate 32 of them from an order-3 slab.
> >
> > Your config gets you 18 from an order-3 slab, and you'd need to get
> > it down to 1724 (probably 1720 bytes due to alignment) to get 19
> > from an order-3 slab.  I bet you have lockdep or something on.

Hi,

I couldn't find the exact 6.6.15-amd64 kernel, but I installed the
Debian 6.8.12-amd64 and 6.1.0-21-amd64 kernels, along with their
corresponding debug packages. In both cases, the size of xfs_inode is
1000 bytes. By eliminating the padding bytes, the number of xfs_inode
objects allocated from an order-3 slab increased from 32 to 33.

I'm not sure what specific differences there are between our Debian
kernels, but I have submitted the v2 version of the patch. If there
are any issues, please feel free to let me know. Thank you!


Best regards
--=20
Junchao Sun <sunjunchao2870@gmail.com>

