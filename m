Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E97BAED7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjJEWgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 18:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjJEWga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:36:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E0E7
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 15:36:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so1055645a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696545387; x=1697150187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2tQ3RBiSUcSSCDIGm1AqxO9GDksjubSbZBBLyz+/c8=;
        b=REhiCFVhABsJ2q1jPxHObTX6y84Tz2iTSR6iSkdrBM8Hsi+tc+MX6HtHS+ktP+h56f
         CvWqHZsqOaXtYLJ1QqEDS2JjQrJ7seEe4+D9rYAvbq5mcoBtjcnc1i/Q3k+IWcDgbAMh
         92TFvO2l/kNKi566QIqjeD+fdcKq7MHxuhbrstbYcm+q/Qq7ifN955l5YyUQkDv+QUlk
         N8A/gM1KmbpnupgOVyklj9vtP5OqW9RSxFLf3uN06GXn4aWhf6OVjziy55LbjINGimYD
         TSInO6f0KTTlV8D6BMo9rgT2MOUGrFtGNxTTfGQCKEVh0q0oum7k5oADeCJWQEos65bH
         ySwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545387; x=1697150187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2tQ3RBiSUcSSCDIGm1AqxO9GDksjubSbZBBLyz+/c8=;
        b=mivSUhc9p4AQbMf34cbRcX6nwbDF385AwBSFMJdEFXYM/x/RGTydFAmOxDqAqWSrx7
         7pN3qGXKXyK2FUA+wfpfscqmxCt67Dt/ou5sWmCh/ULcy3iXE1YavhYxw84pDIHxUowd
         C1WxIv9FYo+UjBXzanf8HnMyY/VBQDlsHYOF7FvGUv2Sh/XxFziTYiuo8ugup3b6/ECs
         HPWFDX/6ySDDCIe77+J+hGCesXXgoebY+BLWIegYcZnGYRz3lvYzTUCOS8t7ABhavBeB
         GM7IL/211Zcq8Jw6385peg/WmPHTq7UNu7lGQNrs5J7+C4qkORKBxWLAnuMK8ynkvgNY
         UQ3w==
X-Gm-Message-State: AOJu0Yy/F4MjwUt9tjgAIis7htg94xhjZTMC23lTrXAaGSN2kNNitQY2
        tieCqdsALsOojmo0PY/DL2MclQ==
X-Google-Smtp-Source: AGHT+IHkj05WtFRnB1/6TCdC5uNJ+qJuxlAMKS08tzhEQ93tj2n+6Zd7zWsUmCjHAtuzu3cQRcYWSg==
X-Received: by 2002:a17:90a:2cc4:b0:271:7cd6:165d with SMTP id n62-20020a17090a2cc400b002717cd6165dmr6401433pjd.26.1696545387428;
        Thu, 05 Oct 2023 15:36:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a005e00b002776350b50dsm4406336pjb.29.2023.10.05.15.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:36:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qoWxD-009xqX-3D;
        Fri, 06 Oct 2023 09:36:24 +1100
Date:   Fri, 6 Oct 2023 09:36:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZR86Z1OcO52a4BtH@dread.disaster.area>
References: <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:10:45AM -0700, Bart Van Assche wrote:
> On 10/4/23 11:17, Martin K. Petersen wrote:
> > 
> > Hi Bart!
> > 
> > > In other words, also for the above example it is guaranteed that
> > > writes of a single logical block (512 bytes) are atomic, no matter
> > > what value is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.
> > 
> > There is no formal guarantee that a disk drive sector read-modify-write
> > operation results in a readable sector after a power failure. We have
> > definitely seen blocks being mangled in the field.
> 
> Aren't block devices expected to use a capacitor that provides enough
> power to handle power failures cleanly?

Nope.

Any block device that says it operates in writeback cache mode (i.e.
almost every single consumer SATA and NVMe drive ever made) has a
volatile write back cache and so does not provide any power fail
data integrity guarantees. Simple to check, my less-than-1-yr-old
workstation tells me:

$ lspci |grep -i nvme
03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
$ cat /sys/block/nvme*n1/queue/write_cache
write back
write back
$

That they have volatile writeback caches....

> How about blacklisting block devices that mangle blocks if a power
> failure occurs? I think such block devices are not compatible with
> journaling filesystems nor with log-structured filesystems.

Statements like this from people working on storage hardware really
worry me. It demonstrates a lack of understanding of how filesystems
actually work, not to mention the fact that this architectural
problem (i.e. handling volatile device write caches correctly) was
solved in the Linux IO stack a couple of decades ago. This isn't
even 'state of the art' knowledge - this is foundational knowlege
that everyone working on storage should know.

The tl;dr summary is that filesystems will issue a cache flush
request (REQ_PREFLUSH) and/or write-through to stable storage
semantics (REQ_FUA) for any data, metadata or journal IO that has
data integrity and/or ordering requirements associated with it. The
block layer will then do the most optimal correct thing with that
request (e.g. ignore them for IO being directed at WC disabled
devices), but it guarantees the flush/fua semantics for those IOs
will be provided by all layers in the stack right down to the
persistent storage media itself. Hence all the filesystem has to do
is get it's IO and cache flush ordering correct, and everything
just works regardless of the underlying storage capabilities.

And, yes, any storage device with volatile caches that doesn't
implement cache flushes correctly is considered broken and will get
black listed....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
