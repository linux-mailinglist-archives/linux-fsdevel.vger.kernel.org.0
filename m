Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD34352BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 20:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJTShT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 14:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230439AbhJTShT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634754903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aeukl9o1mQa0vBSaLfqExmVWFB9CghqbZ+i9cfAIriM=;
        b=eUXis5ds3DgAw0UbGIo1qOwrYOpGu4ExH+QiSd7wVGlImycopeVlLWoCsOpwu/C288Uo9S
        Gt9TXDdpM+n2HZ22KJK/rEy3tLOqkEs+6LE8f2yLeUpVLD2En+p75Zvd7ciTsRnauMvdyw
        ga4RvcYtGaGB4ieTEF6v6HfNhzBdTlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-NUcknzBGM6i9VG9QagGUaw-1; Wed, 20 Oct 2021 14:35:00 -0400
X-MC-Unique: NUcknzBGM6i9VG9QagGUaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B898112A6A0;
        Wed, 20 Oct 2021 18:34:59 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEABE18352;
        Wed, 20 Oct 2021 18:34:58 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
        <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
        <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 20 Oct 2021 14:37:03 -0400
In-Reply-To: <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk> (Jens Axboe's
        message of "Wed, 20 Oct 2021 12:21:55 -0600")
Message-ID: <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/20/21 12:16 PM, Jeff Moyer wrote:
>> Hi, Jens,
>> 
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> It's not used for anything, and we're wasting time passing in zeroes
>>> where we could just ignore it instead. Update all ki_complete users in
>>> the kernel to drop that last argument.
>> 
>> What does "wasting time passing in zeroes" mean?
>
> That everybody but the funky usb gadget code passes in zero, hence it's
> a waste of time to pass it in as an argument.

OK.  Just making sure you hadn't found some performance gain from this.
:)

>> We can't know whether some userspace implementation relies on this
>> behavior, so I don't think you can change it.
>
> Well, I think we should find out, particularly as it's the sole user of
> that extra argument.

How can we find out?  Anyone can write userspace usb gadget code.  Some
of those users may be proprietary.  Is that likely?  I don't know.  I'd
rather err on the side of not (potentially) breaking existing
applications, though.

> No generic aio code would look at res2, exactly because it is always
> zero for anything but some weird usb gadget code.

I think that no generic code looks at it because it isn't meant to be
interpreted by generic code.  :)

-Jeff

