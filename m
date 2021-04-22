Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58DC367FB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhDVLlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 07:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235977AbhDVLlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619091632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMXkQKD92XEqLOdKkZ9LkipLsjeMEu880iIF7KLHuos=;
        b=chw1jN+O8cqmDNjYIkWdTstywOyo9fpqJ1TkIE/wzFtmIY+BOD28UKoKkZaV+mMSBly+LR
        zghfC624zL232SalnBNvGdNLciJcdJSP7WAWem4MK4aeo189iO/GU3HfsgeCJSI2RWm+nJ
        0JVpqax0ZL7v9BCWWqeGvEIdWr+ct9w=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-DzQZyDLLN3usfo1nP9K6Fw-1; Thu, 22 Apr 2021 07:39:52 -0400
X-MC-Unique: DzQZyDLLN3usfo1nP9K6Fw-1
Received: by mail-yb1-f198.google.com with SMTP id d8-20020a25eb080000b02904e6f038cad5so19504061ybs.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMXkQKD92XEqLOdKkZ9LkipLsjeMEu880iIF7KLHuos=;
        b=Y7PETXszru2nfri0TsUO2UEUl75V1v89U3y3vz4jMK5OMPjI3AckyKe78UasFigM5n
         eDTyvtJx6mpZZGGV6AW33DJAhhv0uV/pL1+Ai/n+HoRxqxlsjDV91OW7gKSfDHe5KuOF
         NPjSIjOAwcagU+3Rps1uUoTRMrJFDTL3GT7AyTHa9QFa3CaXuOhfkuhIuOdreMTwRqvs
         tD2BN8godviLYRsAuZ2Ti//6/+imgoBBg3wh/mnDwywtu2kMdWat0KXj0dLuStjxdcOI
         FthNJNcODh2LJgWx9IZ8uzTUkMP58oq/+JOjsI/ahxo0dkLlRyPVJ9GD9UTVYX1GJYF3
         nmBw==
X-Gm-Message-State: AOAM531pwTChgUGk1UUlSPt4rCXeaTozjzk+McTm9FcrcPrkJOCAWG53
        Y6gf2Ao48b5bjPFd7W9GOK8eJVRsLm/BndVw/spmBEYo7NxMq0flpmXZc9O008vlENp3m5nh93k
        29EAk+eYY/fcguQlDb1BwNeIC6u32eqwJHfsj6CfX/g==
X-Received: by 2002:a25:7085:: with SMTP id l127mr4068969ybc.293.1619091591518;
        Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyhE6DS/eW1dR9xemDwBcQEmjxrQY+fv1G9l6m2UGwYtINpsqaUV9AJsTDjlsF+gV/DTMftEHXE3GlbORd3Hk=
X-Received: by 2002:a25:7085:: with SMTP id l127mr4068951ybc.293.1619091591336;
 Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
In-Reply-To: <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 22 Apr 2021 13:39:39 +0200
Message-ID: <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This series aims to correct a design flaw in the original anon_inode
> > SELinux support that would make it hard to write policies for anonymous
> > inodes once more types of them are supported (currently only userfaultfd
> > inodes are). A more detailed rationale is provided in the second patch.
> >
> > The first patch extends the anon_inode_getfd_secure() function to accept
> > an additional numeric identifier that represents the type of the
> > anonymous inode being created, which is passed to the LSMs via
> > security_inode_init_security_anon().
> >
> > The second patch then introduces a new SELinux policy capability that
> > allow policies to opt-in to have a separate class used for each type of
> > anon inode. That means that the "old way" will still
>
> ... will what? :)

Whoops, I thought I had gone over all the text enough times, but
apparently not :) It should have said something along the lines of:

...will still work and will be used by default.

>
> I think it would be a very good idea if you could provide some
> concrete examples of actual policy problems encountered using the
> current approach.  I haven't looked at these patches very seriously
> yet, but my initial reaction is not "oh yes, we definitely need this".

An example is provided in patch 2. It is a generalized problem that we
would eventually run into in Fedora policy (at least) with the
unconfined_domain_type attribute and so far only hypothetical future
types of anon inodes.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

