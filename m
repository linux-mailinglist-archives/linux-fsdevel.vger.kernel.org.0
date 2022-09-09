Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0865B3B42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiIIOz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiIIOzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07012B286
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662735347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwNONOcL2d/SK9BVP2KAZ92hk6qHDpZvrWgAYuhJXus=;
        b=QheYo69xoB9gYGAnsgeIBDC7esNSK03OeyvG7DI1lt1RJFbBN+g+rHHplP69d+1CDOXIiH
        m0UtKzNaRRQkY63cilKlxAZ9ObzuDtOLHsPv+tyC/QId0YsaSC0RfGA6xqZkCEMp7T5CuD
        9R5inol5YaB7q/ZR2mWjNhaZRTwTrnA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-jllXjL3VMDG0J8Fm4n6_7Q-1; Fri, 09 Sep 2022 10:55:41 -0400
X-MC-Unique: jllXjL3VMDG0J8Fm4n6_7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57DE13C0ED4E;
        Fri,  9 Sep 2022 14:55:41 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.9.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC6D240D296C;
        Fri,  9 Sep 2022 14:55:40 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Fri, 09 Sep 2022 10:55:40 -0400
Message-ID: <13104070.uLZWGnKmhe@x2>
Organization: Red Hat
In-Reply-To: <YxtP9kttFi5TxtcJ@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com> <4748798.GXAFRqVoOG@x2> <YxtP9kttFi5TxtcJ@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, September 9, 2022 10:38:46 AM EDT Richard Guy Briggs wrote:
> > Richard,  add subj_trust and obj_trust. These can be 0|1|2 for no, yes,
> > unknown.
> 
> type?  bitfield?  My gut would say that "0" should be "unset"/"unknown",
> but that is counterintuitive to the values represented.
>
> Or "trust" with sub-fields "subj" and "obj"?

No. just make them separate and u32. subj_trust and obj_trust - no sub fields. 
If we have sub-fields, that probably means bit mapping and that wasn't wanted.

-Steve


