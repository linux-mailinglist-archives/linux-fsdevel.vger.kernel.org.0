Return-Path: <linux-fsdevel+bounces-57859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02EFB25F5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEEC1889E20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633ED2E8899;
	Thu, 14 Aug 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbIckPkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F01459EA;
	Thu, 14 Aug 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161047; cv=none; b=eIymfKwifjgSPW0YnL9NsE3DeyhfAaOxtrIXoubxHF2gtJJuEUFf9INq3+B1l9vFNcTyGFFkpDGQ+wBqg/YZ/pG4FVczAHgfkFznQ9IaCYGCQHM+OGSo8J2+XvO+muvb+Z3T07dKbZju6EFtadpJG3/cKTtgG8MfvK75IURteMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161047; c=relaxed/simple;
	bh=CTmqLMuj0bCvkwKZAg1Un//8JJ/uJlUZHANgFIqPtcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeF/Q1kRSCnDuVF0OhfJ4WeG0uCTsOJXzehPnv//cZgQrWnppRIcAceU3D+tuVoiHckSfaWiQhBWBu4SUibJ40v2Go0LDJTqD3vMzviBKK88nRuyhDhYfE+sZ5fyR1gqMf7Ub+eh1icUVpkOH9oXwLzD3QOEz8DhmoJUtKjeaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbIckPkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599B6C4CEEF;
	Thu, 14 Aug 2025 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755161047;
	bh=CTmqLMuj0bCvkwKZAg1Un//8JJ/uJlUZHANgFIqPtcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbIckPkpIEKyJ2nMayYZEQWySgIgwvq+Q87fMBsC5439jXwx7UjxtP6/3aRizI0iv
	 ijsnrrrpc8/3O6G/xs9aYaXyUBJeY0IX4fqyj3/x/rGOzs3QvqOtEfqO4IsrCj1EJJ
	 vVTmwcSsXtJ+0YCx16H+VWsKJOqsPoCy1fgAXOLlGkTP8ir2BQUm7OaO8V1W2MBlEh
	 imVNM6O/c1ae9lGeBjLpZoDfgKf1bT+2dj2T7y2GbzlYFwT1eLdqkINwalGzjVIgUn
	 KmVdVPjlyrTerI/WOq7DBLaaWbpmX/v+w8GbjVLyRf5VAICnpi3ce09BCy/VxWeJ9r
	 2nFsXdboCSbeg==
Date: Thu, 14 Aug 2025 11:43:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/10] mm: replace mm->flags with bitmap entirely and set
 to 64 bits
Message-ID: <aJ2hvmqj-wREpqXH@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:19PM +0100, Lorenzo Stoakes wrote:
> Now we have updated all users of mm->flags to use the bitmap accessors,
> repalce it with the bitmap version entirely.
> 
> We are then able to move to having 64 bits of mm->flags on both 32-bit and
> 64-bit architectures.
> 
> We also update the VMA userland tests to ensure that everything remains
> functional there.
> 
> No functional changes intended, other than there now being 64 bits of
> available mm_struct flags.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm.h               | 12 ++++++------
>  include/linux/mm_types.h         | 14 +++++---------
>  include/linux/sched/coredump.h   |  2 +-
>  tools/testing/vma/vma_internal.h | 19 +++++++++++++++++--
>  4 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 34311ebe62cc..b61e2d4858cf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -724,32 +724,32 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>  
>  static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
>  {
> -	return test_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
>  {
> -	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
>  {
> -	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline void mm_flags_set(int flag, struct mm_struct *mm)
>  {
> -	set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline void mm_flags_clear(int flag, struct mm_struct *mm)
>  {
> -	clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline void mm_flags_clear_all(struct mm_struct *mm)
>  {
> -	bitmap_zero(ACCESS_PRIVATE(&mm->_flags, __mm_flags), NUM_MM_FLAG_BITS);
> +	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
>  }
>  
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 25577ab39094..47d2e4598acd 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -932,7 +932,7 @@ struct mm_cid {
>   * Opaque type representing current mm_struct flag state. Must be accessed via
>   * mm_flags_xxx() helper functions.
>   */
> -#define NUM_MM_FLAG_BITS BITS_PER_LONG
> +#define NUM_MM_FLAG_BITS (64)
>  typedef struct {
>  	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
>  } mm_flags_t;
> @@ -1119,11 +1119,7 @@ struct mm_struct {
>  		/* Architecture-specific MM context */
>  		mm_context_t context;
>  
> -		/* Temporary union while we convert users to mm_flags_t. */
> -		union {
> -			unsigned long flags; /* Must use atomic bitops to access */
> -			mm_flags_t _flags;   /* Must use mm_flags_* helpers to access */
> -		};
> +		mm_flags_t flags; /* Must use mm_flags_* hlpers to access */
>  
>  #ifdef CONFIG_AIO
>  		spinlock_t			ioctx_lock;
> @@ -1236,7 +1232,7 @@ struct mm_struct {
>  /* Read the first system word of mm flags, non-atomically. */
>  static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  
>  	return bitmap_read(bitmap, 0, BITS_PER_LONG);
>  }
> @@ -1245,7 +1241,7 @@ static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
>  static inline void __mm_flags_set_word(struct mm_struct *mm,
>  				       unsigned long value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  
>  	bitmap_copy(bitmap, &value, BITS_PER_LONG);
>  }
> @@ -1253,7 +1249,7 @@ static inline void __mm_flags_set_word(struct mm_struct *mm,
>  /* Obtain a read-only view of the bitmap. */
>  static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct *mm)
>  {
> -	return (const unsigned long *)ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	return (const unsigned long *)ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  }
>  
>  #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 19ecfcceb27a..079ae5a97480 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -20,7 +20,7 @@ static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
>  
>  static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  
>  	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
>  }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index cb1c2a8afe26..f13354bf0a1e 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -249,6 +249,14 @@ struct mutex {};
>  #define DEFINE_MUTEX(mutexname) \
>  	struct mutex mutexname = {}
>  
> +#define DECLARE_BITMAP(name, bits) \
> +	unsigned long name[BITS_TO_LONGS(bits)]
> +
> +#define NUM_MM_FLAG_BITS (64)
> +typedef struct {
> +	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
> +} mm_flags_t;
> +
>  struct mm_struct {
>  	struct maple_tree mm_mt;
>  	int map_count;			/* number of VMAs */
> @@ -260,7 +268,7 @@ struct mm_struct {
>  
>  	unsigned long def_flags;
>  
> -	unsigned long flags; /* Must use atomic bitops to access */
> +	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
>  };
>  
>  struct vm_area_struct;
> @@ -1333,6 +1341,13 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  {
>  }
>  
> +# define ACCESS_PRIVATE(p, member) ((p)->member)
> +
> +static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
> +{
> +	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
> +}
> +
>  /*
>   * Denies creating a writable executable mapping or gaining executable permissions.
>   *
> @@ -1363,7 +1378,7 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
>  {
>  	/* If MDWE is disabled, we have nothing to deny. */
> -	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
>  		return false;
>  
>  	/* If the new VMA is not executable, we have nothing to deny. */
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

