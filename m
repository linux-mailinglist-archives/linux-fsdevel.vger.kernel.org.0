Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9365594DB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 03:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiHPB0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiHPB01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2C281CDE5D
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660598159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjOJ2ej9e5ff+yIWDnHyj8tdGUgmaChLo0SiD6yuEcY=;
        b=WvzCTugPtnL2TtynknfWhjnLLTpNhTVS//uzw1KuSZU2Cy41UD6BKFH0ZEyAfqsi9/P6SC
        lm32GLeApgzz2IjxerLEdqe4uSeyLkaSneoq/MCEXYDy/q2Ne/DZAHUAsqPglrdfwbtjSs
        x6FqBC/IEi+aPOzgrpTZ1oKEq+hduP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-v-_WRz6XP0eM7eFaWMY6qg-1; Mon, 15 Aug 2022 17:15:56 -0400
X-MC-Unique: v-_WRz6XP0eM7eFaWMY6qg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0180C101A54E;
        Mon, 15 Aug 2022 21:15:56 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.34.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61F4E492C3B;
        Mon, 15 Aug 2022 21:15:55 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 4/4] fanotify,audit: deliver fan_info as a hex-encoded string
Date:   Mon, 15 Aug 2022 17:15:54 -0400
Message-ID: <4748539.GXAFRqVoOG@x2>
Organization: Red Hat
In-Reply-To: <YvRoNSL0snBY87/b@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com> <5623945.DvuYhMxLoT@x2> <YvRoNSL0snBY87/b@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Hello Richard,

On Wednesday, August 10, 2022 10:23:49 PM EDT Richard Guy Briggs wrote:
> > I compiled a new kernel and run old user space on this. The above event
> > is
> > exactly what I see in my audit logs. Why the fan_info=3F? I really would
> > have expected 0. What if the actual rule number was 63? I think this
> > will work better to leave everything 0 with old user space.
> 
> Well, if it is to be consistently hex encoded, that corresponds to "?"

I suppose this OK.

> if it is to be interpreted as a string.  Since the fan_type is 0,
> fan_info would be invalid, so a value of 0 would be entirely reasonable,
> hex encoded to fan_info=00.  It could also be hex encoded to the string
> "(none)".  If you wanted "0" for fan_type=FAN_RESPONSE_INFO_AUDIT_RULE,
> that would be fan_info=30 if it were interpreted as a string, or
> arguably 3F for an integer of rule (decimal) 63.  Ultimately, fan_type
> should determine how fan_info's hex encoded value should be interpreted.
> 
> But ultimately, the point of this patch is to hex encode the fan_info
> field value.

Just one last update, I have been able to test the patches with the user 
space application and it appears to be working from the PoV of what is sent 
is what's in the audit logs. I'm not sure how picky old kernels are wrt the 
size of what's sent. But an unpatched 5.19 kernel seems to accept the larger 
size response and do the right thing.

-Steve


