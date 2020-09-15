Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03926A66D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIONmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbgIONkp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:40:45 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30DD206F4;
        Tue, 15 Sep 2020 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600177111;
        bh=dnk77g8nK72wv6GTGRvDna349HEYviXisPcF8thK9UA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ImFliwOUA173BHK+cxYhaLNr1xPbfN7LncVdraxkIgJpmuyoQyhwo7L/E3pbjHmXY
         13ZySh+xe2qiNjrZ9s56XY1RhrSj6zRGUa6rfNN/HKILrt0XX8czzeQAXDQ7fYTPa1
         2O9d5j2OkkuhVOLU8EhYPYgisjywLniX9DjDInbI=
Message-ID: <66f18d1c84a0bed67908c76cf3ec3dc7795c98e3.camel@kernel.org>
Subject: Re: [RFC PATCH v3 00/16] ceph+fscrypt: context, filename and
 symlink support
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 15 Sep 2020 09:38:29 -0400
In-Reply-To: <20200915021334.GN899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
         <20200915021334.GN899@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-14 at 19:13 -0700, Eric Biggers wrote:
> On Mon, Sep 14, 2020 at 03:16:51PM -0400, Jeff Layton wrote:
> > This is the third posting of the ceph+fscrypt integration work. This
> > just covers context handling, filename and symlink support.
> > 
> > The main changes since the last set are mainly to address Eric's review
> > comments. Hopefully this will be much closer to mergeable. Some highlights:
> > 
> > 1/ rebase onto Eric's fscrypt-file-creation-v2 tag
> > 
> > 2/ fscrypt_context_for_new_inode now takes a void * to hold the context
> > 
> > 3/ make fscrypt_fname_disk_to_usr designate whether the returned name
> >    is a nokey name. This is necessary to close a potential race in
> >    readdir support
> > 
> > 4/ fscrypt_base64_encode/decode remain in fs/crypto (not moved into lib/)
> > 
> > 5/ test_dummy_encryption handling is moved into a separate patch, and
> >    several bugs fixed that resulted in context not being set up
> >    properly.
> > 
> > 6/ symlink handling now works
> > 
> > Content encryption is the next step, but I want to get the fscache
> > rework done first. It would be nice if we were able to store encrypted
> > files in the cache, for instance.
> > 
> > This set has been tagged as "ceph-fscrypt-rfc.3" in my tree here:
> > 
> >     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
> > 
> > Note that this is still quite preliminary, but my goal is to get a set
> > merged for v5.11.
> 
> A few comments that didn't fit anywhere else:
> 
> I'm looking forward to contents encryption, as that's the most important part.
> 

Me too, but I've got a fairly substantial rework of the buffered
writeback code queued up to handle some fscache changes. We'll probably
need to teach fscache how to deal with encrypted data, so I haven't
really started on that part yet.

> Is there any possibility that the fscrypt xfstests can be run on ceph?
> See: https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html#tests
> 

I've been testing with the xfstests "quick" group as a sanity test, but
it doesn't have the fscrypt tests. I'll try them out soon.

> In fs/ceph/Kconfig, CEPH_FS needs:
> 
> 	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
> 
> There are compile errors when !CONFIG_FS_ENCRYPTION.
> 

Thanks. I should have added the caveat that this is still _very_ rough
and not at all ready for merge. I'll definitely fix up
the !CONFIG_FS_ENCRYPTION case before I send the next set.

Thanks for the detailed review so far. I'm working through your comments
now and should address most of them in the next set.
-- 
Jeff Layton <jlayton@kernel.org>

