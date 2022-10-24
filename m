Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F91609824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJXCRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 22:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXCRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104870E5E
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666577835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9v3FWZ1u0qD8ZLDJpp9h3sV4g6hnZHOOtI7FbrsDezQ=;
        b=bDmAAopUELXzva19YS0IXSVXiPFQZD1E8L2Pf9pBW1FgFUFh789NjDJ7XMyGlbTjhHFR9s
        9ocoesqN4PDAlYmXUvEzuQR/kin+u8+3sRq4awsJfRs0DoyFiy0uEVB/Rk7AlnEhGgJWS/
        XcBkkQkoJUlMMzQMnsb+lk0XHwu3fM8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-DhslFbn4OlCElM7Va1pqkA-1; Sun, 23 Oct 2022 22:17:13 -0400
X-MC-Unique: DhslFbn4OlCElM7Va1pqkA-1
Received: by mail-pl1-f200.google.com with SMTP id u9-20020a17090341c900b0017f8514cf61so5527117ple.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 19:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v3FWZ1u0qD8ZLDJpp9h3sV4g6hnZHOOtI7FbrsDezQ=;
        b=lXSF3ylXZQIYtBXlZD6ePm47F6iyMZ8M8PAbq42KHezWB1/GJqujESW6/99jNM56mm
         HIe5rIsWBKWQiw7ClfEU0UN3GjLgIteb1+Zf2EVbyD6/uq+YWWsXbAeTcE2PPlHwt0fX
         19qRrskvTdi2yg0GfSV3G3QKUGZ97y4IlMKwaPLpwW2uhOpqNYsPbjki5afCcd93QePa
         V3s/KIIsJpjPSGPWCiCAbKuP0I1BXk7hGfvKipdvCmQiqpK7uHiNJdhMwsS9rhnfqwy4
         9wCLDEAa0tQ+psNet5fFKNlvNz3TSZ0Aba6lbj/mr7YEJ980/W22RQJLY0Dg9DixVMut
         0w1Q==
X-Gm-Message-State: ACrzQf2EIhyKJtC3Q1Nj8sLGTxaH+E18JN1B0LO51U/BEjWD0WmDypEg
        +fSos8DMxrZoa1HYzWagDgU7XO309SYEsfMa4jPmvonYHEudwTTyyN1WReEZecoze72Qj0JWrUC
        DVDt5blXpKqXJPUagBQehVRUiJg==
X-Received: by 2002:a17:90a:5781:b0:20a:9962:bb4a with SMTP id g1-20020a17090a578100b0020a9962bb4amr69741688pji.185.1666577831726;
        Sun, 23 Oct 2022 19:17:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4SfgJRkSkZHrTPYkX1LXMqdPEQ0jk6B3EgsYSpWxN8mmQY+v6NcttGHTuEqpwrNhHeNuXKMA==
X-Received: by 2002:a17:90a:5781:b0:20a:9962:bb4a with SMTP id g1-20020a17090a578100b0020a9962bb4amr69741666pji.185.1666577831355;
        Sun, 23 Oct 2022 19:17:11 -0700 (PDT)
Received: from [10.72.12.79] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p1-20020a62d001000000b0056bc742d21esm1199139pfg.176.2022.10.23.19.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 19:17:11 -0700 (PDT)
Subject: Re: [PATCH -next 3/5] ceph: fix possible null-ptr-deref when parsing
 param
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     idryomov@gmail.com, jlayton@kernel.org, 18801353760@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org
References: <aa3f35c1-1550-a322-956f-1837cb2389a9@redhat.com>
 <20221024020430.15795-1-yin31149@gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <91999bb6-3e59-60cc-32ff-504920735a0e@redhat.com>
