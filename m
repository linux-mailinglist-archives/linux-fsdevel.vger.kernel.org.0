Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2CF558510
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiFWRyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiFWRws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95156C00;
        Thu, 23 Jun 2022 10:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20AA061DB9;
        Thu, 23 Jun 2022 17:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00482C3411B;
        Thu, 23 Jun 2022 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656004416;
        bh=rMClqc3zvDXfYMCOvdBp6CeRJmIcRkGT8/7yt5f5Kj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hy8Xfb3CaW83gPTXBez87TKF6HsLY6Vgm+L3dfAfuvodGOX+OUOmbQ/Ghk1w6n2+M
         2DV+2gMkStrDZHG0tUAgHCir1JmtSae//xHrbJSV2gG+wwa4uN1WE2Ew04+yShP6x+
         Wo8Q7FH6WA50N/wiz6O1C6ye8ptPWUlTYD6uObRVS2xQ/Ze/MF5VWCHOxq6jfKo6l0
         mCqmrUBFwatWgjD3iv0rzwXH1Z/HLaoZYGH27u8U6kOqNS9YP0NtGaBshrq51xY8/4
         F7Nj+Vat3OIy1SzwGsAmMrhnN50t3L35HZyEIHe3J5ItFl3WXqp5QqxgJxdZ26l/2R
         70TYqohWcia9w==
Date:   Thu, 23 Jun 2022 10:13:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [man-pages RFC PATCH] statx.2, open.2: document STATX_DIOALIGN
Message-ID: <YrSfPmaWCTOfmQ8H@sol.localdomain>
References: <20220616202141.125079-1-ebiggers@kernel.org>
 <YrSOm2murB4Bc1RQ@magnolia>
 <622BA3BB-03EA-4271-8A2E-2ADAFB574155@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622BA3BB-03EA-4271-8A2E-2ADAFB574155@dilger.ca>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:27:19AM -0600, Andreas Dilger wrote:
> On Jun 23, 2022, at 10:02 AM, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > On Thu, Jun 16, 2022 at 01:21:41PM -0700, Eric Biggers wrote:
> >> From: Eric Biggers <ebiggers@google.com>
> >> 
> >> @@ -244,8 +249,11 @@ STATX_SIZE	Want stx_size
> >> STATX_BLOCKS	Want stx_blocks
> >> STATX_BASIC_STATS	[All of the above]
> >> STATX_BTIME	Want stx_btime
> >> +STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> >> +         	This is deprecated and should not be used.
> > 
> > STATX_ALL is deprecated??  I was under the impression that _ALL meant
> > all the known bits for that kernel release, but...
> 
> For userspace STATX_ALL doesn't make sense, and it isn't used by the kernel.
> 
> Firstly, that would be a compile-time value for an application, so it
> may be incorrect for the kernel the code is actually run on (either too
> many or too few bits could be set).
> 
> Secondly, it isn't really useful for an app to request "all attributes"
> if it doesn't know what they all mean, as that potentially adds useless
> overhead.  Better for it to explicitly request the attributes that it
> needs.  If that is fewer than the kernel could return it is irrelevant,
> since the app would ignore them anyway.
> 
> The kernel will already ignore and mask attributes that *it* doesn't
> understand, so requesting more is fine and STATX_ALL doesn't help this.
> 

What Andreas said.  Note, this discussion really should be happening on my
standalone patch that fixes the documentation for STATX_ALL:
https://lore.kernel.org/r/20220614034459.79889-1-ebiggers@kernel.org.  I folded
it into this RFC one only so that it applies cleanly without a prerequisite.

- Eric
