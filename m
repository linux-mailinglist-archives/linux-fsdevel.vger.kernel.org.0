Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508052DE37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244657AbiESUUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 16:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiESUUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 16:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32DFB87A3D
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652991604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/KzPHjCHCtQObe1Y24P096H3Qk3kj52f/NF374wXgs=;
        b=OlM/KZWo0mN4VAc9AAW3L7RNpWG+6iqdqWolLcc4NN/c6cmUXkeuEYk39bcRTiIu/k7IW4
        BdkBBeikjmbu3GHxDtAZjNGlyERTICKi+NsidPMkO3NLQNoKqth5VhvakbGX4aBuToX70y
        ypi+opMcgBi4pNGXwsahMeHMnQMMEwY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-jll-i-JKPQe6hYkxBXhJPQ-1; Thu, 19 May 2022 16:20:02 -0400
X-MC-Unique: jll-i-JKPQe6hYkxBXhJPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9C2E39F9CB6;
        Thu, 19 May 2022 20:20:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C2D240CF8F5;
        Thu, 19 May 2022 20:20:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zOk923ZnSucxitYQFN9m3AY=iOy+j90WrFmqZbKMuOcVsA@mail.gmail.com>
References: <CALF+zOk923ZnSucxitYQFN9m3AY=iOy+j90WrFmqZbKMuOcVsA@mail.gmail.com> <165294669215.3283481.13374322806917745974.stgit@warthog.procyon.org.uk>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        anna@kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: Fix fscache volume key rendering for endianness
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3662003.1652991599.1@warthog.procyon.org.uk>
Date:   Thu, 19 May 2022 21:19:59 +0100
Message-ID: <3662004.1652991599@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> Did someone report the "cache copied between architectures" issue, or
> is that mostly a theoretical problem you noticed?

Ah, I didn't mention.  Checker noticed it (make C=1).

David

