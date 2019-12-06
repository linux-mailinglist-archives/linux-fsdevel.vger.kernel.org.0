Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6432D11582F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFU21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 15:28:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37508 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFU21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:28:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so6218443lfc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D7AuzC7KPUuG+16rwarCAF7khGQqEuNHk2heBfehumM=;
        b=g8Wqm1UmJpiH9XsG7+mZgytZn6KAUz++mHOwaddVEx2NVcxiPW1xU5oMTujibpzGt1
         vA9Ahc4HGx1rvG4yaU+qIwSsmJrUqOaUYXaZB3Qxd428SSA5oPrNmN3i/iWippFABM3e
         SQvl5CWEZqP7WerH4SEuBDeTCnoSRwNi7YXJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D7AuzC7KPUuG+16rwarCAF7khGQqEuNHk2heBfehumM=;
        b=jxH3QJFMECT/wpNxw+z8ety7CxnYhclwPg56LSymntMqYd/uVjbJFVn1YXWUN791+B
         7znGNznlVN5j1RNsgVQ8OUdhEqSg9/apPy+FZzDvCf1L38mMdsbJSTEAVBjMIx6bJTC7
         b9bpEHUTFQKqDkhZ1gRN5FZ4d8E86XmGX6uJ7RWKxNAYncL6jlHy6CBhMhQ1F3gZiVGB
         v4CISQw2rUxPlL/6C0Xcg7tKZjOawNn7yAau+m0mo4DrqG0H9RvWXeOH1FXsbo6ZNtOQ
         ZIZ6BCq9KqQAHjajcFV1BRTAyy4IiAKTszzEbDycayLVVSLdiXheiSTlNBeZ+lw9u0PB
         DlqQ==
X-Gm-Message-State: APjAAAWvsBbjEhmFQcp6rewQ2PX6jH/r0IOUcUnpkTESuaBRxtDNRRqe
        uekAFcLDsdPcF1AegaHWp5dazmUp7aY=
X-Google-Smtp-Source: APXvYqzCFF8e7FOQawfiX1Cel9hstZVL9Oi3OiZoSyCmgsiow7qc3HVmESPWpdaDtTlCfCTbz9k6Tw==
X-Received: by 2002:a19:5508:: with SMTP id n8mr2562372lfe.157.1575664104483;
        Fri, 06 Dec 2019 12:28:24 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o69sm7116751lff.14.2019.12.06.12.28.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:28:23 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 21so9059920ljr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 12:28:22 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr9946818ljj.1.1575664102180;
 Fri, 06 Dec 2019 12:28:22 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
In-Reply-To: <20191206135604.GB2734@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 12:28:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
Message-ID: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 5:56 AM David Sterba <dsterba@suse.cz> wrote:
>
> For reference, I've retested current master (b0d4beaa5a4b7d), that
> incldes the 2 pipe fixes, the test still hangs.

I think I found it.

TOTALLY UNTESTED patch appended. It's whitespace-damaged and may be
completely wrong. And might not fix it.

The first hunk is purely syntactic sugar - use the normal head/tail
order. The second/third hunk is what I think fixes the problem:
iter_file_splice_write() had the same buggy "let's cache
head/tail/mask" pattern as pipe_write() had.

You can't cache them over  a 'pipe_wait()' that drops the pipe lock,
and there's one in splice_from_pipe_next().

        Linus

--- snip snip --

diff --git a/fs/splice.c b/fs/splice.c
index f2400ce7d528..fa1f3773c8cd 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -495,7 +495,7 @@ static int splice_from_pipe_feed(struct
pipe_inode_info *pipe, struct splice_des
        unsigned int mask = pipe->ring_size - 1;
        int ret;

-       while (!pipe_empty(tail, head)) {
+       while (!pipe_empty(head, tail)) {
                struct pipe_buffer *buf = &pipe->bufs[tail & mask];

                sd->len = buf->len;
@@ -711,9 +711,7 @@ iter_file_splice_write(struct pipe_inode_info
*pipe, struct file *out,
        splice_from_pipe_begin(&sd);
        while (sd.total_len) {
                struct iov_iter from;
-               unsigned int head = pipe->head;
-               unsigned int tail = pipe->tail;
-               unsigned int mask = pipe->ring_size - 1;
+               unsigned int head, tail, mask;
                size_t left;
                int n;

@@ -732,6 +730,10 @@ iter_file_splice_write(struct pipe_inode_info
*pipe, struct file *out,
                        }
                }

+               head = pipe->head;
+               tail = pipe->tail;
+               mask = pipe->ring_size - 1;
+
                /* build the vector */
                left = sd.total_len;
                for (n = 0; !pipe_empty(head, tail) && left && n <
nbufs; tail++, n++) {
