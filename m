Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE162F5AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 14:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbiKRNPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 08:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiKRNPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6459175
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668777249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwgnOjsBwuRm3KvaCsNzS6B7/KxJyL7ZVpx0OHwNOwA=;
        b=C04F8QIJBjjsddSNPZ51GWKK9KcMztKXaHhay6vaAvzAmApw5PVWLM0t0k7U4BsKcLyNTr
        7tVEyobA3+MXLfsQunlKNf1cyYzNP6zhbk5jyf57GyYeTyMesbHkzNYt8Y4VDdjfWpkMQR
        BzGV5qwV/Q3lRtv6hF2vgKtpjZ+XFHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-gGjGeDE0NEeha0WFuDPt1Q-1; Fri, 18 Nov 2022 08:14:02 -0500
X-MC-Unique: gGjGeDE0NEeha0WFuDPt1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD4F1811E75;
        Fri, 18 Nov 2022 13:14:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65BF640C83EC;
        Fri, 18 Nov 2022 13:14:01 +0000 (UTC)
Date:   Fri, 18 Nov 2022 14:13:58 +0100
From:   Niels de Vos <ndevos@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y3eFFrhT3b0yoti9@ndevos-x1>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y20a/akbY8Wcy3qg@mit.edu>
 <Y20rDl45vSmdEo3N@ndevos-x1>
 <Y3HZ/To8z76vBqYo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3HZ/To8z76vBqYo@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 13, 2022 at 10:02:37PM -0800, Christoph Hellwig wrote:
> On Thu, Nov 10, 2022 at 05:47:10PM +0100, Niels de Vos wrote:
> > And, there actually are options like CONFIG_EXT4_FS_POSIX_ACL and
> > CONFIG_EXT4_FS_SECURITY. Because these exist already, I did not expect
> > too much concerns with proposing a CONFIG_EXT4_FS_ENCRYPTION...
> 
> ext4 is a little weird there as most file systems don't do that.
> So I think these should go away for ext4 as well.

Yeah, I understand that there is a preference for reducing the number of
Kconfig options for filesystems. That indeed would make it a little
easier for users, so I am supportive of that as well.

> > Note that even with the additional options, enabling only
> > CONFIG_FS_ENCRYPTION causes all the filesystems that support fscrypt to
> > have it enabled. For users there is no change, except that they now have
> > an option to disable fscrypt support per filesystem.
> 
> But why would you do that anyay?

An other mail in this thread contains a description about that. It is
more about being able to provide a kernel build that is fully tested,
and enabling more options (or being unable to disable features)
increases the testing efforts that are needed.

However, as Ted pointed out, there are other features that can not be
disabled or limited per filesystem, so there will always be a gap in
what can practically be tested.

Thanks,
Niels

