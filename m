Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0111230775B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 14:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhA1NpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 08:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhA1NpM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:45:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E1096146D;
        Thu, 28 Jan 2021 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611841471;
        bh=tF5VNXaxITVNhggRu8ScCIDQCR93x2TmmmMh329FLxo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ej01plCx/ClGzuNh2AiWuFxjD99JQRpUBvluUGe0HOsmJdg7isfoVOxFB2XXw5Ur2
         Wm48TsJ8tUM4iMqFTRgwu/8pvT6yvj7xeLzXb/LMQnxyFu3u25SgK/opLxvJMf+bSC
         AnUOqRMPp5UMjCeU6eea7qAy+eNNzrQKiVABo7ivrawn3K/jLU/AJ63v/Aia98otTj
         ifSmGFJZv8GuOHuuCYi4jv8ztLIyiC2TEkajiPzfbrOO3Ap1RWaoBDkie2nicPvIUf
         6gTzALuXrFASY8ZczyHaah0oG9zQ8H9LlrqtEKn5zz4y802V9bmxFmqmH8lytjhAdZ
         qt2bik1kO3xCQ==
Message-ID: <91d4d85d1c59d27bc0ed890efd078645211ae86a.camel@kernel.org>
Subject: Re: [RFC PATCH v4 17/17] ceph: add fscrypt ioctls
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 28 Jan 2021 08:44:29 -0500
In-Reply-To: <87y2gdi74l.fsf@suse.de>
References: <20210120182847.644850-1-jlayton@kernel.org>
         <20210120182847.644850-18-jlayton@kernel.org> <87y2gdi74l.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-01-28 at 12:22 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > Most of the ioctls, we gate on the MDS feature support. The exception is
> > the key removal and status functions that we still want to work if the
> > MDS's were to (inexplicably) lose the feature.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/ioctl.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> > 
> > diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> > index 6e061bf62ad4..832909f3eb1b 100644
> > --- a/fs/ceph/ioctl.c
> > +++ b/fs/ceph/ioctl.c
> > @@ -6,6 +6,7 @@
> >  #include "mds_client.h"
> >  #include "ioctl.h"
> >  #include <linux/ceph/striper.h>
> > +#include <linux/fscrypt.h>
> >  
> > 
> > 
> > 
> >  /*
> >   * ioctls
> > @@ -268,8 +269,29 @@ static long ceph_ioctl_syncio(struct file *file)
> >  	return 0;
> >  }
> >  
> > 
> > 
> > 
> > +static int vet_mds_for_fscrypt(struct file *file)
> > +{
> > +	int i, ret = -EOPNOTSUPP;
> > +	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
> > +
> > +	mutex_lock(&mdsc->mutex);
> > +	for (i = 0; i < mdsc->max_sessions; i++) {
> > +		struct ceph_mds_session *s = __ceph_lookup_mds_session(mdsc, i);
> > +
> > +		if (!s)
> > +			continue;
> > +		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
> > +			ret = 0;
> 
> And another one, I believe...?  We need this here:
> 
> 		ceph_put_mds_session(s);
> 

Well spotted. Though since we hold the mutex over the whole thing, I
probably should change this to just not take references at all. I'll fix
that.

> Also, isn't this logic broken?  Shouldn't we walk through all the sessions
> and return 0 only if they all have that feature bit set?
> 

Tough call.

AFAIU, we're not guaranteed to have a session with all of the available
MDS's at any given time. I figured we'd have one and we'd assume that
all of the others would be similar.

I'm not sure if that's a safe assumption or not though. Let me do some
asking around...

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

