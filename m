Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F01323B0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhBXLJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 06:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234940AbhBXLHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614164769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCwc6nRDm9GGv20OtNC9Z78gm9Rbh/8za4AwSnHSa90=;
        b=OtHz2A82mChlzJpVA8HNIQCiOzInkGxkyQx4Ay4pYueBIA/fpjWI+lI7nPJtVcIGlHB4cC
        UKrjTmd46aFcqR2Rg92ZW0rhVMWKwj2JvDGNwZDiLLVojPuX5ErYMcQYlPLrAHKbD1I91Z
        wQcgp3Yg+pi25gq6QcOtqX3kFd+G+ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-xGIY2WhzPf6hyRVOJ49uNw-1; Wed, 24 Feb 2021 06:06:07 -0500
X-MC-Unique: xGIY2WhzPf6hyRVOJ49uNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10071936B61;
        Wed, 24 Feb 2021 11:06:05 +0000 (UTC)
Received: from [10.72.12.156] (ovpn-12-156.pek2.redhat.com [10.72.12.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B41110016F9;
        Wed, 24 Feb 2021 11:05:59 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] ceph: convert to netfs helper library
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, willy@infradead.org
References: <20210223130629.249546-1-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <aceeb647-f75a-8146-cab5-ecbfce7cd8bc@redhat.com>
Date:   Wed, 24 Feb 2021 19:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223130629.249546-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/2/23 21:06, Jeff Layton wrote:
> This is the third posting of this patchset. The main differences between
> this one and the last are some bugfixes, and cleanups:
>
> - rebase onto David's latest fscache-netfs-lib set
> - unify the netfs_read_request_ops into one struct
> - fix inline_data handling in write_begin
> - remove the now-unneeded i_fscache_gen field from ceph_inode_info
> - rename gfp_flags to gfp in releasepage
> - pass appropriate was_async flag to netfs_subreq_terminated
>
> This set is currently sitting in the ceph-client/testing branch, so
> it should get good testing coverage over the next few weeks via in
> the teuthology lab.
>
> Jeff Layton (6):
>    ceph: disable old fscache readpage handling
>    ceph: rework PageFsCache handling
>    ceph: fix fscache invalidation
>    ceph: convert readpage to fscache read helper
>    ceph: plug write_begin into read helper
>    ceph: convert ceph_readpages to ceph_readahead
>
>   fs/ceph/Kconfig |   1 +
>   fs/ceph/addr.c  | 541 +++++++++++++++++++-----------------------------
>   fs/ceph/cache.c | 125 -----------
>   fs/ceph/cache.h | 101 +++------
>   fs/ceph/caps.c  |  10 +-
>   fs/ceph/inode.c |   1 +
>   fs/ceph/super.h |   2 +-
>   7 files changed, 242 insertions(+), 539 deletions(-)
>
This series LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

