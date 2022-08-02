Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC095880D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 19:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiHBROZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiHBROY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D3473E74E
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659460462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlhiUUm/2R9OZ4dkUwKfWDfhVhDGEpgB2ljUziEmU/8=;
        b=drJVPIPBAw3oxkGxwAwV/sirwOjufDeR1s7jONo7tnJ6guxu/YGkxeCqk1sozLlXBcM5/I
        fGIYGZ9hApGwQeB+eAWXxGXtAvPbbg6c+Endup7r2nfvieXRTWQKe3lkK0WLehkt1RdRgm
        R7LRI3iEvFL9hhoDqL2/Cj9PDqHTkyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-k-YzkfN-MGGMiRIedld4nw-1; Tue, 02 Aug 2022 13:14:18 -0400
X-MC-Unique: k-YzkfN-MGGMiRIedld4nw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3671F802D1C;
        Tue,  2 Aug 2022 17:14:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94638492CA2;
        Tue,  2 Aug 2022 17:14:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com>
References: <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com> <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk> <165911278430.3745403.16526310736054780645.stgit@warthog.procyon.org.uk>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] afs: Fix access after dec in put functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3733971.1659460456.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Aug 2022 18:14:16 +0100
Message-ID: <3733972.1659460456@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Marc Dionne <marc.dionne@auristor.com> wrote:

> > -       trace_afs_server(server, r - 1, atomic_read(&server->active), =
reason);
> > +       trace_afs_server(server->debug_id, r - 1, a, reason);
> =

> Don't you also want to copy server->debug_id into a local variable here?

Okay, how about the attached change?

David
---
diff --git a/fs/afs/server.c b/fs/afs/server.c
index bca4b4c55c14..4981baf97835 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -399,7 +399,7 @@ struct afs_server *afs_use_server(struct afs_server *s=
erver, enum afs_server_tra
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a;
+	unsigned int a, debug_id =3D server->debug_id;
 	bool zero;
 	int r;
 =

@@ -408,7 +408,7 @@ void afs_put_server(struct afs_net *net, struct afs_se=
rver *server,
 =

 	a =3D atomic_inc_return(&server->active);
 	zero =3D __refcount_dec_and_test(&server->ref, &r);
-	trace_afs_server(server->debug_id, r - 1, a, reason);
+	trace_afs_server(debug_id, r - 1, a, reason);
 	if (unlikely(zero))
 		__afs_put_server(net, server);
 }

