Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D407163934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 02:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBSBTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 20:19:19 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37130 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbgBSBTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:19:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7A0D48EE367;
        Tue, 18 Feb 2020 17:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582075158;
        bh=xIfqzfucbJWWcKXdQLPFmN/N0pl05ZSNks6ieJmGKoo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z+KsDrNXQUB3S0tV7krHBqryNLM47vWtBeSFmNshCOdpSN8Cg1FQEuE6HlUIYvpKE
         zKSlQYpmhcNfhzI8bTHHBpuxcgy6QXBjEF7hNauNou/Gaccbx5+Ymfk78Qsp6b0i1B
         0bFyOHlGd5kHg/Su47DuR5ZaWR38EYK19xUu4D54=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VTMFlHDLiULv; Tue, 18 Feb 2020 17:19:18 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DB4698EE0D5;
        Tue, 18 Feb 2020 17:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582075158;
        bh=xIfqzfucbJWWcKXdQLPFmN/N0pl05ZSNks6ieJmGKoo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z+KsDrNXQUB3S0tV7krHBqryNLM47vWtBeSFmNshCOdpSN8Cg1FQEuE6HlUIYvpKE
         zKSlQYpmhcNfhzI8bTHHBpuxcgy6QXBjEF7hNauNou/Gaccbx5+Ymfk78Qsp6b0i1B
         0bFyOHlGd5kHg/Su47DuR5ZaWR38EYK19xUu4D54=
Message-ID: <1582075157.31675.0.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 2/3] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>
Date:   Tue, 18 Feb 2020 17:19:17 -0800
In-Reply-To: <20200218223313.GA15846@infradead.org>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
         <20200217205307.32256-3-James.Bottomley@HansenPartnership.com>
         <20200218223313.GA15846@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-18 at 14:33 -0800, Christoph Hellwig wrote:
> On Mon, Feb 17, 2020 at 12:53:06PM -0800, James Bottomley wrote:

[...]
> > diff --git a/include/linux/cred.h b/include/linux/cred.h
> > index 18639c069263..d29638617844 100644
> > --- a/include/linux/cred.h
> > +++ b/include/linux/cred.h
> > @@ -59,6 +59,7 @@ extern struct group_info *groups_alloc(int);
> >  extern void groups_free(struct group_info *);
> >  
> >  extern int in_group_p(kgid_t);
> > +extern int in_group_p_shifted(kgid_t);
> 
> How do I know when to use in_group_p_shifted vs in_group_p?
> What about the various other fs callers?

So this is one I wondered about too.  The problem is that the shifted
credential (the one representing the fsuid/fsgid the filesystem will
see) still has cred->group_info representing the kuid/kgid which are
unshifted from the filesystem perspective.  The solution was to use
in_group_p_shifted when you're comparing a filesystem view fsgid and
use in_group_p when you're comparing a kernel kgid.

However, I'm now thinking that's way too complex and what should happen
is that I should shift every member of cred->group_info so that all
searches happen on the fs view, meaning the fs always uses in_group_p
like it does today and only the corner cases that compare a kgid need
shifting.

James


