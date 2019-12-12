Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25211D934
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfLLWS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:18:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43526 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbfLLWSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:18:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so380074ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 14:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibmYe5dmY9qFVLAgJoCojAZp2sCL8vXGU5XsSLw7St8=;
        b=dSlXNntYZVPGXn3lcC2vbzXF6WipSUsta1btx41YmoTh6VEKRpX2b7fs4TxKEw1Y2K
         UUZW0j/AAeXCmzGIAkJ4aunSCoZhgKx4W43dwuoHYpIAgug4033pSgKiZUT1ThtmS8ic
         OMRV4vbDWMBE++REQi15KrlEQuhlW3+R9WzL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibmYe5dmY9qFVLAgJoCojAZp2sCL8vXGU5XsSLw7St8=;
        b=Mh4ZX81blc77tldqkWMZ7DzBFkl+/3tG/HT7EEQ5fC4PwA0HBVfjJ7Yh94CtDjUEFl
         Q2JHuGMhz3pbNUOjq7EriKAuAWSIE/AeC1qVB/P6PgTELS+zYtnJgp3hjnuRQSbUOJBe
         LSq6sV7qq28ntsqn49lsjsrg8wYVlAlwpooKTnhpdoJwa8ZcQphzaBGY/UJ40PBk567g
         qrYF61jkYoFtgr5wjegucTG9NHhLmQcwJa27rHRXTnSjwY/UdIsVZ0F7VLfqyCKk20fg
         m2qRXuWeBuxWv5QkLaGcoP6b9fItq5ion3ydYJU+G6ebM/C54nKsximeIBxORbWcv4H8
         Eusg==
X-Gm-Message-State: APjAAAUcgOKY6EPM3+/oErAmwabNvppn3OpcKIR/Un93FIhIylmuEQUJ
        SLW8izSnZuM6NERXbGic0J4XwnerwLA=
X-Google-Smtp-Source: APXvYqxqUbXxKPHjrSH54BsWLbQFo9e+nxP1G+5BNUxrYRIPyeyWASAL59T+rjBObsBZlxObm/pkRg==
X-Received: by 2002:a2e:84d0:: with SMTP id q16mr7305751ljh.138.1576189103567;
        Thu, 12 Dec 2019 14:18:23 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l7sm3501917lfc.80.2019.12.12.14.18.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 14:18:22 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id v201so430925lfa.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 14:18:22 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr6996151lfm.29.1576189102141;
 Thu, 12 Dec 2019 14:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <63049728.ylUViGSH3C@merkaba>
 <7bf74660-874e-6fd7-7a41-f908ccab694e@kernel.dk>
In-Reply-To: <7bf74660-874e-6fd7-7a41-f908ccab694e@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 14:18:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAdtXUzqFNfZKm+AEh9Oxd5ZvNx_sZZi-RXSFhtf5V+Q@mail.gmail.com>
Message-ID: <CAHk-=wgAdtXUzqFNfZKm+AEh9Oxd5ZvNx_sZZi-RXSFhtf5V+Q@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 7:16 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I don't know the nocache tool, but I'm guessing it just does the writes
> (or reads) and then uses FADV_DONTNEED to drop behind those pages?
> That's fine for slower use cases, it won't work very well for fast IO.
> The write side currently works pretty much like that internally, whereas
> the read side doesn't use the page cache at all.

Well, I think that if we have this RWF/IOC_UNCACHED flag, maybe we
should make FADV_NOREUSE file descriptors just use it even for regular
read/write..

Right now FADV_NOREUSE is a no-op for the kernel, I think, because we
historically didn't have the facility.

But FADV_DONTNEED is different. That's for dropping pages after use
(ie invalidate_mapping_pages())

               Linus
