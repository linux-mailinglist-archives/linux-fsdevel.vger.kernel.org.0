Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643FCE63AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJ0PWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 11:22:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfJ0PWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ABDhaHUlk58M0GS8x0OMrJzxXgr2v5RmyRmLK7Waq+g=; b=dUZFeTqfxrYApphqMY5veHBsj
        A+RBT+sV9JAtjLVJ+WGOvwNXNw/oX5Nmdvk/AvVWpQtUikMzhdcFtLs1khOn6BULZkyos9EyCedJ5
        hnt6JriZauG8vb9KgHx/w5MlX/0VsPY2qith2hEChaeTwdY1U4gqTqvfXNegsgqDSyxL508wE6OTp
        rSaIg8nxkLmtsXAZhqw2s7U224aDC3inBSdoJfjj10LxclpiVy3dsmRybQQ2cjBiPNh9YfQem1O52
        i64kZVSne/xbFmaWrYMJPXP1/NB8tION2wFu8JyUehQlS7P6++7uDvnUPpIJ80aCkyA7RRWHTg8rb
        VpLLc/GSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOkN5-0005Zc-Hn; Sun, 27 Oct 2019 15:22:23 +0000
Date:   Sun, 27 Oct 2019 08:22:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
Message-ID: <20191027152223.GA21194@infradead.org>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30394.1571936252@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:57:32PM +0100, David Howells wrote:
> pipe: Add fsync() support
> 
> The keyrings testsuite needs the ability to wait for all the outstanding
> notifications in the queue to have been processed so that it can then go
> through them to find out whether the notifications it expected have been
> emitted.
> 
> Implement fsync() support for pipes to provide this.  The tailmost buffer
> at the point of calling is marked and fsync adds itself to the list of
> waiters, noting the tail position to be waited for and marking the buffer
> as no longer mergeable.  Then when the buffer is consumed, if the flag is
> set, any matching waiters are woken up.

I am _really_ worried about overloading fsync for this behavior.  fsync
hasn't done anything for 50 years, and suddenly adding any action
is not helpful.  If you can't use FIONREAD please add a new ioctls
instead, and document it properly.
