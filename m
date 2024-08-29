Return-Path: <linux-fsdevel+bounces-27772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E08963BC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7019FB21108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AA158208;
	Thu, 29 Aug 2024 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JHybwRc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3212F399
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913536; cv=none; b=dznJUI6A1Ru+YnJDsY/vkADnln5lTjNyDpsY6WUYaAUvgy7u86HLTjBZP3FJ40dfOTKlDUCrhG7S+U7B06ac7W05iket3YPmdV5WxxwnstB24uXXt2D2ITEdHYywT644e0K/FheyaHCWUE9qzYqVfjvEVjNoBofmXxxuQtiH7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913536; c=relaxed/simple;
	bh=IRTKibgtAnhRT230n0IdApnI3of5TnaokNyimXTB3Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqFnkfB0FDb94/bZrpfVNS9fTNmYyqCZF4mSpac6/IiAy9QEALZvi/niZr51fXN/8C2z8lHO5LCe2ilmXqtKXNdV+N5dXd22hJ3D48vBCtjbHx+kassTBtFCUV6CbFqmkkedWJtGOxPZ7FSKiKJ4D3iFgX+YGiuBbAiINkHJra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JHybwRc0; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724913525; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+QdHDLtyL8p4G0URTlJWQbxLz0+tzutez+LES2PWA6A=;
	b=JHybwRc0x5lszaLHSAR3A/z6Ov5WRDMv52fUBQo+WS6+DUy6rthCb8KTSgNgpIPSn9SWCsXg3+kgui6LntSPxuPQ25d1sg7wcYdhnMsOTaZb8rrgF7+N3XkBBuzvgnw0RL336CmG5NrE4hctTgPmbtHrybGwKEcxzp6OzNTNLuY=
Received: from 30.221.146.47(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDs6CHT_1724913524)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 14:38:45 +0800
Message-ID: <c6b851b4-57ba-4ad3-9a52-c5509ffb08b3@linux.alibaba.com>
Date: Thu, 29 Aug 2024 14:38:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Yafang Shao <laoar.shao@gmail.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: kernel test robot <lkp@intel.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com,
 Bernd Schubert <bschubert@ddn.com>
References: <20240826203234.4079338-3-joannelkoong@gmail.com>
 <202408280419.yuu33o7t-lkp@intel.com>
 <CAJnrk1Y3piNWm3482N1QcasAmmUMYk1KkoO9TyupaJDBM8jW9A@mail.gmail.com>
 <CALOAHbC9a-U+Gk53bxo1=X4nMQng8TSUWo7B=TZVN-f=Y4JeUg@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CALOAHbC9a-U+Gk53bxo1=X4nMQng8TSUWo7B=TZVN-f=Y4JeUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Yafang,

On 8/29/24 11:58 AM, Yafang Shao wrote:
> On Wed, Aug 28, 2024 at 11:51 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Tue, Aug 27, 2024 at 2:52 PM kernel test robot <lkp@intel.com> wrote:
>>>
>>> Hi Joanne,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on mszeredi-fuse/for-next]
>>> [also build test ERROR on linus/master v6.11-rc5 next-20240827]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-add-optional-kernel-enforced-timeout-for-requests/20240827-043354
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
>>> patch link:    https://lore.kernel.org/r/20240826203234.4079338-3-joannelkoong%40gmail.com
>>> patch subject: [PATCH v5 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
>>> config: arc-randconfig-002-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280419.yuu33o7t-lkp@intel.com/config)
>>> compiler: arceb-elf-gcc (GCC) 13.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280419.yuu33o7t-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408280419.yuu33o7t-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> fs/fuse/sysctl.c:30:5: error: redefinition of 'fuse_sysctl_register'
>>>       30 | int fuse_sysctl_register(void)
>>>          |     ^~~~~~~~~~~~~~~~~~~~
>>>    In file included from fs/fuse/sysctl.c:9:
>>>    fs/fuse/fuse_i.h:1495:19: note: previous definition of 'fuse_sysctl_register' with type 'int(void)'
>>>     1495 | static inline int fuse_sysctl_register(void) { return 0; }
>>>          |                   ^~~~~~~~~~~~~~~~~~~~
>>>>> fs/fuse/sysctl.c:38:6: error: redefinition of 'fuse_sysctl_unregister'
>>>       38 | void fuse_sysctl_unregister(void)
>>>          |      ^~~~~~~~~~~~~~~~~~~~~~
>>>    fs/fuse/fuse_i.h:1496:20: note: previous definition of 'fuse_sysctl_unregister' with type 'void(void)'
>>>     1496 | static inline void fuse_sysctl_unregister(void) { return; }
>>>          |                    ^~~~~~~~~~~~~~~~~~~~~~
>>>
>>
>> I see. In the Makefile, the sysctl.o needs to be gated by CONFIG_SYSCTL
>> eg
>> fuse-$(CONFIG_SYSCTL) += sysctl.o
>>
>> I'll wait a bit to see if there are more comments on this patchset
>> before submitting v6.
> 
> Hello Joanne,
> 
> I noticed a change in behavior between versions v5 and v4 during my
> hellofuse test.
> 
> - Setup:
>   1. Set fs.fuse.default_request_timeout to 10.
>   2. Start the hellofuse daemon, with FUSE mounted on /tmp/fuse/.
>   3. Run `cat /tmp/fuse/hello` and kill it within 10 seconds to
> trigger a Timer expired event.
>   4. Run `cat /tmp/fuse/hello` again.
> 
> - v4:
>   After the Timer expired event occurs, running `cat /tmp/fuse/hello`
> again is successful.
> 
> - v5:
>   Running `cat /tmp/fuse/hello` fails with the error: "Transport
> endpoint is not connected."
> 
> I believe this behavior in v5 is unintended, correct?
> 

I think v5 has changed the per-request timeout to per-connection timeout
according to Miklos's suggestion.  That is, once timedout, the whole
connection will be aborted.


-- 
Thanks,
Jingbo

