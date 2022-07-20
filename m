Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F7E57B849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiGTOP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 10:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiGTOP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17E3A1B7B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658326556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFK3tkfEyTe6jEh19UggWd/zo4/NbtsoQCP905aDbQo=;
        b=gucKQA5ScqwJ2Z/a3RZwP9n8hMvlsfHs7wGaFCVkTehQ4rQ6BB1kwhoJB6Boyo2q85tvLY
        fnEwYc7qGbDav7U2StTzqjS6TkApAVPk3dj2hg8KzhUh+7OdAU+MgICBRzq58LoDqmhMld
        hBcnrzdop7KEqpnYARKosA/cHDw8cMA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-dU7N4XjZMdq_AqhedIGCSg-1; Wed, 20 Jul 2022 10:15:50 -0400
X-MC-Unique: dU7N4XjZMdq_AqhedIGCSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 139ED280F2AE;
        Wed, 20 Jul 2022 14:15:50 +0000 (UTC)
Received: from fedora (unknown [10.40.194.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E29ADC1D3AD;
        Wed, 20 Jul 2022 14:15:48 +0000 (UTC)
Date:   Wed, 20 Jul 2022 16:15:46 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Message-ID: <20220720141546.46l2d7bxwukjhtl7@fedora>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:51:33AM -0400, Jeff Layton wrote:
> Back in 2018, I did a patchset [1] to rework the inode->i_version
> counter handling to be much less expensive, particularly when no-one is
> querying for it.
> 
> Testing at the time showed that the cost of enabling i_version on ext4
> was close to 0 when nothing is querying it, but I stopped short of
> trying to make it the default at the time (mostly out of an abundance of
> caution). Since then, we still see a steady stream of cache-coherency
> problems with NFSv4 on ext4 when this option is disabled (e.g. [2]).
> 
> Is it time to go ahead and make this option the default on ext4? I don't
> see a real downside to doing so, though I'm unclear on how we should
> approach this. Currently the option is twiddled using MS_I_VERSION flag,
> and it's unclear to me how we can reverse the sense of such a flag.
> 
> Thoughts?
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4b7fd7d34de5765dece2dd08060d2e1f7be3b39
> [2]: https://bugzilla.redhat.com/show_bug.cgi?id=2107587

Hi,

I don't have the results myself yet, but a quick look at how it is done
suggests that indeed the impact should be low. But not zero, at least
every time the inode is loaded from disk it is scheduled for i_version
update on the next attempted increment. Could that have an effect on
some particular common workload you can think of?

How would we approach making iversion a default? libmount is passing
this option to the kernel as just a MS_I_VERSION flag that is set when
-o iversion is used and left empty when the -o noiversion is used. This
means that while we could make it a default in ext4, we don't have any
way of knowing whether the user asked for -o noiversion. So that's not
really an option.

Updating the mke2fs/tune2fs to allow setting iversion as a default mount
option I think has the same problem.

So the only way I can see ATM would be to introduce another mountflag
for libmount to indicate -o noiversion. This way we can make iversion a
default on ext4 without loosing the information about user provided -o
noiversion option.

Is there a different way I am not seeing?


If we can do reasonably extensive testing that will indeed show
negligible impact when nothing is querying i_version, then I would be in
favor of the change.

Thanks!
-Lukas

> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

