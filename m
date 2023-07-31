Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845077697B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGaNe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGaNe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD6C170B
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690810450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fzwvrlH1XSGlWSe56Wopyn1B7OdltVaU2XLlAlxd74o=;
        b=cD551nsaTI6/bVC1yZCrziMzFXXAHSrvLEWDdqYrAGU7yrm2WxtahoN5M3FDpPJlbDCi4q
        zFfe7LhOrhUskjXMGVKyaHObgEExP+Jll0MqGmMFgoQ9X8QgvxRRhBEEGuHUyvhWYR9Zmc
        Q8pa5+PVI88yCq3kaVolkv19XIeeR40=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-facAzEGHPVC7lcet0k7VTQ-1; Mon, 31 Jul 2023 09:34:05 -0400
X-MC-Unique: facAzEGHPVC7lcet0k7VTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31911382C965;
        Mon, 31 Jul 2023 13:34:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87D58C57964;
        Mon, 31 Jul 2023 13:34:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch>
References: <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch> <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch> <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com> <792238.1690667367@warthog.procyon.org.uk> <831028.1690791233@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1125141.1690810441.1@warthog.procyon.org.uk>
Date:   Mon, 31 Jul 2023 14:34:01 +0100
Message-ID: <1125142.1690810441@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Is the MSG_CONFIRM needed to trigger this?

It's not actually necessary.  The syz test was doing it.

> Is this indeed trivially sidestepped if downgrading from splicing to
> regular copying with fragmentation?

That works.  The logging looks like:

==>splice_to_socket() 5535
udp_sendmsg(8,8)
__ip_append_data(copy=-1,len=8, mtu=8192 skblen=8189 maxfl=8188)
copy 8 = 9 - 0 - 1 - 0
length 8 -= 8 + 0
<==splice_to_socket() = 8

It looks like pagedlen being non-zero might be the issue.

David

