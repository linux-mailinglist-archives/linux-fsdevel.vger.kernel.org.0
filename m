Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68449487B75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 18:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348590AbiAGRcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 12:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237699AbiAGRcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641576741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdAc6PseEnLyNUpy5hOG3sEEZ/DdMyjFeQyzQ1FGI2A=;
        b=H9FqWWqEO0GwDrdTjVGK6HYG6StRXHe1aSZbXoKBBE2YhJSWb0xge/vx5GHbV+eO0yxJTc
        lYoaszC22YAdL2STU/xfyLiOIrG0Qe6UVfFYGUAYuMLtA/But2hGin4H7iUUwSVBzdZbd2
        0NoK6xYhlwe3/ilrKsOF9N11NWUsQlg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-JNNVG4_gPHuFfCSJ3e_WyA-1; Fri, 07 Jan 2022 12:32:20 -0500
X-MC-Unique: JNNVG4_gPHuFfCSJ3e_WyA-1
Received: by mail-qt1-f197.google.com with SMTP id j26-20020ac8405a000000b002c472361f33so5224622qtl.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jan 2022 09:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdAc6PseEnLyNUpy5hOG3sEEZ/DdMyjFeQyzQ1FGI2A=;
        b=hv4pdzy6nkSuDhVuqsQuB1kjHKiUqnIcRdCSm0tZSqVg8bcQha5GcYdKYBPvW3P2+s
         lEzc2vKnXyW92tycVCxTrzppnjN69t3JDpvyJGzFyiBw2q/lQSXpQbo63YcAkfTThcRO
         T0PuL2ms3GWx/9nLHlhT49bIynxHYWe0wtWPbAHD9/UqzRiTjp7fzUJnnZEGpw1b/hFM
         lnHxtQ5Yq4DvBtgpfPWNzgK4lfgh4kSvpROilmctiDh6Lf+DpJsHHwNE4a/lVt5+mjhm
         sldUvRuCMVLNkcGOdHdor5p8abEQiNwCAG6OpF2YO0IrNb4nvi1jXksFSfiyvIpzIzqD
         a/1w==
X-Gm-Message-State: AOAM532mNIgfm38aNEJyq6pxckI98/wwG5IDQKbTwtHeYplNsTsg1c9y
        RPe6GY1KdxSd7pghVlvrEuUkXdr7DbMAighm1OxABnDAyeAZ/1c0r4j9Ulkd+JIyy7zOo26JDmN
        ljxpH1tuqrSGSpB5XaroDb6WyOQ==
X-Received: by 2002:a05:6214:c4a:: with SMTP id r10mr57014384qvj.62.1641576740230;
        Fri, 07 Jan 2022 09:32:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr5Z/pbM8WmNrsfB9WF0yH9M5FaLwqJtu9+/dgdnOil+jDsvFoz+vcTWtBjQaLrAKrxp6eag==
X-Received: by 2002:a05:6214:c4a:: with SMTP id r10mr57014374qvj.62.1641576740056;
        Fri, 07 Jan 2022 09:32:20 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id v12sm4049013qtx.80.2022.01.07.09.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:32:19 -0800 (PST)
Date:   Fri, 7 Jan 2022 12:32:17 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <Ydh5If9ON/fRs7+N@bfoster>
References: <20220105180259.115760-1-bfoster@redhat.com>
 <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
 <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
 <YdfngxyGWatLfa5h@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdfngxyGWatLfa5h@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:10:59AM +0000, Al Viro wrote:
> On Fri, Jan 07, 2022 at 05:52:27AM +0000, Al Viro wrote:
> 
> > > Looks good, assuming Al is ok with the re-factoring.
> > > Reviewed-by: Ian Kent <raven@themaw.net>
> > 
> > Ummm....  Mind resending that?  I'm still digging myself from under
> > the huge pile of mail, and this seems to have been lost in process...
> 
> Non-obvious part is that current code only does this forgetting
> the root when we are certain that we won't look at it later in
> pathwalk.  IOW, it's guaranteed to be the same through the entire
> thing.  This patch changes that; the final component may very well
> be e.g. an absolute symlink.  We won't know that until we unlazy,
> so we can't make forgetting conditional upon that.
> 
> I _think_ it's not going to lead to any problems, but I'll need to
> take a good look at the entire thing after I get some sleep -
> I'm about to fall down right now.
> 

Heh, Ok. I think I understand what you're getting at, but I'd have to
stare at the code much more to grok the details. Let me know if you
think the logic and/or commit log needs to change wrt to this and I'll
give it a shot.

> Other problems here (aside of whitespace damage - was that a
> cut'n'paste of some kind?  Looks like 8859-1 NBSP for each
> leading space...) are

Hmm.. I don't see any whitespace damage, even if I pull the patch back
from the mailing list into my tree..?

> 	* misleading name of the new helper - it sounds like
> "non-RCU side of complete_walk()" and that's not what it does

The intent was the opposite, of course. :P I'm not sure how you infer
the above from _rcu(), but I'll name the helper whatever. Suggestions?

> 	* LOOKUP_CACHED needs to be mentioned in commit message
> (it's incompatible with O_CREAT, so it couldn't occur on that
> codepath - the transformation is an equivalent one, but that
> ought to be mentioned)

Ok. I can add a "for non-create path only" comment to that effect in the
helper as well if useful.

> 	* the change I mentioned above needs to be in commit
> message - this one is a lot more subtle.
> 

Ack.

> Anyway, I'll look into that tomorrow - too sleepy right now
> to do any serious analysis.
> 

Ack. Thanks for the first pass.

Brian

