Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF35242ECD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhJOIyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhJOIyJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:54:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7EF26109E;
        Fri, 15 Oct 2021 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634287923;
        bh=W0xAcJkW8KdBFsJ63oVYPtXGFhdoFVWNeDyM8kiFZ8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLqEoyo3OdfLn5YKYCXm4p+vFFf9v1O/fleKCvft+boHLGAy22Pra75iPEGpvAv1l
         X2KwqEU0hw0zrjB8LyPBJcqYbyhzGp06itzL06FB/gbebMxNvEUwCjn1AHdh+HGhXZ
         E4/RQPqcHcmHuyJ74in2eZAijam1OnLrAgvdOXGg=
Date:   Fri, 15 Oct 2021 10:52:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWlBMZW5cYJJKGGR@kroah.com>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWk9e957Hb+I7HvR@T590>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:36:11PM +0800, Ming Lei wrote:
> On Thu, Oct 14, 2021 at 05:22:40PM -0700, Luis Chamberlain wrote:
> > On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
> ...
> > > 
> > > We need to understand the exact reason why there is still cpuhp node
> > > left, can you share us the exact steps for reproducing the issue?
> > > Otherwise we may have to trace and narrow down the reason.
> > 
> > See my commit log for my own fix for this issue.
> 
> OK, thanks!
> 
> I can reproduce the issue, and the reason is that reset_store fails
> zram_remove() when unloading module, then the warning is caused.
> 
> The top 3 patches in the following tree can fix the issue:
> 
> https://github.com/ming1/linux/commits/my_v5.15-blk-dev

At a quick glance, those look sane to me, nice work.

greg k-h
