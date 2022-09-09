Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32D5B3F08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIISu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIISu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A48673A
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662749426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9Dh8pEyMDv7C3f0d4E6QH8pWeVCfeTh7yGFQY5CPq0=;
        b=eOlf8zeduOg0EQympAnrT7U8sFPKqMgSuRxuqmuCXpwewuPMhzcP6SLErCXu1HkQWNcEWw
        MBSxX2Xkv0dKNKKUy9ph5HUW2lo4Wks03F2wO+W/Frxva7YDguG9LCERUIR4XOJaHDsHks
        kT4OWNaGiOnWBYe5i8Jv2nqYBGq33lM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-S0jFSYMdNviySDb1ypgl6A-1; Fri, 09 Sep 2022 14:50:22 -0400
X-MC-Unique: S0jFSYMdNviySDb1ypgl6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12242101A56C;
        Fri,  9 Sep 2022 18:50:22 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD452026D4C;
        Fri,  9 Sep 2022 18:50:20 +0000 (UTC)
Date:   Fri, 9 Sep 2022 14:50:18 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <YxuK6qTfeHfmp4B6@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com>
 <4748798.GXAFRqVoOG@x2>
 <YxtP9kttFi5TxtcJ@madcap2.tricolour.ca>
 <13104070.uLZWGnKmhe@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13104070.uLZWGnKmhe@x2>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-09-09 10:55, Steve Grubb wrote:
> On Friday, September 9, 2022 10:38:46 AM EDT Richard Guy Briggs wrote:
> > > Richard,  add subj_trust and obj_trust. These can be 0|1|2 for no, yes,
> > > unknown.
> > 
> > type?  bitfield?  My gut would say that "0" should be "unset"/"unknown",
> > but that is counterintuitive to the values represented.
> >
> > Or "trust" with sub-fields "subj" and "obj"?
> 
> No. just make them separate and u32. subj_trust and obj_trust - no sub fields. 
> If we have sub-fields, that probably means bit mapping and that wasn't wanted.

Ack.

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

