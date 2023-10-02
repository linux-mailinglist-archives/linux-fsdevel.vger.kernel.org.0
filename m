Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303037B5AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjJBTM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbjJBTM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:12:56 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2FC9;
        Mon,  2 Oct 2023 12:12:52 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3af603da0f0so69170b6e.3;
        Mon, 02 Oct 2023 12:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273972; x=1696878772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUdRRJDEOEUkLfFy9sPy2x/dfu57//lkDWppt3CgCr0=;
        b=POUAI3nH/ATN8nxSyfkeanTklP+0FQKReRaRF4qD8X4PoZ6eKRfV/KZMLAup1P3yTl
         gGqaI0w8luGRdM4k8tIMxufzgreqRPchnetFqn5qooNVYGQUKvVJ2yBH0Yf0a3Ro/jPs
         aIbryfGYXyA29WOBG1mObNAr3whIyLVdVXYsj1yJeRCOmQJeEtRbm3cizVtQGxF029YB
         +v7a7O7d9UFQ3fm1t+PQoHBnABzj68IuYHfVlMkrNXJPL8Hy0LBsDvPibm30k16zUf6D
         KozoWv41MOJ2pRNi20gLhPMoqpSOHlHK3vz5xAfhZZ/jaPXgGateCmIs6PCGzBOlIWyP
         WnSw==
X-Gm-Message-State: AOJu0Yz1kdLOTGYCxBYu2M1+r2WMOXK/Zc39uMwnQsgKZ0vr7nBkBZCE
        7lS8byRfes8Vms2Fx4HaS68=
X-Google-Smtp-Source: AGHT+IH0PK11dn6H63Mr8RpWcPoILY0OrFw4a9OhWFOW8KKCEwPGNLXzRWfSUSCL5bhxshAKSBIzhQ==
X-Received: by 2002:aca:1911:0:b0:3a7:aabc:738f with SMTP id l17-20020aca1911000000b003a7aabc738fmr11881935oii.39.1696273971928;
        Mon, 02 Oct 2023 12:12:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id p4-20020a637f44000000b005637030d00csm19436115pgn.30.2023.10.02.12.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:12:51 -0700 (PDT)
Message-ID: <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
Date:   Mon, 2 Oct 2023 12:12:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 03:10, John Garry wrote:
> On 29/09/2023 18:51, Bart Van Assche wrote:
>> On 9/29/23 03:27, John Garry wrote:
>  > +    if (pos % atomic_write_unit_min_bytes)
>  > +        return false;
> 
> See later rules.

Is atomic_write_unit_min_bytes always equal to the logical block size?
If so, can the above test be left out?

>  > +    if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
>  > +        return false;
> 
> For SCSI, there is an atomic write granularity, which dictates 
> atomic_write_unit_min_bytes. So here we need to ensure that the length 
> is a multiple of this value.

Are there any SCSI devices that we care about that report an ATOMIC 
TRANSFER LENGTH GRANULARITY that is larger than a single logical block?
I'm wondering whether we really have to support such devices.

>  > +    if (!is_power_of_2(iov_iter_count(iter)))
>  > +        return false;
> 
> This rule comes from FS block alignment and NVMe atomic boundary.
> 
> FSes (XFS) have discontiguous extents. We need to ensure that an atomic 
> write does not cross discontiguous extents. To do this we ensure extent 
> length and alignment and limit atomic_write_unit_max_bytes to that.
> 
> For NVMe, an atomic write boundary is a boundary in LBA space which an 
> atomic write should not cross. We limit atomic_write_unit_max_bytes such 
> that it is evenly divisible into this atomic write boundary.
> 
> To ensure that the write does not cross these alignment boundaries we 
> say that it must be naturally aligned and a power-of-2 in length.
> 
> We may be able to relax this rule but I am not sure it buys us anything 
> - typically we want to be writing a 64KB block aligned to 64KB, for 
> example.

It seems to me that the requirement is_power_of_2(iov_iter_count(iter))
is necessary for some filesystems but not for all filesystems. 
Restrictions that are specific to a single filesystem (XFS) should not 
occur in code that is intended to be used by all filesystems 
(blkdev_atomic_write_valid()).

Thanks,

Bart.

