Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049A073DB72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFZJcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFZJcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A94A8F;
        Mon, 26 Jun 2023 02:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D3ED60DBB;
        Mon, 26 Jun 2023 09:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C5AC433C8;
        Mon, 26 Jun 2023 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687771940;
        bh=KJMesHLQZFCa7LJI2v2t21gz7AC5ng51lYh7GjEpzq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8P/sxe55KSWowTHibXollcoZjKqgBcyRP0QK+3exdpYFIfkBuSLvWHiXsFUG06Uq
         7Jst0SQvt6I9zHDA/JRENEDaXJRTDlfZpJiAEK1NJHvJEgeWZq6Mx5XW6Ri91mpMKg
         GsiFiOIAEYNf81GSJqVktSTxfcEapTO490E995PFumrjrJIIeHqUkTEa/Pg9SlkO6v
         9sj6uRbsKMqVJdr5qORKDTVEjlXZbRMFczGZbR63GPKMSWnBcHI7JYI4tcHbs0xRoU
         f+5X/LHvvzmxdH/GgkIf4JrSYDGt5ieyabWLF/gDvJntQ8Qna22vQzibNhETaqVj6R
         p76gS5ZgKItPA==
Date:   Mon, 26 Jun 2023 11:32:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Pending splice(file -> FIFO) always blocks read(FIFO),
 regardless of O_NONBLOCK on read side?
Message-ID: <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:12:09AM +0200, Ahelenia Ziemiańska wrote:
> Hi! (starting with get_maintainers.pl fs/splice.c,
>      idk if that's right though)
> 
> Per fs/splice.c:
>  * The traditional unix read/write is extended with a "splice()" operation
>  * that transfers data buffers to or from a pipe buffer.
> so I expect splice() to work just about the same as read()/write()
> (and, to a large extent, it does so).
> 
> Thus, a refresher on pipe read() semantics
> (quoting Issue 8 Draft 3; Linux when writing with write()):
> 60746  When attempting to read from an empty pipe or FIFO:
> 60747  • If no process has the pipe open for writing, read( ) shall return 0 to indicate end-of-file.
> 60748  • If some process has the pipe open for writing and O_NONBLOCK is set, read( ) shall return
> 60749    −1 and set errno to [EAGAIN].
> 60750  • If some process has the pipe open for writing and O_NONBLOCK is clear, read( ) shall
> 60751    block the calling thread until some data is written or the pipe is closed by all processes that
> 60752    had the pipe open for writing.
> 
> However, I've observed that this is not the case when splicing from
> something that sleeps on read to a pipe, and that in that case all
> readers block, /including/ ones that are reading from fds with
> O_NONBLOCK set!
> 
> As an example, consider these two programs:
> -- >8 --
> // wr.c
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <stdio.h>
> int main() {
>   while (splice(0, 0, 1, 0, 128 * 1024 * 1024, 0) > 0)
>     ;
>   fprintf(stderr, "wr: %m\n");
> }
> -- >8 --
> 
> -- >8 --
> // rd.c
> #define _GNU_SOURCE
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <unistd.h>
> int main() {
>   fcntl(0, F_SETFL, fcntl(0, F_GETFL) | O_NONBLOCK);
> 
>   char buf[64 * 1024] = {};
>   for (ssize_t rd;;) {
> #if 1
>     while ((rd = read(0, buf, sizeof(buf))) == -1 && errno == EINTR)
>       ;
> #else
>     while ((rd = splice(0, 0, 1, 0, 128 * 1024 * 1024, 0)) == -1 &&
>            errno == EINTR)
>       ;
> #endif
>     fprintf(stderr, "rd=%zd: %m\n", rd);
>     write(1, buf, rd);
> 
>     errno = 0;
>     sleep(1);
>   }
> }
> -- >8 --
> 
> Thus:
> -- >8 --
> a$ make rd wr
> a$ mkfifo fifo
> a$ ./rd < fifo                           b$ echo qwe > fifo
> rd=4: Success
> qwe
> rd=0: Success
> rd=0: Success                            b$ sleep 2 > fifo
> rd=-1: Resource temporarily unavailable
> rd=-1: Resource temporarily unavailable
> rd=0: Success
> rd=0: Success                            
> rd=-1: Resource temporarily unavailable  b$ /bin/cat > fifo
> rd=-1: Resource temporarily unavailable
> rd=4: Success                            abc
> abc
> rd=-1: Resource temporarily unavailable
> rd=4: Success                            def
> def
> rd=0: Success                            ^D
> rd=0: Success
> rd=0: Success                            b$ ./wr > fifo
> -- >8 --
> and nothing. Until you actually type a line (or a few) into teletype b
> so that the splice completes, at which point so does the read.
> 
> An even simpler case is 
> -- >8 --
> $ ./wr | ./rd
> abc
> def
> rd=8: Success
> abc
> def
> ghi
> jkl
> rd=8: Success
> ghi
> jkl
> ^D
> wr: Success
> rd=-1: Resource temporarily unavailable
> rd=0: Success
> rd=0: Success
> -- >8 --
> 
> splice flags don't do anything.
> Tested on bookworm (6.1.27-1) and Linus' HEAD (v6.4-rc7-234-g547cc9be86f4).
> 
> You could say this is a "denial of service", since this is a valid
> way of following pipes (and, sans SIGIO, the only portable one),

splice() may block for any of the two file descriptors if they don't
have O_NONBLOCK set even if SPLICE_F_NONBLOCK is raised.

SPLICE_F_NONBLOCK in splice_file_to_pipe() is only relevant if the pipe
is full. If the pipe isn't full then the write is attempted. That of
course involves reading the data to splice from the source file. If the
source file isn't O_NONBLOCK that read may block holding pipe_lock().

If you raise O_NONBLOCK on the source fd in wr.c then your problems go
away. This is pretty long-standing behavior. Splice would have to be
refactored to not rely on pipe_lock(). That's likely major work with a
good portion of regressions if the past is any indication.

If you need that ability to fully async read from a pipe with splice
rn then io_uring will at least allow you to punt that read into an async
worker thread afaict.
