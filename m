Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783E7591CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 05:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfF1DAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 23:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfF1DAa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:00:30 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D99208CB;
        Fri, 28 Jun 2019 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561690828;
        bh=pbLYvNe/6qkAnoA79ALM9ag4cBtnyMvqkIIhOCRf2Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zNbh31L95Ds/t4wKKYOnaNQuAvd/Jdq/lVR0fxPThWzMUYK4tIaBviOwSFLoOTvXZ
         9P3QMp+gcKP05LNAxYVo92cnlRj+A73lH/5fcBWoa0G87sFEYE06RqZl+GjVj/dUBj
         H5g1jTPlrTOUhiH8tKTc7aGzNRoP6N73LYkj3mDE=
Date:   Thu, 27 Jun 2019 20:00:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig validation.
Message-ID: <20190628030017.GA673@sol.localdomain>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
 <20190627234149.GA212823@gmail.com>
 <alpine.LRH.2.21.1906271844470.22562@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1906271844470.22562@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jaskaran,

On Thu, Jun 27, 2019 at 06:49:58PM -0700, Jaskaran Singh Khurana wrote:
> 
> 
> On Thu, 27 Jun 2019, Eric Biggers wrote:
> 
> > Hi Jaskaran, one comment (I haven't reviewed this in detail):
> > 
> > On Wed, Jun 19, 2019 at 12:10:48PM -0700, Jaskaran Khurana wrote:
> > > diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> > > index db269a348b20..2d658a3512cb 100644
> > > --- a/drivers/md/Kconfig
> > > +++ b/drivers/md/Kconfig
> > > @@ -475,6 +475,7 @@ config DM_VERITY
> > >  	select CRYPTO
> > >  	select CRYPTO_HASH
> > >  	select DM_BUFIO
> > > +	select SYSTEM_DATA_VERIFICATION
> > >  	---help---
> > >  	  This device-mapper target creates a read-only device that
> > >  	  transparently validates the data on one underlying device against
> > > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > > index be7a6eb92abc..3b47b256b15e 100644
> > > --- a/drivers/md/Makefile
> > > +++ b/drivers/md/Makefile
> > > @@ -18,7 +18,7 @@ dm-cache-y	+= dm-cache-target.o dm-cache-metadata.o dm-cache-policy.o \
> > >  		    dm-cache-background-tracker.o
> > >  dm-cache-smq-y   += dm-cache-policy-smq.o
> > >  dm-era-y	+= dm-era-target.o
> > > -dm-verity-y	+= dm-verity-target.o
> > > +dm-verity-y	+= dm-verity-target.o dm-verity-verify-sig.o
> > >  md-mod-y	+= md.o md-bitmap.o
> > >  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
> > >  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
> > 
> > Perhaps this should be made optional and controlled by a kconfig option
> > CONFIG_DM_VERITY_SIGNATURE_VERIFICATION, similar to CONFIG_DM_VERITY_FEC?
> > 
> > CONFIG_SYSTEM_DATA_VERIFICATION brings in a lot of stuff, which might be
> > unnecessary for some dm-verity users.  Also, you've already separated most of
> > the code out into a separate .c file anyway.
> > 
> > - Eric
> > 
> Hello Eric,
> 
> This started with a config (see V4). We didnot want scripts that pass this
> parameter to suddenly stop working if for some reason the verification is
> turned off so the optional parameter was just parsed and no validation
> happened if the CONFIG was turned off. This was changed to a commandline
> parameter after feedback from the community, so I would prefer to keep it
> *now* as commandline parameter. Let me know if you are OK with this.
> 
> Regards,
> JK

Sorry, I haven't been following the whole discussion.  (BTW, you sent out
multiple versions both called "v4", and using a cover letter for a single patch
makes it unnecessarily difficult to review.)  However, it appears Milan were
complaining about the DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE option which set the
policy for signature verification, *not* the DM_VERITY_VERIFY_ROOTHASH_SIG
option which enabled support for signature verification.  Am I missing
something?  You can have a module parameter which controls the "signatures
required" setting, while also allowing people to compile out kernel support for
the signature verification feature.

Sure, it means that the signature verification support won't be guaranteed to be
present when dm-verity is.  But the same is true of the hash algorithm (e.g.
sha512), and of the forward error correction feature.  Since the signature
verification is nontrivial and pulls in a lot of other kernel code which might
not be otherwise needed (via SYSTEM_DATA_VERIFICATION), it seems a natural
candidate for putting the support behind a Kconfig option.

BTW, I'm doing something similar for fs-verity; see
https://patchwork.kernel.org/patch/11008077/.  The signature verification
support is behind CONFIG_FS_VERITY_BUILTIN_SIGNATURES, but the policy of
requiring signatures is a sysctl fs.verity.require_signatures.

- Eric
