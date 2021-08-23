Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E553F4E76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhHWQg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 12:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhHWQg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629736574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5NSirjKs41jSzfQIVFQxmbd80RcTLP1GCVAVajYdQQ=;
        b=Qde5mPLE6DsI9Fjbd8t0fA35gPqF6pIQZAoslUNw4/p5jw58FxWpZniRmrRJRLzYiVGCAC
        8cvRKKrVgFJIhmdgSVopO53QO//0pdAqrkFbN2Li5Cy3OBRtcsjL5ACOScxs5ZUz6sg+A3
        aSnx+i16x7aAKcl8HTLV53ob+gtxi8s=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-TyPLxVUlO5Otp2MHnJdsMw-1; Mon, 23 Aug 2021 12:36:12 -0400
X-MC-Unique: TyPLxVUlO5Otp2MHnJdsMw-1
Received: by mail-io1-f69.google.com with SMTP id f1-20020a5edf01000000b005b85593f933so10428111ioq.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 09:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5NSirjKs41jSzfQIVFQxmbd80RcTLP1GCVAVajYdQQ=;
        b=bOwYxvvg2hV4kIjAV57OmJhTwJPEWIvKdZlVlZ503lwlHGXX05drO8oEqPOmAb+a85
         d1V2liIPj9IBA4+f7E35vAnv1vG/xeAf4/3tC2sc88bR//Q9NIwFTgBD2GxXOtpb9doy
         Dm/uKArxTmytC6FwqFgIS/wnKSHQMqv5bMbBwMMffRVOeVipWRvQ7IOjsm91iGn3iX0V
         fSkoH3lEXXkR8+MB2mySNL2AqsR1sIJSLVmu1lgkz+FtLQF7ChOJ7vTCHIVrMi8DD34y
         PbuNirCVxxS3HAg6Sxnj6GNFCJCln7V8mhGp7g8LO1tilQUOJo553stMwO7KRSm/ZcQT
         Vvow==
X-Gm-Message-State: AOAM531fiPdh/xmtEWey12civ4er/GucYIM/DSQNLb15tTgwV++5Ylsh
        1B5KKn52IJcnI1UvpycibrBYMU+0Jsj6gPTArqZoA6vOcm86GcRhEZFaVcD/4wYJlF9Nq/T5QQr
        YKa8WKMwutt3AVGoQMf2cWV5w8A==
X-Received: by 2002:a05:6602:341:: with SMTP id w1mr27131475iou.40.1629736572394;
        Mon, 23 Aug 2021 09:36:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjIF/CeJPjrbLMOMSAillsWB3d7qGWogCMb9ncBdT7T+8wQDkqYOC3c+S2kxOZsak+rrto5w==
X-Received: by 2002:a05:6602:341:: with SMTP id w1mr27131468iou.40.1629736572248;
        Mon, 23 Aug 2021 09:36:12 -0700 (PDT)
Received: from [172.16.0.19] (209-212-39-192.brainerd.net. [209.212.39.192])
        by smtp.gmail.com with ESMTPSA id z6sm7453260ilp.9.2021.08.23.09.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 09:36:11 -0700 (PDT)
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
References: <20210819194102.1491495-1-agruenba@redhat.com>
 <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
 <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
 <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
 <8e2ab23b93c96248b7c253dc3ea2007f5244adee.camel@redhat.com>
 <CAHc6FU5uHJSXD+CQk3W9BfZmnBCd+fqHt4Bd+=uVH18rnYCPLg@mail.gmail.com>
 <YSPHR7EL/ujG0Of7@casper.infradead.org>
From:   Bob Peterson <rpeterso@redhat.com>
Message-ID: <43cf01f7-1fb5-26a9-bcda-5c9748c6f32e@redhat.com>
Date:   Mon, 23 Aug 2021 11:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSPHR7EL/ujG0Of7@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/23/21 11:05 AM, Matthew Wilcox wrote:
> On Mon, Aug 23, 2021 at 05:18:12PM +0200, Andreas Gruenbacher wrote:
>> On Mon, Aug 23, 2021 at 10:14 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>>> If the goal here is just to allow the glock to be held for a longer
>>> period of time, but with occasional interruptions to prevent
>>> starvation, then we have a potential model for this. There is
>>> cond_resched_lock() which does this for spin locks.
>>
>> This isn't an appropriate model for what I'm trying to achieve here.
>> In the cond_resched case, we know at the time of the cond_resched call
>> whether or not we want to schedule. If we do, we want to drop the spin
>> lock, schedule, and then re-acquire the spin lock. In the case we're
>> looking at here, we want to fault in user pages. There is no way of
>> knowing beforehand if the glock we're currently holding will have to
>> be dropped to achieve that. In fact, it will almost never have to be
>> dropped. But if it does, we need to drop it straight away to allow the
>> conflicting locking request to succeed.
> 
> It occurs to me that this is similar to the wound/wait mutexes
> (include/linux/ww_mutex.h & Documentation/locking/ww-mutex-design.rst).
> You want to mark the glock as woundable before faulting, and then discover
> if it was wounded after faulting.  Maybe sharing this terminology will
> aid in understanding?
> 
Hmm. Woundable. I like it.
Andreas and I argued about the terminology but we never found a 
middle-ground. Perhaps this is it. Thanks, Matthew.

Regards,

Bob Peterson

