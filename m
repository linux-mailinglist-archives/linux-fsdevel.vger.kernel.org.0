Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957EBAB853
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392728AbfIFMnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 08:43:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392067AbfIFMnw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F1808553B
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 12:43:52 +0000 (UTC)
Received: from Liberator-6.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C9C600C4;
        Fri,  6 Sep 2019 12:43:51 +0000 (UTC)
Subject: Re: [PATCH] fs: fs_parser: remove fs_parameter_description name field
To:     David Howells <dhowells@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>
References: <7020be46-f21f-bd05-71a5-cb2bc073596b@redhat.com>
 <29446.1567761462@warthog.procyon.org.uk>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <9998d31a-7594-761c-a1a6-22b3ee96e736@redhat.com>
Date:   Fri, 6 Sep 2019 07:43:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29446.1567761462@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 06 Sep 2019 12:43:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/19 4:17 AM, David Howells wrote:
> Eric Sandeen <sandeen@redhat.com> wrote:
> 
>> There doesn't seem to be a strong reason to have another copy of the
>> filesystem name string in the fs_parameter_description structure;
>> it's easy enough to get the name from the fs_type, and using it
>> instead ensures consistency across messages (for example,
>> vfs_parse_fs_param() already uses fc->fs_type->name for the error
>> messages, because it doesn't have the fs_parameter_description).
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> It was put there for fs_validate_description() to use.  That checks both
> filesystem and LSM parameter descriptions.
> 
> We could pass a name in to that function instead.

My patch does exactly that, right?

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..77bf5f95362d 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -74,7 +74,8 @@ int register_filesystem(struct file_system_type * fs)
 	int res = 0;
 	struct file_system_type ** p;
 
-	if (fs->parameters && !fs_validate_description(fs->parameters))
+	if (fs->parameters &&
+	    !fs_validate_description(fs->name, fs->parameters))
 		return -EINVAL;

....

@@ -7021,7 +7020,7 @@ static __init int selinux_init(void)
 	else
 		pr_debug("SELinux:  Starting in permissive mode\n");
 
-	fs_validate_description(&selinux_fs_parameters);
+	fs_validate_description("selinux", &selinux_fs_parameters);
 
 	return 0;
