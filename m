Return-Path: <linux-fsdevel+bounces-13764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7AC873A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ACD1F26822
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFED134CCC;
	Wed,  6 Mar 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5LZlQPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348D133402;
	Wed,  6 Mar 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737420; cv=none; b=L5+p8wMlhhcItbUtcxTTHc7WNAu2UK5NAAUm3BNxhb3Fcy4yWG9sT1drUrp/+5N5rvJ72+eRWjoaP+Fsxxs15a29rGgJPpJ5goEAzY6lHN4cxPgjGSZIo1OoaRLMln1OcsKnUW55xN2/giDnKPMX9LSqzrXkFoWBaHgC8jqIUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737420; c=relaxed/simple;
	bh=Vmpa/qr22uEjdXQqzFUUaPtJdIje6Z7IfI92Npf8qXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVEkgXSIGk9NMoLQmJjchuX7V0CcneRFtiaJF8YYaDYQQmmkLZPmYfMv0vZ1qrXW9vyXtvwk7sU89sBqWgOGBNjgE/aYeYEx/G3Ix/dFam0eHaQfLjweR5h55hFMtneKpltC/khv83cy9FH6TkhyssBAWu05TG+fcGCEdUYawks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5LZlQPT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso85925541fa.2;
        Wed, 06 Mar 2024 07:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709737416; x=1710342216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLRhOa/VEHrwVicHu75uCn3tRw6+UafQ6T3s8RssrHA=;
        b=j5LZlQPTk++HUyk5KrDWRU1pQkjMF5636LmDs8Op6XWl1ZQ1U58er1DRP8T2nOgUns
         lMNqHCkng3fiOPKPhsOP3ewI4NDSUJGcQUvlV/06LbhIneoXlV8cp8Nbf3ShbHM5GEn6
         qx5/nGy+g/veGPShNnX/S48oqbs7SuOJ7wADev7ksmPyaxV0SAALCnBDiuUg1mHfG7rD
         WHRYlfpKAeLTdY6Fmt6/oSL0IyhhwIIixB+XX/V+KNowwTVfaAV8RXyA9lB2jlBiblBp
         3/9zU29Pth6B4ZdwvA7viu62DSJ1etkxltAsOSYdrEDjMSk5GOUgm7nF3VhHxwP7XxDV
         38Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737416; x=1710342216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLRhOa/VEHrwVicHu75uCn3tRw6+UafQ6T3s8RssrHA=;
        b=OB/UZFaI7fJXFwOCP5PoLf56bO1ZFcrs5H3ZMUiv5ANMIh52II6g74aWqXy9eSfkCY
         /XaEN/AKMlp/ho9iIbrn3OJMOxxVzfK/VHlyxCEO40wMh+hhs0c8maO3/3tIh4gJgR0d
         IazSsKuz7nswp0nn+R90VI4bQ++7nR4OhV4SRvgIlBY3D8O9aozqR3/OnafFsQXBOMpe
         iVM4pREJpc7P0L4slGbqR5e6ucXfWD/Y1mGJ1pnacqrgAP8IQzW/j7LiRCkaEhXbyxMF
         OTaKBXVIr7FqdOVlE5ZEbkZwQHrXzn0sRZ8EUv+enIxkGDt1uCXqTwrQJvNz474oedZs
         SAdA==
X-Forwarded-Encrypted: i=1; AJvYcCWdGFvAaE1mxU6rklLL/JitrQgfu7P+nUK7HLjscz2mJxkw0n1J7sNO/RhxdldnGr/Pu1rFqyX6+oEHO6uqAhVHsxc3+yJGhhI31UNwCNHwHTzZqfuv0kF10mZb6POUHFz5xCF3K5hUsITMGbz+YFP+Ps5Fo/+nX6m64U/Pyc9E1A9SInWm/YMS
X-Gm-Message-State: AOJu0YzdGxH0dAC21d8FQf35hsv664WYL37D7VPH1S1iz7qN25XsGoQ3
	MP/vofdtjaI7UTmh6CrF06h65G31j5BkM6QCuSHS+jvVhWvglgdqr97ljc5SLxwQKGrmi8W+IJy
	kBLiqoD+krHsuJ39UxCWRKMyIXCs=
X-Google-Smtp-Source: AGHT+IGUstqb46rDRskzavCFfceGJ4GNfCXdrMwaRfZeZhq56pJS9/mVX2h9/y3coq1WgQfYZxWuTcKXS1Ko4BzHDRA=
X-Received: by 2002:a05:651c:620:b0:2d3:469b:3dca with SMTP id
 k32-20020a05651c062000b002d3469b3dcamr2947914lje.50.1709737416193; Wed, 06
 Mar 2024 07:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLz8V-CMiZK0Gzz=eXf2G3E-psemp2pMZwZ_XJG53GawgA@mail.gmail.com>
 <CAKFNMomdU5RHVMt2CCXYMAb5oyjDwOVRitNM+XGGC65TQs1ECQ@mail.gmail.com>
 <CABOYnLxE86iTqTA3BOMLPHX5SeB--46S_4nec7H18H7B4oEi3w@mail.gmail.com> <CAKFNMomM0i1mOwkFsBta4rO+gDB1_LjSF_mENkB=PGF6a-tW-A@mail.gmail.com>
