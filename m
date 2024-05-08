Return-Path: <linux-fsdevel+bounces-19027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A88BF780
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA02A1C212BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F739FF7;
	Wed,  8 May 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLQuFcws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0032C8B;
	Wed,  8 May 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154347; cv=none; b=KaFe2R2I57sWo6AXUODqtH7oRvWr2Yviy5bLYhTVAPM2h2BXuVw1EVFTNVeavAW92zdHVKMyKK6hFn5B8CXcJorUnJpvoQTHICaSt1/JBXzJ0WddFr4OEmhmgwKYD9c71nLCGABbfCfEdA7iTusU2tRmYWb65/0qZgkVENB5lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154347; c=relaxed/simple;
	bh=Asxa12FYwp6Eh7LcfCTnjW7ES+F3pNL6geI94xycBN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfYW51BZyvp1AorFkp41EyT30emxo/5cfZ6U5/KG6SPfaYSSjWt+PKjKC7CugxyY4wkDa+H2cD1I8pHglVoPhQVxmyOLKZbqt7uzsnrUEeJUJs7exYOzq2ItqGjrAQOlxEQd4y0jyjy7m53rWuJw/LsNxnWeHg0CLbZ3nUl95fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLQuFcws; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7929c9e67fdso259261885a.2;
        Wed, 08 May 2024 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715154345; x=1715759145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asxa12FYwp6Eh7LcfCTnjW7ES+F3pNL6geI94xycBN8=;
        b=hLQuFcwsUYlmVm5bAV+IcTDVBe8Ckv6pnnIspz9APHyKCEfVmShImBKfh6GfMTQAfq
         /N0yAnq+iiWVcKouglpHu2+dzNT1+1zlldahDkKMpov+/XZfCCIMDWCbgL7+1fRRMKST
         FNoUnhkmoGDdG00GJh5HXlD4wxFq0ctvm5gnpzJpOupvHj9qQUXqwRsnwuI6CNmiT5sc
         BZ7brPvl9nu0vdHRhPMfyWxLDWuu+8ocgsG+TChZ9h+NZ2hp0yZ/3lHodZT/o2qU2TrN
         AB+zerCtSsVuo0Wf652tqOsZZxRkERz0VP3iUjciJhl2VPtoWjA7vQ4O7jwXuwiCEVIi
         Bdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154345; x=1715759145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Asxa12FYwp6Eh7LcfCTnjW7ES+F3pNL6geI94xycBN8=;
        b=MzMzToTcCCachlt+2EBp4rEkex3XMs9T4aB1tPJ99dwefp48amnVxT6Cu7q09sw5Pb
         LDflV3bGaG1eyJMQez/IO38/HS2g0qhwl+KsAWaFvzyasL7KqwBlxWPaQXQe6VHcZ6Ja
         WNwWS5rmUjqaVBQBufb9z3SbiPiUgDn/EW6uExld+deDjif4Fs0yq6UCAIPmCz6kBt0E
         XAhbHb3IAJApSAtcrBOfV6S3DqPidEtQ70LKbHqj65B743BrAGd5FQz4ntDikU4amS3d
         taLYEeJ/r2P2hbb///KLh0Y0P0OOoSn/MhGjtdvNND67FCUOZg2rBShMp0AAH+7tqszP
         Z/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmIfM31EIHsCkG/LD66LUgKrMpd5nZs6gElrPH+lUC1QEEYipUSmKFLLKSfWuP+BmecWEZ3uVtFXUhUrbyVPE9FfVEQavhcFId8YgwOwMYU8BXMiOWtj23FrPNj4DmQmPNnsm94ZLcBw==
X-Gm-Message-State: AOJu0YxfGCOxmCVoL0cl4VBdusynv5AqxeH/ctPZzd4L/7IIOFJWB9/Y
	vcTwXWgQ0SknwWbM5CoyRtYP2BWW9zqiQAk3S6pEnFCLBIwefK6nH0bBo+/x8PZEaiewastCWqt
	wPruKi9/VsPlq0zGShvBesS61orI=
X-Google-Smtp-Source: AGHT+IETJkV+zUHuVrv52PTMHRbun4ueox3FklyyPNHf1V0JNtHy/KFcHP4vl/EDr89gXxpF3AQrY2pcBW3rctQ02rs=
X-Received: by 2002:a05:620a:17a8:b0:78f:182:5e20 with SMTP id
 af79cd13be357-792b27bdeb1mr232953285a.7.1715154344973; Wed, 08 May 2024
 00:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
In-Reply-To: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 May 2024 10:45:33 +0300
Message-ID: <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
Subject: Re: kdevops BoF at LSFMM
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, kdevops@lists.linux.dev, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-cxl@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:44=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Dear LPC session leads,
>
> We'd like to gather together and talk about current ongoing
> developments / changes on kdevops at LSFMM. Those interested in
> automation on complex workflows with kdevops are also welcomed. This
> is best addressed informally, but since I see an open slot for at
> 10:30am for Tuesday, figured I'd check to see if we can snatch it.

The empty slot is there for flexibility of the schedule and also
wouldn't storage/MM people be interested in kdevops?

I've placed you session instead of the FS lightning talks on Tuesday
after Leah's FS testing session.
There are enough slots for FS lightning talks.

There are several empty slots throughout the agenda left for
flexibility, including the one you mentioned on Tue morning.
kdevops session is for a very specialized group of developers,
so if that group is assembled and decides to use an earlier slot
we can do that on the spot.

> BoFs for filesystems are scheduled towards the end of the conference
> on Wednesday it seems, so ideally this would just take place then, but
> the last BoF for XFS at Linux Plumbers took... 4 hours, and if such
> filesystem BoFs take place I suspect each FS developer would also want
> to attend their own respective FS BoF...

I certainly hope that FS maintainers will use this gathering to have
their own respective BoFs.
If anyone would like to lead an FS BoF in the FS track room,
please let me know and I will place it on the agenda.

Thanks,
Amir.

