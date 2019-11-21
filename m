Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA86105687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUQHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:07:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfKUQHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zwTICfRN5iACciAHZej7Yc13+NfID7IlxajfIE6j//U=; b=M9Dg9W3xQri5/iGpRMcBCnDHT
        Rq+TUwNMYFn45MoG8UEYPNCuWZtZbFPkFKYwSp8k3Mr/WM/ConXVjW4ee0bYkrFXfihxS5iEog2R7
        LqIhicHqEHG833ceHRr+8Ff2HRtkL2SUJxNhaVl0lo9382vdai2B4TrZiXxEaRwVric7HeYzhT38C
        DHaL0WkAGuJ7nU8m+ydaWbjtQ/Flcva12OImgfH2Qg+Pf3AiKwmt3RHfF5TMNDAX3IueIVRrIgS5z
        SL3r6r5qwi+8kITxgAJHXrY6uQgz3MqzkiWa1pjfiHOe5PkOpEwoJYu63zUuSpEzcsrGoq150/Cnx
        A4DD4JI3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXozN-00055c-L3; Thu, 21 Nov 2019 16:07:25 +0000
Date:   Thu, 21 Nov 2019 08:07:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cifs: Don't use iov_iter::type directly
Message-ID: <20191121160725.GA19291@infradead.org>
References: <20191121081923.GA19366@infradead.org>
 <157432403818.17624.9300948341879954830.stgit@warthog.procyon.org.uk>
 <30992.1574327471@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30992.1574327471@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:11:11AM +0000, David Howells wrote:
> What I've been exploring is moving to:
> 
> 	ITER_IOVEC = 0
> 	ITER_KVEC = 1,
> 	ITER_BVEC = 2,
> 	ITER_PIPE = 3,
> 	ITER_DISCARD = 4,
> 
> and using switch statements - and then leaving it to the compiler to decide
> how best to do things.  In some ways, it might be nice to let the compiler
> decide what constants it might use for this so as to best optimise the use
> cases, but there's no way to do that at the moment.

I'm all in favor of that. 

> However, all the code that is doing direct accesses using '&' has to change to
> make that work - so I've converted it all to using accessors so that I only
> have to change the header file, except that the patch to do that crossed with
> a cifs patch that added more direct accesses, IIRC.

But I still don't really see the point of the wrappers.  Maybe they are
ok as a migration strategy, but in that case this patch mostly makes
sense as part of the series only.
