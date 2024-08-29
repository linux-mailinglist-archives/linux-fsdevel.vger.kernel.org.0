Return-Path: <linux-fsdevel+bounces-27775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0885963DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BE71F21A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09121189F54;
	Thu, 29 Aug 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2JFWQB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB4189F31
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918774; cv=none; b=EGN283Hu7wZLe2WPATOXQT2q7veKjww2jNoR6i/01rWvbq1n+GJcJ1KqNv6g632IXUe3t0RVSSXdaZj1sEdJumrKF349u0nC4Agg1FgGuqeE1JuZEru12L3DsX5kKuPtLaRyCtg3nDXWF7xjIUBFldUZQbfA1xi4cn2jP9/Vjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918774; c=relaxed/simple;
	bh=WADVHpmrppU9JtnOjIwY5J7I644fptX9Ii69q7ozQjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1y5c0tEoiFjWF3z2KfQXExU1vYSa5iUQ58XOg18VomnaAuW7DIciKv7cj7POzboyxx/1Gm8mkIRAS/sgJsX3qCoM+XgkvrQV8Cyz50LGJceQm1AGvsEIH8qCKeIShKBSoPb46VjWr/5Izhjjjt4TijiP17kq5oEf9LcHT9XA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2JFWQB/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a806b967afso34421585a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724918771; x=1725523571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYgvuKqZcmRq3AS2Q5lvhT3PiVjGn2/fDZSyjmpEqyA=;
        b=I2JFWQB/uSOM3IWwt4eyuupR0fa6qI53oLBOJzD0/AgL0K95EneiJdnBWT8RGVvZXr
         VgsadWtelA0Oq9QF0ZDj2MDZnReg3WQU3i6cGmjPrQ/PpP5Xsodbk7za5t2p5fWYZakQ
         RAoKAxac2IOz0gVZAUchsTqFislhOfJnypP+Je2mApsFv0MaEOOaUHG9QF2F11f12XM1
         3TjdzvsYy8qKRA5a1gDfeFTt3YlyKoH/IHlCPtt6MXzxd66gHpIwhFlLAK2kp5zQZ5UE
         JrdinzrQ8fMSk8wKcA1bMVC7QtInSwoPXBT3wnAai8f05KsrcS1ZpkfEFl6+iKICCQ/6
         SnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918771; x=1725523571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYgvuKqZcmRq3AS2Q5lvhT3PiVjGn2/fDZSyjmpEqyA=;
        b=H0Ij7T3c5G/bSB4tiO+zbDXj+XGzowvgdMimHLLTk4L/3pIlzLxC4ozegD+YjikvzA
         63DXZCWPgBbyHVBcXo26Z9QTX47JvPH2ccR1p2i8f3VA+9KU5u+MZdS+MPYk1k1+XHSq
         tVdvcLB6tdZffFcbqVxlBaEmJubXpleo8NkNIioN2EkOzMaf0Wuczr1bPO4QntXi5v9B
         Xhleuv/v7Ia19WHcB+0Ku4xo8bOUfZBFEp3BtJWLFJk5KXlWqXMDN5A5bJIm+I5OO3Rp
         oJ9TraPeQ1P20lefHBer3g49bFeIK+cfqxUA2i66zluJ0ltvzhazWvMkYeQLgp2SE5ZE
         kopg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/kS283NMPV/e+0AhbGhlrwL97YTjWFk2TEPlPlf4wFF2KTLoBJkW74IBfwDmhc1hjuyWT4bqRdZDcNRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2T6Rt69AxcjDPcR/DtRNr05ApdYZ/DVcUBJShfeit/wO4mPJX
	oYBGlSCGxxfzkGFUCR33rYzQRCCN6pxSyB0ew3/vnldf6OC8soif6ZZ6BHNTH4wjQ1nK//oa1eh
	68ORCCoxFJ8wRO1FhE6/hmPu64fg=
X-Google-Smtp-Source: AGHT+IHwQM3l4fVs0TLwgaw6UHwDGfa/YXuKNhg+OUIL0VUZl1cZkhKDOS6yggUL3zwoxQnVYEECNFei/Mcz3cb5XKw=
X-Received: by 2002:a05:6214:f69:b0:6b5:2062:dd5c with SMTP id
 6a1803df08f44-6c33f33be5fmr35504506d6.8.1724918771539; Thu, 29 Aug 2024
 01:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826203234.4079338-3-joannelkoong@gmail.com>
 <202408280419.yuu33o7t-lkp@intel.com> <CAJnrk1Y3piNWm3482N1QcasAmmUMYk1KkoO9TyupaJDBM8jW9A@mail.gmail.com>
 <CALOAHbC9a-U+Gk53bxo1=X4nMQng8TSUWo7B=TZVN-f=Y4JeUg@mail.gmail.com> <c6b851b4-57ba-4ad3-9a52-c5509ffb08b3@linux.alibaba.com>
