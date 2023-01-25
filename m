Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6A67B307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjAYNLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjAYNLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE9753E6A
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674652237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S4aCTlmusSBeoV7pRyVwlsoOpJeNAMFzR7Diw02ed+A=;
        b=Guul77biHQdqjcRlGfN2jgq3DsdLvN0lRanCh+Q79QH9b713kHmqN7aDjjme2mvPy+TyG1
        FG+QJwjwvVNkqnnlDdo5FYTlr4FxGLh74AKYEYkpvq32tT6GfWikr/tqWNNZ65SkCLUivS
        MwR+0BOlZCwcNqIW6gVKbmVS45DK0sw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-HUe-KsSpMvCcXG6thL8mgA-1; Wed, 25 Jan 2023 08:10:36 -0500
X-MC-Unique: HUe-KsSpMvCcXG6thL8mgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB5E53828886;
        Wed, 25 Jan 2023 13:10:35 +0000 (UTC)
Received: from localhost (unknown [10.39.195.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 741BD2026D4B;
        Wed, 25 Jan 2023 13:10:35 +0000 (UTC)
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
Date:   Wed, 25 Jan 2023 14:10:33 +0100
In-Reply-To: <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 25 Jan 2023 14:46:59 +0200")
Message-ID: <87fsbybvzq.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

>> >
>> > Based on Alexander's explanation about the differences between overlayfs
>> > lookup vs. composefs lookup of a regular "metacopy" file, I just need to
>> > point out that the same optimization (lazy lookup of the lower data
>> > file on open)
>> > can be done in overlayfs as well.
>> > (*) currently, overlayfs needs to lookup the lower file also for st_blocks.
>> >
>> > I am not saying that it should be done or that Miklos will agree to make
>> > this change in overlayfs, but that seems to be the major difference.
>> > getxattr may have some extra cost depending on in-inode xattr format
>> > of erofs, but specifically, the metacopy getxattr can be avoided if this
>> > is a special overlayfs RO mount that is marked as EVERYTHING IS
>> > METACOPY.
>> >
>> > I don't expect you guys to now try to hack overlayfs and explore
>> > this path to completion.
>> > My expectation is that this information will be clearly visible to anyone
>> > reviewing future submission, e.g.:
>> >
>> > - This is the comparison we ran...
>> > - This is the reason that composefs gives better results...
>> > - It MAY be possible to optimize erofs/overlayfs to get to similar results,
>> >   but we did not try to do that
>> >
>> > It is especially important IMO to get the ACK of both Gao and Miklos
>> > on your analysis, because remember than when this thread started,
>> > you did not know about the metacopy option and your main argument
>> > was saving the time it takes to create the overlayfs layer files in the
>> > filesystem, because you were missing some technical background on overlayfs.
>>
>> we knew about metacopy, which we already use in our tools to create
>> mapped image copies when idmapped mounts are not available, and also
>> knew about the other new features in overlayfs.  For example, the
>> "volatile" feature which was mentioned in your
>> Overlayfs-containers-lpc-2020 talk, was only submitted upstream after
>> begging Miklos and Vivek for months.  I had a PoC that I used and tested
>> locally and asked for their help to get it integrated at the file
>> system layer, using seccomp for the same purpose would have been more
>> complex and prone to errors when dealing with external bind mounts
>> containing persistent data.
>>
>> The only missing bit, at least from my side, was to consider an image
>> that contains only overlay metadata as something we could distribute.
>>
>
> I'm glad that I was able to point this out to you, because now the comparison
> between the overlayfs and composefs options is more fair.
>
>> I previously mentioned my wish of using it from a user namespace, the
>> goal seems more challenging with EROFS or any other block devices.  I
>> don't know about the difficulty of getting overlay metacopy working in a
>> user namespace, even though it would be helpful for other use cases as
>> well.
>>
>
> There is no restriction of metacopy in user namespace.
> overlayfs needs to be mounted with -o userxattr and the overlay
> xattrs needs to use user.overlay. prefix.

if I specify both userxattr and metacopy=on then the mount ends up in
the following check:

if (config->userxattr) {
	[...]
	if (config->metacopy && metacopy_opt) {
		pr_err("conflicting options: userxattr,metacopy=on\n");
		return -EINVAL;
	}
}

to me it looks like it was done on purpose to prevent metacopy from a
user namespace, but I don't know the reason for sure.

> w.r.t. the implied claim that composefs on-disk format is simple enough
> so it could be made robust enough to avoid exploits, I will remain
> silent and let others speak up, but I advise you to take cover,
> because this is an explosive topic ;)
>
> Thanks,
> Amir.

