Return-Path: <linux-fsdevel+bounces-26353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436C295815B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05531F251A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A018A94F;
	Tue, 20 Aug 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyXyLvZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636D18E35E;
	Tue, 20 Aug 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143792; cv=none; b=iqbh7cdxOu5hq8FapXy4yB0V8172rOh0QKtpjyJaCYcYp9St0Ug56vT1oZU+nvzEPqYEq4+E0vxmN/293PTPEkEoHKqnZ6PftMHbRVxuQQVV7xcnzZutsACN9BChrW3yaWaK3jUpNtTCryBnpHN6eaD+xcLmO2jdrBadSBEmgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143792; c=relaxed/simple;
	bh=ZuLJpDNd6eqRAPO6Aa71nXLB1ln53B/diFlYAIMMu6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBDd9BxmBDIAQW7ddw33uzWyLfh5JmQ8hriSBkbHfNl+XmmTELcUUKJUtJB417xJX5bsK+QD6DW+8Y49Sz9cAuMbFGnxiUHXF6ntQIqAPT5Y7eOEAYUAPDMwe0Boi+63qNs9ISMa5xrbH6cd+lJukqVFd2VRACc+stK+SDbOnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyXyLvZT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718eaf4046so3319115f8f.3;
        Tue, 20 Aug 2024 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724143789; x=1724748589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg9dJIN/hiobsnuENkgWKW4tMAbr4qvFo2moMhu7vdU=;
        b=IyXyLvZTmSyRs1S2BfRPIBxXmAeUvrBOJyuvwwLehtxaDVRLtdpE5lCdWnmIRrQCP/
         X6GJeNET1BjxBjyObWYaZz45y8lZycSXjhICEIxq4CBMLWyadfc66uBvAzz99YsNPuUp
         SzdLH6cTcvcI6F3Wxxv3cunWIPqOXmRwQvCQGE+aXDc24p5PbR76sbZZ9AwIj98BdLx1
         EtJIjiK6yNZljMfmsXLKd7FTTNlrnRvvRsPcBkMqZjgJ4/o0dmR7+5j+53VFs5JEeep0
         AX9sHDcugR7QO1NdTp4RfGw8ZxiUamzAZC3yYMWiut116c3pFEYhzmm2RQS93XJ9Eo8G
         0axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143789; x=1724748589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lg9dJIN/hiobsnuENkgWKW4tMAbr4qvFo2moMhu7vdU=;
        b=JTqjY+envmtySA4EwImb/TMHnYI0pFbw+FgekLlnLluNunPMcD6IwkKfGMQDnMFDR1
         wuNqC7iOZxMpQ+Hh5FU8EoO3egobtZK5/1TJ18mODvgnuGeX21SuEL2Bd2mX3ltuYsTG
         tVQu0clW0ebOipGqCEWcbyk+PqY6kUs86H/biQRcumWatTniyE2xN00YQs7UfghUbA0B
         87O1thDVG/Yc5HYbZ6GS3FcP/Uz3e7Q9HAsN74AQSJc9mhvQDtzZ4hadOwCoCZRetnwA
         eP8K/gPqWKz/ANPQyZqJY5B47cG5E7jyWRfcnkuq9pZrt42MjRC13bUd4YUFCnC9R3/w
         FYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgGe3TOtGUdXSsMBUhUKXpYJVNre2VFcrNOzo0nR94WifyLNWrbwAGmWDsO7f3/tpqjlwjC2fO@vger.kernel.org, AJvYcCWmvVXkkl16RJSrhqg/oXKeH4KJjBTLMrPoncJzXrbHnp6A6YnNJ77L3/qVE4mCDmLByIwwhTaaEwM=@vger.kernel.org, AJvYcCXDJPdhmNGsp7kR4t1iZY47rbzj5JfrPi0Ec+0TdBAHN1gDYFTjfkpUJrB0txF558ZTjN7U90NqlsFiTfc=@vger.kernel.org, AJvYcCXawiiUVf5TN4sY8zmnTe3FraN13Efu96keKMTFoOAO127qwjW4lx/pGKOHkwpyKtj+eAZN8SagrKj92Kvs0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0B6AvltUeDcreuIJsty+5jFKIP0SM82zYkGvTf+hkbVqkXo6N
	9CukAzQWtgRGF6yr7d+1VSvE3/HnLi7u6QENeg5eD3vu92p97CGYqBH6bl/fdY+DMOiP8PqHfQ/
	uxKDAuWgjRTkh/3e7CptP4l+G2P4=
X-Google-Smtp-Source: AGHT+IFl1anUYNa4FEC9klpgIUgBfM1uAYHx0Cm1xw4Sl52EjyYY0wMF0UPRDb7vLO5PAlVajoCL0hkHQ/xxsJo/UCg=
X-Received: by 2002:a5d:6751:0:b0:367:90cc:fe8b with SMTP id
 ffacd0b85a97d-37194649ca0mr9476564f8f.27.1724143788583; Tue, 20 Aug 2024
 01:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820000245.61787-1-technoboy85@gmail.com> <202408201433.eqBpp8z9-lkp@intel.com>
In-Reply-To: <202408201433.eqBpp8z9-lkp@intel.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 20 Aug 2024 10:49:12 +0200
Message-ID: <CAFnufp2zP-J7r_0zh=NYBbeMMpJkFnHvm6aZB2RP4Y1rR+7h+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan <skhan@linuxfoundation.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 20 ago 2024 alle ore 08:59 kernel test robot
<lkp@intel.com> ha scritto:
>
> Hi Matteo,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Croce/bpf-use-kfunc-hooks-instead-of-program-types/20240820-080354
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20240820000245.61787-1-technoboy85%40gmail.com
> patch subject: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
> config: arc-randconfig-002-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201433.eqBpp8z9-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201433.eqBpp8z9-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408201433.eqBpp8z9-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> net/core/filter.c:12084:38: warning: 'bpf_kfunc_set_sock_addr' defined but not used [-Wunused-const-variable=]
>    12084 | static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/bpf_kfunc_set_sock_addr +12084 net/core/filter.c
>
> 05421aecd4ed65 Joanne Koong  2023-03-01  12083
> 53e380d2144190 Daan De Meyer 2023-10-11 @12084  static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
> 53e380d2144190 Daan De Meyer 2023-10-11  12085          .owner = THIS_MODULE,
> 53e380d2144190 Daan De Meyer 2023-10-11  12086          .set = &bpf_kfunc_check_set_sock_addr,
> 53e380d2144190 Daan De Meyer 2023-10-11  12087  };
> 53e380d2144190 Daan De Meyer 2023-10-11  12088
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

It seems that I removed one too many calls, the last one was using
bpf_kfunc_set_sock_addr and needs to be kept.

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

