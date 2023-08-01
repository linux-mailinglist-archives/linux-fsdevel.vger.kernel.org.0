Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028576BAD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjHARKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjHARK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6FB26B6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690909695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHJDHQhMPESpDTCc7d6m6CZ7cgDoS6a5SZpOnu6DMTE=;
        b=Gd/2ejWwUWBBD39ftmmWlwskBg46B6g75Q/KwKsOp3re49V+cOHgG7m+3cjQWeUKCO+03g
        zeE6OQLlskld67wSEbLLp3gkxx6b3EDEmAF3T826Nv1/Xi+CI5H/gBcb3ivcKM868bvTPB
        yUfBiSfhIWHdERhQ+v9vQo32Xv4GCA4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-EC2oBIfLOtWePQZQ6GVBpg-1; Tue, 01 Aug 2023 13:05:04 -0400
X-MC-Unique: EC2oBIfLOtWePQZQ6GVBpg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4054266d0beso13660511cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 10:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909504; x=1691514304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHJDHQhMPESpDTCc7d6m6CZ7cgDoS6a5SZpOnu6DMTE=;
        b=XWNtedwOUPPmfS23dABDVIFv9kwXfq/McZ2p4acRqBLAOqW6eyW7TTHi/QTkojq851
         ZaOxcnYHMELrkZNfmDet046Paojp3Aq0Yc4sQ4gv8YTi2anJytJQiGQ6uJsmljv6/28t
         AjdwOsY3J2tkEIIuDW84aB/GBsXIqSttzsZazwZ90OjKEjda3Q555HIZDIfXWFNijbeK
         wGsmpv/OJZW4znrcJxyu42ahED/G1C9W4NbFsUMF47ShXm8Ql8Hb1NvnS8q/r0dKJeDu
         CSXMiP/QJRIBVRvtfRKGOQi+hxyu9z6XWtnnTzITXHvn05sv1MxPFZnWzwl6GjPxMlj8
         axPA==
X-Gm-Message-State: ABy/qLYZYNskX4UZ4HGGLVICo7WNK89hOBcPjxaneiSG4fizHT7r1iSy
        1yMLUBED3KFLEYJrZ6VZqBDdlR6NujAPNzpjgFZaeDMchEfaq7MBidyQ8BvRvlnHes/PMbDYkn1
        bPiwJf2Sxjd0EbfhMZqJQMnc9eA==
X-Received: by 2002:ad4:5b83:0:b0:63c:f5fd:d30f with SMTP id 3-20020ad45b83000000b0063cf5fdd30fmr13776746qvp.1.1690909504497;
        Tue, 01 Aug 2023 10:05:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaaBdvX372gnIc+hqJabCioknXLsWVusS1Xd1tIAYtUq1mP4VO3uaCM3OMaXWQ6+iPT5cVCQ==
X-Received: by 2002:ad4:5b83:0:b0:63c:f5fd:d30f with SMTP id 3-20020ad45b83000000b0063cf5fdd30fmr13776714qvp.1.1690909504219;
        Tue, 01 Aug 2023 10:05:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id e30-20020a0caa5e000000b0063d10086876sm4807945qvb.115.2023.08.01.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:05:03 -0700 (PDT)
Date:   Tue, 1 Aug 2023 13:04:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Message-ID: <ZMk7MqApTDZXzwKX@x1n>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com>
 <ZMkpM95vdc9wgs9T@x1n>
 <30d86a2d-4af2-d840-91be-2e68c73a07bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30d86a2d-4af2-d840-91be-2e68c73a07bd@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 06:15:48PM +0200, David Hildenbrand wrote:
> On 01.08.23 17:48, Peter Xu wrote:
> > On Tue, Aug 01, 2023 at 02:48:37PM +0200, David Hildenbrand wrote:
> > > @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
> > >   		gup_flags |= FOLL_UNLOCKABLE;
> > >   	}
> > > +	/*
> > > +	 * For now, always trigger NUMA hinting faults. Some GUP users like
> > > +	 * KVM really require it to benefit from autonuma.
> > > +	 */
> > > +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
> > 
> > Since at it, do we want to not set it for FOLL_REMOTE, which still sounds
> > like a good thing to have?
> 
> I thought about that, but decided against making that patch here more
> complicated to eventually rip it again all out in #4.

I thought that was the whole point of having patch 4 separate, because we
should assume patch 4 may not exist in (at least) some trees, so I ignored
patch 4 when commenting here, and we should not assume it's destined to be
removed here.

> 
> I fully agree that FOLL_REMOTE does not make too much sense, but let's
> rather keep it simple for this patch.

It's fine - I suppose this patch fixes whatever we're aware of that's
broken with FOLL_NUMA's removal, so it can even be anything on top when
needed.  I assume I'm happy to ack this with/without that change, then:

Acked-by: Peter Xu <peterx@redhat.com>

PS: I still hope that the other oneliner can be squashed here directly; it
literally changes exact the same line above so reading this patch alone can
be affected.  You said there you didn't want the commit message to be too
long here, but this is definitely not long at all!  I bet you have similar
understanding to me on defining "long commit message". :) I'd never worry
that.  Your call.

Thanks,

-- 
Peter Xu

