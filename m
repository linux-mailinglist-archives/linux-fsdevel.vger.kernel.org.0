Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334DA38F66F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 01:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhEXXpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 19:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhEXXou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 19:44:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB8C061362
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:42:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so12095197pjb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kG8l3p6+P6rjx7Jvu48S/gpIV1ulPkX7htpDNR4shWY=;
        b=H9ngW7m8uvUo5qLVjNuC4k7O6ZpIEp57rNdE7C5JZJGuWi0AH7SrRg+eh8WdN4binM
         7h/hwOFnrj1iUNG2jxBjTmmwCHTE9yprc1A7jWlEsDUKhkRMTW7QlJkUCzbjvU1UJegt
         Op+h7cf+U/9QxO4AHRx530wJLlx/a7WCFyXQHSCD2vC3WKeqFFd406geRsYX9apaq4CP
         32Ojk/LKBtSIzfAmmmkuz6K8y8Og82BEWxICkYN+3wyEQBM3EPh9PzuzSICSpq+BTFHM
         DOCu8E801U0WY5rnp2shaTu07/4yxVTy2N3LiTB51NflcM+i7N2oGdis6zyhSOpQPC4s
         j+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kG8l3p6+P6rjx7Jvu48S/gpIV1ulPkX7htpDNR4shWY=;
        b=MW/eE6hap3cdmRx16M2/nEpL1D7VUM/pLNxc7MvxbKJKhR5407iOlGf+09phdT9JFS
         oAQEp3e/+azSPdFTxcCWKRZpD3yEG4/xllyKE2QntdZNhAnvjxqIfg7I3LUS5E2aHi4r
         41vlYvLiuFT1aPSYid2jr7CoLxBpNLXnnyZIKG/Syka8/JSC2ZKHGss/6RA6gcKWAIJU
         Z9AT0vRnlrxy7KSLRU43ZDOukxjU1Vbvpb1lm10n4bVrliZ2BbILVGd3uxnkfPRCpojs
         a4/jzUVrsNvdfzErkaMblLkJVS18RkuhtGrRspAex+l9iy+9yf/qfiAixEymC723STFT
         0ZTg==
X-Gm-Message-State: AOAM531fQHo7DRTlUdYnHCLGU0Xf7Ezo4dvs0jQ4cg2hV8Zkf8SONx5M
        hHbbhcxT7nruo+PeByDhk4S6/w==
X-Google-Smtp-Source: ABdhPJxIITBSg0KGYxMkDBkPrkJtn2u8MlifbBF6+lhdCoJJELuvArsxlmFif1Y2TblwdxHm5JLW6A==
X-Received: by 2002:a17:902:26c:b029:ef:96e9:1471 with SMTP id 99-20020a170902026cb02900ef96e91471mr27342168plc.63.1621899762002;
        Mon, 24 May 2021 16:42:42 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:fd86:de3d:256d:6afc])
        by smtp.gmail.com with ESMTPSA id g72sm11835226pfb.33.2021.05.24.16.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:42:41 -0700 (PDT)
Date:   Tue, 25 May 2021 09:42:30 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: fix permission model of unprivileged group
Message-ID: <YKw55s1EsYjQxPYf@google.com>
References: <20210522091916.196741-1-amir73il@gmail.com>
 <YKtmwOM9WqUTK/u4@google.com>
 <20210524100004.GI32705@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524100004.GI32705@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 12:00:04PM +0200, Jan Kara wrote:
> On Mon 24-05-21 18:41:36, Matthew Bobrowski wrote:
> > On Sat, May 22, 2021 at 12:19:16PM +0300, Amir Goldstein wrote:
> > > Reporting event->pid should depend on the privileges of the user that
> > > initialized the group, not the privileges of the user reading the
> > > events.
> > > 
> > > Use an internal group flag FANOTIFY_UNPRIV to record the fact the the
> > > group was initialized by an unprivileged user.
> > > 
> > > To be on the safe side, the premissions to setup filesystem and mount
> > > marks now require that both the user that initialized the group and
> > > the user setting up the mark have CAP_SYS_ADMIN.
> > > 
> > > Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > 
> > Thanks for sending through this patch Amir!
> > 
> > In general, the patch looks good to me, however there's just a few
> > nits below.
> > 
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 71fefb30e015..7df6cba4a06d 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -424,11 +424,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >  	 * events generated by the listener process itself, without disclosing
> > >  	 * the pids of other processes.
> > >  	 */
> > > -	if (!capable(CAP_SYS_ADMIN) &&
> > > +	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> > >  	    task_tgid(current) != event->pid)
> > >  		metadata.pid = 0;
> > >  
> > > -	if (path && path->mnt && path->dentry) {
> > > +	/*
> > > +	 * For now, we require fid mode for unprivileged listener, which does
> > > +	 * record path events, but keep this check for safety in case we want
> > > +	 * to allow unprivileged listener to get events with no fd and no fid
> > > +	 * in the future.
> > > +	 */
> > 
> > I think it's best if we keep clear of using first person in our
> > comments throughout our code base. Maybe we could change this to:
> > 
> > * For now, fid mode is required for an unprivileged listener, which
> >   does record path events. However, this check must be kept...
> 
> Actually, I have no problem with the first person in comments. It is a
> standard "anonymous" language and IMO easy to understand as well. Also
> frequently used in the kernel AFAICT. What problem do you see with the
> first person? I'm well aware that unlike us you are a native speaker ;)

That's fair, perhaps it's just personal preference more than
anything. I do believe that it does lead to more succinct comments
that doesn't necessarily lead to thinking about who the reader is
intended to be in this partcular context.

> > > +/* Internal flags */
> > > +#define FANOTIFY_UNPRIV		0x80000000
> > > +#define FANOTIFY_INTERNAL_FLAGS	(FANOTIFY_UNPRIV)
> > 
> > Should we be more distinct here i.e. FANOTIFY_INTERNAL_INIT_FLAGS?
> > Just thinking about a possible case where there's some other internal
> > fanotify flags that are used for something else?
> 
> Well, do we need to distinguish different uses of internal flags? I don't
> think so...

Maybe not. I was just thinking about the possibility of other internal
flags being possibly introduced further on down the line that wouldn't
properly align with the use of FANOTIFY_INTERNAL_FLAGS, therefore me
providing the suggestion for renaming it. Anyway, if such a situation
ever arises then there's absolutely no reason why we can't shuffle
things around later.

/M
