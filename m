Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8031630A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 20:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBRTu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 14:50:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31868 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgBRTu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582055456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K+LV8qrLkLKxHNwn2AaZxB78FQ7KCDxReRpoihQjkh4=;
        b=gpqgwqF3Oo7pEmmCVaxO7ujvpzU76hlYpckGYjHut7rtvUQaHmcSwWD+pscGf+5raebYAt
        1Wl/Mtl+asqEyzc14CEJ0SLsMrTsWs5Dyu66BpnlAX9+WWY2plGycOseUqEYI6atlCs1TL
        Sg1eMLFdfRU07hgmOPJUJXyGZ4wKNoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-aS0ax9IXOAmCjVPDxzFEnw-1; Tue, 18 Feb 2020 14:50:52 -0500
X-MC-Unique: aS0ax9IXOAmCjVPDxzFEnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F37F10509B8;
        Tue, 18 Feb 2020 19:50:51 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 974031001920;
        Tue, 18 Feb 2020 19:50:50 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
References: <20200129210337.GA13630@redhat.com>
        <f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
        <CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 18 Feb 2020 14:50:49 -0500
In-Reply-To: <CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
        (Dan Williams's message of "Wed, 5 Feb 2020 16:37:40 -0800")
Message-ID: <x49v9o3brom.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Right now the kernel does not install a pte on faults that land on a
> page with known poison, but only because the error clearing path is so
> convoluted and could only claim that fallocate(PUNCH_HOLE) cleared
> errors because that was guaranteed to send 512-byte aligned zero's
> down the block-I/O path when the fs-blocks got reallocated. In a world
> where native cpu instructions can clear errors the dax write() syscall
> case could be covered (modulo 64-byte alignment), and the kernel could
> just let the page be mapped so that the application could attempt it's
> own fine-grained clearing without calling back into the kernel.

I'm not sure we'd want to do allow mapping the PTEs even if there was
support for clearing errors via CPU instructions.  Any load from a
poisoned page will result in an MCE, and there exists the possiblity
that you will hit an unrecoverable error (Processor Context Corrupt).
It's just safer to catch these cases by not mapping the page, and
forcing recovery through the driver.

-Jeff

