Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C908A4C8836
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiCAJkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiCAJkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0178B593B6
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 01:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646127562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTzdsYa5YSVczKzUN4WM0G6s7Arj4BQWQDc4bwTJlys=;
        b=JLxSkS+9oG2TJXUB5FwwqUOjIiiM1LLZHTsVga5DiH3to08ras1lPZXre7SKMwzd4xKr7P
        oW5dt0/grrUuTh/jdDy/bcMfwOsdfb+gT+Ef4GUgUbryXQFbroAnz4Rgi93qIOnSyE5xBq
        /hybMMWcJDeDiNViDpZbbTkCA5KtiIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-RvHXMJnANwOEE6MCenBbTQ-1; Tue, 01 Mar 2022 04:39:18 -0500
X-MC-Unique: RvHXMJnANwOEE6MCenBbTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407E7FC80;
        Tue,  1 Mar 2022 09:39:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 783E083199;
        Tue,  1 Mar 2022 09:39:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACdtm0aZnQLyduKxr9dhcpYB_r00UFnR=WQvAnqL0DebxgbrOw@mail.gmail.com>
References: <CACdtm0aZnQLyduKxr9dhcpYB_r00UFnR=WQvAnqL0DebxgbrOw@mail.gmail.com> <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk> <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk> <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com> <3013921.1644856403@warthog.procyon.org.uk> <CACdtm0Z4zXpbPBLJx-=AgBRd63hp_n+U-5qc0gQDQW0c2PY7gg@mail.gmail.com> <2498968.1646058507@warthog.procyon.org.uk>
To:     Rohith Surabattula <rohiths.msft@gmail.com>
Cc:     dhowells@redhat.com, smfrench@gmail.com, nspmangalore@gmail.com,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2568724.1646127551.1@warthog.procyon.org.uk>
Date:   Tue, 01 Mar 2022 09:39:11 +0000
Message-ID: <2568725.1646127551@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btw, do you have any changes on top of my cifs-experimental branch?

Also, what commands are you running to test it?  I see you're using 'vi' - is
it possible that vi is opening the file O_RDWR?

David

