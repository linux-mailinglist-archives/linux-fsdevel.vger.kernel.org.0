Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25763589ECC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiHDPiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiHDPiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD1B21D0E2
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Aug 2022 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659627496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yog9DRxVr54iQAe1p9ahsjOiy30Sl9RiTZ3r7Sc6V88=;
        b=LYI9aDfBg3VMYo0YUJxaf+CppoJF6Id1LJph1rQy8Sq2KucTaDM8ESRcCsPOSNt/1+CXLx
        dkYFDi+4q/52AkNcpOe9fFGJI/YsfCAz57nRJ/7BufR/2p1kApVKgdnVXYhNl3eH/7N3k5
        T1imySVAHUVSn8sD7vZiyJ7g4ml5pDM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-QsAES3BkMXC2cZWKAdz1-w-1; Thu, 04 Aug 2022 11:38:15 -0400
X-MC-Unique: QsAES3BkMXC2cZWKAdz1-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD34A8037AA;
        Thu,  4 Aug 2022 15:38:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51A0CC15D4F;
        Thu,  4 Aug 2022 15:38:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk>
References: <165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: Fix automount superblock LSM init problem, preventing sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3366905.1659627492.1@warthog.procyon.org.uk>
Date:   Thu, 04 Aug 2022 16:38:12 +0100
Message-ID: <3366906.1659627492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Meh.  Forgot to commit before mailing.  I've posted a v2 with the smack
changes and a change to make SELinux check reference != NULL instead of
fc->purpose == FS_CONTEXT_FOR_SUBMOUNT.

David

