Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26C02ED02B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 13:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbhAGMoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 07:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728219AbhAGMoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610023369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8GYXHjWTOh0UH/y8ZgnKRJ27aQdFgDUIcHSJBqDdrQ=;
        b=R79wOLitjwePshA4aPNJGpVPbEvdjdVdX4nH0EpJrXGc6eUW0Cz/NpFLJKMLxPlcvUEeZn
        p9R9U5ixJBKLRh0w2RxRsaY4QUXPPey+p/5qywLR098qF63I+BWjtKiRr7nWj7IoLaWXsD
        W0SdSxaSQL94mkM4XUhgY/WPvBh6OAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-kiCDWx76MyOkIl7t4s2Hjw-1; Thu, 07 Jan 2021 07:42:45 -0500
X-MC-Unique: kiCDWx76MyOkIl7t4s2Hjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 955A119251A9;
        Thu,  7 Jan 2021 12:42:44 +0000 (UTC)
Received: from starship (unknown [10.35.206.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D95AF5B6A2;
        Thu,  7 Jan 2021 12:42:42 +0000 (UTC)
Message-ID: <389f04288690b44b0ea6c977894dc0592e904c90.camel@redhat.com>
Subject: Re: [PATCH] block: fallocate: avoid false positive on collision
 detection
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Date:   Thu, 07 Jan 2021 14:42:41 +0200
In-Reply-To: <20210107124022.900172-1-mlevitsk@redhat.com>
References: <45420b24124b5b91bc0a80a4abad2e06acb8c2b3.camel@redhat.com>
         <20210107124022.900172-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-01-07 at 14:40 +0200, Maxim Levitsky wrote:
> Align start and end on page boundaries before calling
> invalidate_inode_pages2_range.
> 
> This might allow us to miss a collision if the write and the discard were done
> to the same page and do overlap but it is still better than returning -EBUSY
> if those writes didn't overlap.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

This is my attempt to fix this issue. I am not 100% sure
that this is the right solution though.

Any feedback is welcome!

Best regards,
	Maxim Levitsky

