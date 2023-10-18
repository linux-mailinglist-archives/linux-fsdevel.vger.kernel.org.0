Return-Path: <linux-fsdevel+bounces-671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC87CE2A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A1B1C20B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835173C08B;
	Wed, 18 Oct 2023 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGzLzViw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400720307
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 16:24:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104211F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697646250; x=1729182250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+e68RPiQrLViVlvxO19pWLbsvYC0AeXfModttr3aG4=;
  b=fGzLzViwTBptNt6QAW9WYUi5q4Z3QHHU1/JJLW8y7aybHaBicRkjjA4n
   nNMvhYVhKHA9q2woUOroeScCJnNQLUm5GxlNHek+bm0/U92Ihu6v9t6+w
   JDqF+hUdE/ITpe6yacqVue0W7f3oT0A5+ZgcEsaJyhmX9wZu8+y9viPUg
   u5lffNRtJXr/MSd6fM3ZN5b8v9+7TtrtC0D1G9uWemzJI2d5R1KGdGIG1
   E+rHyyvGmawA/f30sqK3E7o7+QPQEzR0Rj05xWt31eVFzctzOe6J53DP+
   UAU8wZ9WJSKc9IxQgOdLSWypQ+XoOJvtdCid66Qy2lDJ2iGbozNf2ka9j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389926814"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="389926814"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 09:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="826958049"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="826958049"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2023 09:24:06 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qt9L2-0000em-2D;
	Wed, 18 Oct 2023 16:24:04 +0000
