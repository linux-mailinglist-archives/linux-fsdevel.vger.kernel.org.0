Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA72E8DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 01:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfE2XLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 19:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfE2XLN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 19:11:13 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46C024305;
        Wed, 29 May 2019 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559171472;
        bh=A7U+MKtbpL0dbOSwe7NVUwPsEv1DCY3eyaHKJ9yij5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnSJfxskqxpoQDrJRLWPU3NKJ9nfYdmkllbJE1jasU/tSrYzbQeEsRa/tEIwqDZA1
         58t5pmRoasRn8uJ1R9YBMOP9PLM6McjNKfMxSrTAqzTZ1uhDbKtwQqlK+rfABj+Un2
         qEmgNaK4na4weQeZUl4U347gLc9xz8YWC4qIuY8E=
Date:   Wed, 29 May 2019 16:11:12 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190529231112.GB3164@kroah.com>
References: <20190528231218.GA28384@kroah.com>
 <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
 <31936.1559146000@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31936.1559146000@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 05:06:40PM +0100, David Howells wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > And how does the tracing and perf ring buffers do this without needing
> > volatile?  Why not use the same type of interface they provide, as it's
> > always good to share code that has already had all of the nasty corner
> > cases worked out.
> 
> I've no idea how trace does it - or even where - or even if.  As far as I can
> see, grepping for mmap in kernel/trace/*, there's no mmap support.
> 
> Reading Documentation/trace/ring-buffer-design.txt the trace subsystem has
> some sort of transient page fifo which is a lot more complicated than what I
> want and doesn't look like it'll be mmap'able.
> 
> Looking at the perf ring buffer, there appears to be a missing barrier in
> perf_aux_output_end():
> 
> 	rb->user_page->aux_head = rb->aux_head;
> 
> should be:
> 
> 	smp_store_release(&rb->user_page->aux_head, rb->aux_head);
> 
> It should also be using smp_load_acquire().  See
> Documentation/core-api/circular-buffers.rst
> 
> And a (partial) patch has been proposed: https://lkml.org/lkml/2018/5/10/249

So, if that's all that needs to be fixed, can you use the same
buffer/code if that patch is merged?

thanks,

greg k-h
