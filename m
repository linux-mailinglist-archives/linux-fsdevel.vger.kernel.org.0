Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121AD634B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfGILCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 07:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGILCp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:02:45 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA9E20861;
        Tue,  9 Jul 2019 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562670164;
        bh=hL37JcKeLyH9DZ7CbyS9wdqGlD9LnWI+3fpZyFuIhpA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Atbk/mDDVQ3d+H+TE2v8QPNIv6+4uHKrnLjsYM7WJEuwr7qttU76I6dW1eeRnO0g6
         j+1Qqc/4TLOXUTlOuXTqRdxWAf/eXJigPJgmB/yPlWrmWPxwDf1tIWSnKoIHf7Bqv2
         vZiLMEiTjXvoYA9m9hf6EdzHej8dz3gyBz2kGh5k=
Message-ID: <d86b0afa34654da16b4ecfeb6d23a6b0efcea3ba.camel@kernel.org>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write
 lease
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Tue, 09 Jul 2019 07:02:42 -0400
In-Reply-To: <CAOQ4uxjBGHh9cU7EX7X3F-iVFZkD+kax2x+Hj8YX83HMiwLqSw@mail.gmail.com>
References: <20190612172408.22671-1-amir73il@gmail.com>
         <2851a6b983ed8b5b858b3b336e70296204349762.camel@kernel.org>
         <CAOQ4uxi-uEhAbqVeYbeqAR=TXpthZHdUKkaZJB7fy1TgdZObjQ@mail.gmail.com>
         <20190613140804.GA2145@fieldses.org>
         <CAOQ4uxjBGHh9cU7EX7X3F-iVFZkD+kax2x+Hj8YX83HMiwLqSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-07-08 at 19:09 +0300, Amir Goldstein wrote:
> On Thu, Jun 13, 2019 at 5:08 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> > On Thu, Jun 13, 2019 at 04:28:49PM +0300, Amir Goldstein wrote:
> > > On Thu, Jun 13, 2019 at 4:22 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > Looks good to me. Aside from the minor nit above:
> > > > 
> > > >     Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > 
> > > > I have one file locking patch queued up for v5.3 so far, but nothing for
> > > > v5.2. Miklos or Bruce, if either of you have anything to send to Linus
> > > > for v5.2 would you mind taking this one too?
> > > > 
> > > 
> > > Well. I did send a fix patch to Miklos for a bug introduced in v5.2-rc4,
> > > so...
> > 
> > I could take it.  I've modified it as below.
> > 
> > I'm very happy with the patch, but not so much with the idea of 5.2 and
> > stable.
> > 
> > It seems like a subtle change with some possibility of unintended side
> > effects.  (E.g. I don't think this is true any more, but my memory is
> > that for a long time the only thing stopping nfsd from giving out
> > (probably broken) write delegations was an extra reference that it held
> > during processing.) And if the overlayfs bug's been there since 4.19,
> > then waiting a little longer seems OK?
> > 
> 
> Getting back to this now that the patch is on its way to Linus.
> Bruce, I was fine with waiting to 5.3 and I also removed CC: stable,
> but did you mean that patch is not appropriate for stable or just that
> we'd better wait a bit and let it soak in master before forwarding it to stable?
> 

With NFS and SMB, oplocks/leases/delegations are optimizations and
you're never guaranteed to get one in the face of competing access.

stable-kernel-rules.rst says:

- It must fix a problem that causes a build error (but not for
things marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
security issue, or some "oh, that's not good" issue.  In short,
something critical.

I'm not sure this clears that bar.
-- 
Jeff Layton <jlayton@kernel.org>

