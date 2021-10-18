Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293A0430DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 04:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhJRCET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Oct 2021 22:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhJRCET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Oct 2021 22:04:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09043C06161C;
        Sun, 17 Oct 2021 19:02:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o133so13486215pfg.7;
        Sun, 17 Oct 2021 19:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gnfNXEgujGvawauEg9YydXWS6BRz/6cMDQi7O0o09Zs=;
        b=OSSKds8FSYbCcj1NACgvGgwqPBjvXDN9lJ4tZ33t1UmiCNeE6B+J9rb4/W/8QLXRag
         KfHc37psA0fkFbmIQflXwiC92dJs8c/452nO2eyEY7DPq6ES20YQebv4uDV6lxXeL3IE
         XwBUlbnbSJTB0oLyi8YDxeXlhD5mmtYFzW3peGbx7HYMICh5Ij8hvCZmd2pV10/DZeFj
         ufOXTampJ3XZ0soFS0p14bGYbNI4vaX6hcUFiQb2TKKBflSZyubV5nPkEIuijn7kVcFj
         9KHMHDxcSqUEVCvpROPkXRdcnSXxUw8kA+eUrtZWlb58L4lk2+r86WHS87MlGPICFVER
         aOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gnfNXEgujGvawauEg9YydXWS6BRz/6cMDQi7O0o09Zs=;
        b=lPA8ZVHOgyXB3tKHxipcyTScK/lcm+CLZiFW6YvVF4CDn3cF+KQLXKCuq6rMrPDMgb
         934q07KR9HwMx1uJhVig3qgjT8yA2Hgph0z34Ct4TVKFRzEoMcpjps6zUb5cw+zcHKYU
         CrvGr4+qkkgJG2apfEsTC9m3cm2Ktjx2X83yzdz/sKUjW81EzCKfwIFxYxCG5kY3PBrK
         A1u9647/q3NYKgTBuOkXIkbDvO0BQzsXVMu5g13hCKupgG1YN1yBR8yd3EozQUhEiteH
         Ap2orupCBsrmcfcw9tB7LT7x+Ec8K+p0N8vaAyxFrx60gspfjUjP2Q1GcAcy81QejzRv
         QEtw==
X-Gm-Message-State: AOAM531z3fKU3zCQ/EnT2asV2amuq6b5+6wApFbsAxeQ/i6fo7aLSml1
        XonSrAErJpvybL2vpT5RTgveEHrjYsIyQZaD
X-Google-Smtp-Source: ABdhPJxHnbYE3nUsnSbmgPYLkgQbrShltoz0ZUMBjL+SPxQxBZxDGUmbVBOPPw1ZYvtraPtTcQEWAw==
X-Received: by 2002:a05:6a00:c1:b0:44c:ec40:b47 with SMTP id e1-20020a056a0000c100b0044cec400b47mr26094657pfj.76.1634522527790;
        Sun, 17 Oct 2021 19:02:07 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id d137sm11428224pfd.72.2021.10.17.19.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 19:02:07 -0700 (PDT)
Subject: Re: [PATCH] fs: inode: use queue_rcu_work() instead of call_rcu()
To:     kernel test robot <lkp@intel.com>, willy@infradead.org,
        hch@infradead.org, akpm@linux-foundation.org, sunhao.th@gmail.com
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211015080216.4871-1-qiang.zhang1211@gmail.com>
 <202110152130.xS6rNVMW-lkp@intel.com>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <db12d556-24f2-b790-ec48-b03fac9c4130@gmail.com>
