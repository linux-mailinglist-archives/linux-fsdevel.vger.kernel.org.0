Return-Path: <linux-fsdevel+bounces-19162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C68C0D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E7D2826CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A6514A4F0;
	Thu,  9 May 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPY+udbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C6149C7C;
	Thu,  9 May 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246063; cv=none; b=dysySdwPyeKflI9kCb1pfl5IXhFJiMG/TNKuGR3WZ3Wg48fNkk/Iiwp4bes1E4m6Q0I4pD9TJyww6/5mX570qsBD2hi9zkzV0K5i2fmuqbnklt8whPUb3euVjXvdCXru96XaJIeA7KYvJ5R+7S5P5grirYpb/XtiygRvD+ebqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246063; c=relaxed/simple;
	bh=ZK+doQhDp/d9fILs65wdCIh3mPDLgRhve4CwjVpi63I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=oS70ddrwbzjZ92tQUzltnC0GPiTVA58Hvw2WmwAlb30T3Bn68VnPpW/mDA4DQEyBpZbfDabjVFamgzCSZBtvuH8EpVWH5F4LoFyMR1ziZYJQZ5EZP1v3BVk4PUtaBVWEqXT7p0+nJ3NggEm0+V/YAFmeTyNfabX+nT/KE5TLYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPY+udbo; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b27999f889so39926eaf.0;
        Thu, 09 May 2024 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715246061; x=1715850861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK+doQhDp/d9fILs65wdCIh3mPDLgRhve4CwjVpi63I=;
        b=hPY+udboPGJ6xEUnb6sS+HDH4SzQshVmec6lAqVm6/V1M4C38TRV2t/i643ruG3vWn
         jOr6OnS3lncOM4d51Cb/lKtRWdiHsSDpLKPs3G/x/1aJaGttGXdzyQM96ApT2OGBttDa
         NSYIG1UA9lZ8u3jYjiIlC2pbOZ2ZcGFMMKSbFYCA9MFROok8hLXyxt4fShDLOHkUk/Jb
         EFntP9pzvOxaizNCGyMPh5su3bzJy5HchgifJ4hmq1OfPHj8+0VlUyz6/8G0nYBZAlps
         f7fsJDAO24buC9zW223j9PrLD30N3vfsBRSOdCj/1PqZkSkd5SHJ5tcSjdfyK89aZbbx
         US5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246061; x=1715850861;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK+doQhDp/d9fILs65wdCIh3mPDLgRhve4CwjVpi63I=;
        b=dLqJe8w9rsF8U5NhzoYytk06+JSFVNyoXHVj1FfQwv2dgqh8WAMAZ9xa2mB2OLNmTQ
         KvDtWGArQBUOLwdN4vfJwcTVB2s0Va1Q7GEu7lSv76RsNfKHAJMIQAxOfEBSlei1MuwM
         ktO6R+Y9hqbnjM7nzXnpp1vr7u60lLdHnc6McJCJT+jDYtiKxyyjQVvMNjxt9eaY/FSB
         JkquHptYmPxOdGRAjGSa0elXa04nfeE1+upAdU2vGyPqlO5tVq/oeS/SXMsoI+B90JAy
         C1QLq9pxO9fCF4fKOTPwAg9sfc8Cd2udhZyqhZ1abaPuu6x5GyeUJ9og6LJt/trdXBQ8
         Fwsw==
X-Forwarded-Encrypted: i=1; AJvYcCXzI3KTH6WgkS2GwVmMj3ENeS3p0Ug6p4e4W97FDDX8cfQl+Pribnmz8kh3lEAvWn2pANAlalBYD1ablkHqtBMxXWpdiKelXRNEwPAdLzBQR4+DtDZyNcPbYGyc/xzgqyAk47HU2xPp7g==
X-Gm-Message-State: AOJu0Yyq35jJ2FJ8OetZ8ixLbS8iBqHKDiiFPD0qL1djv0/KfyAmHK0t
	gu1jHnY5F6QuBmGOxQj+f8f0/1+v9GZ+hgxE9KN17l38sMBU6wbK
X-Google-Smtp-Source: AGHT+IFku0mLCd/miLK6ElPcOAzixoVqefNKq7YjiBiYCLtTm8MlG8E09soBoRoMMwR7yUDlR5ikLQ==
X-Received: by 2002:a05:6359:5a8c:b0:192:4dd2:2b49 with SMTP id e5c5f4694b2df-192d2c29bc5mr643331955d.4.1715246061427;
        Thu, 09 May 2024 02:14:21 -0700 (PDT)
Received: from dw-tp ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134705dsm864299a12.85.2024.05.09.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:14:20 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Chandan Babu R <chandan.babu@oracle.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
In-Reply-To: <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
Date: Thu, 09 May 2024 14:39:09 +0530
Message-ID: <87v83nfj2i.fsf@gmail.com>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com> <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, May 8, 2024 at 10:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> How about an XFS BoF at LSFMM?
>
> Let me rephrase that.
>
> Darrick,
>
> Would you like to list some items for the XFS BoF so I can put it on
> the agenda and link to this thread?
>
>> Would it be good to separate the BoF
>> for XFS and bcachefs so that folks who want to attend both can do so?
>
> I have set a side 2.5 hours in the schedule on Wed afternoon for per-FS BoF
> 3 hours if you include the FS lightning slot afterwards that could be used
> as per-FS lightning updates.
>
>> How about Wednesday 15:30? That would allow a full hour for bcachefs.
>
> I have no doubt that people want to be updated about bcaches,
> but a full hour for bcachefs? IDK.
>
> FYI, I counted more than 10 attendees that are active contributors or
> have contributed to xfs in one way or another.
> That's roughly a third of the FS track.
>
> So let's see how much time XFS BoF needs and divide the rest of the
> time among other FS that want to do a BoF in the FS room.

Thanks that would be helpful. I would like to participate in XFS/iomap BoF
session and ext4 too (if that happens). So if we could avoid the
conflict between the two, that would be much appreciated.

>
> If anyone would like to run a *FS BoF in the FS room please let me know
> and please try to estimate how much time you will need.
> You can also "register" for *FS lightning talk, but we can also arrange this
> ad-hoc.
>
> Excited to see you all next week!

Same here, Thanks!

-ritesh

