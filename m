Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3424B564D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiBNQdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 11:33:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiBNQdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4BA8B30
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644856412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5ehzTgYsJrgx/mR3qH68Df1kFTmMdOC2dgTalQfHvk=;
        b=Ucegybfa3nBLbVz8U1pnqDOJ9rQoKlgzwkszt+GaEECM6VoTfKemCWzmbgs8x3sps+OSAI
        FwZtDNYi7PqUqo7EbKlP829j8vGmqq5Z4qp/BXu8L/ZaRsgnWS21ypfbFNik105Y8StlYj
        mB1C6XBLVTVQzMu+Vj9S1Jb6vZV0ROw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-hW6L7UubPHyyp-tSiy8Ecw-1; Mon, 14 Feb 2022 11:33:27 -0500
X-MC-Unique: hW6L7UubPHyyp-tSiy8Ecw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D1D5100C663;
        Mon, 14 Feb 2022 16:33:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98C027D70E;
        Mon, 14 Feb 2022 16:33:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com>
References: <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com> <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk> <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk>
To:     Rohith Surabattula <rohiths.msft@gmail.com>
Cc:     dhowells@redhat.com, smfrench@gmail.com, nspmangalore@gmail.com,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3013920.1644856403.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 14 Feb 2022 16:33:23 +0000
Message-ID: <3013921.1644856403@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rohith Surabattula <rohiths.msft@gmail.com> wrote:

> I have tested netfs integration with fsc mount option enabled. But, I
> observed function "netfs_cache_prepare_read" always returns
> "NETFS_DOWNLOAD_FROM_SERVER" because cres->ops(i.e cachefiles
> operations) is not set.

I see it download from the server and write to the cache:

	# cat /proc/fs/fscache/stats =

	...
	IO     : rd=3D0 wr=3D4     <---- no reads, four writes made
	RdHelp : DR=3D0 RA=3D4 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
	RdHelp : ZR=3D0 sh=3D0 sk=3D0
	RdHelp : DL=3D4 ds=3D4 df=3D0 di=3D0
	RdHelp : RD=3D0 rs=3D0 rf=3D0
	RdHelp : WR=3D4 ws=3D4 wf=3D0

Turning on the cachefiles_vol_coherency tracepoint, I see:

     kworker/2:2-1040    [002] .....   585.499799: cachefiles_vol_coherenc=
y: V=3D00000003 VOL BAD cmp  B=3D480004
     kworker/2:2-1040    [002] .....   585.499872: cachefiles_vol_coherenc=
y: V=3D00000003 VOL SET ok   B=3D480005

every time I unmount and mount again.  One of the fields is different each
time.

Using the netfs tracepoints, I can see the download being made from the se=
rver
and then the subsequent write to the cache:

          md5sum-4689    [003] .....   887.382290: netfs_read: R=3D0000000=
5 READAHEAD c=3D0000004e ni=3D86 s=3D0 20000
          md5sum-4689    [003] .....   887.383076: netfs_read: R=3D0000000=
5 EXPANDED  c=3D0000004e ni=3D86 s=3D0 400000
          md5sum-4689    [003] .....   887.383252: netfs_sreq: R=3D0000000=
5[0] PREP  DOWN f=3D01 s=3D0 0/400000 e=3D0
          md5sum-4689    [003] .....   887.383252: netfs_sreq: R=3D0000000=
5[0] SUBMT DOWN f=3D01 s=3D0 0/400000 e=3D0
           cifsd-4687    [002] .....   887.394926: netfs_sreq: R=3D0000000=
5[0] TERM  DOWN f=3D03 s=3D0 400000/400000 e=3D0
           cifsd-4687    [002] .....   887.394928: netfs_rreq: R=3D0000000=
5 ASSESS f=3D22
           cifsd-4687    [002] .....   887.394928: netfs_rreq: R=3D0000000=
5 UNLOCK f=3D22
    kworker/u8:4-776     [000] .....   887.395000: netfs_rreq: R=3D0000000=
5 WRITE  f=3D02
    kworker/u8:4-776     [000] .....   887.395005: netfs_sreq: R=3D0000000=
5[0] WRITE DOWN f=3D03 s=3D0 400000/400000 e=3D0
     kworker/3:2-1001    [003] .....   887.627881: netfs_sreq: R=3D0000000=
5[0] WTERM DOWN f=3D03 s=3D0 400000/400000 e=3D0
     kworker/3:2-1001    [003] .....   887.628163: netfs_rreq: R=3D0000000=
5 DONE   f=3D02
     kworker/3:2-1001    [003] .....   887.628165: netfs_sreq: R=3D0000000=
5[0] FREE  DOWN f=3D03 s=3D0 400000/400000 e=3D0
    kworker/u8:4-776     [000] .....   887.628216: netfs_rreq: R=3D0000000=
5 FREE   f=3D02

Can you mount a cifs share with "-o fsc", read a file and then look in
/proc/fs/fscache/cookies and /proc/fs/fscache/stats for me?

David

