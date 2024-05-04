Return-Path: <linux-fsdevel+bounces-18739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88658BBE19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 22:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121451C20ACD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99E83CDB;
	Sat,  4 May 2024 20:51:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640561EB3A;
	Sat,  4 May 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714855869; cv=none; b=tvdBguhFc/70ag5AFtRI9MjMNjOFYeRDv104oHxwFjF9sRYd1n8jsL7+JhI1GlhCoRoRQ6tQ+doyJS1S46pc3DjmDMucdXa71ooeXODWR3Vk4WQtPo02kD6bUe8OT5oD8IfBz6Wd8r7SzA8JIDKri4YldSQFSRf9L1whN3MvYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714855869; c=relaxed/simple;
	bh=9uJfWXMR03eNE2YUUTCfyyDgkZyNICSSak1xKBcsiBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1Yyv5KQ1okstqZ6cEu2FHGxxHelVHSZwqA2ZblGp0qT6FASL14DAzZnkQ07UuHmIwY+QzdYCK1BnWVUiMaSFdf+T53bXK+tKs2YSPd2RcKMbOqyJeqgLFKgu2IncTtwOPzg4l3awsbKMzEk39/VKuG/+ordpBjc/Z4rN824I/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=valtier.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=valtier.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-deb65b541faso446303276.0;
        Sat, 04 May 2024 13:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714855867; x=1715460667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPCniJ/STVhyaGQN5FVTwiFqhAYGUie52dbeOASHZFo=;
        b=l0MYLe+RWP9cDOr0UGDmLaIvteUUCsTe0hH5fxyrEC1KAxVf2e53j34ITV4BeDP+48
         V49vEX5J/NMvESirG+SRBxKJLo3oeI5rpxmHZSrqERdFl+yVsPbvuY7skt8Kl0YAHw8A
         w4N9CXufLiQLHK1a7ybjFBgsb12lGT4UiXRJSLub8EHixEqSv3NBn0bgqBfwm4+79FGK
         fXWtpiWS1tAPSszNlBvdWLSOgZ/wUjN3IP5lmoi+llaRZ2fpwqvZExNm3ALU7eHZ+hwb
         I56x6h6isAFVV2Uq1oSINAMyQJ8h52Pqj1jnJg32KkGTM4ANHd4au/K6MEklxb45A7se
         swhw==
X-Forwarded-Encrypted: i=1; AJvYcCUIaq6h9I6/IXp8RHWuJ2m0V6OY19qB8pwbiEkX5nTc8ikR6J53Bc6KHaskO0E9DoDpQM1orcCfssFuy7Bbss/OZ2mNSGgKoyDbjSpdgoey0aL8oetXcmuWeDylQOvKW9mbqeHZIObSGKZg7g==
X-Gm-Message-State: AOJu0Yw/zci706T3BbvRpnMl4rjpT1LZu4P2KPzpBO2Xp+Vh31PMsE9i
	3CsPK36CFhB/kgAcWTRLb+PWb0xGD3PGPcNb7PqM1fZz635AJa8xAYa73ePXbNWq940l9TWO+AT
	EAeuLGLJmelPEXn0LKPknQMZ8lDY=
X-Google-Smtp-Source: AGHT+IEnoawDU3gTITS5ni/drqQmAdCb0Tjso8UnkpjmJWJSfn9hNs/QIaQvKAZp2IuTz/yro/5XQv2GbRGW9g5y7Ms=
X-Received: by 2002:a25:d0c9:0:b0:dc3:7041:b81b with SMTP id
 h192-20020a25d0c9000000b00dc37041b81bmr6993350ybg.36.1714855867412; Sat, 04
 May 2024 13:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com>
 <CAOQ4uxjh5iQ0_knRebNRS271vR2-2f_9bNZyBG5vUy3rw6xh-g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjh5iQ0_knRebNRS271vR2-2f_9bNZyBG5vUy3rw6xh-g@mail.gmail.com>
From: Hugo Valtier <hugo@valtier.fr>
Date: Sat, 4 May 2024 22:50:35 +0200
Message-ID: <CAF+WW=rRz0L-P9X2tV9svGdTbhAhpBea=huf-_DDfkz29fXUyQ@mail.gmail.com>
Subject: Re: bug in may_dedupe_file allows to deduplicate files we aren't
 allowed to write to
To: Amir Goldstein <amir73il@gmail.com>
Cc: mfasheh@suse.de, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> My guess is that not many users try to dedupe other users' files,
> so this feature was never used and nobody complained.

+1

Thx for the answer, I'm new to this to be sure I understood what you meant:
> You should add an xfstest for this and include a
> _fixed_by_kernel_commit and that will signal all the distros that
> care to backport the fix.

So right now I wait for 6.9 to be released soon enough then
I then submit my patch which invert the condition.
Once that is merged in some tree (fsdevel I guess ?) I submit a patch for
xfstest which adds a regression test and has _fixed_by_kernel_commit
mentioning the commit just merged in the fsdevel linux tree.

Le sam. 4 mai 2024 =C3=A0 11:43, Amir Goldstein <amir73il@gmail.com> a =C3=
=A9crit :
>
> On Sat, May 4, 2024 at 7:49=E2=80=AFAM Hugo Valtier <hugo@valtier.fr> wro=
te:
> >
> > For context I am making a file based deduplication tool.
> >
> > I found that in this commit
> > 5de4480ae7f8 ("vfs: allow dedupe of user owned read-only files")
> > it states:
> > > - the process could get write access
> >
> > However the behavior added in allow_file_dedupe now may_dedupe_file is =
opposite:
> > > +       if (!inode_permission(file_inode(file), MAY_WRITE))
> > > +               return true
> >
> > I've tested that I can create an other readonly file as root and have
> > my unprivileged user deduplicate it however if I then make the file
> > other writeable I cannot anymore*.
> > It doesn't make sense to me why giving write permissions on a file
> > should remove the permission to deduplicate*.
>
> True. Here is the discussion about adding "could have been opened w"
> to allow dedupe:
> https://lore.kernel.org/linux-fsdevel/20180517230150.GA28045@wotan.suse.d=
e/
>
> >
> > I'm not sure on how to fix this, flipping the condition would work but
> > that is a breaking change and idk if this is ok here.
> > Adding a check to also users who have write access to the file would
> > remove all the logic here since you would always be allowed to dedup
> > FDs you managed to get your hands on.
> >
> > Any input on this welcome, thx
>
> My guess is that not many users try to dedupe other users' files,
> so this feature was never used and nobody complained.
> What use case do you think flipping the condition could break?
> breaking uapi is not about theoretical use cases and in any
> case this needs to be marked with Fixes: and can be backported
> as far as anyone who cares wants to backport.
>
> You should add an xfstest for this and include a
> _fixed_by_kernel_commit and that will signal all the distros that
> care to backport the fix.
>
> Thanks,
> Amir.

