Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5C7131608
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgAFQ3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 11:29:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726677AbgAFQ3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578328139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWZzCo0dL1t3oBL+mRxnfhduXRW4GvQOIUYTk1rT7zk=;
        b=YtQNgwvOxTFB8V78QlgV0YOa7/TYyx5TQH10B8ONOSzQRytVLieqUTVfExaCowA/cnnWNN
        QnmyyW7z7zHFz00OZM7SHLzwgrcAXDDSCroqsc2kfE2Hx0qlrfcpTAMidmm3cEQ1rEv69N
        5o9Ywkv6JeW+A6EIT5BIxZYnjDuRTS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-5o_xm6yvM4OHFzWq3DrMOQ-1; Mon, 06 Jan 2020 11:28:58 -0500
X-MC-Unique: 5o_xm6yvM4OHFzWq3DrMOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E3F218552DF;
        Mon,  6 Jan 2020 16:28:57 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-126-209.rdu2.redhat.com [10.10.126.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B1E10840F5;
        Mon,  6 Jan 2020 16:28:56 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 9E8D7120198; Mon,  6 Jan 2020 11:28:54 -0500 (EST)
Date:   Mon, 6 Jan 2020 11:28:54 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     trond.myklebust@hammerspace.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH]: nfs acl: bugfix, don't use static nfsd_acl_versions[]
Message-ID: <20200106162854.GA25029@pick.fieldses.org>
References: <29104.1578242282@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29104.1578242282@jrobl>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, but, see 7c149057d044 "nfsd: restore NFSv3 ACL support", in
5.5-rc1; looks like you and I both stumbled on the identical fix?--b.

On Mon, Jan 06, 2020 at 01:38:02AM +0900, J. R. Okajima wrote:
> Here is a patch to fix nfs acl.
> 
> J. R. Okajima
> 
> ----------------------------------------
> commit 8684b9a7c55e9283e8b21112fbdf19b4d27f36b7
> Author: J. R. Okajima <hooanon05g@gmail.com>
> Date:   Mon Jan 6 01:31:20 2020 +0900
> 
>     nfs acl: bugfix, don't use static nfsd_acl_versions[]
>     
>     By the commit for v5.2-rc1,
>     e333f3bbefe3 2019-04-24 nfsd: Allow containers to set supported nfs versions
>     the line to copy a value from nfsd_acl_version[] to static
>     nfsd_acl_versions[] was removed.  It is OK, but nfsd_acl_versions[] is
>     still set to nfsd_acl_program.pg_vers which means pg_vers has NULLs for
>     its all entires and nfsacl stops working entirely.
>     I am afraid the removal of static nfsd_acl_versions[] was just
>     forgotten.
>     
>     Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 18d94ea984ba..7f938bcb927d 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -94,12 +94,11 @@ static const struct svc_version *nfsd_acl_version[] = {
>  
>  #define NFSD_ACL_MINVERS            2
>  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
> -static const struct svc_version *nfsd_acl_versions[NFSD_ACL_NRVERS];
>  
>  static struct svc_program	nfsd_acl_program = {
>  	.pg_prog		= NFS_ACL_PROGRAM,
>  	.pg_nvers		= NFSD_ACL_NRVERS,
> -	.pg_vers		= nfsd_acl_versions,
> +	.pg_vers		= nfsd_acl_version,
>  	.pg_name		= "nfsacl",
>  	.pg_class		= "nfsd",
>  	.pg_stats		= &nfsd_acl_svcstats,
> 