In-Reply-To: <c6b851b4-57ba-4ad3-9a52-c5509ffb08b3@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Aug 2024 16:05:35 +0800
Message-ID: <CALOAHbCOgxWXojuyzyGVLdrG_=XW2HBhr9Oj=KxfpgJNvAusRA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, kernel test robot <lkp@intel.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:38=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi, Yafang,
>
> On 8/29/24 11:58 AM, Yafang Shao wrote:
> > On Wed, Aug 28, 2024 at 11:51=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> >>
> >> On Tue, Aug 27, 2024 at 2:52=E2=80=AFPM kernel test robot <lkp@intel.c=
om> wrote:
> >>>
> >>> Hi Joanne,
> >>>
> >>> kernel test robot noticed the following build errors:
> >>>
> >>> [auto build test ERROR on mszeredi-fuse/for-next]
> >>> [also build test ERROR on linus/master v6.11-rc5 next-20240827]
> >>> [If your patch is applied to the wrong git tree, kindly drop us a not=
e.
> >>> And when submitting patch, we suggest to use '--base' as documented i=
n
> >>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >>>
> >>> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/f=
use-add-optional-kernel-enforced-timeout-for-requests/20240827-043354
> >>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse=
.git for-next
> >>> patch link:    https://lore.kernel.org/r/20240826203234.4079338-3-joa=
nnelkoong%40gmail.com
> >>> patch subject: [PATCH v5 2/2] fuse: add default_request_timeout and m=
ax_request_timeout sysctls
> >>> config: arc-randconfig-002-20240827 (https://download.01.org/0day-ci/=
archive/20240828/202408280419.yuu33o7t-lkp@intel.com/config)
> >>> compiler: arceb-elf-gcc (GCC) 13.2.0
> >>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20240828/202408280419.yuu33o7t-lkp@intel.com/reproduce)
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408280419.yuu33o7t=
-lkp@intel.com/
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>>> fs/fuse/sysctl.c:30:5: error: redefinition of 'fuse_sysctl_register=
'
> >>>       30 | int fuse_sysctl_register(void)
> >>>          |     ^~~~~~~~~~~~~~~~~~~~
> >>>    In file included from fs/fuse/sysctl.c:9:
> >>>    fs/fuse/fuse_i.h:1495:19: note: previous definition of 'fuse_sysct=
l_register' with type 'int(void)'
> >>>     1495 | static inline int fuse_sysctl_register(void) { return 0; }
> >>>          |                   ^~~~~~~~~~~~~~~~~~~~
> >>>>> fs/fuse/sysctl.c:38:6: error: redefinition of 'fuse_sysctl_unregist=
er'
> >>>       38 | void fuse_sysctl_unregister(void)
> >>>          |      ^~~~~~~~~~~~~~~~~~~~~~
> >>>    fs/fuse/fuse_i.h:1496:20: note: previous definition of 'fuse_sysct=
l_unregister' with type 'void(void)'
> >>>     1496 | static inline void fuse_sysctl_unregister(void) { return; =
}
> >>>          |                    ^~~~~~~~~~~~~~~~~~~~~~
> >>>
> >>
> >> I see. In the Makefile, the sysctl.o needs to be gated by CONFIG_SYSCT=
L
> >> eg
> >> fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
> >>
> >> I'll wait a bit to see if there are more comments on this patchset
> >> before submitting v6.
> >
> > Hello Joanne,
> >
> > I noticed a change in behavior between versions v5 and v4 during my
> > hellofuse test.
> >
> > - Setup:
> >   1. Set fs.fuse.default_request_timeout to 10.
> >   2. Start the hellofuse daemon, with FUSE mounted on /tmp/fuse/.
> >   3. Run `cat /tmp/fuse/hello` and kill it within 10 seconds to
> > trigger a Timer expired event.
> >   4. Run `cat /tmp/fuse/hello` again.
> >
> > - v4:
> >   After the Timer expired event occurs, running `cat /tmp/fuse/hello`
> > again is successful.
> >
> > - v5:
> >   Running `cat /tmp/fuse/hello` fails with the error: "Transport
> > endpoint is not connected."
> >
> > I believe this behavior in v5 is unintended, correct?
> >
>
> I think v5 has changed the per-request timeout to per-connection timeout
> according to Miklos's suggestion.  That is, once timedout, the whole
> connection will be aborted.

Understood. Thanks for your explanation.

--=20
Regards
Yafang

