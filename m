Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3540ED2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbhIPWOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 18:14:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbhIPWOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:14:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D597F22285;
        Thu, 16 Sep 2021 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631830405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUML7PP2cwKhFn9IzXhNLUrnTUVcJXoS96ewZU1uWd4=;
        b=jXq3fACJglbXO8ZZxnEEMQ+MUPWIjZYeP9OWVMQcOLpTCitAL/GY0hB3ikpZqLry9QOXDj
        ZRrPGSLgWi+Y6HeNGhcNrGJGBweWKtIOvbUo2E/PYEVdhNesAL6oSHskkTyze7963m/w7v
        FapF8aEecdCetxL/vyAtSFplWCBT8aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631830405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUML7PP2cwKhFn9IzXhNLUrnTUVcJXoS96ewZU1uWd4=;
        b=tYmy1+ayRfKGCMEtC5l9akiHOlDJJKFM6kSmG2YO8aDY/SdACek6JZkZDMbN7tSZ+4Wr23
        jXJfi3+TQ02lBADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35C2013D6D;
        Thu, 16 Sep 2021 22:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uyMeOYHBQ2GwUwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Sep 2021 22:13:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.com>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: annotate congestion_wait() and
 wait_iff_congested() as ineffective.
In-reply-to: <YUHfdtth69qKvk8r@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>,
 <163157838437.13293.15392955714346973750.stgit@noble.brown>,
 <YUHfdtth69qKvk8r@dhcp22.suse.cz>
Date:   Fri, 17 Sep 2021 08:13:19 +1000
Message-id: <163183039931.3992.6407941879351179168@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Sep 2021, Michal Hocko wrote:
> On Tue 14-09-21 10:13:04, Neil Brown wrote:
> > Only 4 subsystems call set_bdi_congested() or clear_bdi_congested():
> >  block/pktcdvd, fs/ceph fs/fuse fs/nfs
> >=20
> > It may make sense to use congestion_wait() or wait_iff_congested()
> > within these subsystems, but they have no value outside of these.
> >=20
> > Add documentation comments to these functions to discourage further use.
>=20
> This is an unfortunate state. The MM layer still relies on the API.
> While adding a documentation to clarify the current status can stop more
> usage I am wondering what is a real alternative. My experience tells me
> that a lack of real alternative will lead to new creative ways of doing
> things instead.

That is a valid concern.  Discouraging the use of an interface without
providing a clear alternative risks people doing worse things.

At lease if people continue to use congestion_wait(), then we will be
able to find those uses when we are able to provide a better approach.

I'll drop this patch.

Thanks,
NeilBrown


> =20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/backing-dev.h |    7 +++++++
> >  mm/backing-dev.c            |    9 +++++++++
> >  2 files changed, 16 insertions(+)
> >=20
> > diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> > index ac7f231b8825..cc9513840351 100644
> > --- a/include/linux/backing-dev.h
> > +++ b/include/linux/backing-dev.h
> > @@ -153,6 +153,13 @@ static inline int wb_congested(struct bdi_writeback =
*wb, int cong_bits)
> >  	return wb->congested & cong_bits;
> >  }
> > =20
> > +/* NOTE congestion_wait() and wait_iff_congested() are
> > + * largely useless except as documentation.
> > + * congestion_wait() will (almost) always wait for the given timeout.
> > + * wait_iff_congested() will (almost) never wait, but will call
> > + * cond_resched().
> > + * Were possible an alternative waiting strategy should be found.
> > + */
> >  long congestion_wait(int sync, long timeout);
> >  long wait_iff_congested(int sync, long timeout);
> > =20
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index 4a9d4e27d0d9..53472ab38796 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -1023,6 +1023,11 @@ EXPORT_SYMBOL(set_bdi_congested);
> >   * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) =
to exit
> >   * write congestion.  If no backing_devs are congested then just wait fo=
r the
> >   * next write to be completed.
> > + *
> > + * NOTE: in the current implementation, hardly any backing_devs are ever
> > + * marked as congested, and write-completion is rarely reported (see cal=
ls
> > + * to clear_bdi_congested).  So this should not be assumed to ever wake =
before
> > + * the timeout.
> >   */
> >  long congestion_wait(int sync, long timeout)
> >  {
> > @@ -1054,6 +1059,10 @@ EXPORT_SYMBOL(congestion_wait);
> >   * The return value is 0 if the sleep is for the full timeout. Otherwise,
> >   * it is the number of jiffies that were still remaining when the functi=
on
> >   * returned. return_value =3D=3D timeout implies the function did not sl=
eep.
> > + *
> > + * NOTE: in the current implementation, hardly any backing_devs are ever
> > + * marked as congested, and write-completion is rarely reported (see cal=
ls
> > + * to clear_bdi_congested).  So this should not be assumed to sleep at a=
ll.
> >   */
> >  long wait_iff_congested(int sync, long timeout)
> >  {
> >=20
>=20
> --=20
> Michal Hocko
> SUSE Labs
>=20
>=20
