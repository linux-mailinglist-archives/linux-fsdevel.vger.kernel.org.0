Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238EC4C886C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiCAJqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiCAJqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433766005C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646127954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CS+BveLPCIYaqdM0GboJzI/BUhA8EFIEFcQXoJM2YsI=;
        b=cywgn08vj8og5Bi3nAPtmEAdLaTaoYzaSA5KUGo+lcxfx1pOj7z8LfeiddS8qmgmmoV+au
        DKTs5L4UN0gvuYZV+GoIEHZGjxm6MSAK37X3ivqHfN8QXy2d2lzglJYsQysfzEsGbx5526
        EM6/ne8zGFJsgKLiXEAJJJbYyRU0t/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-SLXOppvvMPai04k0pnDGfQ-1; Tue, 01 Mar 2022 04:45:53 -0500
X-MC-Unique: SLXOppvvMPai04k0pnDGfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2403FC80;
        Tue,  1 Mar 2022 09:45:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D72ED7FCEE;
        Tue,  1 Mar 2022 09:45:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
References: <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com> <2571706.1643663173@warthog.procyon.org.uk>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     dhowells@redhat.com,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610251.1646127950.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 01 Mar 2022 09:45:50 +0000
Message-ID: <2610252.1646127950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chuck Lever III <chuck.lever@oracle.com> wrote:

> > I've been working on a library (in fs/netfs/) to provide network files=
ystem
> > support services, with help particularly from Jeff Layton.  The idea i=
s to
> > move the common features of the VM interface, including request splitt=
ing,
> > operation retrying, local caching, content encryption, bounce bufferin=
g and
> > compression into one place so that various filesystems can share it.
> =

> IIUC this suite of functions is beneficial mainly to clients,
> is that correct? I'd like to be clear about that, this is not
> an objection to the topic.

Yes, this is intended as client-side support only.

David

