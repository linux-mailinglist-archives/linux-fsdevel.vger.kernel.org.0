Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0664E5D932
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 02:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGCAhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 20:37:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59280 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfGCAhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:37:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 48BE28EE1D2;
        Tue,  2 Jul 2019 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562114254;
        bh=uyzX6BoE1CwDs0CD6pnhs6F4/+UpRopcnU/hOzBnNNw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vQyDZzWW3sZnLm6fLKFB04mnrY7TaJBg9G//u7FKHiUAnX2V912X26EJRk/KmTvcn
         jJIsM6mRZZ2kmRUzeBDhzzvsWS0sUfyvdTLOe1EzswmTn2GT/3NsvAjo1Vda+yYgVg
         COlvz7XL50US3q2NEesSe7p2LrfMTOpSD/mUzxyM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8bT_NPhGTwR4; Tue,  2 Jul 2019 17:37:34 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BAAF18EE0CC;
        Tue,  2 Jul 2019 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562114253;
        bh=uyzX6BoE1CwDs0CD6pnhs6F4/+UpRopcnU/hOzBnNNw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YpJyr7JsuVvGT1ykRzxd9h2/EEh1dPbfQKip40Wx6lDwrObnlS+tSy27iSu5DqwhP
         fX4CrrGlhUxZcLrv6fVTDHkSL9SSUMRzu3NDnxPT0C3K4k34KaEDkahutoDjOS7oZM
         1qdtKsMME+Hty5mWf4bdJB7ZeS8WyVmk0Jc5O+K0=
Message-ID: <1562114252.29304.64.camel@HansenPartnership.com>
Subject: Re: [BUG] mke2fs produces corrupt filesystem if badblock list
 contains a block under 251
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Tue, 02 Jul 2019 17:37:32 -0700
In-Reply-To: <20190702203937.GG3032@mit.edu>
References: <1562021070.2762.36.camel@HansenPartnership.com>
         <20190702002355.GB3315@mit.edu>
         <1562028814.2762.50.camel@HansenPartnership.com>
         <20190702173301.GA3032@mit.edu>
         <1562095894.3321.52.camel@HansenPartnership.com>
         <20190702203937.GG3032@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-07-02 at 16:39 -0400, Theodore Ts'o wrote:
> On Tue, Jul 02, 2019 at 12:31:34PM -0700, James Bottomley wrote:
> > Actually, this is giving me:
> > 
> > mke2fs: Operation not supported for inodes containing extents while
> > creating huge files
> > 
> > Is that because it's an ext4 only feature?
> 
> That'll teach me not to send out a sequence like that without testing
> it myself first.  :-)

Heh, join the club ... it has a very large membership ... I've got a
frequent flier card for it ...

> Yeah, because one of the requirements was to make the file
> contiguous, without any intervening indirect block or extent tree
> blocks, the creation of the file is done manually, and at the time, I
> only implemented it for extents, since the original goal of the goal
> was to create really big files (hence the name of the feature
> "mk_hugefile"), and using indirect blocks would be a huge waste of
> disk space.

I guessed as much.

> It wouldn't be that hard for me to add support for indirect block
> maps, or if you were going to convert things over so that the pa_risc
> 2nd stage boot loader can understand how to read from extents,
> that'll allow this to work as well.

Let me look at it.  I think I can just take routines out of lib/ext2fs
and graft them into the IPL, but our own home grown ext2/3 handling
routines are slightly eccentric so it's not as simple as that.

James

