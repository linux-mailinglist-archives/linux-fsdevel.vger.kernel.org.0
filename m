Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09615AE7D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiIFMVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbiIFMUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28D7B1E9
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662466669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjvVsGnaOPZ/gpG0KVHSfjbjbq9SkmePYc60DJuuWGs=;
        b=cT+7bCVxJgQLFqa1HP+1ZQIb55muguaQsYrHBkRhzzdY6qJycblS0wqgVjnGjsm2aVCYqb
        hXzoqZP/ZbeAJiRe5Lrxcw+TXSvcnlNisF65z641R8AAIrKmOuQSsfyrt0JjQYIGd2Uhdm
        f3eTlgaNZFd3mI0sU6vACDPWA+py8uc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-HSUfhPJXM-2ppp1fdmrDZw-1; Tue, 06 Sep 2022 08:17:46 -0400
X-MC-Unique: HSUfhPJXM-2ppp1fdmrDZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E76891C06901;
        Tue,  6 Sep 2022 12:17:44 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F5940334C;
        Tue,  6 Sep 2022 12:17:39 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
References: <20220901121714.20051-1-jlayton@kernel.org>
        <874jxrqdji.fsf@oldenburg.str.redhat.com>
        <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org>
Date:   Tue, 06 Sep 2022 14:17:38 +0200
In-Reply-To: <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org> (Jeff
        Layton's message of "Thu, 01 Sep 2022 12:30:20 -0400")
Message-ID: <87ilm066jh.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeff Layton:

> All of the existing implementations use all 64 bits. If you were to
> increment a 64 bit value every nanosecond, it will take >500 years for
> it to wrap. I'm hoping that's good enough. ;)
>
> The implementation that all of the local Linux filesystems use track
> whether the value has been queried using one bit, so there you only get
> 63 bits of counter.
>
> My original thinking here was that we should leave the spec "loose" to
> allow for implementations that may not be based on a counter. E.g. could
> some filesystem do this instead by hashing certain metadata?

Hashing might have collisions that could be triggered deliberately, so
probably not a good idea.  It's also hard to argue that random
collisions are unlikely.

> It's arguable though that the NFSv4 spec requires that this be based on
> a counter, as the client is required to increment it in the case of
> write delegations.

Yeah, I think it has to be monotonic.

>> If the system crashes without flushing disks, is it possible to observe
>> new file contents without a change of i_version?
>
> Yes, I think that's possible given the current implementations.
>
> We don't have a great scheme to combat that at the moment, other than
> looking at this in conjunction with the ctime. As long as the clock
> doesn't jump backward after the crash and it takes more than one jiffy
> to get the host back up, then you can be reasonably sure that
> i_version+ctime should never repeat.
>
> Maybe that's worth adding to the NOTES section of the manpage?

I'd appreciate that.

Thanks,
Florian

