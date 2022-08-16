Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74124595DDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiHPNzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiHPNzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F4AB1B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660658145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6hFaBEt5GLJr4zgAQ4FRbZHDnVYqPwY862jut86w9JQ=;
        b=Al+iApvilV9+ixq/cXvG7vrgxdCfqc9Gt8fsf2K/F/kMDeObYlfN41tcVYOn45t5hj+h7M
        01cbfTXXSTIi6/YVii7fEnA7dIpG3SkaskmxIjIel+VTd1rPAEBG1H09izDTOEbY/NyR+N
        PSHg06lRvqp2VzosNce2qmJcVHWMUQU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-F8ogFSYXMsGc_wpiFfBlFQ-1; Tue, 16 Aug 2022 09:55:44 -0400
X-MC-Unique: F8ogFSYXMsGc_wpiFfBlFQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED93C3C0E230;
        Tue, 16 Aug 2022 13:55:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D4C1492C3B;
        Tue, 16 Aug 2022 13:55:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220816134419.xra4krb3jwlm4npk@wittgenstein>
References: <20220816134419.xra4krb3jwlm4npk@wittgenstein> <20220816132759.43248-1-jlayton@kernel.org> <20220816132759.43248-2-jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for IS_I_VERSION inodes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4066395.1660658141.1@warthog.procyon.org.uk>
Date:   Tue, 16 Aug 2022 14:55:41 +0100
Message-ID: <4066396.1660658141@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> wrote:

> > +#define STATX_CHANGE_ATTR	0x00002000U	/* Want/got stx_change_attr */
> 
> I'm a bit worried that STATX_CHANGE_ATTR isn't a good name for the flag
> and field. Or I fail to understand what exact information this will
> expose and how userspace will consume it.
> To me the naming gives the impression that some set of generic
> attributes have changed but given that statx is about querying file
> attributes this becomes confusing.
> 
> Wouldn't it make more sense this time to expose it as what it is and
> call this STATX_INO_VERSION and __u64 stx_ino_version?

I'm not sure that STATX_INO_VERSION is better that might get confused with the
version number that's used to uniquify inode slots (ie. deal with inode number
reuse).

The problem is that we need fsinfo() or similar to qualify what this means.
On some filesystems, it's only changed when the data content changes, but on
others it may get changed when, say, xattrs get changed; further, on some
filesystems it might be monotonically incremented, but on others it's just
supposed to be different between two consecutive changes (nfs, IIRC).

David

