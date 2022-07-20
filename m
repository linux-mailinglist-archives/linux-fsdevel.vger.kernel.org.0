Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5257BB69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiGTQ3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiGTQ3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 871394D171
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658334572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucQ5TaXTrdPuaudEuwd2XaNeFmVaJveBPL1sbMmyZv8=;
        b=jSAc2gfKe4gfyxAGYGpCuknJqYuXScn/FlPKq4VrJBSamSf1aIgt/vFhVH47zSlb3zW2rv
        rULIL/Qy95NPUXMsBc+4lQ8twglRcr5XavcuWW22+t0jusYdyAsSDBSnVX5M5H3fsYVH5v
        gnNCBOCDwSxfDwL89TZ8g/IdEz9hq58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-nTPgxi46P460zz5tdxR5iw-1; Wed, 20 Jul 2022 12:29:15 -0400
X-MC-Unique: nTPgxi46P460zz5tdxR5iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50FF0801755;
        Wed, 20 Jul 2022 16:29:15 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 087C61121315;
        Wed, 20 Jul 2022 16:29:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Lukas Czerner" <lczerner@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Date:   Wed, 20 Jul 2022 12:29:12 -0400
Message-ID: <7F6417C7-1261-4C98-96B1-CB15744C04C1@redhat.com>
In-Reply-To: <e84b9caf376a9b958a95ca4e0d088808c482f109.camel@kernel.org>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
 <20220720141546.46l2d7bxwukjhtl7@fedora>
 <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
 <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
 <e84b9caf376a9b958a95ca4e0d088808c482f109.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20 Jul 2022, at 12:15, Jeff Layton wrote:

> On Wed, 2022-07-20 at 11:56 -0400, Benjamin Coddington wrote:
>> On 20 Jul 2022, at 10:38, Jeff Layton wrote:
>>> On Wed, 2022-07-20 at 16:15 +0200, Lukas Czerner wrote:
>>>>
>>>> Is there a different way I am not seeing?
>>>>
>>>
>>> Right, implementing this is the difficult bit actually since this uses a
>>> MS_* flag. If we do make this the default, we'd definitely want to
>>> continue allowing "-o noiversion" to disable it.
>>>
>>> Could we just reverse the default in libmount? It might cause this to
>>> suddenly be enabled in some deployments, but in most cases, people
>>> wouldn't even notice and they could still specify -o noiversion to turn
>>> it off.
>>>
>>> Another idea would be to introduce new mount options for this, but
>>> that's kind of nasty from a UI standpoint.
>>
>> Is it safe to set SB_I_VERSION at export time?  If so, export_operations
>> could grow an ->enable_iversion().
>>
>
> That sounds like it might be problematic.
>
> Consider the case where a NFSv4 client has cached file data and the
> change attribute for the file. Server then reboots, but before the
> export happens a local user makes a change to the file and it doesn't
> update the i_version.

Nfsd currently uses both ctime and i_version if its available, I'd expect
that eliminates this case.

