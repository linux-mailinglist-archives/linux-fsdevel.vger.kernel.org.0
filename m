Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D08929EAF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJ2Lso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 07:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgJ2Lso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603972123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3eO78q+9r1W8jjiRsy6XEsZ6AJ4ydkuDrUHxryN5JM=;
        b=CU9xiqtacnbtZv0/GtVLmOHAdaidFP5qOc43DiqmBKRIFrvZeYq6FNbMTrB9WHShU3e2t5
        ugLZUfURau+n93AlaC+LrYjZzB1v19/wrvvqc50Anh/TkKrTDTr5+XumShv9BLIcwYyONI
        mge3hABV4s3ah1kZNoOFWyu/E0iVijE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-j-klzaLdOVu3MhWyzwxHbg-1; Thu, 29 Oct 2020 07:48:41 -0400
X-MC-Unique: j-klzaLdOVu3MhWyzwxHbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD818015FD;
        Thu, 29 Oct 2020 11:48:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E82085C1D0;
        Thu, 29 Oct 2020 11:48:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160392383297.592578.14698271215668067643.stgit@warthog.procyon.org.uk>
References: <160392383297.592578.14698271215668067643.stgit@warthog.procyon.org.uk> <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, kernel test robot <lkp@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] afs: Fix dirty-region encoding on ppc32 with 64K pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <957372.1603972118.1@warthog.procyon.org.uk>
Date:   Thu, 29 Oct 2020 11:48:38 +0000
Message-ID: <957373.1603972118@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +static inline unsigned int afs_page_dirty_resolution(void)
> +{
> +	long shift = PAGE_SHIFT - (__AFS_PAGE_PRIV_SHIFT - 1);

This should be int, not long, in case we get an explicitly unsigned int number
included in the mix (say from thp_order() with THP support).

David

