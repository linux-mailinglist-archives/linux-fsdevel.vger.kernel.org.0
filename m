Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51958E990
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiHJJ0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiHJJ0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C56896053A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660123596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REovcAc0irul9Otc+DHjiNYKhgyWXaWXdC+TCEPnc/U=;
        b=IFu79W3O9X4h8A0hQntdnluZjtYEYAINmzoLY69O10ZQ+uC0mcyxG0sSUfR7bECdl78MKs
        6nOV+BPZnNiyfbWo8VPTPJ2rsora3RzjzgKUDb3DuNBELkJqWIXY/rX6ELhIyXq4dZJRR6
        nkqclZc+h6GVALpFmPHhoPBji1qIXpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-V-viqhV2OyKPRUEj6RfDPg-1; Wed, 10 Aug 2022 05:26:33 -0400
X-MC-Unique: V-viqhV2OyKPRUEj6RfDPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7707118A6585;
        Wed, 10 Aug 2022 09:26:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2352A400DFD7;
        Wed, 10 Aug 2022 09:26:31 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] uapi: Remove the inclusion of linux/mount.h from
 uapi/linux/fs.h
References: <163410.1659964655@warthog.procyon.org.uk>
Date:   Wed, 10 Aug 2022 11:26:30 +0200
In-Reply-To: <163410.1659964655@warthog.procyon.org.uk> (David Howells's
        message of "Mon, 08 Aug 2022 14:17:35 +0100")
Message-ID: <87zggce9fd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* David Howells:

> We're seeing issues in autofs and xfstests whereby linux/mount.h (the UAPI
> version) as included indirectly by linux/fs.h is conflicting with
> sys/mount.h (there's a struct and an enum).
>
> Would it be possible to just remove the #include from linux/fs.h (as patch
> below) and rely on those hopefully few things that need mount flags that don't
> use the glibc header for them working around it by configuration?

Wasn't <linux/mount.h> split from <linux/fs.h> relatively recently, and
userspace is probably using <linux/fs.h> to get the mount flag
definitions?

In retrospect, it would have been better to add the new fsmount stuff to
a separate header file, so that we could include that easily from
<sys/mount.h> on the glibc side.  Adhemerval posted a glibc patch to
fake that (for recent compilers):

  [PATCH] linux: Fix sys/mount.h usage with kernel headers
  <https://sourceware.org/pipermail/libc-alpha/2022-August/141316.html>

I think it should work reliably, so that's probably the direction we are
going to move in.

We'll backport this to 2.36, and distributions will pick it up.

Thanks,
Florian

