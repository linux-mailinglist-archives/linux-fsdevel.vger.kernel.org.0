Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9997A12AA34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 06:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfLZFJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 00:09:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41628 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLZFJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 00:09:56 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so18792540ioo.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2019 21:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAZfaEs6YpKYtHBM8W7V/Ev4pydDAEShxtV81100U6U=;
        b=l6Kf1yoZ/VDr2Stni7nyAyxyDBhwnD7Cj/CNTdZ8wCVkgkA7THrfcEMXYYJf644/MP
         OYTt7l4FPeMCeyHGkhcjQ6A5FuHd7YePURVqrhTtIkZ6VE9pWTFtbI9Gg8JsTdDgdl1r
         wPYyCZza0U/pHi1Deem5DgJkplstwhGZQEjCtz+oqk4Q33V24YW3YGrk+QAUI8blDKnU
         MSi0vTG4CWY5wliCwmZxbK1fM3OtfpjY0+nzMsUFZo+Cze7Va4Cj3dClf4vgqstW5ryq
         yYYGv1b3p7wIfx1kHsXYU2nqqwacpKaxhF7HE154pFmTRytyTrn6rJuXBSKFTkEsZuoX
         XuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAZfaEs6YpKYtHBM8W7V/Ev4pydDAEShxtV81100U6U=;
        b=XfIAugS+D9aL+grNfnxFZD+KjxTnx6OQBP+4IbB5A3Oky+LkmMwWTVJ+YQYgU2IA3Q
         bYOqbQ+3AY9/LoOd+UApY3LfgK+uIh8zycdf9BTOGE9NfXNS7eI4Pcxf9T93AQm/aVzS
         ms3OQWWYGveOOLhsFmjtSdN8zfzQEmVO/CqSmh86xa+CryJNk5HJzqwgWeb5Kp5gMPL1
         q0xStxJtSCZcrwqiZ6xm6p0n84cd6cmcBUWOU78hSJCuMAW+1kEmTIwI61WVmk4j5f/0
         /H6vaxWgn7Kl6uK4aBXY+Z9MU4QcZMRhWXCW/BiQUyLFCWoc1sKcZJbp2phKmGJep8YI
         BkYg==
X-Gm-Message-State: APjAAAUlYpWbILXfQA5j2BWJYcbR2BWBWkrk3Wx5Ndjy95uQlhwJ5jUd
        weD1R/eOWiE6UjiQP2NE6/Cfr6mMCAfZFTvO2pc=
X-Google-Smtp-Source: APXvYqwSrDTzpWUuR/DoX4y6F/l8/SL9ykrmtDdwruroS0Uop+WbBJ1VXdDRLyqrXNfn3BjDSWsNA//VlPJwKD+6qh4=
X-Received: by 2002:a5d:8b96:: with SMTP id p22mr28833877iol.93.1577336995413;
 Wed, 25 Dec 2019 21:09:55 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-6-git-send-email-laoar.shao@gmail.com> <201912252113.85DYfWul%lkp@intel.com>
In-Reply-To: <201912252113.85DYfWul%lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 26 Dec 2019 13:09:19 +0800
Message-ID: <CALOAHbCYZSPmYuouCX+WEG6C5zssLt5qtOOSxz6gQ+ht0GbvNg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] memcg, inode: protect page cache from freeing inode
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 9:19 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Yafang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.5-rc3 next-20191220]
> [cannot apply to mmotm/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Yafang-Shao/protect-page-cache-from-freeing-inode/20191225-193636
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 46cf053efec6a3a5f343fead837777efe8252a46
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/swap.h:9:0,
>                     from include/linux/suspend.h:5,
>                     from arch/x86/kernel/asm-offsets.c:13:
> >> include/linux/memcontrol.h:872:23: error: conflicting types for 'memcg'
>             struct inode *memcg)
>                           ^~~~~
>    include/linux/memcontrol.h:871:63: note: previous definition of 'memcg' was here
>     static inline bool memcg_can_reclaim_inode(struct mem_cgroup *memcg,
>                                                                   ^~~~~
>    make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
>    9 real  4 user  3 sys  93.40% cpu    make prepare
>
> vim +/memcg +872 include/linux/memcontrol.h
>
>    870
>    871  static inline bool memcg_can_reclaim_inode(struct mem_cgroup *memcg,
>  > 872                                             struct inode *memcg)
>    873  {
>    874          return true;
>    875  }
>    876
>

Will fix this build error (when CONFIG_MEMCG_KMEM is not set) in next
version, thanks kbuild test robot.

Thanks
Yafang
