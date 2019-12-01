Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7794910E26F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2019 16:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLAPzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 10:55:03 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42842 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfLAPzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 10:55:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 88B588EE133;
        Sun,  1 Dec 2019 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575215702;
        bh=vgspgg06S5mIJ4p1OH+sM0udGzcoW3s/nFoNqsRmxRo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ouIQ966xuHxog/W5V3wKeDdxUyAeuT0iz7H4IXlZuzM0+socwHIk/y/52709PTQYe
         3TG4qI5z6eqb8vYv1ipYdC6rKN682BqUdUYQLxbbFey6NWzXSuyQhAzjzzjtFkYtwk
         XGTasxvwiGtDVkOxeCZs2JFKLxomYUP0w90LRxB0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rj8XX9yj2wf4; Sun,  1 Dec 2019 07:55:02 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E2FED8EE0DA;
        Sun,  1 Dec 2019 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575215702;
        bh=vgspgg06S5mIJ4p1OH+sM0udGzcoW3s/nFoNqsRmxRo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ouIQ966xuHxog/W5V3wKeDdxUyAeuT0iz7H4IXlZuzM0+socwHIk/y/52709PTQYe
         3TG4qI5z6eqb8vYv1ipYdC6rKN682BqUdUYQLxbbFey6NWzXSuyQhAzjzzjtFkYtwk
         XGTasxvwiGtDVkOxeCZs2JFKLxomYUP0w90LRxB0=
Message-ID: <1575215700.3374.4.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/1] fs: rethread notify_change to take a path instead
 of a dentry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>
Date:   Sun, 01 Dec 2019 07:55:00 -0800
In-Reply-To: <20191201114706.GL20752@bombadil.infradead.org>
References: <1575148763.5563.28.camel@HansenPartnership.com>
         <1575148868.5563.30.camel@HansenPartnership.com>
         <20191201114706.GL20752@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2019-12-01 at 03:47 -0800, Matthew Wilcox wrote:
> On Sat, Nov 30, 2019 at 01:21:08PM -0800, James Bottomley wrote:
> > @@ -402,6 +403,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct
> > svc_fh *fhp, struct iattr *iap,
> >  
> >  	dentry = fhp->fh_dentry;
> >  	inode = d_inode(dentry);
> > +	path = &(struct path){
> > +		.mnt = fhp->fh_export->ex_path.mnt,
> > +		.dentry = dentry,
> > +	};
> 
> Is this really clearer than writing:
> 
> 	path.mnt = fhp->fh_export->ex_path.mnt;
> 	path.dentry = dentry;

I'm not sure about clearer but certainly better: the general principle
is always do named structure initialization, so in my version any
unspecified fields are cleared.  In your version they're set to
whatever uninitialized data was on the stack.  For struct path, it
probably doesn't matter because it's only ever going to have two
elements for all time, but in general it does.

James

