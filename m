Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1913C68D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgAOOtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:49:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39363 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgAOOtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:49:51 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so7451478qvk.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cm5cr0KkaFdqdflwJkN3g1ehM0Qx8fj0jos08WlEqzM=;
        b=lqMsQAnXFU2Rt1775zA/Y9RpU+D9BdtIlQNRV5pcYeoMkgjr8kts7UivMPIOiL0e5n
         f10UOZ9PUDQKAc4uo8oxCDRPATVBy+4x0jxET5bAEYC/jRQba05LCqA5mFdDPXZKT+lb
         OBhCmsKyjTUS/lbEpqcO3YgoacGz12Msnp2wVNAfyc8QXres7PpHjPHKsi2ZXkAcjK24
         L01d3NeJlem45mPJulNzAcL08AlMmZ5ok7aIP/9KMn5V/0cTFYAPgtVCpTokVMp8STJN
         Oyz87SA3j4IaBLjvR+j0YWYGrVgSfqgGG1K43pIfxbDt8YK8NEtcqI1PpfT+bfXVdzrt
         6cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cm5cr0KkaFdqdflwJkN3g1ehM0Qx8fj0jos08WlEqzM=;
        b=bpaSTuAlM1z23/USDU5PsrmKeOFqKdj/aJqRFfoB8npYj2saJXAg0l0tiAw6XHEBYO
         nSNEmSJboc30JBuMUJWB8Z0M9DWCETvMxAlyNHsiKz4zz2AQB97/uzfB5YMvHTC5aJus
         q9GBudtJL4F7hhnODpQySlcvCTHU71U9VO5IK99Osm/LF+AtQqvJef77NIyFAYG9I+nU
         SFL1n1iiKZ7ID7oCbOES4j+4k9iVJOUlK89tJD5sLr9FMwON0yBhLNdQTU5hMGkRB2Op
         NN9eZHINfrOU4vEOMF9BRXrKi1dkYNSmyYNdVh8D5zOE31eEplQEEiXFWpR5doGlDaPM
         /wlQ==
X-Gm-Message-State: APjAAAUJNu7Ur/lKiOj6qhzX4bAVC0huYQTIMznlGHdihaONFlcOqzDa
        NAxUnSKZCdGWNS9SlBiBOXf4Iw==
X-Google-Smtp-Source: APXvYqyFIeQqkTbqfmHkLFxl6XwrUnGz4rIsK+5vF2sMxHxXVPVwnMtL57gUSF9TASMuieCBEj6hKA==
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr26158641qvv.16.1579099789994;
        Wed, 15 Jan 2020 06:49:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n32sm9400465qtk.66.2020.01.15.06.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 06:49:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irjzQ-0008QI-RY; Wed, 15 Jan 2020 10:49:48 -0400
Date:   Wed, 15 Jan 2020 10:49:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200115144948.GB25201@ziepe.ca>
References: <20200114161225.309792-1-hch@lst.de>
 <20200114192700.GC22037@ziepe.ca>
 <20200115065614.GC21219@lst.de>
 <20200115132428.GA25201@ziepe.ca>
 <20200115143347.GL2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115143347.GL2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 03:33:47PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 15, 2020 at 09:24:28AM -0400, Jason Gunthorpe wrote:
> 
> > I was interested because you are talking about allowing the read/write side
> > of a rw sem to be held across a return to user space/etc, which is the
> > same basic problem.
> 
> No it is not; allowing the lock to be held across userspace doesn't
> change the owner. This is a crucial difference, PI depends on there
> being a distinct owner. That said, allowing the lock to be held across
> userspace still breaks PI in that it completely wrecks the ability to
> analyze the critical section.

I'm not sure what you are contrasting?

I was remarking that I see many places open code a rwsem using an
atomic and a completion specifically because they need to do the
things Christoph identified:

> (1) no unlocking by another process than the one that acquired it
> (2) no return to userspace with locks held

As an example flow: obtain the read side lock, schedual a work queue,
return to user space, and unlock the read side from the work queue.

If we can make some general primative that addresses this then maybe
those open coded places can convert as well?

Regards,
Jason
