Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9071410D215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 08:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfK2HvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 02:51:03 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:43042 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2HvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:51:02 -0500
Received: by mail-lj1-f180.google.com with SMTP id a13so7765913ljm.10;
        Thu, 28 Nov 2019 23:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=G7htS148MLHne5gcdg1L2MpYQYz/l/iKEwv8PYFcG2E=;
        b=F1sUJA6CQo0FU6YJTe8zF3XS9wn1GdYIGYKKW0FkH1WZjpFUNLduWY7619x4knvYuL
         II29bxpBYNCe1WTppKZPD3gWAjLNZvPN8OYY+bRDbydx8UvRceDBEacyqW7eHUDwYexn
         TeX/cu4QgfvFSzOQo2tyqLXKl6WzzWLcts+u+DBj+apKQ0DLv2jyN1R6JN4TwG89ZHNM
         yuCv43rlcM8ImNJ/JymVpNIGiWmBNW8ivSjHfB+WQ3C8K+rDH6OoA1h1H+YcuX6fiPn1
         8ODbdSJiZdXp3rJ/vf1zqTG3Tv7a/o7gxl+QC/JTulZCeDkOil1FNdS/SAYXzfr5txH9
         wiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=G7htS148MLHne5gcdg1L2MpYQYz/l/iKEwv8PYFcG2E=;
        b=WERmLLP1De0aqa6XNds/ch61d1gpqSQQNwVWrJGYNYCWOu1JlPyyJBH91vY1Hwz0rp
         NMClHvRIS1g6vAi1YgkRQDeQmrQIWV3LY6Pw6kWGJppulS+LBuF8gkstqbG/qBoGu6kU
         FcyIWpkg/FuTCfTNaPd/EiE8bWpvevtx3WV698FuTXhLtmeDU5+GAfp8kPcxRivTs6w3
         U8gkul+4SHcnwVAYsA6QBXZQTkJQqHwmKNXTMZ2Dt3zl1cSbybqSYZFGW+unM+fOsZ6x
         Ak67SX3VGMD4N6tdCndXDU5xKBu894V648qE05TlyvQSvupjwHFrCY8OUF0h6ueWyMnF
         ranw==
X-Gm-Message-State: APjAAAUSY7cg+zu+RC7eR0R9ZY1yYwn49HTcSGUQrlkwr/ldhyM+FuRB
        DOMlkrueBErC0sUeEZINRgWYGM6rYBZTIVIMdCc3pujz
X-Google-Smtp-Source: APXvYqzTIyrUoGUmL075z/BU7X+QXiOWAeMrU+mvmklSZUzJDlwkcaucXHnotp5Tm7JwlrZBFFBcw/VvT1SXB0VSACM=
X-Received: by 2002:a2e:984f:: with SMTP id e15mr36803147ljj.109.1575013858719;
 Thu, 28 Nov 2019 23:50:58 -0800 (PST)
MIME-Version: 1.0
From:   Jason Xing <kerneljasonxing@gmail.com>
Date:   Fri, 29 Nov 2019 15:50:22 +0800
Message-ID: <CAL+tcoD8o5A4vgLHHp8dyFV5PmJVL5tu0h-XQavLOiAexmVLRQ@mail.gmail.com>
Subject: About whether we should support the alignment in the
 generic_file_splice_read() ?
To:     viro@zeniv.linux.org.uk
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Sorry to send this email to you all. I recently noticed there're some
incompatibilities existing in the generic_file_splice_read() function
between 3.X and 4.X kernel. The result will goes wrong if we're using
sendfile() with unaligned offset in 4.X/5.X kernel. But if we do the
same in 3.X kernel, it will surely return success.

Here is the call trace:
1. Using sendfile() with unaligned offset
2. Then it runs into the kernel:
sendfile64()->do_sendfile()->do_splice_direct()->splice_direct_to_actor()->do_splice_to()->splice_read()
3. splice_read() calls the __generic_file_splice_read() in 3.X kernel,
generic_file_splice_read() in 4.X kernel.

In 3.X kernel, this function handles the alignment by using the
PAGE_SHIFT and PAGE_MASK. However, after applying this
commit(82c156f853840645604acd7c2cebcb75ed1b6652) the 4.X no longer
supports the unaligned data.

I'm wondering should we add the alignment process code back again?
Does anyone have idea about why this part got removed? Any information
and suggestions are welcome:-)

Thanks,
Jason
