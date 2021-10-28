Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E343E8AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJ1S7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 14:59:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45368 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1S7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:05 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 083D11F454BA;
        Thu, 28 Oct 2021 19:56:35 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 31/32] samples: Add fs error monitoring example
Organization: Collabora
References: <20211019000015.1666608-1-krisman@collabora.com>
        <20211019000015.1666608-32-krisman@collabora.com>
        <20211028151834.GA423440@roeck-us.net>
Date:   Thu, 28 Oct 2021 15:56:28 -0300
In-Reply-To: <20211028151834.GA423440@roeck-us.net> (Guenter Roeck's message
        of "Thu, 28 Oct 2021 08:18:34 -0700")
Message-ID: <87fsslasgz.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Mon, Oct 18, 2021 at 09:00:14PM -0300, Gabriel Krisman Bertazi wrote:
>> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
>> errors.
>> 
>> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>> Changes since v4:
>>   - Protect file_handle defines with ifdef guards
>> 
>> Changes since v1:
>>   - minor fixes
>> ---
>>  samples/Kconfig               |   9 +++
>>  samples/Makefile              |   1 +
>>  samples/fanotify/Makefile     |   5 ++
>>  samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 157 insertions(+)
>>  create mode 100644 samples/fanotify/Makefile
>>  create mode 100644 samples/fanotify/fs-monitor.c
>> 
>> diff --git a/samples/Kconfig b/samples/Kconfig
>> index b0503ef058d3..88353b8eac0b 100644
>> --- a/samples/Kconfig
>> +++ b/samples/Kconfig
>> @@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
>>  	  with it.
>>  	  See also Documentation/driver-api/connector.rst
>>  
>> +config SAMPLE_FANOTIFY_ERROR
>> +	bool "Build fanotify error monitoring sample"
>> +	depends on FANOTIFY
>
> This needs something like
> 	depends on CC_CAN_LINK
> or possibly even
> 	depends on CC_CAN_LINK && HEADERS_INSTALL
> to avoid compilation errors such as
>
> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
>     7 | #include <errno.h>
>       |          ^~~~~~~~~
> compilation terminated.
>
> when using a toolchain without C library support, such as those provided
> on kernel.org.

Thank you, Guenter.

We discussed this, but I wasn't sure how to silence the error and it
didn't trigger in the past versions.

The original patch is already in Jan's tree.  Jan, would you pick the
pack below to address it?  Feel free to squash it into the original
commit, if you think it is saner..

Thanks,

-- >8 --
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Thu, 28 Oct 2021 15:34:46 -0300
Subject: [PATCH] samples: Make fs-monitor depend on libc and headers

Prevent build errors when headers or libc are not available, such as on
kernel build bots, like the below:

samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file
or directory
  7 | #include <errno.h>
    |          ^~~~~~~~~

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 88353b8eac0b..56539b21f2c7 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -122,7 +122,7 @@ config SAMPLE_CONNECTOR
 
 config SAMPLE_FANOTIFY_ERROR
 	bool "Build fanotify error monitoring sample"
-	depends on FANOTIFY
+	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  When enabled, this builds an example code that uses the
 	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
-- 
2.33.0
