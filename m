Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D764267BAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjAYTqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 14:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjAYTqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:46:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA2564A0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674675951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxReU7OtDHr372Wv68SqBu8t7buHYmfZ4ed0qaGXjK4=;
        b=ERt+aCOkanvcxPBam9cLXL8QBmFLiaIEorJaNRwis7anbAlyB/i1PGQcs2x59NRGxovqbH
        x9lIeO5GGDFUFpxyJ3s3iRlc+P2YcWJL9H6udlRhOK2BLP4W4cHWSxaIPhWUs6tLxK9SBU
        z5DDwPG/fQxXGOEby4gTnsPqlWJuPvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-vp5M5eS9O2Sttrm5PnG-dw-1; Wed, 25 Jan 2023 14:45:48 -0500
X-MC-Unique: vp5M5eS9O2Sttrm5PnG-dw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E45CD88B7A0;
        Wed, 25 Jan 2023 19:45:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72563492B01;
        Wed, 25 Jan 2023 19:45:47 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
References: <cover.1674227308.git.alexl@redhat.com>
        <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
        <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
        <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
        <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
        <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
        <20230125041835.GD937597@dread.disaster.area>
        <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
        <87wn5ac2z6.fsf@redhat.com>
        <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
        <87o7qmbxv4.fsf@redhat.com>
        <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
        <87fsbybvzq.fsf@redhat.com>
        <CAOQ4uxgos8m72icX+u2_6Gh7eMmctTTt6XZ=BRt3VzeOZH+UuQ@mail.gmail.com>
Date:   Wed, 25 Jan 2023 20:45:45 +0100
In-Reply-To: <CAOQ4uxgos8m72icX+u2_6Gh7eMmctTTt6XZ=BRt3VzeOZH+UuQ@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 25 Jan 2023 20:07:26 +0200")
Message-ID: <87wn5a9z4m.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

>> >> I previously mentioned my wish of using it from a user namespace, the
>> >> goal seems more challenging with EROFS or any other block devices.  I
>> >> don't know about the difficulty of getting overlay metacopy working in a
>> >> user namespace, even though it would be helpful for other use cases as
>> >> well.
>> >>
>> >
>> > There is no restriction of metacopy in user namespace.
>> > overlayfs needs to be mounted with -o userxattr and the overlay
>> > xattrs needs to use user.overlay. prefix.
>>
>> if I specify both userxattr and metacopy=on then the mount ends up in
>> the following check:
>>
>> if (config->userxattr) {
>>         [...]
>>         if (config->metacopy && metacopy_opt) {
>>                 pr_err("conflicting options: userxattr,metacopy=on\n");
>>                 return -EINVAL;
>>         }
>> }
>>
>
> Right, my bad.
>
>> to me it looks like it was done on purpose to prevent metacopy from a
>> user namespace, but I don't know the reason for sure.
>>
>
> With hand crafted metacopy, an unpriv user can chmod
> any files to anything by layering another file with different
> mode on top of it....

I might be missing something obvious about metacopy, so please correct
me if I am wrong, but I don't see how it is any different than just
copying the file and chowning it.  Of course, as long as overlay uses
the same security model so that a file that wasn't originally possible
to access must be still blocked, even if referenced through metacopy.

> Not sure how the composefs security model intends to handle
> this scenario with userns mount, but it sounds like a similar
> problem.

composefs, if it is going to be used from a user namespace, should be
doing the same check as overlay and do not allow accessing files that
weren't accessible before.  It could be even stricter than overlay, and
expect the payload files to be owned by the user who mounted the file
system (or be world readable) instead of any ID mapped inside the user
namespace.

Thanks,
Giuseppe

