Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAA6644B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjAJP1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 10:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbjAJP13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596E8E991
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673364372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+NefOpcxugrX/y4MYy0C1CL3s92hQ9uzP66eCvp/+E=;
        b=EBc2qjldm3LpPRmR4SSOHYIqB/O9Rk1/M7WP2JXLhV6rlEGMFD3RpsW45JJVkciIe2iRbz
        GEG9rpP3/CsWVWClw+fs+j63IJoqMo12ANwjq5MwlmQZ6sAUWuEdSC8QQAVijFinR/JnTq
        ZrCvR0n3bOwmDkcEspOPiC4JBFDOxRA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-Afb7B3CoPiGxRwoGcJ0-BQ-1; Tue, 10 Jan 2023 10:26:08 -0500
X-MC-Unique: Afb7B3CoPiGxRwoGcJ0-BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6263B1C08790;
        Tue, 10 Jan 2023 15:26:01 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.9.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C58831121314;
        Tue, 10 Jan 2023 15:26:00 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 3/3] fanotify,audit: Allow audit to use the full permission
 event response
Date:   Tue, 10 Jan 2023 10:26:00 -0500
Message-ID: <4778109.GXAFRqVoOG@x2>
Organization: Red Hat
In-Reply-To: <Y7zWlFbrrNcfGauJ@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com> <3211441.aeNJFYEL58@x2>
 <Y7zWlFbrrNcfGauJ@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Richard,

On Monday, January 9, 2023 10:08:04 PM EST Richard Guy Briggs wrote:
> When I use an application that expected the old API, meaning it simply
> does:
> > 
> > response.fd = metadata->fd;
> > response.response = reply;
> > close(metadata->fd);
> > write(fd, &response, sizeof(struct fanotify_response));
> > 
> > I get access denials. Every time. If the program is using the new API and
> > sets FAN_INFO, then it works as expected. I'll do some more testing but I
> > think there is something wrong in the compatibility path.
> 
> I'll have a closer look, because this wasn't the intended behaviour.

I have done more testing. I think what I saw might have been caused by a 
stale selinux label (label exists, policy is deleted). With selinux in 
permissive mode it's all working as expected - both old and new API.

-Steve


