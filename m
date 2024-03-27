Return-Path: <linux-fsdevel+bounces-15469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE888EECE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C328B1C3422D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EC61514E8;
	Wed, 27 Mar 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYHPGXJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9812EBC4;
	Wed, 27 Mar 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566142; cv=none; b=TJC2zj12O4ThTg00v4SI9PNDiWiO+qUeHB0Fi9rGhskmx0aWBk78FKV8mORJuBjurXx+Baq7fOFiimy/iXtuWESlSPTDTpuqoqXxWIpHfPD3bEL6H7lWA5rwVg3igWAhEXATxou16X5q353Z8cjGbc9idzmEgSGVeLmw6f1/WTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566142; c=relaxed/simple;
	bh=Mkjkay7Z0Vj+E8vwdVGwj0OsZgK9nBJ7enE6cPyGExw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdewmW++iMtfjVPAyJYu/P0E+ZyUHOwIf+D7U4gBM+AbbJd6jxiSocCsWHWMXTTSYos0vUHxLPvg9/OPnG/MjJc+pXUZi72uzzxj7pSieGxI7C7ZoVW8/koYrFEB+k+2WACaXYXq0cqyxyE9OUwDfGGXiPc/KPmHz74tAOX56wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYHPGXJ3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33fd8a2a407so61157f8f.2;
        Wed, 27 Mar 2024 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566139; x=1712170939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G43Y9I+3uus2Fv/YCLNGCC6IN7NsddtveLn+lJcwAXE=;
        b=UYHPGXJ3PPkqIeKVia220JRIT2Mq5ZI9ahYFTwPWE6QsdixEs6MV0i/+rtxhe9prLh
         /JWeed8ZDDmU5px4kx1jf6pgqxGa3/vwdSlxmIODqjTwIdl91IIo5WfLcR66eQxGYfOM
         5VcdRh1jqGyDEAST+7nqacKRrcZyiP80qvPVDSYZql6ZZyFhhSsPMISHXOVxMe37t0q5
         73nJwoX6McszcNwbP1CUXXrZRzh3qai8Hc11f7hkprwLNXbzU+D2mNLJmvIO1nQjlkRo
         lBTH/hIh7JKon2iPflrEZw8k1N5ctVl8Ar/RS+37D3iDi7J1WEqZ25nfnYlDc/W6SKMJ
         Y7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566139; x=1712170939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G43Y9I+3uus2Fv/YCLNGCC6IN7NsddtveLn+lJcwAXE=;
        b=Dv9p5/FMr/rgf67WB86azqkrrmZDfAlqHe8BbmUUfA2UKVuAXV4mFR2hxx+H/cd7K7
         hIxEZFmQa4x5xKT+fEp4fH7NRrZ8jkf8wwVlDvWeGCbYZZr3XMhsHMpBNpSt5cytA+Vj
         ksKCb4xpt6iaWWEQqwI/+JFmKfH/+I3/Ne6pgIjcMUJ67PW0TvC2gw7YgXYMmRGnWZP4
         2LnBnjJgk3qT11Nq6Q5OP8nhEbxUYX6WVBcBUTEFmoPDBDwyA81Wp5ETFOHVtIzHxmMP
         zTHv3DjGp/O28Q4qI7iOiVlpTnJl9GwNJyROCI4zxpvoZdKM9Is/oCAliGBxbtk1JaOR
         /PFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhIDoa0MX9FFtcR9MV8S2zWQzPfW+MChouNEH9perUpWZ0RVL2FIuUzYXPuVYnSRLcU5K0VMwgnaNZdsIKQmaQiyaX0EgdoN+nEXAIRmZZUeTu/TDYh9TjjtB6EYCV4m9DhlG5s98/136mnpygcEHEhSE/sTLVJa+bQ+jkWeNfVTkVVjmwEqiD5aNXlhKnZLYSvTrza3KMpg==
X-Gm-Message-State: AOJu0YzmXagCvwkmEN3FLd9NZeTBX1nr7oS9XZH3+yx2qiPgaHSZSsjN
	U0WrMdDofkCmDmwP2lyoU3FGireASSr7PfK26s5Y4Ojuei/TpcB8RMxrDUYkkVb5/WSDIu1n8oc
	NIVN6AalzvB3c6VztWOinUz7AVrI=
X-Google-Smtp-Source: AGHT+IF3uK8BNj55j5GBkzVOsoRtME4sRuRyuXZ1Yo73eCITL53hu+yrnhHrXwg4fZIQHBJexfPsMc5dhyeUKDaRz0g=
X-Received: by 2002:a5d:6e0d:0:b0:33e:7896:a9d7 with SMTP id
 h13-20020a5d6e0d000000b0033e7896a9d7mr601323wrz.67.1711566139396; Wed, 27 Mar
 2024 12:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000055ecb906105ed669@google.com> <20240202121531.2550018-1-lizhi.xu@windriver.com>
 <ZeXGZS1-X8_CYCUz@codewreck.org> <20240321182824.6f303e38@kernel.org>
 <ada13e85bf2ceed91052fa20adb02c4815953e26@linux.dev> <20240322081312.2a8a4908@kernel.org>
 <20240327115328.22c5b5a3@kernel.org>
In-Reply-To: <20240327115328.22c5b5a3@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 12:02:08 -0700
Message-ID: <CAADnVQJ2SyJq25wvV2kf8Mepic_rYyGNYh7KpdGerFi6a-jQJw@mail.gmail.com>
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>, asmadeus@codewreck.org, 
	Lizhi Xu <lizhi.xu@windriver.com>, 
	syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, v9fs@lists.linux.dev, 
	Linux Regressions <regressions@lists.linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 22 Mar 2024 08:13:12 -0700 Jakub Kicinski wrote:
> > On Fri, 22 Mar 2024 14:26:07 +0000 Eric Van Hensbergen wrote:
> > > Patch is in the unapplied portion of my for-next tree along with
> > > another one.  I was hoping to hear some feedback on the other one
> > > before i did a pull request and was torn on whether or not I wait on
> > > -rc1 to send since we are so close.
> >
> > My guess would be that quite a few folks use 9p for in-VM kernel
> > testing. Real question is how many actually update their work tree
> > before -rc1 or even -rc2, given the anticipated merge window code
> > instability.. so maybe there's no extreme urgency?
> >
> > From netdev's perspective, FWIW, it'd be great if the fix reached
> > Linux before Thursday, which is when we will forward our tree again.
>
> Any progress on getting the fix to Linus? I didn't spot it getting
> merged.
>
> I'm a bit surprised there aren't more people complaining TBH
> I'd have thought any CI setup with KASAN enabled has a good
> chance of hitting this..

The proposed fix is no brainer:
https://lore.kernel.org/all/20240202121531.2550018-1-lizhi.xu@windriver.com=
/

+ v9fs_stat2inode_dotl(st, inode, 0);
  kfree(st);
  if (retval)
    goto error;

- v9fs_stat2inode_dotl(st, inode, 0);

Please ship it to Linus asap.
I'm surprised this bug slipped through.

It does affect bpf developers and our CI, since we run with KASAN and use 9=
P.

