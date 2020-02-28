Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B67E173B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgB1PcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:32:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33257 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727009AbgB1PcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582903934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bvw4EKIq7Nz96iliNwe+sYPmeB2MxKGQA5tmOw0Z4RU=;
        b=e4qoeDNugewOs2BzpMKD1l1eGuHpTjCRs8FQXjFMOIV3seKs1ErToZPmLrbsHO0DAsIKyG
        OKiFHGs2AnnuwsMRsM4zyKhmLH5NPDs5clDZG1JtJTRxO9x4WRP8Nrd+GvyT01oEpzM8uP
        EZpxo8kf4ui7Y7o9yLxD7zc8ssUHUeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-ajKGKpX8OVSU15sG2IeCPA-1; Fri, 28 Feb 2020 10:32:10 -0500
X-MC-Unique: ajKGKpX8OVSU15sG2IeCPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0043107B7D8;
        Fri, 28 Feb 2020 15:32:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-107.rdu2.redhat.com [10.10.123.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72E28101D481;
        Fri, 28 Feb 2020 15:32:03 +0000 (UTC)
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
To:     Matthew Wilcox <willy@infradead.org>, Ian Kent <raven@themaw.net>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
 <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
 <20200228033412.GD29971@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e8730c5e-6610-f25a-f1cc-9d4ffffe0eb5@redhat.com>
Date:   Fri, 28 Feb 2020 10:32:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200228033412.GD29971@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/20 10:34 PM, Matthew Wilcox wrote:
> On Thu, Feb 27, 2020 at 05:55:43PM +0800, Ian Kent wrote:
>> Not all file systems even produce negative hashed dentries.
>>
>> The most beneficial use of them is to improve performance of rapid
>> fire lookups for non-existent names. Longer lived negative hashed
>> dentries don't give much benefit at all unless they suddenly have
>> lots of hits and that would cost a single allocation on the first
>> lookup if the dentry ttl expired and the dentry discarded.
>>
>> A ttl (say jiffies) set at appropriate times could be a better
>> choice all round, no sysctl values at all.
> The canonical argument in favour of negative dentries is to improve
> application startup time as every application searches the library path
> for the same libraries.  Only they don't do that any more:
>
> $ strace -e file cat /dev/null
> execve("/bin/cat", ["cat", "/dev/null"], 0x7ffd5f7ddda8 /* 44 vars */) = 0
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/dev/null", O_RDONLY) = 3
>
> So, are they still useful?  Or should we, say, keep at most 100 around?
>
It is the shell that does the path search, not the command itself.

Cheers,
Longman

