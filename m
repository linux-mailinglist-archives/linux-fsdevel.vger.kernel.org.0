Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C07B259F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI1TB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjI1TB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB7E199
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695927643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sYeSXBF9ox8JewI5CgNTTLRvL8aO3BLx9jhzfMOKFj4=;
        b=Z12cDymAbTrp3C4MnW235jQxzK1QFF0CmW1ywiid7w5F6LLZPLJO5XhlMf0viZrWIdJvst
        6HvoJ+0XmNbDpoeeRrFG5fb8+OkzvxzoM3YuYDl7fv8BtyHd4rbAcBa1WVg74R61/2ekBG
        zQs8uYGsN49dny5w05S33LBlcdaZg94=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Wel4Ekd6OiqN_hnalvQFVQ-1; Thu, 28 Sep 2023 15:00:41 -0400
X-MC-Unique: Wel4Ekd6OiqN_hnalvQFVQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65623d0075aso44773326d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 12:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695927640; x=1696532440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYeSXBF9ox8JewI5CgNTTLRvL8aO3BLx9jhzfMOKFj4=;
        b=LqvQ/zec6ikyK+XYq5zC/Z5PcOW08JF6K6slwVlP/RIBThXNmfhmPjkWmo+SmQ2aPd
         NyZKJMXCDV/bQxedAQAJ52k3xN8VVhTzF+03J72dubakm+dzoBFDRH03w8uW6pqCnMmc
         faw4fiSAP4wz30tT8bSsdQTtaASy/xamZ/hZ/p52YaaS8GNRElrFcJz26Ok8iZE+suCJ
         0PqQlJruXdmbEuGVgMZaJmL18+tJtRdtPyHPH5U/uPYISgqb6sCX1RxD04QEXgdrUgBz
         ZI0AxgTVRRCFoqp9kL/Gqqbdxt6OI0DGdZVzWktyyT5yAZtfzTssxqWWXdU458ZaGFIy
         ikqg==
X-Gm-Message-State: AOJu0Yz/BBp/+DK66cqbLxktyW98gKI+nL62+hVFKnqoyqQa4r951qxc
        4EzH/6ImMBmQYCf4ClA5ETlzzF1yggAxLuL1mtF1NOc8XsO4tRqHsx2ZGrWGc5igXjC6qosG9EE
        ++B0chHZGDbo7oPJ1s+zaZbdtQQ==
X-Received: by 2002:a05:6214:509b:b0:65d:482:9989 with SMTP id kk27-20020a056214509b00b0065d04829989mr2048544qvb.5.1695927640389;
        Thu, 28 Sep 2023 12:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3uis8ZcMwGkA2LhfKt3i7NAV8nmQaJXoWJnDpIdTIO5n+q2tK4lmY4mR5a342HyQijvEuHQ==
X-Received: by 2002:a05:6214:509b:b0:65d:482:9989 with SMTP id kk27-20020a056214509b00b0065d04829989mr2048511qvb.5.1695927639908;
        Thu, 28 Sep 2023 12:00:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id k13-20020a0cb24d000000b0065862497fd2sm3723831qve.22.2023.09.28.12.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:00:39 -0700 (PDT)
Date:   Thu, 28 Sep 2023 15:00:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRXNVGI73SfX1lu4@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
 <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:15:13PM +0200, David Hildenbrand wrote:
> There are some interesting questions to ask here:
> 
> 1) What happens if the old VMA has VM_SOFTDIRTY set but the new one not? You
> most probably have to mark the PTE softdirty and not make it writable.

I don't know whether anyone would care about soft-dirty used with uffd
remap, but if to think about it..

Logically if the dst vma has !SOFTDIRTY (means, soft-dirty tracking
enabled), then IIUC the right thing to do is to assume this page is
modified, hence mark softdirty and perhaps proceed with other checks (where
write bit can be set if all check pass)?

Because from a soft-dirty monitor POV on dst_vma I see this REMAP the same
as writting data onto the missing page and got a page fault
(e.g. UFFDIO_COPY); we just avoided the allocation and copy.

The src vma seems also fine in this regard: soft-dirty should ignore holes
always anyway (e.g. DONTNEED on a page should report !soft-dirty later even
if tracking).

> 
> 2) VM_UFFD_WP requires similar care I assume? Peter might know.

UFFD_WP shouldn't be affected, iiuc.

Let's first discuss dst vma side.

WP_UNPOPULATED made it slightly complicated but not so much.  The core
should be that REMAP only installs pages if it's exactly pte_none():

+       if (!pte_none(orig_dst_pte)) {
+               err = -EEXIST;
+               goto out;
+       }

Then it already covers things like pte markers, and any marker currently
will fail the REMAP ioctl already.  May not be always wanted, but no risk
of losing wp notifications.  If that'll be a valid use case we can work it
out.

On src vma, REMAP ioctl should behave the same as DONTNEED.  Now we drop
the src pte along with the uffd-wp bit even if set, which is the correct
behavior from that regard.

Again, I don't know whether anyone cares on any of those, though..

Thanks,

-- 
Peter Xu

