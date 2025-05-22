Return-Path: <linux-fsdevel+bounces-49686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42FAC1074
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B11C00121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95529A33D;
	Thu, 22 May 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcBRbc91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D0299AA8;
	Thu, 22 May 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929364; cv=none; b=LLotqExZ+8CCmo2yp4krjatxv4sBpShJyyJwqjSF8ED7FBfwkqi/2TtGzzZ4UESHgmtaYYcCkhjtKS7ST6KHeirVmpnmc8Gq3WVooHYWarJmcv+pdp3RpG7e3MGWLAGU0paxB0XiCv/OQOAo1b//1sa3FdmI8RsaCNfK0O17ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929364; c=relaxed/simple;
	bh=A4J+qQeo8FojNZDrm8K6UkrhE2Rb/ECmA/pvJXKHIeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayD5lBDUem++L/42dU//e/z74qc4CANKt1VMo9IjZms4Sc0xS6k0r1puuJzjcX4kJezrNMalW32X6NNYehX6UjwWqHxyHNb4TZFZF+46mbi1AzTQCZOaohAYwgG2GsL4ucsdooyWy8AVLQzkaGeiSc2HZykIbYK3qhGJS+rGSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcBRbc91; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad53a96baf9so1025280466b.3;
        Thu, 22 May 2025 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929361; x=1748534161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4J+qQeo8FojNZDrm8K6UkrhE2Rb/ECmA/pvJXKHIeg=;
        b=mcBRbc91IPJbfIHD3/GQRq9UaxQF+0/Kp6yErbzv92rSFkKBEIgm+AD++hqoMQx6GF
         FeZO3gnPWnkuqkp8lJWquaiNHbhEPC4oFiFwusBzFZErslOznoRgbNf6cRQsSO4Ew5OO
         MHwP20nMO8rXy1l+6AbpTWaBnKLDykLgIzbY3x54XUePAkVp2Dw5OOeqUoVvXGYebC47
         LDnBhug8KgrNMX1/Im4tamBuU733pS77MD2KrTWzq8ZXHsFW0cI2kvAvL8NvRT3fwcRf
         ORLSKJnCE2w+TZ1T16sxvaaTE05hJTgccFXAOix1DMPJv2G0ylT+0fIWIpRUZy/5Ak9J
         Owdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929361; x=1748534161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4J+qQeo8FojNZDrm8K6UkrhE2Rb/ECmA/pvJXKHIeg=;
        b=uC0SiBqatr10fBQJ5+tNj3hzSX1Z/Ff2mBOHZFP+2ApyX9EIrCHtmeBTHHBn0t1zTx
         QIvfczWYazU3s/LPIck8Yn7LaxepSBd5q+xCpUSQTDp9+IQX1B0YrlWam3/NFYRN6DJE
         HRNulr3IxuWdNsTnIfTclem3brZmZZdPSNtEvaKn3SMaM2PJM5okMStq0Q9pn71KISCJ
         gBlyz46Ve/UYFCGK8KsWL4jsDAo1e3WsrCfxWdW8HGS+JfcFOL6HqVV1Y32dGwI7TdpT
         0JhdJkiSnvXgclGNGtdGxclYKaXX+/tnT0jUF7cPskM3ktegp14L+wOz/iHK1Bx7GKlp
         I41g==
X-Forwarded-Encrypted: i=1; AJvYcCUcYZynevWKQmGbD04ZCpG+iUms5X4EqBAo3XMjzArHwH1FUrtz6DWRdK/BD8U3JrvD5jG2TQ0IRt7l@vger.kernel.org, AJvYcCV2j9C/Oy7pahQud8Zjm9BVoS4UmzkLIQUCpponNhyCxRoMXcZWbjJYPvIpA+18Fws0bqm4BCqeK1Y=@vger.kernel.org, AJvYcCVm2osReLqydd+pzRubxDDDxU7rddrx+5cOrA8Bt3b4EQvA5rEwSmx2NcAp+MWwMRgaDrAJgqaRMPOLDZ/Bhw==@vger.kernel.org, AJvYcCX3RD7nwUTHg9oyPbRkGvILv69/1DZeM32LxL7b3JScRbAj5GeZLl1+vm3RvPKzxsZNAGN9JasYdnL4Mvq/@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVJHYAQuLPP9x8Z34w4/eilhJWDns81ygOdBZNgHCDyDgYAya
	LVqP25HnvR2c722EYZVKucuegiPdMzGjmpGqZcZxzBBzyMi237/Bekin7sSRPhhChYC6tuJQRMH
	xXZrnANtb8roUJ5koKp7D5V5/1+rQdwI=
X-Gm-Gg: ASbGnctcUhhF08o2zmB49Gv9hVadYD81jtZqQsfY/3ciWgGo16lmZrZmg+UCHwJHq8P
	b3o+raUJEIKEcET1RR5+I1ZbpLzYs4AfKbWima2acOQxY5RMVRhLSNKObNoScI3wBW2+iXm+MrB
	Lw+Qh8cx+0xIw+IVdjD3uhNAsLngb3wawI
X-Google-Smtp-Source: AGHT+IH6QL3rTW5k/XBVsCAcYeUMdtDIv0Z5CTpmk9yXv5afLUYePNzV48MFbmXlyN3ijm1K7kXjZ0FhjF+aJ1p4y4w=
X-Received: by 2002:a17:907:fdcb:b0:ad5:52a3:e358 with SMTP id
 a640c23a62f3a-ad552a3e5b3mr2046292766b.49.1747929360593; Thu, 22 May 2025
 08:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <hobxhwsn5ruaw42z4xuhc2prqnwmfnbouui44lru7lnwimmytj@fwga2crw2ych>
In-Reply-To: <hobxhwsn5ruaw42z4xuhc2prqnwmfnbouui44lru7lnwimmytj@fwga2crw2ych>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 17:55:48 +0200
X-Gm-Features: AX0GCFsIIcsMi4HVgfhUZ-aKlbSmC6wfuBA3UyRPVDwUyb5pOFwqCosyJaGAPEw
Message-ID: <CAOQ4uxiNPiT5=OLN_Pp695MPH=p7ffoLm8hEQ4S637RSYZz5gg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, 
	Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 12:30=E2=80=AFAM John Groves <John@groves.net> wrot=
e:
>
> On 25/04/20 08:33PM, John Groves wrote:
> > Subject: famfs: port into fuse
> >
> > <snip>
>
> I'm planning to apply the review comments and send v2 of
> this patch series soon - hopefully next week.
>
> I asked a couple of specific questions for Miklos and
> Amir at [1] that I hope they will answer in the next few
> days.

I missed this question.
Feel free to ping me next time if I am not answering.

> Do you object to zeroing fuse_inodes when they're
> allocated, and do I really need an xchg() to set the
> fi->famfs_meta pointer during fuse_alloc_inode()? cmpxchg
> would be good for avoiding stepping on an "already set"
> pointer, but not useful if fi->famfs_meta has random
> contents (which it does when allocated).
>

I don't have anything against zeroing the fuse inode fields
but be careful not to step over fuse_inode_init_once().

The answer to the xchg() question is quite technically boring.
At least in my case it was done to avoid an #ifdef in c file.

Thanks,
Amir.

