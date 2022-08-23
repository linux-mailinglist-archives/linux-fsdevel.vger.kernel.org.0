Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990359E42F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbiHWM5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiHWM4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7062DAAB
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661248884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0e9zp8WKUjGYqm5mPMp4N3c60gCpZ/O4fuVYAMSQOs8=;
        b=NWLi52+AVUCuU5wAdTcgtmGiuz2X0LISd/Cn+Ly9Jdx6wiks6AwrBA/ZGwTgstNZhGSPNu
        IT9D7tItIqIy+n1BHZ7ulagGk29SkWicL0QIBm7VVio8732QxuAFMAXeFAkzcBxFeC67cK
        gGWM9/L/Z7g5SQ9j4wkh5s8/GX96DnM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-ZBqIdgmUNGCqbKV9pZdyiQ-1; Tue, 23 Aug 2022 06:01:22 -0400
X-MC-Unique: ZBqIdgmUNGCqbKV9pZdyiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30D658041BE;
        Tue, 23 Aug 2022 10:01:22 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A184010D2A;
        Tue, 23 Aug 2022 10:01:19 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION
 inodes
References: <20220819115641.14744-1-jlayton@kernel.org>
Date:   Tue, 23 Aug 2022 12:01:18 +0200
In-Reply-To: <20220819115641.14744-1-jlayton@kernel.org> (Jeff Layton's
        message of "Fri, 19 Aug 2022 07:56:41 -0400")
Message-ID: <87o7wb2s9d.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeff Layton:

> From: Jeff Layton <jlayton@redhat.com>
>
> The NFS server and IMA both rely heavily on the i_version counter, but
> it's largely invisible to userland, which makes it difficult to test its
> behavior. This value would also be of use to userland NFS servers, and
> other applications that want a reliable way to know if there was an
> explicit change to an inode since they last checked.
>
> Claim one of the spare fields in struct statx to hold a 64-bit inode
> version attribute. This value must change with any explicit, observeable
> metadata or data change. Note that atime updates are excluded from this,
> unless it is due to an explicit change via utimes or similar mechanism.
>
> When statx requests this attribute on an IS_I_VERSION inode, do an
> inode_query_iversion and fill the result in the field. Also, update the
> test-statx.c program to display the inode version and the mountid.

Will the version survive reboots?  Is it stored on disks?  Can backup
tools (and others) use this to check if the file has changed since the
last time the version has been observed?

Thanks,
Florian

