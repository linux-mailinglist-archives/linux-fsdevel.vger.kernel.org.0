Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB462B3A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKPHBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 02:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKPHB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A513F92
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 23:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668582028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6OIcgGNpadwxLbIdYcGcd+Dz1Vbz9BtruCXW1wedl5c=;
        b=hF5rEcV0nM4/8Nryd+Bx7xR7mX1bzZ2zUPwDz4zY+rg3LUt2d1pSrAwHMcIqg5tkYZVBzM
        oE+ZFPe1eTghsAlaVT/8cyU6lJ0NaYn5gR8qh2Gyj2Un1QwoKa2ITio0jaCmQkrtphDutD
        zN7op86NbirKgeoTtEgPjPaP9hxeoFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-zRSdwYDdOdWwS3fYJIStDw-1; Wed, 16 Nov 2022 02:00:24 -0500
X-MC-Unique: zRSdwYDdOdWwS3fYJIStDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C798805AC8;
        Wed, 16 Nov 2022 07:00:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFEF5C1908B;
        Wed, 16 Nov 2022 07:00:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
References: <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org> <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     dhowells@redhat.com, smfrench@gmail.com, tom@talpey.com,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2147869.1668582019.1@warthog.procyon.org.uk>
Date:   Wed, 16 Nov 2022 07:00:19 +0000
Message-ID: <2147870.1668582019@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stefan Metzmacher <metze@samba.org> wrote:

> I'm not sure I understand why this would fix anything when encryption is
> enabled.
> 
> Is the payload still be offloaded as plaintext? Otherwise we wouldn't have
> use_rdma_mr...  So this rather looks like a fix for the non encrypted case.

The "inline"[*] PDUs are encrypted, but the direct RDMA data transmission is
not.  I'm not sure if this is a bug in ksmbd.  As I understand it, encrypting
and decrypting the directly transferred data would need to be done by the NIC,
not the cifs driver.

David

[*] I don't know the correct RDMA terminology for these things.

