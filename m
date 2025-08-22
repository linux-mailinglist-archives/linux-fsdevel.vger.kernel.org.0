Return-Path: <linux-fsdevel+bounces-58850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB16B32177
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF685C22F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27A27CB04;
	Fri, 22 Aug 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDqXCxCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361F1A0BE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883319; cv=none; b=b4HnZtrD28LpOLQKpUbFF/mrO9FHHcRYQ5lxAnSUkvyjKJStvh8JuX0zS0sOSpzJ7L/fGh667/vdcX1lN5BkjXALA46x0jHMorldVMBaUHriODkU9uT3n9bECPG4Py6+wZzFNHpcReuvcYdTMSmtS1yjEImHCy+2POTMeyVBJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883319; c=relaxed/simple;
	bh=oKRgK3jkdnNEgxI96HLZYFGPCfFoDJEYQazzXkG4Ylk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVIJToemZzQOie/1YcMEV+UdzvGSIv3+GXBroKOhDMehZlZ/l0qdtPvrph+8nxUhLXiaJTrHJVjkkxfca/rBCVG0EmLhyX6+aMW9ZVEczi/BcEHQ+5uZ83mpy16Oj4YUdNB7z/ZdOQlhmVwnMQVq5pTQ5fnitbjO74hAY0hHHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDqXCxCe; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109919a09so28594521cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755883316; x=1756488116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTZO5/pB1R02+lnZhViB2JVpBq/zqUvUf3MyM+tMcDQ=;
        b=iDqXCxCeYqdidV+7dZqpaCzXH013rVOPQVcfCqatWslBfeqw2kPtu2/0rwzQsjfawm
         x3ad5vlMD3SupvALrpvtGJRPlLvbPb8F6FvXk/baGOok/VCdOqblTM8I8ed/vG8+AlGy
         2XnOltzw9+yfF2StcHFg1kSoP8XfmopUZ0v/lGoJar1wPi6Qs3g7s3GVNLankU15t5kO
         50+XbzuLx2616jR3e346LzSBi0y27ynovw+Py6L1xDgjIzWJNCPV35kEy7Jn+tFGbq2g
         9HG6euuwW0Wqe1l+4kYUApigfdDSkPpqeH2AkygXWHht0sOi5F6kq1PO/jMyfHD0EGoA
         SQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755883316; x=1756488116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTZO5/pB1R02+lnZhViB2JVpBq/zqUvUf3MyM+tMcDQ=;
        b=uyLKd3xDX5gvcMswtj0OfUVorYfK1T0uGcF0+GQx5kvK8LL8Su8tddZPn9XCilAzPd
         acrTHSLNlLGIqgFJDTuRsOwlKsed9GYqrBTe9j5d3LQIQGOZ6P4Q8HUMaAXMwMQUT759
         bwWqa/7Q2N/BGakxH5QY49wce7IyTgJN4iGZ9KNBvLFBh1cYWq2ePABzIFdHc2TZz8NI
         75ujh/kVrH23yby5EYRAwy/omUMOmCCIadi18yoBVMfQYbFBAZXTz7KM0VR8XHPtfZY6
         8+YNzAdYX+MBARje4nFTesEekyL6/1e4OE8GpwoCcx1cFEiZB5GCiqWwPW+r7poYFwDq
         k93g==
X-Forwarded-Encrypted: i=1; AJvYcCUlYC9531SHpn/lWiiYLNBZfffv/PUKS0Xammh8D58Rm2RJOdFkMDelrV91pu1kfBjHEIVtyOaK5syOThh4@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1wXBqsPA1zjm/Lg5sz3Qth2kFr4Cx28smA41yL2XQ3tIDdyC
	KpQsJx//PcpxhVFSEmOjnL5A9Sk88ilwQHJPV8XEEBMUjg8/sYQ3rKRb2CGNTihrHXP1Z/XunpV
	FThpWubQAS/jG4EO+vyZbzFF6eErfuhRJZQ==
X-Gm-Gg: ASbGncvKCWQKADdp6KTxdeTnIh6pyxWOxndgzekTCf9G/BDTqEKWpGjOF45lEspnLwG
	nud6bmIuxOpQVDNh1JGDPgcxqKCzUvkye6E2c1taVzhyqbsH7vvAITvQ+9FIzFJ3yLZqwcnRi3V
	wRp6yb3yy+HoaChXRnlRuNg1xNCxK5AAEpIdcq53YhD605YRBkApH1GFs1iPQynUyNE+U3OTCDQ
	dF1Q8PJrNtzcfHe+0k=
