Return-Path: <linux-fsdevel+bounces-10489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9A84B8C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D64289677
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D31332A7;
	Tue,  6 Feb 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr0Ql/Fu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5313248D;
	Tue,  6 Feb 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231912; cv=none; b=HuS0Z3dTLn4b+GbtsgdZRgjy1uvJWqGzp1Vqro6S/qC6hf9VfdKa/eAb6GJdusQyQOEpIvFFwDm8z86Bg35qtygDEjQwwUvPfmubrcb8a0uhrXHlx1n4gosGmIzliYQHkKRZpZHzhOl/hKXk+YenDczViNKD6kpI+kAP3eBBtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231912; c=relaxed/simple;
	bh=bVno8WQTGbHurQQwnhVu0vijufkiMDbLKRAxnxjC3Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maZS37Pahv4c3K4BEx2+FGOkUrMnpFt3dP0CRbdri7YIVahO2y64MU8TWkDizRICIFtiK1QUmQktXOB+8oWoxjFqD3nVralQ6npDEq83tgf4Cku3nZDhmzZiwOo+ubBGqsb7T1zRAWwzH+ES8qGq+xWl7w0+pxpY0wC6Y3D+UeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr0Ql/Fu; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e125818649so3001591a34.1;
        Tue, 06 Feb 2024 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231908; x=1707836708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioIvR4LsMaW6xA6i7+EQnV42R5bTHmknBpHkYqe7Uv8=;
        b=gr0Ql/FuruA7uGX+Lr5gM8RFh5zuQqngDZ8NEwprk94/w6uRosssVwl/txD3osnLvQ
         U+d5D0UsOrmS+tauC7JDB9oPuFbV0/45bJyzDxUVfN13yRqsC+nhV03ZK9Y4eCB1GHUz
         MvfZD6ysXn2PJ+7HfRTCpy9IhR7i0EdTHA31pxHXzWmyk+22FMzNJ6JrhPyl05RtVMDc
         DSZHZUQEVtPbs8KlIwgDJg8aPMq6FC8L/9kyUrxv4NDzmEXXsdFC9m3bfsPw+GycR+cB
         By1aGZiZavYftP15uSUWN0VrJmjbMuLlFYtuhcqgiMUD94HzvO2xkdNHFT5AqRJFCUVD
         aFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231908; x=1707836708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioIvR4LsMaW6xA6i7+EQnV42R5bTHmknBpHkYqe7Uv8=;
        b=Q+Ve6RCJWdO0mEZjZpDEZfQOMWcaAi3wBdtlyFQO0bn0+UYKcMfwKYRbxaTj0JsCDR
         Knhk3gvDsP8tO7HdpS5vYnyRFaFRiEiU90qltvBx9PNTtSibJgQUsUtk/7/TmVUNkUNv
         JmP8hQ4yGBSFn6DBjU9P2JNqGQ8s/3fwfBp3wkEsmD3lzGxoS1+I1GbWYdkYTqYp7qSk
         Hx10nUFvNbnMSfWQRLPsvpqmsCifEgRc/AyCDI8ZTmF+ksFmSfuPOqsMMClRZVTp15Xw
         kGLDRMUHG0u3Y12p/YHAQ7ZQvWRoLNHDRNpGRXm3oRJPBsxkGpd22Yr6CU6wcneRIjNn
         WevA==
X-Gm-Message-State: AOJu0YwsstVjALus1sGpm/LtgYtLj210fQsQCnmIkGSxWDpbugtdcura
	KbpOb/L1G+btsLBLdE6acjFC5Z7u+sI4vFklTPHwjmIsomXpRToGTjO+F0KkDW78mihVtH5rWgX
	ygzE/kEu8bKTvk5NXgx5jdM3Fv/nFJ2wS3ow=
X-Google-Smtp-Source: AGHT+IFWVTl6mm2CDlJsEbStomZ4IAGwkcu/Joc866MJc31wLxOcsv3DEJmL9yHTk+0ChG99yqhy1/iteBtcWJn+H6M=
X-Received: by 2002:a05:6870:5251:b0:204:f0b:3bfd with SMTP id
 o17-20020a056870525100b002040f0b3bfdmr3094700oai.43.1707231908476; Tue, 06
 Feb 2024 07:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401312229.eddeb9a6-oliver.sang@intel.com> <CAOQ4uxiwCGxBBbz3Edsu-aeJbNzh5b-+gvTHwtBFnCvbto2v-g@mail.gmail.com>
 <CAOQ4uxgAaApTVxxPLKH69PMP-5My=1vS_c6TGqvV5MizMKoaiw@mail.gmail.com> <Zb8vk1Psust0ODrs@xsang-OptiPlex-9020>
In-Reply-To: <Zb8vk1Psust0ODrs@xsang-OptiPlex-9020>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:04:56 +0200
Message-ID: <CAOQ4uxjFA=P8ZiPjaqP-4Ka35GdqEtKaTTG1XMnts6rOswchCA@mail.gmail.com>
Subject: Re: [linus:master] [remap_range] dfad37051a: stress-ng.file-ioctl.ops_per_sec
 -11.2% regression
To: Oliver Sang <oliver.sang@intel.com>, Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:33=E2=80=AFAM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Amir,
>
> On Fri, Feb 02, 2024 at 11:13:56AM +0200, Amir Goldstein wrote:
> > On Wed, Jan 31, 2024 at 5:47=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Wed, Jan 31, 2024 at 4:13=E2=80=AFPM kenel test robot <oliver.sang=
@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed a -11.2% regression of stress-ng.file-ioc=
tl.ops_per_sec on:
> > > >
> > > >
> > > > commit: dfad37051ade6ac0d404ef4913f3bd01954ee51c ("remap_range: mov=
e permission hooks out of do_clone_file_range()")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git mas=
ter
> > > >
> > >
> > > Can you please try this fix:
> > >
> > >  7d4213664bda remap_range: move sanity checks out of do_clone_file_ra=
nge()
> > >
> > > from:
> > >
> > > https://github.com/amir73il/linux ovl-fixes
> > >
> >
> > Sorry, Oliver, this was a buggy commit.
> > I pushed this fixes version to ovl-fixes branch:
> >
> >  1c5e7db8e1b2 remap_range: merge do_clone_file_range() into
> > vfs_clone_file_range()
> >
> > Can you please test.
>
> the regression disappeared by above commit in our tests.
>
> I noticed this branch is based on v6.8-rc2, so I directly tested upon it =
and its
> parent (3f01e53bf6). I found 3f01e53bf6 has same data as dfad37051a we re=
ported.
>
> and on 1c5e7db8e1b2, the performance back to the same level before dfad37=
051a.
>

Thanks for testing!

Christian, can you please amend the fix commit to
Reported-and-tested-by: kernel test robot <oliver.sang@intel.com>

Thanks,
Amir.

