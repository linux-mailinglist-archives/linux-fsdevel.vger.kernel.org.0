Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB4154DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 22:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgBFVKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 16:10:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727543AbgBFVKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581023436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1cpKivOnpmIeBs6dCDGwYcwPckDr7hTGtXIHu5JIzxs=;
        b=LPFqqWO8EejTO4jplwV7fZRmTAZPGanXMzqUE4w/zPZeH/37jgTFIOMDymstC4PNdvZEzA
        xSIshztFA1bUPbQBhAToxIYOm1GTddOSgw0m2DrnVXCZU3lMUFgY+f1axPU2SKrsytIxDX
        XBFvXkRyN2rZNkngkZ9vTbDkYI/mlZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-E78yXA8cN52mC1Au5vMBdQ-1; Thu, 06 Feb 2020 16:10:32 -0500
X-MC-Unique: E78yXA8cN52mC1Au5vMBdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16EFD800D5C;
        Thu,  6 Feb 2020 21:10:31 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-124-80.rdu2.redhat.com [10.10.124.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E255760C05;
        Thu,  6 Feb 2020 21:10:30 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 46BCD1201F8; Thu,  6 Feb 2020 16:10:29 -0500 (EST)
Date:   Thu, 6 Feb 2020 16:10:29 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
Message-ID: <20200206211029.GA53503@pick.fieldses.org>
References: <20200126220800.32397-1-amir73il@gmail.com>
 <20200127173002.GD115624@pick.fieldses.org>
 <CAOQ4uxhqO5DtSwAtO950oGcnWVaVG+Vcdu6TYDfUKawVNGWEiA@mail.gmail.com>
 <20200127211757.GA122687@pick.fieldses.org>
 <CAOQ4uxiXceNbL6jPW9LSH_ijftwHd8NzUACG6w7raZhSoeR1Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiXceNbL6jPW9LSH_ijftwHd8NzUACG6w7raZhSoeR1Ew@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:22:21PM +0200, Amir Goldstein wrote:
> On Mon, Jan 27, 2020 at 11:18 PM J. Bruce Fields <bfields@redhat.com> wrote:
> >
> > On Mon, Jan 27, 2020 at 08:38:00PM +0200, Amir Goldstein wrote:
> > > > > Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> > > > > warning") changes this behavior from always returning success,
> > > > > regardless if dentry was reconnected by somoe other task, to always
> > > > > returning a failure.
> > > >
> > > > I wonder whether it might be safest to take the out_reconnected case on
> > > > any error, not just -ENOENT.
> > > >
> > >
> > > I wondered that as well, but preferred to follow the precedent.
> >
> > I can live with that.
> 
> Will you take this patch through your tree,
> or do you want me to re-post to Al?

If Al wants to delegate exportfs/ patches to nfsd maintainers that's OK
by me, but in the past I think it's always him that's taken them.

> With your Reviewed-by?

That'd be fine.  Thanks!

--b.

