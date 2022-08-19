Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8512859A4D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 20:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354835AbiHSRt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 13:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351301AbiHSRst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:48:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC210F682
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 10:17:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s1so4136444lfp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jF3p7eucLj35Tf/dx8yU7+OQzgohLYj/T6WQnEPpcq8=;
        b=oV8cmQ/AYe6fKs6g5xkmrGZTX3b66teSY2TQYduxFdvsAaMZZ7TmFJDbslZdso2dR/
         a6Z2zrTLsGVnEqLcIKBdLlq40S/0WLtd1cp2TWyUUekD8VOJ32hrY1AMqIuqDpqwqWF5
         pWpQWWdZvqs6R1A8FtAyzMNyg7pj0bRp10NTmZ1Jgbf5ifavFlxpr5PSIy8oPavvGxoA
         dAbDhysYbOQYplefwU7Riqe4Q82hWQ0TwSoZtHQUWJotljEC9OzenqirtaXbNe3ZmKYe
         7NzbrITsERQNqZ3IgUaIJSdZ7kG6fjp7vJepFYBPQNMIV75uL0LzKsXiWFco/6FJGEYx
         cKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jF3p7eucLj35Tf/dx8yU7+OQzgohLYj/T6WQnEPpcq8=;
        b=0B07o6RVPePakF+8m8HYQNx50jqJWtgpmPxJ5VnJ2I1r0poghQfvWhLm3Jv+pGqItK
         q9rgydJ/ghYjQnwEmAhgbBTsbYnxXDj5vi+8tVBE0+JpGBMAyFfr48Kh0I3liM8BoIc6
         oZcX27KzE74UzHvFge3HhqhDmRGvSqPxQGLM82PZvT0Luw0y/LiJxvQLof2NXntWzY1J
         cprHsJyF5aksVyR/ZoTv3jaiHigC2NHo6LSo5j4LsXMB8aEpObq3Q+dtghG7LYI0Ptvf
         zw/OBSwwsO/baw6yIZX20jTO7P7tm5y4B3mVxY+Hm7+UDIOqBPNEZoGqtEyWlHfT96s0
         cm/A==
X-Gm-Message-State: ACgBeo1BSDdKatTEvtrmzGQthfYSSS2HpqjoiNWij1r8riI7gARm3l6H
        yg5mpddLWdMHHXPZyHWf3g1HCoD7fyFqOUrk9yEDIA==
X-Google-Smtp-Source: AA6agR6eA764nLrYZaBVmT71AjszmnBSG/gKjjWIEFAe6ZKPz7BslEWua4WPvIWFK2LgV0AxO0GBjQpn9WvoyasQuh0=
X-Received: by 2002:a05:6512:1317:b0:48c:ed42:5cf4 with SMTP id
 x23-20020a056512131700b0048ced425cf4mr2547681lfu.103.1660929462999; Fri, 19
 Aug 2022 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
 <202208102231.qSUdYAdb-lkp@intel.com> <Yv+5ZkFxhR+JK/Rj@madcap2.tricolour.ca>
In-Reply-To: <Yv+5ZkFxhR+JK/Rj@madcap2.tricolour.ca>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Aug 2022 10:17:31 -0700
Message-ID: <CAKwvOdnQiC++rhVCFToE6t-ZO_VgkhtbH0gy=dEg662EfWucBg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: define struct members to hold response
 decision context
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 9:25 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2022-08-10 22:28, kernel test robot wrote:
> > Hi Richard,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on jack-fs/fsnotify]
> > [also build test WARNING on pcmoore-audit/next linus/master v5.19 next-=
20220810]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Guy-Brig=
gs/fanotify-Allow-user-space-to-pass-back-additional-audit-info/20220810-01=
2825
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.g=
it fsnotify
> > config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/2=
0220810/202208102231.qSUdYAdb-lkp@intel.com/config)
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f=
1c7e2cc5a3c07cbc2412e851a7283c1841f520)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/a943676abc023c0=
94f05b45f4d61936c567507a2
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review Richard-Guy-Briggs/fanotify-Al=
low-user-space-to-pass-back-additional-audit-info/20220810-012825
> >         git checkout a943676abc023c094f05b45f4d61936c567507a2
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash fs/notify/fanotify/
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> fs/notify/fanotify/fanotify_user.c:325:35: warning: format specifies=
 type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int=
') [-Wformat]
>
> Interesting.  When I "fix" it, my compiler complains:
>
>         fs/notify/fanotify/fanotify_user.c:324:11: warning: format =E2=80=
=98%u=E2=80=99 expects argument of type =E2=80=98unsigned int=E2=80=99, but=
 argument 8 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned i=
nt=E2=80=99} [-Wformat=3D]

The correct format specifier for size_t is %zu.  This avoids issues
between ILP32 vs LP64 targets.

