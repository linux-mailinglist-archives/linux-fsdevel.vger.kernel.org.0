Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C095588D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiFWT3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFWT3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5322D8E1F2;
        Thu, 23 Jun 2022 11:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8473B62044;
        Thu, 23 Jun 2022 18:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFD1C341C6;
        Thu, 23 Jun 2022 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656010717;
        bh=wcnDAE6efCkUyOu/9igfaJxsfWfaKPG9S7OSaniKuNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WQKN03GKc3xjYJxrsDtPtPxj231mXmv+7HUl8K06cmI4vPswygum9iBmiIotv8v90
         52rc4x9HRdRewYOwGiyXOd3rhywelcFJr2iYHAoabwJYYXpDoTRMC2FLTai+k5zgI9
         7i6eyhzRLhm5Jr8hLHbXBkAqdk7C6goKP9bUshzNgYJjlJD+zDv+9b5kQDtecRd/Ce
         t8fpkXqpbiixPzTW5oPjxXMiuK437eriEXT6TYL800O3vpnoqZAoWFtYB9m6CCJo+K
         rFl4YJnqmgCEZXzdgvHJSYa98bPNv8IagXucwatIdOPgtrQ2tk/ji5B9/eYJxuVn7g
         2AK0Q9WEjXRGg==
Date:   Thu, 23 Jun 2022 11:58:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Message-ID: <YrS322LwMpQwiMT2@sol.localdomain>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
 <YrSNlFgW6X4pUelg@magnolia>
 <YrShiIjNCIANjSwL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrShiIjNCIANjSwL@sol.localdomain>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:23:20AM -0700, Eric Biggers wrote:
> On Thu, Jun 23, 2022 at 08:58:12AM -0700, Darrick J. Wong wrote:
> > > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > > index 7df06931f25d8..ff277ced50e9f 100644
> > > --- a/include/linux/stat.h
> > > +++ b/include/linux/stat.h
> > > @@ -50,6 +50,8 @@ struct kstat {
> > >  	struct timespec64 btime;			/* File creation time */
> > >  	u64		blocks;
> > >  	u64		mnt_id;
> > > +	u32		dio_mem_align;
> > > +	u32		dio_offset_align;
> > 
> > Hmm.  Does the XFS port of XFS_IOC_DIOINFO to STATX_DIOALIGN look like
> > this?
> > 
> > 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > 
> > 	kstat.dio_mem_align = target->bt_logical_sectorsize;
> > 	kstat.dio_offset_align = target->bt_logical_sectorsize;
> > 	kstat.result_mask |= STATX_DIOALIGN;
> 
> Yes, I think so.
> 

By the way, the patchset "[PATCHv6 00/11] direct-io dma alignment"
(https://lore.kernel.org/linux-block/20220610195830.3574005-1-kbusch@fb.com/T/#u),
which is currently queued in linux-block/for-next for 5.20, will relax the user
buffer alignment requirement to the dma alignment for all filesystems using the
iomap direct I/O implementation.  If that goes in, the XFS implementation of
STATX_DIOALIGN, as well as the ext4 and f2fs ones, will need to be changed
accordingly.  Also, the existing XFS_IOC_DIOINFO will need to be changed.

- Eric
