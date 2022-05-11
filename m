Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1877D523ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 22:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347482AbiEKUUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiEKUUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 16:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6A6D941;
        Wed, 11 May 2022 13:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE50B61A66;
        Wed, 11 May 2022 20:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD71C34116;
        Wed, 11 May 2022 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652300423;
        bh=QuAzmQUWAdTF3kVEFtlEvcYEsAV85ZHmZfYX+FkiBu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8sqDYc9f/b3VIPjxf8biiuGjLxfdnp9wBEtfHavR6AwNGrefagGZdiOLNIKkY6UH
         6G1RGrwLCJxnUIJrVYt8XLSgVrqfDo5bFAuesausqpqHZ/zhKKyYy0ga0apFS8IJWN
         WA1vXVi45gHdjH6EqigkjlbEXR2wpDFuJgNFSbwQj4w7TiEqFyqIEi0XvY6z8v4Aq5
         EB3jVIsLw2eTq+/nWiCURnhRtxzFjkr2I90scOEItPXwP0RBGwu12VXS2DD1redAvg
         oION6uU1H48J0+7/11LFZM+lBrizeFsjwGBVXdnoh4UBCvOyDK6sNx8x1140n7+cAA
         I2hkHscnJ00Ag==
Date:   Wed, 11 May 2022 13:20:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: misreported st_blocks (AllocationSize)
Message-ID: <20220511202022.GA1841530@magnolia>
References: <CAH2r5mvoQskGmY5SkgktzS1ZALeq7uk29EpLELLjVwcwYRwT1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvoQskGmY5SkgktzS1ZALeq7uk29EpLELLjVwcwYRwT1g@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 02:33:01PM -0500, Steve French wrote:
> Was investigating trying to fix emulation of some fallocate flags, and
> was wondering how common is it for a fs to very loosely report
> allocation size (st_blocks) for a file - ie the allocation sizes does
> not match the allocate ranges returned by fiemap (or
> SEEK_HOLE/SEEK_DATA).   Presumably there are Linux fs that coalesce
> ranges on the fly so allocation sizes may be a 'guess' for some fs.
> 
> How common is this for it to be off?

Very common -- XFS reports /all/ file block usage in st_blocks,
including the extent mapping trees and staging areas for copy on write.

--D

> -- 
> Thanks,
> 
> Steve
