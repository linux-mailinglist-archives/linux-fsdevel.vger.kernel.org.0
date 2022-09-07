Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190E5B0DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIGULv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIGULt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8666D9F0
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662581507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8e+cKhEsRBLNJIALtFAqGedx8wto8TjTS4Lu/Z9SW0E=;
        b=Y5WJu81XHHxyopvqv33tcPRp+bv085/mCuiXQzmmV8fHjFXLHW/yhnTtJALUXIPgc4F+An
        Hvdg8YbKo2FcnLn4atjFuyfQ/OWa3xGOkJbK91Rf4Nvo1F4GqH2mZaaigPELxOQsMxOk4S
        vJEI/tfSxt1owB1dGM1Q6Es//I9bzig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-T1C38poHNcaiVTTuJXmVqw-1; Wed, 07 Sep 2022 16:11:46 -0400
X-MC-Unique: T1C38poHNcaiVTTuJXmVqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B106101AA47;
        Wed,  7 Sep 2022 20:11:46 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.33.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9941840C141D;
        Wed,  7 Sep 2022 20:11:45 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Wed, 07 Sep 2022 16:11:45 -0400
Message-ID: <4753948.GXAFRqVoOG@x2>
Organization: Red Hat
In-Reply-To: <YxjmassY2yXOYtgo@madcap2.tricolour.ca>
References: <cover.1659996830.git.rgb@redhat.com> <CAHC9VhStnE9vGu9h5tHnS58eyb8vm8rMN4miXpLAG6fFnidD=w@mail.gmail.com> <YxjmassY2yXOYtgo@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs wrote:
> > > Ultimately I guess I'll leave it upto audit subsystem what it wants to
> > > have in its struct fanotify_response_info_audit_rule because for
> > > fanotify subsystem, it is just an opaque blob it is passing.
> > 
> > In that case, let's stick with leveraging the type/len fields in the
> > fanotify_response_info_header struct, that should give us all the
> > flexibility we need.
> > 
> > Richard and Steve, it sounds like Steve is already aware of additional
> > information that he wants to send via the
> > fanotify_response_info_audit_rule struct, please include that in the
> > next revision of this patchset.  I don't want to get this merged and
> > then soon after have to hack in additional info.
> 
> Steve, please define the type and name of this additional field.

Maybe extra_data, app_data, or extra_info. Something generic that can be 
reused by any application. Default to 0 if not present.

Thanks,
-Steve


