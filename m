Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E73A959C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPJNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPJNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:13:42 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F01C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 02:11:37 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id k71so450493vka.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiD8Z4XvGnBbwGrshb7UXxHT652dqAyMkCuowMB3MT0=;
        b=nmmxCvEXPxXX714K3Ah58M3prp7FPXm5e0dbGyXk+UgncTPwPlVXjXsXU08PpM8eus
         H2zwAYPoDsUexMBqU2+Iaj0cMPUzXmcyCxrPE2ceTieDAjlYVPw7LMj+m5qVLkDvN3fL
         LrB8P3AMMg1jl0L34uchh+aloIhljQlPmNMUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiD8Z4XvGnBbwGrshb7UXxHT652dqAyMkCuowMB3MT0=;
        b=awY7SyiVnPq+Mn3Ru2xUy2PW4WAvm44yXRs/xlnX0V82NU1wo61BECZb7mR5LbOOV8
         9dWBtbIYBGW1HGZUVWOqPpbU5/faNwcxCLWXVXJpe+wLySVhgL6xf/xGhVdadhLPkf2l
         gJpRjqSwUlyr14BC7dT9HI3tdaXl1Qyd/fwzxRPgpuj22HZOSJTrYaFC4dpoySQH82G+
         KWvECZSmP79msDfoqa05uYUYOG57pB9wwN/VDvsYLnAwngYCOG99vl6jyseXROYuGEi0
         j2VjwNy8IOeCKqR/zsVsKfZKdeZVx2nPvnS7nagWKYBnpz1Qr8uDYTQVL3FwFW7t0NZ5
         Eotg==
X-Gm-Message-State: AOAM532QgwV/IFMIz0H3JMX8W4LuEryeEch7gqQQOfBFeYEUbX/aDrK0
        3z0O2Po50N0KoQmMrYgq0jHJ8VVuqQlAI+ieuLJtzg==
X-Google-Smtp-Source: ABdhPJyZ8Fh4vDeTPBSXAyBN+qYc9L8PH55Fh2rEBhC5gLAKhWPXbJkX/QSaqRzQ2faLmW7Rl9wn1UqCRaAbYMplXwo=
X-Received: by 2002:a1f:90c8:: with SMTP id s191mr8299008vkd.3.1623834695969;
 Wed, 16 Jun 2021 02:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
 <162375276735.232295.14056277248741694521.stgit@web.messagingengine.com>
In-Reply-To: <162375276735.232295.14056277248741694521.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Jun 2021 11:11:25 +0200
Message-ID: <CAJfpegtgXvW+vyKQEvQauSXskYiO+GAjViDYo_84sa23eWCjdw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] kernfs: add a revision to identify directory node changes
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

On Tue, 15 Jun 2021 at 12:26, Ian Kent <raven@themaw.net> wrote:
>
> Add a revision counter to kernfs directory nodes so it can be used
> to detect if a directory node has changed during negative dentry
> revalidation.
>
> There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> on all architectures and as far as I know that assumption holds.
>
> So adding a revision counter to the struct kernfs_elem_dir variant of
> the kernfs_node type union won't increase the size of the kernfs_node
> struct. This is because struct kernfs_elem_dir is at least
> sizeof(pointer) smaller than the largest union variant. It's tempting
> to make the revision counter a u64 but that would increase the size of
> kernfs_node on archs where sizeof(pointer) is smaller than the revision
> counter.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
