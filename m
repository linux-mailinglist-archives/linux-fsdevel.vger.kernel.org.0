Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1632151EFDD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiEHTRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiEHScE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 14:32:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B962DF7;
        Sun,  8 May 2022 11:28:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d22so11937911plr.9;
        Sun, 08 May 2022 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L0vTBUu7cERNrSt/2j/cpvelXrPJBDUXqkluepqf8b8=;
        b=jSsthn14SJCrQ++glajXqdmZL710hNBoeiChvIIa2mF54enjFgsN60hFht2Ig41Y/F
         s15VvMWd/z9OCWjSezTGMmY2w1Xk90IIymsv2zGmFAHbB+0kjZr5M23Ex7pAUV8YLSXx
         i/QIgEi39FE6nPWsZwuVxbEmWf8HThYWGvVJyIlhUjMgbozOpZOm1P31r5iC73NzWcOn
         Q+NOAdGnq0tzlWX9SGruGL7rgOkCKccpNd2zGoJsqJvoaOH0rJYyw7zp9aNTNKGhoBX+
         HsQT2OVDnX5mnAKsyK1uGvOTvmD2vVaGz7fgfyCQ8ktGlH/gHfMLD0n6ekbJ5Y5YN8YF
         jv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0vTBUu7cERNrSt/2j/cpvelXrPJBDUXqkluepqf8b8=;
        b=MzrpBYrViDDEaJA6B03/PItHrkfao5EpWU+4yA+z+/ql5PARR4hvSj41qQq4gxHibG
         EySzDANWliYeJjarsl4p+SatmvKxsXhoJJqhzS5Rvs5xDgxFPGqZhmH9HnF36CeKNRBA
         Y2ezdv+p6i2+U7V5glbCgTSs7uRUgXXVOQASJGp/MRkfmR6f2XVGx5JuNDRJ7Eu76bGj
         M+gLm4D7GgbBoFosngE/uUtxwGkF7YVGfwgwC5DFB4OshIQqNMzXblIgV0941JlQaGa0
         08NkU3yVvz9anesvnf+qyR0UUKxwjhs0ZF98lTbKNEeoi4Eb2aO121vzMt+GHxqCGwfy
         Pz8A==
X-Gm-Message-State: AOAM530PFARqatliSGYIQp0w2M3txVSwfd5XqWsKt5VPEmVpBvmdGQka
        PDwwBqmHArXamfHP06KiSvA=
X-Google-Smtp-Source: ABdhPJz5nkrHBlEe+ZEiZjuwSpdX5J++4ul6PD3fhb/JnsqyltoFFFtmmBQ3dkbNfrlUPRbhl0WYJQ==
X-Received: by 2002:a17:90a:f3cb:b0:1d9:62d4:25db with SMTP id ha11-20020a17090af3cb00b001d962d425dbmr14412062pjb.222.1652034493427;
        Sun, 08 May 2022 11:28:13 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id c2-20020aa79522000000b0050dc7628164sm7038349pfp.62.2022.05.08.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 11:28:12 -0700 (PDT)
Date:   Sun, 8 May 2022 11:28:07 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, stable@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: sendfile handles O_NONBLOCK of out_fd
Message-ID: <YngLt9seLZBQ6Cer@gmail.com>
References: <20220415005015.525191-1-avagin@gmail.com>
 <CANaxB-wcf0Py9eCeA8YKcBSnwzW6pKAD5edCDUadebmo=JLYhA@mail.gmail.com>
 <20220507145224.a9b6555969d6e66586b6514c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220507145224.a9b6555969d6e66586b6514c@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 02:52:24PM -0700, Andrew Morton wrote:
> On Mon, 2 May 2022 00:01:46 -0700 Andrei Vagin <avagin@gmail.com> wrote:
> 
> > Andrew, could you take a look at this patch?
> > 
> > Here is a small reproducer for the problem:
> > 
> > #define _GNU_SOURCE /* See feature_test_macros(7) */
> > #include <fcntl.h>
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <errno.h>
> > #include <sys/stat.h>
> > #include <sys/types.h>
> > #include <sys/sendfile.h>
> > 
> > 
> > #define FILE_SIZE (1UL << 30)
> > int main(int argc, char **argv) {
> >         int p[2], fd;
> > 
> >         if (pipe2(p, O_NONBLOCK))
> >                 return 1;
> > 
> >         fd = open(argv[1], O_RDWR | O_TMPFILE, 0666);
> >         if (fd < 0)
> >                 return 1;
> >         ftruncate(fd, FILE_SIZE);
> > 
> >         if (sendfile(p[1], fd, 0, FILE_SIZE) == -1) {
> >                 fprintf(stderr, "FAIL\n");
> >         }
> >         if (sendfile(p[1], fd, 0, FILE_SIZE) != -1 || errno != EAGAIN) {
> >                 fprintf(stderr, "FAIL\n");
> >         }
> >         return 0;
> > }
> > 
> > It worked before b964bf53e540, it is stuck after b964bf53e540, and it
> > works again with this fix.
> 
> Thanks.  How did b964bf53e540 cause this?  do_splice_direct()
> accidentally does the right thing even when SPLICE_F_NONBLOCK was not
> passed?

do_splice_direct() calls pipe_write that handles O_NONBLOCK. Here is
a trace log from the reproducer:

 1)               |  __x64_sys_sendfile64() {
 1)               |    do_sendfile() {
 1)               |      __fdget()
 1)               |      rw_verify_area()
 1)               |      __fdget()
 1)               |      rw_verify_area()
 1)               |      do_splice_direct() {
 1)               |        rw_verify_area()
 1)               |        splice_direct_to_actor() {
 1)               |          do_splice_to() {
 1)               |            rw_verify_area()
 1)               |            generic_file_splice_read()
 1) + 74.153 us   |          }
 1)               |          direct_splice_actor() {
 1)               |            iter_file_splice_write() {
 1)               |              __kmalloc()
 1)   0.148 us    |              pipe_lock();
 1)   0.153 us    |              splice_from_pipe_next.part.0();
 1)   0.162 us    |              page_cache_pipe_buf_confirm();
... 16 times
 1)   0.159 us    |              page_cache_pipe_buf_confirm();
 1)               |              vfs_iter_write() {
 1)               |                do_iter_write() {
 1)               |                  rw_verify_area()
 1)               |                  do_iter_readv_writev() {
 1)               |                    pipe_write() {
 1)               |                      mutex_lock()
 1)   0.153 us    |                      mutex_unlock();
 1)   1.368 us    |                    }
 1)   1.686 us    |                  }
 1)   5.798 us    |                }
 1)   6.084 us    |              }
 1)   0.174 us    |              kfree();
 1)   0.152 us    |              pipe_unlock();
 1) + 14.461 us   |            }
 1) + 14.783 us   |          }
 1)   0.164 us    |          page_cache_pipe_buf_release();
... 16 times
 1)   0.161 us    |          page_cache_pipe_buf_release();
 1)               |          touch_atime()
 1) + 95.854 us   |        }
 1) + 99.784 us   |      }
 1) ! 107.393 us  |    }
 1) ! 107.699 us  |  }

> 
> I assume that Al will get to this.  Meanwhile I can toss it
> into linux-next to get some exposure and so it won't be lost.
> 
