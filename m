Return-Path: <linux-fsdevel+bounces-20912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6148FAB70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D72289A09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501613F44D;
	Tue,  4 Jun 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmaiDmtk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F813E031
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484056; cv=none; b=nuWy1wFHpUtLFZdLbDOwC6/WfXibPZc+0b+8A5K0/AvYoNxOfU0P/b3t2y8PCpaolA1N5LC2WWptecrEB3yLSSUy/46DofvICfMVlqvfBXZSqPyrkxlHVzhk1R4c876nA0eHBPnwk29uxYS3J7hIGUwb60+OGm7e8WW2VrRab/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484056; c=relaxed/simple;
	bh=TY4AocV9cgF8fRQSPmGBPK3k6Q8W1dFYfVUQieI7WuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3AzXqtXftrRSin6wSnl6qsCnZW5S8gHfAUUOHflQAZjI6JA5m0K1b6zFszD/egsWJu8ap9p+VJelG38mzN5glEfcQqJCpASoWdCZvgqsf/4vRUkihDfgUjWEtYSTtOanHwF2b0HLm4KyzGougqJXBIzSbNjbmnyVdDuLYGL7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmaiDmtk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so690658a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717484053; x=1718088853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVA7yh1AKU8cP/KGgHsriPjGq2Djzd3Pv7KW58ilYh0=;
        b=HmaiDmtkvwWveuXs9AGpAyuB5viO+x0uSJHQqbK7ZNeWvtYXrBEHEklw3xu8+5nicz
         bznHIPpBZMu7CFWXk2zGluR62YbXJO8aBlt+ZcmTat3PT5BW86qnh66wq3BldGI1jHep
         2MK41cPR31ENoO2tutPyrFC+Tc6d8uK0zYrbrt/5mtQ7Ig+6yu8RgN9O2pAMlufwaF6v
         3d2nYc+l78nqx2/4hvdmptHuGREg0LcxiFKRrMDHb9RXSBhrBo+rY17xXg9ax0Jq1Lvt
         pHzfkutykZeQ2Eb+Dgdl3eqQPehiyi9nUaW0GygsPrwzg1DO73G6xGEMC6GHmugA/hXF
         CAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717484053; x=1718088853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVA7yh1AKU8cP/KGgHsriPjGq2Djzd3Pv7KW58ilYh0=;
        b=a/D0RQVI1a5OC3QLbl1R3pRceKNcuFjgz9d9SeNrUOm5iFG+36vsPA7ddD0UGuQ+2j
         ICkCNm9/PcQGpTEpBRsVpcxcNII9zwn5qRw54FszdxH8z9TzTzR2bIXJ8cS8OFhzRORj
         QgF7E8pzMnjStAz97W2dd30ErQaNxRZ2i8qxZT1+wsKdBEfL2Q7980f8GCG9Fl6ZmTWg
         jAKosz89j/wbEE5ytn/gHHT++XpR9h157nv4izbeJDBFRrEKvlUxQaRpdh2tzCLva/Ug
         1QMhcVEeEZNdSkN8VDQwen/xXz1hbrvYouuazCvlXR/YRgd9QCwm690h/SBbiz8mLITL
         Oc0A==
X-Gm-Message-State: AOJu0Yz33zL/Z6hi2SfJ7MqW+lsTHZ2MatPyutsQvzfM9yph6Y1GoHbj
	vpLGtGkblq6iOlAeQW76P0Ooq8EUY4De2wdFqcc29le6Yxok4xgKqeOumGkf3ewvTQrQl/BpnX1
	iOhqtxtuCIVU/itqST5ulFkIQMXU=
X-Google-Smtp-Source: AGHT+IEhM6vASmKMihQ+GAdQJeFzkj5cwXK4IyhfpcTYIOD67Tpdo3MENn/mHqpQEg26vN9Z7lREUODhPbvPW1he6DQ=
X-Received: by 2002:a50:cd55:0:b0:578:c161:525d with SMTP id
 4fb4d7f45d1cf-57a3643a163mr7067428a12.25.1717484052885; Mon, 03 Jun 2024
 23:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
In-Reply-To: <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Tue, 4 Jun 2024 14:54:01 +0800
Message-ID: <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Miklos Szeredi <miklos@szeredi.hu> =E4=BA=8E2024=E5=B9=B46=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.com> wrote=
:
>
> > Given these challenges, I would like to inquire about the community's
> > perspective on implementing quota functionality at the FUSE kernel
> > part. Is it feasible to implement quota functionality in the FUSE
> > kernel module, allowing users to set quotas for FUSE just as they
> > would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> > quotaset /mnt/fusefs)?  Would the community consider accepting patches
> > for this feature?
>
>
> > I would say yes, but I have no experience with quota in any way, so
> > cannot help with the details.

Thanks for your reply. I'd like try to implement this feature.

Best regards.

>
> Thanks,
> Miklos

