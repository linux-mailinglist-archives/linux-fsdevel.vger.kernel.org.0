Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48A63DB2F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhG3FnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:43:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51110 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhG3FnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:43:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8ABE422386;
        Fri, 30 Jul 2021 05:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627623797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1vVobsHGIK8tpporn/Uz4BMLNgGBlTdsKnVBQ03gqs=;
        b=HQ9WxcXf1I3QtRWo0DA/JPVX6NFfD2oJbJuEJcSectdr3ZnwqIDdC9oEeOlihjiDmgg8X4
        k3g2mVmenFcKl5G/m9y+w+o1hAwbX6kSKfE6GPaFqGkGL0CjoH9KCub8hvdiq6uWoOEeUE
        kxHGYVrxjKmlFCyesEe3o7m7l1qtQLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627623797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1vVobsHGIK8tpporn/Uz4BMLNgGBlTdsKnVBQ03gqs=;
        b=gGE3Xwk1k5wETxoc6G8VAHxtnLUJPCSyeHN5LUSN5oO7SY9m+OnGC7Z1e96alzz3c7sDXH
        PtEKD3GDBWuimACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A465513BF9;
        Fri, 30 Jul 2021 05:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rw6aGHKRA2ErfAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 05:43:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/11] nfsd: Allow filehandle lookup to cross internal
 mount points.
In-reply-to: <YQNK2rgZuqh/XmMt@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546556.32498.16708762469227881912.stgit@noble.brown>,
 <YQNK2rgZuqh/XmMt@zeniv-ca.linux.org.uk>
Date:   Fri, 30 Jul 2021 15:43:11 +1000
Message-id: <162762379181.21659.6770844735701522704@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Al Viro wrote:
> On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
>=20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index baa12ac36ece..22523e1cd478 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -64,7 +64,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *pat=
h_parent,
> >  			    .dentry =3D dget(path_parent->dentry)};
> >  	int err =3D 0;
> > =20
> > -	err =3D follow_down(&path, 0);
> > +	err =3D follow_down(&path, LOOKUP_AUTOMOUNT);
> >  	if (err < 0)
> >  		goto out;
> >  	if (path.mnt =3D=3D path_parent->mnt && path.dentry =3D=3D path_parent-=
>dentry &&
> > @@ -73,6 +73,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *pa=
th_parent,
> >  		path_put(&path);
> >  		goto out;
> >  	}
> > +	if (mount_is_internal(path.mnt)) {
> > +		/* Use the new path, but don't look for a new export */
> > +		/* FIXME should I check NOHIDE in this case?? */
> > +		path_put(path_parent);
> > +		*path_parent =3D path;
> > +		goto out;
> > +	}
>=20
> ... IOW, mount_is_internal() is called with no exclusion whatsoever.  What'=
s there
> to
> 	* keep its return value valid?
> 	* prevent fetching ->mnt_mountpoint, getting preempted away, having
> the mount moved *and* what used to be ->mnt_mountpoint evicted from dcache,
> now that it's no longer pinned, then mount_is_internal() regaining CPU and
> dereferencing ->mnt_mountpoint, which now points to hell knows what?
>=20

Yes, mount_is_internal needs to same mount_lock protection that
lookup_mnt() has.  Thanks.

I don't think it matter how long the result remains valid.  The only
realistic transtion is from True to False, but the fact that it *was*
True means that it is acceptable for the lookup to have succeeded.
i.e.  If the mountpoint was moved which a request was being processed it
will either cause the same result as if it happened before the request
started, or after it finished.  Either seems OK.

Thanks,
NeilBrown

