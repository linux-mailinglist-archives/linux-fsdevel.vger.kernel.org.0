Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2276538CF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiEaIf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiEaIf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 04:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 089AC6F4AA
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653986127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qKNyRC3W7GQfrKZjwEu/nMGpeq6NFxAtL9kib1O0QQ=;
        b=iG7QxjWU2elwwgTr0jvvPk2o0PlVfbIJDIgbAO5bHc+y5vlFIGxeVIQ1p4cBFe8sIO1PxP
        1i+k1y15Imsvbmccg/PhcCukvpqzcTl3PvYsOQ6wD8/RSXmigcKL37L+sWmYGYiG0sSC6d
        M+y4ib4eRmmUOX8loUwLjy7lpzMpMG4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-1OYmHSJBMBaOXHyk4IzOgg-1; Tue, 31 May 2022 04:35:23 -0400
X-MC-Unique: 1OYmHSJBMBaOXHyk4IzOgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26D733816840;
        Tue, 31 May 2022 08:35:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FD602166B26;
        Tue, 31 May 2022 08:35:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YnI7lgazkdi6jcve@rabbit.intern.cm-ag>
References: <YnI7lgazkdi6jcve@rabbit.intern.cm-ag> <Yl75D02pXj71kQBx@rabbit.intern.cm-ag> <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <507518.1650383808@warthog.procyon.org.uk> <509961.1650386569@warthog.procyon.org.uk> <705278.1650462934@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <263651.1653986121.1@warthog.procyon.org.uk>
Date:   Tue, 31 May 2022 09:35:21 +0100
Message-ID: <263652.1653986121@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> On 2022/04/20 15:55, David Howells <dhowells@redhat.com> wrote:
> > I have a tentative patch for this - see attached.
> 
> Quick feedback: your patch has been running on our servers for two
> weeks, and I have received no new complaints about corrupted files.
> That doesn't prove the patch is correct or that it really solves my
> problem, but anyway it's a good sign.  Thanks so far.

Can I put that down as a Tested-by?

David

