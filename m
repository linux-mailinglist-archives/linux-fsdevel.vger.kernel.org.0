Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336C50DFAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiDYMLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiDYMLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 483D558E47
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650888480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3I28rQJDnhHxMtAGkz1SevfRVOxy1YWGVvIDo5VbNQY=;
        b=Js4DkiPcqNGlExWSUd6KnaIVSAtBPuISRf/Df1m3IaHI8AdVDehRj5aDVwZLdrwqV8XiRk
        b8aB1aKjptP2ScXyFpQ0kSAwCh6HjDU5QPm6UF8AI8EtK2JOloPtLxJ6jVOUnIb/16ozq8
        tqpoZ4NPVTHoDXZoF8BXlxczwQekTFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-OAw2PWF8O5CZiGHgMX8hCw-1; Mon, 25 Apr 2022 08:07:56 -0400
X-MC-Unique: OAw2PWF8O5CZiGHgMX8hCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3EC580005D;
        Mon, 25 Apr 2022 12:07:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB599E71;
        Mon, 25 Apr 2022 12:07:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yk9V/03wgdYi65Lb@casper.infradead.org>
References: <Yk9V/03wgdYi65Lb@casper.infradead.org> <Yk5W6zvvftOB+80D@casper.infradead.org> <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk> <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk> <469869.1649313707@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/14] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3118842.1650888461.1@warthog.procyon.org.uk>
Date:   Mon, 25 Apr 2022 13:07:41 +0100
Message-ID: <3118843.1650888461@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> OK.  You suggested that releasepage was an acceptable place to call it.
> How about we have AS_RELEASE_ALL (... or something ...) and then
> page_has_private() becomes a bit more complicated ... to the point
> where we should probably get rid of it (by embedding it into
> filemap_release_folio():

I'm not sure page_has_private() is quite so easy to get rid of.
shrink_page_list() and collapse_file(), for example, use it to conditionalise
a call to try_to_release_page() plus some other bits.

I think that, for the moment, I would need to add a check for AS_RELEASE_ALL
to page_has_private().

David

