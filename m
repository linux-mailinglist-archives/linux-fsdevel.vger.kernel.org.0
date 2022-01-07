Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC667487CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiAGTFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 14:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232022AbiAGTFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641582309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NUVf7m1XOyKMBK6yeuN7Vw85UmogiAc77nI819YDeEg=;
        b=BolI8RFUrI2Qby+KAsYZoxjiCQJslKQVSlVuVEGkFMa+CKb7iKxjja46/VlQdPC2UdLnWh
        m0OQRHk8FiR4joVPo6GvWv1fUsi5t53Ff9wqDpSI+6jJpsFsM1SvIAcK0Drh9jge3uI1ou
        4dlQIxsBjmP5EGwUPMtVxiz7tU/ubN4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-i-k-pTGCPGidnwK88zt_PA-1; Fri, 07 Jan 2022 13:42:44 -0500
X-MC-Unique: i-k-pTGCPGidnwK88zt_PA-1
Received: by mail-qt1-f197.google.com with SMTP id h20-20020ac85e14000000b002b2e9555bb1so5427752qtx.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jan 2022 10:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUVf7m1XOyKMBK6yeuN7Vw85UmogiAc77nI819YDeEg=;
        b=SW0TxqMyIYC2GkplXa2wD4WTYIiYrBJ+QW/R/lzh4MukADrH61sdTREvpxxGRn01Pn
         HIZpCA/Nf8nqXzAdLVdhlxqoOe7xP439TE+PFSBhP4+Ygy1c73SjdovkDlXfbFSMVQwz
         KtwsRoLTJypS/nFqeBaFDRYJrKZRu4t6PRZITGXqGxgusIxiffoFip4o4AM3h2a7Xemp
         gWRhA0szShbWhXSspt0UT3JudMxpjHeJsB8jckpz7RyrGbpWk8tsQGkkZNR4KvUtP9Zd
         9dpexqG+tcUPD2dZ+eNja/w+VFfIozPzKeH6DrEPHYqCW9A7WAbf3JqSiQ3Da76ZeHY2
         ATLA==
X-Gm-Message-State: AOAM533ae1xpY/uFQjJQj2Nu6IsT5fvoy93Y7SphGjyYlEKWBnlX6JLC
        qUpitbkQz+baOAITs4Y1distDRYxMU6ktZu00VfxIlKF0owBdVBxQmP5fGucTd1hNnjf3NwUw+p
        E9VDxaL/XTw7wak9XWU3vd0EQfQ==
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr56351964qtw.206.1641580963916;
        Fri, 07 Jan 2022 10:42:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPgNoBX9ejFKlCJfc6wykyqLyOQCkwVdWdMM1YPowE48uWMNVtSyTVoBNB72EXiHtaM60FBw==
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr56351949qtw.206.1641580963690;
        Fri, 07 Jan 2022 10:42:43 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id w10sm4533618qtj.37.2022.01.07.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:42:43 -0800 (PST)
Date:   Fri, 7 Jan 2022 13:42:41 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <YdiJoZhJyVRE4xqT@bfoster>
References: <20220105180259.115760-1-bfoster@redhat.com>
 <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
 <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
 <YdfngxyGWatLfa5h@zeniv-ca.linux.org.uk>
 <Ydh5If9ON/fRs7+N@bfoster>
 <Ydh9uKldc0cbusbt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydh9uKldc0cbusbt@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 05:51:52PM +0000, Al Viro wrote:
> On Fri, Jan 07, 2022 at 12:32:17PM -0500, Brian Foster wrote:
> 
> > > Other problems here (aside of whitespace damage - was that a
> > > cut'n'paste of some kind?  Looks like 8859-1 NBSP for each
> > > leading space...) are
> > 
> > Hmm.. I don't see any whitespace damage, even if I pull the patch back
> > from the mailing list into my tree..?
> 
> That had occured in Ian's reply, almost certainly.  Looks like whatever
> he's using for MUA (Evolution?) is misconfigured into doing whitespace
> damage - his next mail (in utf8, rather than 8859-1) had a scattering of
> U+00A0 in it...  Frankly, I'd never seen a decent GUI MUA, so I've no
> real experience with that thing and no suggestions on how to fix that.
> 
> > > 	* misleading name of the new helper - it sounds like
> > > "non-RCU side of complete_walk()" and that's not what it does
> > 
> > The intent was the opposite, of course. :P I'm not sure how you infer
> > the above from _rcu(), but I'll name the helper whatever. Suggestions?
> 
> s/non-// in the above (I really had been half-asleep).  What I'm
> saying is that this name invites an assumption that in RCU case
> complete_walk() is equivalent to it.  Which is wrong - that's
> what complete_walk() does as the first step if it needs to get
> out of RCU mode.
> 

Ah, Ok. I see your point. I suppose we could call it something like
__complete_walk() or __complete_walk_rcu() just to assert that it's a
subcomponent of complete_walk(). Alternatively, we could leave the
complete_walk() bits alone and create a slightly duplicate helper for
the create path (minus LOOKUP_CACHED), or just open code those bits in
the create path without a helper, or perhaps create a lower level helper
along the lines of:

static inline bool nd_reset_root_and_unlazy(struct nameidata *nd)
{
        /*      
         * We don't want to zero nd->root for scoped-lookups or
         * externally-managed nd->root.
         */
        if (!(nd->state & ND_ROOT_PRESET))
                if (!(nd->flags & LOOKUP_IS_SCOPED))
                        nd->root.mnt = NULL; 
        return try_to_unlazy(nd);
}

... and then just leave the LOOKUP_RCU check and LOOKUP_CACHED handling
open coded in the callers as they are now. Hm?

Brian

