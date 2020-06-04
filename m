Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320D61EE0FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFDJRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgFDJRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:17:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226EDC03E96D
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2020 02:17:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l1so4078722ede.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2020 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhAP4FrRDZrjypcHYBWPYi+wkv0jiWxIjMhRADC+Z5I=;
        b=gAJavElU635AJKokbORkRDl2kDekyNy4u8CmFMidi8khzlpUxFcGRfzaeZ3Jgj9mOB
         1+tKhkMzDGoDn2AGpuzJ0NsaB1c3+XFNNzAZKaQYHmNxgVeT+XUEk+2k16vEB2GOO7M3
         yHp6Vl00koFbXurW03WpWE/JSwfPOtiGtfhvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhAP4FrRDZrjypcHYBWPYi+wkv0jiWxIjMhRADC+Z5I=;
        b=OuGnjN5MnWuI6amm0jwgEFyOT68wllWEMprJFD6W4R9aK2jrRIbP05rVMbZ9m4Huc9
         cNIH3p4+wggTZ0aRZMJ4eyc4/8F8SSRM2bjbVcQurtE/aQ8OxYVtQxhzLGwXhLDuK6sZ
         k4OFtYbq71bN/qjTB8QGYqZR+E0kSBEL/hyBZmz7c1H5UAIiIEVVdSkNzobH5Wvojt0S
         0LZi9HBA1TvSCPGH5vSX4i+tDQW3N01JC2/pE9UIIYc8/Z1woCj0QravXiu6Yi24yhjk
         VkoaH/cre2AsOuILZSGwDJaTlzQdCNhpLQI1UnCw6sU8lrUuicnF/ZHOXOaGP9ViSYLS
         XP1A==
X-Gm-Message-State: AOAM5313R2GGO/O75KN1Xnoz8JbfH0jWLcO6ENdy772PJ903lyk78Q4f
        te5WajMOQDy+etQBNiRjnlKk3PZuvXlX7ON0FwM84g==
X-Google-Smtp-Source: ABdhPJx61AOxmZRmL/Oy5iwZykzcL1rHsU7jxY58d6SBzKQDu9pppgd1wvMKOMT3TGbZI7nXAdbF8OSqjlU8BfXzx44=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr3554653edq.17.1591262220848;
 Thu, 04 Jun 2020 02:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
 <202005281652.QNakLkW3%lkp@intel.com> <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
In-Reply-To: <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Jun 2020 11:16:49 +0200
Message-ID: <CAJfpegtz=tzndsF=_1tYHewGwEgvqEOA_4zj8HCAqyFdKe6mag@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: provide real_file() and overlayfs get_unmapped_area()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 11:01 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/28/20 1:37 AM, kbuild test robot wrote:
> > Hi Mike,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on miklos-vfs/overlayfs-next]
> > [also build test ERROR on linus/master v5.7-rc7]
> > [cannot apply to linux/master next-20200526]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Mike-Kravetz/ovl-provide-real_file-and-overlayfs-get_unmapped_area/20200528-080533
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
> > config: h8300-randconfig-r036-20200528 (attached as .config)
> > compiler: h8300-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All error/warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > fs/overlayfs/file.c: In function 'ovl_get_unmapped_area':
> >>> fs/overlayfs/file.c:768:14: error: 'struct mm_struct' has no member named 'get_unmapped_area'
> > 768 |   current->mm->get_unmapped_area)(realfile,
> > |              ^~
> >>> fs/overlayfs/file.c:770:1: warning: control reaches end of non-void function [-Wreturn-type]
> > 770 | }
> > | ^
> >
> > vim +768 fs/overlayfs/file.c
> >
> >    760
> >    761        static unsigned long ovl_get_unmapped_area(struct file *file,
> >    762                                        unsigned long uaddr, unsigned long len,
> >    763                                        unsigned long pgoff, unsigned long flags)
> >    764        {
> >    765                struct file *realfile = real_file(file);
> >    766
> >    767                return (realfile->f_op->get_unmapped_area ?:
> >  > 768                        current->mm->get_unmapped_area)(realfile,
> >    769                                                        uaddr, len, pgoff, flags);
> >  > 770        }
> >    771
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
>
> Well yuck!  get_unmapped_area is not part of mm_struct if !CONFIG_MMU.
>
> Miklos, would adding '#ifdef CONFIG_MMU' around the overlayfs code be too
> ugly for you?  Another option is to use real_file() in the mmap code as
> done in [1].

I think the proper fix is to add an inline helper
(call_get_unmapped_area()?) in linux/mm.h, and make that work properly
for the NOMMU case as well.

Thanks,
Miklos
