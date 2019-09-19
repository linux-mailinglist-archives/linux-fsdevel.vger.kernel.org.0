Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA20B7A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfISNPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 09:15:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732319AbfISNPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N3ATsTug9sl7XndvxKEm/a4/GmNoRazh1uwz6q7DYO8=; b=Lm8MDDY/OV67l/pcT6Z3dvK21
        C+k/zFe/9t+fscMqP3BQbBEbhnayBgNeXvaGy/w6kTcEV2yIsiyeDwA62SIaxa4buVlzSmlAXC/Zw
        Oxm4B/P84MzFdBmwFTRRBiqL2TTtXYgmKqhZU9LWQTsREJx7TjZlwkoFzEkeJkq/6XU66MAh9GF67
        iM24xGHPY4A3MtHY1052N6QI3XPn7C/NwotwnErbxi66dkYdplJfgwA74UHV52dPm08htzv+VPjUY
        CEC2bJribMg5+CpP7MVNMV9AuQX0r1UwwCxBOVoPgnY0Lk+iEJDnhXBYzjxMIUIo2zN1HIj83yhMo
        ZW8oWr0sw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAwHZ-0002qj-HV; Thu, 19 Sep 2019 13:15:39 +0000
Date:   Thu, 19 Sep 2019 06:15:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL afs: Development for 5.4
Message-ID: <20190919131537.GA15392@bombadil.infradead.org>
References: <28368.1568875207@warthog.procyon.org.uk>
 <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
 <16147.1568632167@warthog.procyon.org.uk>
 <16257.1568886562@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16257.1568886562@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:49:22AM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > > However, I was close to unpulling it again. It has a merge commit with
> > > this merge message:
> > > 
> > >     Merge remote-tracking branch 'net/master' into afs-next
> > > 
> > > and that simply is not acceptable.
> > 
> > Apologies - I meant to rebase that away.  There was a bug fix to rxrpc in
> > net/master that didn't get pulled into your tree until Saturday.
> 
> Actually, waiting for all outstanding fixes to get merged and then rebasing
> might not be the right thing here.  The problem is that there are fixes in
> both trees: afs fixes go directly into yours whereas rxrpc fixes go via
> networking and I would prefer to base my patches on both of them for testing
> purposes.  What's the preferred method for dealing with that?  Base on a merge
> of the lastest of those fixes in each tree?

Why is it organised this way?  I mean, yes, technically, rxrpc is a
generic layer-6 protocol that any blah blah blah, but in practice no
other user has come up in the last 37 years, so why bother pretending
one is going to?  Just git mv net/rxrpc fs/afs/ and merge everything
through your tree.

I feel similarly about net/9p, net/sunrpc and net/ceph.  Every filesystem
comes with its own presentation layer; nobody reuses an existing one.
Just stop pretending they're separate components.
