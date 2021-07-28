Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70E3D985B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhG1WZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 18:25:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhG1WZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:25:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2A511FFFC;
        Wed, 28 Jul 2021 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627511135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjqme1zUDcnCcoQ3Tk+VHxnefaATV89KJZnBvhXQjFA=;
        b=ilInrbZFKX8z9FuzlIy3upOXktBpM2kuOdFc746OIss7c3RfZzh+438j+1r0gOkFUJ7bkn
        U1lQx/2lxi8zlln0vXKn91Z64LgK9rcMZFLAej96S8LTfLtdG58Yy+qNqNTDb7NQNGqlQ1
        9osZkZr3/h8YYrHr4P1+nJYrQLHG01I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627511135;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjqme1zUDcnCcoQ3Tk+VHxnefaATV89KJZnBvhXQjFA=;
        b=DC6yRi2TJLwl24uaWgAmLztV9spiv/95pJXC4jAxYXp91tLSjJk9TmT9Wok5B/wQVRrGDU
        nnSoBaZSdPm5pCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDD7913BC4;
        Wed, 28 Jul 2021 22:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yB6XJlzZAWEzXQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 28 Jul 2021 22:25:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
In-reply-to: <20210728191711.GC3152@fieldses.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546554.32498.9309110546560807513.stgit@noble.brown>,
 <20210728191711.GC3152@fieldses.org>
Date:   Thu, 29 Jul 2021 08:25:29 +1000
Message-id: <162751112971.21659.13568311032380832336@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Jul 2021, J. Bruce Fields wrote:
> On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > @@ -232,6 +239,68 @@ reconnect_path(struct vfsmount *mnt, struct dentry *=
target_dir, char *nbuf)
> >  	}
> >  	dput(dentry);
> >  	clear_disconnected(target_dir);
>=20
> Minor nit--I'd prefer the following in a separate function.

Fair.  Are you thinking "a separate function that is called here" or "a
separate function that needs to be called by whoever called
exportfs_decode_fh_raw()" if they happen to want the vfsmnt to be
updated?

NeilBrown

>=20
> --b.
>=20
> > +
> > +	/* Need to find appropriate vfsmount, which might not exist yet.
> > +	 * We may need to trigger automount points.
> > +	 */
> > +	path.mnt =3D mnt;
> > +	path.dentry =3D target_dir;
> > +	vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
> > +	target_dev =3D stat.dev;
> > +
> > +	path.dentry =3D mnt->mnt_root;
> > +	vfs_getattr_nosec(&path, &stat, 0, AT_STATX_DONT_SYNC);
> > +
> > +	while (stat.dev !=3D target_dev) {
> > +		/* walk up the dcache tree from target_dir, recording the
> > +		 * location of the most recent change in dev number,
> > +		 * until we find a mountpoint.
> > +		 * If there was no change in show_dev result before the
> > +		 * mountpount, the vfsmount at the mountpoint is what we want.
> > +		 * If there was, we need to trigger an automount where the
> > +		 * show_dev() result changed.
> > +		 */
