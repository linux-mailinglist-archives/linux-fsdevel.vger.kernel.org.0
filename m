Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAEC43AEBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 11:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhJZJMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhJZJLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:11:54 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35FAC061227;
        Tue, 26 Oct 2021 02:09:30 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l13so4702148ilh.3;
        Tue, 26 Oct 2021 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5xNIVDKeqDoV8AwrzbKcuLQV4d4coDlOBkR+lZh6ZI=;
        b=Q/R7Asu5XLz/o07GRexotBWO7tgOVQg/eiz/IAbuae24HMCb1OGHuxy1ZfkFRDVXqs
         CEqxj//xvt68QMTRXS5hGUNTpUD2OWZznSqalWkkMNdQEUGZdtJiBbzUqM8TMRPUWy0m
         FLe4JEQnHmfxx8nFRDi3cddp5z9PjH+4hCShr6Io1je2l1Ylk1gpVOQKnXAdMWrfCqJQ
         Of1CreYii0GmFWx6ETh5a+wc36xwBThkFTUb2wecrwWOwyMVTUx99iMcBbMKDQT7dJRO
         e9B0htEFnQaWJBtZCeXoinXM4nY84pg9caLgRiZIMT0G/LCZsqUWkMt23V7bN0RzNDvo
         mciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5xNIVDKeqDoV8AwrzbKcuLQV4d4coDlOBkR+lZh6ZI=;
        b=2kuDeiVF02nHZR/pXC+ZnRyJhZa8qM+zPPnRXbjhS0/yuzp3VIV8xKVfswW2rc1xXA
         vsVbnMnaq1kra4s3t1Qe8JYUIqG9LBdOi0vl1eK9QxKGMAQ2fa996FBmQFraSx7jW0hF
         LRJUYFUgGXlkhpH7DXeTODWChPcpUDjQD098NXCqWiBbdusFN7adC5kV2quuTAZf1TkX
         xhWSHMpWwOTGPmxNG6gBVoglr18C45sxkRlGmQERX6AzFy1E6iX2msLjs9lp5U1BrAvh
         kLJrHGh09FsCC6vXqh3pKBTXd1Bt0f9f2Qu4kSO4hgbxsi4woMcCePmeOmZcinDPPphR
         e8jA==
X-Gm-Message-State: AOAM532MPYYrbfpj41dCKKvQpNFFE7vNJehC5BQvnOhQ0abKPSJueruM
        rr1HWEEScEGdcGa4zE4WiSAhvLMQtuceCVFTuyE=
X-Google-Smtp-Source: ABdhPJzdTOif9GahJ20jd3JAMV4etjfOEln78c3hkiEv8e8znUjjStaO1WOc6yAe+RaKWlGiCOOnU8O1y/GeMYoUgOA=
X-Received: by 2002:a05:6e02:214f:: with SMTP id d15mr12867052ilv.24.1635239370166;
 Tue, 26 Oct 2021 02:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <20211025192746.66445-25-krisman@collabora.com>
In-Reply-To: <20211025192746.66445-25-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 12:09:19 +0300
Message-ID: <CAOQ4uxhCsCPNN=Xb6Xo9VpW+rYCkMUy-1zEXO41d1D4vN74GcA@mail.gmail.com>
Subject: Re: [PATCH v9 24/31] fanotify: Report fid entry even for zero-length file_handle
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:30 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Non-inode errors will reported with an empty file_handle.  In
> preparation for that, allow some events to print the FID record even if
> there isn't any file_handle encoded
>
> Even though FILEID_ROOT is used internally, make zero-length file
> handles be reported as FILEID_INVALID.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v8:
>   - Move fanotify_event_has_object_fh check here (jan)

Logically, this move is wrong, because after this patch,
copy_fid_info_to_user() can theoretically be called with NULL fh in the
existing construct of:
  if (fanotify_event_has_object_fh(event)) {
  ...
    ret = copy_fid_info_to_user(fanotify_event_fsid(event),

fanotify_event_object_fh(event),

The thing that prevents this case in effect is that FAN_FS_ERROR
is not yet wired, but I am not sure if leaving this theoretic bisect
issue is a good idea.

Anyway, that's a very minor theoretic issue and I am sure Jan can
decide whether to deal with it and how (no need to post v10 IMO).

Thanks,
Amir.
