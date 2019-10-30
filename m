Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E0E9C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 14:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfJ3NtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 09:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3NtR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:49:17 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AC62087E;
        Wed, 30 Oct 2019 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572443357;
        bh=dUusjx3ywSPOuaYvaHLTu0RConlG+TMDy1ocUNW4ZoI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ieNDJTsFzBCDbkNOkDvUjbczXjizL8R1sjbNdWPdRQSLwonv9hsLUHc+qkimQynew
         IVEcz3z/zr1yCZ28I6gooaCZgMP37o5kU13WW4CQyecTmhqnj4HxO6c7ZhNW5dffgH
         XRFGH3xsb+GJwSKuN6F9vBIZDhSna/+7GqO20uH8=
Message-ID: <ab18543fbecfa6a6ac8003a9b506b74b1acddcab.camel@kernel.org>
Subject: Re: [PATCH] ceph_fill_trace(): add missing check in d_revalidate
 snapdir handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Date:   Wed, 30 Oct 2019 09:49:15 -0400
In-Reply-To: <20191029135329.GI26530@ZenIV.linux.org.uk>
References: <20191029135329.GI26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-10-29 at 13:53 +0000, Al Viro wrote:
> [resent to correct address]
> 
> we should not play with dcache without parent locked...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 9f135624ae47..c07407586ce8 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1434,6 +1434,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
>  		dout(" final dn %p\n", dn);
>  	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
>  		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
> +	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
>  		   !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
>  		struct inode *dir = req->r_parent;
>  

Thanks Al.

Both patches merged and marked for stable. Ilya should send a PR to
Linus with these within the next week or so.
-- 
Jeff Layton <jlayton@kernel.org>

