Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC014733004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjFPLjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 07:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjFPLjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5842713
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686915506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tN5v3o0zv/y8j8TIojIIEgXvfa2nroMudyhxjFLG/U=;
        b=ACJjxrd5EmRGIxfUmqNF7d474/osL9nq8Qs8Vf8RQDEJrmghGGd2pCzVMR7XLwCfQdOiCE
        SBjTM0fmCCig6dYm7JTsyMN8tu7h0DONSyTjTiyK7zQem6tbpRCfMIU/RdPU/QghKNM3uj
        iwUloR+o8ZHU/tx9yLMGXzvljKB/U9U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-CFU_VXqONECwx-pX0zZDJg-1; Fri, 16 Jun 2023 07:38:23 -0400
X-MC-Unique: CFU_VXqONECwx-pX0zZDJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7B8D101A52C;
        Fri, 16 Jun 2023 11:38:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5212E2026D49;
        Fri, 16 Jun 2023 11:38:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSR6Yh=p0QLvYFH168W1_fyNo-wd3WhXdSSuHoYOFmf9mw@mail.gmail.com>
References: <CAOg9mSR6Yh=p0QLvYFH168W1_fyNo-wd3WhXdSSuHoYOFmf9mw@mail.gmail.com> <20230519074047.1739879-1-dhowells@redhat.com>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v20 00/32] splice, block: Use page pinning and kill ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <433152.1686915501.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 16 Jun 2023 12:38:21 +0100
Message-ID: <433153.1686915501@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Diov-extract
> to build 6.4.0-rc2-00037-g0c3c931ab6d1 and ran xfstests
> through with no regressions on orangefs. You can add a
> tested by me if you'd like...

Thanks:-)  I'm pushing this branch in bits, though.  Some of it is in the
block tree and some in the net-next tree.

David

