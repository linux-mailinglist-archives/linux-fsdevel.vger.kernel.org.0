Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF613A423B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFKMsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFKMsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:48:12 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0523C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 05:46:06 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id l12so2544924uai.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjHrb1dtK2G/VbmUcqAkZXLppuMhMD3yMja93ulZGQA=;
        b=TDYoRaMYnwSoHRfHhL8DdQgmyyazxTWd+5D9U6VCh6/4Cqe+HB+jQIwNMTGVAepTi/
         EG8SMJmsDCwnfL7FNv9ubkMR7fxAyaiyOaUuzrCpG6AQ0ECcse3JAlaW1CpYbpIgrCqL
         kXP81kGnaSZ+bsP/LfqD63ZHfNlQLgSxrUIg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjHrb1dtK2G/VbmUcqAkZXLppuMhMD3yMja93ulZGQA=;
        b=Uqhy+5jmt3XKD+3ZEpyEwT7AB/uXTHVxJn44xaBMSTvb+IoimO4ehVu8iUOVHvYIZs
         5EbC2nF4FFyoT9shY9TsDU1Ui32hzHX7kgwec9OoGq0z4YtgkpQnAr31wx572XNyu8nP
         pL0/stxRAPZBZhEnQZt+YOj04FqNcRFDIVR78BiIDe0DmgcD7geNIc/jcZ8TCx7SHT6X
         WfJaRwyWsIqsE05ucuqctfAT6rjaRW4fPfrgfPrSBPbNE9HcerH9JgW8KW9fTDcVgJlH
         ashbM9HmjagmXSxwcrI+N1fAanruDAjz8tkIPWnKTPwm/TdePvP76zkHg6VrGAf1i/Ze
         OVIg==
X-Gm-Message-State: AOAM530eN/XDFv/vmbcqDaGQmoPei0w+J6OFvk7wvsSZOoWQKaSiVNCR
        MWl6SsK+wc98GhqxBp6bJBOIyMyzkcrHmgnaTRXRKg==
X-Google-Smtp-Source: ABdhPJxsTaNkmd6IAo6MBi8zrtu0rXXBlRV5F5kC0pToscPzFB5ElGS3yZW1yf0MnsJxWIjkZkCPso9bS6w7O+CpmE8=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr2723800uap.11.1623415565376;
 Fri, 11 Jun 2021 05:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322857790.361452.16044356399148573870.stgit@web.messagingengine.com>
In-Reply-To: <162322857790.361452.16044356399148573870.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 14:45:54 +0200
Message-ID: <CAJfpegvsi7CjdGORphOZTHg_fEdwidszhyKT94CRQJ3bYLogBQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] kernfs: move revalidate to be near lookup
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

On Wed, 9 Jun 2021 at 10:49, Ian Kent <raven@themaw.net> wrote:
>
> While the dentry operation kernfs_dop_revalidate() is grouped with
> dentry type functions it also has a strong affinity to the inode
> operation ->lookup().
>
> It makes sense to locate this function near to kernfs_iop_lookup()
> because we will be adding VFS negative dentry caching to reduce path
> lookup overhead for non-existent paths.
>
> There's no functional change from this patch.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