Date: Thu, 19 Oct 2023 00:23:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>, Yury Norov <yury.norov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Message-ID: <202310190005.NqJcRXtK-lkp@intel.com>
References: <20231011150252.32737-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011150252.32737-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/lib-find-Make-functions-safe-on-changing-bitmaps/20231011-230553
base:   linus/master
patch link:    https://lore.kernel.org/r/20231011150252.32737-1-jack%40suse.cz
patch subject: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
config: i386-randconfig-002-20231018 (https://download.01.org/0day-ci/archive/20231019/202310190005.NqJcRXtK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190005.NqJcRXtK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190005.NqJcRXtK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/percpu.c: In function 'pcpu_build_alloc_info':
>> mm/percpu.c:2885:26: warning: array subscript 32 is above array bounds of 'int[32]' [-Warray-bounds]
    2885 |                 group_map[cpu] = group;
         |                 ~~~~~~~~~^~~~~
   mm/percpu.c:2842:20: note: while referencing 'group_map'
    2842 |         static int group_map[NR_CPUS] __initdata;
         |                    ^~~~~~~~~


vim +2885 mm/percpu.c

3c9a024fde58b0 Tejun Heo              2010-09-09  2813  
3c9a024fde58b0 Tejun Heo              2010-09-09  2814  /* pcpu_build_alloc_info() is used by both embed and page first chunk */
3c9a024fde58b0 Tejun Heo              2010-09-09  2815  #if defined(BUILD_EMBED_FIRST_CHUNK) || defined(BUILD_PAGE_FIRST_CHUNK)
3c9a024fde58b0 Tejun Heo              2010-09-09  2816  /**
3c9a024fde58b0 Tejun Heo              2010-09-09  2817   * pcpu_build_alloc_info - build alloc_info considering distances between CPUs
3c9a024fde58b0 Tejun Heo              2010-09-09  2818   * @reserved_size: the size of reserved percpu area in bytes
3c9a024fde58b0 Tejun Heo              2010-09-09  2819   * @dyn_size: minimum free size for dynamic allocation in bytes
3c9a024fde58b0 Tejun Heo              2010-09-09  2820   * @atom_size: allocation atom size
3c9a024fde58b0 Tejun Heo              2010-09-09  2821   * @cpu_distance_fn: callback to determine distance between cpus, optional
3c9a024fde58b0 Tejun Heo              2010-09-09  2822   *
3c9a024fde58b0 Tejun Heo              2010-09-09  2823   * This function determines grouping of units, their mappings to cpus
3c9a024fde58b0 Tejun Heo              2010-09-09  2824   * and other parameters considering needed percpu size, allocation
3c9a024fde58b0 Tejun Heo              2010-09-09  2825   * atom size and distances between CPUs.
3c9a024fde58b0 Tejun Heo              2010-09-09  2826   *
bffc4375897ea0 Yannick Guerrini       2015-03-06  2827   * Groups are always multiples of atom size and CPUs which are of
3c9a024fde58b0 Tejun Heo              2010-09-09  2828   * LOCAL_DISTANCE both ways are grouped together and share space for
3c9a024fde58b0 Tejun Heo              2010-09-09  2829   * units in the same group.  The returned configuration is guaranteed
3c9a024fde58b0 Tejun Heo              2010-09-09  2830   * to have CPUs on different nodes on different groups and >=75% usage
3c9a024fde58b0 Tejun Heo              2010-09-09  2831   * of allocated virtual address space.
3c9a024fde58b0 Tejun Heo              2010-09-09  2832   *
3c9a024fde58b0 Tejun Heo              2010-09-09  2833   * RETURNS:
3c9a024fde58b0 Tejun Heo              2010-09-09  2834   * On success, pointer to the new allocation_info is returned.  On
3c9a024fde58b0 Tejun Heo              2010-09-09  2835   * failure, ERR_PTR value is returned.
3c9a024fde58b0 Tejun Heo              2010-09-09  2836   */
258e0815e2b170 Dennis Zhou            2021-02-14  2837  static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
3c9a024fde58b0 Tejun Heo              2010-09-09  2838  				size_t reserved_size, size_t dyn_size,
3c9a024fde58b0 Tejun Heo              2010-09-09  2839  				size_t atom_size,
3c9a024fde58b0 Tejun Heo              2010-09-09  2840  				pcpu_fc_cpu_distance_fn_t cpu_distance_fn)
3c9a024fde58b0 Tejun Heo              2010-09-09  2841  {
3c9a024fde58b0 Tejun Heo              2010-09-09  2842  	static int group_map[NR_CPUS] __initdata;
3c9a024fde58b0 Tejun Heo              2010-09-09  2843  	static int group_cnt[NR_CPUS] __initdata;
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2844  	static struct cpumask mask __initdata;
3c9a024fde58b0 Tejun Heo              2010-09-09  2845  	const size_t static_size = __per_cpu_end - __per_cpu_start;
3c9a024fde58b0 Tejun Heo              2010-09-09  2846  	int nr_groups = 1, nr_units = 0;
3c9a024fde58b0 Tejun Heo              2010-09-09  2847  	size_t size_sum, min_unit_size, alloc_size;
3f649ab728cda8 Kees Cook              2020-06-03  2848  	int upa, max_upa, best_upa;	/* units_per_alloc */
3c9a024fde58b0 Tejun Heo              2010-09-09  2849  	int last_allocs, group, unit;
3c9a024fde58b0 Tejun Heo              2010-09-09  2850  	unsigned int cpu, tcpu;
3c9a024fde58b0 Tejun Heo              2010-09-09  2851  	struct pcpu_alloc_info *ai;
3c9a024fde58b0 Tejun Heo              2010-09-09  2852  	unsigned int *cpu_map;
3c9a024fde58b0 Tejun Heo              2010-09-09  2853  
3c9a024fde58b0 Tejun Heo              2010-09-09  2854  	/* this function may be called multiple times */
3c9a024fde58b0 Tejun Heo              2010-09-09  2855  	memset(group_map, 0, sizeof(group_map));
3c9a024fde58b0 Tejun Heo              2010-09-09  2856  	memset(group_cnt, 0, sizeof(group_cnt));
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2857  	cpumask_clear(&mask);
3c9a024fde58b0 Tejun Heo              2010-09-09  2858  
3c9a024fde58b0 Tejun Heo              2010-09-09  2859  	/* calculate size_sum and ensure dyn_size is enough for early alloc */
3c9a024fde58b0 Tejun Heo              2010-09-09  2860  	size_sum = PFN_ALIGN(static_size + reserved_size +
3c9a024fde58b0 Tejun Heo              2010-09-09  2861  			    max_t(size_t, dyn_size, PERCPU_DYNAMIC_EARLY_SIZE));
3c9a024fde58b0 Tejun Heo              2010-09-09  2862  	dyn_size = size_sum - static_size - reserved_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2863  
3c9a024fde58b0 Tejun Heo              2010-09-09  2864  	/*
3c9a024fde58b0 Tejun Heo              2010-09-09  2865  	 * Determine min_unit_size, alloc_size and max_upa such that
3c9a024fde58b0 Tejun Heo              2010-09-09  2866  	 * alloc_size is multiple of atom_size and is the smallest
25985edcedea63 Lucas De Marchi        2011-03-30  2867  	 * which can accommodate 4k aligned segments which are equal to
3c9a024fde58b0 Tejun Heo              2010-09-09  2868  	 * or larger than min_unit_size.
3c9a024fde58b0 Tejun Heo              2010-09-09  2869  	 */
3c9a024fde58b0 Tejun Heo              2010-09-09  2870  	min_unit_size = max_t(size_t, size_sum, PCPU_MIN_UNIT_SIZE);
3c9a024fde58b0 Tejun Heo              2010-09-09  2871  
9c01516278ef87 Dennis Zhou (Facebook  2017-07-15  2872) 	/* determine the maximum # of units that can fit in an allocation */
3c9a024fde58b0 Tejun Heo              2010-09-09  2873  	alloc_size = roundup(min_unit_size, atom_size);
3c9a024fde58b0 Tejun Heo              2010-09-09  2874  	upa = alloc_size / min_unit_size;
f09f1243ca2d5d Alexander Kuleshov     2015-11-05  2875  	while (alloc_size % upa || (offset_in_page(alloc_size / upa)))
3c9a024fde58b0 Tejun Heo              2010-09-09  2876  		upa--;
3c9a024fde58b0 Tejun Heo              2010-09-09  2877  	max_upa = upa;
3c9a024fde58b0 Tejun Heo              2010-09-09  2878  
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2879  	cpumask_copy(&mask, cpu_possible_mask);
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2880  
3c9a024fde58b0 Tejun Heo              2010-09-09  2881  	/* group cpus according to their proximity */
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2882  	for (group = 0; !cpumask_empty(&mask); group++) {
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2883  		/* pop the group's first cpu */
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2884  		cpu = cpumask_first(&mask);
3c9a024fde58b0 Tejun Heo              2010-09-09 @2885  		group_map[cpu] = group;
3c9a024fde58b0 Tejun Heo              2010-09-09  2886  		group_cnt[group]++;
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2887  		cpumask_clear_cpu(cpu, &mask);
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2888  
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2889  		for_each_cpu(tcpu, &mask) {
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2890  			if (!cpu_distance_fn ||
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2891  			    (cpu_distance_fn(cpu, tcpu) == LOCAL_DISTANCE &&
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2892  			     cpu_distance_fn(tcpu, cpu) == LOCAL_DISTANCE)) {
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2893  				group_map[tcpu] = group;
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2894  				group_cnt[group]++;
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2895  				cpumask_clear_cpu(tcpu, &mask);
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2896  			}
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2897  		}
3c9a024fde58b0 Tejun Heo              2010-09-09  2898  	}
d7d29ac76f7efb Wonhyuk Yang           2020-10-30  2899  	nr_groups = group;
3c9a024fde58b0 Tejun Heo              2010-09-09  2900  
3c9a024fde58b0 Tejun Heo              2010-09-09  2901  	/*
9c01516278ef87 Dennis Zhou (Facebook  2017-07-15  2902) 	 * Wasted space is caused by a ratio imbalance of upa to group_cnt.
9c01516278ef87 Dennis Zhou (Facebook  2017-07-15  2903) 	 * Expand the unit_size until we use >= 75% of the units allocated.
9c01516278ef87 Dennis Zhou (Facebook  2017-07-15  2904) 	 * Related to atom_size, which could be much larger than the unit_size.
3c9a024fde58b0 Tejun Heo              2010-09-09  2905  	 */
3c9a024fde58b0 Tejun Heo              2010-09-09  2906  	last_allocs = INT_MAX;
4829c791b22f98 Dennis Zhou            2021-06-14  2907  	best_upa = 0;
3c9a024fde58b0 Tejun Heo              2010-09-09  2908  	for (upa = max_upa; upa; upa--) {
3c9a024fde58b0 Tejun Heo              2010-09-09  2909  		int allocs = 0, wasted = 0;
3c9a024fde58b0 Tejun Heo              2010-09-09  2910  
f09f1243ca2d5d Alexander Kuleshov     2015-11-05  2911  		if (alloc_size % upa || (offset_in_page(alloc_size / upa)))
3c9a024fde58b0 Tejun Heo              2010-09-09  2912  			continue;
3c9a024fde58b0 Tejun Heo              2010-09-09  2913  
3c9a024fde58b0 Tejun Heo              2010-09-09  2914  		for (group = 0; group < nr_groups; group++) {
3c9a024fde58b0 Tejun Heo              2010-09-09  2915  			int this_allocs = DIV_ROUND_UP(group_cnt[group], upa);
3c9a024fde58b0 Tejun Heo              2010-09-09  2916  			allocs += this_allocs;
3c9a024fde58b0 Tejun Heo              2010-09-09  2917  			wasted += this_allocs * upa - group_cnt[group];
3c9a024fde58b0 Tejun Heo              2010-09-09  2918  		}
3c9a024fde58b0 Tejun Heo              2010-09-09  2919  
3c9a024fde58b0 Tejun Heo              2010-09-09  2920  		/*
3c9a024fde58b0 Tejun Heo              2010-09-09  2921  		 * Don't accept if wastage is over 1/3.  The
3c9a024fde58b0 Tejun Heo              2010-09-09  2922  		 * greater-than comparison ensures upa==1 always
3c9a024fde58b0 Tejun Heo              2010-09-09  2923  		 * passes the following check.
3c9a024fde58b0 Tejun Heo              2010-09-09  2924  		 */
3c9a024fde58b0 Tejun Heo              2010-09-09  2925  		if (wasted > num_possible_cpus() / 3)
3c9a024fde58b0 Tejun Heo              2010-09-09  2926  			continue;
3c9a024fde58b0 Tejun Heo              2010-09-09  2927  
3c9a024fde58b0 Tejun Heo              2010-09-09  2928  		/* and then don't consume more memory */
3c9a024fde58b0 Tejun Heo              2010-09-09  2929  		if (allocs > last_allocs)
3c9a024fde58b0 Tejun Heo              2010-09-09  2930  			break;
3c9a024fde58b0 Tejun Heo              2010-09-09  2931  		last_allocs = allocs;
3c9a024fde58b0 Tejun Heo              2010-09-09  2932  		best_upa = upa;
3c9a024fde58b0 Tejun Heo              2010-09-09  2933  	}
4829c791b22f98 Dennis Zhou            2021-06-14  2934  	BUG_ON(!best_upa);
3c9a024fde58b0 Tejun Heo              2010-09-09  2935  	upa = best_upa;
3c9a024fde58b0 Tejun Heo              2010-09-09  2936  
3c9a024fde58b0 Tejun Heo              2010-09-09  2937  	/* allocate and fill alloc_info */
3c9a024fde58b0 Tejun Heo              2010-09-09  2938  	for (group = 0; group < nr_groups; group++)
3c9a024fde58b0 Tejun Heo              2010-09-09  2939  		nr_units += roundup(group_cnt[group], upa);
3c9a024fde58b0 Tejun Heo              2010-09-09  2940  
3c9a024fde58b0 Tejun Heo              2010-09-09  2941  	ai = pcpu_alloc_alloc_info(nr_groups, nr_units);
3c9a024fde58b0 Tejun Heo              2010-09-09  2942  	if (!ai)
3c9a024fde58b0 Tejun Heo              2010-09-09  2943  		return ERR_PTR(-ENOMEM);
3c9a024fde58b0 Tejun Heo              2010-09-09  2944  	cpu_map = ai->groups[0].cpu_map;
3c9a024fde58b0 Tejun Heo              2010-09-09  2945  
3c9a024fde58b0 Tejun Heo              2010-09-09  2946  	for (group = 0; group < nr_groups; group++) {
3c9a024fde58b0 Tejun Heo              2010-09-09  2947  		ai->groups[group].cpu_map = cpu_map;
3c9a024fde58b0 Tejun Heo              2010-09-09  2948  		cpu_map += roundup(group_cnt[group], upa);
3c9a024fde58b0 Tejun Heo              2010-09-09  2949  	}
3c9a024fde58b0 Tejun Heo              2010-09-09  2950  
3c9a024fde58b0 Tejun Heo              2010-09-09  2951  	ai->static_size = static_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2952  	ai->reserved_size = reserved_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2953  	ai->dyn_size = dyn_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2954  	ai->unit_size = alloc_size / upa;
3c9a024fde58b0 Tejun Heo              2010-09-09  2955  	ai->atom_size = atom_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2956  	ai->alloc_size = alloc_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2957  
2de7852fe9096e Peng Fan               2019-02-20  2958  	for (group = 0, unit = 0; group < nr_groups; group++) {
3c9a024fde58b0 Tejun Heo              2010-09-09  2959  		struct pcpu_group_info *gi = &ai->groups[group];
3c9a024fde58b0 Tejun Heo              2010-09-09  2960  
3c9a024fde58b0 Tejun Heo              2010-09-09  2961  		/*
3c9a024fde58b0 Tejun Heo              2010-09-09  2962  		 * Initialize base_offset as if all groups are located
3c9a024fde58b0 Tejun Heo              2010-09-09  2963  		 * back-to-back.  The caller should update this to
3c9a024fde58b0 Tejun Heo              2010-09-09  2964  		 * reflect actual allocation.
3c9a024fde58b0 Tejun Heo              2010-09-09  2965  		 */
3c9a024fde58b0 Tejun Heo              2010-09-09  2966  		gi->base_offset = unit * ai->unit_size;
3c9a024fde58b0 Tejun Heo              2010-09-09  2967  
3c9a024fde58b0 Tejun Heo              2010-09-09  2968  		for_each_possible_cpu(cpu)
3c9a024fde58b0 Tejun Heo              2010-09-09  2969  			if (group_map[cpu] == group)
3c9a024fde58b0 Tejun Heo              2010-09-09  2970  				gi->cpu_map[gi->nr_units++] = cpu;
3c9a024fde58b0 Tejun Heo              2010-09-09  2971  		gi->nr_units = roundup(gi->nr_units, upa);
3c9a024fde58b0 Tejun Heo              2010-09-09  2972  		unit += gi->nr_units;
3c9a024fde58b0 Tejun Heo              2010-09-09  2973  	}
3c9a024fde58b0 Tejun Heo              2010-09-09  2974  	BUG_ON(unit != nr_units);
3c9a024fde58b0 Tejun Heo              2010-09-09  2975  
3c9a024fde58b0 Tejun Heo              2010-09-09  2976  	return ai;
3c9a024fde58b0 Tejun Heo              2010-09-09  2977  }
23f917169ef157 Kefeng Wang            2022-01-19  2978  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

