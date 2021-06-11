Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F03A42DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhFKNQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 09:16:48 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:34635 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKNQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:16:45 -0400
Received: by mail-ua1-f42.google.com with SMTP id c17so2558923uao.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaDxm7CAMccH6BxkH3jMQSzq1sz+JsTOHJ81BcDQxlc=;
        b=Ex2De4dHAN5GsZSCNxo84B8s/T/KbAuuiZl/QmTRrOZ5HiOuqZh7rYh4QgJVvpYv8B
         fxNg5SPcXBuIk3m7aqDwhkoHklDHFoT7qrk2VlpMKDu05oeWd3ppy767v/LYMxqFwqjE
         aLOK5ZY2PyQCHetjeEqvNAnQU60n064ubIDjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaDxm7CAMccH6BxkH3jMQSzq1sz+JsTOHJ81BcDQxlc=;
        b=Tpb6CtBZUGpwhHhWam1gxH6kbLOLCoKuLQVTn00q6dcRnuvHDL/6mEtvQDozRXwyCq
         1+RK008MKdUc8XyLQWSUcijUOI/KLnrFsUzSC5yNIWnjr86iCr7GWrfTBoXN4fpzmQUv
         lrVQnXUNHQLJFxADzZA6u5TfnvynnujY5/BfqO+E9b7ea3KkqGe4ZQ6pIngiQRolWKF/
         WL7T79KCQrhvLtdXmbiOPnDeXYndcV1RoGiZiVPj8+VO+GFwVAtgHHyMJ2qfGz6zKa/r
         alGm+4bvbJZuOHXXFFL4ApDrrorSSp+YsBVGermp/TnUbZMyiTIKZt4onZa4xUY1upX3
         ZA3w==
X-Gm-Message-State: AOAM530TfkvosMB1115J+SbEFGDwb5bghkdBChTBIOKB+fkiWupaYFey
        TQB0+RYerY/xacRoihOplEGXNkaTkUZx/QdMYdub+Q==
X-Google-Smtp-Source: ABdhPJx44Ziz7vPRZ46bsBmuGBMqTKcmVOpww5OiQk+u1PD4sFDnONguBzgZ3BY8hkisnZD5KFTvHUQILKdDYVrB5YM=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr2923322uao.9.1623417227768;
 Fri, 11 Jun 2021 06:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322872534.361452.17619177755627322271.stgit@web.messagingengine.com>
In-Reply-To: <162322872534.361452.17619177755627322271.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 15:13:37 +0200
Message-ID: <CAJfpegtQd-eYqdSee7CwOFz=uViDV4=P+BmKR_Ciryz1wEe0FQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] kernfs: add kernfs_need_inode_refresh()
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
> Now the kernfs_rwsem read lock is held for kernfs_refresh_inode() and
> the i_lock taken to protect inode updates there can be some contention
> introduced when .permission() is called with concurrent path walks in
> progress.
>
> Since .permission() is called frequently during path walks it's worth
> checking if the update is actually needed before taking the lock and
> performing the update.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
