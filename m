Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7062BFD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 14:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiKPNnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 08:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiKPNmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:42:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874E2A246
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 05:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668606116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hthprm1ypSC4H9RqIYyAtXvnaUxVWoTWmoLjvcjOG60=;
        b=dh+wlneHHDkIdnRnE0uf2FtATU34mEV9e4GzFP2P+yMfa05m8FdroxD3SD14cJN3buycPv
        KrgVaJaGEYtVKAKpuUMovgigOy3y6yFc5HIzwNSZrXv8zHdYQoiMbNT2XevbQHMDzKBLDw
        8u7K0Zx7VSxRwh94gokynhckoXnK1FY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-OEYROdlKO_qh-fNyr-TMBw-1; Wed, 16 Nov 2022 08:41:46 -0500
X-MC-Unique: OEYROdlKO_qh-fNyr-TMBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0D6A101CC6D;
        Wed, 16 Nov 2022 13:41:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 723EE140EBF3;
        Wed, 16 Nov 2022 13:41:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
References: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org> <20221116104502.107431-1-jefflexu@linux.alibaba.com> <20221116104502.107431-2-jefflexu@linux.alibaba.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Jingbo Xu <jefflexu@linux.alibaba.com>,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read() callback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2968418.1668606101.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 16 Nov 2022 13:41:41 +0000
Message-ID: <2968419.1668606101@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_c=
ache_resources *cres,
> > +					loff_t *_start, size_t *_len,
> > +					unsigned long *_flags, loff_t i_size)
>
> _start is never changed, so it should be passed by value instead of by
> pointer.

Hmmm.  The intention was that the start pointer should be able to be moved
backwards by the cache - but that's not necessary in ->prepare_read() and
->expand_readahead() is provided for that now.  So yes, the start pointer
shouldn't get changed at this point.

> I'd also reverse the position of the arguments for _flags and i_size.
> Otherwise, the CPU/compiler have to shuffle things around more in
> cachefiles_prepare_ondemand_read before they call this.

Better to pass the flags in and then ignore them.  That way it can tail ca=
ll,
or just call cachefiles_do_prepare_read() directly from erofs.  If you're
going to have a wrapper, then you might be just as well create a
netfs_io_subrequest struct on the stack.

David

