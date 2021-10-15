Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3A42FA4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhJORdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhJORds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:33:48 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA6C061570;
        Fri, 15 Oct 2021 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uUlcTDK4XPU+iizrpIkJOrRHPABQ0RGWVp54/0NzJKk=; b=NgbjHiyaDO4zvgJzUVTEBWtoLd
        MxI2VAOvKixcFxmUR9Q78HrsKsnDB2feafuRocMJlVJca+AtlN2zmCFgfeF73UGfFhvY36HHdpv+c
        p1/8xX3sPuI7ChCJO1bKSWXZ0nrU7NiH+lVFMaTQ4HoVgLCIiqAeSMRNDIBy98+Bb908T9VbJT4zJ
        VTKMweCE7STFbx6SekAkMWFyslODFau0/CJz9pXg1M5OcXwK3M7uRgMch3FDaVwHYbHdPwaAjj2ZP
        IHpqOF83NJkwFyvrlkb19rWiAs7nWP3NODSCnSsYVSn/uKy59n0CpkMd0lNUHlfse0jti5fbGEnEE
        EJKPi/Fg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbR3L-008L4Y-Lv; Fri, 15 Oct 2021 17:31:31 +0000
Date:   Fri, 15 Oct 2021 10:31:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWm68xUnAofop3PZ@bombadil.infradead.org>
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
Sender: Luis Chamberlain <mcgrof@infradead.org>
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

Thanks for trying an alternative fix! A crash stops yes, however this
also ends up leaving the driver in an unrecoverable state after a few
tries. Ie, you CTRL-C the scripts and try again over and over again and
the driver ends up in a situation where it just says:

zram: Can't change algorithm for initialized device

And the zram module can't be removed at that point.

  Luis
