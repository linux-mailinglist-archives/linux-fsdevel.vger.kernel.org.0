Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40504E1909
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 00:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiCSXtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiCSXtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 19:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAE8DA192
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Mar 2022 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647733671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6n/sDsvAuIPEifJSzKj64MzdJQCs8pJY1Y2N6jUReiU=;
        b=hWiV0S04n2Ly0esyaGCpJPVWkrzbRiEi3jwHr482QPJTP0L64pjaf639+fywiqjjFf9yac
        S0JU7b/tLgUs2OXZ74oi8a9af5DxvhjbAtLcngP2BO44SaaJ4S5VHEwAfUX5IJC5L5nQ3j
        gwg2DaknD8M+C8+Cst/6Y3EyQLjcA7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-CVtg9R1OMg6ffmTpYKYm1Q-1; Sat, 19 Mar 2022 19:47:47 -0400
X-MC-Unique: CVtg9R1OMg6ffmTpYKYm1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A6B6811E76;
        Sat, 19 Mar 2022 23:47:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E10C40CF8F2;
        Sat, 19 Mar 2022 23:47:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP_sEj7i8YbbwJibbSG=BCVp4E9BAo=JF0aC79xBNC8wcA@mail.gmail.com>
References: <CAOi1vP_sEj7i8YbbwJibbSG=BCVp4E9BAo=JF0aC79xBNC8wcA@mail.gmail.com> <751829.1647648125@warthog.procyon.org.uk>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Coordinating netfslib pull request with the ceph pull request
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <824347.1647733664.1@warthog.procyon.org.uk>
Date:   Sat, 19 Mar 2022 23:47:44 +0000
Message-ID: <824348.1647733664@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ilya Dryomov <idryomov@gmail.com> wrote:

> Given how your branch is structured, it sounds like the easiest would
> be for you to send the netfslib pull request after I send the ceph pull
> request.  Or do you have some tighter coordination in mind?

I think that's sufficient - or if I sent mine first, I can put in a big note
at the top saying it depends on yours, when you decide to post it.

David

