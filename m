Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEADD62FDDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 20:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiKRTSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 14:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiKRTSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:18:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB16B84A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 11:18:48 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i131so6731436ybc.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46Lq8zuv/x+zWGVVLn8B9wakNtwzIPndWxRzWrLURwI=;
        b=MGOXMi+29GCwoeEFPsCLzpqC6GQd1fnoo6yb4wXlQh/IPqXLDzUy42z8COoPDR7RNl
         n1wa3LjO0IdKfcUjxJ1Yj5HXaWdIIjI5zLXfW+7kS1tJvj6oEejbNd6fQEnNv857kjPr
         P1Qh2dfNfoegYVnhRUAClhh6v8XimaujhUs/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46Lq8zuv/x+zWGVVLn8B9wakNtwzIPndWxRzWrLURwI=;
        b=e3jCCsTuNEMtMjNNO97fYDl3OtJqbRw9t2xGgDIVuNIkr9KC4ZLZ+MM1OUJ+yiKT6u
         LQeV270S65OnJdPVUnyl8cF8giIr8Qjo7tLBqbyhxkuACSHCMeculqXaib0lajjcNz5p
         kWSJGr3hdeNNc85nBBaxh0MJ409qabpGjPZGRebQ9JrfziKcw1VHS1VRDIACy/U9WEdn
         m/m9WqZmjB5ORooMaraqGz2XUHQft69lRB3mLCWBtEIZYjfd8NzJ/wz0txOzftE8i95k
         SMbV2efuNuQZQ4qotvRE+jusghDM9IwXH4rKYT5afdTZ9x37SBW0Ms5puVXQb7Z3cFI0
         lCpw==
X-Gm-Message-State: ANoB5plSSbqBWo/WTin6diH80/lYr6Mc/mqS419UeqH6vsPMatKT6nHX
        nTjFLq4rO9odtmY1hyXG7UN3Bk6cAISFTmmoAYBLGA==
X-Google-Smtp-Source: AA0mqf44IaTG9JRuJ4BfeMH36lPl0NsucVN67sIumTK1NMJiMlkLhTK59DrmL7nZfAiIze+ZiOs31YW0mSz90zBAM5k=
X-Received: by 2002:a25:3c07:0:b0:6c3:f821:4d0b with SMTP id
 j7-20020a253c07000000b006c3f8214d0bmr7823680yba.201.1668799127612; Fri, 18
 Nov 2022 11:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20221024173140.30673-1-ivan@cloudflare.com> <Y3fYu2VCBgREBBau@bfoster>
In-Reply-To: <Y3fYu2VCBgREBBau@bfoster>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 18 Nov 2022 11:18:36 -0800
Message-ID: <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for /proc/pid/fd
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> > +                     const struct path *path, struct kstat *stat,
> > +                     u32 request_mask, unsigned int query_flags)
> > +{
> > +     struct inode *inode = d_inode(path->dentry);
> > +     int rv = 0;
> > +
> > +     generic_fillattr(&init_user_ns, inode, stat);
> > +
>
> Sorry I missed this on v3, but shouldn't this pass through the
> mnt_userns parameter?

The mnt_userns parameter was added in 549c729 (fs: make helpers idmap
mount aware), and it's not passed anywhere in fs/proc.

Looking at other uses of generic_fillattr, all of them use "init_user_ns":

$ rg generic_fillattr fs/proc
fs/proc/proc_net.c
301: generic_fillattr(&init_user_ns, inode, stat);

fs/proc/base.c
1970: generic_fillattr(&init_user_ns, inode, stat);
3856: generic_fillattr(&init_user_ns, inode, stat);

fs/proc/root.c
315: generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);

fs/proc/generic.c
150: generic_fillattr(&init_user_ns, inode, stat);

fs/proc/proc_sysctl.c
841: generic_fillattr(&init_user_ns, inode, stat);
