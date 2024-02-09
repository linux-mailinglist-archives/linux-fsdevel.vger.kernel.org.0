Return-Path: <linux-fsdevel+bounces-11018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA084FDA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28ABDB2968F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE896CA66;
	Fri,  9 Feb 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRRBmZbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6C1C10;
	Fri,  9 Feb 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510898; cv=none; b=ov4XcQrF0QqbarYrO+euYpghZsGIQLZC1gZvWilnGFqZIfMB6GaDil3YudLVHiKrWvjwE7G2xnJUkfNSMIm5Qgfp0/M1sc2tyB+CP0UvXhWEzZfatVQ0lzT0sM7fe5uYzeS8llRoti06UJ/1k89p2Ubyot4BhQ+QcUqzKOJySdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510898; c=relaxed/simple;
	bh=Nhcj9DPiHCkuEemzq4+XBqgkPDJz+Mbq1jpF87vjhKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdPfehTAf6jtRfRx5Mf0qF/FrQ5BjQ4LpQAzX9DGtub2iAioshzspfgUhBwgi6t8UAVDQgYPap0CUQ2pmt+0OiZveseSByB5+edsgj0gO7Uhi8FQsyfz0OreKAQ9y6C6FkFSiKPCuHaSZFwgrZOjJaWkoMiMXHY0v+13ufjOjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRRBmZbQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5114c05806eso2186033e87.1;
        Fri, 09 Feb 2024 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707510894; x=1708115694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUN8b7/S7YXII4W3X1WElde9eqEXoxcQDnp8+sG/BgE=;
        b=dRRBmZbQp0HEmH9ikd+upqQ+8XBNJaM5W4Pc/JrmDFXMULOz3y25UCYaZ0o0fVs2We
         S2CyTiexjHiqRbdycUeFSstF+yZYbU7P5UO+C3ZU87NmXoZUne3Mpv/efKWYuitSVUcr
         Y9yXqlMx96x9fzvncTzWHTvoDSgyqY9nzulHHkP4D7FUrc2OJmiP036VS7Y6rd9SV3JQ
         9Z6MmbEJtmkI+XSGbBoarNjsrzf78TEi7p9uGTfsEZmIMVbbPYNCpPCJaxMXJsF2cRv7
         1la2tgMTJSg//5CpBOnG364em96vlOb6yxan719IoWFfEOss08Jahe9PCjYKplkY0ZLG
         sPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510894; x=1708115694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUN8b7/S7YXII4W3X1WElde9eqEXoxcQDnp8+sG/BgE=;
        b=jULbkU+cZ+ki8GbXvigF38FSXtlZwUd3ty5cFOPWO8e9QcqY4a7U6wVnrhFXrey15Z
         YZu4bhLXxNEVys6PMZkb1P4qyWFVjR3ZF8EB/gdrgzGir//srQaGLN6dGvSMRgeWh8Ad
         xt9cWenfHx+TpyY3T2XuWnbFMwj1xlNELNFUpccRxhBj4qT3z+uZT/cE+H6bo/Iy6OTC
         BBHqazC71QRuE+rC5ki7U2+SVa0eOVyh2q1PhYQDwLnmzyO3Cd0QDLJsqDxDJcualIeb
         Vm7pEcTPSyOUOVpAquVFrhzU++BwQNdWlTLzsQbbxUqtaArJoXjS1aDeYnj/AIrTQfvT
         +oWg==
X-Gm-Message-State: AOJu0Yzowt8n0c3PLlTznVPn5bPLagKdxWTEG8G0YN6pysEtav797vVE
	DijptVBfCoWLg163hgZOE5Yad5+HiUn5UTkTrv1UK5l58eeFj+mlMBKhOtBoJZ4913BQqD5z6ku
	MB0VIEVEguovvQkmpJTtsFV9iTpo8USAH1mI=
X-Google-Smtp-Source: AGHT+IHY+3bC9RrkKLvACoZnqJXmO8zdYFcMlf2PGSqkOf/ErSIr6eVNnCGgcJUatD3Wkecd/8lWk4G0DBBrQjGO2xs=
X-Received: by 2002:a05:6512:368b:b0:511:5e2c:e63 with SMTP id
 d11-20020a056512368b00b005115e2c0e63mr78851lfs.59.1707510894295; Fri, 09 Feb
 2024 12:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
 <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
 <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
 <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com>
 <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com> <617c148c-4a18-49b4-974a-18f1f500358e@rd10.de>
In-Reply-To: <617c148c-4a18-49b4-974a-18f1f500358e@rd10.de>
From: Steve French <smfrench@gmail.com>
Date: Fri, 9 Feb 2024 14:34:43 -0600
Message-ID: <CAH2r5muANsy5U4Xgsi3BtvRMEFR1cnj5jFjJVUbrGAn86N8ejg@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: Matthew Ruffell <matthew.ruffell@canonical.com>, dhowells@redhat.com, 
	linux-cifs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:42=E2=80=AFAM R. Diez <rdiez-2006@rd10.de> wrote:
<...>
> Now that I mentioned misleading messages: The man page for mount.cifs, pa=
rameters rsize and wsize, talks about "maximum amount of data the kernel wi=
ll request", and about the "maximum size that servers will accept". It is n=
ot clear that this is a maximum value for the negotiation phase, so 1) you =
do not have to worry about setting it too high on the Linux client, as the =
server will not reject it but negotiate it down if necessary (is that true?=
), and 2) the negotiation result may actually be much lower than the value =
you requested, but that is fine, as it wasn't really a hard request, but a =
soft petition.
>
> I suggest that you guys rephrase that man page, in order to prevent other=
 people scratching their heads again.
>
> I would write something along this line: "Maximum amount of data that the=
 kernel will negotiate for read [or write] requests in bytes. Maximum size =
that servers will negotiate is typically ...".

That is a good idea - there are also other changes to the mount.cifs
man page to be done (e.g. to go through the mount parameters in
fs/smb/client/fs_context.c and compare with the mount.cifs man page to
see which are missing descriptions)


> By the way, the current option naming is quite misleading too. I am guess=
ing that you can specify "wsize=3Dxxx" and then "mount -l" will show "wsize=
=3Dyyy", leaving you wondering why your value was not actually taken. Or, l=
ike it happened this time, other people automatically assume that I specifi=
ed a wsize, when I didn't. I would have called these parameters "maxwsize" =
and "negotiatedwsize", to make the distinction clear. I wonder if it is not=
 too late to change the name of the one listed by "mount -l", that is, the =
"negotiatedwsize".
>
> Regards,
>    rdiez

The mount parm names wsize=3D and rsize=3D were used to match other
filesystems (e.g. nfs) which have similarly named mount params for a
similar purpose.

--=20
Thanks,

Steve

