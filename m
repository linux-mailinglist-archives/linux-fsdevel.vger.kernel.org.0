Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6318D441ACD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhKALpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 07:45:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43496 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhKALo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:44:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 487171FD6F;
        Mon,  1 Nov 2021 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635766943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+UZ2j8LT45fgqOAv0Vr6ez6FSL6G50V8K6dC/keqBw=;
        b=TpxQF6XkaQ4sHXFLHRKTujdwKdEcQ3Wxqz7N2HhNThXxseVCuEiHp/GrSyujTn3z92eWSl
        brvTK7RPJ7Xy2uvk0OCSjQK5b08Qgfptl+vYiz2luwB2noLA0pde8QTx3Zo1IMAhFhxSP5
        a+7SnrlVcp9uVdLb9Q6fDXrA1IM8a1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635766943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+UZ2j8LT45fgqOAv0Vr6ez6FSL6G50V8K6dC/keqBw=;
        b=VcmHWF5BTXOtCHI147RmuzHfL1k+o+u55tYqmccO0oz5vdCGgnb/5ZDnos6+N/oy+b+Sh5
        75W1t868sxM6+bAQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 0709AA3B81;
        Mon,  1 Nov 2021 11:42:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD7281E0922; Mon,  1 Nov 2021 12:42:22 +0100 (CET)
Date:   Mon, 1 Nov 2021 12:42:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, jack@suse.com,
        amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v8 31/32] samples: Add fs error monitoring example
Message-ID: <20211101114222.GA21679@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-32-krisman@collabora.com>
 <20211028151834.GA423440@roeck-us.net>
 <87fsslasgz.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsslasgz.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-10-21 15:56:28, Gabriel Krisman Bertazi wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
> > On Mon, Oct 18, 2021 at 09:00:14PM -0300, Gabriel Krisman Bertazi wrote:
> >> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> >> errors.
> >> 
> >> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> Reviewed-by: Jan Kara <jack@suse.cz>
> >> ---
> >> Changes since v4:
> >>   - Protect file_handle defines with ifdef guards
> >> 
> >> Changes since v1:
> >>   - minor fixes
> >> ---
> >>  samples/Kconfig               |   9 +++
> >>  samples/Makefile              |   1 +
> >>  samples/fanotify/Makefile     |   5 ++
> >>  samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
> >>  4 files changed, 157 insertions(+)
> >>  create mode 100644 samples/fanotify/Makefile
> >>  create mode 100644 samples/fanotify/fs-monitor.c
> >> 
> >> diff --git a/samples/Kconfig b/samples/Kconfig
> >> index b0503ef058d3..88353b8eac0b 100644
> >> --- a/samples/Kconfig
> >> +++ b/samples/Kconfig
> >> @@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
> >>  	  with it.
> >>  	  See also Documentation/driver-api/connector.rst
> >>  
> >> +config SAMPLE_FANOTIFY_ERROR
> >> +	bool "Build fanotify error monitoring sample"
> >> +	depends on FANOTIFY
> >
> > This needs something like
> > 	depends on CC_CAN_LINK
> > or possibly even
> > 	depends on CC_CAN_LINK && HEADERS_INSTALL
> > to avoid compilation errors such as
> >
> > samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
> >     7 | #include <errno.h>
> >       |          ^~~~~~~~~
> > compilation terminated.
> >
> > when using a toolchain without C library support, such as those provided
> > on kernel.org.
> 
> Thank you, Guenter.
> 
> We discussed this, but I wasn't sure how to silence the error and it
> didn't trigger in the past versions.
> 
> The original patch is already in Jan's tree.  Jan, would you pick the
> pack below to address it?  Feel free to squash it into the original
> commit, if you think it is saner..

Thanks guys, I've added the patch to my tree. If we had more time, I'd
probably squash it but given I'd like to send Linus a pull request at the
end of the week I don't want to touch commits that are already in next.

								Honza

> -- >8 --
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> Date: Thu, 28 Oct 2021 15:34:46 -0300
> Subject: [PATCH] samples: Make fs-monitor depend on libc and headers
> 
> Prevent build errors when headers or libc are not available, such as on
> kernel build bots, like the below:
> 
> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file
> or directory
>   7 | #include <errno.h>
>     |          ^~~~~~~~~
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  samples/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 88353b8eac0b..56539b21f2c7 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -122,7 +122,7 @@ config SAMPLE_CONNECTOR
>  
>  config SAMPLE_FANOTIFY_ERROR
>  	bool "Build fanotify error monitoring sample"
> -	depends on FANOTIFY
> +	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
>  	help
>  	  When enabled, this builds an example code that uses the
>  	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