In-Reply-To: <CAKFNMomM0i1mOwkFsBta4rO+gDB1_LjSF_mENkB=PGF6a-tW-A@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 7 Mar 2024 00:03:19 +0900
Message-ID: <CAKFNMom7z+XG4J1sRC2aJ25aJZNzkUkrUtDnHa1LKDY-+0sbfQ@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs
 (2)
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:20=E2=80=AFPM Ryusuke Konishi wrote:
>
> On Wed, Mar 6, 2024 at 4:07=E2=80=AFPM xingwei lee wrote:
> > On 3 Mar 2024, at 20:45, Ryusuke Konishi <konishi.ryusuke@gmail.com> wr=
ote:
> >
> > Hi, sorry for the delayed response.
> >
> > I test my reproducer in the linux 6.8-rc4 with KMSAN kernel config for =
one hours, it doesn=E2=80=99t trigger any crash or report as follows:
> >
> > [  315.607028][   T37] audit: type=3D1804 audit(1709708422.469:31293): =
pid=3D86478 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  315.608038][T86480] 884-0[86480]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14 likely on CPU 2 (core 2, socke)
> > [  315.611270][T86480] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  320.575680][   T37] kauditd_printk_skb: 1253 callbacks suppressed
> > [  320.575689][   T37] audit: type=3D1804 audit(1709708427.439:32130): =
pid=3D88573 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  320.576419][T88575] 884-0[88575]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14
> > [  320.576695][   T37] audit: type=3D1804 audit(1709708427.439:32131): =
pid=3D88574 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  320.579042][T88575]  likely on CPU 0 (core 0, socket 0)
> > [  320.584184][T88575] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  320.593832][   T37] audit: type=3D1804 audit(1709708427.459:32132): =
pid=3D88578 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  320.594549][T88580] 884-0[88580]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14 likely on CPU 1 (core 1, socke)
> > [  320.596256][   T37] audit: type=3D1804 audit(1709708427.459:32133): =
pid=3D88579 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  320.597901][T88580] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  320.610954][   T37] audit: type=3D1804 audit(1709708427.479:32134): =
pid=3D88583 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  320.611700][T88585] 884-0[88585]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14 likely on CPU 2 (core 2, socke)
> > [  320.613455][   T37] audit: type=3D1804 audit(1709708427.479:32135): =
pid=3D88584 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  320.615959][T88585] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  320.628571][   T37] audit: type=3D1804 audit(1709708427.489:32136): =
pid=3D88588 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.582663][   T37] kauditd_printk_skb: 1280 callbacks suppressed
> > [  325.582673][   T37] audit: type=3D1804 audit(1709708432.449:32990): =
pid=3D90727 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.583320][T90729] 884-0[90729]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14
> > [  325.583460][   T37] audit: type=3D1804 audit(1709708432.449:32991): =
pid=3D90728 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.585838][T90729]  likely on CPU 1 (core 1, socket 0)
> > [  325.590985][T90729] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  325.599620][   T37] audit: type=3D1804 audit(1709708432.459:32992): =
pid=3D90732 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.601818][T90734] 884-0[90734]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14
> > [  325.601827][   T37] audit: type=3D1804 audit(1709708432.459:32993): =
pid=3D90733 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.603945][T90734]  likely on CPU 2 (core 2, socket 0)
> > [  325.607037][T90734] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  325.617928][   T37] audit: type=3D1804 audit(1709708432.479:32994): =
pid=3D90737 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.618862][T90739] 884-0[90739]: segfault at 5c7ade ip 00000000005c=
7ade sp 00000000200001f8 error 14
> > [  325.620190][   T37] audit: type=3D1804 audit(1709708432.479:32995): =
pid=3D90738 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> > [  325.623238][T90739]  likely on CPU 0 (core 0, socket 0)
> > [  325.623803][T90739] Code: Unable to access opcode bytes at 0x5c7ab4.
> > [  325.632693][   T37] audit: type=3D1804 audit(1709708432.499:32996): =
pid=3D90742 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cau=
se=3D0
> >
> > It=E2=80=99s seems this issue have been fixed.
> >
> > I'd like to isolate that the issue is still not fixed with the latest
> > fixes, but I need to do some trial and error to reestablish a testable
> > (bootable) KMSAN-enabled kernel config.
> >
> > Thanks,
> > Ryusuke Konishi
> >
> >
> > I hope it helps.
> > Best regards
> > xingwei Lee
>
> Thank you!
> That helps a lot.
>
> Regards,
> Ryusuke Konishi

Ahh.  Looking at the February 28th syzbot crash, it appears that this
issue still exists in recent -rc releases.
So I'm going to investigate without closing it.

Regards,
Ryusuke Konishi

