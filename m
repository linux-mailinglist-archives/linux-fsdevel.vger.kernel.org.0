Return-Path: <linux-fsdevel+bounces-27703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B396364B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF63B251C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC7B1AED5F;
	Wed, 28 Aug 2024 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ln/O9WVE";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="T/lL4Rv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EF1AE034
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888461; cv=none; b=rUC6iPpKCCdJV4g35ebYrdXl0PNSpHFqh4dMD4UOGkTb0/KFgS8T5avUdZ318d4ZfqjmuJkEjjHHsHVD9Dy2GbrDbDDx7hG/87vrGnSuWIFExO9dSiVJ8ub3mI2NJJ+4caZm25IBo4j93J/PRrI1jT7cTVI4am9eRmISUqe8pzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888461; c=relaxed/simple;
	bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrqU7RnYlxNBkyoQow5V4BfWo1ZJHHQT07ZGRv8LxT/1QifVyO1cDz/8Tq2wNL80/k4UfbsgJs68GkoEBp/TI9rqRoL9jjU8ao+hu1D0MFjtx0yYcUGkc3hKK3285gkc5okXrlW0BRgdh9l61ZGs23goPgyz+TpAY90u4P582V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ln/O9WVE; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=T/lL4Rv/; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888461; x=1756424461;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
  b=ln/O9WVEFKOxWuZNmxm1DbT8Q1OIMuIhu5nLbqd6nP1a14ajRb7qcpJR
   H4sEQZBU/pkuKDPO9Q4DBgHSvV7Mub/Fh689Qi992gB9wy2Sbbuja0BNq
   IEs4iJVApmEhhlVwveo3ShH8pXheIZ/2Mz5GxYxTepJ1+Ud6tJT7FVY/W
   ND4v0tY3wDn1XN9ywYrKdeDt1Q9Lfl3MM87YMyhhMgP6pX2al3ecBSC4Z
   IjRD1DLRWQHfI3PPyJYBtpEBaFHSaioGuBagHYpxOe4dij3ffAXFeNoDa
   6nboVbLIrUjJM2cgrko7LITFvqCp9jhV71kGxOl+moFMAZzAGgDRyOLiv
   w==;
X-CSE-ConnectionGUID: 65KOpKNHTSCV5mlezzFDUQ==
X-CSE-MsgGUID: QVzLZQh6TjyJzuk6lT9NOQ==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:40:58 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d27200924so10268805ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888456; x=1725493256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
        b=T/lL4Rv/i5HK4hZatlEaK90AH9lPqZlVxtTUZM2lqWS8kUHyFm+v+7ji9GeiA6QFFk
         LnzSVfcpQZSD/E4999WznyI1XpsIDIUfeCIYfuodbRGfC48xwTG3t1clxS+KHY0vDn1A
         IidF7eVhPCdbi4WCjQdZ2VgG4yPu6XKzApU04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888456; x=1725493256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ICgvZh1XJ1kK1zQIOLD5sHD39B1UXAvvuE36ZmWr18=;
        b=Iv6SFRkBMBX8Bp2H7S7bvHy8RSLGuooJDnVnK6PkuF0TFLWucJib2WiAWd6oqzsLx5
         EgDMXs/FsgCdfVIUMryXVcTi2xP9yFAPelA4L95I8x4KDrxirbAW+qFCi7tDooNlUPPI
         EYTTuoy37xjA0ELJ0E+SpWBXo8QaAlb3yNRYZjoqaL+kszSiMeOdWTI1yR68Ou8CrHxm
         bEsgyUUnVIOwVfEDT1IK26aGz63Vmsbj7txEzZ4E7az+YxHlv2WLty3Qlwma8oUD2fvE
         cnsjaXnLq14o5fQCun4c0cMQma3kTbLSm20gKrCzKdGn9qViGfYbDvkE9oiBb+TCHBBL
         bZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCV2YsqYQ7Jwndu5P951/1/h31lQkv0kgZm4sYf8Tk12Q6VUniO9R1Ki30ryXLNl0AXXLSIErKxNMfPnULpL@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFkFWnH6MPDBApboOVkgWIxDgBQVarqYUibqo2t/I2dnEI1Ay
	IookykpE9lINBtykmTC4gVvoBVWarIA8Shzv688Nar916CkHMw96UDVOfLrac5d65ZmVOwUwHxF
	a5NPVF5OtthukMPE25Qxi9Bz7TqqblvuxsGm29HYCLYYrdIKV3Z65iJxO5tXJPT6invmL8OOuP7
	oV0Zr1Tf/pMF4DkXqJ4Qrdtj67qBDsOE129C6bdy2E/eGd5cDGJw==
X-Received: by 2002:a05:6e02:1848:b0:39e:6a2f:ad79 with SMTP id e9e14a558f8ab-39f38add897mr5489475ab.2.1724888456195;
        Wed, 28 Aug 2024 16:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHExE7N2HLmIBgUTC9d3TYDNHufWSKlu5VDT9xGH/MN29veCd9nNTH74lOUfkl8yPuD4ChlwNTSKCgbbCC8da4=
X-Received: by 2002:a05:6e02:1848:b0:39e:6a2f:ad79 with SMTP id
 e9e14a558f8ab-39f38add897mr5489385ab.2.1724888455901; Wed, 28 Aug 2024
 16:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4@eucas1p2.samsung.com>
 <CALAgD-4n=bgzbLyyw1Q3C=2aa=wh8FimDgS30ud_ay53hDgYBQ@mail.gmail.com> <20240827142749.ibj4fjdp6n7wvz2p@joelS2.panther.com>
In-Reply-To: <20240827142749.ibj4fjdp6n7wvz2p@joelS2.panther.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:40:45 -0700
Message-ID: <CALAgD-5SgEFKD36qtMxWoFci0pLiPxC6Y9Z6rumBr7bGO3x9fQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in put_links
To: Joel Granados <j.granados@samsung.com>, Yu Hao <yhao016@ucr.edu>
Cc: mcgrof@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We use syzkaller to fuzz the linux kernel, and this bug is triggered
during fuzzing. However, unfortunately, syzkaller did not generate
reproducing source codes.

On Tue, Aug 27, 2024 at 12:50=E2=80=AFPM Joel Granados <j.granados@samsung.=
com> wrote:
>
> On Sat, Aug 24, 2024 at 10:04:54PM -0700, Xingyu Li wrote:
> > Hi,
> >
> > We found a bug in Linux 6.10. It is probably a null pointer reference b=
ug.
> > The reason is probably that before line 123 of
> > fs/proc/proc_sysctl.c(entry =3D &head->ctl_table[ctl_node -
> > head->node];), there is no null pointer check for `head`.
> > The bug report is as follow:
>
> Thx for the report. How did you trigger it. Do you have code that
> triggers it?
>
> Best
>
> --
>
> Joel Granados



--=20
Yours sincerely,
Xingyu

