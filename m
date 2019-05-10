Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2D19FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEJO6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 10:58:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40867 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJO6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 10:58:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id 18so4961060ywe.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6rszSDtVumI8WbMCUaoSAATR2h/h0pgrpCUpAo0A+Q=;
        b=SCmIx119iHTsyrKEmxPnN9NpY6SMxBCSJ/mHLioj+XeCxsqhT2bb+QQnEiF3LrPQUy
         Q0nhJdV5BF3A1EB3pBA40uRIkK8OCofiHponMNCPye9DaWNY4tNy2UECDpLpoVzUrzU2
         5we+4fMH0ePC1oXHE7Yl4sjupPjlzqof8+VqujeaRSY2yAK2v2MHJlOnrWZQqjniVhb4
         qNztzQTg/4WKCznxzmIattODrCnG++/40JkYcJNsU08q3+WyV90ZeAgZbcP3lZnhazsz
         +u/2DMFFtVEV9qFxbri+F5zzdcT/GbrgN3KogGBwEOlc82KzFQHv62WJDj4PTfO2a0g3
         ZOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6rszSDtVumI8WbMCUaoSAATR2h/h0pgrpCUpAo0A+Q=;
        b=pWe3Xio8yX35fGubP1RdLqv7PSEOFQMluZcaLqa1pJNliaqGXua4k+gA6ZThsYDxng
         qjNrDig7FOSWt/ew5+cpKBhHWsaRLR71ZySSDHl1vN/2nt4YYVdNGAb9vyoDyml3Hybs
         vSYRidDMlvPv1MnMWerZw7HDi/+lSe6fDDqT4udWc6bdM9JulFfpA90zdgwBp98CahT0
         z83490B3v6BcfR6H1zqjRqjCqL28G2ZS4odT4A2TicMZo47W+l/t+uU4XctcmTvNJrmB
         FJtMVNcrbk7gAa2Q9IcuYJPKX77eLndBYF71M5VL0fZJSCFrxLBzFWMNsfNDaPMYCYfA
         FHNA==
X-Gm-Message-State: APjAAAV9t2dHLUIZFvZ1dTONwqESXgvrHP80syl6DRy7T0YcwmIXtdqs
        n4kKeqj7SXQEas+yAUdY08scRGA+cZC1R1ettPDlCNAi
X-Google-Smtp-Source: APXvYqy9IUQnM5YJEgcbC4h5qEaHaxRd/8MG9zJ9hTtoXS4UsBiHCveKgevGTImlNL94NJcwZWvhsfkyjpGKa+qRYxo=
X-Received: by 2002:a5b:64a:: with SMTP id o10mr5749646ybq.32.1557500280986;
 Fri, 10 May 2019 07:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgde7UeFRkD13CHYX2g3SyKY92zX8Tt_wSShkNd9QPYOA@mail.gmail.com>
 <20190505200728.5892-1-amir73il@gmail.com> <20190507161928.GE4635@quack2.suse.cz>
 <CAOQ4uxgHgSiNGqozbR-pqF0BU7J-R51wXUwT_fDUnYbix3kGXw@mail.gmail.com> <20190509094629.GB23589@quack2.suse.cz>
In-Reply-To: <20190509094629.GB23589@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 10 May 2019 17:57:49 +0300
Message-ID: <CAOQ4uxiE=32a5RhqVyC9YAwoxfAdjLjAH0dgSEEV_EaT7H25UQ@mail.gmail.com>
Subject: Re: [PATCH v2] fsnotify: fix unlink performance regression
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 9, 2019 at 12:46 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 07-05-19 22:12:57, Amir Goldstein wrote:
> > On Tue, May 7, 2019 at 7:19 PM Jan Kara <jack@suse.cz> wrote:
> > > So I'd rather move the fsnotify call to vfs_unlink(),
> > > vfs_rmdir(), simple_unlink(), simple_rmdir(), and then those few callers of
> > > d_delete() that remain as you suggest elsewhere in this thread. And then we
> > > get more consistent context for fsnotify_nameremove() and could just use
> > > fsnotify_dirent().
> > >
> >
> > Yes, I much prefer this solution myself and I will follow up with it,
> > but it would not be honest to suggest said solution as a stable fix
> > to the performance regression that was introduced in v5.1.
> > I think is it better if you choose between lesser evil:
> > v1 with ifdef CONFIG_FSNOTIFY to fix build issue
> > v2 as subtle as it is
> > OR another obviously safe stable fix that you can think of
>
> OK, fair enough. I'll go with v1 + build fix for current merge window +
> stable as it's local to fsnotify_nameremove().

Please note that the patch on your fsnotify branch conflicts with
fsnotify_nameremove() changes in master:
230c6402b1b3 ovl_lookup_real_one(): don't bother with strlen()
25b229dff4ff fsnotify(): switch to passing const struct qstr * for file_name

Thanks,
Amir.