Date:   Mon, 24 Oct 2022 10:17:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221024020430.15795-1-yin31149@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/10/2022 10:04, Hawkins Jiawei wrote:
> Hi Xiubo,
> On Mon, 24 Oct 2022 at 08:55, Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 24/10/2022 00:39, Hawkins Jiawei wrote:
>>> According to commit "vfs: parse: deal with zero length string value",
>>> kernel will set the param->string to null pointer in vfs_parse_fs_string()
>>> if fs string has zero length.
>>>
>>> Yet the problem is that, ceph_parse_mount_param() will dereferences the
>>> param->string, without checking whether it is a null pointer, which may
>>> trigger a null-ptr-deref bug.
>>>
>>> This patch solves it by adding sanity check on param->string
>>> in ceph_parse_mount_param().
>>>
>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>> ---
>>>    fs/ceph/super.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>> index 3fc48b43cab0..341e23fe29eb 100644
>>> --- a/fs/ceph/super.c
>>> +++ b/fs/ceph/super.c
>>> @@ -417,6 +417,9 @@ static int ceph_parse_mount_param(struct fs_context *fc,
>>>                param->string = NULL;
>>>                break;
>>>        case Opt_mds_namespace:
>>> +             if (!param->string)
>>> +                     return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
>>> +                                    param->string, param->key);
>>>                if (!namespace_equals(fsopt, param->string, strlen(param->string)))
>>>                        return invalfc(fc, "Mismatching mds_namespace");
>>>                kfree(fsopt->mds_namespace);
>> BTW, did you hit any crash issue when testing this ?
>>
>> $ ./bin/mount.ceph :/ /mnt/kcephfs -o mds_namespace=
>>
>> <5>[  375.535442] ceph: module verification failed: signature and/or
>> required key missing - tainting kernel
>> <6>[  375.698145] ceph: loaded (mds proto 32)
>> <3>[  375.801621] ceph: Bad value for 'mds_namespace'
>>
>>   From my test, the 'fsparam_string()' has already make sure it won't
>> trigger the null-ptr-deref bug.
> Did you test on linux-next tree?

No, I am using the ceph-client repo for ceph code developing.

