Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925444E420C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiCVOnv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiCVOnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:43:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042233E09;
        Tue, 22 Mar 2022 07:41:46 -0700 (PDT)
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxE5Y-1oGgme2JAm-00xdQD; Tue, 22 Mar 2022 15:41:44 +0100
Received: by mail-wm1-f50.google.com with SMTP id r64so11292291wmr.4;
        Tue, 22 Mar 2022 07:41:44 -0700 (PDT)
X-Gm-Message-State: AOAM530BDjO7Ptc7KG3n2uMNgMLdtoACHLIVfFqpOrFENIjylRb7mIzk
        rz0ukRuhYOLDyNi+xdBXpOAJ+K2gLkSSVmIqZ3s=
X-Google-Smtp-Source: ABdhPJw00aHA9GFbzzznIWn5mHtAHfYTPmhqzO6UEPK2HL9vxQvPUMxGCmZQnRZD3CkDmdl5/Fe8OWNuPz92L/qaiek=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr4133952wmc.94.1647960104135; Tue, 22
 Mar 2022 07:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220318071130.163942-1-chenjiahao16@huawei.com>
 <CAK8P3a3==vLKZUOceuMh3X1U5_sN82Vpm8J_3P-H-+q3sKKMxg@mail.gmail.com> <88ff36b3-558b-9c3f-f21d-5ef05b3227c5@huawei.com>
In-Reply-To: <88ff36b3-558b-9c3f-f21d-5ef05b3227c5@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 15:41:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_iZihNmgRNz7Ntrp8sj0hB_Yrpu5iT++ivMjsUXH7+w@mail.gmail.com>
Message-ID: <CAK8P3a3_iZihNmgRNz7Ntrp8sj0hB_Yrpu5iT++ivMjsUXH7+w@mail.gmail.com>
Subject: Re: [PATCH -next] uaccess: fix __access_ok limit setup in compat mode
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stafford Horne <shorne@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:xhNDHgu7aAbv+8rDLCqGmegm5QwYM2Yemq5liH+S6AlDcX9vO8r
 leaQiEzw5kWftGHrGXtbRtqGp9NVWEhPsCC0cTLpcHzOZ/WIZrTQP9czq1maaENSXV33PdE
 lxRw3DRWuoPxdToxFqxwzB1CrR8ZqJ5LGbKqtWZbhSoL5X8I591TSSEIbg1uwAL6kPxMXwe
 ngmAijhLONTMbvIzXX5hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O4XSNy/4Jnk=:kstbtJLZznfpFcRZ6/O0lF
 f03ml5tZo3q0oMeA9a8jwE2dEQefNuHIvqLcXvWTz726WgpUGXzBdUQTmkki8LbOQA4PHkAtG
 OsHyG1amlxU4Vf40UOuAsvSwx1o5YqhXdmIsDIMeNYz1TR9/V/TvnJoWqdndk3/Jt805IAINk
 nRvfo9+t5zyH6r6U8rjunMIVK5qkxAgo2tpsLBKvysGMMhdyYQ3D7MwtECepigU9GDZ8MhbCD
 ln05zBDOKsJCyRvfzLdWob7RfCajtfXCYgxQGNyZUP4t/PaHqf6iHTpIjOSw3Plv45WTnfLxE
 fLGR3008WCwHvlOTsxGHLO1y+znz5PLvHFrWlw9pVyG09vrJ4qYcOg1jZH/g5jwtaQ3jBX2Wc
 T7SJe7BAoiUSF5S6y40BEahXhLhNiiN52n/9CfiBsLm3wbWCYohFESPDW1ne6i78E024rD+F7
 bbX/enNzJrUq3yO2CDaTO7gmwjJV074r/lPvXmU2JGHj9/Aa7Cntt+o1JyKD1Wl6SDqDeOhnV
 5KsIg439Jr+SngEVyQKkL9OZ831wgdoAgWwNup5MTz4439Yj4G2uF66Kzhh+1fATTah/je03e
 r7XDon8CJfeBC3sysM36Es6pag30jyumjzGm1cklvm5XnTmfb5bW9qYFRvwOb89Hx+wrB9EMl
 +ylyO7NVrbLUHfmBywUr7K8xmg2ffHzvuUNfQ527BeBHTfq+VrW4p+F81kxgmBa79cIc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 1:55 PM chenjiahao (C) <chenjiahao16@huawei.com> wrote:
> 在 2022/3/18 15:44, Arnd Bergmann 写道:
> >
> > This should not result in any user visible difference, in both cases
> > user process will see a -EFAULT return code from its system call.
> > Are you able to come up with a test case that shows an observable
> > difference in behavior?
>
> Actually, this patch do comes from a testcase failure, the code is
> pasted below:

Thank you for the test case!

> #define TMPFILE "__1234567890"
> #define BUF_SIZE    1024
>
> int main()
> {
>      char buf[BUF_SIZE] = {0};
>      int fd;
>      int ret;
>      int err;
>
>      fd = open(TMPFILE, O_CREAT | O_RDWR);
>      if(-1 == fd)
>      {
>          perror("open");
>          return 1;
>      }
>
>      ret = pread64(fd, buf, -1, 1);
>      if((-1 == ret) && (EFAULT == errno))
>      {
>          close(fd);
>          unlink(TMPFILE);
>          printf("PASS\n");
>          return 0;
>      }
>      err = errno;
>      perror("pread64");
>      printf("err = %d\n", err);
>      close(fd);
>      unlink(TMPFILE);
>      printf("FAIL\n");
>
>      return 1;
>   }
>
> The expected result is:
>
> PASS
>
> but the result of 32-bit testcase running in x86-64 kernel with compat
> mode is:
>
> pread64: Success
> err = 0
> FAIL
>
>
> In my explanation, pread64 is called with count '0xffffffffull' and
> offset '1', which might still not trigger
>
> page fault in 64-bit kernel.
>
>
> This patch uses TASK_SIZE as the addr_limit to performance a stricter
> address check and intercepts

I see. So while the kernel behavior was not meant to change from
my patch, it clearly did, which may cause problems. However, I'm
not sure if the changed behavior is actually wrong.

> the illegal pointer address from 32-bit userspace at a very early time.
> Which is roughly the same
>
> address limit check as __access_ok in arch/ia64.
>
>
> This is why this fixes my testcase failure above, or have I missed
> anything else?

My interpretation of what is going on here is that the pread64() call
still behaves according to the documented behavior, returning a small
number of bytes from the file, up to the first faulting address.

As the manual page for pread64() describes,

       On  success,  pread()  returns  the  number  of  bytes read
       (a return of zero indicates end of file) and pwrite() returns
       the number of bytes written.
       Note that it is not an error for a successful call to transfer
       fewer bytes than requested  (see  read(2)
       and write(2)).

The difference after my patch is that originally it returned
-EFAULT because part of the buffer is outside of the
addressable memory, but now it returns success because
part of the buffer is inside the addressable memory ;-)

I'm also not sure about which patch caused the change in
behavior, can you double-check that? The one you cited,
967747bbc084 ("uaccess: remove CONFIG_SET_FS"), does
not actually touch the x86 implementation, and commit
36903abedfe8 ("x86: remove __range_not_ok()") does touch
x86 but the limit was already TASK_SIZE_MAX since commit
47058bb54b57 ("x86: remove address space overrides using
set_fs()") back in linux-5.10.

        Arnd
