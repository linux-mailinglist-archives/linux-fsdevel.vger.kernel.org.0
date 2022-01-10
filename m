Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160AB4896A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 11:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiAJKqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 05:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiAJKqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:46:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727EEC06173F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 02:46:32 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v123so8427033wme.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SpvwAuihWslZqXA/ciuI6rZvOl34Iog/rpC5Tpxi+eE=;
        b=Ii3ZEC9yu5j/eD9DUKA2GXQ4ru1n67a8MAtb/NSpE0WjjARKmmma91YIWEGM0RKAjD
         1ZqjZy1uCJT6HS1vOYTWmKcavW70pweDB0BvOMS0I6wzDOOaGrFsnkXX302+4RV4aI/O
         tewv0KFiJCt9+RxP6OjkyRbrq1z2WPnZysTsLyT7Cf2tgVvAzL7wCyaiVELCDH9w9Wog
         i/b/1qg1b8VqFtpltiL3H+DkM6NdiXJxsclRSzk8o42YdX8s7uHl0hwEj5V3Iu3TCSQ4
         G0oZUj/4q51SCa6RvPAV59/sUjLl1V7gDZmqcxgLTDzWd6ug2EfCUqR9OaaE86Okxt2J
         K4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SpvwAuihWslZqXA/ciuI6rZvOl34Iog/rpC5Tpxi+eE=;
        b=zKSmXGygwx52Hhzt1Q1b4hvSKCCnN4YISbe6xKOYfES5RvQUV6g3toJ/j03MV3k9GX
         51TeDtAbcUOD/sNtJWLBEADVeBA/DmidBA/zrfwBbZ8zbN+Jjc6nCHhvids69L0+wYJ3
         kAIkcxj99AgqzSaz6INKAaOzMAvQbpr9pyuaiVbxIVhRz3xnF4Qao0cwc6GC+RhHqYzJ
         mS6VeUKPjjVI6w4UH3A0zcQMZpNFfGUyhrp2VoAiij5onIoR7eJ7sg5bZb6ynS2WS5Lw
         YzF2YPKpAbnl1UJY2ZSM+qxFd75vYY1GO5Z3MN+juIbDiKnWIuH0t7/DTozfDuladjtR
         ctCw==
X-Gm-Message-State: AOAM531ImLkjyhM6bY/KimpoFij0oAD3vKuUE5CRsVXfhJw+xR9HhMye
        0IjxYfEgGzp1GUfbrvyLaO8JxaI2y+x87/QbdKAXjMIE3gU=
X-Google-Smtp-Source: ABdhPJze+eGNusyg+MfUKu1UBt7/mKXybNxRtg5t0PwBKZI1MBck+XxEWpJ2EY/nikkVoyBIKW1eLvQcLbA+9VabVAo=
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr13163641wme.113.1641811590450;
 Mon, 10 Jan 2022 02:46:30 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Zuboff <anotherdiskmag@gmail.com>
Date:   Mon, 10 Jan 2022 13:46:19 +0300
Message-ID: <CAL-cVeifoTfbYRfOcb0YeYor+sCtPWo_2__49taprONhR+tncw@mail.gmail.com>
Subject: Bug: lockf returns false-positive EDEADLK in multiprocess
 multithreaded environment
To:     linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a32e0305d5380cc7"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a32e0305d5380cc7
Content-Type: text/plain; charset="UTF-8"

As an application-level developer, I found a counter-intuitive
behavior in lockf function provided by glibc and Linux kernel that is
likely a bug.

In glibc, lockf function is implemented on top of fcntl system call:
https://github.com/lattera/glibc/blob/master/io/lockf.c
man page says that lockf can sometimes detect deadlock:
http://manpages.ubuntu.com/manpages/xenial/man3/lockf.3.html
Same with fcntl(F_SETLKW), on top of which lockf is implemented:
http://manpages.ubuntu.com/manpages/hirsute/en/man3/fcntl.3posix.html

