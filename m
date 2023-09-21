Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7C7A9EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjIUULm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIUUL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE455994B
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:20:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso1102197b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316818; x=1695921618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFaHfoaxn08xsAqYV/UBPB0BsJ0aDfd3cBl6EMbcNgw=;
        b=KBkt+KycjezgD+xAtZLmmkvsh7i/fs3sHnE5HZ+uPwSqUaFHlY5DX01mgaxqpaZ19m
         EEbeq2ShrN3kNfij2CG7tRRYCVIArmLd9OtZs4K9Rx4nrGQlMAnkw9HpV8BcITqGlknZ
         UUyVnkTR44ErZ37PU6z/CTfItbTnUoatvYT4cG3J3QgYtKIBa/1MizS9Wcil90XGkJeo
         K4prAZ31n3IPmbn6NEp0Xp/7kSDdUjNeFBuPKk8dxWh7fzDH618a+233rsPEXH5j5uXT
         KPRnyhc6GPQTHVplMktKgn0rPGq1+8yD1DHow51ywU6dFU5cKS9VtgT5xMkV9aZAwVwm
         F24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316818; x=1695921618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFaHfoaxn08xsAqYV/UBPB0BsJ0aDfd3cBl6EMbcNgw=;
        b=TtuVofnqpvCC4tWYik3pCp0H40KUUn+n9PAFbq3E2YABu+hq6+o+ehMuiwf4zAXcGx
         097LlWHRcLFOX+gDQRWR4HUrhewP/xmOzoomSHH3Ta9tuGeD6JIFLTo0snnIwm6qJyfM
         M78ktJ6QFdqymJ5LHjeqI61UZcjbUHUSvdoyY132LIJ38hjV8fNG7oMjbmB4mBKiTzOq
         Wa2WqJu1Yw8MhBhXj9YMAeG7uE/Tqpz/ztmCfSkSMbxqlWECncsykjNC+wWKFT9WMm99
         rPZVmZB9j0jdTByjowBsZwdWju9nSb/8jjCjQHTj2x0R16Y9DQDxyj9KPHbsXS/XgWLK
         nVqg==
X-Gm-Message-State: AOJu0YwpmDJ5mMe6V73A2bfpJlVGCgdJsZIiPk9HYQge5aUw27YJ7HAR
        cmaPau06Y1x+d/9woLUYZ3X8TSUZbV21FsbC1eJSXR764AA=
X-Google-Smtp-Source: AGHT+IEX0oUA/m6qcydkc/MWRxmpvID/DRX9SY5OT+po1vq9MZCQuVXYDV3BHR9AxQnZho/TDPq2BuQ2cxuIIY5YALM=
X-Received: by 2002:a67:e8da:0:b0:452:988c:f339 with SMTP id
 y26-20020a67e8da000000b00452988cf339mr5582120vsn.5.1695307461687; Thu, 21 Sep
 2023 07:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com> <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com> <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