>
> >                     group, fd, response, info_buf, count);
> >                                                    ^~~~~
> >    include/linux/printk.h:594:38: note: expanded from macro 'pr_debug'
> >            no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> >                                        ~~~     ^~~~~~~~~~~
> >    include/linux/printk.h:131:17: note: expanded from macro 'no_printk'
> >                    printk(fmt, ##__VA_ARGS__);             \
> >                           ~~~    ^~~~~~~~~~~
> >    include/linux/printk.h:464:60: note: expanded from macro 'printk'
> >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS=
__)
> >                                                        ~~~    ^~~~~~~~~=
~~
> >    include/linux/printk.h:436:19: note: expanded from macro 'printk_ind=
ex_wrap'
> >                    _p_func(_fmt, ##__VA_ARGS__);                       =
    \
> >                            ~~~~    ^~~~~~~~~~~
> >    1 warning generated.
> >
> >
> > vim +325 fs/notify/fanotify/fanotify_user.c
> >
> >    312
> >    313        static int process_access_response(struct fsnotify_group =
*group,
> >    314                                           struct fanotify_respon=
se *response_struct,
> >    315                                           const char __user *buf=
,
> >    316                                           size_t count)
> >    317        {
> >    318                struct fanotify_perm_event *event;
> >    319                int fd =3D response_struct->fd;
> >    320                u32 response =3D response_struct->response;
> >    321                struct fanotify_response_info_header info_hdr;
> >    322                char *info_buf =3D NULL;
> >    323
> >    324                pr_debug("%s: group=3D%p fd=3D%d response=3D%u bu=
f=3D%p size=3D%lu\n", __func__,
> >  > 325                         group, fd, response, info_buf, count);
> >    326                /*
> >    327                 * make sure the response is valid, if invalid we=
 do nothing and either
> >    328                 * userspace can send a valid response or we will=
 clean it up after the
> >    329                 * timeout
> >    330                 */
> >    331                if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
> >    332                        return -EINVAL;
> >    333                switch (response & FANOTIFY_RESPONSE_ACCESS) {
> >    334                case FAN_ALLOW:
> >    335                case FAN_DENY:
> >    336                        break;
> >    337                default:
> >    338                        return -EINVAL;
> >    339                }
> >    340                if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(gro=
up, FAN_ENABLE_AUDIT))
> >    341                        return -EINVAL;
> >    342                if (fd < 0)
> >    343                        return -EINVAL;
> >    344                if (response & FAN_INFO) {
> >    345                        size_t c =3D count;
> >    346                        const char __user *ib =3D buf;
> >    347
> >    348                        if (c <=3D 0)
> >    349                                return -EINVAL;
> >    350                        while (c >=3D sizeof(info_hdr)) {
> >    351                                if (copy_from_user(&info_hdr, ib,=
 sizeof(info_hdr)))
> >    352                                        return -EFAULT;
> >    353                                if (info_hdr.pad !=3D 0)
> >    354                                        return -EINVAL;
> >    355                                if (c < info_hdr.len)
> >    356                                        return -EINVAL;
> >    357                                switch (info_hdr.type) {
> >    358                                case FAN_RESPONSE_INFO_AUDIT_RULE=
:
> >    359                                        break;
> >    360                                case FAN_RESPONSE_INFO_NONE:
> >    361                                default:
> >    362                                        return -EINVAL;
> >    363                                }
> >    364                                c -=3D info_hdr.len;
> >    365                                ib +=3D info_hdr.len;
> >    366                        }
> >    367                        if (c !=3D 0)
> >    368                                return -EINVAL;
> >    369                        /* Simplistic check for now */
> >    370                        if (count !=3D sizeof(struct fanotify_res=
ponse_info_audit_rule))
> >    371                                return -EINVAL;
> >    372                        info_buf =3D kmalloc(sizeof(struct fanoti=
fy_response_info_audit_rule),
> >    373                                           GFP_KERNEL);
> >    374                        if (!info_buf)
> >    375                                return -ENOMEM;
> >    376                        if (copy_from_user(info_buf, buf, count))
> >    377                                return -EFAULT;
> >    378                }
> >    379                spin_lock(&group->notification_lock);
> >    380                list_for_each_entry(event, &group->fanotify_data.=
access_list,
> >    381                                    fae.fse.list) {
> >    382                        if (event->fd !=3D fd)
> >    383                                continue;
> >    384
> >    385                        list_del_init(&event->fae.fse.list);
> >    386                        /* finish_permission_event() eats info_bu=
f */
> >    387                        finish_permission_event(group, event, res=
ponse_struct,
> >    388                                                count, info_buf);
> >    389                        wake_up(&group->fanotify_data.access_wait=
q);
> >    390                        return 0;
> >    391                }
> >    392                spin_unlock(&group->notification_lock);
> >    393
> >    394                return -ENOENT;
> >    395        }
> >    396
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> >
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
>
>


--=20
Thanks,
~Nick Desaulniers
