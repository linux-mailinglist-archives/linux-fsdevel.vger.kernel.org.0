Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3750857B981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiGTPXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiGTPXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92EFD5B7A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658330582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUcxIoB2J7OZSdoCp00xQlFV5PxUPCmzZjIlgAQpABg=;
        b=iRBOy7ZziRxlnJgPbKF09AVDKyIaYNVafa+8BSoiZVdwTUEGVrsysPyNTiQPZNhEw2jPGI
        7ZMIApxVvsKtcpVrUWc5F7eW0Wt+/V9kcT5890EWISJzXZ7JtFU1TQQKpxSCTshexRcGEL
        Eo1iz/qivytzHYP18tnLgICJaMdBZtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-NSpBIl2VOkWCl7pVBu4WtA-1; Wed, 20 Jul 2022 11:23:01 -0400
X-MC-Unique: NSpBIl2VOkWCl7pVBu4WtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 508538F3EE0;
        Wed, 20 Jul 2022 15:23:00 +0000 (UTC)
Received: from fedora (unknown [10.40.194.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 419AE1121314;
        Wed, 20 Jul 2022 15:22:59 +0000 (UTC)
Date:   Wed, 20 Jul 2022 17:22:57 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Message-ID: <20220720152257.t67grnm4wdi3dpld@fedora>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
 <20220720141546.46l2d7bxwukjhtl7@fedora>
 <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:38:31AM -0400, Jeff Layton wrote:
> On Wed, 2022-07-20 at 16:15 +0200, Lukas Czerner wrote:

--snip--

> > How would we approach making iversion a default? libmount is passing
> > this option to the kernel as just a MS_I_VERSION flag that is set when
> > -o iversion is used and left empty when the -o noiversion is used. This
> > means that while we could make it a default in ext4, we don't have any
> > way of knowing whether the user asked for -o noiversion. So that's not
> > really an option.
> > 
> > Updating the mke2fs/tune2fs to allow setting iversion as a default mount
> > option I think has the same problem.
> > 
> > So the only way I can see ATM would be to introduce another mountflag
> > for libmount to indicate -o noiversion. This way we can make iversion a
> > default on ext4 without loosing the information about user provided -o
> > noiversion option.
> > 
> > Is there a different way I am not seeing?
> > 
> 
> Right, implementing this is the difficult bit actually since this uses a
> MS_* flag. If we do make this the default, we'd definitely want to
> continue allowing "-o noiversion" to disable it.
> 
> Could we just reverse the default in libmount? It might cause this to
> suddenly be enabled in some deployments, but in most cases, people
> wouldn't even notice and they could still specify -o noiversion to turn
> it off.

Can be done, but that would change the default for everyone. Not sure if
that desirable. Also I can image this being a bit confusing. I still
think the best approach would be to introduce another MS_ flag for
noiversion case. I think there is precedence in the case of
MS_STRICTATIME - not exactly the same but similar enough.

> Another idea would be to introduce new mount options for this, but
> that's kind of nasty from a UI standpoint.
> 
> > 
> > If we can do reasonably extensive testing that will indeed show
> > negligible impact when nothing is querying i_version, then I would be in
> > favor of the change.
> > 
> 
> Excellent! I think that would be best if we can get away with it. A lot
> of people are currently running ext4-backed nfs servers and aren't using
> that mount option.

Could you provide some performance numbers for iversion case?

Thanks!
-Lukas

> -- 
> Jeff Layton <jlayton@kernel.org>
> 

