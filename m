Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658902224EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGPOLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGPOLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:11:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD8EC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 07:11:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so6118801iom.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rk38R6x3ocN06+SrFqhx09L3b75LyqSYh6qK7EXNqNM=;
        b=P7xoxSeaxyMuApdCdZPhmSsaq5f+VLXqSTw+3V3urDR6h3EY+oMtSOS+RwgkyZz5Fv
         5raDhyH5TkJTG1tPCdT4a92BxgmzwAAh1Ywl6LLNkVbFm8ZK70WnK7HuoBU1xCv1GmB+
         mINpTKr97OSVm7woKNyW12416SrAAnkNNtfWoI9FkebtGg5wVfwVxZtaHUzqRRjEJOYj
         GgiLQPiDtV85mezsNFKBcJOycRUBBvgLyM9UD/oF+h7eRmSvso05zqwKqnbJq/FwLIjy
         a3V1gmdDxpjbkCzVzzPBIWf5alBOsZVKu5g4t4VAKSnQ/9M0Rn91ZYR0CRe8NK8sTmdf
         Q+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk38R6x3ocN06+SrFqhx09L3b75LyqSYh6qK7EXNqNM=;
        b=cU4/fa+s4BBoUtFoTw9Uv6K0iF/EETRVLYbianf9g9VFlyQBCLBUnezgHG+Wa6XfXx
         gAifgFA2tXXdZ2bm6O1d/JAz0hkO/FfW/aOO3gSVgbb+1L4Sbz3smodnpmrtVIQh0vCk
         fAM2IYcEFwaOvooC/wPRZGOEXW1GDAEO1E4+FMiHCOvcMkvkLVEeuQ8rBs0cZwIltU6L
         FxrDOZlC2leGVV8E4qHtDFosHY1IN//tI0q2MKvs5tPYoyKWwsv4BKpf6SNEtB0WbvQ4
         MVJwkB9vJ/DMDOFgSzyqiH3ki4fu7sOdfSvyYSmdxjnk4QdSx29l5tGe/f2OCeaxYpUl
         MQpw==
X-Gm-Message-State: AOAM530G6Q6m7XlqJC4Iz4s5WpKAV7wVpkwxFW8yTkJrHjLJq/ohEtK0
        mBlNP6DXGxYTglQ97h2BmJYy6FkR4JNWThZ0cab0hA==
X-Google-Smtp-Source: ABdhPJyQLqm2StjGhoB3ZyUr4T9p8Cr8xGjI+CiSwH8BDhVe6h3BEZa293H8mHQUnEUWaaGwaURIzWgn7EFeAiaujZ8=
X-Received: by 2002:a6b:ba03:: with SMTP id k3mr4656352iof.72.1594908660307;
 Thu, 16 Jul 2020 07:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-18-amir73il@gmail.com>
 <20200716134556.GE5022@quack2.suse.cz> <CAOQ4uxiYAviCUAzp0oz8dEmDzJvCW1z_Cyh0FiCONH7kY72rFQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiYAviCUAzp0oz8dEmDzJvCW1z_Cyh0FiCONH7kY72rFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 17:10:48 +0300
Message-ID: <CAOQ4uxjViX_UhSY7KZBf04yqJK8qORP8EisXBvUpnvfoRWmRLg@mail.gmail.com>
Subject: Re: [PATCH v5 17/22] fsnotify: send MOVE_SELF event with parent/name info
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 4:59 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 4:45 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 16-07-20 11:42:25, Amir Goldstein wrote:
> > > MOVE_SELF event does not get reported to a parent watching children
> > > when a child is moved, but it can be reported to sb/mount mark or to
> > > the moved inode itself with parent/name info if group is interested
> > > in parent/name info.
> > >
> > > Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
> > > fsnotify() to handle the case of an event "on child" that should not
> > > be sent to the watching parent's inode mark.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > What I find strange about this is that the MOVE_SELF event will be reported
> > to the new parent under the new name (just due to the way how dentry
> > handling in vfs_rename() works). That seems rather arbitrary and I'm not
> > sure it would be useful? I guess anybody needing dir info with renames
> > will rather use FS_MOVED_FROM / FS_MOVED_TO where it is well defined?
> >
> > So can we leave FS_MOVE_SELF as one of those cases that doesn't report
> > parent + name info?
> >
>
> I can live with that.
> I didn't have a use case for it.
> This patch may be dropped from the series without affecting the rest.
>

BTW, I checked my man page and it doesn't say anything about whether
parent fid and child fid can be reported together with MOVE_SELF.
The language is generic enough on that part.

Thanks,
Amir.
