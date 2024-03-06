Return-Path: <linux-fsdevel+bounces-13683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B517872F7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5CB1C25E80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485B5C8E7;
	Wed,  6 Mar 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et1cWynJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A65CDC3;
	Wed,  6 Mar 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709650; cv=none; b=WPpJUCIz5HwtqmkdzQquqcjGdJy8vVR6kTnoHkM6uB1alxyxlMkqkr6Z7fpqUyq5FClTotUBEJKtNfxmGke9KsJVr2Y1o2HKkSEz95Ymb56Tgp4FFlXhduWZtd2C6o5wL16WvftPLu1PcegdL5Fzl8DW5RvWji/Qs7pn0PG2nsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709650; c=relaxed/simple;
	bh=pFoV/VguqY/NSp1xnqNqe6GOvN0JgkhoKCuylStQfD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV3L2VgGDHcegQK9Pawv6KwqBju79xS1sGulb1OP5kEwDbkhBNdMXzguNeeUih0Qx9HCV06m+1ZrKIr/SiJKPKjfDizVdBh4vLu77imP53776ERht2Kwz3p/a2bxo+59ntzWk+P8y1K6KfRuewNt7zenZ1cGrz4wNWNRdgMNkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et1cWynJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d28051376eso89326871fa.0;
        Tue, 05 Mar 2024 23:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709709646; x=1710314446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q29JTqGy0mFIQJdxfat2AsoxuWRo7RMedizkOOPFqY=;
        b=Et1cWynJC502XEYxomT6stinrGUQZzuVB4MtEHkOSBAv3fEz91ORQDnLbBqumDjIgV
         AixtdtLo6hbMnnpHtG4nxXfrFcjtOM5siVLGrVQUw+gnoZPDR67Wd9pRGpRs0CkRClQ9
         lYjjfRWBuLSuc2PiCf/ZEiIzr9xEr17LsQ24fww5d8KEu0f+yLSJ9c9eH1SKq1V9Vtsf
         v6gMLgZA9UINjLVqglvfU6jbWe4RZlqEdYxARwkqeHSeYLvTEORlyQabhBA9RLu/hfbY
         cE/n7GI1JERMJI7//0WQ8OJ83uWbd5nGGFrT7NJXw23WWH9HHDZJtf7nWBNt4+I2RTjE
         n1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709709646; x=1710314446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q29JTqGy0mFIQJdxfat2AsoxuWRo7RMedizkOOPFqY=;
        b=JV1pMc+Rbn/fuNsSKr0SxXftM64dyoCxdhxMGpV8ivuzCD96FNPV1zC0Z7nw91P+5C
         lirvMyScOtzfgT8J4EGdxqf1yQBX94oXClskU0Q7bSOmlOoMlzMhs2sOf3zy//4v/Py0
         flYTo5XMgpWgfz/cXCNMBK6OMotD2mFLyT29MO/HDAMU82LBwbV/Q0dfMa1jxSw/FXL3
         eZUTYYTnkRDRVfBqDs2uV6sMULK4JwC1tT38ArvBTprgOtgbZ3Rt6SCz2CNfYVThwiXs
         gtt4a1q+0OhR+DgLkN1dDJ8+n66ViUaaR773q5GlwE06RSMjwaNmmv/R58S4nzokE0LC
         Zx+w==
X-Forwarded-Encrypted: i=1; AJvYcCWQD06fqilXq7CCG0vTw39RAGvrJRX6qzam1GwkIZK15Xmv/FBlIxSKQ41CsVjABwfxL6blCGqv3RYU+oztniaiB93RGVjkHwyBXjltzpAqA6p6LpZR+wTQZW36MVgthiKfLtzNmajor3g+nBR8xWAc3/b3sp8HRPnqepSG0jo6FHgsu5t/xAtK
X-Gm-Message-State: AOJu0YxCSPzpUPnfqJ7ael2kHg9C80ZO/Yo/6qg7UHpgO7nJD768n9Pq
	0aO9bRxzxkRULeq6GQdOliswhCm1BW7jXG5VUwHEuBaTCeZofR90WWNDA095VwEnWgTQtRyGJf7
	KBOQY93UFfieOreN1YTlPKEuYfkI=
X-Google-Smtp-Source: AGHT+IFM6US1C9y949dv+pLB538wUYBhybQPr8OT5Rxcw/ngdS0UAvRzxwIo7rLNcuY+P11NmgdGuJIfm60z8qg4ZOc=
X-Received: by 2002:a2e:834c:0:b0:2d2:9f41:2fc4 with SMTP id
 l12-20020a2e834c000000b002d29f412fc4mr2733482ljh.27.1709709645981; Tue, 05
 Mar 2024 23:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLz8V-CMiZK0Gzz=eXf2G3E-psemp2pMZwZ_XJG53GawgA@mail.gmail.com>
 <CAKFNMomdU5RHVMt2CCXYMAb5oyjDwOVRitNM+XGGC65TQs1ECQ@mail.gmail.com> <CABOYnLxE86iTqTA3BOMLPHX5SeB--46S_4nec7H18H7B4oEi3w@mail.gmail.com>
