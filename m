Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595DFCDA6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 04:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfJGCaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 22:30:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40522 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfJGCaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 22:30:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so7648667pfb.7;
        Sun, 06 Oct 2019 19:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YGjpu8ryTJmj9+qQvcdT72pgFzxKNn0JDKrBtisM5Yo=;
        b=dfQJ/qOrpDnZcEkCQnkZza2iEKQq9j26rxpgPi5Ms2YaSGclYVATq7qVZvZ9mK4M/s
         jwaff2DO3dPC2NKOuspZnmf8Rzqe7dRydjTjmP8TkkCVKmXA2A4ZCwIyL9Jw27jeEtkM
         kfn85HRuV3+rQv6db4WTfUQgn+hLWHuA8SMIPMeyj4iuL6g8SQGEE2UVouf3c6BDhbPT
         hijlOqP+LA8gGIoj1nsqrc06cN+jxWHrOlcKH5ZZis1HkO4E+B+cx9PUS+WaY00dfwt4
         c75h2VTP5lkjg6lZn0C99yAf33tOkVfqhM3PRyIiP6nroDltewe0lvOdIdjGiaG8sfHC
         nJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YGjpu8ryTJmj9+qQvcdT72pgFzxKNn0JDKrBtisM5Yo=;
        b=TpxPKkTSLQjCZuUYAhoXF/JfVjRj7yy1fo4S7rlVm11rZDr9nxz/CRJ4TJ3lotpqZR
         Z9QOTPYmKHwz+77NOt4N6j2uRNK5w1GdSYZijd1oRDIdy3Wedz8Jf2gRYCn2roornNZ5
         dgNIlbWFRYB/x+bKJCCgdFN1PyZycWs5g6BXcwSfEKQf4+Lm8sXOziC3Jh+hzwJWa4L4
         r8OKT/Tyieu/vwRfsp11+Sl2De9jMD2JlhTo4c3aFlbuaCi9ENv6vEjOO9nf9b6DlCc2
         M76ZfNZTOhWjynaGKR5L2o0g+PNvKlvlRCmk2eXyTr39JoKHRYAlK9BHoDStu0QikgNy
         5e1A==
X-Gm-Message-State: APjAAAXzra5/OYXLnMWJq5OG3fA4lQ4VZPew298dUonYxZ5QO2LwhEe6
        bcu6DH0cwVIwlWusGTCKrKpGu7s/
X-Google-Smtp-Source: APXvYqxYHjYhp+FPiyT9juSRuUmfuBocFjOXnRXj15b5Xc2xqXMD5kIt3az+stvbSstLH06yMvcqqA==
X-Received: by 2002:a63:1e16:: with SMTP id e22mr28381741pge.413.1570415418760;
        Sun, 06 Oct 2019 19:30:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p189sm15158676pfp.163.2019.10.06.19.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 19:30:17 -0700 (PDT)
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
 <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c3e9ec03-5eb5-75bb-98da-63eaa9246cff@roeck-us.net>
Date:   Sun, 6 Oct 2019 19:30:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/19 6:17 PM, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 5:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
> And yes, I'll fix that name copy loop in filldir to align the
> destination first, *but* if I'm right, it means that something like
> this should also likely cause issues:
> 
>    #define _GNU_SOURCE
>    #include <unistd.h>
>    #include <sys/mman.h>
> 
>    int main(int argc, char **argv)
>    {
>          void *mymap;
>          uid_t *bad_ptr = (void *) 0x01;
> 
>          /* Create unpopulated memory area */
>          mymap = mmap(NULL, 16384, PROT_READ | PROT_WRITE, MAP_PRIVATE
> | MAP_ANONYMOUS, -1, 0);
> 
>          /* Unaligned uidpointer in that memory area */
>          bad_ptr = mymap+1;
> 
>          /* Make the kernel do put_user() on it */
>          return getresuid(bad_ptr, bad_ptr+1, bad_ptr+2);
>    }
> 
> because that simple user mode program should cause that same "page
> fault on unaligned put_user()" behavior as far as I can tell.
> 
> Mind humoring me and trying that on your alpha machine (or emulator,
> or whatever)?
> 

Here you are. This is with v5.4-rc2 and your previous patch applied
on top.

/ # ./mmtest
Unable to handle kernel paging request at virtual address 0000000000000004
mmtest(75): Oops -1
pc = [<0000000000000004>]  ra = [<fffffc0000311584>]  ps = 0000    Not tainted
pc is at 0x4
ra is at entSys+0xa4/0xc0
v0 = fffffffffffffff2  t0 = 0000000000000000  t1 = 0000000000000000
t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000000000
t5 = 000000000000fffe  t6 = 0000000000000000  t7 = fffffc0007edc000
s0 = 0000000000000000  s1 = 00000001200006f0  s2 = 00000001200df19f
s3 = 00000001200ea0b9  s4 = 0000000120114630  s5 = 00000001201145d8
s6 = 000000011f955c50
a0 = 000002000002c001  a1 = 000002000002c005  a2 = 000002000002c009
a3 = 0000000000000000  a4 = ffffffffffffffff  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0000000000  t10= 0000000000000000
t11= 000000011f955788  pv = fffffc0000349450  at = 00000000f8db54d3
gp = fffffc0000f2a160  sp = 00000000ab237c72
Disabling lock debugging due to kernel taint
Trace:

Code:
  00000000
  00063301
  000007b6
  00001111
  00003f8d

Segmentation fault

Guenter
