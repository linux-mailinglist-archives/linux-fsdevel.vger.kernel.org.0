Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215A0129356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 09:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfLWIwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 03:52:50 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:36179 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfLWIwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:52:49 -0500
Received: by mail-qt1-f176.google.com with SMTP id q20so14850085qtp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TgZ5wQeLpSI36DgbHghGRNlge7sN/PjDKlYtqGLPpjE=;
        b=llHc5aACfmYmBh1HC6OzEaIUM0LWwqSs6lZi31qBvOiC8wdBuW4+1EZFG1YZgFpCXm
         SpSsijXHOevazB+gx0L4AQXraqK/7EEEl5CHkhLJjSHwXc0BT89duDGm4C99siUD5N1V
         nkzWy6uC9qFt3eJYKixjiNl6eNqw8yvmUHPvshFjqgjsY1lz75Iw3gBngeAKXamiJ0qV
         bzsUHvGl+cArSW33As3OuBVcg94aiWK6+C+IGlFi2+bNDSaeA24N+lq8vAmSIOa+BjYz
         I434PLXNP0iNSKrTKavBLqJ0/1RDcWF3+FGvLYUvv2d9B3loIUzi+7PGqGmjhQJtckso
         14rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TgZ5wQeLpSI36DgbHghGRNlge7sN/PjDKlYtqGLPpjE=;
        b=C6dElL29bp75DkV0EFK5MzatZ7wgj8PS7bGhLstYid+OaGXyxQglrUWSPa+FJ30Nbr
         Fk8xR+d7D78C2jJ234xEKZnGrWGHiy7S/xu+BsiSY8arJZZkgwyxFfXXgBcia3ZTHTS+
         8Tqf1Lod4vy/ZvkBCTjIzOifmyB5XA0ta68+e6hLgCWfMowqgLA7dH4CxwhqvlCOto52
         F5SmNhH0B15QZ5YZ0zbf0T8yV/VMi3f4QO22QSgTLZlKjRlCMbImUZKHU+CjWdh5LxAQ
         fXhP4rXF7+KDA8oG/mO9DjQlI2TV8X6fIVRPa+xwW0DlJxekWb0Wno54EGoUDw9ROWJU
         Qg9Q==
X-Gm-Message-State: APjAAAU9d6TmSovBGRuv/oF6fRanpRfTrFcWTQItBxkEpkzxGorXQSng
        o/246IiysKC9nGdiSUEpEDUYmJuwyaC6Qh6r+0PlKhQaU5g=
X-Google-Smtp-Source: APXvYqwyX8YBP9k0Ms8fSMbEQAj+AhDlMi3wWusHI8pSrG7RB4zxThL55AjozfAGs8XH9iPeXrfbpYIoS/JdT2w+pes=
X-Received: by 2002:ac8:769a:: with SMTP id g26mr21923157qtr.259.1577091168592;
 Mon, 23 Dec 2019 00:52:48 -0800 (PST)
MIME-Version: 1.0
From:   Liang Chen <liangchen.linux@gmail.com>
Date:   Mon, 23 Dec 2019 16:52:37 +0800
Message-ID: <CAKhg4tJwahZBXLtSB3fnk8n+Y9tXRehA_=1xkAJ6d3Gn1Hw5uQ@mail.gmail.com>
Subject: possible infinite loop with buffer_head usage
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There exists an inconsistency in calculation of page cache index between
__find_get_block_slow and grow_buffers.

__bread(bdev, 64, 1024);

With 4k page size and block size, above usage causes infinite loop in
__getblk_slow. This is not to say it doesn't have issues with different page
size or block size.

__find_get_block (in __find_get_block_slow) tries to find buffers associated
with page indexed at "block >> (PAGE_SHIFT - bd_inode->i_blkbits);", i.e. index
64.

grow_buffers calculates the page index in a different way which gives 16 for the
page index number, thus eventually associates the 4 newly created buffers (4K
page equally divided into 4 buffers of 1024 bytes) with the page at index 16.

So __find_get_block will never find the newly created buffer and stuck in the
loop.


Using i_blkbits for the calculation in grow_buffers seems to work, but there are
more concerns. For example, end_block and b_blocknr calculation in
init_page_buffers assumes block size equals to buffer size, and a similar
situation in submit_bh_wbc while calculating bi_sector. I made some minor
changes to these places to use block size instead of b_size, which looks ok with
a few simple test cases.

I would really appreciate if someone could give more insight on the issue and
potential impact on the changes of page cache index and b_blocknr calculation
before I go ahead spent more time on it.


Thanks,
Liang
