Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA41056BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUQPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:15:23 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49648 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUQPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:15:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EDB4C8EE10C;
        Thu, 21 Nov 2019 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574352922;
        bh=vsXCsg3ID4OaOFh2QxMCz8/ByYygZx/+8wdbBYQ03HA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fC9USl4Jby/qKS2uI0CmiftfMzzKNZgfN36NSzEH3nKDrbVN/oIH1RzggrbOttf5v
         TLs1BEPJ3Td6L+EnZA7FwdiRBWuuT7jsE5PNIBH4jP2Zc3A17943LN2DZCF1kUWBt3
         3G3w+Ibu85DiF4xYv0x8jQYQRG3GU5q80FUwqUpc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xYXMjVcV6qWT; Thu, 21 Nov 2019 08:15:21 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 74CA38EE0D2;
        Thu, 21 Nov 2019 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574352921;
        bh=vsXCsg3ID4OaOFh2QxMCz8/ByYygZx/+8wdbBYQ03HA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lptKMjgHrSKmOJhdg07ZvL44wwqNI1RoG0wlkpsJlehmK30BCWg9MLx+BNuz77DZt
         P98bAui1e28d0ElwToclsoqQ3oPcaKIl8U+Bx5pD2hg2Qp0vcM1SRmARneF8w5wnjx
         XkgC5L1z6RMV50ShMgApsRPG8d3Jlc8K5nkIvrN8=
Message-ID: <1574352920.3277.18.camel@HansenPartnership.com>
Subject: Re: Feature bug with the new mount API: no way of doing read only
 bind mounts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Nov 2019 08:15:20 -0800
In-Reply-To: <17268.1574323839@warthog.procyon.org.uk>
References: <1574295100.17153.25.camel@HansenPartnership.com>
         <17268.1574323839@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-11-21 at 08:10 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > I was looking to use the read only bind mount as a template for
> > reimplementing shiftfs when I discovered that you can't actually
> > create a read only bind mount with the new API.  The problem is
> > that fspick() will only reconfigure the underlying superblock,
> > which you don't want because you only want the bound subtree to
> > become read only and open_tree()/move_mount() doesn't give you any
> > facility to add or change options on the bind.
> 
> You'd use open_tree() with OPEN_TREE_CLONE and possibly AT_RECURSIVE
> rather than fspick().  fspick() is, as you observed, more for
> reconfiguring the superblock.

In the abstract, I think the concept of a configuration file descriptor
with the, open add parameters and execution to fd, and optionally
convert to representation or reconfigure in place is a very generic
one.  If we did agree to do that for bind mounts as well, I wouldn't
overload the existing logic, I'd lift it up to the generic level,
probably by hooking the execution parts, and make superblock and bind
two implementations of it.  It would basically be 3 system calls:
configopen, configparam and configconvert although obviously with more
appealing names.

The reason for thinking like this is I can see it having utility in
some of the more complex SCSI configuration operations we do today via
a bunch of mechanisms including configfs that could more compactly be
done by this file descriptor mechanism.

I'd also note that this plethora of system calls you have could then go
away: fspick itself would just become an open type to which the path
file descriptor would then be a required parameter, as would open_tree
and the missing mount_setattr would then just work.

James

