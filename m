Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB166D78D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjAQIIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjAQIIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC71279B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 00:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673942872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHTUsi4Kd9KdcBjg+BxR2hXsDjFiOFOUW1pZ4fdQ8n0=;
        b=RGXEfvm6vvJLv6/3f5WjH9Lzo1nCwl5zlRpR4hE9Qo/gjF6BlWjCenJXHDJ8Hb+5PBAW8k
        wTBaqW3/lCjW6YrAQhSGH8MIlzu1tSNJUYm3f6ETGCmW9AZdqKu2NcJ5uuGYzbRhjPSqVX
        rGrzbIFXEzbOhRrvoAAaukJ9LAlFtSk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-NXKA0TW5OtOU5NB0mkH-XA-1; Tue, 17 Jan 2023 03:07:51 -0500
X-MC-Unique: NXKA0TW5OtOU5NB0mkH-XA-1
Received: by mail-wm1-f72.google.com with SMTP id l23-20020a7bc457000000b003db0cb8e543so6526wmi.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 00:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHTUsi4Kd9KdcBjg+BxR2hXsDjFiOFOUW1pZ4fdQ8n0=;
        b=IGRiasib4Co+5VEuttRjpLqE+QGP3zMBclSp8A5VNiukQJRFeBRnTNS/gs8Fg2ffiR
         vulREDtaHJgvPZwVLZr9FP8nHRbhG1NavaD7tKpKOSn6faaYzX0Ze2eOqRPLX0mRziYR
         nJRqGTSSur2sbDayEonc0hgmc8xycS10SU1GwBrvaCP3qn8lfGYQRi32IZd2R7PfWCs/
         mHhwaOE2gHH3dVZM9oXQ9RUVU6ujQjOKlXeA2oyhQzzXcss3mAuEDqFas1+U6IK4Lo09
         pGCRjcrI3JVZAbL912lIiGKqjTJuLHViVZnlt8hAvyaGxgW9tmygfYWoy+6krSxGD/YP
         7+3A==
X-Gm-Message-State: AFqh2krKCV+PCkmOT8IwdbzWL5LUE1PPTGIqciZ9jEqReHsdB4IqJJ40
        HojIkzE6MeY4iax+UQTmCHiN+xe7/ycKLKOUmW1GU1H9fmwjO1RQS1/8EZJUD+UyibUOO+rLfvc
        xQBPOWzkW2d6wsUY4wC8d88gFcQ==
X-Received: by 2002:a05:600c:35d0:b0:3db:c4c:9224 with SMTP id r16-20020a05600c35d000b003db0c4c9224mr267290wmq.3.1673942870026;
        Tue, 17 Jan 2023 00:07:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsrQsShhdpEwzPezLsOASWXQKEy0oVIg3RStgySPZly5QWvqSJPGTqxSrAKNnSZHfcr2FdLvg==
X-Received: by 2002:a05:600c:35d0:b0:3db:c4c:9224 with SMTP id r16-20020a05600c35d000b003db0c4c9224mr267266wmq.3.1673942869664;
        Tue, 17 Jan 2023 00:07:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:f00:323e:5956:8da1:9237? (p200300cbc7080f00323e59568da19237.dip0.t-ipconnect.de. [2003:cb:c708:f00:323e:5956:8da1:9237])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003d99da8d30asm40320669wmh.46.2023.01.17.00.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:07:49 -0800 (PST)
Message-ID: <3515368f-d622-f7d2-5854-9503d4a19fb2@redhat.com>
Date:   Tue, 17 Jan 2023 09:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <Y8ZU1Jjx5VSetvOn@infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
In-Reply-To: <Y8ZU1Jjx5VSetvOn@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.01.23 08:57, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 11:08:24PM +0000, David Howells wrote:
>> Define FOLL_SOURCE_BUF and FOLL_DEST_BUF to indicate to get_user_pages*()
>> and iov_iter_get_pages*() how the buffer is intended to be used in an I/O
>> operation.  Don't use READ and WRITE as a read I/O writes to memory and
>> vice versa - which causes confusion.
>>
>> The direction is checked against the iterator's data_source.
> 
> Why can't we use the existing FOLL_WRITE?

Agreed. What I understand, David considers that confusing when 
considering the I/O side of things.

I recall that there is

DMA_BIDIRECTIONAL -> FOLL_WRITE
DMA_TO_DEVICE -> !FOLL_WRITE
DMA_FROM_DEVICE -> FOLL_WRITE

that used different defines for a different API. Such terminology would 
be easier to get ... but then, again, not sure if we really need 
acronyms here.

We're pinning pages and FOLL_WRITE defines how we (pinning the page) are 
going to access these pages: R/O or R/W. So the read vs. write is never 
from the POC of the device (DMA read will write to the page).

-- 
Thanks,

David / dhildenb

