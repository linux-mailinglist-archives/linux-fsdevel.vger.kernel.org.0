Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7397AEF13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjIZOUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjIZOUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39346101
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695737994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLfoTuiOlkq71LtQIM368ZbzJBNnHFUnsO5iHo6yhEM=;
        b=PPxlBgrtYHGafpRLTGSpS13Na0JUYXtSogG8vhGWbt3L4sEtzeket2P58ap7U7heA/ktJE
        uusPtdLh9nCUcEICysLvzUvtlmF+TPcSTiCDvecWZpWzDvu5bP1TDCc9FvBvH0WChqolYp
        EPzz+klXpF6NqeKARc/Ux9MO+OZZhlc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-Za_WVKlVMr-fkse-WyoN-g-1; Tue, 26 Sep 2023 10:19:50 -0400
X-MC-Unique: Za_WVKlVMr-fkse-WyoN-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 906C03C1ACE4;
        Tue, 26 Sep 2023 14:19:49 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1F78492C37;
        Tue, 26 Sep 2023 14:19:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
References: <20230913152238.905247-1-mszeredi@redhat.com>
        <20230913152238.905247-3-mszeredi@redhat.com>
        <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
        <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
        <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
        <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
        <20230918-grafik-zutreffen-995b321017ae@brauner>
        <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
        <871qeloxj0.fsf@oldenburg.str.redhat.com>
        <CAJfpegupTzdG4=UwguL02c08ZaoX+UK7+=9XQ9D1G4wLMxuqFA@mail.gmail.com>
Date:   Tue, 26 Sep 2023 16:19:46 +0200
In-Reply-To: <CAJfpegupTzdG4=UwguL02c08ZaoX+UK7+=9XQ9D1G4wLMxuqFA@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 26 Sep 2023 16:06:05 +0200")
Message-ID: <87wmwdnhj1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Miklos Szeredi:

>> Try-and-resize interfaces can be quite bad for data obtained from the
>> network.
>
> In this particular case it's all local information.

That's good.

>>  If the first call provides the minimum buffer size (like
>> getgroups, but unlike readlink or the glibc *_r interfaces for NSS),
>> this could at least allow us to avoid allocating too much.  In
>> userspace, we cannot reduce the size of the heap allocation without
>> knowing where the pointers are and what they mean.
>
> Does it matter if the heap allocation is say 32k instead of 589bytes?
>  The returned strings are not limited in size, but are quite unlikely
> to be over PATH_MAX.

It matters if the application needs to keep a copy.

> E.g. getdents apparently uses 32k buffers, which is really a tiny
> amount of heap these days, but more than enough for the purpose.  Not
> sure if this is hard coded into libc or if it's the result of some
> heuristic based on available memory, but I don't see why similar
> treatment couldn't be applied to the statmount(2) syscall.

getdents gets away with this buffer size because applications can copy
out all the data from struct dirent if they need long-term storage.
They have to do that because the usual readdir interface overwrites the
buffer, potentially at the next readdir call.  This means the buffer
size does not introduce an amount of memory fragmention that is
dependent on the directory size.

With an opaque, pointer-carrying struct, copying out the data is not
possible in a generic fashion.  Only the parts that the application
knows about can be copied out.  So I think it's desirable to have a
fairly exact allocation.

>> I also don't quite understand the dislike of variable-sized records.
>> Don't getdents, inotify, Netlink all use them?  And I think at least for
>> Netlink, more stuff is added all the time?
>
> What do you mean by variable sized records?

Iterating through d_reclen-sized subojects (for getdents).

Thanks,
Florian

