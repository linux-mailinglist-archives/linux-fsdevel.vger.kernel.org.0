Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCC2697CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjBONDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjBONDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90BD32E59
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676466126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kO8N6JLykhQ4YdfKs2d43b+gPORvqK7xPAz9ypT+Zk=;
        b=ChQXqeMqdW+QnogcPSvUwwiVHsWkjON+7pvbwLVNRByY7t+xWvvnoUtFoKH8vOTdoV1g64
        k7dRasoPguYkz1T9MaR1Nx5wO2wenWF4oYdV7QML8MacYAhyI5DNBgU3AkzB0XMt0BgNFn
        4MD9edPySNGvBlDbDreZEXc6ridb0FE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-BxtiEXZhM5WJBsv1CLOnxg-1; Wed, 15 Feb 2023 08:02:02 -0500
X-MC-Unique: BxtiEXZhM5WJBsv1CLOnxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 842BD3C10691;
        Wed, 15 Feb 2023 13:02:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57EA9140EBF4;
        Wed, 15 Feb 2023 13:01:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230215-topic-next-20230214-revert-v1-2-c58cd87b9086@linaro.org>
References: <20230215-topic-next-20230214-revert-v1-2-c58cd87b9086@linaro.org> <20230215-topic-next-20230214-revert-v1-0-c58cd87b9086@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] Revert "splice: Do splice read from a buffered file without using ITER_PIPE"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3055588.1676466118.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 13:01:58 +0000
Message-ID: <3055589.1676466118@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Konrad Dybcio <konrad.dybcio@linaro.org> wrote:

> next-20230213 introduced commit d9722a475711 ("splice: Do splice read fr=
om
> a buffered file without using ITER_PIPE") which broke booting on any
> Qualcomm ARM64 device I grabbed, dereferencing a null pointer in
> generic_filesplice_read+0xf8/x598. Revert it to make the devices
> bootable again.
> =

> This reverts commit d9722a47571104f7fa1eeb5ec59044d3607c6070.
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Commit d9722a47571104f7fa1eeb5ec59044d3607c6070 was part of v13 of my
patches.  This got replaced yesterday by a newer version which may or may =
not
have made it into linux-next.

This is probably a known bug fixed in the v14 by making shmem have its own
splice-read function.

Can you try this?

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Diov-extract

(Also, can you include me in the cc list as I'm the author of the patch yo=
u
reverted?)

Thanks,
David

