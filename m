Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4745F0B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353776AbhKZPdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:33:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44332 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351646AbhKZPbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:31:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B0A672191E;
        Fri, 26 Nov 2021 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637940521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RHSIG8Vf41kDD6Z+gj3pEYz2X1E+EwgDu3TAzBBrEw=;
        b=gRdlKPtWb3qSLg2HGMItq8q43xL16ww1bReTj3h2SjmAeSQ3Ao4AKEyoJc9X59m+usIwWx
        5h4A6yy7UDxR4C640TaZBsLj/xapb08uh4Kzgxj3NMC5hRt3ZH7EcowROGvZJauHZlN+DT
        b9E0lYa3q9RX0tnNMRC5Kt0UKiLWcTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637940521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RHSIG8Vf41kDD6Z+gj3pEYz2X1E+EwgDu3TAzBBrEw=;
        b=UutFxPNPcPdYlaCbCIW6W0mMdOtVnrkdD7vVJZte3yoRkhQB9pHpnPB4nCt7jbAdgEzLPS
        MCxlfWQbvZ6IJADQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 9E36CA3B83;
        Fri, 26 Nov 2021 15:28:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 772651E11F3; Fri, 26 Nov 2021 16:28:41 +0100 (CET)
Date:   Fri, 26 Nov 2021 16:28:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Extend fanotify dirent events
Message-ID: <20211126152841.GK13004@quack2.suse.cz>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Fri 19-11-21 09:17:29, Amir Goldstein wrote:
> This is the 2nd version of FAN_REPORT_TARGET_FID patches [1].
> 
> In the first version, extra info records about new and old parent+name
> were added to FAN_MOVED_FROM event.  This version uses a new event
> FAN_RENAME instead, to report those extra info records.
> The new FAN_RENAME event was designed as a replacement for the
> "inotify way" of joining the MOVED_FROM/MOVED_TO events using a cookie.
> 
> FAN_RENAME event differs from MOVED_FROM/MOVED_TO events in several ways:
> 1) The information about old/new names is provided in a single event
> 2) When added to the ignored mask of a directory, FAN_RENAME is not
>    reported for renames to and from that directory
> 
> The group flag FAN_REPORT_TARGET_FID adds an extra info record of
> the child fid to all the dirent events, including FAN_REANME.
> It is independent of the FAN_RENAME changes and implemented in the
> first patch, so it can be picked regardless of the FAN_RENAME patches.
> 
> Patches [2] and LTP test [3] are available on my github.
> A man page draft will be provided later on.

I've read through the series and I had just two small comments. I was also
slightly wondering whether instead of feeding the two directories for
FS_RENAME into OBJ_TYPE_PARENT and OBJ_TYPE_INODE we should not create
another iter_info type OBJ_TYPE_INODE2 as using OBJ_TYPE_PARENT is somewhat
error prone (you have to get the ordering of conditions right so that you
catch FS_RENAME e.g. before some code decides event should be discarded
because it is parent event without child watching). But I have not fully
decided whether the result is going to be worth it so I'm just mentioning
it as a possible future cleanup.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
