Return-Path: <linux-fsdevel+bounces-20033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D88CCAAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 04:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92669280DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BAC4C9F;
	Thu, 23 May 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XySX8E8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D764687;
	Thu, 23 May 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716430938; cv=none; b=MkZsLd+l9uc7IkJ0ibsPqwJN/TPM4zrhifLNjVWATwjva9pZnSFnIrLsOYjo+barfHmAhYewzWMuNKzfft/KdqRQ5s1pzP6C37eufHEWB6FpG00EwBYAez7yQeAMlC5FXJy7bdj7QAVBqhF4mhAECEC9fFBMV4xcMyLAW5RoJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716430938; c=relaxed/simple;
	bh=n6S3d3rjzLN89lrRlWOEeom2CR+3xxp0nmbZn5Tlv8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/S/Gn9eeA2YsGGPGgxUi/60m02SkUF9Oqgaza/P/r/zN+vp1YXEKSuY6Az1FwFNfa5u6RatA18Hqm2MTArxyLswDQ1eSMTCr20+DdWQCDQynEH7+/B02Mjd/4b/ZWk5iDobDPGmqcjBRxjgfVjiR6Kxw/D7Nm2aKxcmtLPxBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XySX8E8L; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-df4d60c59f7so1661561276.3;
        Wed, 22 May 2024 19:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716430936; x=1717035736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQDfZ0LPwhJX3/QNF0EEJO3WCRe9zAijIGwiWSjHPuo=;
        b=XySX8E8LxDGOI/tor9LveyTBVtjIitEuX3O+5BtUaH2V8HHRRFM4USmAZnq7J1AQig
         scTFtx8v463Wxqn6DNwUdr7BmOSL0VOpNwfDrI8RzpIdBVBTYuqigW1DUvvADkYHgHRD
         O8ZlLZTyJV6OA18jaMPeW+JVrNzgJow2KuEeoc9GynLo4vicv4BYgzgIrSaHna8pT2tz
         m+XUW36ZZ7nPmH+GEO9fQ/TzX92o5GlzqCy/UJzoOlovxCfUcuGit8TvQwnMn748GDXx
         epQJmmond7IJjMRrjQGc7LhuW8DtWOvZ16LX5Kr5K29o0vtKqcPBP1HUoUtj/khiawwY
         gOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716430936; x=1717035736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQDfZ0LPwhJX3/QNF0EEJO3WCRe9zAijIGwiWSjHPuo=;
        b=Hd3wqLQKSedAMgHclZFOQM10dIGgJJvo7ZB9pXEaZixy9DL1YLxt3sDEc8roEJl7j1
         W7abs8CXP786R3boW85on3EYorSR0cxvOWEN9lc6eCpBIyH0oVl1M+dcgBRn3StrWM4k
         3bC+VovWBzLhTgiEGmlEwZ3u33qL8qUKAvuWsS4jYFdNF+KGKBpCobeTTJSw/BZTeICy
         RCzsDqURn9tNED7w17CSLd7td949ugEsUppUz2sKhDPGARrrVYGzROwVafd3p3pqeYAk
         dtbnvs565m8mbP8ZjVsge1EToSBv41DoGj1PwuB+sRl4ECZddjP9LOyIeCoA29ZOmZ5u
         nbFw==
X-Forwarded-Encrypted: i=1; AJvYcCVSNayr8L7qSsLToACZ/0XtI2xWWcSqLjQrIN05ctJrUPf4E/wmOCM7sjuWcFWJlF9f5lvxmfFggIM80JE7RgDZnHy0pOrAjsCfM8XOdVjtizb9Kx3ypYnOR2uUIBVZoq+Vkqb+3bTY9HFnMw==
X-Gm-Message-State: AOJu0YyvYC+xLiNfCqFM0emoz6cJCxgiuCX4i+QOpgrIzTGre1eXGTLX
	AHwSsXmX6HcCg5cfsehFVPV0c0QbooRT/ouON5ffV9OKph+tI6iWuaufq7M1PkEQU12+OlL2/9M
	MqOnVda15eT+aKZlYqqXLbI8sIoo=
X-Google-Smtp-Source: AGHT+IGIrKWhqy/R8UjLEd99c1CXhskhEggyC5D4DvABYvRnP5ifskPb85lAwQfQ0fLDLvAUpyNvgP63eumMfAsRfuk=
X-Received: by 2002:a25:d090:0:b0:de5:8290:35b8 with SMTP id
 3f1490d57ef6-df4e0ad024cmr4216897276.32.1716430935914; Wed, 22 May 2024
 19:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
 <20240515091727.22034-1-laoar.shao@gmail.com> <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
 <Zk2x+WmxndbwjxQ4@xsang-OptiPlex-9020>
