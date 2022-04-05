Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FAF4F45DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiDEPC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390548AbiDENmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:42:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE8108BDE
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 05:43:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DBAF9210FD;
        Tue,  5 Apr 2022 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649162605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7S/t1zaEhSlY3aJ08K2hc/DJgP/P3fQZIhmDxUqc4hQ=;
        b=nuUWXtFahgEAq+vGQZH5OJmf45auKB2jB+kD0+SqJvb78eH8U94A+G2HWvgPqGIDizWHU+
        cyO7tSHStdBYh+r+/NhLDQ9gozlrizgDlzIDra6bvRpcsCaNziFn//Y5AU9f8SB5vQsHbX
        byvFDEnq67+x4wYNY/r1/Tj+ZIM1sc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649162605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7S/t1zaEhSlY3aJ08K2hc/DJgP/P3fQZIhmDxUqc4hQ=;
        b=Eb9eLkntLt8MGqGl9PQst+FyJGOXlZMLMzKLXMs9vlzjZRB8z8mShWnggXNy5w6cwZjWPG
        hZqIdoEEQHJpuYCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5E9DA3B87;
        Tue,  5 Apr 2022 12:43:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5AF1DA0615; Tue,  5 Apr 2022 14:43:25 +0200 (CEST)
Date:   Tue, 5 Apr 2022 14:43:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/16] inotify: show inotify mask flags in proc fdinfo
Message-ID: <20220405124325.v3hio5b7j7faw322@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-2-amir73il@gmail.com>
 <20220405124045.tagcmykrg6byou2m@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405124045.tagcmykrg6byou2m@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-04-22 14:40:45, Jan Kara wrote:
> On Tue 29-03-22 10:48:49, Amir Goldstein wrote:
> > diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> > index 57f0d5d9f934..3451708fd035 100644
> > --- a/fs/notify/fdinfo.c
> > +++ b/fs/notify/fdinfo.c
> > @@ -83,16 +83,9 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
> >  	inode_mark = container_of(mark, struct inotify_inode_mark, fsn_mark);
> >  	inode = igrab(fsnotify_conn_inode(mark->connector));
> >  	if (inode) {
> > -		/*
> > -		 * IN_ALL_EVENTS represents all of the mask bits
> > -		 * that we expose to userspace.  There is at
> > -		 * least one bit (FS_EVENT_ON_CHILD) which is
> > -		 * used only internally to the kernel.
> > -		 */
> > -		u32 mask = mark->mask & IN_ALL_EVENTS;
> > -		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:%x ",
> > +		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:0 ",
> >  			   inode_mark->wd, inode->i_ino, inode->i_sb->s_dev,
> > -			   mask, mark->ignored_mask);
> > +			   inotify_mark_user_mask(mark));
> 
> I think inotify_mark_user_mask() helper is overdoing it a bit. Just using
> INOTIFY_USER_MASK here directly is IMHO fine.

Ah, seeing the next patch I take this comment back. Helper is indeed
useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
