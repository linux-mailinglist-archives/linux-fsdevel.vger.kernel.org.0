Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323743B1E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhJZMJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 08:09:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60970 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbhJZMJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:09:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 098572193C;
        Tue, 26 Oct 2021 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635249998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyjRbs13Q6FC77TliUQSlFXG3BjAyQNOL98Zw53Q71o=;
        b=my+j0d0t9CwC5WyZ+iqBY32+ynYT3vWd3h4rmhlfK4G8n3u2BgTVaLyhZyZdiAEMoByh9K
        RboCe2Q5TpWcaC+dd/w+EuW71LbMqicm1ZTeunStGV972K/LANs6UNs+eDbtMUkvTfapzg
        23/lFqtZoXeaYWYQGx/vhwiWvRXPBGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635249998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyjRbs13Q6FC77TliUQSlFXG3BjAyQNOL98Zw53Q71o=;
        b=GZUQd92EQNYMhBz+cBvVS5up9G9ce2xHX9rW+5OZc6O+MFp4n4XLfBA4q+fzIBcv77BAdU
        XYjuTLyvfyelYgDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id E6B8FA3B8C;
        Tue, 26 Oct 2021 12:06:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C34BC1F2C66; Tue, 26 Oct 2021 14:06:37 +0200 (CEST)
Date:   Tue, 26 Oct 2021 14:06:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v9 24/31] fanotify: Report fid entry even for zero-length
 file_handle
Message-ID: <20211026120637.GD21228@quack2.suse.cz>
References: <20211025192746.66445-1-krisman@collabora.com>
 <20211025192746.66445-25-krisman@collabora.com>
 <CAOQ4uxhCsCPNN=Xb6Xo9VpW+rYCkMUy-1zEXO41d1D4vN74GcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhCsCPNN=Xb6Xo9VpW+rYCkMUy-1zEXO41d1D4vN74GcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 12:09:19, Amir Goldstein wrote:
> On Mon, Oct 25, 2021 at 10:30 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Non-inode errors will reported with an empty file_handle.  In
> > preparation for that, allow some events to print the FID record even if
> > there isn't any file_handle encoded
> >
> > Even though FILEID_ROOT is used internally, make zero-length file
> > handles be reported as FILEID_INVALID.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> > ---
> > Changes since v8:
> >   - Move fanotify_event_has_object_fh check here (jan)
> 
> Logically, this move is wrong, because after this patch,
> copy_fid_info_to_user() can theoretically be called with NULL fh in the
> existing construct of:
>   if (fanotify_event_has_object_fh(event)) {
>   ...
>     ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> 
> fanotify_event_object_fh(event),
> 
> The thing that prevents this case in effect is that FAN_FS_ERROR
> is not yet wired, but I am not sure if leaving this theoretic bisect
> issue is a good idea.
> 
> Anyway, that's a very minor theoretic issue and I am sure Jan can
> decide whether to deal with it and how (no need to post v10 IMO).

Hum, correct. I guess I'll just fold this patch into patch 26. Logically
they are very close anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
