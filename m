Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8A206FFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbgFXJ1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 05:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387495AbgFXJ1J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:27:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C9D20874;
        Wed, 24 Jun 2020 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592990829;
        bh=sz9dFsvgElJPSubu1rXAM7K6qMOH0Op/lpJbVq77JSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSZxGLXrqkpIi+HrdkKJOWxRMXfCXaz/q9N/4epJGnp9QBX0eNuRQTw9EWBMTtGr7
         37xiwGQb7ER9IhHHmMACOqJ9hDzajgcbJOXRhCh5iGSC0DUl+bXiRw66t/iEf1n/H7
         S1sT0a5gURcQYYYWSWcbcbDVIbgm+jF2idYiwRqE=
Date:   Wed, 24 Jun 2020 11:27:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, Ian Kent <raven@themaw.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200624092708.GA1749737@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
 <20200622175343.GC13061@mtj.duckdns.org>
 <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
 <20200623231348.GD13061@mtj.duckdns.org>
 <a3e9414e-4740-3013-947d-e1839a20227c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3e9414e-4740-3013-947d-e1839a20227c@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:04:15AM -0700, Rick Lindsley wrote:
> In contrast, the provided patch fixes the observed problem with no ripple
> effect to other subsystems or utilities.

Your patch, as-is, is fine, but to somehow think that this is going to
solve your real problem here is the issue we keep raising.

The real problem is you have way too many devices that somehow need to
all get probed at boot time before you can do anything else.

> Greg had suggested
>     Treat the system as a whole please, don't go for a short-term
>     fix that we all know is not solving the real problem here.
> 
> Your solution affects multiple subsystems; this one affects one.  Which is
> the whole system approach in terms of risk?  You mentioned you support 30k
> scsi disks but only because they are slow so the inefficiencies of kernfs
> don't show.  That doesn't bother you?

Systems with 30k of devices do not have any problems that I know of
because they do not do foolish things like stall booting before they are
all discovered :)

What's the odds that if we take this patch, you all have to come back in
a few years with some other change to the api due to even larger memory
sizes happening?  What happens if you boot on a system with this change
and with 10x the memory you currently have?  Try simulating that by
creating 10x the number of devices and see what happens.  Does the
bottleneck still remain in kernfs or is it somewhere else?

thanks,

greg k-h
