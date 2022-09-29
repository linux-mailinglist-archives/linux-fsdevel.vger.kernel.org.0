Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C815EF0BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiI2Iox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiI2Iow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674D26486
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664441090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhURcHiYMgqHQeK9HxVnUCNM0WJFXYGBheggezh9BdQ=;
        b=caJjVlLhY2XXFxdTZcR4D0yEhHsehVW81XTV4uAIz1i8elKEg5W/ee7wmlUobos1GQff+l
        6nlCE879+r0i+LKnKyVfynWy3IftrTS63GBgr2ngp+DqLftddJyy5TidQ1AA/+hdczoLe4
        ykRJjPhDtd1htsWBwy4IB8qiuq4bAFY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-kxELS-fmNRyxf4tVZaqV1g-1; Thu, 29 Sep 2022 04:44:47 -0400
X-MC-Unique: kxELS-fmNRyxf4tVZaqV1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12C201C05144;
        Thu, 29 Sep 2022 08:44:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 232E9140EBF4;
        Thu, 29 Sep 2022 08:44:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220922084442.2401223-6-mszeredi@redhat.com>
References: <20220922084442.2401223-6-mszeredi@redhat.com> <20220922084442.2401223-1-mszeredi@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 05/10] cachefiles: use vfs_tmpfile_open() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3533149.1664441085.1@warthog.procyon.org.uk>
Date:   Thu, 29 Sep 2022 09:44:45 +0100
Message-ID: <3533150.1664441085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> wrote:

> -		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);

Is there any point passing S_IFREG in to vfs_tmpfile()?  Can you actually make
a tmpfile that isn't a regular file?

David

