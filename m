Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48385234A79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgGaRsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 13:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgGaRsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:48:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DBC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 10:48:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so29525327qke.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgavFM9fv9RyVhfrzNoVsCZw1UsAPzbtBmN1LRCEpDI=;
        b=NVVxcC3PrAhlWdWZAWXxQH3YnlOFLgOFSt9l4fAQh5s9CGD+7SfmnH7YtjzVCrmpAL
         /yoy1xD/5Y3ppQ/nvRTkHrv4u9eJ2hIDdvbPZvVyBWzSnVn4Q1ZI6Ogru6RAZXtl9WNZ
         jHZQMgE64oC3noQpXLWf3N6gOB4ERfg3ihC16yTOCMhwlAvGABhNAPpSfLKnWw2rdN2l
         ATEDeLEF7WEbyWs3zItzJaX/FLJuVcoO3JorFxvMhgyU24GVw2xIRGKxJ8Bh12drH+w0
         /ZR4XSjBm0Hr4fb7q1NoZQ/bqna8kQn6OutHIE+wtJzCRTc29vF8cZQKnO/JZK9zM+dl
         kQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgavFM9fv9RyVhfrzNoVsCZw1UsAPzbtBmN1LRCEpDI=;
        b=bypmSGznh4qtPr3DfpP+mlRP6A7hFX4TM+Y/b9yIYxu62GNplDbOdxxQ8+5oGfqMOE
         hO6yVviExUdLCs8qsvRAd//ra1l1HZAWu/NutXW7oeyBlBD5c11E6YnhoeP/rVAIsvYC
         VsAV2+37CHXrCX//+5gepe/bWxOjDsMaYD99Sedu+uGBegqE3i4TnfOkDg0hs9mITI0J
         zLHFPv4yi25QmdsONi3DqNV2iGnKY7ASlv5VlHzX7zSWy7o6vh0WskYLZ67w2JrVMdlu
         UsV1LHoXCQghSLoMvM85ZEoB1V75nHx1WjEpAZZwbrtNf8KK2q7DEyU1FT1RIVeByaiG
         +7mA==
X-Gm-Message-State: AOAM531r37EXkr0wFS/u4JkhlhkjnTf6iywH+N93iO9LFSxZopYlyWUq
        P251Bj+OAQ482YDyTuuYvLMvhQ==
X-Google-Smtp-Source: ABdhPJz0MnmxY5FGxiJd/Rlf5vNi7glj7xvlTjk3q/iCWrbWoe08wUQotvFp9C66WBoUIiITj3nu9g==
X-Received: by 2002:a37:b942:: with SMTP id j63mr5170964qkf.138.1596217718437;
        Fri, 31 Jul 2020 10:48:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 22sm8910314qkd.64.2020.07.31.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 10:48:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k1Z93-002AAS-77; Fri, 31 Jul 2020 14:48:37 -0300
Date:   Fri, 31 Jul 2020 14:48:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200731174837.GH24045@ziepe.ca>
References: <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
 <20200731165649.GG24045@ziepe.ca>
 <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 31, 2020 at 01:15:34PM -0400, Steven Sistare wrote:
> On 7/31/2020 12:56 PM, Jason Gunthorpe wrote:
> > On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> >>> Your preservation-across-exec use-case might or might not need the
> >>> VMA to be mapped at the same address.  
> >>
> >> It does.  qemu registers memory with vfio which remembers the va's in kernel
> >> metadata for the device.
> > 
> > Once the memory is registered with vfio the VA doesn't matter, vfio
> > will keep the iommu pointing at the same physical pages no matter
> > where they are mapped.
> 
> Yes, but there are other code paths that compute and use offsets between va and the
> base va.  Mapping at a different va in the new process breaks vfio; I have tried it.

Maybe you could fix vfio instead of having this adventure, if vfio is
the only motivation.

Jason
