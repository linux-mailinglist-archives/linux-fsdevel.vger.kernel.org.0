Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3894436A03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhJUSGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 14:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232562AbhJUSGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634839425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSHfqseBKeRB8xf7I0mUX0PNFUzMlKErE4TYf1UyH6c=;
        b=dHLnYKle40+eUQ7Xjz/SjoqbpGe/n+cd8Eyh4rNZVZKnaaIlMSBILhsjaRzBUFNqEkUAHe
        SAsK/l4Qg8sTSmQUecVVJo5xSSMzRfZYoA0gLJi8ub0ez5SYYNid00gfFY+08sw1ejfiWV
        ug5hHYY1mBwypmBNv8q6TQnKI6G6cyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-nxdvAYv3MO2dOkZVxQcX4A-1; Thu, 21 Oct 2021 14:03:41 -0400
X-MC-Unique: nxdvAYv3MO2dOkZVxQcX4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 779B01006AA3;
        Thu, 21 Oct 2021 18:03:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEE2560C13;
        Thu, 21 Oct 2021 18:03:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with a single argument
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
        <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
        <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
        <YXF8X3RgRfZpL3Cb@infradead.org>
        <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
        <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
        <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 21 Oct 2021 14:05:45 -0400
In-Reply-To: <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk> (Jens Axboe's
        message of "Thu, 21 Oct 2021 09:19:45 -0600")
Message-ID: <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> I'll follow up if there are issues.

s390 (big endian, 64 bit) is failing libaio test 21:

# harness/cases/21.p
Expected -EAGAIN, got 4294967285

If I print out both res and res2 using %lx, you'll see what happened:

Expected -EAGAIN, got fffffff5,ffffffff

The sign extension is being split up.

-Jeff

