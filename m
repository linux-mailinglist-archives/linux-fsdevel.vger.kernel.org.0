Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC15A4C68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiH2MvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiH2Muz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F4B7C74C;
        Mon, 29 Aug 2022 05:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F55F611FA;
        Mon, 29 Aug 2022 12:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A60C433C1;
        Mon, 29 Aug 2022 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776656;
        bh=iJoS2HHPSfAQPS7l1aJ39VXIxX+3fe7CLzcb+f5VidQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HDLqM9EE81L82hfqDGddOPlqSmySTPWwLwm56CCLD/qUdQKxMTn2JoCz1ZOeiCrRv
         Re0CnimCHjDxAq30OOeIqGjM8oqKuS/Cq5DX1Pc/3Xl/ZKzagzJ0/i/6xR0Q3PecjB
         YDB506/bXCpuaTaxjvLwx7wYtjv492SDCxJgOCKasgwTkNi8ctn0K4xlv3bLaOC8sW
         W4o8/i7C+tdfNefvBaA+B2AST8A4dWJPs/qTXS28uePb+pb0Eya9+rrc8NwXVYf2bj
         ughTMcwv3SwmIrRqR1BwM/SU6gQQO3t6eLuWwgHtiHmnzhNOtq7Jr6Rxxk9PXSy5Kp
         j1Pkzv5nCU65g==
Message-ID: <bffe16482bcb3e6a69378e821e76182be21c7d1b.camel@kernel.org>
Subject: Re: [man-pages PATCH] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     John Stoffel <john@stoffel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 08:37:33 -0400
In-Reply-To: <25355.34889.890961.350510@quad.stoffel.home>
References: <20220826214747.134964-1-jlayton@kernel.org>
         <25355.34889.890961.350510@quad.stoffel.home>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-08-28 at 11:22 -0400, John Stoffel wrote:
> > > > > > "Jeff" =3D=3D Jeff Layton <jlayton@kernel.org> writes:
>=20
> Jeff> We're planning to expose the inode change attribute via statx.
> Document
> Jeff> what this value means and what an observer can infer from a
> change in
> Jeff> its value.
>=20
> It might be nice to put in some more example verbiage of how this
> would be used by userland.  For example, if you do a statx() call and
> notice that the ino_version has changed... what would you do next to
> find out what changed? =20
>=20
> Would you have to keep around an old copy of the statx() results and
> then compare them to find the changes?  When talking to userland
> people, don't assume they know anything about the kernel internals
> here. =20
>=20

How you'd use this really depends on the application, but yes, you'd
need to at least know what an old stx_ino_version was in order to detect
that there has been a change to it.

Today, i_version is mostly of use for knowing when you should invalidate
cached file info. Think of it as something like ctime, but with infinite
granularity. If it changes then something substantive _might_ have
changed in the inode. It's possible it's nothing your application cares
about, so you'd likely have to deal with "false" changes to this anyway.

In the case of NFS, it will invalidate its data and metadata caches when
this value changes. This is why this why false iversion bumps are so
expensive for NFS, particularly if you're dealing with large files.
Everything has to be re-fetched from the server when it changes.

In the case of IMA, it will re-measure the data in the inode to make
sure that it hasn't changed. That involves reading the whole file in and
running a checksum over it.

You could envision a backup tool using this to do incremental backups,
for instance. Keep a db of stx_ino:stx_ino_version for the files and you
could scan a filesystem and see which files need their backups updated.

Or, use it as a way to do stable file copies: Get the stx_ino_version
for a file, copy it somewhere and then get the stx_ino_version again.
Did it change? Redo the copy. That might be a nice option to add to
rsync, actually.

>=20
> Jeff> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Jeff> ---
> Jeff>  man2/statx.2 | 13 +++++++++++++
> Jeff>  man7/inode.7 | 10 ++++++++++
> Jeff>  2 files changed, 23 insertions(+)
>=20
> Jeff> diff --git a/man2/statx.2 b/man2/statx.2
> Jeff> index 0d1b4591f74c..644fb251f114 100644
> Jeff> --- a/man2/statx.2
> Jeff> +++ b/man2/statx.2
> Jeff> @@ -62,6 +62,7 @@ struct statx {
> Jeff>      __u32 stx_dev_major;   /* Major ID */
> Jeff>      __u32 stx_dev_minor;   /* Minor ID */
> Jeff>      __u64 stx_mnt_id;      /* Mount ID */
> Jeff> +    __u64 stx_ino_version; /* Inode change attribute */
> Jeff>  };
> Jeff>  .EE
> Jeff>  .in
> Jeff> @@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
> Jeff>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> Jeff>  	It is deprecated and should not be used.
> Jeff>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> Jeff> +STATX_INO_VERSION	Want stx_ino_version (since Linux
> 6.1)
> Jeff>  .TE
> Jeff>  .in
> Jeff>  .PP
> Jeff> @@ -411,6 +413,17 @@ and corresponds to the number in the first
> field in one of the records in
> Jeff>  For further information on the above fields, see
> Jeff>  .BR inode (7).
> Jeff>  .\"
> Jeff> +.TP
> Jeff> +.I stx_ino_version
> Jeff> +The inode version, also known as the inode change attribute.
> This
> Jeff> +value is intended to change any time there is an inode status
> change. Any
> Jeff> +operation that would cause the stx_ctime to change should also
> cause
> Jeff> +stx_ino_version to change, even when there is no apparent
> change to the
> Jeff> +stx_ctime due to timestamp granularity.
> Jeff> +.IP
> Jeff> +Note that an observer cannot infer anything about the nature or
> Jeff> +magnitude of the change from the value of this field. A change
> in this value
> Jeff> +only indicates that there may have been an explicit change in
> the inode.
> Jeff>  .SS File attributes
> Jeff>  The
> Jeff>  .I stx_attributes
> Jeff> diff --git a/man7/inode.7 b/man7/inode.7
> Jeff> index 9b255a890720..d296bb6df70c 100644
> Jeff> --- a/man7/inode.7
> Jeff> +++ b/man7/inode.7
> Jeff> @@ -184,6 +184,16 @@ Last status change timestamp (ctime)
> Jeff>  This is the file's last status change timestamp.
> Jeff>  It is changed by writing or by setting inode information
> Jeff>  (i.e., owner, group, link count, mode, etc.).
> Jeff> +.TP
> Jeff> +Inode version (i_version)
> Jeff> +(not returned in the \fIstat\fP structure);
> \fIstatx.stx_ino_version\fP
> Jeff> +.IP
> Jeff> +This is the inode change attribute. Any operation that would
> result in a ctime
> Jeff> +change should also result in a change to this value. The value
> must change even
> Jeff> +in the case where the ctime change is not evident due to
> timestamp granularity.
> Jeff> +An observer cannot infer anything from the actual value about
> the nature or
> Jeff> +magnitude of the change. If it is different from the last time
> it was checked,
> Jeff> +then something may have made an explicit change to the inode.
> Jeff>  .PP
> Jeff>  The timestamp fields report time measured with a zero point at
> the
> Jeff>  .IR Epoch ,
> Jeff> --=20
> Jeff> 2.37.2
>=20

--=20
Jeff Layton <jlayton@kernel.org>
