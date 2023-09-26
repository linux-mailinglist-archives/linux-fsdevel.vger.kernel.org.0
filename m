Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05AF7AEECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjIZOkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjIZOkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633B124
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695739151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XllbBqxTvNzfuhH1RFsYE8Y8P6H7hYsJSRNMnTexg+M=;
        b=GC5kb3tVC7t/WmGQ3HfCI6ZTrylsPE2nFdWqFwbunBsjUIzF+vbL/E0qXXUlWwtRBmOK46
        xNpJaqWy0VVn4Kl2lyb33ZyD+zOwU67STyv51Iq2dBcvzUqy2N1uN4cb6S28HmAQynVtlu
        rCQsPI3LJ2XRKFEmxfCfhlC7xAjaxbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-Fk0Y759GO-SfTiZBEIRSlA-1; Tue, 26 Sep 2023 10:39:08 -0400
X-MC-Unique: Fk0Y759GO-SfTiZBEIRSlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CB3F8039D2;
        Tue, 26 Sep 2023 14:39:07 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 268471004058;
        Tue, 26 Sep 2023 14:39:05 +0000 (UTC)
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
        <87wmwdnhj1.fsf@oldenburg.str.redhat.com>
        <CAJfpegvKECAFNhWYKfGbSWVX8pycQxsHnCr6KSqrQrR+u77yAg@mail.gmail.com>
Date:   Tue, 26 Sep 2023 16:39:03 +0200
In-Reply-To: <CAJfpegvKECAFNhWYKfGbSWVX8pycQxsHnCr6KSqrQrR+u77yAg@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 26 Sep 2023 16:33:50 +0200")
Message-ID: <87bkdpngmw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Miklos Szeredi:

> On Tue, 26 Sept 2023 at 16:19, Florian Weimer <fweimer@redhat.com> wrote:
>
>> getdents gets away with this buffer size because applications can copy
>> out all the data from struct dirent if they need long-term storage.
>> They have to do that because the usual readdir interface overwrites the
>> buffer, potentially at the next readdir call.  This means the buffer
>> size does not introduce an amount of memory fragmention that is
>> dependent on the directory size.
>>
>> With an opaque, pointer-carrying struct, copying out the data is not
>> possible in a generic fashion.  Only the parts that the application
>> knows about can be copied out.  So I think it's desirable to have a
>> fairly exact allocation.
>
> Okay, so let's add a 'size' field to the struct, which is set to the
> size used (as opposed to the size of the buffer).   That should solve
> copying without wasting a single byte of memory.

That would be helpful.

> Otherwise the format is fully copyable, since the strings are denoted
> with an offset, which doesn't change after the buffer is copied.

I missed the development in that direction.  Yes, offsets would work
nicely in this context.  They help with compat syscalls, too.

If the buffer is relocatable like that, we can even try first with a
reasonably sized on-stack buffer and create an exactly-sized heap
allocation from that.

Thanks,
Florian

