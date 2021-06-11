Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388313A42CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFKNOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhFKNOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:14:14 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E9C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 06:11:59 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id f21so3728431vsl.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2mQncfrs7AfFiUrkmQW6cIH8U36siV+Y7SfstDBq4I=;
        b=YzjcMGP3UQnO1hid52zVsZw/+JgVMd/sqhgVfs3xBOo3bzdZT1WGZorX2pxsstxlb3
         iFVI7wbbEnZ1b/cR6Dw6q6JOZ6TcCe2M+4onbA89UQr39g/N1fQzaIDeGPDkcp98Unm0
         CShXp+XTdvNwziAQdxfL58laQ18gC4Q30Z5p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2mQncfrs7AfFiUrkmQW6cIH8U36siV+Y7SfstDBq4I=;
        b=A1uXC8mAH6cxBstj45zRuuHFBA5wP/o9tAeCc8ws19EQ4j6HtRER092uVWeZk/dhQ5
         umQl7xiEtkG7gQzEM2Dps6tiRriuPQ9q19isWSodEE+Tk2ON85VGYE93lvCcUjyKAzOK
         zuXstXUGZg3Y3q3xzoqVSNk5RN2CumpGmPJ+huOVV+YDTT3msC6Stsc3++RLCbVWNmMD
         k9S1ostGgduuuRZae6NXfWMgdLcGZm6Oz6J5W2AntNMmsRyotD/mTtY8CiB1ywZhwYCm
         wu7aI3uh8rYTgnO4iQkry8/T8eGRcYik/rVr/tKBIo1gzo5xhP+9+LavpQ9HG7G53ia/
         bxcA==
X-Gm-Message-State: AOAM530hSAQZBUWl3B/RLTpqN1/aHTBQF84vq1erORAED0VL7Gi9o09S
        LlE5nW4msWyH6b5WYEb5H3dzq99fsCWkGwiXAEyMPg==
X-Google-Smtp-Source: ABdhPJxj0V9vxqoFypjA280EKBMwJ2AFeJIrnkSVjOVglthbez6K67JSmvz1TPy2KBfxtjG5A/4uCeX4rTda/o3xcv8=
X-Received: by 2002:a67:f659:: with SMTP id u25mr4911654vso.9.1623417119022;
 Fri, 11 Jun 2021 06:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
In-Reply-To: <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 15:11:48 +0200
Message-ID: <CAJfpegvYeNjWKc_9Aah+8NMicTus1CqqwQqLGUeYiQSKN9=gmQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] kernfs: use i_lock to protect concurrent inode updates
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 10:52, Ian Kent <raven@themaw.net> wrote:
>
> The inode operations .permission() and .getattr() use the kernfs node
> write lock but all that's needed is to keep the rb tree stable while
> updating the inode attributes as well as protecting the update itself
> against concurrent changes.
>
> And .permission() is called frequently during path walks and can cause
> quite a bit of contention between kernfs node operations and path
> walks when the number of concurrent walks is high.
>
> To change kernfs_iop_getattr() and kernfs_iop_permission() to take
> the rw sem read lock instead of the write lock an additional lock is
> needed to protect against multiple processes concurrently updating
> the inode attributes and link count in kernfs_refresh_inode().
>
> The inode i_lock seems like the sensible thing to use to protect these
> inode attribute updates so use it in kernfs_refresh_inode().
>
> The last hunk in the patch, applied to kernfs_fill_super(), is possibly
> not needed but taking the lock was present originally and I prefer to
> continue to take it so the rb tree is held stable during the call to
> kernfs_refresh_inode() made by kernfs_get_inode().
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
