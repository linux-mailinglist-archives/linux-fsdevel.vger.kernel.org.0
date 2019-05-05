Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF53141D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfEES00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 14:26:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36669 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfEES00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 14:26:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id q185so8718391ywe.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2019 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/yZ8vxVRHr/ebEgX80KHhSm47yf9wQnIHda3hAE+RA=;
        b=pSgjwBvk3z5l5uZklgdwK7WVW8vYGN+5jgWosCIUtq9ojoBEbi+p4ZTkABsS1rryUm
         s/5rVZXDBfIf24peoU/Xx6QM+iIbRf3jwW0sYvD9viJlq4NiMCjwTbOqEe8mT4KorWbr
         ZHDfNSmgl1+AbVxN2Wz6CzwYIMY1pH16bpDkHNOQm0CQHFo3avv+7EyL/4/Tppm9warb
         CryeFiXFgwAeO2C6CNLhww87vqNx+l7qjmwnYDmGCx29LHrR9e0Zsw98GngQtE3sMd+m
         goUFpBOIhoQ1rpQ0TKZkakOIcvxPPZpbsNjEIwl3ezjUdN7HbCeclxIQaHdQhoOU3ves
         +DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/yZ8vxVRHr/ebEgX80KHhSm47yf9wQnIHda3hAE+RA=;
        b=GHVSYQsFb5sCztkATWEdHejkcYcguA+x6JdVtHwP+GR+1B0n9AVs5kA7OEf/85w63S
         +9adHV6Vtn6fLkx5tVQ1ojZGrqfMDg+KKu3TGMhEmGMWwPQSBqI81boyL5UYdUEM/nxs
         Ca3IvOAnTzldQnn/xgaDWfwHKeQ33O/CLqpQsrmunlg7Y1xJfvAhgHuvmNXIG2TET48k
         p8L+oFZeEvjYV++CxmznkIr0Wu5Lf0O23HIC7bogm0+jEBeo3qsz3ovu4qlUc5oNw12/
         +dcIb2EVvtxWS0ZevZBZYBiaC9zg4XNFdnMd1b5GI3eKF0TDrCOba0I+jzce0cZeK4J0
         dkGg==
X-Gm-Message-State: APjAAAWQeS/iV5NjyAXeOLcMk4WWgWvqvX6ZR7KTNRCmxbiBiUQdyjrD
        LI7veV5/HqYaUkPxD1JuMVP7wBnMvIv8zU4gcQQ=
X-Google-Smtp-Source: APXvYqylPfXvPrgaCJnZp9ZwOu9DtS+z+XdCLbgr4JitRzHaSx1wqex1/S4xaup0fKPCmcVbE6TJLXqBNpF1luR3HVM=
X-Received: by 2002:a0d:ff82:: with SMTP id p124mr15836954ywf.409.1557080785290;
 Sun, 05 May 2019 11:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190505091549.1934-1-amir73il@gmail.com> <201905060021.I3fgRl4C%lkp@intel.com>
In-Reply-To: <201905060021.I3fgRl4C%lkp@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 5 May 2019 21:26:14 +0300
Message-ID: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 5, 2019 at 7:34 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Amir,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.1-rc7 next-20190503]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/fsnotify-fix-unlink-performance-regression/20190505-233115
> config: riscv-tinyconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from fs///attr.c:15:
>    include/linux/fsnotify.h: In function 'fsnotify_nameremove':
> >> include/linux/fsnotify.h:179:23: error: 'struct inode' has no member named 'i_fsnotify_mask'
>      if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
>                           ^~
> >> include/linux/fsnotify.h:180:20: error: 'struct super_block' has no member named 's_fsnotify_mask'
>          !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
>                        ^~
>

Crap! forgot these wrappers are not NOOPed without CONFIG_FSNOTIFY.
It is so annoying to fix bugs in code that should not exist.

In d_delete() at this point, dentry is either negative or inode->i_nlink
which accounts for this name should be decremented.
If d_move() was possible on this dentry, bad things would happen.

I really wish I could just drop this take_dentry_name_snapshot()
and leave the WARN_ON() I suggested instead...
For now will just send an unbroken patch.

Thanks,
Amir.
