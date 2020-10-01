Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4E280045
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgJANhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 09:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731993AbgJANhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601559425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sGr2wExNAO71PZ/d9+MAsn8iYPVAzjyIKeYzyAJt0k=;
        b=jKHmI64yF5lENHEmhqQrxmR3iOlINr8gcdY2RfrUXdLc66vHXGueTlwhaE1d4NgSJFKPH/
        hrb56+SvWVyqAYJd4Yu4k7hMkCw4dBO44XB1Rj8WU8UrPPxHAZonjlXEJ8Lf2xCbj5/aeZ
        mTYbxndb37UnGYZwILJvTZGTNxr1la4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Zwr6LNjaOsK4ZrBOyt_CXA-1; Thu, 01 Oct 2020 09:37:04 -0400
X-MC-Unique: Zwr6LNjaOsK4ZrBOyt_CXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1029C51BA;
        Thu,  1 Oct 2020 13:37:03 +0000 (UTC)
Received: from ovpn-115-202.rdu2.redhat.com (ovpn-115-202.rdu2.redhat.com [10.10.115.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9681E55772;
        Thu,  1 Oct 2020 13:37:02 +0000 (UTC)
Message-ID: <68ab61d0ba3a6ddd7838bc293c9e24f5d8002e27.camel@redhat.com>
Subject: Re: [PATCH v3] pipe: Fix memory leaks in create_pipe_files()
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Oct 2020 09:37:02 -0400
In-Reply-To: <20201001131659.GE3421308@ZenIV.linux.org.uk>
References: <20201001125055.5042-1-cai@redhat.com>
         <20201001131659.GE3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-01 at 14:16 +0100, Al Viro wrote:
> On Thu, Oct 01, 2020 at 08:50:55AM -0400, Qian Cai wrote:
> > Calling pipe2() with O_NOTIFICATION_PIPE could results in memory leaks
> > in an error path or CONFIG_WATCH_QUEUE=n. Plug them.
> 
> [snip the copy of bug report]
> 
> No objections on the patch itself, but commit message is just about
> unreadable.  How about something along the lines of the following?
> 
> =======================
> 	Calling pipe2() with O_NOTIFICATION_PIPE could results in memory
> leaks unless watch_queue_init() is successful.
> 
> 	In case of watch_queue_init() failure in pipe2() we are left
> with inode and pipe_inode_info instances that need to be freed.  That
> failure exit has been introduced in commit c73be61cede5 ("pipe: Add
> general notification queue support") and its handling should've been
> identical to nearby treatment of alloc_file_pseudo() failures - it
> is dealing with the same situation.  As it is, the mainline kernel
> leaks in that case.
> 
> 	Another problem is that CONFIG_WATCH_QUEUE and !CONFIG_WATCH_QUEUE 
> cases are treated differently (and the former leaks just pipe_inode_info,
> the latter - both pipe_inode_info and inode).
> 
> 	Fixed by providing a dummy wath_queue_init() in !CONFIG_WATCH_QUEUE
> case and by having failures of wath_queue_init() handled the same way
> we handle alloc_file_pseudo() ones.
> 
> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Signed-off-by: Qian Cai <cai@redhat.com>
> =======================

Thanks Al. This looks very good to me.

