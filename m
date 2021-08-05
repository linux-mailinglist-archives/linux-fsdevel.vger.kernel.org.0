Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4863E18DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbhHEPzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 11:55:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbhHEPzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:55:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 088C0223D1;
        Thu,  5 Aug 2021 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628178929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRS8W2fSdbInZnode1VLLZoQwYcBMtWZIsbGmSoeHq4=;
        b=CIthExvPxVPjncvT/rZM6Ys3SU0tML4mogdAk1aRD87nTInO6G33Hzr9uOphb4MtjNowbh
        h9hScglk4NVTZ0kEfvj8QHNvFRgfW0210bWSYiiY/6uymFwRjMZT6eulb8g7V2u+t5Do2+
        hlCDwKYqAduCr+xDTxKZAD8VLBkwEaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628178929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRS8W2fSdbInZnode1VLLZoQwYcBMtWZIsbGmSoeHq4=;
        b=EDs3lSsswX+BstistyykpAfNDfRb8tHe6Csjc0wAl/PivhiucKFONjcq4WCjIZb3++9/5v
        /clobKWir5R/mIDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id E3B0BA4A52;
        Thu,  5 Aug 2021 15:55:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B55671E1511; Thu,  5 Aug 2021 17:55:28 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:55:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v5 10/23] fsnotify: Allow events reported with an empty
 inode
Message-ID: <20210805155528.GN14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-11-krisman@collabora.com>
 <20210805102453.GG14483@quack2.suse.cz>
 <CAOQ4uxjFyMd=Ja4W18JjBBSpzoKdPD-jafdw78OZO3eAEeMFNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjFyMd=Ja4W18JjBBSpzoKdPD-jafdw78OZO3eAEeMFNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-08-21 17:14:26, Amir Goldstein wrote:
> > 2) AFAICS 'inode' can be always derived from 'data' as well. So maybe we
> > can drop it Amir?
> 
> If only we could. The reason that we pass the allegedly redundant inode
> argument is because there are two different distinguished inode
> arguments:
> 
> 1. The inode event happened on, which can be referenced from data
> 2. Inode that may be marked, which is passed in the inode argument
> 
> Particularly, dirent events carry the inode of the child as data, but
> intentionally pass NULL inode arguments, because mark on inode
> itself should not be getting e.g. FAN_DELETE event, but
> audit_mark_handle_event() uses the child inode data.

I see, thanks for explanation. I forgot that NULL 'inode' argument from
fsnotify_name() is actually needed for this to work.

> If we wanted to, we could pass report_mask arg to fsnotify()
> instead of inode arg and then fsnotify() will build iter_info
> accordingly, but that sounds very complicated and doesn't gain
> much.

Yeah. I'll think a bit more if we could simplify this but now I don't see
anything obvious.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
