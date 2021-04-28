Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895FB36D7DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbhD1NBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 09:01:00 -0400
Received: from mx-out.tlen.pl ([193.222.135.175]:32461 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239618AbhD1NA7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:00:59 -0400
Received: (wp-smtpd smtp.tlen.pl 815 invoked from network); 28 Apr 2021 15:00:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1619614812; bh=JxD4NCQWWsavhdqtqjcpxaRszwmY/ct3WAZ8qWDgcVE=;
          h=From:To:Cc:Subject;
          b=YPSB3iPx7WqGxrqI0SNXEPsS3ljznp4+G32g+FACMHF2JkAVBYZ/xgThbpGDAU/C3
           P9P91/EXDjeGJYPdxb5w+XJzoLgb2Gp4o/s48WRaM3Dk9aue1ihFAqXj+htQetokg+
           +PdwSc4LmSAupZ6srMUSryA3yWjRiu9kLv8TYIWs=
Received: from 89-64-46-199.dynamic.chello.pl (HELO swift.dev.arusekk.pl) (arek_koz@o2.pl@[89.64.46.199])
          (envelope-sender <arek_koz@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <hch@lst.de>; 28 Apr 2021 15:00:12 +0200
From:   Arusekk <arek_koz@o2.pl>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] proc: Use seq_read_iter where possible
Date:   Wed, 28 Apr 2021 15:02:13 +0200
Message-ID: <9905352.nUPlyArG6x@swift.dev.arusekk.pl>
In-Reply-To: <20210428061259.GA5084@lst.de>
References: <20210427183414.12499-1-arek_koz@o2.pl> <20210428061259.GA5084@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-WP-MailID: d5a3335d5a2651ffc3728d37fd384915
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [IcMh]                               
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 08:12:59 CEST, Christoph Hellwig wrote:
> Patching what entry point?

The instructions at the entry point of the executable being inspected.
The flow of the tool:
- parse ELF headers of the binary to be inspected,
- locate its entry point position in the file,
- write short code at the location (this short code has used sendfile so far),
- execute the patched binary,
- parse the output and extract information about the relevant mappings.
This can be seen as equivalent to setting LD_TRACE_LOADED_OBJECTS,
but also works for static binaries, and is a bit safer.

The problem was reported at:
https://github.com/Gallopsled/pwntools/issues/1871

> Linus did object to blindly switching over all instances.

I know, I read that, but I thought that pointing a real use case, combined 
with the new interface being used all throughout the other code, might be 
convincing.
I would be happy with only changing the f_ops of /proc/.../maps, even if only 
on MMU-enabled systems, but I thought that consistence would be better.
This is my first time contributing to Linux, so I am very sorry for any wrong 
assumptions, and glad to learn more.

-- 
Arusekk


