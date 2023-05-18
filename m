Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7131B7084E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjERPbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjERPby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 11:31:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32177F9;
        Thu, 18 May 2023 08:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB72161127;
        Thu, 18 May 2023 15:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD10BC433EF;
        Thu, 18 May 2023 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684423909;
        bh=QR4Dg1YX8B3ucH22ew4CZd/iXu3GjZRKYDWVOpx+evE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hkdFwcBJVE9dIN6CfKsxNXSd9p1Dtcr1QSDfC8aMAvKedIePfHDxUlpwmozTZzfAP
         TLCpcZOxGKz5VlEpgPrgpr5t3YzKML/wC+aJreAjz3GtZlHuoNi30y34bKkaomgG+X
         Yy9zcWXpi6PGfMYcOZ3z6O8VqBMQf8pvec+lwb6DaGTqCS3CRxKjPqps536opGcEvy
         TAJgkl6XBfgrbZe5ZkFzqgubsFE59jd2MfqCUK6kqij4NFXrre+7zIPhMXng2Ms9Z4
         JvY0rdmps06AX+Bqn9hYd6YD6k8r0RJk2reKh6o2ga0ZDkvPqjI+YpWD2wcKBcIlkx
         adWAjdBLXM3Sw==
Message-ID: <b046f7e3c86d1c9dd45e932d3f25785fce921f4a.camel@kernel.org>
Subject: Re: [PATCH v4 4/9] nfsd: ensure we use ctime_peek to grab the
 inode->i_ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Date:   Thu, 18 May 2023 11:31:45 -0400
In-Reply-To: <2B6A4DDD-0356-4765-9CED-B22A29767254@oracle.com>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-5-jlayton@kernel.org>
         <2B6A4DDD-0356-4765-9CED-B22A29767254@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-05-18 at 13:43 +0000, Chuck Lever III wrote:
>=20
> > On May 18, 2023, at 7:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > If getattr fails, then nfsd can end up scraping the time values directl=
y
> > out of the inode for pre and post-op attrs. This may or may not be the
> > right thing to do, but for now make it at least use ctime_peek in this
> > situation to ensure that the QUERIED flag is masked.
>=20
> That code comes from:
>=20
> commit 39ca1bf624b6b82cc895b0217889eaaf572a7913
> Author:     Amir Goldstein <amir73il@gmail.com>
> AuthorDate: Wed Jan 3 17:14:35 2018 +0200
> Commit:     J. Bruce Fields <bfields@redhat.com>
> CommitDate: Thu Feb 8 13:40:17 2018 -0500
>=20
>     nfsd: store stat times in fill_pre_wcc() instead of inode times
>=20
>     The time values in stat and inode may differ for overlayfs and stat t=
ime
>     values are the correct ones to use. This is also consistent with the =
fact
>     that fill_post_wcc() also stores stat time values.
>=20
>     This means introducing a stat call that could fail, where previously =
we
>     were just copying values out of the inode.  To be conservative about
>     changing behavior, we fall back to copying values out of the inode in
>     the error case.  It might be better just to clear fh_pre_saved (thoug=
h
>     note the BUG_ON in set_change_info).
>=20
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> I was thinking it might have been added to handle odd corner
> cases around re-exporting NFS mounts, but that does not seem
> to be the case.
>=20
> The fh_getattr() can fail for legitimate reasons -- like the
> file is in the middle of being deleted or renamed over -- I
> would think. This code should really deal with that by not
> adding pre-op attrs, since they are optional.
>=20

That sounds fine to me. I'll plan to drop this patch from the series and
I'll send a separate patch to just remove those branches altogether
(which should DTRT).

--=20
Jeff Layton <jlayton@kernel.org>
