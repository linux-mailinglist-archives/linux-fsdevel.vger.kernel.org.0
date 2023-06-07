Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2B7257F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjFGIhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjFGIhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C17173A
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686127019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGNGuZdb3YfUa/RgZYBAS20b4KQ6QaroF4WQ7qei7lo=;
        b=g00XpsYu6hKespguJJy/MK1b2zmoUbfdIGUWlE785EZFdTp8chntqu1ZAp8ZTz2PNiaJ4N
        VTYzIrrHyouPX5Q2cLl9XFjqY0ArNfT8vrXY5n5YFY+bYDc8Gj6IQrY7Vx2+WDyNnz4eqp
        P+EzQtDrcDvpb3C46wxi71Wej9XQ8bU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-GM9I-4gjMCKvH9c3tuCwwQ-1; Wed, 07 Jun 2023 04:36:54 -0400
X-MC-Unique: GM9I-4gjMCKvH9c3tuCwwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9674D3801FF5;
        Wed,  7 Jun 2023 08:36:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10C6EC1603B;
        Wed,  7 Jun 2023 08:36:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230530232914.3689712-3-mcgrof@kernel.org>
References: <20230530232914.3689712-3-mcgrof@kernel.org> <20230530232914.3689712-1-mcgrof@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dhowells@redhat.com, keescook@chromium.org, yzaikin@google.com,
        jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, j.granados@samsung.com, brauner@kernel.org,
        ebiederm@xmission.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: move security keys sysctl registration to its own file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2003476.1686127009.1@warthog.procyon.org.uk>
Date:   Wed, 07 Jun 2023 09:36:49 +0100
Message-ID: <2003477.1686127009@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> wrote:

> The security keys sysctls are already declared on its own file,
> just move the sysctl registration to its own file to help avoid
> merge conflicts on sysctls.c, and help with clearing up sysctl.c
> further.
> 
> This creates a small penalty of 23 bytes:
> 
> ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> add/remove: 2/0 grow/shrink: 0/1 up/down: 49/-26 (23)
> Function                                     old     new   delta
> init_security_keys_sysctls                     -      33     +33
> __pfx_init_security_keys_sysctls               -      16     +16
> sysctl_init_bases                             85      59     -26
> Total: Before=21256937, After=21256960, chg +0.00%
> 
> But soon we'll be saving tons of bytes anyway, as we modify the
> sysctl registrations to use ARRAY_SIZE and so we get rid of all the
> empty array elements so let's just clean this up now.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: David Howells <dhowells@redhat.com>

