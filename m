Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606B57AE51D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 07:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjIZFey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 01:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjIZFew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:34:52 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F6D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 22:34:46 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4524dc540c7so3285131137.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695706485; x=1696311285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSkbghx5rrzjOMhhAlkPeMs9G2sVzf6qQF2DH4QfBao=;
        b=LhLmDY5wNnj6RvPZ5/Maz3ddOTY25YWcBvcxLUeA6xXCkmph2KHeQpbQLK1KzzZQJz
         sFYrYEzpvqgHf6OQ9ifEbhyrfX5rvLWuhU4Uhd0aGcVydLAfsuju92zOyB6d7XRxkOr5
         MAVG0Czz4Xkp56pUeqnd6mGIxAuqM7LZjBnMUQ8iZUx6Wy7xqTSi/QxF0LBxfKJmJ9FT
         bb3qw/sHKQ8E0/vosFGq086ME5iDrdbFCzFazJh8IAngSo5ZU+TIWNE7p8RB9YYElFWW
         lQdbHdikrYTwIAuBta2E2S3tSE3nUFXEwp/R4K+9xh/9TJnT/mWuJKe1HSoZbDXmKrPJ
         CpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695706485; x=1696311285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSkbghx5rrzjOMhhAlkPeMs9G2sVzf6qQF2DH4QfBao=;
        b=AxBWyxtZHBDmPGlWatbMrphySLwkfstYIVtwplPUC7hcuhtdoxHi1tctDVCXBr3xWD
         KKc7WdkTE/SD8JloqE9Jyl9wm+tPzzMHRHq4DYQVT5YlfLLvHZ3wAwybCqE5kMyozHEp
         jGXTBht1sj8DT2CMKBO0aSiu5uIaabzLxP6qj7z6KBOPobtmRddO5VUmmj+xpCG3WPne
         8fqkHDUXaS02e4wBgvRGTWJyx1z5xlfay7iYKq0hkOP0bQvEBRTNdQQboFuslll9Sc+K
         a8GIAc7CiUs8aO363QFeaRjGaJ5z16ujXDOJwDW+qDtOkumlBHBPDOL1fFeBsaub2Xtv
         iQoA==
X-Gm-Message-State: AOJu0Yxf/Jw6cjaV8abFJJVYulrAoUNVep2F3klSm61zPtLjdE1TmKXD
        ishcuOB6mUUNYrXOnLxbXOU9wySV1yq514ngCBc=
X-Google-Smtp-Source: AGHT+IHTDW6g2Tc/NjDzsxfrnkbQgYGREbZGtPAwsFltUq/iWFHSo9kGF9e0kVp3kKTZXnUIgmPl3AIMzTNYCOHJpPo=
X-Received: by 2002:a67:fa10:0:b0:452:6366:b0ed with SMTP id
 i16-20020a67fa10000000b004526366b0edmr6080464vsq.13.1695706485364; Mon, 25
 Sep 2023 22:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZQ1Z_JHMPE3hrzv5@yuki> <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org> <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org> <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRI6MsKeEgDnsyTo@xsang-OptiPlex-9020>
In-Reply-To: <ZRI6MsKeEgDnsyTo@xsang-OptiPlex-9020>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Sep 2023 08:34:34 +0300
Message-ID: <CAOQ4uxgjnMZQOwOzzi6XH4eFn+UoHQ3cq5CYGjqbHOE0BZRG8g@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Reuben Hawkins <reubenhwk@gmail.com>, brauner@kernel.org,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 4:56=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi Amir,
>
> On Sun, Sep 24, 2023 at 06:32:30PM +0300, Amir Goldstein wrote:
> > On Sun, Sep 24, 2023 at 5:27=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Sun, Sep 24, 2023 at 02:47:42PM +0300, Amir Goldstein wrote:
> > > > Since you joined the discussion, you have the opportunity to agree =
or
> > > > disagree with our decision to change readahead() to ESPIPE.
> > > > Judging  by your citing of lseek and posix_fadvise standard,
> > > > I assume that you will be on board?
> > >
> > > I'm fine with returning ESPIPE (it's like ENOTTY in a sense).  but
> > > that's not what kbuild reported:
> >
> > kbuild report is from v1 patch that was posted to the list
> > this is not the patch (v2) that is applied to vfs.misc
> > and has been in linux-next for a few days.
> >
> > Oliver,
> >
> > Can you say the failure (on socket) is reproduced on
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.misc?
> >
> > I would expect the pipe test to fail for getting ESPIPE
> > but according to Reuben the socket test does not fail.
>
> I tested on this commit:
> 15d4000b93539 (brauner-vfs/vfs.misc) vfs: fix readahead(2) on block devic=
es
>
> below is the test output:
>
> <<<test_output>>>
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> readahead01.c:36: TINFO: test_bad_fd -1
> readahead01.c:37: TPASS: readahead(-1, 0, getpagesize()) : EBADF (9)
> readahead01.c:39: TINFO: test_bad_fd O_WRONLY
> readahead01.c:45: TPASS: readahead(fd, 0, getpagesize()) : EBADF (9)
> readahead01.c:54: TINFO: test_invalid_fd pipe
> readahead01.c:56: TFAIL: readahead(fd[0], 0, getpagesize()) expected EINV=
AL: ESPIPE (29)
> readahead01.c:60: TINFO: test_invalid_fd socket
> readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
>
> Summary:
> passed   2
> failed   2
> broken   0
> skipped  0
> warnings 0
>
>

Thank you!
We had some confusion about patch of reported bug vs. current patch,
but these results are matching the other reports wrt current patch.


> BTW, I noticed the branch updated, now:
> e9168b6800ecd (brauner-vfs/vfs.misc) vfs: fix readahead(2) on block devic=
es
>
> though the patch-id are same. do you want us to test it again?
>

It's the same patch. no need to re-test.

Thanks,
Amir.
