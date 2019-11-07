Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAEF3AF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 23:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKGWM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 17:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGWM7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:12:59 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96BA2075C;
        Thu,  7 Nov 2019 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573164778;
        bh=sumKTTMSu0TjJWnjdn6qQq4QblYrYnTbD5OwaLmnW5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeN+ChtHQHJOrgWAnW3PkTwaUugMas6qp/lkjPGpxmLky0BCWxxrj/L4Hw2tOllRq
         eUybTaY70haNLirl0N5ZQwGMGqohpHOdSNfxRNLs7tRlGtGPrjH7XY9Ybj6lkmA1PJ
         mA9rv2v0pQvvx0U19R4VgA8fkiHdVMcAoaLF6gsE=
Date:   Thu, 7 Nov 2019 14:12:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 1/4] statx: define STATX_ATTR_VERITY
Message-ID: <20191107221255.GB1160@gmail.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
References: <20191029204141.145309-1-ebiggers@kernel.org>
 <20191029204141.145309-2-ebiggers@kernel.org>
 <20191107014420.GD15212@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107014420.GD15212@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:44:20PM -0800, Darrick J. Wong wrote:
> On Tue, Oct 29, 2019 at 01:41:38PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add a statx attribute bit STATX_ATTR_VERITY which will be set if the
> > file has fs-verity enabled.  This is the statx() equivalent of
> > FS_VERITY_FL which is returned by FS_IOC_GETFLAGS.
> > 
> > This is useful because it allows applications to check whether a file is
> > a verity file without opening it.  Opening a verity file can be
> > expensive because the fsverity_info is set up on open, which involves
> > parsing metadata and optionally verifying a cryptographic signature.
> > 
> > This is analogous to how various other bits are exposed through both
> > FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  include/linux/stat.h      | 3 ++-
> >  include/uapi/linux/stat.h | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index 765573dc17d659..528c4baad09146 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
> > @@ -33,7 +33,8 @@ struct kstat {
> >  	 STATX_ATTR_IMMUTABLE |				\
> >  	 STATX_ATTR_APPEND |				\
> >  	 STATX_ATTR_NODUMP |				\
> > -	 STATX_ATTR_ENCRYPTED				\
> > +	 STATX_ATTR_ENCRYPTED |				\
> > +	 STATX_ATTR_VERITY				\
> >  	 )/* Attrs corresponding to FS_*_FL flags */
> >  	u64		ino;
> >  	dev_t		dev;
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 7b35e98d3c58b1..ad80a5c885d598 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -167,8 +167,8 @@ struct statx {
> >  #define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
> >  #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
> >  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
> > -
> >  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> > +#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> 
> Any reason why this wasn't 0x2000?

Yes, as Andreas pointed out, the value is chosen to match the corresponding
FS_IOC_GETFLAGS bit, like the other bits above marked [I].

> 
> If there's a manpage update that goes with this, then...
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> 

It's pretty trivial to add it to the statx(2) man page.
I've sent out a patch for comment:
https://lkml.kernel.org/linux-fscrypt/20191107220248.32025-1-ebiggers@kernel.org/

- Eric
