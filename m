Return-Path: <linux-fsdevel+bounces-9974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D737E846BA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CEFB2BC0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98677637;
	Fri,  2 Feb 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CesPhn6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D05FDCA;
	Fri,  2 Feb 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865250; cv=none; b=u3JzoM0CWDOobeovI//Iwp9aVAoaenI0NR/bbFApG4y4kpUgTvClDfqJhc3q514p9L/jzXFa5uVncoaAw2S8lR7vyK8/DOJ+sZ3PXunrNJElbsdWmnlq15mwkgiuOou8Lj3KeNgXAbMfwosrFh1RVQ/0SO0nPFq/j/GcjqZbRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865250; c=relaxed/simple;
	bh=kBYTNwS6Us4GwZnCPZJooUBVvwncpX0u33cfM3dFqGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hk/xd7Yo9oQPAu4g3wLhgx0Sg23TRaf3/lI3ai1w+TaWsl+Mt5vKouhoSCuwC2FCg81ERrnwevtLJ3w++XRZQG7nV6WTZGKi/SWVfKSDN4HbeI3Aw7Jx8jy1l7j0CDBJr7VcrzwqriFwQWECW09vzweIWB7Qxi+/cT8oYgACDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CesPhn6o; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-686a92a8661so10131326d6.0;
        Fri, 02 Feb 2024 01:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706865248; x=1707470048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbAAumpPfIt/JaTeqaHTjOEYGyvHU1h2sRc7QPBrzJg=;
        b=CesPhn6oKXwzsMtkSUIVncY8vUSkgTmZWHiNhhGLrmbAYOtPWltgxubYX82vefP8hj
         /GY3b6Lv0jkVJiCIhlCVYsqVm2duOl4TOfnJXjJr3Zm4l+YJH7at2febunwBSwVNtCD9
         L44crv6f9cQiJNdKMOIVBi1agAaMnlTkbSIctjrHpxnbRK0HeBnFLBpOqS9mYCIv7kCi
         eIy1FZXsYYD8hiWplD4wLRvaCyA18n+OhIFJu5uOwmJmLrRtCQs58ae8Q6zCaHMN9oJ9
         xNJswBUfQhYlFTRgBhOEX63ctz298ay3UCFvnLHNHvY6GQlGHyyAPiImDuPznIxzedg9
         ymCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865248; x=1707470048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbAAumpPfIt/JaTeqaHTjOEYGyvHU1h2sRc7QPBrzJg=;
        b=rCX2bDFUVevx8bVFFwkrxp9deMJi7jy1MaHVgdC9Rkoxongl4Kt3vSEtCEQd7EHKQT
         iD2pPHXVOkNqFKluNOGgVXW0/kPhX5Y/vp+Stssi/TkTy0uBLo7v9H2RBd9nhTDaTuR8
         lhL1Yyx6HR9pouIg59gWk20VGdqgS9AHIeLVYIIDcNZIgoUfcpSuMFj1u1h0YKl0OMEl
         5H+cUItkv7FQFcFhzpENBTmpCvg/uznDGEukXrRw3V3twgWKA64zJGxsHfcGkMUWaFl5
         NspxHZDReg9fGNwE6SPlZyv3XDOw3BRYQ92Pv7d4XSRnAKVsc8ve1hUNeBjVgkt2FkyI
         9ikQ==
X-Gm-Message-State: AOJu0YzhF2Og0uKuPJRqNdCdAM3U9EAFK2zxX5zDEirtichPrZDgmfnm
	rcvBCSgyM/RJYZe8VhVF0v5xyJly8oaOy/sVhOKZuEP0imDaB0YeExu0jaLIr5pW9RaHZ15ipo2
	5T3SJYFwN9FVKzGhF2d537IvoAkM=
X-Google-Smtp-Source: AGHT+IEA6Ff4lcXRh07SyKhXAs07igcF4REEo54H7o8fp0nV88H0+Q3BYm+9VXx6KrD6j55EIuIdaID2z7TnHzCt2R4=
X-Received: by 2002:a0c:a99b:0:b0:686:ad1a:ecb7 with SMTP id
 a27-20020a0ca99b000000b00686ad1aecb7mr1009057qvb.42.1706865247858; Fri, 02
 Feb 2024 01:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401312229.eddeb9a6-oliver.sang@intel.com> <CAOQ4uxiwCGxBBbz3Edsu-aeJbNzh5b-+gvTHwtBFnCvbto2v-g@mail.gmail.com>
In-Reply-To: <CAOQ4uxiwCGxBBbz3Edsu-aeJbNzh5b-+gvTHwtBFnCvbto2v-g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 11:13:56 +0200
Message-ID: <CAOQ4uxgAaApTVxxPLKH69PMP-5My=1vS_c6TGqvV5MizMKoaiw@mail.gmail.com>
Subject: Re: [linus:master] [remap_range] dfad37051a: stress-ng.file-ioctl.ops_per_sec
 -11.2% regression
To: kenel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:47=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 4:13=E2=80=AFPM kenel test robot <oliver.sang@int=
el.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed a -11.2% regression of stress-ng.file-ioctl.o=
ps_per_sec on:
> >
> >
> > commit: dfad37051ade6ac0d404ef4913f3bd01954ee51c ("remap_range: move pe=
rmission hooks out of do_clone_file_range()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
>
> Can you please try this fix:
>
>  7d4213664bda remap_range: move sanity checks out of do_clone_file_range(=
)
>
> from:
>
> https://github.com/amir73il/linux ovl-fixes
>

Sorry, Oliver, this was a buggy commit.
I pushed this fixes version to ovl-fixes branch:

 1c5e7db8e1b2 remap_range: merge do_clone_file_range() into
vfs_clone_file_range()

Can you please test.

Thanks,
Amir.

