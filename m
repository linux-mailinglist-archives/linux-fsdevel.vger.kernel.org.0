Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD027207DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjFBQpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbjFBQpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:45:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427531A8
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 09:45:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 352GjMfp008777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 12:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685724324; bh=fQX3HEZV3KIskpFARmPelBT88Aj1ZdbBSbJ5xbiBv/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UcR0PExUqSSgpGNR5fBjNDAbhuXYHLDvQrDCJiet2+f73mOXSbzNwuMip4+Nu5MJt
         XFRb7FVgPUH5DVaXYC5lISiYdoy1bBhBFmjDDMP9+eMmm8BX7y+0RCsoB9bCgOu99e
         zj1KlthqmQg9lIQZyN3pGo6Pt2p5XQebD0uxMOKwS8XCnSJegUw8K2UVyFpod+3dKT
         t1E/gNnErXCke1dc3862gYAQWzf0IIBUacIrWnUQlS532xxdfHEptSfob2mn/PDWxi
         yIG1gJeaPKQhvkTZ3yV6povDLlxnqHwc1vW6f15Zb6sqXC7EVCiwgOHX1Gl+8Dajsg
         KN0AeE+zWk0Vw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 112B415C02EE; Fri,  2 Jun 2023 12:45:22 -0400 (EDT)
Date:   Fri, 2 Jun 2023 12:45:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 01/12] Revert "ext4: remove ac->ac_found >
 sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
Message-ID: <20230602164522.GD1069561@mit.edu>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com>
 <CA+icZUXDFbxRvx8-pvEwsZAu+-28bX4VDTj6ZTPtvn4gWqGnCg@mail.gmail.com>
 <ZHcMCGO5zW/P8LHh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <29895f4d-9492-4572-d6f3-30d028cdcbe3@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29895f4d-9492-4572-d6f3-30d028cdcbe3@leemhuis.info>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:45:52PM +0200, Thorsten Leemhuis wrote:
> > 
> > Since this patch fixes a regression I think it should ideally go in
> > Linux 6.4
> 
> Ted can speak up for himself, but maybe this might speed things up:
> 
> A lot of maintainers in a case like this want fixes (like this)
> submitted separately from other changes (like the rest of this series).

While it's nice to do that in the future (since I would have noticed
this earlier, it could have gone into my regression fixes push to
Linus last week), in this particular case I've already noted this
particular issue, and per the discussion in the last weekly ext4 video
conference chat, I will be reordering the pashes so I can send a
secondary regression fix to Linus very shortly.

Thanks,

						- Ted