In-Reply-To: <Zk2x+WmxndbwjxQ4@xsang-OptiPlex-9020>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 23 May 2024 10:21:39 +0800
Message-ID: <CALOAHbD7x_QCyPTy8M7KXddEdLK6vQhg8kv=U2bPucgV0-pN-Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: Oliver Sang <oliver.sang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, longman@redhat.com, viro@zeniv.linux.org.uk, 
	walters@verbum.org, wangkai86@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, philip.li@intel.com, 
	yujie.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:51=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
>
> hi, Linus, hi, Yafang Shao,
>
>
> On Wed, May 15, 2024 at 09:05:24AM -0700, Linus Torvalds wrote:
> > Oliver,
> >  is there any chance you could run this through the test robot
> > performance suite? The original full patch at
> >
> >     https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail=
.com/
> >
> > and it would be interesting if the test robot could see if the patch
> > makes any difference on any other loads?
> >
>
> we just reported a stress-ng performance improvement by this patch [1]

Awesome!

>
> test robot applied this patch upon
>   3c999d1ae3 ("Merge tag 'wq-for-6.10' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/tj/wq")
>
> filesystem is not our team's major domain, so we just made some limited r=
eview
> of the results, and decided to send out the report FYI.
>
> at first stage, we decided to check below catagories of tests as priority=
:
>
> stress-ng filesystem
> filebench mailserver
> reaim fileserver
>
> we also pick sysbench-fileio, blogbench into coverage.
>
> here is a summary.
>
> for stress-ng, besided [1] which was reported, we got below data that are
> about this patch comparing to 3c999d1ae3.
>
> either there is no significant performance change, or the change is small=
er
> than the noise which will make test robot's bisect fail, so these informa=
tion
> is just FYI. and if you have any doubt about any subtests, could you let =
us know
> then we could check further?
>
> (also included some net test results)
>
>       12.87 =C4=85  6%      -0.6%      12.79        stress-ng.xattr.ops_p=
er_sec
>        6721 =C4=85  5%      +7.5%       7224 =C4=85 27%  stress-ng.rawdev=
.ops_per_sec
>        9002 =C4=85  7%      -8.7%       8217        stress-ng.dirmany.ops=
_per_sec
>     8594743 =C4=85  4%      -3.0%    8337417        stress-ng.rawsock.ops=
_per_sec
>        2056 =C4=85  3%      +2.9%       2116        stress-ng.dirdeep.ops=
_per_sec
>        4307 =C4=85 21%      -6.9%       4009        stress-ng.dir.ops_per=
_sec
>      137946 =C4=85 18%      +5.8%     145942        stress-ng.fiemap.ops_=
per_sec
>    22413006 =C4=85  2%      +2.5%   22982512 =C4=85  2%  stress-ng.sockdi=
ag.ops_per_sec
>      286714 =C4=85  2%      -3.8%     275876 =C4=85  5%  stress-ng.udp-fl=
ood.ops_per_sec
>       82904 =C4=85 46%     -31.6%      56716        stress-ng.sctp.ops_pe=
r_sec
>     9853408            -0.3%    9826387        stress-ng.ping-sock.ops_pe=
r_sec
>       84667 =C4=85 12%     -26.7%      62050 =C4=85 17%  stress-ng.dccp.o=
ps_per_sec
>       61750 =C4=85 25%     -24.2%      46821 =C4=85 38%  stress-ng.open.o=
ps_per_sec
>      583443 =C4=85  3%      -3.4%     563822        stress-ng.file-ioctl.=
ops_per_sec
>       11919 =C4=85 28%     -34.3%       7833        stress-ng.dentry.ops_=
per_sec
>       18.59 =C4=85 12%     -23.9%      14.15 =C4=85 27%  stress-ng.swap.o=
ps_per_sec
>      246.37 =C4=85  2%     +15.9%     285.58 =C4=85 12%  stress-ng.aiol.o=
ps_per_sec
>        7.45            -4.8%       7.10 =C4=85  7%  stress-ng.fallocate.o=
ps_per_sec
>      207.97 =C4=85  7%      +5.2%     218.70        stress-ng.copy-file.o=
ps_per_sec
>       69.87 =C4=85  7%      +5.8%      73.93 =C4=85  5%  stress-ng.fpunch=
.ops_per_sec
>        0.25 =C4=85 21%     +24.0%       0.31        stress-ng.inode-flags=
.ops_per_sec
>      849.35 =C4=85  6%      +1.4%     861.51        stress-ng.mknod.ops_p=
er_sec
>      926144 =C4=85  4%      -5.2%     877558        stress-ng.lease.ops_p=
er_sec
>       82924            -2.1%      81220        stress-ng.fcntl.ops_per_se=
c
>        6.19 =C4=85124%     -50.7%       3.05        stress-ng.chattr.ops_=
per_sec
>      676.90 =C4=85  4%      -1.9%     663.94 =C4=85  5%  stress-ng.iomix.=
ops_per_sec
>        0.93 =C4=85  6%      +5.6%       0.98 =C4=85  7%  stress-ng.symlin=
k.ops_per_sec
>     1703608            -3.8%    1639057 =C4=85  3%  stress-ng.eventfd.ops=
_per_sec
>     1735861            -0.6%    1726072        stress-ng.sockpair.ops_per=
_sec
>       85440            -2.0%      83705        stress-ng.rawudp.ops_per_s=
ec
>        6198            +0.6%       6236        stress-ng.sockabuse.ops_pe=
r_sec
>       39226            +0.0%      39234        stress-ng.sock.ops_per_sec
>        1358            +0.3%       1363        stress-ng.tun.ops_per_sec
>     9794021            -1.7%    9623340        stress-ng.icmp-flood.ops_p=
er_sec
>     1324728            +0.3%    1328244        stress-ng.epoll.ops_per_se=
c
>      146150            -2.0%     143231        stress-ng.rawpkt.ops_per_s=
ec
>     6381112            -0.4%    6352696        stress-ng.udp.ops_per_sec
>     1234258            +0.2%    1236738        stress-ng.sockfd.ops_per_s=
ec
>       23954            -0.1%      23932        stress-ng.sockmany.ops_per=
_sec
>      257030            -0.1%     256860        stress-ng.netdev.ops_per_s=
ec
>     6337097            +0.1%    6341130        stress-ng.flock.ops_per_se=
c
>      173212            -0.3%     172728        stress-ng.rename.ops_per_s=
ec
>      199.69            +0.6%     200.82        stress-ng.sync-file.ops_pe=
r_sec
>      606.57            +0.8%     611.53        stress-ng.chown.ops_per_se=
c
>      183549            -0.9%     181975        stress-ng.handle.ops_per_s=
ec
>        1299            +0.0%       1299        stress-ng.hdd.ops_per_sec
>    98371066            +0.2%   98571113        stress-ng.lockofd.ops_per_=
sec
>       25.49            -4.3%      24.39        stress-ng.ioprio.ops_per_s=
ec
>    96745191            -1.5%   95333632        stress-ng.locka.ops_per_se=
c
>      582.35            +0.1%     582.86        stress-ng.chmod.ops_per_se=
c
>     2075897            -2.2%    2029552        stress-ng.getdent.ops_per_=
sec
>       60.47            -1.9%      59.34        stress-ng.metamix.ops_per_=
sec
>       14161            -0.3%      14123        stress-ng.io.ops_per_sec
>       23.98            -1.5%      23.61        stress-ng.link.ops_per_sec
>       27514            +0.0%      27528        stress-ng.filename.ops_per=
_sec
>       44955            +1.6%      45678        stress-ng.dnotify.ops_per_=
sec
>      160.94            +0.4%     161.51        stress-ng.inotify.ops_per_=
sec
>     2452224            +4.0%    2549607        stress-ng.lockf.ops_per_se=
c
>        6761            +0.3%       6779        stress-ng.fsize.ops_per_se=
c
>      775083            -1.5%     763487        stress-ng.fanotify.ops_per=
_sec
>      309124            -4.2%     296285        stress-ng.utime.ops_per_se=
c
>       25567            -0.1%      25530        stress-ng.dup.ops_per_sec
>        1858            +0.9%       1876        stress-ng.procfs.ops_per_s=
ec
>      105804            -3.9%     101658        stress-ng.access.ops_per_s=
ec
>        1.04            -1.9%       1.02        stress-ng.chdir.ops_per_se=
c
>       82753            -0.3%      82480        stress-ng.fstat.ops_per_se=
c
>      681128            +3.7%     706375        stress-ng.acl.ops_per_sec
>       11892            -0.1%      11875        stress-ng.bind-mount.ops_p=
er_sec
>
>
> for filebench, similar results, but data is less unstable than stress-ng,=
 which
> means for most of them, we regarded them as that they should not be impac=
ted by
> this patch.
>
> for reaim/sysbench-fileio/blogbench, the data are quite stable, and we di=
dn't
> notice any significant performance changes. we even doubt whether they go
> through the code path changed by this patch.
>
> so for these, we don't list full results here.
>
> BTW, besides filesystem tests, this patch is also piped into other perfor=
mance
> test categories such like net, scheduler, mm and others, and since it als=
o goes
> into our so-called hourly kernels, it could run by full other performance=
 test
> suites which test robot supports. so in following 2-3 weeks, it's still p=
ossible
> for us to report other results including regression.
>

That's great. Many thanks for your help.

--=20
Regards
Yafang

