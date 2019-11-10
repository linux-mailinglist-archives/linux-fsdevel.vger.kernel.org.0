Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CBF69E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfKJPqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 10:46:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40755 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKJPqL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 10:46:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so8664982pfl.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2GQxyegm0e037btzeEVrHaTSoeZSraQmKEF2HPtcINM=;
        b=iT76+jqdNNWdjCQpvuTo3yccQOGR0HF+Vv8uFc80bOjg5+6/QCNi9N4XCDxrlmtZQZ
         jTDXAvm6Ni5EyKsKAO64wIdHFKHZfVHypp/Akr4g0KVcgTuC1g+F2b1RAQsbzb9j20LF
         iOybYFb60Cb2ex2uQ8h6ecwW9fS8Yumwkr8OArCiwjoT/GP6QXb7TYFGn9of+RMjRwmL
         Z7tIFtXCBDI4bs0FHdfquiMmEJdYS1kbWI9beyWOK93RQa9p5Ifj+b3wARLX2xhL/hXQ
         //Wv7q/9XFN8ofBdUy24esQtUFUCQq7sadQtnaxWYlIqrdP341tJ1WUFT/u2T8Fk8Uni
         QCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GQxyegm0e037btzeEVrHaTSoeZSraQmKEF2HPtcINM=;
        b=AGHYyGtzV3e1DM1obLpV7JDtPuz8YUnABqTcpium2dehU40S24XckxV802qVaKVu7b
         BXFfndKlryp4jSRJbqEySqcloSB9thrHi7HJ1MHt5wOM5NVb2AZ1rEORp6QniFMFlzCf
         GS6gZiqicEE9FkJI/wscFauIDyA5BaWsnp4nj63SQuyzf2M6sQitvjZrxlXk/81iilkD
         BjsyNdCHpJdXYBb3FCw0KEAJjMv2U+ywSfUqvPXcofrgUQL0VzsYGHTyhudVxvAQRhjo
         ixLRd70D3CGB7gVmKPhQjU0y3oyw7Nr4qK80P+RKroz9+WyJfB/6iQ1sswA/k1QFC/z0
         Gp+A==
X-Gm-Message-State: APjAAAX5M/48PTDk344FloAbMYI1Qo+bO369q8XkBChy2zvWYz7hWbYs
        niZG+K6sGBzV3m+0szdLAXUcgA==
X-Google-Smtp-Source: APXvYqxavNec6jVy0ssikQL5rcqDsZqRzOK/WiO6T6ozJAH7dR1eaCKDtNe/a15zS8npgO7vYxaorA==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr7289159pfa.50.1573400769979;
        Sun, 10 Nov 2019 07:46:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j126sm13804259pfg.4.2019.11.10.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 07:46:08 -0800 (PST)
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
To:     syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000e11df90596fc9955@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3ed8352-23ca-246d-088c-878f9da82c76@kernel.dk>
Date:   Sun, 10 Nov 2019 08:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000e11df90596fc9955@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/10/19 4:49 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Sat Oct 26 13:20:21 2019 +0000
> 
>       io_uring: support for larger fixed file sets
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
> start commit:   5591cf00 Add linux-next specific files for 20191108
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000
> 
> Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
> Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks, I queued up a fix:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fc2a85cb02efd7bdbd09ea5d2d9847937da7bff7

-- 
Jens Axboe

