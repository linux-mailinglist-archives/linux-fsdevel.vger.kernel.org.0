Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913EE29EE22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 15:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgJ2OZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 10:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgJ2OZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603981520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A22khVtnKHqmoKyRs3jDxVOuQ05VtVhowd5o0DD3mL4=;
        b=e/uDJYBS9PL8i6ch5VHIXzOEzW9ZWJGZEHDKzWPJ1zGqTzpurtn9Njvl0iq56MELw6u0DD
        lz6xsRmjjcY0uZnaj5hmSPyC5CtLCCXYkkT7bOTtaH6iczELIrGYsNNhLU9HYkQ66NAjHg
        pdOZvnwBylrbN4eFyjQTi21saIIJeKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-uboe4UJLMa-Y0qxMm_OClQ-1; Thu, 29 Oct 2020 10:25:16 -0400
X-MC-Unique: uboe4UJLMa-Y0qxMm_OClQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87BC3108E1B2;
        Thu, 29 Oct 2020 14:25:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-17.rdu2.redhat.com [10.10.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F241F1002C05;
        Thu, 29 Oct 2020 14:25:10 +0000 (UTC)
Subject: Re: [PATCH] inotify: Increase default inotify.max_user_watches limit
 to 1048576
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca BRUNO <lucab@redhat.com>
References: <20201026204418.23197-1-longman@redhat.com>
 <20201027160012.GE16090@quack2.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <627e1342-a691-e8bc-0e09-f0ffd295f570@redhat.com>
Date:   Thu, 29 Oct 2020 10:25:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20201027160012.GE16090@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/27/20 12:00 PM, Jan Kara wrote:
> On Mon 26-10-20 16:44:18, Waiman Long wrote:
>> The default value of inotify.max_user_watches sysctl parameter was set
>> to 8192 since the introduction of the inotify feature in 2005 by
>> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
>> small for many modern usage. As a result, users have to explicitly set
>> it to a larger value to make it work.
>>
>> After some searching around the web, these are the
>> inotify.max_user_watches values used by some projects:
>>   - vscode:  524288
>>   - dropbox support: 100000
>>   - users on stackexchange: 12228
>>   - lsyncd user: 2000000
>>   - code42 support: 1048576
>>   - monodevelop: 16384
>>   - tectonic: 524288
>>   - openshift origin: 65536
>>
>> Each watch point adds an inotify_inode_mark structure to an inode to be
>> watched. Modeled after the epoll.max_user_watches behavior to adjust the
>> default value according to the amount of addressable memory available,
>> make inotify.max_user_watches behave in a similar way to make it use
>> no more than 1% of addressable memory within the range [8192, 1048576].
>>
>> For 64-bit archs, inotify_inode_mark should have a size of 80 bytes. That
>> means a system with 8GB or more memory will have the maximum value of
>> 1048576 for inotify.max_user_watches. This default should be big enough
>> for most of the use cases.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> So I agree that 8192 watches seem to be a bit low today but what you
> propose seems to be way too much to me. OTOH I agree that having to tune
> this manually kind of sucks so I'm for auto-tuning of the default. If the
> computation takes into account the fact that a watch pins an inode as Amir
> properly notes (that's the main reason why the number of watches is
> limited), I think limiting to 1% of pinned memory should be bearable. The
> amount of space pinned by an inode is impossible to estimate exactly
> (differs for different filesystems) but about 1k for one inode is a sound
> estimate IMO.
>
> 								Honza

I will certainly do that. Will send out a v2 soon.

Cheers,
Longman

