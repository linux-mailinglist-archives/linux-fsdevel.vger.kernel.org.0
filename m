Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C559F2B45A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgKPOPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:15:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52558 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgKPOPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:15:35 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0AGEFVEN066011;
        Mon, 16 Nov 2020 23:15:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Mon, 16 Nov 2020 23:15:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0AGEFVKB066007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Nov 2020 23:15:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Garbage data while reading via usermode driver?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0c98ab7f-8483-bb54-7b8f-3d69ed45f1ff@i-love.sakura.ne.jp>
 <20201116123525.GW3576660@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <69d7648e-2c73-65bb-c2eb-53dd10b9a072@i-love.sakura.ne.jp>
Date:   Mon, 16 Nov 2020 23:15:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116123525.GW3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/16 21:35, Al Viro wrote:
> On Mon, Nov 16, 2020 at 08:11:04PM +0900, Tetsuo Handa wrote:
>> Hello.
>>
>> Below is a loadable kernel module which attempts to read (for example) /proc/interrupts from
>> kernel using usermode driver interface. What is strange is that the total bytes obtained by
>> doing "wc -c /proc/interrupts" from userspace's shell and trying to insmod this kernel module
>> differs; for unknown reason, kernel_read() returns "#!/bin/cat /proc/interrupts\n" (28 bytes)
>> at the end of input.
> 
> Because /bin/cat writes it out ;-)

You are right. ;-)

I have an out of tree kernel module (a loadable kernel version of TOMOYO security module)
which needs to read /proc/kallsyms from kernel (in order to find symbols needed by TOMOYO).
Now that kernel_read() can no longer read /proc/kallsyms , I had to abuse usermode driver
only for reading /proc/kallsyms ( https://osdn.net/projects/akari/scm/svn/commits/662 ).
