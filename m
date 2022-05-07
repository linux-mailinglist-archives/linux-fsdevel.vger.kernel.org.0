Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9F51EA64
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 23:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350158AbiEGV4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 17:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiEGV4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 17:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E313CFD10;
        Sat,  7 May 2022 14:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8326F60F2D;
        Sat,  7 May 2022 21:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9956DC385A5;
        Sat,  7 May 2022 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651960345;
        bh=VUBEB/P2WIQw0SMyiFMZdKktomMMIezyj6B6YeN0fcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YTT1ypjOFayfH/VIwXhN9k5FX9ncnibe6OKtZMXDFP1r9CQouE87+i/BZV4MrH0F4
         6SEmVcA9WN2HY1vLSEzzSzyu3T+VibHmN8Zg+7ByrhgSImc5tubb4/uzRZYTZnT1Rx
         L4JZUGK9wkgdnBNfRSEBg1UC6K7JjKz1nbfUBsv4=
Date:   Sat, 7 May 2022 14:52:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, stable@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: sendfile handles O_NONBLOCK of out_fd
Message-Id: <20220507145224.a9b6555969d6e66586b6514c@linux-foundation.org>
In-Reply-To: <CANaxB-wcf0Py9eCeA8YKcBSnwzW6pKAD5edCDUadebmo=JLYhA@mail.gmail.com>
References: <20220415005015.525191-1-avagin@gmail.com>
        <CANaxB-wcf0Py9eCeA8YKcBSnwzW6pKAD5edCDUadebmo=JLYhA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 May 2022 00:01:46 -0700 Andrei Vagin <avagin@gmail.com> wrote:

> Andrew, could you take a look at this patch?
> 
> Here is a small reproducer for the problem:
> 
> #define _GNU_SOURCE /* See feature_test_macros(7) */
> #include <fcntl.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <errno.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/sendfile.h>
> 
> 
> #define FILE_SIZE (1UL << 30)
> int main(int argc, char **argv) {
>         int p[2], fd;
> 
>         if (pipe2(p, O_NONBLOCK))
>                 return 1;
> 
>         fd = open(argv[1], O_RDWR | O_TMPFILE, 0666);
>         if (fd < 0)
>                 return 1;
>         ftruncate(fd, FILE_SIZE);
> 
>         if (sendfile(p[1], fd, 0, FILE_SIZE) == -1) {
>                 fprintf(stderr, "FAIL\n");
>         }
>         if (sendfile(p[1], fd, 0, FILE_SIZE) != -1 || errno != EAGAIN) {
>                 fprintf(stderr, "FAIL\n");
>         }
>         return 0;
> }
> 
> It worked before b964bf53e540, it is stuck after b964bf53e540, and it
> works again with this fix.

Thanks.  How did b964bf53e540 cause this?  do_splice_direct()
accidentally does the right thing even when SPLICE_F_NONBLOCK was not
passed?

I assume that Al will get to this.  Meanwhile I can toss it
into linux-next to get some exposure and so it won't be lost.

