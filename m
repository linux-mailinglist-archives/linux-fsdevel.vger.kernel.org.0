Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D739E3EDA98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhHPQMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 12:12:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44602 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:12:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A7921FF92;
        Mon, 16 Aug 2021 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629130307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7D2Rou1vicTgUvdFxy/dJsujRrKhPDwxoEsMczEVOQ=;
        b=lzWBdZVys7J4/xRH4cyem2qHUbEJQJTV0QA4W4UmTlT+e5DzZtMFs6wT4HvSCZpXYhP3mE
        8YQBykhCqPZhDsac6fb5RAyGNcjwzTaSycbTQ80vbg7JG5m1s4SKqkYg5kD90evvIXbM8V
        cG+no2/urqGOfD4sYkr/pTKEZhGT7Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629130307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7D2Rou1vicTgUvdFxy/dJsujRrKhPDwxoEsMczEVOQ=;
        b=o4IeOzGpfehIyua9llXjd5Y9W5slD9tVO5tCKn3ur3TvdEkiwccPK1unZ1jQLy4UiKXDA+
        IfFNjYlnbnvHvICg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1E678A3B87;
        Mon, 16 Aug 2021 16:11:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DFE701E0426; Mon, 16 Aug 2021 18:11:43 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:11:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 12/21] fanotify: Encode invalid file handle when no
 inode is provided
Message-ID: <20210816161143.GG30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-13-krisman@collabora.com>
 <CAOQ4uxgwuJ4hv8Dp1v40K5qdnnwa7n9MYyvuh2tkb4gkpZv2Yw@mail.gmail.com>
 <20210816140657.GE30215@quack2.suse.cz>
 <CAOQ4uxjQ6R0SvUjasyU3c_ZHTAC1J4=2eamgxJAOyq7C9HZFbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjQ6R0SvUjasyU3c_ZHTAC1J4=2eamgxJAOyq7C9HZFbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 16-08-21 18:54:58, Amir Goldstein wrote:
> On Mon, Aug 16, 2021 at 5:07 PM Jan Kara <jack@suse.cz> wrote:
> > Dunno, it still seems like quite some complications (simple ones but
> > non-trivial amount of them) for what is rather a corner case. What if we
> > *internally* propagated the information that there's no inode info with
> > FILEID_ROOT fh? That means: No changes to fanotify_encode_fh_len(),
> > fanotify_encode_fh(), or fanotify_alloc_name_event(). In
> > copy_info_to_user() we just mangle FILEID_ROOT to FILEID_INVALID and that's
> > all. No useless padding, no specialcasing of copying etc. Am I missing
> > something?
> 
> I am perfectly fine with encoding "no inode" with FILEID_ROOT internally.
> It's already the value used by fanotify_encode_fh() in upstream.
> 
> However, if we use zero len internally, we need to pass fh_type to
> fanotify_fid_info_len() and special case FILEID_ROOT in order to
> take FANOTIFY_FID_INFO_HDR_LEN into account.
> 
> And special case fanotify_event_object_fh_len() in
>  fanotify_event_info_len() and in copy_info_records_to_user().

Right, this will need some tweaking. I would actually leave
fanotify_fid_info_len() alone, just have in fanotify_event_info_len()
something like:

-	if (fh_len)
+	if (fh_len || fanotify_event_needs_fsid(event))

and similarly in copy_info_records_to_user():

-	if (fanotify_event_object_fh_len(event)) {
+	if (fanotify_event_object_fh_len(event) ||
+	    fanotify_event_needs_fsid(event)) {

And that should be all that's needed as far as I'm reading the code.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
