Return-Path: <linux-fsdevel+bounces-11621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C5855678
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 23:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B58B22C7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97FB13DB90;
	Wed, 14 Feb 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgWEYIMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8511DDD7;
	Wed, 14 Feb 2024 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951553; cv=none; b=pkaIT80ZHikVBAhhbHeiAbKzVyiA+4MXC0kxKorwlJeJAMMkZ2kn00AB2hrmaA3SPDK9tcQBr2DdVnswDh7qytRsQgNbptbXczYiuf6TkXPJJzSiuN5+T5yCzBuZ8p/HrHsan6RggyZmNF8PDGg6eBPnK0lDjl9xycmNbT98dRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951553; c=relaxed/simple;
	bh=gUumXsY6f/GstkSVOqlmPHr63YyKvQbTJvGkcUOnWRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BE4xvbq5nJaIfV9yxm2N5nRteIAqRF8ChTJXCVmL5qGiss1oXRbFrHoZSbURRAwUu3bYBa2F4zSOx2T0wilLtg7as0mI4gl1Q6z9YWO0k46gMmmwL7Mn/fnjl+UeqY+FUb8quJD4bRZoWIvxIOJ/XxbgXsGdWr5VgBm/fyOds+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgWEYIMB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707951551; x=1739487551;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gUumXsY6f/GstkSVOqlmPHr63YyKvQbTJvGkcUOnWRc=;
  b=OgWEYIMBetc5qadMxXRlS9C4x0p1/VgJkGHECOiL2DupxGH+Gf8xpkR5
   YJFUKeqcH22qhGcmxc1qysvrlBVr6iLrS9xXkEk54OdquPdEO2spxNn+r
   n+QvPlB5041vMbuug0EmCTdIj3Ngq79wbNeDRu4q8c0Gi+D/hUkc89x/C
   tAfaanavpUcm5WyQZnirsgmxbpde8l+vjqo5LlB+Q2Tu3gAISoAvBsCbq
   z1G/vGY+57UOcOibsu53CRdQ32Yr7ASzlx7IPeYIAedYUhuhLeQxkoco6
   bD5y7z5jQuj1nhvIlD8c2u3s/SfGgUyB2MAbR8Pl8fga18F+yCZLbf30p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2143140"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="2143140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3324531"
Received: from wfaimone-mobl.amr.corp.intel.com (HELO [10.209.29.231]) ([10.209.29.231])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:59:06 -0800
Message-ID: <f4abca3f1d89d11f31b965e58a397aa6074be9d1.camel@linux.intel.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Suren Baghdasaryan <surenb@google.com>, Yosry Ahmed
 <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de,  dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net,  void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com,  catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de,  mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
  nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev,  rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yuzhao@google.com,  dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com,  dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com,  jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com,  kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
 cgroups@vger.kernel.org
Date: Wed, 14 Feb 2024 14:59:05 -0800
In-Reply-To: <CAJuCfpEbdC4k=4aeEO=YfX2tZhkdOVaehAv9Ts7S42B_bmm=Ow@mail.gmail.com>
References: <20240212213922.783301-1-surenb@google.com>
	 <4f24986587b53be3f9ece187a3105774eb27c12f.camel@linux.intel.com>
	 <CAJuCfpGnnsMFu-2i6-d=n1N89Z3cByN4N1txpTv+vcWSBrC2eg@mail.gmail.com>
	 <Zc0f7u5yCq-Iwh3A@google.com>
	 <CAJuCfpEbdC4k=4aeEO=YfX2tZhkdOVaehAv9Ts7S42B_bmm=Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 12:30 -0800, Suren Baghdasaryan wrote:
> On Wed, Feb 14, 2024 at 12:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >=20
> > > > > Performance overhead:
> > > > > To evaluate performance we implemented an in-kernel test executin=
g
> > > > > multiple get_free_page/free_page and kmalloc/kfree calls with all=
ocation
> > > > > sizes growing from 8 to 240 bytes with CPU frequency set to max a=
nd CPU
> > > > > affinity set to a specific CPU to minimize the noise. Below are r=
esults
> > > > > from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel=
 on
> > > > > 56 core Intel Xeon:
> > > > >=20
> > > > >                         kmalloc                 pgalloc
> > > > > (1 baseline)            6.764s                  16.902s
> > > > > (2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
> > > > > (3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
> > > > > (4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
> > > > > (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%=
)
> > >=20
> > > (6 default disabled+memcg)    13.332s (+97.10%)         48.105s (+184=
.61%)
> > > (7 default enabled+memcg)     13.446s (+98.78%)       54.963s (+225.1=
8%)
> >=20
> > I think these numbers are very interesting for folks that already use
> > memcg. Specifically, the difference between 6 & 7, which seems to be
> > ~0.85% and ~14.25%. IIUC, this means that the extra overhead is
> > relatively much lower if someone is already using memcgs.
>=20
> Well, yes, percentage-wise it's much lower. If you look at the
> absolute difference between 6 & 7 vs 2 & 3, it's quite close.
>=20
> >=20
> > >=20
> > > (6) shows a bit better performance than (5) but it's probably noise. =
I
> > > would expect them to be roughly the same. Hope this helps.
> > >=20
> > > >=20

Thanks for the data.  It does show that turning on memcg does not cost
extra overhead percentage wise.

Tim

