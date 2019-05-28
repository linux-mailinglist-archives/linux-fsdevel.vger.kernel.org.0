Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76A2C51D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE1LFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 07:05:49 -0400
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:61701
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbfE1LFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 07:05:49 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 07:05:47 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AoAACTEu1c//aqqnwNWBkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgWWEJoQTg3uRH5M/hj4DVAkBAQEBAQEBAQE3AQEBhD8?=
 =?us-ascii?q?CgwE4EwEDAQEBBAEBAQEDAYZgAQEBAyMVQRALGAICJgICVwYBDAYCAQGDHoF?=
 =?us-ascii?q?qAadJcYEvhUeDHIFGgQwoi2qBQD+BOII2NT6HToJYBI1bhgKUHVkJgR5xXo4?=
 =?us-ascii?q?HhCohgh+KZolELYxBmAZXgSEzGh+DQIIYGo4yYI8WAQE?=
X-IPAS-Result: =?us-ascii?q?A2AoAACTEu1c//aqqnwNWBkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgWWEJoQTg3uRH5M/hj4DVAkBAQEBAQEBAQE3AQEBhD8CgwE4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEDAYZgAQEBAyMVQRALGAICJgICVwYBDAYCAQGDHoFqAadJcYEvhUeDH?=
 =?us-ascii?q?IFGgQwoi2qBQD+BOII2NT6HToJYBI1bhgKUHVkJgR5xXo4HhCohgh+KZolEL?=
 =?us-ascii?q?YxBmAZXgSEzGh+DQIIYGo4yYI8WAQE?=
X-IronPort-AV: E=Sophos;i="5.60,521,1549900800"; 
   d="scan'208";a="163258770"
Received: from 124-170-170-246.dyn.iinet.net.au (HELO [192.168.0.106]) ([124.170.170.246])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 28 May 2019 18:56:25 +0800
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20190524201817.16509-1-jannh@google.com>
 <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
From:   Greg Ungerer <gregungerer@westnet.com.au>
Message-ID: <aa7f66ad-dab5-f0b6-ade9-7d3698d509a9@westnet.com.au>
Date:   Tue, 28 May 2019 20:56:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 27/5/19 11:38 pm, Jann Horn wrote:
> On Sat, May 25, 2019 at 11:43 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
>>> load_flat_shared_library() is broken: It only calls load_flat_file() if
>>> prepare_binprm() returns zero, but prepare_binprm() returns the number of
>>> bytes read - so this only happens if the file is empty.
>>
>> ouch.
>>
>>> Instead, call into load_flat_file() if the number of bytes read is
>>> non-negative. (Even if the number of bytes is zero - in that case,
>>> load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
>>>
>>> In addition, remove the code related to bprm creds and stop using
>>> prepare_binprm() - this code is loading a library, not a main executable,
>>> and it only actually uses the members "buf", "file" and "filename" of the
>>> linux_binprm struct. Instead, call kernel_read() directly.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>> ---
>>> I only found the bug by looking at the code, I have not verified its
>>> existence at runtime.
>>> Also, this patch is compile-tested only.
>>> It would be nice if someone who works with nommu Linux could have a
>>> look at this patch.
>>
>> 287980e49ffc was three years ago!  Has it really been broken for all
>> that time?  If so, it seems a good source of freed disk space...
> 
> Maybe... but I didn't want to rip it out without having one of the
> maintainers confirm that this really isn't likely to be used anymore.

I have not used shared libraries on m68k non-mmu setups for
a very long time. At least 10 years I would think.

Regards
Greg



