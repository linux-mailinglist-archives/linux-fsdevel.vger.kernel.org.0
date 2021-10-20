Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DE4353FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 21:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhJTTr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 15:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231585AbhJTTrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634759140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvnJToiDKtLuWaVJP4UyY1x19xRlQS82A6Py4LuPY6c=;
        b=QnxYDnrgm0pqyqBUeFfCoqu6u5TtCJ+BtORD4Qk2Dnzoq72OKddEhhWzjhYWzfzzW/KyOV
        B/OgNSOZH1gFzuLvuLOJdsThGiTXVLBIi5FITmYsJO8mXWPwdzzoNgfYm+9g40jLbk6J9P
        fXBkMJnKM02+1IAm0jtQEWuMKn9bmaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-OEZZYDpMM4mBapiGRFMaXQ-1; Wed, 20 Oct 2021 15:45:39 -0400
X-MC-Unique: OEZZYDpMM4mBapiGRFMaXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 583C21018738;
        Wed, 20 Oct 2021 19:45:38 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE5A91980E;
        Wed, 20 Oct 2021 19:45:37 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
        <x498ryno93g.fsf@segfault.boston.devel.redhat.com>
        <16a7a029-0d23-6a14-9ae9-79ab8a9adb34@kernel.dk>
        <x494k9bo84w.fsf@segfault.boston.devel.redhat.com>
        <80244d5b-692c-35ac-e468-2581ff869395@kernel.dk>
        <8f5fdbbf-dc66-fabe-db3b-01b2085083b0@kernel.dk>
        <x49zgr3mrzs.fsf@segfault.boston.devel.redhat.com>
        <a60158d1-6ee0-6229-dc62-19ec40674585@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 20 Oct 2021 15:47:43 -0400
In-Reply-To: <a60158d1-6ee0-6229-dc62-19ec40674585@kernel.dk> (Jens Axboe's
        message of "Wed, 20 Oct 2021 13:12:02 -0600")
Message-ID: <x49v91rmqao.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/20/21 1:11 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> On 10/20/21 12:41 PM, Jens Axboe wrote:
>>>> Working on just changing it to a 64-bit type instead, then we can pass
>>>> in both at once with res2 being the upper 32 bits. That'll keep the same
>>>> API on the aio side.
>>>
>>> Here's that as an incremental. Since we can only be passing in 32-bits
>>> anyway across 32/64-bit, we can just make it an explicit 64-bit instead.
>>> This generates the same code on 64-bit for calling ->ki_complete, and we
>>> can trivially ignore the usb gadget issue as we now can pass in both
>>> values (and fill them in on the aio side).
>> 
>> Yeah, I think that should work.
>
> Passed test and allmodconfig sanity check, sent out as v2 :)

It passed the libaio tests on x64.  I'll do some more testing and review
the v2 posting.

Thanks!
Jeff

