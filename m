Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02DC51DE42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444148AbiEFRVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiEFRVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 13:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B36A05B;
        Fri,  6 May 2022 10:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94901B837AA;
        Fri,  6 May 2022 17:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478C8C385A8;
        Fri,  6 May 2022 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651857484;
        bh=oJ7BSJq4l6rV/LR2iCXzf3qzWLmMVgPG/blYMjbJj8U=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IrasRqSy/K3QMu6vkX8fPa93bkexvhleSoQf7qraOcz6j43plU/ehIMSCbLV8QyXp
         +MZyiIXsy4aM7PNc4HJ/A/tkTbUx1KaDL98g+VaOXY5hGgJRunY2eSINOP7/RYjERd
         O9109SGk0hmeCJ3iRh2p3OcYaJtegJE8m+QvMphBmN9cAobSwRBNwcyO2bJCHoLf7Y
         1FmnFHjxeCB1Wk5wiaky/52Inx9tMnaigEPs5YDvoHEqkrl5G7F9AtfdBt5EZBf2cg
         tZ+XEirZBjoQsJQFNMeAid5JBx1HGroIRqP6vb8OXsV3LFN0paPBpMi6cDszC0g6oS
         R5TuZJHtW+7YQ==
Date:   Fri, 6 May 2022 10:18:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: reduce memory allocation in the btrfs direct I/O path
Message-ID: <20220506171803.GA27137@magnolia>
References: <20220504162342.573651-1-hch@lst.de>
 <20220505155529.GY18596@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505155529.GY18596@suse.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 05:55:29PM +0200, David Sterba wrote:
> On Wed, May 04, 2022 at 09:23:37AM -0700, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds two minor improvements to iomap that allow btrfs
> > to avoid a memory allocation per read/write system call and another
> > one per submitted bio.  I also have at last two other pending uses
> > for the iomap functionality later on, so they are not really btrfs
> > specific either.
> 
> The series is reasonably short so I'd like to add it to 5.20 queue,
> provided that the iomap patches get acked by Darrick. Any fixups I'd
> rather fold into my local branch, no need to resend unless there are
> significant updates.

Hm.  I'm planning on pushing out a (very late) iomap-5.19-merge branch,
since (AFAICT) these changes are mostly plumbing.  Do you want me to
push the first three patches of this series for 5.19?

--D
