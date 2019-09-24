Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB50CBD3C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfIXUuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:50:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIXUuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X29R68SVs2Hrds/uDkRhp/eVeg0K6JGMVMqK20FNRBk=; b=CUAX4pwbIslfhY1Yo7H56lNcB
        QCXJXDIlbrnqwbvuFrId1DVv2Skcyw/a9mtDm/+g30U20oFy3jYxxsHdzaIwnh6CnBTg+i4WbSzVO
        7ZWuMSow2ebag3FLN+ur+ZrG+gWR3VxcfEDQT44iIeZjRaAaf/UCebVRpB5WiCuYGQc1LhacPm9Ty
        M8Y2aZ83ow0/9DQ/xu3XmkQke5CA6Ax5q5JBRhkWGpL10bbGU77svsPMlU+tBNUZCnxJJK2gouHnR
        TH9/mxsEn7o/R3jazT75USUpEHZxk1UkvTZL1KjzW4VZ9WqjnLmQ7jwFInVhAtzPET3Vb9SsnMuvi
        HHl0ZfUww==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCrlG-0005S3-7Z; Tue, 24 Sep 2019 20:50:14 +0000
Date:   Tue, 24 Sep 2019 13:50:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>, Omar Sandoval <osandov@osandov.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Message-ID: <20190924205014.GJ1855@bombadil.infradead.org>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader>
 <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190924202229.mjvjigpnrskjtk5n@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924202229.mjvjigpnrskjtk5n@wittgenstein>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:22:29PM +0200, Christian Brauner wrote:
> On Tue, Sep 24, 2019 at 10:01:41PM +0200, Jann Horn wrote:
> > Mmh... but if the file descriptor has been passed through a privilege
> > boundary, it isn't really clear whether the original opener of the
> > file intended for this to be possible. For example, if (as a
> > hypothetical example) the init process opens a service's logfile with
> > root privileges, then passes the file descriptor to that logfile to
> > the service on execve(), that doesn't mean that the service should be
> > able to perform compressed writes into that file, I think.
> 
> I think we should even generalize this: for most new properties a given
> file descriptor can carry we would want it to be explicitly enabled such
> that passing the fd around amounts to passing that property around. At
> least as soon as we consider it to be associated with some privilege
> boundary. I don't think we have done this generally. But I would very
> much support moving to such a model.

I think you've got this right.  This needs to be an fcntl() flag, which
is only settable by root.  Now, should it be an O_ flag, modifiable by
F_SETFL, or should it be a new F_ flag?
