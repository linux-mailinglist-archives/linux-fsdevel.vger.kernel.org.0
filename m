Return-Path: <linux-fsdevel+bounces-58775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1DB31670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E358AAE0B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9281C2FB602;
	Fri, 22 Aug 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLR7RcOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F1224FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862379; cv=none; b=m8TYT5HZY3K0ePxWl06u+BEtMzt0wN8ArlS+w3fxZZxSK+3bB9Fq6s2cNXFcLDo+CkeDYQNNJ7ZHvA7CVC3du5M3lphTxBvUgkFGI4bUrZznpr5x9UmM/RspF0jWbcaiXotiJI9zmAqWazIQY8W74DtqfXloIJ6Q2QnVlRMcsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862379; c=relaxed/simple;
	bh=tut/IXSbygn42TcB/RqKn5Lnfha7VSml4q60FrmRglo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebWpF4uUOaCfPHn/WPHon1eJpExk8Y2edLUvJMI0jLHll9hO+UyCAzIda8as5z5lPpXpQ/mT/4FyW1ZYd/ELOlSk/Vi8r6n5Gzv7pY4PDPvnwjHqGU5xmOUHGjly8fBHyW6jEaEQoHzU2ADoESvZOug5uDW1ZHzN/bXhzR6GWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLR7RcOV; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d6051afbfso16960657b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755862376; x=1756467176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPGjz8CIXbAqYIpDpRtIbotp817ad0xTdrvSoe1RTog=;
        b=WLR7RcOV0Y0JayVF6vjnTx74bx+mUtBgDc8/mPpJJOaJV/gH6MCY02JjqiTxASxcpO
         MunMPRxAiGblqwodV0VINAyBc/I4pobYTYhX6AdnPUAv1h1S8a9W2V2euuQ4Zi8FjCQs
         BE83KGwImA6cbsWhVrz03Q7+xnCWh2Ds4QQ5rFNIGHqbRZ4NvhWIJT2VKznudmqxI0L9
         1IIw9muaLo4aM1kzg+UHUyLHQ+xM8mLcQpeg+E8T2bvkc+ETgg8+PcA5RFyX+C4NExrP
         GWIg//iIy6HlqbkpRIez9Crc9k/WKGMqCFQaOUUNmEaYoWV1EHuXDoT8Qx7Xz5J/WSs4
         4TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862376; x=1756467176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPGjz8CIXbAqYIpDpRtIbotp817ad0xTdrvSoe1RTog=;
        b=qGsUx7W4p+JJXh5qheOt8aCEBfm6Rvmp+V0WSkUzvy2kqN9QfUtMdtxNctqm1z1oPX
         0M589Vjt5ob1ZBQMDOriKKzfePymTgP7U2+KXkdu1PyIeqbPeor+Q77VR9kxfFtIGjPc
         J+K1YUquMipIWxYDcrfIrY4FCSoW48leedXpYIGzi5JFUgzyOLKqY2eCY53L1I8918rR
         AzPSVix2jgPc00E16dOjwDNP7vCY+3agwHPIFtv1bgDk9x9xM9gtqML+CUguLz+BFVFw
         uvovJSGJIMJ6Zb+R7JMqkQDUfLZWv6A4PdxDTI+o6oF3Q5RI5UyvF0/FfjwSqWn6bMS4
         /g4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYvRJlLDSiZcelO2lVZV0Fpus2b2oRna+8V1ydt3Em1fVvyEr3cOQSuBQXivClCmFHE86I0aRcd8mDU3J7@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQMNbEBuTpqmXNNXQTeMwmqmPvYZkD9OY4W/c0a9LZK8VGEIO
	iDxFHKmgmmNJWV95IfWZaj6fygdm8A1WK38595rtdweIFTl769/UfuqUfY/PHpxnIiHVRFhfrzh
	CptO6HHC56D/cOa5HdjJc7F8gxXP+Rgk=
X-Gm-Gg: ASbGncsX3RXnk5yqAqk3uMEkGXjTGWi7Y8xyJqfWWqQYhwu956vrBjsjl0LgLpUL0Qk
	djYYwP7pK3h+9v6eThzQPaqdiHSW8S2L4atsXTie4Jpc7ppCcb8FCWPy2l3btnlWjWD7uouZXFG
	4KQrIPHa1ZrmecGB2Qvc40nCpxPYFaOL9cN58GRs68mnoil6ukF62q016wtwujVY+g3MaYUgjj8
	qSakAi/ySzqT76DAxGeU7mIVWJNWAjOZxs60UMYpwOzAnK9mQ==
X-Google-Smtp-Source: AGHT+IGkaE9bS8KAMb3+pJ2teG9Oyj3S0bwgn49uBeFSv3wl4g2p59epga7y/rmFUb5yE68Gn9pxOjGX1/gSVY2sUTs=
X-Received: by 2002:a05:690c:74c7:b0:719:f1b0:5c29 with SMTP id
 00721157ae682-71fdc2b00efmr25480397b3.3.1755862375896; Fri, 22 Aug 2025
 04:32:55 -0700 (PDT)
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
In-Reply-To: <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
From: Shachar Sharon <synarete@gmail.com>
Date: Fri, 22 Aug 2025 14:32:44 +0300
X-Gm-Features: Ac12FXwl8hJy-onMCrzP2C1Xi8IhtqtvDqCK-itAlOAfntKVj1OdFBHmOggQ5dU
Message-ID: <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: Bernd Schubert <bernd@bsbernd.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	neal@gompa.dev, John@groves.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To the best of my understanding, there are two code paths which may
yield FUSE_SYNCFS: one from user-space syscall syncfs(2) and the other
from within the kernel itself. Unfortunately, there is no way to
distinguish between the two at sb->s_op->sync_fs level, and the DoS
argument refers to the second (kernel) case. If we could somehow
propagate this info all the way down to the fuse layer then I see no
reason for preventing (non-privileged) user-space programs from
calling syncfs(2) over FUSE mounted file-systems.


Please correct me if I am wrong with my analysis.


- Shachar.

On Fri, Aug 22, 2025 at 1:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 8/22/25 00:28, Darrick J. Wong wrote:
> > On Thu, Aug 21, 2025 at 03:18:11PM -0700, Joanne Koong wrote:
> >> On Wed, Aug 20, 2025 at 5:52=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> >>>
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Turn on syncfs for all fuse servers so that the ones in the know can
> >>> flush cached intermediate data and logs to disk.
> >>>
> >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>> ---
> >>>  fs/fuse/inode.c |    1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>>
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index 463879830ecf34..b05510799f93e1 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *=
sb, struct fuse_fs_context *ctx)
> >>>                 if (!sb_set_blocksize(sb, ctx->blksize))
> >>>                         goto err;
> >>>  #endif
> >>> +               fc->sync_fs =3D 1;
> >>
> >> AFAICT, this enables syncfs only for fuseblk servers. Is this what you
> >> intended?
> >
> > I meant to say for all fuseblk servers, but TBH I can't see why you
> > wouldn't want to enable it for non-fuseblk servers too?
> >
> > (Maybe I was being overly cautious ;))
>
> Just checked, the initial commit message has
>
>
> <quote 2d82ab251ef0f6e7716279b04e9b5a01a86ca530>
> Note that such an operation allows the file server to DoS sync(). Since a
> typical FUSE file server is an untrusted piece of software running in
> userspace, this is disabled by default. Only enable it with virtiofs for
> now since virtiofsd is supposedly trusted by the guest kernel.
> </quote>
>
>
> With that we could at least enable for all privileged servers? And for
> non-privileged this could be an async?
>
>
> Thanks,
> Bernd
>
>
>

