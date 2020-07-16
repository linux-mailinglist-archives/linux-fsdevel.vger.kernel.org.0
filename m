Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F922256B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgGPOZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgGPOZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:25:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC66C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 07:25:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so6215421ion.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioi5do9NUqS5zmOL316wDAPtluvXGy4ADGyQVij9gDo=;
        b=TYatR+eUwmemfHFAK4Pmr4RWzY3+5PhPX1OLDhE40LqnGnAr9QUD9Lrd5MIR7o+kR7
         ZmIr5VulCbJXWtCfCvnwpvrUVCLbPAvJJ2mb6Oa6lhVmHPJV7NWWPf018xXeqmJbohhH
         3XyToQ8vkVv84s6ZOKSNCXSdzfc4a4nNDUZh48jLYPAzt5SHxGvLW1OXKNBMw6AU7OmA
         k+10n02sUe4ECIRxAdh1Qp6Ebcck49aoRhdqpLGPXjZAHnGfC9MXZVBAXgwBE94WWRx/
         LkRBGruCkO4xibTco43kg2y1UVY2jsdPBWzuovC1j11YE0Gt4oD6powBUvvyMPi4mf9E
         WeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioi5do9NUqS5zmOL316wDAPtluvXGy4ADGyQVij9gDo=;
        b=eJU5eDoaNSefVTYsWadRHzPmqPt9f5arNgwbL7327JVDsCwnFzDRU+Qio8zpo4r2rf
         BqEooYpLZABemkacuNAXrBD472gUSRiO0Gg1tvfsQ47Ef0bA6R2F8CjkOlcD30VuFOyS
         zu3REqJqC3uherNZEqG3MgCjB1Kmz6dw7icXMLA0FGQW8JRFf5SZPErJQXfs/6zamJ0L
         HLsXRqDaLW/mJweeEQr75g5Fo0id9bvX3iKaMbzErEMf3ncv4rC9Im0j6FAyr9DeyBbi
         4RyH2x+Mi74blscXklNirP7vCBPGUKi664hyFyQNUOUVgqN0ftNa9fZSK8KzAjFsEAZz
         jBww==
X-Gm-Message-State: AOAM531mYbhQ0PLkxntomF0SPXojZTJdYODbe/AqtMF/CDZHh6ofXzcI
        RakzAm6j9MvX7MjSgmfSBWvP3uIUAZACCl9hZ98=
X-Google-Smtp-Source: ABdhPJz6XN2/uU1aaf4FrKTAVU2Ft9Qpw8/9+rOlrE95Eco9FjzeYIoq40zwv1IfbuZdcG8kyRu9JcPmiHE27GI/D+w=
X-Received: by 2002:a6b:b483:: with SMTP id d125mr4747384iof.186.1594909538343;
 Thu, 16 Jul 2020 07:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-13-amir73il@gmail.com>
 <20200716125211.GB5022@quack2.suse.cz>
In-Reply-To: <20200716125211.GB5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 17:25:27 +0300
Message-ID: <CAOQ4uxjFcGGw8Dr+57cwBgpdThpoZrMP-AQvPO9Gn8Lv-V8vvA@mail.gmail.com>
Subject: Re: [PATCH v5 12/22] inotify: report both events on parent and child
 with single callback
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 3:52 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 11:42:20, Amir Goldstein wrote:
> > fsnotify usually calls inotify_handle_event() once for watching parent
> > to report event with child's name and once for watching child to report
> > event without child's name.
> >
> > Do the same thing with a single callback instead of two callbacks when
> > marks iterator contains both inode and child entries.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Another idea for possible future cleanup here: Everybody except for
> fanotify cares only about inode marks and reporting both parent and child
> only complicates things for them (and I can imagine bugs being created by
> in-kernel fsnotify users because they misunderstand inode-vs-child mark
> types etc.). So maybe we can create another fsnotify_group operation
> similar to ->handle_event but with simpler signature for these simple
> notification handlers and send_to_group() will take care of translating
> the complex fsnotify() call into a sequence of these simple callbacks.
>

Yeh we could do that.
But then it's not every day that a new in-kernel fsnotify_group is added...

Thanks,
Amir.
