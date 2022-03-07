Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF04CFF65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 14:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbiCGNCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 08:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiCGNCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:02:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989BF8A6D6;
        Mon,  7 Mar 2022 05:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E79761195;
        Mon,  7 Mar 2022 13:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21564C340E9;
        Mon,  7 Mar 2022 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646658066;
        bh=vNwLmHMPAuTNQ58SyXP5JOCzc1E/QIa9EAucHhxuwk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvdN7XqNAxzEAmE9bN4/uMtzHnmxTF8Bf1x603RX/KNlDIprB9VVaWZhQeHHnpzbB
         L4kxbqOzloAbu6i7BoQuYqHyMOyLIeQm5T/Xe9xRq6c/W5XBudU0rcZiYQpMIqW8K8
         1un6it52tzYgjHiFXgaZvOMiGyPNX8+j799swQCbH5hFeVmQIpZ6iuDIBfN618OhEW
         E3SyRB41KCkHqiZUuZ0YCU6MdmAWosgy6SdJC1dEwmvD9h3AKYZQWeH4JTR8WfP89z
         OZU/YwJS8GT7u3ZHIoY0Pijc0jpcUbZjNcaA6ewtS9TXcLeg8b87/dA7oNopSl/pXR
         0BIy9frXh9DtQ==
Date:   Mon, 7 Mar 2022 15:00:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, jaharkes@cs.cmu.edu,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@telemann.coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2] mm: Add f_ops->populate()
Message-ID: <YiYB6WWz8cbvaAqX@iki.fi>
References: <20220306032655.97863-1-jarkko@kernel.org>
 <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 03:24:56PM -0800, Andrew Morton wrote:
> On Sun,  6 Mar 2022 05:26:55 +0200 Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Sometimes you might want to use MAP_POPULATE to ask a device driver to
> > initialize the device memory in some specific manner. SGX driver can use
> > this to request more memory by issuing ENCLS[EAUG] x86 opcode for each
> > page in the address range.
> 
> Why is this useful?  Please fully describe the benefit to kernel users.
> Convince us that the benefit justifies the code churn, maintenance
> cost and larger kernel footprint.
> 
> Do we know of any other drivers which might use this?

Brutal honesty: I don't know if any other drivers would use this but
neither I would not be surprised if they did. The need for this might
very well be "masked" by ioctl API's.  I was first proposing a ioctl
for this but Dave suggested to at least try out this route.

> > Add f_ops->populate() with the same parameters as f_ops->mmap() and make
> > it conditionally called inside call_mmap(). Update call sites
> > accodingly.
> 
> spello

Thanks, I noticed that but did not want to spam with a new version just
because of that :-)

> 
> > -static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> > +static inline int call_mmap(struct file *file, struct vm_area_struct *vma, bool do_populate)
> >  {
> > -	return file->f_op->mmap(file, vma);
> > +	int ret = file->f_op->mmap(file, vma);
> > +
> > +	if (!ret && do_populate && file->f_op->populate)
> > +		ret = file->f_op->populate(file, vma);
> > +
> > +	return ret;
> >  }
> 
> Should this still be inlined?

I think it might make sense at least to have call_mmap_populate() so and
mmap_region_populate() instead of putting that boolean parameter to every
flow (based on Greg's feedback). But only if this implementation approach
is used in the first place.

As said, I chose to use RFC to pinpoint a bottleneck for us, not claiming
that this would be the best possible way to work around it.

BR, Jarkko
