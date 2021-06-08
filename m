Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1832939F699
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhFHMaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:30:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52908 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhFHMaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:30:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6BFF6219D7;
        Tue,  8 Jun 2021 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623155310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xx42JuYXEiOSP93pifcF2UyzDW50rx2k3cjtbrzPHxw=;
        b=qhqI7plPWVkr+Vfl177qBd0wIncsBKOOrEAZ37X9iuVtmwqtgxqfadlOZ0vecUm8yycOpD
        ikBwnVvM5X8XikZF6VUcwncgBm9sBVB65gs0PcYCvLqHyVuOhVO/wljDHH8Mnxoh9nZj2S
        DKlJQ8/QbxuT+Y4Q91fJye6iBrdFkwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623155310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xx42JuYXEiOSP93pifcF2UyzDW50rx2k3cjtbrzPHxw=;
        b=7d+4st8LpykSpAP/mfNOZmzH4xeR+iVNV2xF3AbKZnsgp2U6x5/LsQXVaIqNT0+mhp1PJs
        kESRQcbOa31TnyAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 73BA7A3B81;
        Tue,  8 Jun 2021 12:28:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5796C1F2C94; Tue,  8 Jun 2021 14:28:29 +0200 (CEST)
Date:   Tue, 8 Jun 2021 14:28:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][v2] fanotify: fix permission model of unprivileged group
Message-ID: <20210608122829.GI5562@quack2.suse.cz>
References: <20210524135321.2190062-1-amir73il@gmail.com>
 <YL9gzn71T82YOdbF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9gzn71T82YOdbF@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-06-21 14:21:34, Greg KH wrote:
> On Mon, May 24, 2021 at 04:53:21PM +0300, Amir Goldstein wrote:
> > Reporting event->pid should depend on the privileges of the user that
> > initialized the group, not the privileges of the user reading the
> > events.
> > 
> > Use an internal group flag FANOTIFY_UNPRIV to record the fact that the
> > group was initialized by an unprivileged user.
> > 
> > To be on the safe side, the premissions to setup filesystem and mount
> > marks now require that both the user that initialized the group and
> > the user setting up the mark have CAP_SYS_ADMIN.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com/
> > Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
> > Cc: <Stable@vger.kernel.org> # v5.12+
> 
> Why is this marked for 5.12+ when 7cea2a3c505e ("fanotify: support
> limited functionality for unprivileged users") showed up in 5.13-rc1?
> 
> What am I supposed to do with this for a stable tree submission?

I think Amir got confused and didn't realize the functionality got merged
only in 5.13 merge window and I didn't notice when merging the patch
either. I'm sorry, please just ignore the fix.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
