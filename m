Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063555FCDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiF2KJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiF2KJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:09:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF541CFEE;
        Wed, 29 Jun 2022 03:09:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D6682204C;
        Wed, 29 Jun 2022 10:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656497365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8J44nym0dyAwhq0nK9KESAeqsoUvdq6frY1Sy5q0KXY=;
        b=es7UlIf0YzuDdbIxxkXpikEX5FuSqSRf6SojQOYd8mlxGQZzFxVVbvMXzq/gAaczeiXJua
        zfKr9pGLpbM/vScb5BZ7n2XMlhLM9KquysmOGix3AM3ZmiDGdoKSYXu+hyzLyzfH3P37P5
        fPphRTDaPhRSznUWXRV33T9ln6IxjCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656497365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8J44nym0dyAwhq0nK9KESAeqsoUvdq6frY1Sy5q0KXY=;
        b=QkuDbnfLwxWgqszpioFQvKlwPdGRVXj7xGeYoqPeu7NYGryzUsxIXemzFbgWsPKY/hL+AO
        KnOtHw+A7SXGhVCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 096CD2C141;
        Wed, 29 Jun 2022 10:09:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B4C71A062F; Wed, 29 Jun 2022 12:09:24 +0200 (CEST)
Date:   Wed, 29 Jun 2022 12:09:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] fanotify: refine the validation checks on non-dir inode
 mask
Message-ID: <20220629100924.kvr6rbaanudmennh@quack3>
References: <20220627174719.2838175-1-amir73il@gmail.com>
 <20220628092725.mfwvdu4sk72jov5x@quack3>
 <CAOQ4uxj4EFTrMHfVY=wFt9aAJakNVQA6_Vq-y-b7yvB0tEDsiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj4EFTrMHfVY=wFt9aAJakNVQA6_Vq-y-b7yvB0tEDsiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-06-22 20:22:28, Amir Goldstein wrote:
> On Tue, Jun 28, 2022 at 12:27 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 27-06-22 20:47:19, Amir Goldstein wrote:
> > > Commit ceaf69f8eadc ("fanotify: do not allow setting dirent events in
> > > mask of non-dir") added restrictions about setting dirent events in the
> > > mask of a non-dir inode mark, which does not make any sense.
> > >
> > > For backward compatibility, these restictions were added only to new
> > > (v5.17+) APIs.
> > >
> > > It also does not make any sense to set the flags FAN_EVENT_ON_CHILD or
> > > FAN_ONDIR in the mask of a non-dir inode.  Add these flags to the
> > > dir-only restriction of the new APIs as well.
> > >
> > > Move the check of the dir-only flags for new APIs into the helper
> > > fanotify_events_supported(), which is only called for FAN_MARK_ADD,
> > > because there is no need to error on an attempt to remove the dir-only
> > > flags from non-dir inode.
> > >
> > > Fixes: ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
> > > Link: https://lore.kernel.org/linux-fsdevel/20220627113224.kr2725conevh53u4@quack3.lan/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Thanks! I've taken the patch to my tree.
> >
> >                                                                 Honza
> >
> > > [1] https://github.com/amir73il/ltp/commits/fan_enotdir
> > > [2] https://github.com/amir73il/man-pages/commits/fanotify_target_fid
> 
> Mathew and Jan,
> 
> Please let me know if I can keep your RVB on the man page patch for
> FAN_REPORT_TARGET_FID linked above.
> 
> The only change is an update to the ENOTDIR section which ends up like this:
> 
>        ENOTDIR
>               flags contains FAN_MARK_ONLYDIR, and dirfd and pathname
> do not specify a directory.
> 
>        ENOTDIR
>               mask contains FAN_RENAME, and dirfd and pathname do not
> specify a directory.
> 
>        ENOTDIR
>               flags  contains FAN_MARK_IGNORE, or the fanotify group
> was initialized with
>               flag FAN_REPORT_TARGET_FID, and mask contains directory
> entry modification
>               events (e.g., FAN_CREATE, FAN_DELETE), or directory event flags
>               (e.g., FAN_ONDIR, FAN_EVENT_ON_CHILD),
>               and dirfd and pathname do not specify a directory.

Looks good to me. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
