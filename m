Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103284F822F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiDGOz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiDGOz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:55:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096417071
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 07:53:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id o18so1092011qtk.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Apr 2022 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhCXiysGoUI2075P7W2bKKgGlOuKb1/T3rmWb858r8I=;
        b=jFRt1DIXo6EA6788UF7BK8isCva6HFoRyCQgP7ybDLBhQIB9LWwbqoHab33rPMGWGk
         g7ifwlHQZGRB8DvnvO3q0Oxp7gId3v6/njDPSGucFWL0HNkaYPF8kg6QDbgntPrsa2A8
         aiAKicfdmslZpVw2owTLLNfbkt0rCCixRwRu1DabsDY35b805K9zyigPbMK+wKAfOMge
         ZZqPgjLVyW9ec/2XunnxSTzCoWQkAjdaN7ww3p+vkGz+IidOLg+jsoBORnq4lAaGRxbm
         R41hdLFTIHpm9zRfibCIRwleX7jLL3ni14UmeO4B5QcQJy7wFMX5BM6+9QCOLcRKj+L0
         OVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhCXiysGoUI2075P7W2bKKgGlOuKb1/T3rmWb858r8I=;
        b=Tsb+0WS4jKwH7lCe4XGiX0hhApyEluUOjkXv1I7xe4AlaXToRHD1h8gSj9QwjNtjMr
         upmzGj+PO/2HyzgXeSOxA9yq7Gmj3HiBLsm+4sSryZceZ9GhGnh0McAbLjCYSk4ysyid
         BUDbMkfIDI9uJknx8Vtsz6qvTpYb4Ug8o9dWiJnHsYrZ30PaWNK8tAzRnxDj2QIaT7WE
         mTRVDZmjC0Ya7uOjJjviHAvygBj5Uy87J33/hF5MG7vB+Beuwi/qnYqlOSk+mVC/11Ne
         gvdg5nG3PKpozRZRztvqnNdfe6o+vrlHmaEAmjMZ3q2rF7ZzbO5lSunAKYVRwvU0RBKn
         kb5g==
X-Gm-Message-State: AOAM531/jXjhWDxn6VRZhTU2UZYKMRTrdu3q8lo8hou0mPo6kcUD7kW7
        cQIiXsTBVtHzTsasA+Rf4isJjGlP0fZeSl43Eh0rrOZy/T0=
X-Google-Smtp-Source: ABdhPJxdhHpYL0L+cXy/nfGIWFduXiqSWRk207C90HRPyoc4838q3H0GR8CL7QmUajtKL9BiqPjr7I6B/zfMxoDbjzk=
X-Received: by 2002:ac8:5f84:0:b0:2e0:6965:c999 with SMTP id
 j4-20020ac85f84000000b002e06965c999mr12192252qta.477.1649343203908; Thu, 07
 Apr 2022 07:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-7-amir73il@gmail.com>
 <20220407143552.c6cddwtus6eaut2j@quack3.lan>
In-Reply-To: <20220407143552.c6cddwtus6eaut2j@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Apr 2022 17:53:12 +0300
Message-ID: <CAOQ4uxi1MFjyGT84RCfgjyanuLCKq+G630ufx1J69RQXCygPbg@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] fsnotify: create helpers for group mark_mutex lock
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 7, 2022 at 5:35 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-03-22 10:48:54, Amir Goldstein wrote:
> > Create helpers to take and release the group mark_mutex lock.
> >
> > Define a flag FSNOTIFY_GROUP_NOFS in fsnotify backend operations struct
> > that determines if the mark_mutex lock is fs reclaim safe or not.
> > If not safe, the nofs lock helpers should be used to take the lock and
> > disable direct fs reclaim.
> >
> > In that case we annotate the mutex with different lockdep class to
> > express to lockdep that an allocation of mark of an fs reclaim safe group
> > may take the group lock of another "NOFS" group to evict inodes.
> >
> > For now, converted only the callers in common code and no backend
> > defines the NOFS flag.  It is intended to be set by fanotify for
> > evictable marks support.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> A few design question here:
>
> 1) Why do you store the FSNOTIFY_GROUP_NOFS flag in ops? Sure, this
> particular flag is probably going to be the same per backend type but it
> seems a bit strange to have it in ops instead of in the group itself...

I followed the pattern of struct file_system_type.
I didn't think per-group NOFS made much sense,
so it was easier this way.

>
> 2) Why do we have fsnotify_group_nofs_lock() as well as
> fsnotify_group_lock()? We could detect whether we should set nofs based on
> group flag anyway. Is that so that callers don't have to bother with passing
> around the 'nofs'? Is it too bad? We could also store the old value of
> 'nofs' inside the group itself after locking it and then unlock can restore
> it without the caller needing to care about anything...

Yes because it created unneeded code.
storing the local thread state in the group seems odd...

Thanks,
Amir.
