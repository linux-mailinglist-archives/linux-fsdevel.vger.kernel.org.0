Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDE3F2CE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbhHTNMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240749AbhHTNMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629465098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqh06A4IsUEWpw6rhzLKw/iWZwAPu+rG9dT74f0JO44=;
        b=L5kJVMfOpVt3JxEOM8yc4L8dOLIPHTh4cQB6QJ1F2TQgDB3IGnQ5q/KlCYnBd0W41hwZWr
        j6GAAmIG+Lf7oAwVMSjwYYFdAIQk1VtAFIIbrWa/9vze0pRAZYledT/8TtJU2BrDHcr4l2
        BLMp6grb8oo/0qfk0W/SDn0hIUtaKKU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-s0O-gErnM8GpsKYsYz1GZQ-1; Fri, 20 Aug 2021 09:11:37 -0400
X-MC-Unique: s0O-gErnM8GpsKYsYz1GZQ-1
Received: by mail-il1-f198.google.com with SMTP id b13-20020a92dccd0000b0290223ea53d878so5356179ilr.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 06:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bqh06A4IsUEWpw6rhzLKw/iWZwAPu+rG9dT74f0JO44=;
        b=nYN528iFewK4X+elQlFWbjQFIeTsrYUYEvETITzvuQbVx7JIvMvM3a+n5hVrwY6Tye
         xooClz7eryMe+0Y87iLfxYIM+qwrBZOVaOwUB+UBOwMAH67bfQrLjWlZpV/Tnyf7VsZM
         Q7SGENLP2AhuAUCW/EofMr4hr/cytN8Nz/avLR0Gw/0RLtQWS2i2JiA+XsvQ6QER4/WM
         +NEMIYUKEdkyP7oK0I68eaBEjsnbtyrNZ4ea2KbteoT1fH5+X/j1YiDsDzfbu14591ew
         SQbIfPDVmsm/5V4KWPonSf7qd8qZrV7x0RvRmVrbLiFHm0LM1aSbFLDReGLUW98wc1U9
         oy7A==
X-Gm-Message-State: AOAM533XxlXYALwlO731RNE7N9raOaOHNBjq6YegNQeq+4pQbgkBSK+G
        htNy1OwOtGBSDd6Koul7ED+rrHvoG39aTZqRoRnPRvLzSiegYm13zZ0BbBeigIDt2XJGUYyhp8X
        gUM80/kgTbI3N4QUvLQw9PknZvQ==
X-Received: by 2002:a05:6638:1905:: with SMTP id p5mr17720505jal.25.1629465096938;
        Fri, 20 Aug 2021 06:11:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn2FwXIDsFpu5O60lFgWVHR+E5ie3a+l6OotzkonnnUZdMfF8XP6FuEiuSEv0LvgDyL5UuiQ==
X-Received: by 2002:a05:6638:1905:: with SMTP id p5mr17720468jal.25.1629465096680;
        Fri, 20 Aug 2021 06:11:36 -0700 (PDT)
Received: from [172.16.0.19] (209-212-39-192.brainerd.net. [209.212.39.192])
        by smtp.gmail.com with ESMTPSA id k9sm3452624ilo.49.2021.08.20.06.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 06:11:36 -0700 (PDT)
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20210819194102.1491495-1-agruenba@redhat.com>
 <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
From:   Bob Peterson <rpeterso@redhat.com>
Message-ID: <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
Date:   Fri, 20 Aug 2021 08:11:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/20/21 4:35 AM, Steven Whitehouse wrote:
> Hi,
> 
> On Thu, 2021-08-19 at 21:40 +0200, Andreas Gruenbacher wrote:
>> From: Bob Peterson <rpeterso@redhat.com>
>>
>> This patch introduces a new HIF_MAY_DEMOTE flag and infrastructure
>> that
>> will allow glocks to be demoted automatically on locking conflicts.
>> When a locking request comes in that isn't compatible with the
>> locking
>> state of a holder and that holder has the HIF_MAY_DEMOTE flag set,
>> the
>> holder will be demoted automatically before the incoming locking
>> request
>> is granted.
>>
> I'm not sure I understand what is going on here. When there are locking
> conflicts we generate call backs and those result in glock demotion.
> There is no need for a flag to indicate that I think, since it is the
> default behaviour anyway. Or perhaps the explanation is just a bit
> confusing...

I agree that the whole concept and explanation are confusing. Andreas 
and I went through several heated arguments about the symantics, 
comments, patch descriptions, etc. We played around with many different 
flag name ideas, etc. We did not agree on the best way to describe the 
whole concept. He didn't like my explanation and I didn't like his. So 
yes, it is confusing.

My preferred terminology was "DOD" or "Dequeue On Demand" which makes 
the concept more understandable to me. So basically a process can say
"I need to hold this glock, but for an unknown and possibly lengthy 
period of time, but please feel free to dequeue it if it's in your way."
And bear in mind that several processes may do the same, simultaneously.

You can almost think of this as a performance enhancement. This concept 
allows a process to hold a glock for much longer periods of time, at a 
lower priority, for example, when gfs2_file_read_iter needs to hold the 
glock for very long-running iterative reads.

The process requesting a holder with "Demote On Demand" must then 
determine if its holder has been stolen away (dequeued on demand) after 
its lengthy operation, and therefore needs to pick up the pieces of 
where it left off in its process.

Meanwhile, another process may need to hold the glock. If its requested 
mode is compatible, say SH and SH, the lock is simply granted with no 
further delay. If the mode is incompatible, regardless of whether it's 
on the local node or a different node in the cluster, these 
longer-term/lower-priority holders may be dequeued or prempted by 
another request to hold the glock. Note that although these holders are 
dequeued-on-demand, they are never "uninitted" as part of the process. 
Nor must they ever be, since they may be on another process's heap.

This differs from the normal glock demote process in which the demote 
bit is set on ("requesting" the glock be demoted) but still needs to 
block until the holder does its actual dequeue.

>> Processes that allow a glock holder to be taken away indicate this by
>> calling gfs2_holder_allow_demote().  When they need the glock again,
>> they call gfs2_holder_disallow_demote() and then they check if the
>> holder is still queued: if it is, they're still holding the glock; if
>> it
>> isn't, they need to re-acquire the glock.
>>
>> This allows processes to hang on to locks that could become part of a
>> cyclic locking dependency.  The locks will be given up when a (rare)
>> conflicting locking request occurs, and don't need to be given up
>> prematurely.
> This seems backwards to me. We already have the glock layer cache the
> locks until they are required by another node. We also have the min
> hold time to make sure that we don't bounce locks too much. So what is
> the problem that you are trying to solve here I wonder?

Again, this is simply allowing premption of lenghy/low-priority holders 
whereas the normal demote process will only demote when the glock is 
dequeued after this potentially very-long period of time.

The minimum hold time solves a different problem, and Andreas and I 
talked just yesterday about possibly revisiting how that all works. The 
problem with minimum hold time is that in many cases the glock state 
machine does not want to grant new holders if the demote bit is on, so 
it ends up wasting more time than solving the actual problem.
But that's another problem for another day.

Regards,

Bob Peterson

