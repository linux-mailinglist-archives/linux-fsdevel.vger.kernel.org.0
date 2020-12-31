Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20912E8227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Dec 2020 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgLaVwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Dec 2020 16:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaVwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Dec 2020 16:52:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC88C061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Dec 2020 13:52:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id x13so23007932oic.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Dec 2020 13:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=zrm/yKGK2LgAghp0NfwHVE9/O8tdyy8MBBQEQ9hIitg=;
        b=eeeS7cZ0L4biDBtJ/kaGiN0wWTDgCNAEoy3Lst/GjtiQMR5viz9Tb+IEK4cn5Y/SGx
         WbOL3noJR3vEoFXB3uqOoJeQR0ULsVj1Hzw72jfqB7cbxM6SI4uL8MGGjzoDoc1vJDcn
         J5GX/IvNNhaId8bfa8xk58KK1vTZca90giA3v8agZ/ilEvE4hyrFHACqSuCk3qLVJRfO
         UMXU8Rd06tkB0Iv/jex74kpMVFzAzty6/UXC3evWnTMkw8KD3DhOK7cNH6+NnejGkONi
         HJTxWeogU4IUEKMVVa1X6J8/+24St6QmSR876uOA3gDG+juS0TnjyADVeLRb6enFYmaK
         BMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zrm/yKGK2LgAghp0NfwHVE9/O8tdyy8MBBQEQ9hIitg=;
        b=OXeYzkjEN8a1r+1yRXrHiETQQz9gSq+o35L5yqd+O2berfpE1x4BBwqOx/pcY3JF4R
         cUpygr2a8+7u7xTBBuc9uO/fGjeHv3lT/9qYNs8NJ5WoFK6HhZq3a7BPXEvkpg1kwqzO
         biPR8jiBkKzCC2zDSu4GWOa1RV/ljgftcPwjXngBLtuEGWXtj5yc8wyqpRrboJMS/1l8
         KLJTIq9ikpqj4XFIHkMKlwzFL2aaeWAE4xPkPRXFeqe262+yK6UrvDvkuNaq0zKyvHx9
         6Yeh6NzE4IRzRMlR1+L4Y/1avtCIkcIoJMlyrLpmOQMrMZxz7GPH219Br5Ss6awQe1DR
         lWag==
X-Gm-Message-State: AOAM53219f5X9dCpqPl1asrOLXpC9gBDAyzvQ1K9uDUMmGgS8PPcqVQj
        yoFsgzBclCaS1xb3Dn0trLVPkRskR3cIGG+cZ+bpQYM8astJ3MP3
X-Google-Smtp-Source: ABdhPJwMrn85+ozS61FoIVALLmH2oNIj7oD3wsjK7wyMjonVkGRi2isvEjG3Ucfajjze5eIOWqRRaSALe4ABWt3FySc=
X-Received: by 2002:aca:210f:: with SMTP id 15mr9119253oiz.174.1609451524664;
 Thu, 31 Dec 2020 13:52:04 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 31 Dec 2020 16:51:53 -0500
Message-ID: <CAOg9mSQkkZtqBND-HKb2oSB8jxT6bkQU1LuExo0hPsEUhcMrPw@mail.gmail.com>
Subject: problem with orangefs readpage...
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Mike Marshall <hubcapsc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings...

I hope some of you will suffer through reading this long message :-) ...

Orangefs isn't built to do small IO. Reading a
big file in page cache sized chunks is slow and painful.
I tried to write orangefs_readpage so that it would do a reasonable
sized hard IO, fill the page that was being called for, and then
go ahead and fill a whole bunch of the following pages into the
page cache with the extra data in the IO buffer.

Anywho... I thought this code was working pretty much like I
designed it to work, but on closer inspection I see that it is
not, and I thought I'd ask for some help or suggestions.

Here's the core of the loop in orangefs_readpage that tries to fill extra
pages, and what follows is a description of how it is not working
the way I designed it to work:

        while there's still data in the IO buffer
        {
            index++;
            slot_index++;
            next_page = find_get_page(inode->i_mapping, index);
            if (next_page) {
                gossip_debug(GOSSIP_FILE_DEBUG,
                    "%s: found next page, quitting\n",
                    __func__);
                put_page(next_page);
                goto out;
            }
            next_page = find_or_create_page(inode->i_mapping,
                            index,
                            GFP_KERNEL);
            /*
             * I've never hit this, leave it as a printk for
             * now so it will be obvious.
             */
            if (!next_page) {
                printk("%s: can't create next page, quitting\n",
                    __func__);
                goto out;
            }
            kaddr = kmap_atomic(next_page);
            orangefs_bufmap_page_fill(kaddr,
                        buffer_index,
                        slot_index);
            kunmap_atomic(kaddr);
            SetPageUptodate(next_page);
            unlock_page(next_page);
            put_page(next_page);
        }

So... my design was that orangefs_readpage would get called, the
needed page would be supplied and a bunch of the following pages
would get filled as well. That way if more pages were needed,
they would be in the page cache already.

My plan "kind of" works when a file is read a page at a time:

  /pvfsmnt/nine is nine pages long.
  -rwxr-xr-x. 1 root root 36864 Dec 29 11:09 /pvfsmnt/nine

  dd if=/pvfsmnt/nine of=/tmp/nine bs=4096 count=9

orangefs_readpage gets called for the first four pages and then my
prefill kicks in and fills the next pages and the right data ends
up in /tmp/nine. I, of course, wished and planned for orangefs_readpage
to only get called once, I don't understand why it gets called four
times, which results in three extraneous expensive hard IOs.

