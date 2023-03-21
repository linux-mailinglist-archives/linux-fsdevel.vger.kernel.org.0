Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED846C3743
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCUQpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCUQo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989E51F8B
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679417035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ni73P6iOwq/z06Tc9mCMwHkprsEWFzyatJbBnmGE7Q8=;
        b=Uo57u9/Sx4m+lXBOPenGtet2NB+Y8dO+s/RqEiUcTQme7jYkYGDPCzLmH/6VQ1slMbCelH
        199TCXNwgpT1rZdBlYf4Y7gJkKb1jRbBGvbORqntdKc+KGiPxgqTux94G/RXJ/R/mWb5Mt
        cTYnuY4E4hESXTRuQPHSiJtYPawsZLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-qaZqdp-zNrahOBtwB2l9Lg-1; Tue, 21 Mar 2023 12:43:52 -0400
X-MC-Unique: qaZqdp-zNrahOBtwB2l9Lg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6FC101A54F;
        Tue, 21 Mar 2023 16:43:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637B3492C13;
        Tue, 21 Mar 2023 16:43:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] keys: Miscellaneous fixes/changes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2851035.1679417029.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Mar 2023 16:43:49 +0000
Message-ID: <2851036.1679417029@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull these fixes/changes for keyrings?

 (1) Fix request_key() so that it doesn't cache a looked up key on the
     current thread if that thread is a kernel thread.  The cache is
     cleared during notify_resume - but that doesn't happen in kernel
     threads.  This is causing cifs DNS keys to be un-invalidateable.

 (2) Fix a wrapper check in verify_pefile() to not round up the length.

 (3) Change asymmetric_keys code to log errors to make it easier for users
     to work out why failures occurred.

Thanks,
David
---
The following changes since commit fc89d7fb499b0162e081f434d45e8d1b47e82ec=
e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/m=
st/vhost (2023-03-13 10:43:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/keys-fixes-20230321

for you to fetch changes up to 3584c1dbfffdabf8e3dc1dd25748bb38dd01cd43:

  asymmetric_keys: log on fatal failures in PE/pkcs7 (2023-03-21 16:23:56 =
+0000)

----------------------------------------------------------------
keyrings fixes

----------------------------------------------------------------
David Howells (1):
      keys: Do not cache key in task struct if key is requested from kerne=
l thread

Robbie Harwood (2):
      verify_pefile: relax wrapper length check
      asymmetric_keys: log on fatal failures in PE/pkcs7

 crypto/asymmetric_keys/pkcs7_verify.c  | 10 +++++-----
 crypto/asymmetric_keys/verify_pefile.c | 32 ++++++++++++++++++-----------=
---
 security/keys/request_key.c            |  9 ++++++---
 3 files changed, 29 insertions(+), 22 deletions(-)

