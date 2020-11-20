Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF502BB5FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgKTTvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 14:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729624AbgKTTvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605901908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnDEod9S9GP35ZJdcDmtV6IFJeO62QQ63RGfcLkybLk=;
        b=Am+c5jZKUQwwNRd+JdK+QBxphc1CWt8Cwc0oWhR5IIqaDGSy78FjyRGSs3DBBDUwPEg/Ek
        bnas3DGbnaNQlnooR2fDret41JtZo5Zko/ZwBQmPzPmWc93L+/0XoWkNULjNF/AfvAxZFh
        JcBR5/t97iuHu+80Bi7kxkwivQUA+x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-hXDQ-YY-NAKgRrsQq4Ia6g-1; Fri, 20 Nov 2020 14:51:46 -0500
X-MC-Unique: hXDQ-YY-NAKgRrsQq4Ia6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39C951DDED;
        Fri, 20 Nov 2020 19:51:45 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D5010013C0;
        Fri, 20 Nov 2020 19:51:44 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "K.R. Foley" <kr@cybsft.com>, linux-fsdevel@vger.kernel.org
Subject: Re: BUG triggers running lsof
References: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
        <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 20 Nov 2020 14:51:48 -0500
In-Reply-To: <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org> (Randy
        Dunlap's message of "Fri, 20 Nov 2020 11:42:48 -0800")
Message-ID: <x49im9zn6wb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 11/20/20 11:16 AM, K.R. Foley wrote:
>> I have found an issue that triggers by running lsof. The problem is
>> reproducible, but not consistently. I have seen this issue occur on
>> multiple versions of the kernel (5.0.10, 5.2.8 and now 5.4.77). It
>> looks like it could be a race condition or the file pointer is being
>> corrupted. Any pointers on how to track this down? What additional
>> information can I provide?
>
> Hi,
>
> 2 things in general:
>
> a) Can you test with a more recent kernel?
>
> b) Can you reproduce this without loading the proprietary & out-of-tree
> kernel modules?  They should never have been loaded after bootup.
> I.e., don't just unload them -- that could leave something bad behind.

Heh, the EIP contains part of the name of one of the modules:

>
>> [ 8057.297159] BUG: unable to handle page fault for address: 31376f63
                                                                ^^^^^^^^

>> [ 8057.297219] Modules linked in: ITXico7100Module(O)
                                         ^^^^
-Jeff

