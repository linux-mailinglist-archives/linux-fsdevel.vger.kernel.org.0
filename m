Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71D332EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 20:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCITFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 14:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCITFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:05:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B597C06174A;
        Tue,  9 Mar 2021 11:05:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dx17so30776935ejb.2;
        Tue, 09 Mar 2021 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3B1rfVT/1MapX7VMCgOxa4XmZopN8HbNzmnG/7rsfgQ=;
        b=UHCRXggSJfUa2CgVkSB7dL/4Y5FXhX0eaFb5Av4/n6K6BgIC0i/eubDi5wkFBKAWCW
         3O3YKzjk7lvVkzJWYm0PodTCGxgXZmkeSqxOhRVoWk8/FsbKyu7ycbCBQQ9zdq/sy+UW
         juHXYFWckJ9tOZPOiy1eSEIXU54wAZTP7VVeFfUbz2NJzeJc5ZtlYPKZ7oChO50opBPF
         V9lTHgovzzjbjNGBCT9qsWb4Kz3RgnJHqqqk8JTwIDl0Q1JzoJR+SpEcZBWNPE1Vaf+0
         eVCvQY78DUn+WVmXMKzUrmzIz55wbfO7sreNpud0MfyjvTe5tr+F+wdyLphhN05RS/k7
         p3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3B1rfVT/1MapX7VMCgOxa4XmZopN8HbNzmnG/7rsfgQ=;
        b=dqhoIKyR8Nw3K/FHiDIVO4mcPDIO0nHihNdbBEp2LfS2myLG9dkqx6SJ8fQg4WlcM6
         +ccbr1uOgKcB0JLYM+XFFD+e2b0k28VVUAVBm9xKmlikZy70Y4stYPu/N8E3fAbP4p84
         4VUD27DMEszl2Mv0mZegjpShTuWARA39sLXN3kkMn3r7djtxut7/bx2smr5Cy7AUbUII
         iglM8SKqIfrk0svphuwiwuWITUeMmRX8Lqwn81Tq9N3WVZIh0Xw3co2h0YpVCDgCGvMu
         L55u7KgRyXMZXxuZTdkX3W/JcwMZA5geSkuhD4fMK5mvxdpmLOw32nlWg3zYH7MeXeNW
         EaZQ==
X-Gm-Message-State: AOAM531tifq8bCqghUiIhJ95HcSJpILBqbgaI0jJP/w4oKJ1zMuKaztW
        6H71xbamshFbCdHt0gNZgA==
X-Google-Smtp-Source: ABdhPJwK8G/3vajvhyL3Z6b2MUVjPIAuxx8+/N6Is3CGCXaZnJztCDcTnqTZcFLBs1EZ53Jb0WgwEQ==
X-Received: by 2002:a17:907:aa2:: with SMTP id bz2mr22247785ejc.239.1615316714077;
        Tue, 09 Mar 2021 11:05:14 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.54])
        by smtp.gmail.com with ESMTPSA id a22sm9046312ejr.89.2021.03.09.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:05:13 -0800 (PST)
Date:   Tue, 9 Mar 2021 22:05:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, christian@brauner.io,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        keescook@chromium.org, gladkov.alexey@gmail.com, walken@google.com,
        bernd.edlinger@hotmail.de, avagin@gmail.com, deller@gmx.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: fix error return code of
 proc_map_files_readdir()
Message-ID: <YEfG54xMM7OtPEE5@localhost.localdomain>
References: <20210309095527.27969-1-baijiaju1990@gmail.com>
 <YEe+v+ywMrxgmj05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEe+v+ywMrxgmj05@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:30:23AM -0800, Eric Biggers wrote:
> On Tue, Mar 09, 2021 at 01:55:27AM -0800, Jia-Ju Bai wrote:
> > When get_task_mm() returns NULL to mm, no error return code of
> > proc_map_files_readdir() is assigned.
> > To fix this bug, ret is assigned with -ENOENT in this case.

> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -2332,8 +2332,10 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> >  		goto out_put_task;
> >  
> >  	mm = get_task_mm(task);
> > -	if (!mm)
> > +	if (!mm) {
> > +		ret = -ENOENT;
> >  		goto out_put_task;
> > +	}
> >  
> >  	ret = mmap_read_lock_killable(mm);
> 
> Is there something in particular that makes you think that returning ENOENT is
> the correct behavior in this case?  Try 'ls /proc/$pid/map_files' where pid is a
> kernel thread; it's an empty directory, which is probably intentional.  Your
> patch would change reading the directory to fail with ENOENT.

Yes. 0 from readdir means "no more stuff", not an error.
