Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADDF26CE1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIPVJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 17:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbgIPVJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 17:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600290593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVdVObv8tbiDVGVAm0SCTZNM8HTzvb9fYiClqlI5+Vg=;
        b=YDqOUlxcH+/xbGbISfZoIsK5ni48L0Af8NKi9KV+62nWsX1xYDKrkmsHRb8+2gCryZfwyh
        VtRwKxTzV6oahQimTlWAD3QUDA7wRSekzIbY5MjJuWtK7GmbH3VvtjJSe1IcOxKaPT39bf
        3YThZv0gG++qQrbzqWscWsluCrbaa1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-oYobg3TyPaOR4_EN5N2vjg-1; Wed, 16 Sep 2020 17:09:51 -0400
X-MC-Unique: oYobg3TyPaOR4_EN5N2vjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93725801ADC;
        Wed, 16 Sep 2020 21:09:50 +0000 (UTC)
Received: from ovpn-66-86.rdu2.redhat.com (ovpn-66-86.rdu2.redhat.com [10.10.66.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B345C1001281;
        Wed, 16 Sep 2020 21:09:49 +0000 (UTC)
Message-ID: <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
Subject: Re: slab-out-of-bounds in iov_iter_revert()
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:09:49 -0400
In-Reply-To: <20200911235511.GB3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
         <20200911235511.GB3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-09-12 at 00:55 +0100, Al Viro wrote:
> On Fri, Sep 11, 2020 at 05:59:04PM -0400, Qian Cai wrote:
> > Super easy to reproduce on today's mainline by just fuzzing for a few
> > minutes
> > on virtiofs (if it ever matters). Any thoughts?
> 
> Usually happens when ->direct_IO() fucks up and reports the wrong amount
> of data written/read.  We had several bugs like that in the past - see
> e.g. 85128b2be673 (fix nfs O_DIRECT advancing iov_iter too much).
> 
> Had there been any recent O_DIRECT-related patches on the filesystems
> involved?

This is only reproducible using FUSE/virtiofs so far, so I will stare at
fuse_direct_IO() until someone can beat me to it.