>
> I just write a reproducer based on syzkaller's template(So please
> forgive me if it is too ugly to read)
>
> ===========================================================
> // https://syzkaller.appspot.com/bug?id=76bbdfd28722f0160325e4350b57e33aa95b0bbe
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>
> unsigned long long procid;
>
> static void sleep_ms(uint64_t ms)
> {
>    usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
>    struct timespec ts;
>    if (clock_gettime(CLOCK_MONOTONIC, &ts))
>      exit(1);
>    return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static bool write_file(const char* file, const char* what, ...)
> {
>    char buf[1024];
>    va_list args;
>    va_start(args, what);
>    vsnprintf(buf, sizeof(buf), what, args);
>    va_end(args);
>    buf[sizeof(buf) - 1] = 0;
>    int len = strlen(buf);
>    int fd = open(file, O_WRONLY | O_CLOEXEC);
>    if (fd == -1)
>      return false;
>    if (write(fd, buf, len) != len) {
>      int err = errno;
>      close(fd);
>      errno = err;
>      return false;
>    }
>    close(fd);
>    return true;
> }
>
> static void kill_and_wait(int pid, int* status)
> {
>    kill(-pid, SIGKILL);
>    kill(pid, SIGKILL);
>    int i;
>    for (i = 0; i < 100; i++) {
>      if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>        return;
>      usleep(1000);
>    }
>    DIR* dir = opendir("/sys/fs/fuse/connections");
>    if (dir) {
>      for (;;) {
>        struct dirent* ent = readdir(dir);
>        if (!ent)
>          break;
>        if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>          continue;
>        char abort[300];
>        snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                 ent->d_name);
>        int fd = open(abort, O_WRONLY);
>        if (fd == -1) {
>          continue;
>        }
>        if (write(fd, abort, 1) < 0) {
>        }
>        close(fd);
>      }
>      closedir(dir);
>    } else {
>    }
>    while (waitpid(-1, status, __WALL) != pid) {
>    }
> }
>
> static void setup_test()
> {
>    prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>    setpgrp();
>    write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
>    int iter;
>    for (iter = 0;; iter++) {
>      int pid = fork();
>      if (pid < 0)
>        exit(1);
>      if (pid == 0) {
>        setup_test();
>        execute_one();
>        exit(0);
>      }
>      int status = 0;
>      uint64_t start = current_time_ms();
>      for (;;) {
>        if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>          break;
>        sleep_ms(1);
>        if (current_time_ms() - start < 5 * 1000)
>          continue;
>        kill_and_wait(pid, &status);
>        break;
>      }
>    }
> }
>
> void execute_one(void)
> {
>    char opt[] = "mds_namespace=,\x00";
>    memcpy((void*)0x20000080, "./file0\000", 8);
>    syscall(__NR_mknod, 0x20000080ul, 0ul, 0x700ul + procid * 2);
>    memcpy((void*)0x20000040, "[d::]:/8:", 9);
>    memcpy((void*)0x200000c0, "./file0\000", 8);
>    memcpy((void*)0x20000140, "ceph\000", 5);
>    memcpy((void*)0x20000150, opt, sizeof(opt));
>    syscall(__NR_mount, 0x20000040ul, 0x200000c0ul, 0x20000140ul, 0ul, 0x20000150);
> }
> int main(void)
> {
>    syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
>    for (procid = 0; procid < 6; procid++) {
>      if (fork() == 0) {
>        loop();
>      }
>    }
>    sleep(1000000);
>    return 0;
> }
> ===========================================================
>
> And it triggers the null-ptr-deref bug described above,
> its log is shown as below:
> ===========================================================
> [   90.779695][ T6513] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [   90.782502][ T6513] RIP: 0010:strlen+0x1a/0x90
> [ ... ]
> [   90.782502][ T6513] Call Trace:
> [   90.782502][ T6513]  <TASK>
> [   90.782502][ T6513]  ceph_parse_mount_param+0x89a/0x21e0
> [   90.782502][ T6513]  ? __kasan_unpoison_range-0xf/0x10
> [   90.782502][ T6513]  ? kasan_addr_to_slab-0xf/0x90
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  ? ceph_parse_mount_param+0x0/0x21e0
> [   90.782502][ T6513]  ? audit_kill_trees+0x2b0/0x300
> [   90.782502][ T6513]  ? lock_release+0x0/0x760
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  ? security_fs_context_parse_param+0x99/0xd0
> [   90.782502][ T6513]  ? ceph_parse_mount_param+0x0/0x21e0
> [   90.782502][ T6513]  vfs_parse_fs_param+0x20f/0x3d0
> [   90.782502][ T6513]  vfs_parse_fs_string+0xe4/0x180
> [   90.782502][ T6513]  ? vfs_parse_fs_string+0x0/0x180
> [   90.782502][ T6513]  ? rcu_read_lock_sched_held+0x0/0xd0
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  ? kfree+0x129/0x1a0
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  generic_parse_monolithic+0x16f/0x1f0
> [   90.782502][ T6513]  ? generic_parse_monolithic+0x0/0x1f0
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  ? alloc_fs_context+0x5cb/0xa00
> [   90.782502][ T6513]  path_mount+0x11d3/0x1cb0
> [   90.782502][ T6513]  ? path_mount+0x0/0x1cb0
> [   90.782502][ T6513]  ? putname+0xfe/0x140
> [   90.782502][ T6513]  do_mount+0xf3/0x110
> [   90.782502][ T6513]  ? do_mount+0x0/0x110
> [   90.782502][ T6513]  ? _copy_from_user+0xf7/0x170
> [   90.782502][ T6513]  ? __sanitizer_cov_trace_pc+0x1a/0x40
> [   90.782502][ T6513]  __x64_sys_mount+0x18f/0x230
> [   90.782502][ T6513]  do_syscall_64+0x35/0xb0
> [   90.782502][ T6513]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ ... ]
> [   90.782502][ T6513]  </TASK>
> ===========================================================
>
> By the way, commit "vfs: parse: deal with zero length string value"
> is still in discussion as below, so maybe this patchset is not
> needed.
> https://lore.kernel.org/all/17a1fdc-14a0-cf3c-784f-baa939895aef@google.com/

Okay, It's said that breaking commit will be reverted. Let's wait for a 
while to see what will it be.

Thanks!

- Xiubo

>> But it will always make sense to fix it in ceph code with your patch.
>>
>> - Xiubo
>>
>>
>>

