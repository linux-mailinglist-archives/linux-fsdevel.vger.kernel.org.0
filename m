Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6140F42A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbhIQIcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 04:32:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhIQIcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:32:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5AFCF22286;
        Fri, 17 Sep 2021 08:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631867444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5eb8TqjzrqfA6ERLZr5A6LRYLt6Dsy4QQOdugdSe97Q=;
        b=XdmkuscCNdsJbshxJludjY9UBBxnrbeeje9zR82u+BctBDXam0UMT8SP2fcDBYZ8aK/Smc
        KK/ENfXXqaYp1ZVw7dgw7fKlvNMDcINECnbmaTL/uw1vFM3xyY9gnITACUu6/fHxERD3Z9
        M0t8mT0HGmh5SlFuY54Ma1mexoGe2VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631867444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5eb8TqjzrqfA6ERLZr5A6LRYLt6Dsy4QQOdugdSe97Q=;
        b=E/Cq/YykbiDucpkCYq/JzAf9kaune18m05B2tIsNjSE0lmHWgW8/GBS+8vNCJeMe80D3SL
        8yGpCLimjZj+SGBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 18851A3B84;
        Fri, 17 Sep 2021 08:30:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EEBB21E0CA7; Fri, 17 Sep 2021 10:30:43 +0200 (CEST)
Date:   Fri, 17 Sep 2021 10:30:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Shameless plug for the FS Track at LPC next week!
Message-ID: <20210917083043.GA6547@quack2.suse.cz>
References: <20210916013916.GD34899@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916013916.GD34899@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

We did a small update to the schedule:

> Christian Brauner will run the second session, discussing what idmapped
> filesystem mounts are for and the current status of supporting more
> filesystems.

We have extended this session as we'd like to discuss and get some feedback
from users about project quotas and project ids:

Project quotas were originally mostly a collaborative feature and later got
used by some container runtimes to implement limitation of used space on a
filesystem shared by multiple containers. As a result current semantics of
project quotas are somewhat surprising and handling of project ids is not
consistent among filesystems. The main two contending points are:

1) Currently the inode owner can set project id of the inode to any
arbitrary number if he is in init_user_ns. It cannot change project id at
all in other user namespaces.

2) Should project IDs be mapped in user namespaces or not? User namespace
code does implement the mapping, VFS quota code maps project ids when using
them. However e.g. XFS does not map project IDs in its calls setting them
in the inode. Among other things this results in some funny errors if you
set project ID to (unsigned)-1.

In the session we'd like to get feedback how project quotas / ids get used
/ could be used so that we can define the common semantics and make the
code consistently follow these rules.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
