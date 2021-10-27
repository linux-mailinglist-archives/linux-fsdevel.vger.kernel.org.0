Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7B43C9CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbhJ0MjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhJ0MjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:39:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4533C061570;
        Wed, 27 Oct 2021 05:36:49 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f9so3362716ioo.11;
        Wed, 27 Oct 2021 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEi/weRXqa/dLpw7OFj8SFTr2thtNGQq1YHdMTA3K9Y=;
        b=iEgrj1H4tmUFkSIc5lW8onL+locWOXWwm0mdp0J7IRnscMPbNqmYkwz9wzRRkFsvdj
         UGcjiKfxjlVNlq/0ZMPLw9Hh1gpeBqaFBnacsoS3Z0qhIGd4MYbNCsCZBy/F19M4eFwg
         NLetr78IPP57+EwL0KNWNeK5rCSU6frSp45njcJk/ajTpwZ9tJAVoZCoXd5A0jsAdFTu
         rg4sL7/9961XGGrR6EZUPgsKET3JepjzbXb6r4qvZxuCHqtK0hJQsKFMa7MpnQwNslOL
         fO3rX7E9XJAxgnluBZitp71LYWd0TCdvvyYWvPWO94SoqGr64h1gnjlE2tCUOm2PDyLh
         uHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEi/weRXqa/dLpw7OFj8SFTr2thtNGQq1YHdMTA3K9Y=;
        b=6EwCoT1CRr5471L6PBzYFTSfpjTmAoeVK2x19bUCz+bU6xtZD4HcKBLhxCHDHloQ8j
         ClFelJl5Sl52RF1SQ1/Wp4dWfFXy7xmwXoghs363cRj0XyXNcATrM2O0G5r1/CxqstM4
         p9+UQCwnFOUKvEkLdCs/N+98q+xrCtlRvgRUR73sRUCUEacy+yukCTnTLkai6CovttRw
         5f2+u3BrYGHc/0tk+ZpD2du0pNa2AMcl03zpb3HvyE2c7/NgzUM/qv7cmX8HaVjUafZT
         96nVJYrN8XDIzvPxmxWAV6lEKcE/aRQ/ndGl1VA2q52YPDzyp3qh3/VtPYX1EzilaJK8
         jaDQ==
X-Gm-Message-State: AOAM532nVIk+LzDB91Z1U6bvKmXnBNYIupP1dcqtF4zRwofeNsDE/BjT
        ebV5y31uqGKiCOmkm+eqgm+v/dNgAnGY8hCFA58=
X-Google-Smtp-Source: ABdhPJzAkEVaRxSQwVqUsmVQ9WgpfAq6n+K7EmNe5gAO/ucmzfo2JBgvsvGHV2BdtV4grUAMFpk1rJB8BpRjFGo/N/0=
X-Received: by 2002:a05:6638:2607:: with SMTP id m7mr13595231jat.136.1635338209387;
 Wed, 27 Oct 2021 05:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
 <20211027112243.GE28650@quack2.suse.cz>
In-Reply-To: <20211027112243.GE28650@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 15:36:38 +0300
Message-ID: <CAOQ4uxgUdvAx6rWTYMROFDX8UOd8eVzKhDcpB0Qne1Uk9oOMAw@mail.gmail.com>
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 2:22 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 26-10-21 12:12:38, Amir Goldstein wrote:
> > On Mon, Oct 25, 2021 at 10:27 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> > >
> > > Hi,
> > >
> > > This is the 9th version of this patch series.  Thank you, Amir, Jan and
> > > Ted, for the feedback in the previous versions.
> > >
> > > The main difference in this version is that the pool is no longer
> > > resizeable nor limited in number of marks, even though we only
> > > pre-allocate 32 slots.  In addition, ext4 was modified to always return
> > > non-zero errno, and the documentation was fixed accordingly (No longer
> > > suggests we return EXT4_ERR* values.
> > >
> > > I also droped the Reviewed-by tags from the ext4 patch, due to the
> > > changes above.
> > >
> > > Please let me know what you think.
> > >
> >
> > All good on my end.
> > I've made a couple of minor comments that
> > could be addressed on commit if no other issues are found.
>
> All good on my end as well. I've applied all the minor updates, tested the
> result and pushed it out to fsnotify branch of my tree. WRT to your new
> FS_ERROR LTP tests, I've noticed that the testcases 1 and 3 from test
> fanotify20 fail for me. After a bit of debugging this seems to be a bug in
> ext4 where it calls ext4_abort() with EXT4_ERR_ESHUTDOWN instead of plain
> ESHUTDOWN. Not sure if you have that fixed or how come the tests passed for
> you. After fixing that ext4 bug everything passes for me.
>

Gabriel mentioned that bug in the cover letter of the LTP series :-)
https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u

Thanks,
Amir.
