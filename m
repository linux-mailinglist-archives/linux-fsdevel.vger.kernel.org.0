Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB81CA2F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 07:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgEHFu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgEHFu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 01:50:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C6C05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 22:50:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so3786305pjw.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7KizsQZiROV6EsP68AF78nG20gKxvU4xu7g/u2G/rfQ=;
        b=GnzP1gSJOJe5VzGwl3UPI0/HY55joCCUajqsnrTMNQUOZaZgel2xDycfizHYUnzpF7
         JELKuNlJlOoXj8e59IeVw8nOFIVL60dUapO4Yifd39sWXcSfTA2GHEEcyLhy9GkIPHZh
         YVaeNeMrD7GCZEmEA4Twebw5v19lpqqfQd3JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7KizsQZiROV6EsP68AF78nG20gKxvU4xu7g/u2G/rfQ=;
        b=nKq1jF2ml+wrtjWx7oFckp78ESJO9qliemNo/w8X7bilzBD3Vz80YnksZ20uqoU8o+
         AzGeRfYYO5QWQFuWxMsB7+063g61xSnnIF3PYOYU5T1E5783PzaVx9iL1JVomhiT0eb3
         kndrxe5Huz3MAwcRcrAIMYFhk3mtb+TWi4Pu8WDWWAH8KCNJ5c2pmoTS2RHACOvq4pzE
         BiSVFQtzisuBENPfFUtOWqDs7wlnUVNsvyxgbx7qPITOQSPtYcyMYxvCDeAOeKDdn5qz
         /7sc/UAamR7WA3/Gvf0kgLqTDmkJuJm3cUMy3mtXdbX2zMwyFqoaj8m2ReNNEYrZ0djr
         2MNw==
X-Gm-Message-State: AGi0PuZ7GKWkN1oKpyVHslq0A3Y7mEwfy740o3Bf73xh07RPQ2zWr53+
        8E2Z5LC2HEONzb/Q/06FL3mCsg==
X-Google-Smtp-Source: APiQypLKOpAhhsaWBvZcuae9Bduk7G88bnc8QVLf76Pury6KYeoMsRuq/xGaRC59YHIKz70yJvLuwg==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr4135072pjt.196.1588917055088;
        Thu, 07 May 2020 22:50:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm526352pgr.17.2020.05.07.22.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 22:50:54 -0700 (PDT)
Date:   Thu, 7 May 2020 22:50:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
Message-ID: <202005072249.81159F29@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87ftcei2si.fsf@x220.int.ebiederm.org>
 <202005051354.C7E2278688@keescook>
 <87blmz8lda.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blmz8lda.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 04:51:13PM -0500, Eric W. Biederman wrote:
> I intend to the following text to the changelog.  At this point I
> believe I have read through everything and nothing raises any concerns
> for me:
> 
> --- text begin ---
> 
> To see why it is safe to move this code please note that effectively
> this change moves the personality setting in the binfmt and the following
> three lines of code after everything except unlocking the mutexes:
>         arch_pick_mmap_layout
>         arch_setup_new_exec
>         mm->task_size = TASK_SIZE
> 
> The function arch_pick_mmap_layout at most sets:
>         mm->get_unmapped_area
>         mm->mmap_base
>         mm->mmap_legacy_base
>         mm->mmap_compat_base
>         mm->mmap_compat_legacy_base
> which nothing in flush_old_exec or setup_new_exec depends on.
> 
> The function arch_setup_new_exec only sets architecture specific
> state and the rest of the functions only deal in state that applies
> to all architectures.
> 
> The last line just sets mm->task_size and again nothing in flush_old_exec
> or setup_new_exec depend on task_size.
> 
> --- text end ---
> [...]
> > So, with a bit larger changelog discussing what's moving "earlier",
> > I think this looks good:
> 
> Please see above.

Awesome! Thanks for checking my checking of your checking. ;)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
