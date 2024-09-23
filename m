Return-Path: <linux-fsdevel+bounces-29910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D5E983A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D623B21E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE912C499;
	Mon, 23 Sep 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evVPFWek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4986131;
	Mon, 23 Sep 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131315; cv=none; b=ignUh8w+NLid269RB8YTmFjbXu8RzH5+iznpy3zq5ihWi1y0g4ia1lec10fg2x3Bk/j4DVxTn2zXHktqid5WjK6Af9oz/SjuZ4Xj4QfhVAdVqFre9SeOimB34WVn4GSLQRpuFBDM92ypsCRiqWhnql2viD+g8rJh5llHpM31hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131315; c=relaxed/simple;
	bh=DKxVsqI4h77W8oz4OPBGGZ2ao2HAHSeda+wfpF76QE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW055XuqUiyDC79bYG0G1V9R4BITXSeF2VJzUP+SasdzmipmCxs4RrUpLQ24dhKrtIc1WJ1cELWJBiJUhKpnLPlOB9xXeQ5w5BBkpyLMbBGYZrTwxnzF4DlTPcSUHbUFSQVRuN+6Kqjxsdjv5IM3ssnRMCI0dh61pcld+HLDYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evVPFWek; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5356ab89665so5764513e87.1;
        Mon, 23 Sep 2024 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727131312; x=1727736112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXtpj3oKM4ibzRsWBeP6PGcZJAeCJUtVQXMOUbE9ruo=;
        b=evVPFWekPcFLOyWcYr1zkd9g8yI3DCcUBp1eYRXwn/dSGgAZchS3P4oDK6+v/haouJ
         /iufklCWgxnZi+4ZKszFSQd+wlIwEJJGgL9PBWPz6VoK6h4gwdi6ORFz7rINPPA4XgQY
         2F0ydzYrxrA3hOAHLyD9RioyXCDx/We1DqxQFuAHLhNobV9tFbdtNORhb5LX8UlAJjj1
         WKA9Jrm/MKtSIpR+SESh9D60ejuswuUOP6JsAyj0aELZGXsTZlUjWoH5cB9KhTCcIvQg
         kNvI8bpQrrzbiKpWUD4iG4Jb7qBwvC+NsrSZXDNo66Y9djBa6z+BesuGEnm0aATxiQHU
         CzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131312; x=1727736112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXtpj3oKM4ibzRsWBeP6PGcZJAeCJUtVQXMOUbE9ruo=;
        b=UtcssTXcgBKLgnqb69UxAmUdVpje2sANzp/mLnZw4ZCAspY5Ba2ZY6mwTx1hRYfsei
         sAzfzUlme1f69DN3wwWi7+9O2SUEZIn3fItGGqSZescee+C/qk7wYr3BH9iNv0KhGmFU
         C+7IorNr+KmdjFpreAxL/irr8XlQwDyE9i2S5OeYCJF5ZGQW4g6jTFCPH7oFBAtEHKoV
         TX0+dC7lgoavCdnqPdWDrX/U0Bn2KmHGC2wc400KDKGpdzYTVBRVr2yQMH+jlXxGdsha
         BHuftSfDDnsFN8QLzEkVo2gIT5WUS84xiHBoRNdhTdcEIoiH0sV4He/r9OERam88cw6m
         MLDg==
X-Forwarded-Encrypted: i=1; AJvYcCW/dkO3gwBbiTk38YHYK7D06GTVNPcgRS1cjVmtItHQ1/0MYSRhv5nGyoq4PQVu3QmdfbQwrCARS3jn@vger.kernel.org, AJvYcCWeBtkBZe8hMfSGH4l3I8XVnRSelWaes8Pozr90nPGq3r3eymq76OVSFClEOChzSEArOsw9TnV1w4UC/wAdSw==@vger.kernel.org, AJvYcCWonJ8g/TUoUXHSLRAz66VkHZGA1oLEwSh1DydwO16WWDLEB5g3g1qndZmolW9e1bLTw3liTopN6K5zQPPB@vger.kernel.org
X-Gm-Message-State: AOJu0YyeSKgEyca4UO86s7bASf7x5trEFLzYPV9VfVR0Vm89Ww18EBm0
	BcugTTsBN00kkhEYCR6S9jChmudPSgoJkKl1e0dguntNDyR8mazE0xQh4Eq+4+NkQD5R+FhNe+g
	YVI8rqXO+/1Uvg6E+zRLGtQRDxU8=
X-Google-Smtp-Source: AGHT+IEuyM6K1Mxszb0GP4Ue8emNvrVXI9jx9caANbmOkUNSBjPzbcALoMwpZFu5YLbqb2qx8VsIIWd5xpcoly+2giE=
X-Received: by 2002:a05:6512:2356:b0:536:9f72:c43a with SMTP id
 2adb3069b0e04-536ad1914cbmr6531368e87.36.1727131311369; Mon, 23 Sep 2024
 15:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2390624.1726687464@warthog.procyon.org.uk> <31d3465bbb306b7390dd7be15e174671@manguebit.com>
 <CAH2r5muENv0sQ0+Q6xtDA-ThVu8B1W9=3-Yy0nOhX3onVVUXFA@mail.gmail.com>
In-Reply-To: <CAH2r5muENv0sQ0+Q6xtDA-ThVu8B1W9=3-Yy0nOhX3onVVUXFA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 17:41:39 -0500
Message-ID: <CAH2r5ms1-EnoxoYSUGVvk-NCucCk-5d8tNAyuR30xi-qrgY8pw@mail.gmail.com>
Subject: Re: [PATCH] cifs: Make the write_{enter,done,err} tracepoints display
 netfs info
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I responded to the wrong email.  This is in cifs-2.6.git for-next, but
it is obviously not a regression, I replied to the wrong email

On Mon, Sep 23, 2024 at 5:20=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> added to cifs-2.6.git for-next since it is important as it fixes a
> regression affecting cifs.ko
>
> On Thu, Sep 19, 2024 at 11:01=E2=80=AFAM Paulo Alcantara <pc@manguebit.co=
m> wrote:
> >
> > David Howells <dhowells@redhat.com> writes:
> >
> > > Make the write RPC tracepoints use the same trace macro complexes as =
the
> > > read tracepoints and display the netfs request and subrequest IDs whe=
re
> > > available (see commit 519be989717c "cifs: Add a tracepoint to track c=
redits
> > > involved in R/W requests").
> > >
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > cc: Steve French <stfrench@microsoft.com>
> > > cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> > > cc: Jeff Layton <jlayton@kernel.org>
> > > cc: linux-cifs@vger.kernel.org
> > > cc: netfs@lists.linux.dev
> > > cc: linux-fsdevel@vger.kernel.org
> > > ---
> > >  fs/smb/client/smb2pdu.c |   22 +++++++++++++++-------
> > >  fs/smb/client/trace.h   |    6 +++---
> > >  2 files changed, 18 insertions(+), 10 deletions(-)
> >
> > Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

