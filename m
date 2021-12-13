Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B544723CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 10:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhLMJ3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 04:29:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232166AbhLMJ3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639387770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VZhEx+sUMMeSJSQzTqGhraZkHXzXw9WTjnutstzo9Q=;
        b=YG1adZW7w0jfmO4GAe9N4SXoWiunCqg9Fw1u3XtrKfT6jj9JwzvN1iSerQ8YXevgLzPYH0
        hpZg5HPbKqxH6f+LbRl5UyF1sfRRKtjT5rPxKxWhu1xLie3Lgtd9eFSnOGtFibMbff/JCG
        lQLqfSIfvCLKGHh5E+huzKpBX2L9+mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-n-9qWa54PzOagvRgJ_RVzA-1; Mon, 13 Dec 2021 04:29:28 -0500
X-MC-Unique: n-9qWa54PzOagvRgJ_RVzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 614F9593AE;
        Mon, 13 Dec 2021 09:29:27 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 898396107F;
        Mon, 13 Dec 2021 09:29:18 +0000 (UTC)
Date:   Mon, 13 Dec 2021 17:29:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an
 iov_iter
Message-ID: <20211213092915.GC29905@MiWiFi-R3L-srv>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-4-willy@infradead.org>
 <20211213080257.GC20986@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213080257.GC20986@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/21 at 09:02am, Christoph Hellwig wrote:
> >  
> >  ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> >  {
> > -	return read_from_oldmem(buf, count, ppos, 0,
> > +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> > +	struct iov_iter iter;
> > +
> > +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> > +
> > +	return read_from_oldmem(&iter, count, ppos,
> >  				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
> >  }
> 
> elfcorehdr_read should probably also take an iov_iter while we're at it.
> 
> I also don't quite understand why we even need the arch overrides for it,
> but that would require some digging into the history of this interface.
> 

Below patchset removing sec_active() from generic code added this arch
override on x86_64. Before that, s390 and arm64 have had arch overrides. 
And arm64 says "elfcorehdr_read() is simple as the region is always mapped."
in commit e62aaeac42 "arm64: kdump: provide /proc/vmcore file".

[v3,0/6] Remove x86-specific code from generic headers
https://patchwork.kernel.org/project/linux-fsdevel/cover/20190718032858.28744-1-bauerman@linux.ibm.com/

5cbdaeefb655 s390/mm: Remove sev_active() function
ae7eb82a92fa fs/core/vmcore: Move sev_active() reference to x86 arch code
284e21fab2cf x86, s390/mm: Move sme_active() and sme_me_mask to x86-specific header
e740815a97e2 dma-mapping: Remove dma_check_mask()
47e5d8f9ed34 swiotlb: Remove call to sme_active()
0c9c1d563975 x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig


