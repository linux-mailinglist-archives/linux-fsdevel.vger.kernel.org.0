Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E463077B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 15:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhA1OJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:09:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:60328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhA1OJe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:09:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53ABFACBA;
        Thu, 28 Jan 2021 14:08:52 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 59f2bb83;
        Thu, 28 Jan 2021 14:09:43 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v4 17/17] ceph: add fscrypt ioctls
References: <20210120182847.644850-1-jlayton@kernel.org>
        <20210120182847.644850-18-jlayton@kernel.org> <87y2gdi74l.fsf@suse.de>
        <91d4d85d1c59d27bc0ed890efd078645211ae86a.camel@kernel.org>
Date:   Thu, 28 Jan 2021 14:09:43 +0000
In-Reply-To: <91d4d85d1c59d27bc0ed890efd078645211ae86a.camel@kernel.org> (Jeff
        Layton's message of "Thu, 28 Jan 2021 08:44:29 -0500")
Message-ID: <87tur1i254.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2021-01-28 at 12:22 +0000, Luis Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > Most of the ioctls, we gate on the MDS feature support. The exception is
>> > the key removal and status functions that we still want to work if the
>> > MDS's were to (inexplicably) lose the feature.
>> > 
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/ceph/ioctl.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 61 insertions(+)
>> > 
>> > diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
>> > index 6e061bf62ad4..832909f3eb1b 100644
>> > --- a/fs/ceph/ioctl.c
>> > +++ b/fs/ceph/ioctl.c
>> > @@ -6,6 +6,7 @@
>> >  #include "mds_client.h"
>> >  #include "ioctl.h"
>> >  #include <linux/ceph/striper.h>
>> > +#include <linux/fscrypt.h>
>> >  
>> > 
>> > 
>> > 
>> >  /*
>> >   * ioctls
>> > @@ -268,8 +269,29 @@ static long ceph_ioctl_syncio(struct file *file)
>> >  	return 0;
>> >  }
>> >  
>> > 
>> > 
>> > 
>> > +static int vet_mds_for_fscrypt(struct file *file)
>> > +{
>> > +	int i, ret = -EOPNOTSUPP;
>> > +	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
>> > +
>> > +	mutex_lock(&mdsc->mutex);
>> > +	for (i = 0; i < mdsc->max_sessions; i++) {
>> > +		struct ceph_mds_session *s = __ceph_lookup_mds_session(mdsc, i);
>> > +
>> > +		if (!s)
>> > +			continue;
>> > +		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
>> > +			ret = 0;
>> 
>> And another one, I believe...?  We need this here:
>> 
>> 		ceph_put_mds_session(s);
>> 
>
> Well spotted. Though since we hold the mutex over the whole thing, I
> probably should change this to just not take references at all. I'll fix
> that.
>
>> Also, isn't this logic broken?  Shouldn't we walk through all the sessions
>> and return 0 only if they all have that feature bit set?
>> 
>
> Tough call.
>
> AFAIU, we're not guaranteed to have a session with all of the available
> MDS's at any given time. I figured we'd have one and we'd assume that
> all of the others would be similar.
>
> I'm not sure if that's a safe assumption or not though. Let me do some
> asking around...

Yeah, you're probably right.  All the sessions should have the same
features set.

Cheers,
-- 
Luis


> Thanks!
> -- 
> Jeff Layton <jlayton@kernel.org>
>
