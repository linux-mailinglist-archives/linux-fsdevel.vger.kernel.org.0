Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C152E506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 08:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbiETGaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 02:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbiETGaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 02:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC214AF51;
        Thu, 19 May 2022 23:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2517A61D97;
        Fri, 20 May 2022 06:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342CEC385A9;
        Fri, 20 May 2022 06:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653028204;
        bh=zLcVAySAGbHavOCyzZ3mHIX/dLccYG2RDrRrXi8XEwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIi0kfLHATOya+xGeR0ur/w+CnAM2SQc8hib3dEpvbOubRYGldcau8s/33XCt2s76
         SThI5nP5Bka/U8+8maJc8ic6ISPZUSR89qgmdoBjvGiqKfq7osmnUSaJHcB6JaG+kf
         KbTo0iwc3dep7dA/EntYOhibh5zEl3e1WihnZHvrlzXhxsrS7FoVV8b6UdpGBAyRFf
         Mgjw7EIhBzad06vU33Lx5bn2irSQTKaen9hMmsvds+j654UiaktBoZjKnKcWp+uVfB
         Vi6Px9ntf2zfzBRwDwtTs3Xltn/kmUYIPpa1ptWnO+w7PtNiWQmW0CZDuhK4HMXxOi
         7bR3YsuCNmwWQ==
Date:   Thu, 19 May 2022 23:30:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <Yoc1asB6Ud4Su3gf@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YobNXbYnhBiqniTH@magnolia>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 04:06:05PM -0700, Darrick J. Wong wrote:
> I guess that means for XFS it's effectively max(pagesize, i_blocksize,
> bdev io_opt, sb_width, and (pretend XFS can reflink the realtime volume)
> the rt extent size)?  I didn't see a manpage update for statx(2) but
> that's mostly what I'm interested in. :)

I'll send out a man page update with the next version.  I don't think there will
be much new information that isn't already included in this patchset, though.

> Looking ahead, it looks like the ext4/f2fs implementations only seem to
> be returning max(i_blocksize, bdev io_opt)?  But not the pagesize?

I think that's just an oversight.  ext4 and f2fs should round the value up to
PAGE_SIZE.

- Eric
