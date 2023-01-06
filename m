Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1226608B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 22:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjAFVSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 16:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjAFVSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:18:09 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D687781C30;
        Fri,  6 Jan 2023 13:18:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3F0AA604F1;
        Fri,  6 Jan 2023 22:18:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673039886; bh=whBWRRi6+5dafVrdHXk6f5Ni/cHoDI18bNNHDz7fQPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qh9H0LU3AFs1ry2tYESspJyuuzH1IqS4ZQ4LrhGyHOQjPuek2S33ty2HPC0rF2nRn
         RJsRnswjpjHSPBIkq5Dm4fuyVoGCFeC+DgWublbi1LS8jP+cKZAqTYXpvmy6rhhas8
         tmn7WVRl10+O2uJbsvo4pw6Hk7sRCe+sFEjsXxdlGgWwyc0uJKZWG6AvPWLStg9ACu
         gcxEbWHTHQRRAAzG2jjDDyT/jUcXEIqFigrPG/A4hulMQmgnbwrbFQq/ExP9FOqibT
         mNPsrNBbA9pqtNdAE2Wb5q+eAWb1qMHE9Iu37B23rHZLvBDzsxPgkJsE5yWeEO08IZ
         PjvS51iolwgEQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jl9NtbcDPe2Z; Fri,  6 Jan 2023 22:18:04 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 7E881604F0;
        Fri,  6 Jan 2023 22:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673039883; bh=whBWRRi6+5dafVrdHXk6f5Ni/cHoDI18bNNHDz7fQPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZWQi72lCmS6wlMhGlrJXi8hF1CFQPbZ86tSn4uasP+roJQ0MuMlq0UV7x0cQ1qRLw
         4/IsNr8lNgT9dVCD1rDQCLu/nUfCpHlUNB/eVnKd24VYbbDy2fgZJsn6Anx11CsxZW
         CksY5wWvWGzgvf2LC2HzRW7gYfFjvuc6zY8I8VRnaDZX7QWYNCJP6iV0IcYHHTSdfC
         L/Sq8ITIWgQdDs2tG2CDiE7KRsWMUHQpX1OgUIaDdFS/SH7KA0jdEmj2AdRFKORdYd
         EY7D1XQRXag5iKGvxrfSheca4b+d+gfhKnG9Uj3C+FwEBlnAflzmYwybJUzJAEMT0V
         lhEbeGkmvWCrA==
Message-ID: <d600f5c4-290b-d575-19a0-9cc83f77caaa@alu.unizg.hr>
Date:   Fri, 6 Jan 2023 22:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: BUG: assert spuriously fails in selftest/proc/proc-uptime-001.c
Content-Language: en-US, hr
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
 <Y7h2xvzKLg36DSq8@p183>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y7h2xvzKLg36DSq8@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

In the same environment as the previous bug report (Lenovo Ideapad 3 15ITL6 laptop
running Ubuntu 22.10 kinetic kudu and 6.2-rc2 vanilla Torvalds tree kernel), the
next test in the ...selftest/proc/* sequence spuriously fails in assert (i1 <= i0).

Please note that the compiler is the novelty GCC 12.2.0-3ubuntu1.

This was previously hidden by premature hang in the `make kselftest` run due to
proc-empty-vm an proc-pid-vm problems that are now fixed.

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.
Aborted (core dumped)
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/proc# ./proc-uptime-001

It happens about half of the times the program is called.

The source seems OK, I can't tell why the idle counter doesn't look monotonic to
the program.

Hope this helps.

BTW, good news: this time I have checked independently, and this is the last test from the .../selftest/proc
group that doesn't have clean exit code 0.

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

