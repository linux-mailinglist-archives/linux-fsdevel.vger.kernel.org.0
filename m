Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62445234A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbiEKNtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiEKNtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 09:49:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C31674C0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:49:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E7101F747;
        Wed, 11 May 2022 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652276980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OjoP0qM1vI+0pbeSQgyFNOD7nSJN06hrQc3QxVgQ8w=;
        b=DA/9xw39Y3/Tt8NpId8H4QXN1F3yPzk8/KWF5T5CSwtKVLLwKSnF4avdQOY/QjPLMwpKKA
        Xm/bO3vqclEwXEx3Ny5+Ie0/05uNyH9nhJrsiUBovmHB5K9hkyrdZSbkgZHODPCqSY8NP3
        qOYx6HRLOB45tJP/vdQkjgncmS9s1vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652276980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OjoP0qM1vI+0pbeSQgyFNOD7nSJN06hrQc3QxVgQ8w=;
        b=vJhUEYFAgikSu8dqiEkUSBE+V2TWkF+eNCxd2oPfOzZ3T+p72ny9NIz6wwE36aZNs4Wn5P
        GNm/HxJTkjubDZCQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F344F2C141;
        Wed, 11 May 2022 13:49:39 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 95ADCA062A; Wed, 11 May 2022 15:49:36 +0200 (CEST)
Date:   Wed, 11 May 2022 15:49:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsnotify: consistent behavior for parent not
 watching children
Message-ID: <20220511134936.yuygsjht26flr2oz@quack3.lan>
References: <20220511092914.731897-1-amir73il@gmail.com>
 <20220511092914.731897-3-amir73il@gmail.com>
 <20220511130912.fohl7qakxaobepf7@quack3.lan>
 <CAOQ4uxjMOVKLD4oeN2zZ-nDKxWouFX9_+00S7CAm3X3VWGfgnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjMOVKLD4oeN2zZ-nDKxWouFX9_+00S7CAm3X3VWGfgnQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-05-22 16:37:36, Amir Goldstein wrote:
> On Wed, May 11, 2022 at 4:09 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 11-05-22 12:29:14, Amir Goldstein wrote:
> > > The logic for handling events on child in groups that have a mark on
> > > the parent inode, but without FS_EVENT_ON_CHILD flag in the mask is
> > > duplicated in several places and inconsistent.
> > >
> > > Move the logic into the preparation of mark type iterator, so that the
> > > parent mark type will be excluded from all mark type iterations in that
> > > case.
> > >
> > > This results in several subtle changes of behavior, hopefully all
> > > desired changes of behavior, for example:
> > >
> > > - Group A has a mount mark with FS_MODIFY in mask
> > > - Group A has a mark with ignore mask that does not survive FS_MODIFY
> > >   and does not watch children on directory D.
> > > - Group B has a mark with FS_MODIFY in mask that does watch children
> > >   on directory D.
> > > - FS_MODIFY event on file D/foo should not clear the ignore mask of
> > >   group A, but before this change it does
> >
> > Since FS_MODIFY of directory never happens I guess the ignore mask is never
> > cleared? Am I missing something?
> 
> According to the code in send_to_group()
> If D has FS_EVENT_ON_CHILD in mask then
> The the inode mask on D would get events on D/foo
> therefore
> The ignore mask on D should ignore events (e.g. from mount mark) on D/foo
> therefore
> A MODIFY event on D/foo should clear the ignore mask on D
> 
> This is expected. The bug is that the ignore mask is cleared also
> when D does not have FS_EVENT_ON_CHILD in the mask.

Ah, now I understand. Thanks for explanation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
