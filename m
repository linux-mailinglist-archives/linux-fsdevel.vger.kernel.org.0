Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BDC591559
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiHLSMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiHLSMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE5B2D8A;
        Fri, 12 Aug 2022 11:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94A54616EA;
        Fri, 12 Aug 2022 18:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35A1C433C1;
        Fri, 12 Aug 2022 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660327949;
        bh=Rv6lMtGY5d9H88atrguKPOp8nVJS42od+lW9pBzVVxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTJV4KhrHOaSfFxNURrSUMS6gfqTumbLuHtpyk/xawEvrWJ9/TX+wPXUKZpVmx2MM
         hBjDW3Nf2JBINWDmIevduFbMAncjc5EC3ICCZDJrdkbwn5la44RnV5IKmkn7eM1qQ8
         KcIqKPzUlFTbuLHbR8p6RNYKgzL2V+Mr6AUvxuboQQ9jZfHV6+/THXkty2iASGS33J
         OW1vsyvTDWI983hyNLe2kUcZRgUfmNlCKhfPT1JbGcrynnB24WZF1WS6KJ2Pk/DNlH
         kRyU1DngWKj73oWw6nzlpK/Ck9Xtw+A++TgdtpnJVja+OizP65iKcv5/tbJ4YGEeCN
         0p/2Qg9YtVbmQ==
Date:   Fri, 12 Aug 2022 11:12:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <YvaYC+LRFqQJT0U9@sol.localdomain>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812123727.46397-2-lczerner@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:37:26PM +0200, Lukas Czerner wrote:
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 6cd6953e175b..5d72b6ba4e63 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -274,6 +274,8 @@ or bottom half).
>  	This is specifically for the inode itself being marked dirty,
>  	not its data.  If the update needs to be persisted by fdatasync(),
>  	then I_DIRTY_DATASYNC will be set in the flags argument.
> +	If the inode has dirty timestamp and lazytime is enabled
> +	I_DIRTY_TIME will be set in the flags.

The new sentence is not always true, since with this patch if
__mark_inode_dirty(I_DIRTY_INODE) is called twice on an inode that has
I_DIRTY_TIME, the second call will no longer include I_DIRTY_TIME -- even though
the inode still has dirty timestamps.  Please be super clear about what the
flags actually mean -- I'm still struggling to understand this patch...

- Eric
