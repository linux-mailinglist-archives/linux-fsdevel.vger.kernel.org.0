Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17F51922A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 01:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbiECXNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 19:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbiECXNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 19:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABBC942A2B
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651619396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOtTfklybxzZCSEMsPzUimB8kRcfo61buiS4NtgbKGM=;
        b=HiQU/ZX8h3wO9tzl/Aei86IqA/IgczosHq7C4v95kbo0hKwuSQYcTUQnJDMkWA+keADtRB
        BfgidjDSCZKg4qQm+4+ZwQoZaKMJ62n8iDpzGRF6/fXrBjU74ZWlx+e4zTI2gG+bVzuQYY
        Z8obdouu4fMsWgMTDo3P9dY4Db1p874=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-ZIA2uvX2Nb-hQEsTeqkgaA-1; Tue, 03 May 2022 17:10:18 -0400
X-MC-Unique: ZIA2uvX2Nb-hQEsTeqkgaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 613271C05EAB;
        Tue,  3 May 2022 21:07:42 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 462655523FB;
        Tue,  3 May 2022 21:07:41 +0000 (UTC)
Date:   Tue, 3 May 2022 17:07:39 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/3] fanotify: Ensure consistent variable type for
 response
Message-ID: <YnGZmw8yuD+6ON29@madcap2.tricolour.ca>
References: <cover.1651174324.git.rgb@redhat.com>
 <aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com>
 <CAHC9VhSFOx1d_7-XnbobjZXjps_mXq3S33T_5E=PmNAeyqAsdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSFOx1d_7-XnbobjZXjps_mXq3S33T_5E=PmNAeyqAsdw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-02 20:16, Paul Moore wrote:
> On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > The user space API for the response variable is __u32. This patch makes
> > sure that the whole path through the kernel uses __u32 so that there is
> > no sign extension or truncation of the user space response.
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/12617626.uLZWGnKmhe@x2
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Link: https://lore.kernel.org/r/aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com
> > ---
> >  fs/notify/fanotify/fanotify.h      | 2 +-
> >  fs/notify/fanotify/fanotify_user.c | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> It seems like audit_fanotify()/__audit_fanotify() should also be
> changed, yes?  Granted, in this case it's an unsigned int to u32
> conversion so not really all that critical, but if you are going to
> update the fanotify code you might as well update the audit code as
> well for the sake of completeness.

Yes, that was somewhere in the back of my mind but forgot to come back
to it.  Thanks for catching that.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

