Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F67AB197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjIVMCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjIVMCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE819A
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 05:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8z1OFlqreKOrvEDFGvg7LWhEbXRLwVnIrf1SNiRPYE=;
        b=ZDjr48Phi3VnVw/UPaWkJML7JP+sM73uBc0ITn9TXrG40j1pIu8l0/tY1cdVr38sIPdV7b
        jK+sIaEOGOtYV1nK+RNonQEIKJ+SqooNf/h/QKYOJX7nrVUCVXtdncQExpCC1Q5ZKVsf36
        HkxrlQkRxRXd/c+LVtLnFVA/Zh+HQTk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-mSZHRhYUPeeDueoxs7x-Ew-1; Fri, 22 Sep 2023 08:01:11 -0400
X-MC-Unique: mSZHRhYUPeeDueoxs7x-Ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F4443C100C7;
        Fri, 22 Sep 2023 12:01:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A713C15BB8;
        Fri, 22 Sep 2023 12:01:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <591a70bf016b4317add2d936696abc0f@AcuMS.aculab.com>
References: <591a70bf016b4317add2d936696abc0f@AcuMS.aculab.com> <20230920222231.686275-1-dhowells@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] iov_iter: Convert the iterator macros into inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1173636.1695384067.1@warthog.procyon.org.uk>
Date:   Fri, 22 Sep 2023 13:01:07 +0100
Message-ID: <1173637.1695384067@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> >  (8) Move the copy-and-csum code to net/ where it can be in proximity with
> >      the code that uses it.  This eliminates the code if CONFIG_NET=n and
> >      allows for the slim possibility of it being inlined.
> > 
> >  (9) Fold memcpy_and_csum() in to its two users.
> > 
> > (10) Move csum_and_copy_from_iter_full() out of line and merge in
> >      csum_and_copy_from_iter() since the former is the only caller of the
> >      latter.
> 
> I thought that the real idea behind these was to do the checksum
> at the same time as the copy to avoid loading the data into the L1
> data-cache twice - especially for long buffers.
> I wonder how often there are multiple iov[] that actually make
> it better than just check summing the linear buffer?

It also reduces the overhead for finding the data to checksum in the case the
packet gets split since we're doing the checksumming as we copy - but with a
linear buffer, that's negligible.

> I had a feeling that check summing of udp data was done during
> copy_to/from_user, but the code can't be the copy-and-csum here
> for that because it is missing support form odd-length buffers.

Is there a bug there?

> Intel x86 desktop chips can easily checksum at 8 bytes/clock
> (But probably not with the current code!).
> (I've got ~12 bytes/clock using adox and adcx but that loop
> is entirely horrid and it would need run-time patching.
> Especially since I think some AMD cpu execute them very slowly.)
> 
> OTOH 'rep movs[bq]' copy will copy 16 bytes/clock (32 if the
> destination is 32 byte aligned - it pretty much won't be).
> 
> So you'd need a csum-and-copy loop that did 16 bytes every
> three clocks to get the same throughput for long buffers.
> In principle splitting the 'adc memory' into two instructions
> is the same number of u-ops - but I'm sure I've tried to do
> that and failed and the extra memory write can happen in
> parallel with everything else.
> So I don't think you'll get 16 bytes in two clocks - but you
> might get it is three.
> 
> OTOH for a cpu where memcpy is code loop summing the data in
> the copy loop is likely to be a gain.
> 
> But I suspect doing the checksum and copy at the same time
> got 'all to complicated' to actually implement fully.
> With most modern ethernet chips checksumming receive pacakets
> does it really get used enough for the additional complexity?

You may be right.  That's more a question for the networking folks than for
me.  It's entirely possible that the checksumming code is just not used on
modern systems these days.

Maybe Willem can comment since he's the UDP maintainer?

David

