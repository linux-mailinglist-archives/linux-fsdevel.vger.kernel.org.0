Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1020E778419
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHJXYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHJXYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BFC2713
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691709842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1baEt9dGWhpInhHnHI73Bb3tBuRezL7Z2A69hej+88=;
        b=EL4/lej3n2Z7IAQokIcKO6p1wM+sJbCtY3UoFCMqBGc4S/0PqkMHhOtmtm0pxq+4kDGUxI
        +r/MDkoycbyoy23y/13RNSVb5umo6D8EVTSACw8uHrD8/NjLDl7+dBJdtWVnWgW8cVTuTV
        FMkS7srJZ+k9fa/7YMxNTzZP5bmCCyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-aEpp3QgzMbG4VOfZNAeReg-1; Thu, 10 Aug 2023 19:23:56 -0400
X-MC-Unique: aEpp3QgzMbG4VOfZNAeReg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85EF5857A84;
        Thu, 10 Aug 2023 23:23:55 +0000 (UTC)
Received: from lebethron.zaitcev.lan (unknown [10.22.8.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B976A140E96E;
        Thu, 10 Aug 2023 23:23:53 +0000 (UTC)
Date:   Thu, 10 Aug 2023 18:23:53 -0500
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 0/5] tmpfs: user xattrs and direct IO
Message-ID: <20230810182353.4e0209d8@lebethron.zaitcev.lan>
In-Reply-To: <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
        <20230809-postkarten-zugute-3cde38456390@brauner>
        <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner>
        <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Aug 2023 22:50:39 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> And big thank you to you and Jan and Carlos for the very quick and
> welcoming reviews.  If only Hugh were able to respond like that...

No negative self-talk. My own naive submission was sitting in my
mailbox since February 2020, so at least you're doing it! Seriously,
thanks a lot for finding the cycles.

-- Pete

