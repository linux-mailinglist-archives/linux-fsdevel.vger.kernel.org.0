Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033DF6A5E18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjB1RTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1RS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:18:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563361ABE7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 09:18:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ee7so43154388edb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677604737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VLoVWdqrXACCM2GouapKLA9JL96p1Na7WBfaOoEKQxA=;
        b=G7LehqzooPd8BCbeVlFg+jPMKCKGZ/IaHR/YO9AaRRat3p9+dKtcz4sRNFa1rulDtP
         cDvvp8FdhyThlOUkEulw+aqyrbHsMr0nvvCC/teWJI395UJCOZsBn70eMJfkACmFTyB9
         bffi1DJEyls1hUkdU1a6D54Ixfo2+5vsUIFyFXSz5fmFMLdJkkRTOYPNVGAY4g1A74q5
         twd08sGthmaUN5PtZ06HgrBvOWqJC7Vvnrznivo0Pmo5Z1Z1sg7xjC+1AYR0oCTXfHZ6
         Y9O+Qe/RBmHl4PBkXjs1gdazqNRDWm/BYz38LYItv5LAWsxcxlTJoFHabbJ3KtzqTS04
         JMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677604737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLoVWdqrXACCM2GouapKLA9JL96p1Na7WBfaOoEKQxA=;
        b=llDerEmj2PEL5UNyg5vp1Y5SUdCn33XXXP1CuO424xlDwO2WHug/jP0Zwz7VMip1J5
         CNXCTIPqkY5+R0p7K3UYaFDeKlEnbAXwQH/o91gBwtIeorF1ZDLF/Bfu69YGnnyGNfmY
         Z+JEIlfIOMme5L8Uyx5XDFfCdIOZ9xy2Kw+GarKTki6HHjjIppM9SvKQWJJTgZ/0vVT5
         Cw0JeHYqR+6oqnWD/oY9zx9flHQ2NU3iqCONJAWDwPYUPlV/PwVP8LkDI4b9/4yACwGP
         o4pazas9lU4yZGLK2zqX+P3XPjmCmvtlrDOUClMXILzx/EoRDEQkz+y5+n1gkEUy54OO
         XvVg==
X-Gm-Message-State: AO0yUKU3hEjsT/ZbpcR9odzx4RkzIGQkpCwZh8VDgXNwvOR94U1cDRza
        cdDMpik0dw3/vRC4nbgNj6/mJu3Pc+7bhZ7PvgKTtg==
X-Google-Smtp-Source: AK7set/vaTqJWeJXi/PEHEc/NmmBXXfMfDTI+pq1bMDgth7G7QT71O0RPAOZmRrFprNOY8p2ozFAFihCdZMUz1x/Rn0=
X-Received: by 2002:a50:8e5b:0:b0:4ab:3a49:68b9 with SMTP id
 27-20020a508e5b000000b004ab3a4968b9mr2136811edx.5.1677604736513; Tue, 28 Feb
 2023 09:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20230228085002.2592473-3-yosryahmed@google.com> <202302281933.vU1PHuZr-lkp@intel.com>
In-Reply-To: <202302281933.vU1PHuZr-lkp@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Feb 2023 09:18:19 -0800
Message-ID: <CAJD7tkZxwuR6JoVo9RnepXA3Kg7HVMLyzTfTdRvLg27OihECiw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     kernel test robot <lkp@intel.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 3:56 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Yosry,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master next-20230228]
> [cannot apply to vbabka-slab/for-next xfs-linux/for-next v6.2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-vmscan-refactor-updating-reclaimed-pages-in-reclaim_state/20230228-165214
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230228085002.2592473-3-yosryahmed%40google.com
> patch subject: [PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
> config: i386-randconfig-a002-20230227 (https://download.01.org/0day-ci/archive/20230228/202302281933.vU1PHuZr-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/f6d2b849f186a927925a29e289d60895048550f5
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yosry-Ahmed/mm-vmscan-refactor-updating-reclaimed-pages-in-reclaim_state/20230228-165214
>         git checkout f6d2b849f186a927925a29e289d60895048550f5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302281933.vU1PHuZr-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> mm/vmscan.c:549:13: error: redefinition of 'cgroup_reclaim'
>    static bool cgroup_reclaim(struct scan_control *sc)
>                ^
>    mm/vmscan.c:191:13: note: previous definition is here
>    static bool cgroup_reclaim(struct scan_control *sc)
>                ^
> >> mm/vmscan.c:554:13: error: redefinition of 'global_reclaim'
>    static bool global_reclaim(struct scan_control *sc)
>                ^
>    mm/vmscan.c:196:13: note: previous definition is here
>    static bool global_reclaim(struct scan_control *sc)
>                ^
>    2 errors generated.

Ugh yeah I didn't realize I am moving the definitions from within an
#ifdef CONFIG_MEMCG. I will just leave the definitions as-is and add a
forward declaration before the definition of
add_non_vmscan_reclaimed(), should also reduce the churn in the diff.
Will wait for a bit before re-spinning to gather some feedback on the
current version first.

>
>
> vim +/cgroup_reclaim +549 mm/vmscan.c
>
> 86750830468506 Yang Shi        2021-05-04  548
> b5ead35e7e1d34 Johannes Weiner 2019-11-30 @549  static bool cgroup_reclaim(struct scan_control *sc)
> 89b5fae5368f6a Johannes Weiner 2012-01-12  550  {
> b5ead35e7e1d34 Johannes Weiner 2019-11-30  551          return false;
> 89b5fae5368f6a Johannes Weiner 2012-01-12  552  }
> 97c9341f727105 Tejun Heo       2015-05-22  553
> a579086c99ed70 Yu Zhao         2022-12-21 @554  static bool global_reclaim(struct scan_control *sc)
> a579086c99ed70 Yu Zhao         2022-12-21  555  {
> a579086c99ed70 Yu Zhao         2022-12-21  556          return true;
> a579086c99ed70 Yu Zhao         2022-12-21  557  }
> a579086c99ed70 Yu Zhao         2022-12-21  558
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
