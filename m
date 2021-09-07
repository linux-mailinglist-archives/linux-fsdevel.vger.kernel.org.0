Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC35403063
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbhIGVlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 17:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347288AbhIGVlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631050838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TFUHSqTOgBpyXCJk72fmTEBK22tiTY8OPr/j1HO3TGY=;
        b=NLFq9iQMTwKVrWygZXVAMNeXyK8DHSM927HQNsQbT8V2jxlF3UXN6x/JB3VR/9R/CE/Z1x
        zus8huocADMgEEVARCI1A68Yn6yiq/nhhdME4rD+IXzV9Mr2aq7cdzjRyy6Z1tHxJYaja3
        2rj7yy0iiB6e6zAK9Wf2mxQVDb70pAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-cFUE1bGMNm2M9M7pOz2g5Q-1; Tue, 07 Sep 2021 17:40:37 -0400
X-MC-Unique: cFUE1bGMNm2M9M7pOz2g5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2EE814244;
        Tue,  7 Sep 2021 21:40:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 551DE6060F;
        Tue,  7 Sep 2021 21:40:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D2EE2220257; Tue,  7 Sep 2021 17:40:31 -0400 (EDT)
Date:   Tue, 7 Sep 2021 17:40:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "Fields, Bruce" <bfields@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <YTfcT1JUactPhwSA@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
 <YTYoEDT+YOtCHXW0@work-vm>
 <CAJfpegvbkmdneMxMjYMuNM4+RmWT8S7gaTiDzaq+TCzb0UrQrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvbkmdneMxMjYMuNM4+RmWT8S7gaTiDzaq+TCzb0UrQrw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 04:56:44PM +0200, Miklos Szeredi wrote:
> On Mon, 6 Sept 2021 at 16:39, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> 
> > IMHO the real problem here is that the user/trusted/system/security
> > 'namespaces' are arbitrary hacks rather than a proper namespacing
> > mechanism that allows you to create new (nested) namespaces and associate
> > permissions with each one.
> 
> Indeed.
> 
> This is what Eric Biederman suggested at some point for supporting
> trusted xattrs within a user namespace:
> 
> | For trusted xattrs I think it makes sense in principle.   The namespace
> | would probably become something like "trusted<ns-root-uid>.".
> 
> Theory sounds simple enough.  Anyone interested in looking at the details?

So this namespaced trusted.* xattr domain will basically avoid the need
to have CAP_SYS_ADMIN in init_user_ns, IIUC.  I guess this is better
than giving CAP_SYS_ADMIN in init_user_ns.

Vivek

