Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC27D10E1C3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLALrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 06:47:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLALrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 06:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ktG3ZmdA69WQp1lqbvzAHYtvHXPbQS3sZQscx5ZDsPY=; b=ipXRZ/L4qhNAzKHyAvkVv9a7O
        RWo/GiLRR6gaJs1B43bz/Qk4souz7bYn59xnb4fgb2ER7O2KlHgBtnzvO4a1ibrVYWurJ0qZW/M/b
        jLVqqhEsyhUW9W92lSm4mmTCiPbHF9WnN+SKDP5mXezV2BOkhltXRDVA68u4VgeGBxo0L+zML+HjL
        CKTdVYT2n0HObjBxag0LgFR9P9waO3vXqYWa79k4Qm2wtlytYOi5xPUi5yKQwPP8oVPjk3KK1lVSc
        5mbE3lQLzHdCk4+LHnS553YQe5dl6nRCdNjTOnbCI6J0ie2aqzQQ1ZQuXV7Er9jeAFxXcvHTR1hmA
        7CYMNg5og==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibNgw-0004hy-SX; Sun, 01 Dec 2019 11:47:06 +0000
Date:   Sun, 1 Dec 2019 03:47:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 1/1] fs: rethread notify_change to take a path instead of
 a dentry
Message-ID: <20191201114706.GL20752@bombadil.infradead.org>
References: <1575148763.5563.28.camel@HansenPartnership.com>
 <1575148868.5563.30.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575148868.5563.30.camel@HansenPartnership.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 30, 2019 at 01:21:08PM -0800, James Bottomley wrote:
> @@ -402,6 +403,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
>  
>  	dentry = fhp->fh_dentry;
>  	inode = d_inode(dentry);
> +	path = &(struct path){
> +		.mnt = fhp->fh_export->ex_path.mnt,
> +		.dentry = dentry,
> +	};

Is this really clearer than writing:

	path.mnt = fhp->fh_export->ex_path.mnt;
	path.dentry = dentry;

(there are a few other occurrences I'd change)
