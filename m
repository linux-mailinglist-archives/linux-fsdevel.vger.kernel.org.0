Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1534296DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhJKS3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKS3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:29:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932E2C061570;
        Mon, 11 Oct 2021 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gq44BE6cR8pVsQLnKSit7diJ5idp1S8o+4+dKV9Zh/s=; b=e9KiY20KcjCMS22qGi2zZlb1EG
        Dl56WOahyftO7bGTf2DDoGk/kUjhFK2UqbJXCMlN672P3XgjbJkTch95a6eBw8mBFRbT//XBq04Rz
        3/mq7wg+74fhnzqHN9OJWQkPAqltlnADqdbpm4U/fbPQp4+9DmuIaILAPTMu/LYoudvrOY58ywyCY
        nxrgAERN1iINi6ljEbIajEY7waqReRQi1uSMaN4gE+n4i1z6rYTjusE58/NDpQVFAhs78h6RY1YYd
        cXsJ9I+RTyzrjbVIKzjYK0M8p9uR58sgxH8IkeOTzY2QRHxOCvbWVE3e9eB9z/9Z1cKNJQL182oYN
        p8SilPmA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma01K-00ANdv-Mf; Mon, 11 Oct 2021 18:27:30 +0000
Date:   Mon, 11 Oct 2021 11:27:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, minchan@kernel.org,
        jeyu@kernel.org, shuah@kernel.org, bvanassche@acm.org,
        dan.j.williams@intel.com, joe@perches.com, tglx@linutronix.de,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWSCEs8BE8HF/+Gx@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <202110051354.294E28AC87@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110051354.294E28AC87@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:55:35PM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:38:04AM -0700, Luis Chamberlain wrote:
> > Provide a simple state machine to fix races with driver exit where we
> > remove the CPU multistate callbacks and re-initialization / creation of
> > new per CPU instances which should be managed by these callbacks.
> > 
> > The zram driver makes use of cpu hotplug multistate support, whereby it
> > associates a struct zcomp per CPU. Each struct zcomp represents a
> > compression algorithm in charge of managing compression streams per
> > CPU. Although a compiled zram driver only supports a fixed set of
> > compression algorithms, each zram device gets a struct zcomp allocated
> > per CPU. The "multi" in CPU hotplug multstate refers to these per
> > cpu struct zcomp instances. Each of these will have the CPU hotplug
> > callback called for it on CPU plug / unplug. The kernel's CPU hotplug
> > multistate keeps a linked list of these different structures so that
> > it will iterate over them on CPU transitions.
> > 
> > By default at driver initialization we will create just one zram device
> > (num_devices=1) and a zcomp structure then set for the now default
> > lzo-rle comrpession algorithm. At driver removal we first remove each
> > zram device, and so we destroy the associated struct zcomp per CPU. But
> > since we expose sysfs attributes to create new devices or reset /
> > initialize existing zram devices, we can easily end up re-initializing
> > a struct zcomp for a zram device before the exit routine of the module
> > removes the cpu hotplug callback. When this happens the kernel's CPU
> > hotplug will detect that at least one instance (struct zcomp for us)
> > exists. This can happen in the following situation:
> > 
> > CPU 1                            CPU 2
> > 
> >                                 disksize_store(...);
> > class_unregister(...);
> > idr_for_each(...);
> > zram_debugfs_destroy();
> > 
> > idr_destroy(...);
> > unregister_blkdev(...);
> > cpuhp_remove_multi_state(...);
> 
> So this is strictly separate from the sysfs/module unloading race?

It is only related in the sense that the sysfs/module unloading race
happened *after* this other issue, but addressing these through
separate threads created a break in conversation and focus. For
instance, a theoretical race was mentioned in one thread, which
I worked to prove/disprove and then I disproved it was not possible.

But at this point, yes, this is a purely separate issue, and this
patch *should* be picked up already.

Andrew, can you merge this? It already has the respective maintainer
Ack, and I can continue to work on the rest of the patches. The only
issue I can think of would be a conflict with the last patch but
that's a oneliner, I think chances are low that would create a conflict
if its all merged separately, and if so, it should be an easy fix for
a merge conflict.

  Luis
