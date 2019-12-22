Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D745128CD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2019 06:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfLVF3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 00:29:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38096 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfLVF3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 00:29:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id d7so13221029otf.5;
        Sat, 21 Dec 2019 21:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZkuKQsKverFFdadZsvM9+HOpPLDV24DoMiHwcyD+pjA=;
        b=vO3AvY1Wy25ZYHDFrrr+VCcNh2SfEdYzq0Dv8f6jj3qpOcTsyFVfpV29OzOhXE9Xeb
         2LQv6yIV1IeWF6jOKDEcFPLXeH2Rz9JeGw6k9ftcHb9gyyOuDzhk3JxUYGmdrJBCXm0y
         MI6t5/SBa8UekMrEkYZPNUZAs+XUz0gIDcaoTsokFtorXH/vPERgNkCTu86DK/NOUxcq
         F+e91xbiT3BrYF0bZoTPHkZb/A/eVmHrY7xMHQPZjyp32yPoK2pJt2Qrga49NV9XUj5f
         4m9jr5RhzFlGNex2hWDW9PEK3GaRfukKT+lnTgzDAZzGDYWqHW4v3KWjFJHA0FNhMlOY
         6RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZkuKQsKverFFdadZsvM9+HOpPLDV24DoMiHwcyD+pjA=;
        b=BNZDNrTRtRJMKgZ8Sdxo1akM6CFGxLY0Y6i13wXzsWZM2Ah8tuV5u7J5oZ+orRMA9T
         j0qllI8p+9wxm8y55wFUdhqA3b2Pc5hE5BcrB7f4Bmx+kzsyjm7YJRezFfrNKgCm8kj2
         O95zkO+kfvbCWQW7KR26oIIifBBgX4lAHh3A89ucjx1XvY9Am6FnSWn6qR+SgQVktV1u
         yLWmlLv7JkEYf6VEDGBbQiAVq7Bq4v3PhfPPY5WnEk+8crPaKXx9pFCEocOu8MT2Bf02
         /mfa0BnegAf5R38dg+cOoUXE282RjvikyBXcgNsga9s6AQwx9vdZd1Hg4Gbg9Q34VvaY
         6f6g==
X-Gm-Message-State: APjAAAVsZhSqZKQs3aSmEFcCUZ0mNfib7dab8LZbtx8Uapx5OvFTJtDI
        NG6eP+DPZtK1/+UIQV+cZ7zRxRpL
X-Google-Smtp-Source: APXvYqyj7IQPWsm9jvv6GHVdWS1aTMAFVZcxVcIMp4BPeMvRSvVlO3eflF3UejP7lGtM9ycZZoO61A==
X-Received: by 2002:a9d:5786:: with SMTP id q6mr7758153oth.164.1576992563606;
        Sat, 21 Dec 2019 21:29:23 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e65sm5579838otb.62.2019.12.21.21.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 21:29:22 -0800 (PST)
Date:   Sat, 21 Dec 2019 22:29:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fs: use UB-safe check for signed addition
 overflow in remap_verify_area
Message-ID: <20191222052921.GA30288@ubuntu-m2-xlarge-x86>
References: <20190808123942.19592-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808123942.19592-1-dsterba@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:39:42PM +0200, David Sterba wrote:
> The following warning pops up with enabled UBSAN in tests fstests/generic/303:
> 
>   [23127.529395] UBSAN: Undefined behaviour in fs/read_write.c:1725:7
>   [23127.529400] signed integer overflow:
>   [23127.529403] 4611686018427322368 + 9223372036854775807 cannot be represented in type 'long long int'
>   [23127.529412] CPU: 4 PID: 26180 Comm: xfs_io Not tainted 5.2.0-rc2-1.ge195904-vanilla+ #450
>   [23127.556999] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
>   [23127.557001] Call Trace:
>   [23127.557060]  dump_stack+0x67/0x9b
>   [23127.557070]  ubsan_epilogue+0x9/0x40
>   [23127.573496]  handle_overflow+0xb3/0xc0
>   [23127.573514]  do_clone_file_range+0x28f/0x2a0
>   [23127.573547]  vfs_clone_file_range+0x35/0xb0
>   [23127.573564]  ioctl_file_clone+0x8d/0xc0
>   [23127.590144]  do_vfs_ioctl+0x300/0x700
>   [23127.590160]  ksys_ioctl+0x70/0x80
>   [23127.590203]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>   [23127.590210]  __x64_sys_ioctl+0x16/0x20
>   [23127.590215]  do_syscall_64+0x5c/0x1d0
>   [23127.590224]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [23127.590231] RIP: 0033:0x7ff6d7250327
>   [23127.590241] RSP: 002b:00007ffe3a38f1d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>   [23127.590246] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ff6d7250327
>   [23127.590249] RDX: 00007ffe3a38f220 RSI: 000000004020940d RDI: 0000000000000003
>   [23127.590252] RBP: 0000000000000000 R08: 00007ffe3a3c80a0 R09: 00007ffe3a3c8080
>   [23127.590255] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 0000000000000000
>   [23127.590260] R13: 0000000000000000 R14: 3fffffffffff0000 R15: 00007ff6d750a20c
> 
> As loff_t is a signed type, we should use the safe overflow checks
> instead of relying on compiler implementation.
> 
> The bogus values are intentional and the test is supposed to verify the
> boundary conditions.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
