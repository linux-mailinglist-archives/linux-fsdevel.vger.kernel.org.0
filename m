Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8F46ADC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 23:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376810AbhLFW5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 17:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376257AbhLFW4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:56:19 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D35C0613FE;
        Mon,  6 Dec 2021 14:52:50 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 661BC2C0; Mon,  6 Dec 2021 17:52:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 661BC2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638831169;
        bh=ARk5YW72X9w/wMd3pZ7wsZFkXgp4dQKKhbNjeUxpc9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRQB7NzCBG2Xxg1yo5dyNA1Q3t1hrDVqKTFVjccN0tixARD5Ue9l/t5qICXWH8wlY
         6H8DvKnQ50QraSkqsShYCI2yy6pbLwixgwG/mQdgSYcVnk+mmCDVHVzu6ZHzy6vRLt
         XZJ+gVME+NoZJrdDjl/tZuYibcnNegQfE43hvvBg=
Date:   Mon, 6 Dec 2021 17:52:49 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211206225249.GE20244@fieldses.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <01923a7c-bb49-c004-8a35-dbbae718e374@oracle.com>
 <242C2259-2CF0-406F-B313-23D6D923C76F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242C2259-2CF0-406F-B313-23D6D923C76F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:30:45PM +0000, Chuck Lever III wrote:
> OK, this is really confusing.
> 
> 5142         set_deny(open->op_share_deny, stp);
> 5143         fp->fi_share_deny |= (open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> 
> Here set_deny() is treating the contents of open->op_share_deny
> as bit positions, but then upon return NFS4_SHARE_DENY_BOTH
> is used directly as a bit mask. Am I reading this correctly?
> 
> But that's not your problem, so I'll let that be.

This is weird but intentional.

For most practical purposes, fi_share_deny is all that matters.

BUT, there is also this language in the spec for OPEN_DOWNGRADE:

	https://datatracker.ietf.org/doc/html/rfc5661#section-18.18.3

	The bits in share_deny SHOULD equal the union of the share_deny
	bits specified for some subset of the OPENs in effect for the
	current open-owner on the current file.

	If the above constraints are not respected, the server SHOULD
	return the error NFS4ERR_INVAL.

If you open a file twice, once with DENY_READ, once with DENY_WRITE,
then that is not *quite* the same as opening it once with DENY_BOTH.  In
the former case, you're allowed to, for example, downgrade to DENY_READ.
In the latter, you're not.

So if we want to the server to follow that SHOULD, we need to remember
not only that the union of all the DENYs so far, you also need to
remember the different DENY modes that different OPENs were done with.

So, we also keep the st_deny_bmap with that information.

The same goes for allow bits (hence there's also an st_access_bmap).

It's arguably a lot of extra busy work just for one SHOULD that has no
justification other than just to be persnickety about client
behavior....

--b.
