Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC317927B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDOkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 09:40:07 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46533 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCDOkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:40:06 -0500
Received: by mail-io1-f67.google.com with SMTP id x21so2590461iox.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dMGVVFarDw73CfV5fUTk6Su35UJvJOifOzDgrmDUXRc=;
        b=Zn9CxSVlchouOG4GZgk7Nm4O/NAB0SnMeBa/JRkGZQ9G1OUrvvluEsXpyBEz8p0mbm
         7wYFzOiTNUdcvsrB6Rvv5CcuSi1CFmYKyGmQmVo8he30G67WaU8kY5ZmaCpX13/5okzl
         KA6BcOXHqW21m8kffBdz9LGa8fLlHe/L+vgJkgYOgJU1kYf0fqdurzWAaaMthk9C24R4
         PZ/4+OTiTWx44fuJjJuJajQQLJPFuchVQ9vRd62Ti3X+1x87hzclf65iIwzpQLwcyk9S
         juAGN51NgAopyDzlSLFxItv/TCemR9SYKMqZSNW27phIVAWaxpAEjIXz34t1ePEh6V+R
         cxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dMGVVFarDw73CfV5fUTk6Su35UJvJOifOzDgrmDUXRc=;
        b=j/BAwIEB5bME7+e6yz0qGZbgKA74ErilGeXNuHZzQ2QIdy5UkLrODwDbNdoh2qVRai
         rnYgmFUu00N7wQJstcTsk0k3cAVFRL4Zq0cDLRwMotwCr0AeZ3MiJ780lmKX+/tEbFV6
         AdUxBc2xZel1r8iNo9JbxYvJTSfOdABY2eQYChYh/spGkxXXTxd4G0fDP23pJ6i4o1Q3
         udjRNz9TtCwJxAh2yzM7+1wIhOXrYbMgGrKMydH8WIAZ2cAlDfliVzBIJalxwGfeITSX
         UOh0XgOHxZfoJcZA8AEyU1ixFwzQk9UeO+K4J+2DKrcDQTjUACH0/FiAzS5u1AgRux4W
         LjKw==
X-Gm-Message-State: ANhLgQ1DZKIwpf6iwlcXxx3aSwM7nIQtXWGhPoQLG+RwfzuY5aw/gjXt
        ur+n5u6VKXvO36lYYNFtvMQ+dg==
X-Google-Smtp-Source: ADFU+vubGPSo6Z/AKTb62TsrXVcF66QjDDSgPTJ2s+8TaTBeohcH0WybO8+xeSzKqgfJmF8AzmAnRQ==
X-Received: by 2002:a6b:3756:: with SMTP id e83mr2523436ioa.133.1583332805008;
        Wed, 04 Mar 2020 06:40:05 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c24sm6544597iom.0.2020.03.04.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 06:40:04 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in percpu_ref_switch_to_atomic_rcu
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        the arch/x86 maintainers <x86@kernel.org>
References: <00000000000067c6df059df7f9f5@google.com>
 <CACT4Y+ZVLs7O84qixsvFqk_Nur1WOaCU81RiCwDf3wOqvHB-ag@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f805e51-1db7-3e57-c9a3-15a20699ea54@kernel.dk>
Date:   Wed, 4 Mar 2020 07:40:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZVLs7O84qixsvFqk_Nur1WOaCU81RiCwDf3wOqvHB-ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/20 12:59 AM, Dmitry Vyukov wrote:
> On Fri, Feb 7, 2020 at 9:14 AM syzbot
> <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    4c7d00cc Merge tag 'pwm/for-5.6-rc1' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12fec785e00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e162021ddededa72
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e017e49c39ab484ac87a
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com
> 
> +io_uring maintainers
> 
> Here is a repro:
> https://gist.githubusercontent.com/dvyukov/6b340beab6483a036f4186e7378882ce/raw/cd1922185516453c201df8eded1d4b006a6d6a3a/gistfile1.txt

I've queued up a fix for this:

https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.6&id=9875fe3dc4b8cff1f1b440fb925054a5124403c3

-- 
Jens Axboe

