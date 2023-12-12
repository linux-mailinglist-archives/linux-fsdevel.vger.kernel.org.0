Return-Path: <linux-fsdevel+bounces-5623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905980E4A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 08:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD436B21C07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEA168B1;
	Tue, 12 Dec 2023 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZP+jHdzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78107CB;
	Mon, 11 Dec 2023 23:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702365035; x=1733901035;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=c+J2fNloI48VUHDJJRFMGroqhUwoShcQh1SbFVIWMEA=;
  b=ZP+jHdzXUWe8PfSzoKDCxEm410tqcQSdc0aVSDNeOmr8nQsnlowxIP1I
   HK4FOmqbtW68tVw0EZ7wq+boDQyBQ7LZsXZIy3nZcl0BJdyzJ2lwjuJ7N
   PStHYZ7EzWgrCxooy41tQb3quL+VTMUkPsrNLz0QivpwEdbg7Wcoofv8V
   UyCFefPkwi2AmbdnGsZDGJ4UkYlOvU55FhwvaAf7OHO4/Iv2CnFmO/+Uu
   Ku6BHgBANzNIyy2LFVKFndWoXodPGN7orkwhafGhniEqn+fzYwF9yivaR
   ACf3kaenchWnuyz7ZTniEBMD+hdrY8AlevitFMa5M5fi43oQbAgs4kPd4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1599746"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1599746"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 23:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="839332406"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="839332406"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 23:10:24 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-doc@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-api@vger.kernel.org>,  <linux-arch@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <akpm@linux-foundation.org>,
  <arnd@arndb.de>,  <tglx@linutronix.de>,  <luto@kernel.org>,
  <mingo@redhat.com>,  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,
  <x86@kernel.org>,  <hpa@zytor.com>,  <mhocko@kernel.org>,
  <tj@kernel.org>,  <corbet@lwn.net>,  <rakie.kim@sk.com>,
  <hyeongtak.ji@sk.com>,  <honggyu.kim@sk.com>,  <vtavarespetr@micron.com>,
  <peterz@infradead.org>,  <jgroves@micron.com>,
  <ravis.opensrc@micron.com>,  <sthanneeru@micron.com>,
  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  Johannes Weiner <hannes@cmpxchg.org>,  "Hasan
 Al Maruf" <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Michal Hocko <mhocko@suse.com>,
  Zhongkun He <hezhongkun.hzk@bytedance.com>,  Frank van der Linden
 <fvdl@google.com>,  "John Groves" <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <ZXc74yJzXDkCm+BA@memverge.com> (Gregory Price's message of "Mon,
	11 Dec 2023 11:42:11 -0500")
References: <20231209065931.3458-1-gregory.price@memverge.com>
	<87r0jtxp23.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXc74yJzXDkCm+BA@memverge.com>
Date: Tue, 12 Dec 2023 15:08:24 +0800
Message-ID: <87plzbx5hz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Dec 11, 2023 at 01:53:40PM +0800, Huang, Ying wrote:
>> Hi, Gregory,
>>=20
>> Thanks for updated version!
>>=20
>> Gregory Price <gourry.memverge@gmail.com> writes:
>>=20
>> > v2:
>> >   changes / adds:
>> > - flattened weight matrix to an array at requested of Ying Huang
>> > - Updated ABI docs per Davidlohr Bueso request
>> > - change uapi structure to use aligned/fixed-length members as
>> >   Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > - Implemented weight fetch logic in get_mempolicy2
>> > - mbind2 was changed to take (iovec,len) as function arguments
>> >   rather than add them to the uapi structure, since they describe
>> >   where to apply the mempolicy - as opposed to being part of it.
>> >
>> >     The sysfs structure is designed as follows.
>> >
>> >       $ tree /sys/kernel/mm/mempolicy/
>> >       /sys/kernel/mm/mempolicy/
>> >       =E2=94=9C=E2=94=80=E2=94=80 possible_nodes
>> >       =E2=94=94=E2=94=80=E2=94=80 weighted_interleave
>> >           =E2=94=9C=E2=94=80=E2=94=80 nodeN
>> >           =E2=94=82=C2=A0  =E2=94=94=E2=94=80=E2=94=80 weight
>> >           =E2=94=94=E2=94=80=E2=94=80 nodeN+X
>> >           =C2=A0   =E2=94=94=E2=94=80=E2=94=80 weight
>> >
>> > 'mempolicy' is added to '/sys/kernel/mm/' as a control group for
>> > the mempolicy subsystem.
>>=20
>> Is it good to add 'mempolicy' in '/sys/kernel/mm/numa'?  The advantage
>> is that 'mempolicy' here is in fact "NUMA mempolicy".  The disadvantage
>> is one more directory nesting.  I have no strong opinion here.
>>=20
>
> i don't have a strong opinion here.
>
>> > 'possible_nodes' is added to 'mm/mempolicy' to help describe the
>> > expected structures under mempolicy directorys. For example,
>> > possible_nodes describes what nodeN directories wille exist under
>> > the weighted_interleave directory.
>>=20
>> We have '/sys/devices/system/node/possible' already.  Is this just a
>> duplication?  If so, why?  And, the possible nodes can be gotten via
>> contents of 'weighted_interleave' too.
>>=20
>
> I'll remove it
>
>> And it appears not necessary to make 'weighted_interleave/nodeN'
>> directory.  Why not just make it a file.
>>=20
>
> Originally I wasn't sure whether there would be more attributes, but
> this is probably fine.  I'll change it.
>
>> And, can we add a way to reset weight to the default value?  For example
>> `echo > nodeN/weight` or `echo > nodeN`.
>>=20
>
> Seems reasonable.
>
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > (Patches 7-10) set_mempolicy2, get_mempolicy2, mbind2
>> >
>> > These interfaces are the 'extended' counterpart to their relatives.
>> > They use the userland 'struct mpol_args' structure to communicate a
>> > complete mempolicy configuration to the kernel.  This structure
>> > looks very much like the kernel-internal 'struct mempolicy_args':
>> >
>> > struct mpol_args {
>> >         /* Basic mempolicy settings */
>> >         __u16 mode;
>> >         __u16 mode_flags;
>> >         __s32 home_node;
>> >         __aligned_u64 pol_nodes;
>> >         __u64 pol_maxnodes;
>> >         __u64 addr;
>> >         __s32 policy_node;
>> >         __s32 addr_node;
>> >         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
>> > };
>>=20
>> This looks unnecessarily complex.  I don't think that it's a good idea
>> to use exact same parameter for all 3 syscalls.
>>
>
> It is exactly as complex as mempolicy is.  Everything here is already
> described in the existing interfaces (except il_weights).
>
>> For example, can we use something as below?
>>=20
>>   long set_mempolicy2(int mode, const unsigned long *nodemask, unsigned =
int *il_weights,
>>                           unsigned long maxnode, unsigned long home_node,
>>                           unsigned long flags);
>>=20
>>   long mbind2(unsigned long start, unsigned long len,
>>                           int mode, const unsigned long *nodemask, unsig=
ned int *il_weights,
>>                           unsigned long maxnode, unsigned long home_node,
>>                           unsigned long flags);
>>=20
>
> Your definition of mbind2 is impossible.
>
> Neither of these interfaces solve the extensibility issue.  If a new
> policy which requires a new format of data arrives, we can look forward
> to set_mempolicy3 and mbind3.

IIUC, we will not over-engineering too much.  It's hard to predict the
requirements in the future.

>> A struct may be defined to hold mempolicy iteself.
>>=20
>> struct mpol {
>>         int mode;
>>         unsigned int home_node;
>>         const unsigned long *nodemask;
>>         unsigned int *il_weights;
>>         unsigned int maxnode;
>> };
>>=20
>
> addr could be pulled out for get_mempolicy2, so i will do that
>
> 'addr_node' and 'policy_node' are warts that came from the original
> get_mempolicy.  Removing them increases the complexity of handling
> arguments in the common get_mempolicy code.
>
> I could probably just drop support for retrieving the addr_node from
> get_mempolicy2, since it's already possible with get_mempolicy.  So I
> will do that.

If it's necessary, we can add another struct for get_mempolicy2().  But
I don't think that it's necessary to add get_mempolicy2() specific
parameters for set_mempolicy2() or mbind2().

--
Best Regards,
Huang, Ying

