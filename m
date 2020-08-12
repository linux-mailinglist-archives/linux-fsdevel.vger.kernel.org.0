Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7588242C1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 17:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHLPWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 11:22:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54498 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbgHLPWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597245755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDh0PVbFmTAjxTuN6pRKl4F3Ayg+hzteD+Qm6hAhSXE=;
        b=WDnoPwLOOeLa9+rusiS1zX0JW28BwerD/G50nB5IweoYYPaypZIHvt+PQL2TxGBLDvCNDa
        7U2H/QYU9RTiIsPuvmnCAnPEd001l9md3Pc1MgL7VDGBPkTO38vsRQwzK6ggX97/CVWXz4
        TJkNQbyrcejOH8IKMBgH0svlKOQ1bQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-IIXQZXrePlKe_3WN_cCaxA-1; Wed, 12 Aug 2020 11:22:32 -0400
X-MC-Unique: IIXQZXrePlKe_3WN_cCaxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EE0B800D55;
        Wed, 12 Aug 2020 15:22:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA7B760CCA;
        Wed, 12 Aug 2020 15:22:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
References: <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com> <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com> <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com> <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com> <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com> <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com> <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com> <20200812143957.GQ1236603@ZenIV.linux.org.uk> <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com> <20200812150807.GR1236603@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <144851.1597245746.1@warthog.procyon.org.uk>
Date:   Wed, 12 Aug 2020 16:22:26 +0100
Message-ID: <144852.1597245746@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> Why does it have to have a struct mount?  It does not have to use
> dentry/mount based path lookup.

file->f_path.mnt

David

