Return-Path: <linux-fsdevel+bounces-16716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1115B8A1C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA48E2858F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1619DF5F;
	Thu, 11 Apr 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKP11z7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9919DF41
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852563; cv=none; b=SMeQKmZ6l0D7XCWZTJgvVMkanY0kPOAYljrouDAAh2uPTmPTVwoX0yq6p4HHl6Q7o6cdwY7lj32tV4KhUdBHFgFlaq3UdUNO1JA9FLI8y7Ighx2iyxckH/czXQtQnXLYmUnYMjqw42o8INw4br1QpVbMxZmtq2jyqT+3N+KoElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852563; c=relaxed/simple;
	bh=2MRqjFE0eZSv+X5pf9AP6+j/LDQ8Hs1sQvNfVGBv4ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhBDrhcdG+VWxV+XKgHfDLLBC++YLNd0E5NyKgC4qdnyM6wKqveapHsA16wcQHGbmDFqCsRo8/rCJqIer0SYuVVbCWs5c2pQsJkKaHwTF9p96FbNWka1M17Eoe4VIHBpwEGUGCTLJKRI83YtN6HvT+++xzB+ViXxiy8SS2TpR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKP11z7I; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d5751901bso370261385a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712852561; x=1713457361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpaqd4lR8cXXUejBxBp0vM8qhyGcYOiHx0i3p2D9+yg=;
        b=UKP11z7IddXVyn2CbkhWBvqQSOb113Vbr81DmYy2tMCnQxj0OU2HL84IOVCweGsBM+
         yAaat1YdQIBLqfZQmzTcTNs5MzeaGDuHVh9j6ZcsjQubtbP01msRJYxRDmODcKwXP3pq
         JFfNm9quJu1HJeAbtA9OBlk6ypBbQgMQFY3viSVKy3QoNpQBV2p2rBGyJA+HY6+Ovl29
         cBRB65zklJkvGdw4vxzG6clEGNmQfDvoexEG+Q8E16olYcreXFWtifaZiMzhVbL+45aA
         SGlqGC3xXGely+YQWBxluSjOR+19UCooViPjPjaDe5lht4p8VawpmnlQHHMc31T8bQG2
         Dxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852561; x=1713457361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpaqd4lR8cXXUejBxBp0vM8qhyGcYOiHx0i3p2D9+yg=;
        b=eZvbRDYarEePkkGej2Pt4s0668htkr9WwFd5maTSswE051+yQqcVOImqlknuSp51rq
         ZFF7yeS3v1q/csIgaROCrBSTOblL+Au4VIOTqMNCBBMh6lEg59PKH7CFxuNjtwhLuusG
         Y3GUqNA01GFbl7DxCQ2dO3jtpMz2826FvP3oTtQclp62uSw75MWSJUs92Bw8E8YYcRIv
         v8wKKwXTG4g0hv7zuryyATm2ijPDMplPfvzGjlPpb23Hc1l48k6QnWpOmiW2XQYcnbtr
         ngu2/pWFjjShJe5vrdzvcvlPtl8M38Eu8mMEe5YZVYt//r5Hbv82I6oKOxD4PlVBWHrj
         hrjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN8L0AwnOfavLR/7xDY0Lcb6zUQt6ToMRE+ufDqSHsNaJuX1cBgA/XbGLYiBxIoNPEqz60ILB24Kjbqgpwoxp7gAXSVE/ClVZlAzmtkA==
X-Gm-Message-State: AOJu0YyX8wMxtbBgy0Ooiqkst7FMobukeSD1OIWqwf5bq+DJl3dOonF4
	qc61nu+4/yzNEbqhFOS8npr3WXsbdUYQ7ZwJWAHc+lWPSUdOb92N/FZcaoTXyJBQuquKKebSEc7
	ZgQ0meF+gkrL+yGze7hraWlp4f7fS2pr8
