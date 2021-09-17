Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1440F5E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbhIQK3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 06:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242494AbhIQK3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631874467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=liKY3Y3XpuEb1R8bOfajserrfbkX+Pg3hLBYQbacQsw=;
        b=RF6CjI/TKVUVZGjfRMSTHsqwnRrLfC63RQ7R+ft7A115Vk6fCJ0tOMPXKNFc5AhjCECl2i
        J1oKvT4X9IYHwp8dlIXxElGIkrxj2bLmw1N4N2K2kMKTbX9+o0CG/0m/0VQu0Smhcx9iBx
        LWw1AZ3pz9II705m5nR2gV1AO6m+rIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-AiRMSWuNP7SQTwSipXnnDQ-1; Fri, 17 Sep 2021 06:27:45 -0400
X-MC-Unique: AiRMSWuNP7SQTwSipXnnDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B3D801B3D;
        Fri, 17 Sep 2021 10:27:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCA49100AE35;
        Fri, 17 Sep 2021 10:27:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     dhowells@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Could we get an IOCB_NO_READ_HOLE?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2315871.1631874463.1@warthog.procyon.org.uk>
Date:   Fri, 17 Sep 2021 11:27:43 +0100
Message-ID: <2315872.1631874463@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

Would it be possible to get an IOCB_NO_READ_HOLE flag that causes a read to
either fail entirely if there's a hole in the file or to stop at the hole,
possibly returning -ENODATA if the hole is at the front of the file?

Looking at iomap_dio_iter(), IOMAP_HOLE should be enabled in
iomap_iter::iomap.type for this?  Is it that simple?

David

