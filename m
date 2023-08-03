Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C128B76E503
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHCJxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjHCJxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:53:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4130F9;
        Thu,  3 Aug 2023 02:53:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so11643851fa.1;
        Thu, 03 Aug 2023 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691056396; x=1691661196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loe5Z5wmjdf0wNrIcqfUxFPcqZQuT7kOhWJD+sA8euo=;
        b=fKou4jDKOOvFN3vYjDfoaFqLJbZ0YqS1SDpgTZS414IOrrJrkKlv8pvVeBhRdKy2Dx
         P6nkrcX32/v9QFbM630+c51OC4uxCBZte1n7/LDLCOrbXOOXB5DzMHOQ0uFRpsaOS9gU
         Xic4zh6/2BiBjLlahZmvMdbwGYEDDfU9L8BwqUgTC8pYfLlAClkKNfV3wbMGAMuw2XaK
         1zjIKgIKgviwvnyZBOu+KOmUMdA6Xkt3GfTEmaYUh9Dp5ILUiEaC1KjT4xdfNi8vg6mQ
         jSbEiB/TAdblta0XSLPRV/x+iLvtuVYo049MC0uwFZT8knI2YXUtPTiVlxuehENwXAAq
         +jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691056396; x=1691661196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loe5Z5wmjdf0wNrIcqfUxFPcqZQuT7kOhWJD+sA8euo=;
        b=WbhFH4X7e+Mg7IZFBadFOyajETS3bL1Uv8/tCtS7wDrQwFbAE3PtdgUnwLh2LL4zgs
         eKDg716jzKWSbhj3Pc3SHEooS4hY63j5jnXSbGBQwvb6UEnRP+2gXwB1w60EF4cp3HHu
         OTP3rqAgtYcB1TobgF66D0SgKzJWsuuKasgWFg/cnhoTxnEOSrJSWW02pxueW/dEvnNe
         OOA4eiSaW/2exQSw8A1vxL+fAgZOCmqGEQiWPoFWdIdcR/SnEz+xC0vQNGBbKlSOxVrs
         6s2dL1jPuyZFAaJt1anOQSUF6rhk6e/qRYfVy8XyzY9jKbwrxzvCZae5yOV+b9lzDEYn
         ljOw==
X-Gm-Message-State: ABy/qLYBLbNAxjQT/92DIzFKMgRQduHQbfEFZmIZMbpc0C/GCnlrJKvY
        7HFE17u96X3go6RkQ0gPnio=
X-Google-Smtp-Source: APBJJlEke8U/BvJUAJaTYGNPgvpmqoLbyrYV8jWZ2hiUjfQHpEM0gXHYe6TFpOJqHU5xCRqURbJtRw==
X-Received: by 2002:a2e:8e97:0:b0:2b9:eaa7:c23f with SMTP id z23-20020a2e8e97000000b002b9eaa7c23fmr6748588ljk.49.1691056395491;
        Thu, 03 Aug 2023 02:53:15 -0700 (PDT)
Received: from f (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003143aa0ca8asm21303042wro.13.2023.08.03.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:53:14 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:53:11 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230803095311.ijpvhx3fyrbkasul@f>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner>
 <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:59:15AM -0700, Linus Torvalds wrote:
> I really hate making the traditional unix single-threaded file
> descriptor case take that lock.
> 
> Maybe it doesn't matter. Obviously it can't have contention, and your
> patch in that sense is pretty benign.
> 
> But locking is just fundamentally expensive in the first place, and it
> annoys me that I never realized that pidfd_getfd() did that thing that
> I knew was broken for /proc.
> 

So I got curious what the impact is and checked on quite a modern CPU
(Sapphire Rapid), so nobody can claim it's some old yeller and atomics
are nowhere near as expensive on modern uarchs.

I used read1_processes from will-it-scale -- it is doing 4KB reads at a
time over a 1MB file and dodges refing the file, but it does not dodge
the lock with the patch at hand.

In short, I got a drop of about 5% (~5778843 -> ~5500871 ops/s).

The kernel was patched with a toggle to force or elide the proposed
mandatory locking, like so:
@@ -1042,8 +1044,10 @@ unsigned long __fdget_pos(unsigned int fd)
        struct file *file = (struct file *)(v & ~3);

        if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
-               v |= FDPUT_POS_UNLOCK;
-               mutex_lock(&file->f_pos_lock);
+               if (file_count(file) > 1 || fdget_pos_mutex) {
+                       v |= FDPUT_POS_UNLOCK;
+                       mutex_lock(&file->f_pos_lock);
+               }
        }
        return v;
 }

I got rather unstable single-threaded perf, going up and down several %
between runs, I don't know yet what's that about. But toggling back and
forth while the bench was running consistently gave aforementioned ~5%
difference.

perf top claims:
[snip]
  32.64%  [kernel]                  [k] copyout
  10.83%  [kernel]                  [k] entry_SYSCALL_64
   6.69%  libc.so.6                 [.] read
   6.16%  [kernel]                  [k] filemap_get_read_batch
   5.62%  [kernel]                  [k] filemap_read
   3.39%  [kernel]                  [k] __fget_light
   2.92%  [kernel]                  [k] mutex_lock	<-- oh
   2.70%  [kernel]                  [k] mutex_unlock	<-- no
   2.33%  [kernel]                  [k] vfs_read
   2.18%  [kernel]                  [k] _copy_to_iter
   1.93%  [kernel]                  [k] atime_needs_update
   1.74%  [kernel]                  [k] __fsnotify_parent
   1.29%  read1_processes           [.] testcase
[/snip]

[note running perf along with the bench changes throughput to some
extent]

So yes, atomics remain expensive on x86-64 even on a very moden uarch
and their impact is measurable in a syscall like read.

Consequently eliding this mutex trip would be most welcome.

Happy to rant,
