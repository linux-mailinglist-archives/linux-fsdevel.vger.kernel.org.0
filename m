Return-Path: <linux-fsdevel+bounces-7323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552AA82398B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073541F25B45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF7A29;
	Thu,  4 Jan 2024 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNlqAeGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81936B;
	Thu,  4 Jan 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0SEkDxkX73eYHKG0v/y3mmPzpF+tkShgrm5cJQMXxio=; b=WNlqAeGaAenVvfZnIUbipXu0s+
	Arz55X0ciai3unUSjDibQpCxLHUM8UAJPsYzJIPgi6uiGjwc5Wr3B+R/VG2X+oFhqnaiNr/CPB+Ay
	N3OUGZHUTX1peTGhl5q52I8yHVMKk4L6OcAtZA22keDKgFh2H53NZBbM1zzImWi31ygZAlxlELDkA
	MLeSHrd6vluGKSFCiETbZEWsYHRMwS9CKFpSfuj9XEgjUGOh2NVF4m8Izs0xzUY/ASJmcwOb7/j6d
	mq0KYL5oyBTbD7ivTvJLbwms7SRahDapcA9azvxetGgRywHPiWsJguMr7avZNDrlwoPeX+W1qkYvC
	hntm+meQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLBS1-00CTNI-2P;
	Thu, 04 Jan 2024 00:19:09 +0000
Message-ID: <429dd825-204a-4b11-87fd-ce9d39040d4d@infradead.org>
Date: Wed, 3 Jan 2024 16:19:03 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] mm/mempolicy: add userland mempolicy arg
 structure
Content-Language: en-US
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
 tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
 tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
 corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com,
 vtavarespetr@micron.com, peterz@infradead.org, jgroves@micron.com,
 ravis.opensrc@micron.com, sthanneeru@micron.com, emirakhur@micron.com,
 Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
 Frank van der Linden <fvdl@google.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
 <20240103224209.2541-9-gregory.price@memverge.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103224209.2541-9-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/3/24 14:42, Gregory Price wrote:
> This patch adds the new user-api argument structure intended for
> set_mempolicy2 and mbind2.
> 
> struct mpol_param {
>   __u16 mode;
>   __u16 mode_flags;
>   __s32 home_node;          /* mbind2: policy home node */
>   __u16 pol_maxnodes;
>   __u8 resv[6];
>   __aligned_u64 *pol_nodes;
> };
> 
> This structure is intended to be extensible as new mempolicy extensions
> are added.
> 
> For example, set_mempolicy_home_node was added to allow vma mempolicies
> to have a preferred/home node assigned.  This structure allows the user
> to set the home node at the time mempolicy is created, rather than
> requiring an additional syscalls.
> 
> Full breakdown of arguments as of this patch:
>     mode:         Mempolicy mode (MPOL_DEFAULT, MPOL_INTERLEAVE)
> 
>     mode_flags:   Flags previously or'd into mode in set_mempolicy
>                   (e.g.: MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES)
> 
>     home_node:    for mbind2.  Allows the setting of a policy's home
>                   with the use of MPOL_MF_HOME_NODE
> 
>     pol_maxnodes: Max number of nodes in the policy nodemask
> 
>     pol_nodes:    Policy nodemask
> 
> The reserved field accounts explicitly for a potential memory hole
> in the structure.
> 
> Suggested-by: Frank van der Linden <fvdl@google.com>
> Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> ---
>  .../admin-guide/mm/numa_memory_policy.rst       | 17 +++++++++++++++++
>  include/linux/syscalls.h                        |  1 +
>  include/uapi/linux/mempolicy.h                  |  9 +++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index a70f20ce1ffb..cbfc5f65ed77 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -480,6 +480,23 @@ closest to which page allocation will come from. Specifying the home node overri
>  the default allocation policy to allocate memory close to the local node for an
>  executing CPU.
>  
> +Extended Mempolicy Arguments::
> +
> +	struct mpol_param {
> +		__u16 mode;
> +		__u16 mode_flags;
> +		__s32 home_node;	 /* mbind2: set home node */
> +		__u64 pol_maxnodes;
> +		__aligned_u64 pol_nodes; /* nodemask pointer */
> +	};
>

Can you make the above documentation struct agree with the
struct in the header below, please?
(just a difference in the size of pol_maxnodes and the
'resv' bytes)


> +The extended mempolicy argument structure is defined to allow the mempolicy
> +interfaces future extensibility without the need for additional system calls.
> +
> +The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
> +all interfaces relative to their non-extended counterparts. Each additional
> +field may only apply to specific extended interfaces.  See the respective
> +extended interface man page for more details.
>  
>  Memory Policy Command Line Interface
>  ====================================


> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 1f9bb10d1a47..109788c8be92 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -27,6 +27,15 @@ enum {
>  	MPOL_MAX,	/* always last member of enum */
>  };
>  
> +struct mpol_param {
> +	__u16 mode;
> +	__u16 mode_flags;
> +	__s32 home_node;	/* mbind2: policy home node */
> +	__u16 pol_maxnodes;
> +	__u8 resv[6];
> +	__aligned_u64 pol_nodes;
> +};
> +
>  /* Flags for set_mempolicy */
>  #define MPOL_F_STATIC_NODES	(1 << 15)
>  #define MPOL_F_RELATIVE_NODES	(1 << 14)

-- 
#Randy

