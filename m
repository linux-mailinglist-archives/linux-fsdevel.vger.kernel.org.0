Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B581D2609D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 07:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIHFMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 01:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgIHFMk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:12:40 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C1B2166E;
        Tue,  8 Sep 2020 05:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599541959;
        bh=tJLgadhddl13X0Eagyq+gBGuNdsfc0/7cQwoI1RUnUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U09ynWyTcRyRzb5y1id1YWRma4rBRNeY19X9t/Z1luVS1X0NLg9DlxuIbOkegNPMM
         UOdwIeArSqBTbasym6d+zOntmnyZ94OFoFUIySaAhXHkbZnF39qaAGoL20oJst+cKE
         c4F7/SUAMAkV4qUF/IrlBzntLr2KMU3FEG9prhqQ=
Date:   Mon, 7 Sep 2020 22:12:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 15/18] ceph: make d_revalidate call fscrypt
 revalidator for encrypted dentries
Message-ID: <20200908051238.GM68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-16-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-16-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:34PM -0400, Jeff Layton wrote:
> If we have an encrypted dentry, then we need to test whether a new key
> might have been established or removed. Do that before we test anything
> else about the dentry.

A more accurate explanation would be:

"If we have a dentry which represents a no-key name, then we need to test
 whether the parent directory's encryption key has since been added."

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/dir.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index b3f2741becdb..cc85933413b9 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1695,6 +1695,12 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
>  	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
>  	     dentry, inode, ceph_dentry(dentry)->offset);
>  
> +	if (IS_ENCRYPTED(dir)) {
> +		valid = fscrypt_d_revalidate(dentry, flags);
> +		if (valid <= 0)
> +			return valid;
> +	}

There's no need to check IS_ENCRYPTED(dir) here.

- Eric