Deadlock detection algorithm in the Linux kernel
(https://github.com/torvalds/linux/blob/master/fs/locks.c) seems buggy
because it can easily give false positives. Suppose we have two
processes A and B, process A has threads 1 and 2, process B has
threads 3 and 4. When this processes execute concurrently, following
sequence of actions is possible:
1. processA thread1 gets lockI
2. processB thread2 gets lockII
3. processA thread3 tries to get lockII, starts to wait
4. processB thread4 tries to get lockI, kernel detects deadlock,
EDEADLK is returned from lockf function

Steps to reproduce this scenario (see attached file):
1. gcc -o edeadlk ./edeadlk.c -lpthread
2. Launch "./edeadlk a b" in the first terminal window.
3. Launch "./edeadlk a b" in the second terminal window.

What I expected to happen: two instances of the program are steadily working.

What happened instead:
Assertion failed: (lockf(fd, 1, 1)) != -1 file: ./edeadlk.c, line:25,
errno:35 . Error:: Resource deadlock avoided
Aborted (core dumped)

Surely, this behavior is kind of "right". lockf file locks belongs to
process, so on the process level it seems that deadlock is just about
to happen: process A holds lockI and waits for lockII, process B holds
lockII and is going to wait for lockI. However, the algorithm in the
kernel doesn't take threads into account. In fact, a deadlock is not
going to happen here if the thread scheduler will give control to some
thread holding a lock.

I think there's a problem with the deadlock detection algorithm
because it's overly pessimistic, which in turn creates problems --
lockf errors in applications. I had to patch my application to use
flock instead because flock doesn't have this overly-pessimistic
behavior.

--000000000000a32e0305d5380cc7
Content-Type: application/octet-stream; name="edeadlk.c"
Content-Disposition: attachment; filename="edeadlk.c"
Content-Transfer-Encoding: base64
Content-ID: <f_ky8k3qwq0>
X-Attachment-Id: f_ky8k3qwq0

I2luY2x1ZGU8dW5pc3RkLmg+CiNpbmNsdWRlPHN0ZGlvLmg+CiNpbmNsdWRlPHN0ZGxpYi5oPgoj
aW5jbHVkZTxmY250bC5oPgojaW5jbHVkZTxlcnJuby5oPgojaW5jbHVkZTxwdGhyZWFkLmg+CiNp
bmNsdWRlPHN0ZGRlZi5oPgojaW5jbHVkZTxzdGRpbnQuaD4KCiNkZWZpbmUgRElFKHgpXAp7XAoJ
ZnByaW50ZihzdGRlcnIsICJBc3NlcnRpb24gZmFpbGVkOiAiICN4ICIgZmlsZTogJXMsIGxpbmU6
JWQsIGVycm5vOiVkICIsIF9fRklMRV9fLCBfX0xJTkVfXywgZXJybm8pOyBcCglwZXJyb3IoIi4g
RXJyb3I6Iik7XAoJZmZsdXNoKHN0ZG91dCk7XAoJYWJvcnQoKTtcCn0KI2RlZmluZSBBU1MoeCkg
aWYgKCEoeCkpIERJRSh4KQojZGVmaW5lIEFTUzEoeCkgQVNTKCh4KSAhPSAtMSkKI2RlZmluZSBB
U1MwKHgpIEFTUygoeCkgPT0gMCkKCnZvaWQgKiBkZWFkbG9ja2VyKHZvaWQgKmFyZykKewogICAg
aW50IGZkID0gKGludCkocHRyZGlmZl90KWFyZzsKICAgIGZvciAoOzspIHsKICAgICAgICBBU1Mx
KCBsb2NrZihmZCwgRl9MT0NLLCAxKSApOwogICAgICAgIEFTUzEoIGxvY2tmKGZkLCBGX1VMT0NL
LCAxKSApOwogICAgfQogICAgcmV0dXJuIE5VTEw7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFy
ICogYXJndltdKQp7CiAgICBpbnQgZmQxLCBmZDI7CiAgICBBU1MoIGFyZ2MgPj0gMyApOwogICAg
QVNTMSggZmQxID0gY3JlYXQoYXJndlsxXSwgMDY2MCkgKTsKICAgIEFTUzEoIGZkMiA9IGNyZWF0
KGFyZ3ZbMl0sIDA2NjApICk7CiAgICB2b2lkICogdGhydjsKICAgIHB0aHJlYWRfdCB0aHIxLCB0
aHIyOwogICAgQVNTMCggcHRocmVhZF9jcmVhdGUoJnRocjEsIE5VTEwsIGRlYWRsb2NrZXIsICh2
b2lkICopKHB0cmRpZmZfdClmZDIpICk7CiAgICBBU1MwKCBwdGhyZWFkX2NyZWF0ZSgmdGhyMiwg
TlVMTCwgZGVhZGxvY2tlciwgKHZvaWQgKikocHRyZGlmZl90KWZkMSkgKTsKICAgIEFTUzAoIHB0
aHJlYWRfam9pbih0aHIxLCAmdGhydikgKTsKICAgIEFTUzAoIHB0aHJlYWRfam9pbih0aHIyLCAm
dGhydikgKTsKICAgIHJldHVybiAwOwp9Cg==
--000000000000a32e0305d5380cc7--
