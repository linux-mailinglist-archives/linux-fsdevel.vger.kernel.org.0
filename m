Return-Path: <linux-fsdevel+bounces-36304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228C9E1225
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F9D282D29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED33148FED;
	Tue,  3 Dec 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm5ybSjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CED224F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198524; cv=none; b=eERy9jCk6GC7VbabgwMS+b2OREVnZA9L6sllzOYchRL+d6EfPcjk9Tx4nXczKAlGFiUHVzSQvynsRxnTMr7Qmoi15eE5zWFwPuq93c8JIpm0XiYFfuZ3KZ7N69XkfdByZd+FUKr+il5tKOAggKq4m12SiyPs2NSWxIrzSw4aL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198524; c=relaxed/simple;
	bh=Tm/yEmz3IrLylog3g/nFD1HOP3ktclopH8zdPWsSzeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojYvSOaOSqYgkaa20wmdCHXQPYvlec9wX0bVE77CxXoClyS4ccAtdkGMxL0xIIFZ+dohbXkT1K1sJMmP6A4qtgAdvJesKL62Kf64bF5JplMta+xmXwdRoT3boI+cAtgqg029v+c0xPrvhqcXp1xgkKvAwEU94EWCeQrcYPIbxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm5ybSjs; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8970e899eso16574236d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 20:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733198522; x=1733803322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X8Y07U9yxHamIdypE6q792whpe9/ZxQOzclBHHAZOQ=;
        b=Dm5ybSjskdSHAtPA9HF9ThGngzA3Y+p3JQ/AhZ8EwwIazH/kjB5GwL/sFmo1cmVddL
         h/LVi7/Hps9rLkF46Jp/7dziFTdy2SqQZVdjHaO2/+VqLrglB0/v9gGJvlowuAhMOLZV
         Q4uXJcUSO5GKtvYp66SSBx5qJv/sx+L6lySl0hJtzg0so8vv3UGx64xvHqPjvlYqtxch
         m1+i4ZZS8KaMJVaNUsFk92YXH8ehs2FBF4Qv8PIHno4xAtDxApwFVSt6BZSLPOAgt4LP
         gR/bwDm4vIHpOQ1/TSqvfVUa/Ue+WxuXiCOkCXqVj6BYT8sNKFKuK7wT+t7QaCyGkYDV
         q6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733198522; x=1733803322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X8Y07U9yxHamIdypE6q792whpe9/ZxQOzclBHHAZOQ=;
        b=LCUeICe+CUfmevA8+w/flgZhg3j9tWe7reYuIYEElmT9suEp7DgXhzS3z2ULIWn3ot
         gdw/T1F8Xoa0YYcpm+fpKPmJylacbCUxINl3rGP8VyiGrAgGco3qomgbDnSC4FzUj+o+
         S1XTpQ6wxvgCDye/tX9NYQM4tkzdNS4ixnttH2O/WifagU1jS4SjGlY1cQ/FvcYa1sDS
         OfKTAnCmnVSAc1ts3hc98A2PpszHrUhivJqIMRRzTTppWt16nSlbeR4IJfPVwAK5R9eN
         gET32UfzS0ftIMxKEjzqhZLxyFViVucAEMNa6mMvIHyAnRJSGxZjAwm/J3XEkuypxh5f
         PLlg==
X-Forwarded-Encrypted: i=1; AJvYcCXGoEIKW3aEW/Qz8+UsUikwfEjvBOL4fUBFkvcTJJVCPO2J9pk4/v8VRYGi3kI/v3MbzML0cqWdYHJhimrb@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFjGg+6QeS7vAW4Epaa/NQwqtUxdYWWijfFy4lJxN2zxA8UgQ
	Xano+Od2J02kjUVyetTIkl3msxdkGdhrChjxWZIVJWzKVAsvsQ8koRbbbyk63eY6aC7aWKxjh5G
	CBKVNLGzLTeZVsPUBbbH5kdE230zv7vMbXSGJejhF
X-Gm-Gg: ASbGncufoSoqtZr9wqvZmE8cIdUq+VtkAX1fKVHdBjSczvHpfH9e/zkD7vZhrJY6Ukx
	HfrxrxlzY31F6btTucxfBBaAfKikSrdAXKQ==
X-Google-Smtp-Source: AGHT+IEXBzm/tLO6RiqlhAJPHmbaD0LqRdtH35Qzpu3o4ZsoXCeFufIruh3si7nzifKpNcQnj6YSveHdkgzbLwaGRY4=
X-Received: by 2002:a05:6214:518e:b0:6d8:ae2c:503a with SMTP id
 6a1803df08f44-6d8b74320ebmr16394506d6.48.1733198522190; Mon, 02 Dec 2024
 20:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411292300.61edbd37-lkp@intel.com> <CALOAHbABe2DFLWboZ7KF-=d643keJYBx0Es=+aF-J=GxqLXHAA@mail.gmail.com>
 <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
In-Reply-To: <Z051LzN/qkrHrAMh@xsang-OptiPlex-9020>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Dec 2024 12:01:26 +0800
Message-ID: <CALOAHbADgrzykLPHqukZB1mtT10=fNm41hb0k_ONKJHqw3To_A@mail.gmail.com>
Subject: Re: [linux-next:master] [mm/readahead] 13da30d6f9: BUG:soft_lockup-CPU##stuck_for#s![usemem:#]
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 11:04=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yafang,
>
> On Tue, Dec 03, 2024 at 10:14:50AM +0800, Yafang Shao wrote:
> > On Fri, Nov 29, 2024 at 11:19=E2=80=AFPM kernel test robot
> > <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![usemem:#=
]" on:
> > >
> > > commit: 13da30d6f9150dff876f94a3f32d555e484ad04f ("mm/readahead: fix =
large folio support in async readahead")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> > >
> > > [test failed on linux-next/master cfba9f07a1d6aeca38f47f1f472cfb0ba13=
3d341]
> > >
> > > in testcase: vm-scalability
> > > version: vm-scalability-x86_64-6f4ef16-0_20241103
> > > with following parameters:
> > >
> > >         runtime: 300s
> > >         test: mmap-xread-seq-mt
> > >         cpufreq_governor: performance
> > >
> > >
> > >
> > > config: x86_64-rhel-9.4
> > > compiler: gcc-12
> > > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H C=
PU @ 2.90GHz (Cooper Lake) with 192G memory
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202411292300.61edbd37-lkp@in=
tel.com
> > >
> > >
>
> [...]
>
> >
> > Is this issue consistently reproducible?
> > I attempted to reproduce it using the mmap-xread-seq-mt test case but
> > was unsuccessful.
>
> in our tests, the issue is quite persistent. as below, 100% reproduced in=
 all
> 8 runs, keeps clean on parent.
>
> d1aa0c04294e2988 13da30d6f9150dff876f94a3f32
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :8          100%           8:8     dmesg.BUG:soft_lockup-CPU##=
stuck_for#s![usemem:#]
>            :8          100%           8:8     dmesg.Kernel_panic-not_sync=
ing:softlockup:hung_tasks
>
> to avoid any env issue, we rebuild kernel and rerun more to check. if sti=
ll
> consistently reproduced, we will follow your further requests. thanks

In your environment, can this issue be reproduced using the following
simple command?

 vm-scalability/run -c case-mmap-xread-seq-mt



--
Regards
Yafang

