Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E787B16FACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBZJeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 04:34:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36423 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBZJeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:34:21 -0500
Received: by mail-io1-f66.google.com with SMTP id d15so2628116iog.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5wZ1/u1Q/XGtqzkCmHMrbhlF3ORHxkK11c7vhsP0Rs=;
        b=ImPM/ry1mry+jsVRe4kG6J/I11ie14n7x4zDKPrg8zYrxCsaBPEeybp2P8bmpUeAcG
         lgcR1FiKbJMpgf7Oir1oj/mQaZz9nIJhn1n8hr8JOho6e+ri4EJ33lzUEXitNPDx2XtB
         C+psW305PJ51rSwZo2ft6AIo0SjshrIORiuHe6Bc/WGYi0D1WhA4VtwjRe1V0IikTW0y
         OGhYEgi97vre8KXYOhBClYCwkzniOjVGVrU3mmMuDgVqcXtlvPV2C4n/yWccRIA12BwH
         WeImHAnFYr83x8GIh6xvLrMgphQybKg6AtorZGHm/17nk0g0GKqQcSHWlgClpsJ/9YLa
         l4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5wZ1/u1Q/XGtqzkCmHMrbhlF3ORHxkK11c7vhsP0Rs=;
        b=kG3Hhg4AttdS9aluybldi/KdNpxzRf0Ad882eAPH2vvfncrzxeRwcQi50l54eLWVxQ
         TrpRlZnx6lI63ytZcXpSS7G0t+n/rCrmACSMUIZXG0p4i4/KVTHi5VtizBvKOwCQrCfW
         wOMl8XFdX0L1otPWVJEcvWO3d2CpFh4oNi5Ysk0HqlcnNkqTrHUDKRh5ve9ngh7JX+8f
         lpuCCRq5KEsKXCj0CfgQ96QEMA2lPYmp8NfD+tzTlZbvUDGA7UBqHcBJwklTfZX5H1ji
         pmsbW0uzc+4RQGb6/wvmlnILLJGNl9XDE4ywBvyjI+3A1zuUd9dTm0SPG7dtz2GLBPBZ
         0SFw==
X-Gm-Message-State: APjAAAWi89u0t5H4ztQtw0sBvZJNHnn/GCQnQZsUot/UJvoiAIZD6Kvh
        k6Mg5zAF4QCgSFqctsuFiAmQyCzPMfGwlAvPnvAOq5se
X-Google-Smtp-Source: APXvYqxFPuh3+GGxT3mCI0/T4AHwGVTyt+3ck7Kh6y8HFUJMzp/D5lfuHVoNWj5vVZbUhE5yvDDVcL+zsGXXRE6sMtM=
X-Received: by 2002:a5d:9c8c:: with SMTP id p12mr3322030iop.72.1582709660934;
 Wed, 26 Feb 2020 01:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-8-amir73il@gmail.com>
 <20200226082058.GB10728@quack2.suse.cz>
In-Reply-To: <20200226082058.GB10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Feb 2020 11:34:10 +0200
Message-ID: <CAOQ4uxg24swRyhKq3uLr7wriBZvgWTJkxO2Q2SQo2WmMeDjuxA@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] fsnotify: replace inode pointer with tag
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:20 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 17-02-20 15:14:46, Amir Goldstein wrote:
> > The event inode field is used only for comparison in queue merges and
> > cannot be dereferenced after handle_event(), because it does not hold a
> > refcount on the inode.
> >
> > Replace it with an abstract tag do to the same thing. We are going to
> > set this tag for values other than inode pointer in fanotify.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I like this but can we call it say 'objectid' or something like that? 'tag'
> seems too generic to me and it isn't clear why we should merge or not merge
> events with different tags...

Sounds good to me.

And I agree to the comment about fsnotify_init_event()

Apropos event merging, I ran across a simple create/delete files
workload where fanotify_merge() was hogging the CPU.
I currently carry a small private patch to limit the merge depth to 128
recent events. I still didn't have time to think about the best way to
deal with this properly.

Thanks,
Amir.