In-Reply-To: <CABOYnLxE86iTqTA3BOMLPHX5SeB--46S_4nec7H18H7B4oEi3w@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 6 Mar 2024 16:20:29 +0900
Message-ID: <CAKFNMomM0i1mOwkFsBta4rO+gDB1_LjSF_mENkB=PGF6a-tW-A@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs
 (2)
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+47a017c46edb25eff048@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:07=E2=80=AFPM xingwei lee wrote:
> On 3 Mar 2024, at 20:45, Ryusuke Konishi <konishi.ryusuke@gmail.com> wrot=
e:
>
> Hi, sorry for the delayed response.
>
> I test my reproducer in the linux 6.8-rc4 with KMSAN kernel config for on=
e hours, it doesn=E2=80=99t trigger any crash or report as follows:
>
> [  315.607028][   T37] audit: type=3D1804 audit(1709708422.469:31293): pi=
d=3D86478 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  315.608038][T86480] 884-0[86480]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14 likely on CPU 2 (core 2, socke)
> [  315.611270][T86480] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  320.575680][   T37] kauditd_printk_skb: 1253 callbacks suppressed
> [  320.575689][   T37] audit: type=3D1804 audit(1709708427.439:32130): pi=
d=3D88573 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  320.576419][T88575] 884-0[88575]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14
> [  320.576695][   T37] audit: type=3D1804 audit(1709708427.439:32131): pi=
d=3D88574 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  320.579042][T88575]  likely on CPU 0 (core 0, socket 0)
> [  320.584184][T88575] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  320.593832][   T37] audit: type=3D1804 audit(1709708427.459:32132): pi=
d=3D88578 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  320.594549][T88580] 884-0[88580]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14 likely on CPU 1 (core 1, socke)
> [  320.596256][   T37] audit: type=3D1804 audit(1709708427.459:32133): pi=
d=3D88579 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  320.597901][T88580] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  320.610954][   T37] audit: type=3D1804 audit(1709708427.479:32134): pi=
d=3D88583 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  320.611700][T88585] 884-0[88585]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14 likely on CPU 2 (core 2, socke)
> [  320.613455][   T37] audit: type=3D1804 audit(1709708427.479:32135): pi=
d=3D88584 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  320.615959][T88585] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  320.628571][   T37] audit: type=3D1804 audit(1709708427.489:32136): pi=
d=3D88588 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.582663][   T37] kauditd_printk_skb: 1280 callbacks suppressed
> [  325.582673][   T37] audit: type=3D1804 audit(1709708432.449:32990): pi=
d=3D90727 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.583320][T90729] 884-0[90729]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14
> [  325.583460][   T37] audit: type=3D1804 audit(1709708432.449:32991): pi=
d=3D90728 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.585838][T90729]  likely on CPU 1 (core 1, socket 0)
> [  325.590985][T90729] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  325.599620][   T37] audit: type=3D1804 audit(1709708432.459:32992): pi=
d=3D90732 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.601818][T90734] 884-0[90734]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14
> [  325.601827][   T37] audit: type=3D1804 audit(1709708432.459:32993): pi=
d=3D90733 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.603945][T90734]  likely on CPU 2 (core 2, socket 0)
> [  325.607037][T90734] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  325.617928][   T37] audit: type=3D1804 audit(1709708432.479:32994): pi=
d=3D90737 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.618862][T90739] 884-0[90739]: segfault at 5c7ade ip 00000000005c7a=
de sp 00000000200001f8 error 14
> [  325.620190][   T37] audit: type=3D1804 audit(1709708432.479:32995): pi=
d=3D90738 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
> [  325.623238][T90739]  likely on CPU 0 (core 0, socket 0)
> [  325.623803][T90739] Code: Unable to access opcode bytes at 0x5c7ab4.
> [  325.632693][   T37] audit: type=3D1804 audit(1709708432.499:32996): pi=
d=3D90742 uid=3D0 auid=3D0 ses=3D1 subj=3Dunconfined op=3Dinvalid_pcr cause=
=3D0
>
> It=E2=80=99s seems this issue have been fixed.
>
> I'd like to isolate that the issue is still not fixed with the latest
> fixes, but I need to do some trial and error to reestablish a testable
> (bootable) KMSAN-enabled kernel config.
>
> Thanks,
> Ryusuke Konishi
>
>
> I hope it helps.
> Best regards
> xingwei Lee

Thank you!
That helps a lot.

Regards,
Ryusuke Konishi

