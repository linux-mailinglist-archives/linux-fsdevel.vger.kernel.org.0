Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5372213A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGORod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGORoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:44:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6AAC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:44:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so3156753iob.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whE827+S7wnMHW3w0ZWpyEDslmIj4jcLVIJfYN1gVz0=;
        b=k1JFEuLvFsURas7BidjBFrhAg+tI7jLOlVmmgpzpuGigvheXaOHCt1hiD1TC8xT7nN
         5Nwsu9s3MDt41ZyqFArvZcZ5Bkd1fWly4ZlgclPKRrT6LYjWt+mjEt2IUrya3zmKWJ5W
         5CX2EsVE3VsmaSj7vDZXjL3FZgs3fabgLnllTL70ow6HC/R6qpV/SjYOh220wkhFqnmn
         la33lwnzSPRT0cNKp50RzQprUlKeJX1cpEJRkpe7LoCSWjxkUMi+BPeo3CC9bz9OExDs
         /zxm4gxzlRrRWibDedOSaP4JHCaz+rjvPa5KS/mF15fZ0RVFDLx5AMFtjcIeVQvx7+yX
         R33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whE827+S7wnMHW3w0ZWpyEDslmIj4jcLVIJfYN1gVz0=;
        b=WU8Q1aqNGdM6R16FVbsJGARjUd5oxE+EQ+Z682yZHMA66DoXHdBiTRgHBUFeC8zrtW
         GiXWJPLsh99OFUbhQ6nfUmGypJuZx1ppI75Qb4/LL3yXWO96L49SvpZHQeTIdRycRQLz
         suLlIXm9c0+PWxki43TrCofDsXL2bOK3igLEfw+kYZ6zRM5cpRrkxPMRm/d1aIekQTs7
         MycL6+/v8UE7YJhTu0UASQPPN+MpXiy95kU57jl4uTk3/N78rKAvVnb29sOovgNbsH4H
         4B4yHDWrdCz4rykDDyrtzZ6pJcOF0KsZu/m7JwOiHKDgz8zvR03uJV4OwrAalpNGO8Vf
         12aQ==
X-Gm-Message-State: AOAM5333c4MXsJeD73mDb49b+FbrUWAXTdLEwgcG6r3njOBXc1+1cJwR
        BXrhDKAQHCAR0jGAg3NMy+JmYXqXNCUFrDSQe0hPdcc6
X-Google-Smtp-Source: ABdhPJxZovo+cotgET/bzIEeiAREqjCPlYEkDGxOxgjdziR82nzwYb2bJPTzniNK0oz8FpaWkqibiA4u0mVyRcN0e80=
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr572197jaj.120.1594835072075;
 Wed, 15 Jul 2020 10:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200708111156.24659-1-amir73il@gmail.com> <20200708111156.24659-20-amir73il@gmail.com>
 <20200715153454.GO23073@quack2.suse.cz> <CAOQ4uxg+75abXiNtPXqh6tybUAGfJ7=we9nmxSnaCsfNGBjZcQ@mail.gmail.com>
 <20200715162440.GP23073@quack2.suse.cz>
In-Reply-To: <20200715162440.GP23073@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jul 2020 20:44:21 +0300
Message-ID: <CAOQ4uxjXEtAqjjKw8Toi_bAZfde5nq-6tbgWsp_Q6vcHHz9JYQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/20] fanotify: no external fh buffer in fanotify_name_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Yap. sounds good.
> > I will test and push the branches.
> > Let me know if you want me to re-post anything.
>
> So I've just picked up patches 1-9 (I took patches 8 and 9 from your git)
> and 17 to my fsnotify branch because they are completely stand-alone
> cleanups and I didn't see a reason to delay them further. All the other
> patches in this series look fine to me but I didn't pick them up yet
> because they are more tightly related to the name event series and could
> possibly change. So I'll pick them up once I feel name event series is more
> stable...
>

Fair enough.
I rebased on top of your branch tested and pushed
fanotify_prep/fanotify_name_fid.

Thanks,
Amir.
