Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382E413CCBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 20:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAOTDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 14:03:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgAOTDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579115012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7ITH9zSXCUTo5cxF0HK0l2gxf6eSqZK0z1Jv9XNif0=;
        b=M4kx82Z2r0Rfqlu2ViXGSbHZVwzxlu1Wk1xFJaFoZdsKSvqlh9jI5nWtRzE68wSt4AxIKg
        I83jdSCL2d+WK1bFAgS0nJ2ksFWEklaCJ3F+44DXAKulKKNWx4+mC0PMwc6fJxlJu1/1Mv
        JFvwvl2J2tuMfwPHEqBYq7wBrDSP20s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-zMv1kJxdM4aNUGL6hHUZXA-1; Wed, 15 Jan 2020 14:03:29 -0500
X-MC-Unique: zMv1kJxdM4aNUGL6hHUZXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 512F1801E77;
        Wed, 15 Jan 2020 19:03:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DBB71000329;
        Wed, 15 Jan 2020 19:03:23 +0000 (UTC)
Subject: Re: RFC: hold i_rwsem until aio completes
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200114161225.309792-1-hch@lst.de>
 <20200114192700.GC22037@ziepe.ca> <20200115065614.GC21219@lst.de>
 <20200115132428.GA25201@ziepe.ca>
 <20200115143347.GL2827@hirez.programming.kicks-ass.net>
 <20200115144948.GB25201@ziepe.ca>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <849239ff-d2d1-4048-da58-b4347e0aa2bd@redhat.com>
Date:   Wed, 15 Jan 2020 14:03:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115144948.GB25201@ziepe.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/20 9:49 AM, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2020 at 03:33:47PM +0100, Peter Zijlstra wrote:
>> On Wed, Jan 15, 2020 at 09:24:28AM -0400, Jason Gunthorpe wrote:
>>
>>> I was interested because you are talking about allowing the read/write side
>>> of a rw sem to be held across a return to user space/etc, which is the
>>> same basic problem.
>> No it is not; allowing the lock to be held across userspace doesn't
>> change the owner. This is a crucial difference, PI depends on there
>> being a distinct owner. That said, allowing the lock to be held across
>> userspace still breaks PI in that it completely wrecks the ability to
>> analyze the critical section.
> I'm not sure what you are contrasting?
>
> I was remarking that I see many places open code a rwsem using an
> atomic and a completion specifically because they need to do the
> things Christoph identified:
>
>> (1) no unlocking by another process than the one that acquired it
>> (2) no return to userspace with locks held
> As an example flow: obtain the read side lock, schedual a work queue,
> return to user space, and unlock the read side from the work queue.

We currently have down_read_non_owner() and up_read_non_owner() that
perform the lock and unlock without lockdep tracking. Of course, that is
a hack and their use must be carefully scrutinized to make sure that
there is no deadlock or other potentially locking issues.

Cheers,
Longman

