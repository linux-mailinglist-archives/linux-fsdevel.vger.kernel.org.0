Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52E58A7C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 10:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiHEIGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbiHEIFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1D1571F;
        Fri,  5 Aug 2022 01:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22B06172F;
        Fri,  5 Aug 2022 08:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F9C433C1;
        Fri,  5 Aug 2022 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659686747;
        bh=ACC8J6EOyuDwM441q/+Rq75PWOUwd33X5JbwAmK4LP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTudcgu/ZLXLQi6W1VrPp4XV6B8teCqRj22vpz6XQAwQXIGy7tzdceHIbzBJnFJKu
         AIO2VOmiD/iCcVwhC8pzjDe0TiI+pj6at2soyDTuZRI4fAwY6+cwazSqslaF1WtT/+
         DmeZLIk6qURdMIX9LjYiXAPzYi4ZBGTfImWV4h5Rb8dTC35Yfiunw5EFknJvQ2HVfT
         lo+nJmrKZ7mI16Y5NDUgVjZXDm3odydiR1DOq026x9azz8pMyPMCOeO6D8kiTc0976
         PgSb+lIgUfHqlXrgXd0eR5VZ+fFaxgzv8tGQ440iXRnqFqQPXmMNpIPmg12sGgauQN
         PHOGMIzMPWlEg==
Date:   Fri, 5 Aug 2022 01:05:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <YuzPWfCuVNkmar2n@sol.localdomain>
References: <20220803105340.17377-1-lczerner@redhat.com>
 <20220803105340.17377-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803105340.17377-2-lczerner@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:53:39PM +0200, Lukas Czerner wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9ad5e3520fae..2243797badf2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2245,9 +2245,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
>   *			The inode itself only has dirty timestamps, and the
>   *			lazytime mount option is enabled.  We keep track of this
>   *			separately from I_DIRTY_SYNC in order to implement
>   *			lazytime.  This gets cleared if I_DIRTY_INODE
> - *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
> - *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
> - *			i_state, but not both.  I_DIRTY_PAGES may still be set.
> + *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
> + *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
> + *			in place.

I'm still having a hard time understanding the new semantics.  The first
sentence above needs to be updated since I_DIRTY_TIME no longer means "the inode
itself only has dirty timestamps", right?

Also, have you checked all the places that I_DIRTY_TIME is used and verified
they do the right thing now?  What about inode_is_dirtytime_only()?

Also what is the precise meaning of the flags argument to ->dirty_inode now?

	sb->s_op->dirty_inode(inode,
			flags & (I_DIRTY_INODE | I_DIRTY_TIME));

Note that dirty_inode is documented in Documentation/filesystems/vfs.rst.

- Eric