X-Google-Smtp-Source: AGHT+IGZiEK/Mv0s9OPEks6r/3e9n937N4ny9IMw6rXM07EEPCWI/XW6MDQrgsbKYwzkcJga3f2DX8IXHLVWojR0KLw=
X-Received: by 2002:a05:622a:181c:b0:4b1:103b:bb82 with SMTP id
 d75a77b69052e-4b2aab5caf9mr52045791cf.64.1755883316375; Fri, 22 Aug 2025
 10:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
In-Reply-To: <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 Aug 2025 10:21:44 -0700
X-Gm-Features: Ac12FXyu1___h7CrOHUB8OyiX0K8PtWewo0C-lfcE8xBtOMa4qdF1jsGdqS_dQ8
Message-ID: <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: synarete@gmail.com
Cc: Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu, 
	neal@gompa.dev, John@groves.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:32=E2=80=AFAM Shachar Sharon <synarete@gmail.com>=
 wrote:
>
> To the best of my understanding, there are two code paths which may
> yield FUSE_SYNCFS: one from user-space syscall syncfs(2) and the other
> from within the kernel itself. Unfortunately, there is no way to
> distinguish between the two at sb->s_op->sync_fs level, and the DoS
> argument refers to the second (kernel) case. If we could somehow
> propagate this info all the way down to the fuse layer then I see no
> reason for preventing (non-privileged) user-space programs from
> calling syncfs(2) over FUSE mounted file-systems.

I interpreted the DoS comment as referring to the scenario where a
userspace program calls generic sync()  and if an untrusted fuse
server deliberately hangs on servicing that request then it'll hang
sync forever. I think if this only affected the syncfs() syscall then
it wouldn't be a problem since the caller is directly invoking it on a
fuse fd, but if it affects generic sync() that seems like a big issue
to me. Or at least that's my understanding of the code with
ksys_sync() -> iterate_supers(sync_fs_one_sb, &wait).

Thanks,
Joanne
>
>
> Please correct me if I am wrong with my analysis.
>
>
> - Shachar.
>
> On Fri, Aug 22, 2025 at 1:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com=
> wrote:
> >
> >
> >
> > On 8/22/25 00:28, Darrick J. Wong wrote:
> > > On Thu, Aug 21, 2025 at 03:18:11PM -0700, Joanne Koong wrote:
> > >> On Wed, Aug 20, 2025 at 5:52=E2=80=AFPM Darrick J. Wong <djwong@kern=
el.org> wrote:
> > >>>
> > >>> From: Darrick J. Wong <djwong@kernel.org>
> > >>>
> > >>> Turn on syncfs for all fuse servers so that the ones in the know ca=
n
> > >>> flush cached intermediate data and logs to disk.
> > >>>
> > >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > >>> ---
> > >>>  fs/fuse/inode.c |    1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>>
> > >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > >>> index 463879830ecf34..b05510799f93e1 100644
> > >>> --- a/fs/fuse/inode.c
> > >>> +++ b/fs/fuse/inode.c
> > >>> @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block=
 *sb, struct fuse_fs_context *ctx)
> > >>>                 if (!sb_set_blocksize(sb, ctx->blksize))
> > >>>                         goto err;
> > >>>  #endif
> > >>> +               fc->sync_fs =3D 1;
> > >>
> > >> AFAICT, this enables syncfs only for fuseblk servers. Is this what y=
ou
> > >> intended?
> > >
> > > I meant to say for all fuseblk servers, but TBH I can't see why you
> > > wouldn't want to enable it for non-fuseblk servers too?
> > >
> > > (Maybe I was being overly cautious ;))
> >
> > Just checked, the initial commit message has
> >
> >
> > <quote 2d82ab251ef0f6e7716279b04e9b5a01a86ca530>
> > Note that such an operation allows the file server to DoS sync(). Since=
 a
> > typical FUSE file server is an untrusted piece of software running in
> > userspace, this is disabled by default. Only enable it with virtiofs fo=
r
> > now since virtiofsd is supposedly trusted by the guest kernel.
> > </quote>
> >
> >
> > With that we could at least enable for all privileged servers? And for
> > non-privileged this could be an async?
> >
> >
> > Thanks,
> > Bernd
> >
> >
> >

