Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4FD896E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfJPHbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:31:20 -0400
Received: from tretyak2.mcst.ru ([212.5.119.215]:54008 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfJPHbT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:31:19 -0400
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 362B920A29;
        Wed, 16 Oct 2019 10:31:17 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 195002092D;
        Wed, 16 Oct 2019 10:31:07 +0300 (MSK)
Received: from [192.168.1.7] (e2k7 [192.168.1.7])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id x9G7V6Uu029565;
        Wed, 16 Oct 2019 10:31:06 +0300
Subject: Re: copy_mount_options() problem
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <5DA60B3E.5080303@mcst.ru>
 <20191015184034.GN26530@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
From:   "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Message-ID: <5DA6C73A.4010809@mcst.ru>
Date:   Wed, 16 Oct 2019 10:31:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <20191015184034.GN26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20191016 notchecked
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:16
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            |/  _-----=> need-resched_lazy
#                            || / _---=> hardirq/softirq
#                            ||| / _--=> preempt-depth
#                            |||| / _-=> preempt-lazy-depth
#                            ||||| / _-=> migrate-disable
#                            |||||| /    delay
#           TASK-PID   CPU#  |||||||   TIMESTAMP  FUNCTION
#              | |       |   |||||||      |         |
        automount-5999  [001] .......   170.320000: 0: 
copy_mount_options(): copy 0xd017d560b000 data 0xc2dfffffe340 size 
0x1000 USER_DS 0xc2dffffff000 TASK_SIZE 0xd00000000000
        automount-5999  [001] .......   170.320000: : 
exact_copy_from_user(): !access_ok
        automount-5999  [001] .......   170.320000: : 
copy_mount_options(): return -EFAULT

On 15.10.2019 21:40, Al Viro wrote:
> On Tue, Oct 15, 2019 at 09:09:02PM +0300, Pavel V. Panteleev wrote:
>> Hello,
>>
>> copy_mount_options() checks that data doesn't cross TASK_SIZE boundary. It's
>> not correct. Really it should check USER_DS boudary, because some archs have
>> TASK_SIZE not equal to USER_DS. In this case (USER_DS != TASK_SIZE)
>> exact_copy_from_user() will stop on access_ok() check, if data cross
>> USER_DS, but doesn't cross TASK_SIZE.
> Details of the call chain, please.
>
>

