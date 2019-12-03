Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262C510FFA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCOKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 09:10:54 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34954 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbfLCOKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:10:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1DB038EE12C;
        Tue,  3 Dec 2019 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575382253;
        bh=3nuYzvU4W0IRrZhc/Onz6qcXlfU1cLwtsW8xZrCdAQA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qrMTmuxt577cP50KHGbeCxK41/XB8T+mSVMn0tJqYc0+oaZwrDGhSOVkbtmYoJOAV
         YteWXY7sWQQCGlhpgeiFqWZ9qEJ83EIYOdgedTYBOA0cdlRw67xhV6Sa6WUaCRzzyM
         LRGUlBxGTxF9hYTeDx6LzDK/qWaEaqdXShd0lEJM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OOVPYLao4Iy5; Tue,  3 Dec 2019 06:10:52 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 43FB78EE0D2;
        Tue,  3 Dec 2019 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575382252;
        bh=3nuYzvU4W0IRrZhc/Onz6qcXlfU1cLwtsW8xZrCdAQA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q/0oXsFR4O6RqjoSvHHxCqAeEz6xvfRv/fqalskRH+aUEHk54xMHwCuJ31EscHovJ
         L3vmw+mZvJinAPoanvQgpdVop48pk5sbnCkDzyW9T+tH+J7k8Q5EJsDkgjxYvbVltW
         Bv3nO+Px9OhSLE229zabngtRrIWMlgFuG8lMiUVc=
Message-ID: <1575382251.3435.4.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 03 Dec 2019 06:10:51 -0800
In-Reply-To: <CAOQ4uxgcD5gwOXJfXaNki8t3=6oq32TB9URDpsoQo9A5tyCfqw@mail.gmail.com>
References: <1575335637.24227.26.camel@HansenPartnership.com>
         <1575335700.24227.27.camel@HansenPartnership.com>
         <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
         <1575349974.31937.11.camel@HansenPartnership.com>
         <CAOQ4uxgcD5gwOXJfXaNki8t3=6oq32TB9URDpsoQo9A5tyCfqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[splitting topics for ease of threading]
On Tue, 2019-12-03 at 08:55 +0200, Amir Goldstein wrote:
> On Tue, Dec 3, 2019 at 7:12 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Tue, 2019-12-03 at 06:51 +0200, Amir Goldstein wrote:
> > > [cc: ebiederman]
[...]
> > > 2. Needs serious vetting by Eric (cc'ed)
> > > 3. A lot of people have been asking me for filtering of "dirent"
> > > fsnotify events (i.e. create/delete) by path, which is not
> > > available in those vfs functions, so ifthe concept of current-
> > > >mnt flies, fsnotify is going to want to use it as well.
> > 
> > Just a caveat: current->mnt is used in this patch simply as a tag,
> > which means it doesn't need to be refcounted.  I think I can prove
> > that it is absolutely valid if the cred is shifted because the
> > reference is held by the code that shifted the cred, but it's
> > definitely not valid except for a tag comparison outside of
> > that.  Thus, if it is useful for fsnotify, more thought will have
> > to be given to refcounting it.
> > 
> 
> Yes. Is there anything preventing us from taking refcount on
> current->mnt?

We could, but what would it usefully mean?  It would just be the last
mnt that had its credentials shifted.  I think stashing a refcounted
mnt in the task structure is reasonably easy:  The creds are
refcounted, so you simply follow all the task mnt_cred logic I added
for releasing the ref in the correct places, so if you want to do that,
I can simply rename this tag to something less generic ... unless you
have some idea about using the last shift mnt?

James


