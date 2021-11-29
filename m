Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E9461C1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 17:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbhK2QwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 11:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241960AbhK2QuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638204405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3GJRzGCMMDnoa4rTFWngW6LBT+sAXy7Pg1leaBZ3T8=;
        b=RPtr9lKeL13Cy7AMG3FlXY+XatcVbvU3WLRIjBS3KAHPXL7Ex2tbfsG+eJV6hC/njBZpJ9
        gXvQAN4k3+ZE/i7B2agVTLBUxEPnS5BazOTZGWpDlQ/pO8e8RM0RIVBUi7UOd/+OeuUvoe
        Chb2vUlJFdJETqQSqRJrXTnnXT3LtdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-165-b3d9wAmmPtWOM8sWk8afEg-1; Mon, 29 Nov 2021 11:46:43 -0500
X-MC-Unique: b3d9wAmmPtWOM8sWk8afEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3CB84B9A1;
        Mon, 29 Nov 2021 16:46:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAC6319724;
        Mon, 29 Nov 2021 16:46:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211129162907.149445-2-jlayton@kernel.org>
References: <20211129162907.149445-2-jlayton@kernel.org> <20211129162907.149445-1-jlayton@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ceph: conversion to new fscache API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <278916.1638204396.1@warthog.procyon.org.uk>
Date:   Mon, 29 Nov 2021 16:46:36 +0000
Message-ID: <278917.1638204396@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> +void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
>  {
> -	return fscache_register_netfs(&ceph_cache_netfs);
> +	struct fscache_cookie* cookie = xchg(&ci->fscache, NULL);
> +
> +	fscache_relinquish_cookie(cookie, false);
>  }

xchg() should be excessive there.  This is only called from
ceph_evict_inode().  Also, if you're going to reset the pointer, it might be
worth poisoning it rather than nulling it.

David

