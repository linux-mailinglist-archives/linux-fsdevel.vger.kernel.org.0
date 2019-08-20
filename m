Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1113596DF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 01:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfHTXz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 19:55:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44270 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfHTXz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:55:56 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so908990iop.11;
        Tue, 20 Aug 2019 16:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VN45UlY/SIJMvVnIZBAGdkV8k84Qdp5IWpvTMUhkzY=;
        b=DQs9BH3MbWD824XQ9LknEVh4mBDWxQgOXPr3k3XaYm/i+UznQX9+zpqyV1e0ujAhLX
         yIGLbYK7wsSemDexIqkG+yczIxazaXV0qHsz2dOArvnfonGoeTivGguUskjEPVVBGTCY
         ep3jM/+8iMqf7pcnNokfpxmxQw1TxsHWDnwmk/ERlx9FqwcLhi1zo9Y6CvwL1RLr3mmN
         8NFHzlSynlP203ULWA8V6PFzoiVo3rDxWy1kTCaImo6zxZIYsWRQTZuxBPbNneo5L043
         K87d3ryu3AhfZKP+gAOc/cHW1Ol7f3ESaA3xa43c6JM9Ftj9g+xUagXx/evITyjXP0JY
         1nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VN45UlY/SIJMvVnIZBAGdkV8k84Qdp5IWpvTMUhkzY=;
        b=uC1wAKrnGsxu77HjCXI3BPbxWo8ovcgMssR1LzOk6P8YnCARDw7TVH+f8JTOeq10BW
         o7PXClihVYcHZyYjj+bx7C4VdvsR0MhQkiUpiGbkBOyMLGQjBGwPNG0HAfufVI8OkBu7
         6nSro0x/o9Sdkx9dSud7wGxxmfiwx3aaLnhNmpSfLlDtPdhNu7d89SQXmQbhacK1vwvl
         uIoOxWD8tZBv4CCRrUDXI+ccdC/sfb72wmWEBOE+vs3ULqwTd+T5kI7aQYoQNwT0uxph
         eakLAYoJVxq51ocTWKMLHcfr6r9wc3mbM5+VSC0s3nGdBZN6tWAsmouCbE6Im1f4CdzS
         e6Gw==
X-Gm-Message-State: APjAAAXg1x97Mu5v+MHwocFTW622UlnW8De7OkqvzdoDA3kfyhtKuE4a
        SxUhn3eoIEgAxyTqUYfGg4uitynOrHiXwoPaCxc=
X-Google-Smtp-Source: APXvYqytxeS8L53oS7anlww6mkD6FxkkzlRqfznDU7NbmJRw48l356kP3488N8SKcyiC4ya2h0Aal4wUfTXOt3XuobM=
X-Received: by 2002:a6b:ed09:: with SMTP id n9mr1843806iog.153.1566345355817;
 Tue, 20 Aug 2019 16:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
 <20190818165817.32634-9-deepa.kernel@gmail.com> <20190820162856.GA21274@bombadil.infradead.org>
In-Reply-To: <20190820162856.GA21274@bombadil.infradead.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 20 Aug 2019 16:55:44 -0700
Message-ID: <CABeXuvoLHW2fYSNVC=N9tfNRtuq8Xg3QmqfcfMJEsCN5rEvuog@mail.gmail.com>
Subject: Re: [PATCH v8 08/20] adfs: Fill in max and min timestamps in sb
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 9:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Aug 18, 2019 at 09:58:05AM -0700, Deepa Dinamani wrote:
> > Note that the min timestamp is assumed to be
> > 01 Jan 1970 00:00:00 (Unix epoch). This is consistent
> > with the way we convert timestamps in adfs_adfs2unix_time().
>
> That's not actually correct.  RISC OS timestamps are centiseconds since
> 1900 stored in 5 bytes.

The timestamp can hold earlier values but the fs implementation
explicitly rejects those in adfs_adfs2unix_time() too_early check.
We could fix the implementation to not throw away times before 1970.
Are you suggesting we want to do this?
I could post a separate patch to fix this or we could do it as part of
the series.

 static void
 adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 {
         unsigned int high, low;
         static const s64 nsec_unix_epoch_diff_risc_os_epoch =
RISC_OS_EPOCH_DELTA * NSEC_PER_SEC;
         s64 nsec;

         if (!adfs_inode_is_stamped(inode))
                 goto cur_time;

         high = ADFS_I(inode)->loadaddr & 0xFF; /* top 8 bits of timestamp */
         low  = ADFS_I(inode)->execaddr;    /* bottom 32 bits of timestamp */

         /* convert 40-bit centi-seconds to 32-bit seconds
          * going via nanoseconds to retain precision
          */
         nsec = (((s64) high << 32) | (s64) low) * 10000000; /* cs to ns */

         /* Files dated pre  01 Jan 1970 00:00:00. */
         if (nsec < nsec_unix_epoch_diff_risc_os_epoch)
                 goto too_early;

         /* convert from RISC OS to Unix epoch */
         nsec -= nsec_unix_epoch_diff_risc_os_epoch;

         *tv = ns_to_timespec64(nsec);
         return;

  cur_time:
         *tv = current_time(inode);
         return;

  too_early:
         tv->tv_sec = tv->tv_nsec = 0;
         return;
 }

-Deepa