X-Google-Smtp-Source: AGHT+IF1n1MmiItwvOWqgMgv4m4+n4I8Y3auG+nptwY+6Z23ewfnl3nk+P/BfPeOzUZb+UqPnkngS/WuwG3g9BJWMJk=
X-Received: by 2002:a05:620a:b4a:b0:78d:61a4:6955 with SMTP id
 x10-20020a05620a0b4a00b0078d61a46955mr106103qkg.67.1712852560673; Thu, 11 Apr
 2024 09:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404101624.85684be8-oliver.sang@intel.com> <CAOQ4uxgFAPMsD03cyez+6rMjRsX=aTo_+d2kuGG9eUwwa6P-zA@mail.gmail.com>
 <20240411115408.266zydqiwalko5k3@quack3>
In-Reply-To: <20240411115408.266zydqiwalko5k3@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Apr 2024 19:22:29 +0300
Message-ID: <CAOQ4uxj_KnD3uZPTt6HR3sRynsHOxqH4YcyJG5pb-12dWQNDQw@mail.gmail.com>
Subject: Re: [linux-next:master] [fsnotify] a5e57b4d37: stress-ng.full.ops_per_sec
 -17.3% regression
To: Jan Kara <jack@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:54=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 11-04-24 12:23:34, Amir Goldstein wrote:
> > On Thu, Apr 11, 2024 at 4:42=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > > for "[amir73il:fsnotify-sbconn] [fsnotify]  629f30e073: unixbench.thr=
oughput 5.8% improvement"
> > > (https://lore.kernel.org/all/202403141505.807a722b-oliver.sang@intel.=
com/)
> > > you requested us to test unixbench for this commit on different branc=
hes and we
> > > observed consistent performance improvement.
> > >
> > > now we noticed this commit is merged into linux-next/master, we still
> > > observed similar unixbench improvement, however, we also captured a
> > > stress-ng regression now. below details FYI.
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -17.3% regression of stress-ng.full.ops_p=
er_sec on:
> > >
> > >
> > > commit: a5e57b4d370c6d320e5bfb0c919fe00aee29e039 ("fsnotify: optimize=
 the case of no permission event watchers")
> >
> > Odd. This commit does add an extra fsnotify_sb_has_priority_watchers()
> > inline check for reads and writes, but the inline helper
> > fsnotify_sb_has_watchers()
> > already exists in fsnotify_parent() and it already accesses fsnotify_sb=
_info.
> >
> > It seems like stress-ng.full does read/write/mmap operations on /dev/fu=
ll,
> > so the fsnotify_sb_info object would be that of devtmpfs.
> >
> > I think that the permission events on special files are not very releva=
nt,
> > but I am not sure.
> >
> > Jan, any ideas?
>
> So I'm not 100% sure but this load simply seems to run 'stress-ng' with a=
ll
> the syscalls it is able to exercise (one per CPU if I'm right). Hum...
> looking at perf numbers I've noticed changes like:
>
>       0.43 =C4=85  3%      -0.2        0.21 =C4=85  5%  perf-profile.self=
.cycles-pp.__fsnotify_parent
>       0.00            +2.8        2.79 =C4=85  5%  perf-profile.self.cycl=
es-pp.fsnotify_open_perm
>
> or
>
>       1.77 =C4=85 12%      +1.9        3.64 =C4=85  8%  perf-profile.call=
trace.cycles-pp.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
>       1.71 =C4=85 15%      +1.9        3.64 =C4=85  9%  perf-profile.call=
trace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
>       0.00            +2.8        2.79 =C4=85  5%  perf-profile.calltrace=
.cycles-pp.fsnotify_open_perm.do_dentry_open.do_open.path_openat.do_filp_op=
en
>
> So the savings in __fsnotify_parent() don't really outweight the costs in
> fsnotify_file()... I can see stress-ng exercises also inotify so maybe
> there's some contention on the counters which is causing the regression n=
ow
> that we have more of them?
>
> BTW, I'm not sure how you've arrived at the conclusing the test is using
> /dev/full. For all I can tell the e.g. the stress-mmap test is using a fi=
le
> in a subdir of CWD.
>

Oh, I just saw the file stress-full.c in stress-ng and wrongly assumed that
test stress-ng.full refers to this code.

Where do I find the code for this test?

Thanks,
Amir.

