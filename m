Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C975B190
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGTOse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjGTOsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:48:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF75A26A5
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 07:48:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36KEm7VL023871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 10:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689864489; bh=3qENlvGeUSbvXcarripQ98xoXLuUgBMJEeEDtgpgOzs=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=o38BvjzvkxR9ejnyf8J9SKcPT7ZJcGH4zqa8IXw45DFO13eV5m5TSfM/gDPPLoBZ8
         ta5EDsmwfIfQF2mCPexYVge9lWt9uqcW72rvke+rTwAxwEzkaV6CbzIGEyqfC9rfa2
         L7PyDewRuWCC3rP/VAWX75IVcDCQpXRu+IvV2lJhK513oNNTwjjJ0QKrI/QcTkNGRN
         1Ao43il3c+osacjK/ueGFmJ0esAkLCI1CXgqj6eiphjsjm3dhq/1iTcrnR0mQH4eP1
         +XRYJFu9iux33+GCMMv4VqIBGH6dMWz3z0S6z7uSu2JdubNsT7UxAuL5UyOCqN437e
         UlcbgKyYSUUaw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7824515C04D6; Thu, 20 Jul 2023 10:48:07 -0400 (EDT)
Date:   Thu, 20 Jul 2023 10:48:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] ext4: fix the time handling macros when ext4 is using
 small inodes
Message-ID: <20230720144807.GC5764@mit.edu>
References: <20230719-ctime-v2-1-869825696d6d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-ctime-v2-1-869825696d6d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 06:32:19AM -0400, Jeff Layton wrote:
> If ext4 is using small on-disk inodes, then it may not be able to store
> fine grained timestamps. It also can't store the i_crtime at all in that
> case since that fully lives in the extended part of the inode.
> 
> 979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
> still store the tv_sec field of the i_crtime into the raw_inode, even
> when they were small, corrupting adjacent memory.
> 
> This fixes those macros to skip setting anything in the raw_inode if the
> tv_sec field doesn't fit, and to properly return a {0,0} timestamp when
> the raw_inode doesn't support it.
> 
> Also, fix a bug in ctime handling during rename. It was updating the
> renamed inode's ctime twice rather than the old directory.
> 
> Cc: Jan Kara <jack@suse.cz>
> Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
> Reported-by: Hugh Dickins <hughd@google.com>
> Tested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>

I assume this is will be applied to the vfs.ctime branch, yes?

  	      	      	 	    	- Ted