A nine page file is just an example, in general when files are read
a page at a time, orangefs_readpage gets called four times and the
rest of the pages (up to the design limit) are pre-filled.

When a file gets read all at once, though, my design
fails in a different way...

  dd if=/pvfsmnt/nine of=/tmp/nine bs=36864 count=1

In the above, orangefs_readpage gets called nine times, with
eight extraneous expensive hard IOs. Further investigation into
larger and larger block sizes shows a pattern.

I hope it is apparent to some of you why my page-at-a-time
reads don't start pre-filling until after four calls to orangefs_readpage.
Below are some more examples that show what happens with larger and larger
block sizes, hopefully the pattern there will be suggestive as well.

/pvfsmnt/N is a file exactly N pages long.

Key: orangefs_readpage->X times foo, bar, baz, ..., qux

X = number of calls to orangefs_readpage.
foo = number of bytes fetched from Orangefs on the first read.
bar = number of bytes fetched from Orangefs on the extraneous 2nd read.
baz = number of bytes fetched from Orangefs on the extraneous 3rd read.
qux = number of bytes fetched from Orangefs on the extraneous last read.


  dd if=/pvfsmnt/32 of=/tmp/32 bs=131072 count=1
       orangefs_readpage->32 times 131072, 126976, 122880, ..., 4096
       orangefs_bufmap_page_fill->0 times

  dd if=/pvfsmnt/33 of=/tmp/33 bs=135168 count=1
       orangefs_readpage->32 times 135168, 131072, 126976, ..., 8192
       orangefs_bufmap_page_fill->1 time

  dd if=/pvfsmnt/34 of=/tmp/34 bs=139264 count=1
       orangefs_readpage->32 times 139264, 135168, 131072, ..., 12288
       orangefs_bufmap_page_fill->2 times

  dd if=/pvfsmnt/35 of=/tmp/35 bs=143360 count=1
       orangefs_readpage->32 times 143360, 139264, 135168, ..., 16384
       orangefs_bufmap_page_fill->3 times

  dd if=/pvfsmnt/36 of=/tmp/36 bs=147456 count=1
       orangefs_readpage->32 times 147456, 143360, 139264, ..., 20480
       orangefs_bufmap_page_fill->4 times

  dd if=/pvfsmnt/37 of=/tmp/37 bs=151552 count=1
       orangefs_readpage->32 times 151552, 147456, 143360, ..., 24576
       orangefs_bufmap_page_fill->5 times

  dd if=/pvfsmnt/38 of=/tmp/38 bs=155648 count=1
       orangefs_readpage->32 times 155648, 151552, 147456, ..., 28672
       orangefs_bufmap_page_fill->6 times

  dd if=/pvfsmnt/39 of=/tmp/39 bs=159744 count=1
       orangefs_readpage->32 times 159744, 155648, 151552, ..., 32768
       orangefs_bufmap_page_fill->7 times

  dd if=/pvfsmnt/40 of=/tmp/40 bs=163840 count=1
       orangefs_readpage->32 times 163840, 159744, 155648, ..., 36864
       orangefs_bufmap_page_fill->8 times

  dd if=/pvfsmnt/41 of=/tmp/41 bs=167936 count=1
       orangefs_readpage->32 times 167936, 163840, 159744, ..., 40960
       orangefs_bufmap_page_fill->9 times

                     .
                     .
                     .

  dd if=/pvfsmnt/47 of=/tmp/47 bs=192512 count=1
       orangefs_readpage->32 times 192512, 188416, 184320, ..., 65536
       orangefs_bufmap_page_fill->15 times

  dd if=/pvfsmnt/48 of=/tmp/48 bs=196608 count=1
       orangefs_readpage->32 times 196608, 192512, 188416, ..., 69632
       orangefs_bufmap_page_fill->16 times

  dd if=/pvfsmnt/49 of=/tmp/49 bs=200704 count=1
       orangefs_readpage->32 times 200704, 196608, 192512, ..., 73728
       orangefs_bufmap_page_fill->17 times

                     .
                     .
                     .

  dd if=/pvfsmnt/63 of=/tmp/63 bs=258048 count=1
       orangefs_readpage->32 times 258048, 253952, 249856, ..., 131072
       orangefs_bufmap_page_fill->31 times

  dd if=/pvfsmnt/64 of=/tmp/64 bs=262144 count=1
       orangefs_readpage->32 times 262144, 258048, 253952, ..., 135168
       orangefs_bufmap_page_fill->32 times

  dd if=/pvfsmnt/65 of=/tmp/65 bs=266240 count=1
       orangefs_readpage->32 times 266240, 262144, 258048, ..., 139264
       orangefs_bufmap_page_fill->33 times

                     .
                     .
                     .

  dd if=/pvfsmnt/127 of=/tmp/127 bs=520192 count=1
       orangefs_readpage->32 times 520192, 516096, 512000, ..., 393216
       orangefs_bufmap_page_fill->95 times

  dd if=/pvfsmnt/128 of=/tmp/128 bs=524288 count=1
       orangefs_readpage->32 times 524288, 520192, 516096, ..., 397312
       orangefs_bufmap_page_fill->96 times

It kind of starts over here, since the hard IOs are all 524288 bytes.
# grep 524288 fs/orangefs/inode.c
    read_size = 524288;

Thanks for any help y'all can give, I'll of course keep on trying
to understand what is going on.

-Mike
