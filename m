Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1E4664B1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 19:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjAJSi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 13:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjAJSiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B58D5F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673375568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=isX/xl/Gk4O2RcsWO9IXu2O1CLN73hFphddfEk/12nc=;
        b=GkDgtAlptI7r0IZhyUyP42LmEKr20awq+4ld6qmOpld1o1Lco9UnYd/jdcDN8Dj5E4AH/i
        l/L5zwfu8NZeZxgI6g9Tr4VZ71UQsUppICQ4EOeeP1r3cwckQJsbD0tCIsbCx82/r/wipy
        o2qGMvoITOT/wcAIxrASHdDRXkudjyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-CeJyOlZoPEOV_EaDDCckkQ-1; Tue, 10 Jan 2023 13:32:44 -0500
X-MC-Unique: CeJyOlZoPEOV_EaDDCckkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED2F8811E9C;
        Tue, 10 Jan 2023 18:32:43 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3EF0492B00;
        Tue, 10 Jan 2023 18:32:42 +0000 (UTC)
Date:   Tue, 10 Jan 2023 13:32:40 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v5 3/3] fanotify, audit: Allow audit to use the full
 permission event response
Message-ID: <Y72vSB+dEgD4HMCN@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com>
 <3211441.aeNJFYEL58@x2>
 <Y7zWlFbrrNcfGauJ@madcap2.tricolour.ca>
 <4778109.GXAFRqVoOG@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4778109.GXAFRqVoOG@x2>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-01-10 10:26, Steve Grubb wrote:
> Hello Richard,
> 
> On Monday, January 9, 2023 10:08:04 PM EST Richard Guy Briggs wrote:
> > When I use an application that expected the old API, meaning it simply
> > does:
> > > 
> > > response.fd = metadata->fd;
> > > response.response = reply;
> > > close(metadata->fd);
> > > write(fd, &response, sizeof(struct fanotify_response));
> > > 
> > > I get access denials. Every time. If the program is using the new API and
> > > sets FAN_INFO, then it works as expected. I'll do some more testing but I
> > > think there is something wrong in the compatibility path.
> > 
> > I'll have a closer look, because this wasn't the intended behaviour.
> 
> I have done more testing. I think what I saw might have been caused by a 
> stale selinux label (label exists, policy is deleted). With selinux in 
> permissive mode it's all working as expected - both old and new API.

Ah good, thank you.

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