In-Reply-To: <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 17:44:10 +0300
Message-ID: <CAOQ4uxj7-=pU_WR8PbV4QUK=cepZnmd_1eCqRcwthJNkkzA5VA@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        ltp@lists.linux.it, mszeredi@redhat.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 4:01=E2=80=AFPM Reuben Hawkins <reubenhwk@gmail.com=
> wrote:
>
>
> On Tue, Sep 19, 2023 at 3:43=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
>>
>> On Tue, Sep 19, 2023 at 5:47=E2=80=AFAM kernel test robot <oliver.sang@i=
ntel.com> wrote:
>> >
>> >
>> >
>> > Hello,
>> >
>> > kernel test robot noticed "ltp.readahead01.fail" on:
>> >
>> > commit: f49a20c992d7fed16e04c4cfa40e9f28f18f81f7 ("[PATCH] vfs: fix re=
adahead(2) on block devices")
>> > url: https://github.com/intel-lab-lkp/linux/commits/Reuben-Hawkins/vfs=
-fix-readahead-2-on-block-devices/20230909-124349
>> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git =
32bf43e4efdb87e0f7e90ba3883e07b8522322ad
>> > patch link: https://lore.kernel.org/all/20230909043806.3539-1-reubenhw=
k@gmail.com/
>> > patch subject: [PATCH] vfs: fix readahead(2) on block devices
>> >
>> > in testcase: ltp
>> > version: ltp-x86_64-14c1f76-1_20230715
>> > with following parameters:
>> >
>> >         disk: 1HDD
>> >         fs: ext4
>> >         test: syscalls-00/readahead01
>> >
>> >
>> >
>> > compiler: gcc-12
>> > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30=
GHz (Ivy Bridge) with 8G memory
>> >
>> > (please refer to attached dmesg/kmsg for entire log/backtrace)
>> >
>> >
>> >
>> >
>> > If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <oliver.sang@intel.com>
>> > | Closes: https://lore.kernel.org/oe-lkp/202309191018.68ec87d7-oliver.=
sang@intel.com
>> >
>> >
>> >
>> > COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 3917     -n 3=
917 -p -f /fs/sdb2/tmpdir/ltp-R8Bqhtsv5t/alltests -l /lkp/benchmarks/ltp/re=
sults/LTP_RUN_ON-2023_09_13-20h_17m_53s.log  -C /lkp/benchmarks/ltp/output/=
LTP_RUN_ON-2023_09_13-20h_17m_53s.failed -T /lkp/benchmarks/ltp/output/LTP_=
RUN_ON-2023_09_13-20h_17m_53s.tconf
>> > LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2023_09_13-20h_17m_53=
s.log
>> > FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-=
20h_17m_53s.failed
>> > TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2023_09_13-2=
0h_17m_53s.tconf
>> > Running tests.......
>> > <<<test_start>>>
>> > tag=3Dreadahead01 stime=3D1694636274
>> > cmdline=3D"readahead01"
>> > contacts=3D""
>> > analysis=3Dexit
>> > <<<test_output>>>
>> > tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
>> > readahead01.c:36: TINFO: test_bad_fd -1
>> > readahead01.c:37: TPASS: readahead(-1, 0, getpagesize()) : EBADF (9)
>> > readahead01.c:39: TINFO: test_bad_fd O_WRONLY
>> > readahead01.c:45: TPASS: readahead(fd, 0, getpagesize()) : EBADF (9)
>> > readahead01.c:54: TINFO: test_invalid_fd pipe
>> > readahead01.c:56: TPASS: readahead(fd[0], 0, getpagesize()) : EINVAL (=
22)
>> > readahead01.c:60: TINFO: test_invalid_fd socket
>> > readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
>> >
>>
>> Reuben,
>>
>> This report is on an old version of your patch.
>> However:
>> 1. LTP test readahead01 will need to be fixed to accept also ESPIPE
>> 2. I am surprised that with the old patch readahead on socket did not
>>     fail. Does socket have aops?
>>
>> Please try to run LTP test readahead01 on the patch that Christian queue=
d
>> and see how it behaves and if anything needs to be fixed wrt sockets.
>>
>> Thanks,
>> Amir.
>
>
> ack.  Will try to test.  My Ubuntu 22.04 system wasn't able to find packa=
ges called
> for by the test case, so it'll take me a little while to figure out how t=
o get the
> test case working...

Heh! you can write a small C program instead, you don't even need to
build the LTP test.

It is clear what the failed test is doing:

static void test_invalid_fd(void)
{
        int fd[2];

        tst_res(TINFO, "%s pipe", __func__);
        SAFE_PIPE(fd);
        TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
        SAFE_CLOSE(fd[0]);
        SAFE_CLOSE(fd[1]);

        tst_res(TINFO, "%s socket", __func__);
        fd[0] =3D SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
        TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
        SAFE_CLOSE(fd[0]);
}

The report claims that readahead on socket succeeds
and this is surprising.

Thanks,
Amir.
