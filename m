Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9E16FC80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 11:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBZKvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 05:51:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726679AbgBZKvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582714270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIx6zuwqR++Y3FFjikNlSkaH8sZ2FNTsX9QKVbo0PI8=;
        b=hXCOIj/3J3F5VJaUeheaOEUZOQzmPKruWZNTKEyS30DEzPu+tWr9LkjYK+LKEbTl0Qe7E4
        98B8rRQoS0nCxAePM5jY1y6l4tNfOR69cupMbmI9+PQlRNMKy7j21JUuPdjpaiyG+l1l8E
        JItw7DGwNB0X+x/RA3aZxtsxAfpCIbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-uxeWjtzYOB67Z4LxYrMwyg-1; Wed, 26 Feb 2020 05:51:08 -0500
X-MC-Unique: uxeWjtzYOB67Z4LxYrMwyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31F3318B642C;
        Wed, 26 Feb 2020 10:51:06 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 900595DA2C;
        Wed, 26 Feb 2020 10:51:02 +0000 (UTC)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com>
 <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <39284de5-8eb8-ba1d-7ea6-be9b9b5df42c@redhat.com>
Date:   Wed, 26 Feb 2020 10:51:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 26/02/2020 09:11, Miklos Szeredi wrote:
> On Tue, Feb 25, 2020 at 4:29 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>
>> The other thing a file descriptor does that sysfs doesn't is that it
>> solves the information leak: if I'm in a mount namespace that has no
>> access to certain mounts, I can't fspick them and thus I can't see the
>> information.  By default, with sysfs I can.
> That's true, but procfs/sysfs has to deal with various namespacing
> issues anyway.  If this is just about hiding a number of entries, then
> I don't think that's going to be a big deal.
>
> The syscall API is efficient: single syscall per query instead of
> several, no parsing necessary.
>
> However, it is difficult to extend, because the ABI must be updated,
> possibly libc and util-linux also, so that scripts can also consume
> the new parameter.  With the sysfs approach only the kernel needs to
> be updated, and possibly only the filesystem code, not even the VFS.
>
> So I think the question comes down to:  do we need a highly efficient
> way to query the superblock parameters all at once, or not?
>
> Thanks,
> Miklos
>

That is Ian's use case for autofs I think, and it will also be what is 
needed at start up of most applications using the fs notifications, as 
well as at resync time if there has been an overrun leading to lost fs 
notification messages. We do need a solution that can scale to large 
numbers of mounts efficiently. Being able to extend it is also an 
important consideration too, so hopefully David has a solution to that,

Steve.


