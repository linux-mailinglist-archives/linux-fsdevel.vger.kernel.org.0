Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A404769BDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjGaQHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGaQHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843F91BE5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690819551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fe8D0HOECGyB0VhAiINFzMU/ctaZGX42+I+MeNC1CcY=;
        b=GqENVWfKWL4tK4wJVZUbc/8EdC/ldh9hyViAs3ZhamGEClx1cwKTBFjCnK4qgoHsWii26j
        HLkF4wQx4yVcJnCvXfBfNKDw7n/O7OjdP9mACWqKZKCU6RAWTHdXVzbCZKYErAYszA9uwA
        V+cGSKXoV9xcdtklTPTrZYim/DujzZ8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-CPJ8OJ1fNZSlMOQNSEMh8g-1; Mon, 31 Jul 2023 12:05:50 -0400
X-MC-Unique: CPJ8OJ1fNZSlMOQNSEMh8g-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56cd4dbd6c4so120953eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 09:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690819548; x=1691424348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe8D0HOECGyB0VhAiINFzMU/ctaZGX42+I+MeNC1CcY=;
        b=N12AHlbW2/gJMDsb6AR+jVc8BVRqzcVAkGXNeJaOLtJ6sO4ydKb60QVRMbqcOv6hEt
         ynvC3o0ayoggsKGzsv0f9P4TjVBKgMRuLjJ5XLlVaYiVxgfKS+vkVLK2PkvnaHZ+YAIQ
         7S6+/Uc4teHDexvYOcsCkZz6Vb37WEB883mlAhoLY+V8wOo3pcC6N7gTTu0OG2XFWKfv
         gNRY+XMcQuqApdCKNmUxcGsqX+iGpDHT1UZ2+dZNyJh4Qnz1Ir555V9E026QoWofxEDS
         7F89ac02bmAH/Qmv3Td8rCmfcg8rMLZbXLoBtTAm0gX+iZKheqZJzEHS/rbxNpelsv5r
         8Dmg==
X-Gm-Message-State: ABy/qLa5GZNU9heyFYFfCHzJtI2JrORiYA3fmXN37Kf3ojsVonM/Ay2v
        6SS/f0UhVA3mEHGvrdovxj6msTvyIKzzfzGjCFUrU1Tl+M/oxhh/m5r1tzpbkyDegBppkZ74hf7
        PgtTqYTNRRzfYnTMZOssWb6lXHA==
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id d5-20020a4aa585000000b0056c484a923dmr5539747oom.1.1690819548648;
        Mon, 31 Jul 2023 09:05:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhq1hLxxabjktwI+EJsrtIcmAgGCaTSDKURV9TulXm5uBMFY0f/5Fv0jVzE69294Gd73pQkQ==
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id d5-20020a4aa585000000b0056c484a923dmr5539724oom.1.1690819548353;
        Mon, 31 Jul 2023 09:05:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p15-20020a0ccb8f000000b0063d06253995sm3820825qvk.22.2023.07.31.09.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:05:47 -0700 (PDT)
Date:   Mon, 31 Jul 2023 12:05:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMfbz2JFKvAkaKg8@x1n>
References: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
 <ZMQxNzDcYTQRjWNh@x1n>
 <edd9b468-2d60-1df7-a515-22475fd94fe2@nvidia.com>
 <ZMQ32RRJlW/aDYAE@x1n>
 <118e571c-a79f-5020-b9fd-4c0a3722236d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <118e571c-a79f-5020-b9fd-4c0a3722236d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 03:00:04PM -0700, John Hubbard wrote:
> On 7/28/23 14:49, Peter Xu wrote:
> > > The story of how FOLL_NUMA and FOLL_FORCE became entangled was enlightening,
> > > by the way, and now that I've read it I don't want to go back. :)
> > 
> > Yeah I fully agree we should hopefully remove the NUMA / FORCE
> > tangling.. even if we want to revert back to the FOLL_NUMA flag we may want
> > to not revive that specific part.  I had a feeling that we're all on the
> > same page there.
> > 
> 
> Yes, I think so. :)
> 
> > It's more about the further step to make FOLL_NUMA opt-in for GUP.
> 
> Let's say "FOLL_HONOR_NUMA_FAULT" for this next discussion, but yes. So
> given that our API allows passing in FOLL_ flags, I don't understand the
> objection to letting different callers pass in, or not pass in, that
> flag.
> 
> It's the perfect way to clean up the whole thing. As Linus suggested
> slightly earlier here, there can be a comment at the call site,
> explaining why KVM needs FOLL_HONOR_NUMA_FAULT, and you're good, right?

I'm good even if we want to experiment anything, as long as (at least) kvm
is all covered then I'm not against it, not yet strongly.

But again, IMHO we're not only talking about "cleaning up" of any flag - if
that falls into "cleanup" first, which I'm not 100% sure yet - we're
takling about changing GUP abi.  What I wanted to point out to be careful
is we're literally changing the GUP abi for all kernel modules on numa
implications.

Thanks,

-- 
Peter Xu