Date:   Mon, 18 Oct 2021 10:02:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110152130.xS6rNVMW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2021/10/15 下午9:54, kernel test robot wrote:
> Hi Zqiang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.15-rc5 next-20211015]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Zqiang/fs-inode-use-queue_rcu_work-instead-of-call_rcu/20211015-160455
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ec681c53f8d2d0ee362ff67f5b98dd8263c15002
> config: arc-randconfig-r043-20211014 (attached as .config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/2294caaec521b45bdc9db96423fe51762e47afd0
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Zqiang/fs-inode-use-queue_rcu_work-instead-of-call_rcu/20211015-160455
>          git checkout 2294caaec521b45bdc9db96423fe51762e47afd0
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash fs/ntfs3/ fs/xfs/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from <command-line>:
>     fs/ntfs3/super.c: In function 'ntfs_i_callback':
>>> include/linux/kernel.h:495:58: error: 'struct inode' has no member named 'i_rcu'
>       495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>           |                                                          ^~
>     include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
>       302 |                 if (!(condition))                                       \
>           |                       ^~~~~~~~~
>     include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
>       322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^~~~~~~~~~~~~~~~~~
>     include/linux/kernel.h:495:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>           |         ^~~~~~~~~~~~~~~~
>     include/linux/kernel.h:495:27: note: in expansion of macro '__same_type'
>       495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>           |                           ^~~~~~~~~~~
>     fs/ntfs3/super.c:458:31: note: in expansion of macro 'container_of'
>       458 |         struct inode *inode = container_of(head, struct inode, i_rcu);
>           |                               ^~~~~~~~~~~~
>>> include/linux/compiler_types.h:140:41: error: 'struct inode' has no member named 'i_rcu'
>       140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
>           |                                         ^~~~~~~~~~~~~~~~~~
>     include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
>        17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
>           |                                 ^~~~~~~~~~~~~~~~~~~
>     include/linux/kernel.h:498:28: note: in expansion of macro 'offsetof'
>       498 |         ((type *)(__mptr - offsetof(type, member))); })
>           |                            ^~~~~~~~
>     fs/ntfs3/super.c:458:31: note: in expansion of macro 'container_of'
>       458 |         struct inode *inode = container_of(head, struct inode, i_rcu);
>           |                               ^~~~~~~~~~~~
>     fs/ntfs3/super.c: In function 'ntfs_destroy_inode':
>>> fs/ntfs3/super.c:468:24: error: 'struct inode' has no member named 'i_rcu'
>       468 |         call_rcu(&inode->i_rcu, ntfs_i_callback);
>           |                        ^~
> --
>     In file included from <command-line>:
>     fs/xfs/xfs_icache.c: In function 'xfs_inode_free_callback':
>>> include/linux/kernel.h:495:58: error: 'struct inode' has no member named 'i_rcu'
>       495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>           |                                                          ^~
>     include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
>       302 |                 if (!(condition))                                       \
>           |                       ^~~~~~~~~
>     include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
>       322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^~~~~~~~~~~~~~~~~~
>     include/linux/kernel.h:495:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>           |         ^~~~~~~~~~~~~~~~
>     include/linux/kernel.h:495:27: note: in expansion of macro '__same_type'
>       495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>           |                           ^~~~~~~~~~~
>     fs/xfs/xfs_icache.c:120:42: note: in expansion of macro 'container_of'
>       120 |         struct inode            *inode = container_of(head, struct inode, i_rcu);
>           |                                          ^~~~~~~~~~~~
>>> include/linux/compiler_types.h:140:41: error: 'struct inode' has no member named 'i_rcu'
>       140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
>           |                                         ^~~~~~~~~~~~~~~~~~
>     include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
>        17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
>           |                                 ^~~~~~~~~~~~~~~~~~~
>     include/linux/kernel.h:498:28: note: in expansion of macro 'offsetof'
>       498 |         ((type *)(__mptr - offsetof(type, member))); })
>           |                            ^~~~~~~~
>     fs/xfs/xfs_icache.c:120:42: note: in expansion of macro 'container_of'
>       120 |         struct inode            *inode = container_of(head, struct inode, i_rcu);
>           |                                          ^~~~~~~~~~~~
>     fs/xfs/xfs_icache.c: In function '__xfs_inode_free':
>>> fs/xfs/xfs_icache.c:158:28: error: 'struct inode' has no member named 'i_rcu'
>       158 |         call_rcu(&VFS_I(ip)->i_rcu, xfs_inode_free_callback);
>           |                            ^~
>
>
> vim +495 include/linux/kernel.h
>
> cf14f27f82af78 Alexei Starovoitov 2018-03-28  485
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  486  /**
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  487   * container_of - cast a member of a structure out to the containing structure
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  488   * @ptr:	the pointer to the member.
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  489   * @type:	the type of the container struct this is embedded in.
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  490   * @member:	the name of the member within the struct.
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  491   *
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  492   */
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  493  #define container_of(ptr, type, member) ({				\
> c7acec713d14c6 Ian Abbott         2017-07-12  494  	void *__mptr = (void *)(ptr);					\
> c7acec713d14c6 Ian Abbott         2017-07-12 @495  	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
> c7acec713d14c6 Ian Abbott         2017-07-12  496  			 !__same_type(*(ptr), void),			\
> c7acec713d14c6 Ian Abbott         2017-07-12  497  			 "pointer type mismatch in container_of()");	\
> c7acec713d14c6 Ian Abbott         2017-07-12  498  	((type *)(__mptr - offsetof(type, member))); })
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  499
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Sorry this is my mistake, Please ignore this change.

Zqiang


