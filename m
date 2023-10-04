Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FCA7B867E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbjJDR2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 13:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjJDR2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:28:18 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB9A6;
        Wed,  4 Oct 2023 10:28:15 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c760b34d25so18374715ad.3;
        Wed, 04 Oct 2023 10:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440494; x=1697045294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LK6nH29B+DiFq/Dp1LOVmQEn5e8xZV4jVqq1U2i/KY=;
        b=d3cNyMigZLNhhG+JB71gJp6VEGNrHV/19qOfI1goG2vWRlvGeCE3GukhOarH9nox3S
         ceCHsyIZ6xjPtSZriMKaCWjKeRZ96tZleCp3WnXgAvpjAMC6ATDhRvHvcy4CPrrWJWia
         OTf6wBDLG9noK1PLBy61NT+6LDB9EQEjVxIwEZ09g/XLjGWzQPNdoOXdn1GclOVBaKbt
         DYMPSgNylqovUDVRVACHXyFozj7FBQmF7WMNNhliIeYYBNqq0poMlI5ZKltvk9Z4XJ2L
         uFiyDaS0TdHqbQFfcczTWbz1qNOwjAHvQ8nORMT0UX1hAfFsIeXtOO/dY9BRzcySQKfa
         OOcA==
X-Gm-Message-State: AOJu0YzPs04CRzb60vXrj3XAA1vd0kCh0Ih1cNwhy0z219oPcBwlPM8G
        BCqssUugmNDj8u4H1oh5VEQ=
X-Google-Smtp-Source: AGHT+IEzHNMF3cksQjNCwZTYzT4iNYh55MYK+W6HHWMYfKqVCiASNzywosBXOHLZCyqVPviHJVldoA==
X-Received: by 2002:a17:903:26c3:b0:1c5:de65:f8a8 with SMTP id jg3-20020a17090326c300b001c5de65f8a8mr2878682plb.1.1696440494355;
        Wed, 04 Oct 2023 10:28:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001bf11cf2e21sm3947140plz.210.2023.10.04.10.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:28:13 -0700 (PDT)
Message-ID: <776ff7e4-879f-4967-ba46-fd170804a9e0@acm.org>
Date:   Wed, 4 Oct 2023 10:28:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
 <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/3/23 20:00, Martin K. Petersen wrote:
> 
> Bart,
> 
>> also that there are no guarantees that the data written by an 
>> atomic write will survive a power failure. See also the difference 
>> between the NVMe parameters AWUN and AWUPF.
> 
> We only care about *PF. The *N variants were cut from the same cloth 
> as TRIM and UNMAP.

In my opinion there is a contradiction between the above reply and patch
19/21 of this series. Data written with the SCSI WRITE ATOMIC command is
not guaranteed to survive a power failure. The following quote from
SBC-5 makes this clear:

"4.29.2 Atomic write operations that do not complete

If the device server is not able to successfully complete an atomic
write operation (e.g., the command is terminated or aborted), then the
device server shall ensure that none of the LBAs specified by the atomic
write operation have been altered by any logical block data from the
atomic write operation (i.e., the specified LBAs return logical block
data as if the atomic write operation had not occurred).

If a power loss causes loss of logical block data from an atomic write
operation in a volatile write cache that has not yet been stored on the
medium, then the device server shall ensure that none of the LBAs
specified by the atomic write operation have been altered by any logical
block data from the atomic write operation (i.e., the specified LBAs
return logical block data as if the atomic write operation had not
occurred and writes from the cache to the medium preserve the specified
atomicity)."

In other words, if a power failure occurs, SCSI devices are allowed to
discard the data written with a WRITE ATOMIC command if no SYNCHRONIZE
CACHE command has been submitted after that WRITE ATOMIC command or if
the SYNCHRONIZE CACHE command did not complete before the power failure.

Thanks,

Bart.
