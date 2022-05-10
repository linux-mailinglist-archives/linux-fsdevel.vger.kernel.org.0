Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A696520C21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 05:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiEJDkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 23:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiEJDjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 23:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626532397AE;
        Mon,  9 May 2022 20:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C12616F7;
        Tue, 10 May 2022 03:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2351C385C2;
        Tue, 10 May 2022 03:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652153586;
        bh=+2uASBmsqYQqhttQPHm/MX34q5RgNamnUz7NmlzcT3Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=NR5ghk9WTaVDnOfP1O7QDYL5jmvHz7wxPbVVEAVuAgbvBz4j8+kDgpJiv8lRcCROR
         6AGatA3RxmZj0Wq4hyNlsdAkt7kTNjzJGMhMhoVWfl2Ocz44afiIY9ADFE8usmT8B/
         6j+2UJ1DR0VFsaPaFEcDRXLF71KAosLwanSMceytXNnj2naYPKCOln475AWS/L+Hxk
         pDl0q2kZEpt/oFotvytbZSl/GM6gNW3SbkzAfvvRImjjyd+IfKvstKc62dVdU05qPo
         lG+SmVi6UpbUoyyQ7cAvxJuuOdgMIoHKb+WwOonY8lRwgfEJTDnW+To3CoNRmM/Qgp
         6ZmLYSJHY97Pg==
Date:   Mon, 9 May 2022 20:33:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: reduce memory allocation in the btrfs direct I/O path
Message-ID: <20220510033305.GB27137@magnolia>
References: <20220504162342.573651-1-hch@lst.de>
 <20220505155529.GY18596@suse.cz>
 <20220506171803.GA27137@magnolia>
 <20220507052649.GA28014@lst.de>
 <20220509184650.GA18596@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509184650.GA18596@twin.jikos.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 08:46:50PM +0200, David Sterba wrote:
> On Sat, May 07, 2022 at 07:26:49AM +0200, Christoph Hellwig wrote:
> > On Fri, May 06, 2022 at 10:18:03AM -0700, Darrick J. Wong wrote:
> > > > The series is reasonably short so I'd like to add it to 5.20 queue,
>                                                               ^^^^
> Sorry, I meant 5.19, ie. the one that's about to start soon.
> 
> > > > provided that the iomap patches get acked by Darrick. Any fixups I'd
> > > > rather fold into my local branch, no need to resend unless there are
> > > > significant updates.
> > > 
> > > Hm.  I'm planning on pushing out a (very late) iomap-5.19-merge branch,
> > > since (AFAICT) these changes are mostly plumbing.  Do you want me to
> > > push the first three patches of this series for 5.19?
> > 
> > Given that we have no conflicts it might be easiest to just merge the
> > whole series through the btrfs tree.
> 
> Yeah, I'd rather take it via the btrfs tree.

Ah, *5.19*.  Yes, this plan now sounds good to me!

(I had wondered, 5.20 seemed like an awfully long time to wait for
something as straightforward as that.)

--D
