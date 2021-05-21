Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB738C208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhEUIjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhEUIjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:39:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61CC061574;
        Fri, 21 May 2021 01:37:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b25so1036346iot.5;
        Fri, 21 May 2021 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6pxCwi+D5s8azlsfRaUrcmqzzTrPKX02TfNNafLt3E=;
        b=FYVlThmP4Nd4QnbuMrE0VLO7rQ6aAGNWu6N1gFAmdIwGzybJIMpaN6jwNZ+hApv6JC
         +yI3NvxyfohS5HUxVLkH87SF3oFpI2SgesFXV8rjKoxHpWaPNtTwt2oyrXDlhTOibAzq
         wmc69nEtRQH8bg8t1foXosFc05S1OSzCLMaskThpaxVAprf+1xQzo3flefTDYekSe+p6
         lOMJetGNNu6ruOqZKnelIf64xu9CMWZ+gS6Y/+QM8crvn625VR/UzHjveRzn74Ipnh5U
         hIcPhhWQdLH5OLxFhW5AOWM9r3rTOLE21/wPzlkfBn+eFkUxtyTBNYFHZYT2+IftieQU
         CUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6pxCwi+D5s8azlsfRaUrcmqzzTrPKX02TfNNafLt3E=;
        b=UHphPic9LqCEJiLAzOSAk3RwfsbKQN8Av5M3Yst9P8QgW23JRa2hCVBBejFPIK0hMx
         y1NTRscRSieBq2u/64sysHpXFJEDh2Z4n4L9jS+ePvC4PCFR63w4CeTFNAWXt+OPmgye
         TKz/9sU77P0YKspnX0Mo0NwwbsFGQtPWHWJeV34JX9SylS9dKH9SAwK3G5CxrZ5D4+b7
         EF2RSpMT9miRbbbqI9N/AM4fKim7Uu6Uwoas4BI1Qg55iCfuqHDvXN1BODeRG6Km1qPg
         3TGyrVwlq6XjNxmfBopAbVqrnABSMXeAafz5TCD1kp/Uo/V2861SofuuewcuwThuL2lc
         z9FA==
X-Gm-Message-State: AOAM5309Nhr9R3h69b4Ow3TYKphM7p925SSXWqTsVi9nw1BlTzzPbZKO
        o9858VikHHneYNfT5ZjSda3kzeJhU+ozjjJF3p4=
X-Google-Smtp-Source: ABdhPJxR+O/IY+3sCTPWpLEXvd0pYndKMmbrSc/1KpN4GvFPHJJ3f3yhTwrDhy8/BZQ5dqvR8E2eMACYRVwpGvQidEw=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr9292411ioa.64.1621586259251;
 Fri, 21 May 2021 01:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-4-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-4-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 11:37:28 +0300
Message-ID: <CAOQ4uxhSQ0J2c621HBnau9fi9hS4THcyKSZShdpW8J=YSe0fgg@mail.gmail.com>
Subject: Re: [PATCH 03/11] fanotify: Simplify directory sanity check in
 DFID_NAME mode
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> The only fid_mode where the directory inode is reported is
> FAN_REPORT_DFID_NAME.  So remove the negative logic and make it more
> straightforward.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 057abd2cf887..711b36a9483e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -276,7 +276,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>                 /* Path type events are only relevant for files and dirs */
>                 if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
>                         return 0;
> -       } else if (!(fid_mode & FAN_REPORT_FID)) {
> +       } else if (fid_mode & FAN_REPORT_DFID_NAME) {

This change is wrong, because it regresses the case of
fid_mode = FAN_REPORT_FID | FAN_REPORT_DFID_NAME
which is a perfectly legal combination.

Thanks,
Amir.
