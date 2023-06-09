Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF135729855
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjFILpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFILpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14E30EE;
        Fri,  9 Jun 2023 04:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A681619F2;
        Fri,  9 Jun 2023 11:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BDDC433EF;
        Fri,  9 Jun 2023 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686311130;
        bh=v9LI7LVYBOjPg2fzBZyJq+SK2fQsCPaEnoy+9+VJlI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDMq2dnqSVx1XltmNnqRYZexoEdgIJABfzz4UIGNKtRvb3/a3UZ9X/JTFchKOfRkQ
         sRFvBj/wF+vxU6iamY/HlB4f3Aa7Rv9t+KXfLESX4S/ZLONZCzQv2M33GNIxaWNKPA
         YP6c83TzHj3fi7ia+JNj8CIiai/1ID4pWP4SSG/7n7MUe3mXg37HY/ccdIuqMUxEu8
         XBoDbs8av8mrAtb+141KM2QkumSJRapi4VAL0YVMeXrHTDvQhsb7+Zrdl+vx32SqKT
         y9dSVZUrAA2abQY3pSrAR6RdOJSlBxaDL8dU4C7q8nEitdzkJGA+plJoROqGeBQAa6
         MdsXWxdxfb7dQ==
Date:   Fri, 9 Jun 2023 13:45:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Message-ID: <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:22:12AM +0000, Ariel Miculas (amiculas) wrote:
> Hello Christian,
> 
> I didn't send these patches to a wider audience because this is an
> initial prototype of the PuzzleFS driver, and it has a few
> prerequisites before it could be even considered for merging. First of
> all, the rust filesystem abstractions and their dependencies need to
> be upstreamed, then there needs to be a discussion regarding the

Yes.

> inclusion of third-party crates in the linux kernel.

> 
> My plan was to send these patches to the rust-for-linux mailing list and then start a discussion with Miguel Ojeda regarding the upstreaming approach.
> There are a lot of new files added in this patch series because I've included all the dependencies required so that my patches could be applied to the rust-next branch, but these dependencies will most likely need to be upstreamed separately.
> 
> It was never my intention to avoid your reviews, should I also send
> subsequent patches to linux-fsdevel, even if they're in the early
> stages of development?

Yeah, I think that would be great.

Because the series you sent here touches on a lot of things in terms of
infrastructure alone. That work could very well be rather interesting
independent of PuzzleFS. We might just want to get enough infrastructure
to start porting a tiny existing fs (binderfs or something similar
small) to Rust to see how feasible this is and to wet our appetite for
bigger changes such as accepting a new filesystem driver completely
written in Rust.

But aside from the infrastructure discussion:

This is yet another filesystem for solving the container image problem
in the kernel with the addition of yet another filesystem. We just went
through this excercise with another filesystem. So I'd expect some
reluctance here. Tbh, the container world keeps sending us filesystems
at an alarming rate. That's two within a few months and that leaves a
rather disorganized impression.
