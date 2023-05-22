Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428EC70C4FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjEVSL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEVSLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 14:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F398115
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684779067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKUTtrSZf3DfIRZQxguiZKn/SOmLlmmRjaQIkqJDKKw=;
        b=U5VPwzNTER1WoJZahAFFhoQoH3eA2iTDoepgG+AJjtj92gv+GP5SdqOdpEjOt8d0E9W9iW
        rsyjiah7Xv6bZmsmxw0iuRTdkYTAjWjnVGjz4Z+rYGxv1A9fTbDHkdYM15dEs+IyToe0tU
        DsMJXBiRAUssW3fj9wQmxyoQLuJ4gso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-9nIKi6-4Nwue84Km_jizCQ-1; Mon, 22 May 2023 14:11:04 -0400
X-MC-Unique: 9nIKi6-4Nwue84Km_jizCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05D1A800B2A;
        Mon, 22 May 2023 18:11:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 857F51121314;
        Mon, 22 May 2023 18:11:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CANT5p=pNFpEj0p+njYw3sVdq9CKgsTdh29Gj6iYDOsMN0ocj1Q@mail.gmail.com>
References: <CANT5p=pNFpEj0p+njYw3sVdq9CKgsTdh29Gj6iYDOsMN0ocj1Q@mail.gmail.com> <2811951.1684766430@warthog.procyon.org.uk>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <smfrench@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix cifs_limit_bvec_subset() to correctly check the maxmimum size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2818726.1684779061.1@warthog.procyon.org.uk>
Date:   Mon, 22 May 2023 19:11:01 +0100
Message-ID: <2818727.1684779061@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> wrote:

> > +               max_size -= len;
> 
> Shouldn't this decrement happen below, after the span has been
> compared with max_size?

It probably doesn't matter.  The compiler is free to move it around, but yes
that and ix++ can both be moved down.

David

