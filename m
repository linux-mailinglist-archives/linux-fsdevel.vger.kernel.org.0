Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3B507590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiDSQuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347611AbiDSQuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E17E93AA45
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650386827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWvAKy8LocH47YhakvpIBQwKMnIJQQng3vxQEYIL7zc=;
        b=VX9Lea2KWKzJbjxUJB+5eNsXFpCLEh2LP7F4CyPIdOU1zFfTPqSS2LoYo0YSoNfkgMna/l
        wBH6fgiAxG90QkwsxU6bRgklaiCJVMoqE5EQsMdYVfcXV1ETi5SEqAXrjQdn1DBJwuliqu
        C4SVV9PSezIi3S8OhVzbYj3AfM4UvRw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-EaA8j95MOtSsSpdXOLr65A-1; Tue, 19 Apr 2022 12:47:03 -0400
X-MC-Unique: EaA8j95MOtSsSpdXOLr65A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34F563820F64;
        Tue, 19 Apr 2022 16:47:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B4A740E80E0;
        Tue, 19 Apr 2022 16:47:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yl7mQr05hPg4vELb@rabbit.intern.cm-ag>
References: <Yl7mQr05hPg4vELb@rabbit.intern.cm-ag> <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <454834.1650373340@warthog.procyon.org.uk> <508603.1650385022@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <510135.1650386821.1@warthog.procyon.org.uk>
Date:   Tue, 19 Apr 2022 17:47:01 +0100
Message-ID: <510136.1650386821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> I don't think any write is misaligned.  This was triggered by a
> WordPress update, so I think the WordPress updater truncated and
> rewrote all files.  Random guess: some pages got transferred to the
> NFS server, but the local copy in fscache did not get updated.

Do the NFS servers change the files that are being served - or is it just
WordPress pushing the changes to the NFS servers for the web servers to then
export?

David

