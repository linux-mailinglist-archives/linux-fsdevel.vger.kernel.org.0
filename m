Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E745B2D39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 06:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIIEED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 00:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiIIEEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37988D076D
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662696238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slFM8Vfq1w8ltNdHtnQPBjam8+h5JdYTs6yxTf4F8W8=;
        b=hL35hO1UhrEh6y616ZsH5PF8fv+WZyeUxPsS5GaRtC779M5UY5oPAaMYfPxXcApjIx91kl
        xuu3jahHmCk9/WaAuApL+6DGE2857SSWDBkwmNz6mTt0Ul8javamd3S0ecAcRPho2FSUcm
        2W22EdcUnRboXY46uZ4FeThL5rTAlno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-oYY8UzDONviIPnSY1II-wQ-1; Fri, 09 Sep 2022 00:03:54 -0400
X-MC-Unique: oYY8UzDONviIPnSY1II-wQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53DD8811E80;
        Fri,  9 Sep 2022 04:03:54 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.32.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E3D2026D4C;
        Fri,  9 Sep 2022 04:03:53 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Fri, 09 Sep 2022 00:03:53 -0400
Message-ID: <2254543.ElGaqSPkdT@x2>
Organization: Red Hat
In-Reply-To: <Yxqn6NVQr0jTQHiu@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com> <2254258.ElGaqSPkdT@x2> <Yxqn6NVQr0jTQHiu@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, September 8, 2022 10:41:44 PM EDT Richard Guy Briggs wrote:
> > I'm trying to abide by what was suggested by the fs-devel folks. I can
> > live with it. But if you want to make something non-generic for all
> > users of fanotify, call the new field "trusted". This would decern when
> > a decision was made because the file was untrusted or access denied for
> > another reason.
>
> So, "u32 trusted;" ?  How would you like that formatted?
> "fan_trust={0|1}"

So how does this play out if there is another user? Do they want a num= and 
trust=  if not, then the AUDIT_FANOTIFY record will have multiple formats 
which is not good. I'd rather suggest something generic that can be 
interpreted based on who's attached to fanotify. IOW we have a fan_type=0 and 
then followed by info0= info1=  the interpretation of those solely depend on 
fan_type. If the fan_type does not need both, then any interpretation skips 
what it doesn't need. If fan_type=1, then it follows what arg0= and arg1= is 
for that format. But make this pivot on fan_type and not actual names.
 
> > > You mention that you know what you want to put in the struct, why not
> > > share the details with all of us so we are all on the same page and
> > > can have a proper discussion.
> > 
> > Because I want to abide by the original agreement and not impose
> > opinionated requirements that serve no one else. I'd rather have
> > something anyone can use. I want to play nice.
> 
> If someone else wants to use something, why not give them a type of
> their own other than FAN_RESPONSE_INFO_AUDIT_RULE that they can shape
> however they like?

Please, let's keep AUDIT_FANOTIFY normalized but pivot on fan_type.

-Steve


