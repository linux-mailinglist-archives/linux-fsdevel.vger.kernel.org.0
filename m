Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A6709667
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjESLWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjESLWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 07:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C02710E6;
        Fri, 19 May 2023 04:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A981464811;
        Fri, 19 May 2023 11:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3240C433A0;
        Fri, 19 May 2023 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684495364;
        bh=OcLM1N2ClGCrQpYWDpWQ6HQjg4/ELs+8TOzmNb/8/CI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LL1zcwb+2438spSK6nu0QO3uhzmYznCJ6FYaKF0rs9YJzYZuu8q7BN/huMRZ4XVqU
         4UTECX1FDgXRdS6Hcp1cWQukl9y61Nqt8atvBSfQzPf0TQTJuYvBs18zMv+CB2Z+9F
         BdHC51FzAjsQbRGzpE5DM3BQRphGFVqWstaNg4sVKaSKySAvAB5EsuMkelYtdruZDr
         U+KcHge73B0ozjP5fEq7yDURVBW3gkporZYf+I4EjjYprwmtZybM8spv8qcLTjKeBt
         zD0v+X553SpUwol+ns3i/J6jkmT/x9UPBf0hGy3IHNqQUkDr4lwEh9NqfpqcZaAV0F
         S4TGrgB1oAKjA==
Message-ID: <54b7d304016fd6e89a2899f7e417ba89bcb81c78.camel@kernel.org>
Subject: Re: [PATCH v4 4/9] nfsd: ensure we use ctime_peek to grab the
 inode->i_ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Date:   Fri, 19 May 2023 07:22:40 -0400
In-Reply-To: <20230519-zierde-legieren-e769c19a29cb@brauner>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-5-jlayton@kernel.org>
         <2B6A4DDD-0356-4765-9CED-B22A29767254@oracle.com>
         <b046f7e3c86d1c9dd45e932d3f25785fce921f4a.camel@kernel.org>
         <20230519-zierde-legieren-e769c19a29cb@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
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

On Fri, 2023-05-19 at 12:36 +0200, Christian Brauner wrote:
> On Thu, May 18, 2023 at 11:31:45AM -0400, Jeff Layton wrote:
> > On Thu, 2023-05-18 at 13:43 +0000, Chuck Lever III wrote:
> > >=20
> > > > On May 18, 2023, at 7:47 AM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > If getattr fails, then nfsd can end up scraping the time values dir=
ectly
> > > > out of the inode for pre and post-op attrs. This may or may not be =
the
> > > > right thing to do, but for now make it at least use ctime_peek in t=
his
> > > > situation to ensure that the QUERIED flag is masked.
> > >=20
> > > That code comes from:
> > >=20
> > > commit 39ca1bf624b6b82cc895b0217889eaaf572a7913
> > > Author:     Amir Goldstein <amir73il@gmail.com>
> > > AuthorDate: Wed Jan 3 17:14:35 2018 +0200
> > > Commit:     J. Bruce Fields <bfields@redhat.com>
> > > CommitDate: Thu Feb 8 13:40:17 2018 -0500
> > >=20
> > >     nfsd: store stat times in fill_pre_wcc() instead of inode times
> > >=20
> > >     The time values in stat and inode may differ for overlayfs and st=
at time
> > >     values are the correct ones to use. This is also consistent with =
the fact
> > >     that fill_post_wcc() also stores stat time values.
> > >=20
> > >     This means introducing a stat call that could fail, where previou=
sly we
> > >     were just copying values out of the inode.  To be conservative ab=
out
> > >     changing behavior, we fall back to copying values out of the inod=
e in
> > >     the error case.  It might be better just to clear fh_pre_saved (t=
hough
> > >     note the BUG_ON in set_change_info).
> > >=20
> > >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > >=20
> > > I was thinking it might have been added to handle odd corner
> > > cases around re-exporting NFS mounts, but that does not seem
> > > to be the case.
> > >=20
> > > The fh_getattr() can fail for legitimate reasons -- like the
> > > file is in the middle of being deleted or renamed over -- I
> > > would think. This code should really deal with that by not
> > > adding pre-op attrs, since they are optional.
> > >=20
> >=20
> > That sounds fine to me. I'll plan to drop this patch from the series an=
d
> > I'll send a separate patch to just remove those branches altogether
> > (which should DTRT).
>=20
> I'll wait with reviewing this until you send the next version then.

I don't have any other big changes queued up. So far, this would just be
the exact same set, without this patch.

FWIW, I'm mostly interested in your review of patches #1 and 2. Is
altering prototype for generic_fillattr, and changing the logic in
current_time the right approach here?

--=20
Jeff Layton <jlayton@kernel.org>
