Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A270F68AF7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 12:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBELYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 06:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBELYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:24:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048951E5E1;
        Sun,  5 Feb 2023 03:24:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ED38B80C63;
        Sun,  5 Feb 2023 11:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97873C433EF;
        Sun,  5 Feb 2023 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675596267;
        bh=KOkryixY000CjEQSAQ44hBB/5bzB2Lf1P6BPhHHLw/E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HvdDjd+nSGZIN2gFrIgughDXNHWYx6vBeqUiS86AYX5evZEIhG3sXbgQEhsUaclMz
         LGXDyxIAd292Em8xA9uwidrd7fNC5FTvtQOuS5Y+CB018VeKhipq1W2ap4oVvd8DIp
         aOktktMblyh4NChBTd78o2JS3q76bw7cAV7SyEnt5kOTL2v2h1fgpsFaemRoSPXy4S
         kpVdIjYR1L8ecKqpCWJZdbEyxzyN0nECcMQyqxCEmX4rBO7HRrl3MlkhkawofmcVbD
         7BaPfPKtxvN/s751gSLE/1WqSnfEbLP4FJMW1ynPhdXffl0UJrz316T7XQrMhxD15i
         5jlha7XGZx8VA==
Message-ID: <8f122cb0304632b391759788fe1f72ea1bab1ba0.camel@kernel.org>
Subject: Re: git regression failures with v6.2-rc NFS client
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Hugh Dickins <hughd@google.com>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Date:   Sun, 05 Feb 2023 06:24:25 -0500
In-Reply-To: <05BEEF62-46DF-4FAC-99D4-4589C294F93A@redhat.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
         <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
         <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
         <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
         <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
         <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
         <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
         <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
         <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
         <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
         <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com>
         <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com>
         <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
         <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
         <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
         <ab632691-7e4c-ccbf-99a0-397f1f7d30ec@google.com>
         <8B4F6A20-D7A4-4A22-914C-59F5EA79D252@hammerspace.com>
         <c5259e81-631e-7877-d3b0-5a5a56d35b42@leemhuis.info>
         <15679CC0-6B56-4F6D-9857-21DCF1EFFF79@redhat.com>
         <031C52C0-144A-4051-9B4C-0E1E3164951E@hammerspace.com>
         <05BEEF62-46DF-4FAC-99D4-4589C294F93A@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-02-04 at 15:44 -0500, Benjamin Coddington wrote:
> On 4 Feb 2023, at 11:52, Trond Myklebust wrote:
> > On Feb 4, 2023, at 08:15, Benjamin Coddington <bcodding@redhat.com> wro=
te:
> > > Ah, thanks for explaining that.
> > >=20
> > > I'd like to summarize and quantify this problem one last time for fol=
ks that
> > > don't want to read everything.  If an application wants to remove all=
 files
> > > and the parent directory, and uses this pattern to do it:
> > >=20
> > > opendir
> > > while (getdents)
> > >    unlink dents
> > > closedir
> > > rmdir
> > >=20
> > > Before this commit, that would work with up to 126 dentries on NFS fr=
om
> > > tmpfs export.  If the directory had 127 or more, the rmdir would fail=
 with
> > > ENOTEMPTY.
> >=20
> > For all sizes of filenames, or just the particular set that was chosen
> > here? What about the choice of rsize? Both these values affect how many
> > entries glibc can cache before it has to issue another getdents() call
> > into the kernel. For the record, this is what glibc does in the opendir=
()
> > code in order to choose a buffer size for the getdents syscalls:
> >=20
> >   /* The st_blksize value of the directory is used as a hint for the
> >      size of the buffer which receives struct dirent values from the
> >      kernel.  st_blksize is limited to max_buffer_size, in case the
> >      file system provides a bogus value.  */
> >   enum { max_buffer_size =3D 1048576 };
> >=20
> >   enum { allocation_size =3D 32768 };
> >   _Static_assert (allocation_size >=3D sizeof (struct dirent64),
> >                   "allocation_size < sizeof (struct dirent64)");
> >=20
> >   /* Increase allocation if requested, but not if the value appears to
> >      be bogus.  It will be between 32Kb and 1Mb.  */
> >   size_t allocation =3D MIN (MAX ((size_t) statp->st_blksize, (size_t)
> >                                 allocation_size), (size_t) max_buffer_s=
ize);
> >=20
> >   DIR *dirp =3D (DIR *) malloc (sizeof (DIR) + allocation);
>=20
> The behavioral complexity is even higher with glibc in the mix, but both =
the
> test that Chuck's using and the reproducer I've been making claims about
> use SYS_getdents directly.  I'm using a static 4k buffer size which is bi=
g
> enough to fit enough entries to prime the heuristic for a single call to
> getdents() whether or not we return early at 17 or 126.
>=20
> > > After this commit, it only works with up to 17 dentries.
> > >=20
> > > The argument that this is making things worse takes the position that=
 there
> > > are more directories in the universe with >17 dentries that want to b=
e
> > > cleaned up by this "saw off the branch you're sitting on" pattern tha=
n
> > > directories with >127.  And I guess that's true if Chuck runs that te=
sting
> > > setup enough.  :)
> > >=20
> > > We can change the optimization in the commit from
> > > NFS_READDIR_CACHE_MISS_THRESHOLD + 1
> > > to
> > > nfs_readdir_array_maxentries + 1
> > >=20
> > > This would make the regression disappear, and would also keep most of=
 the
> > > optimization.
> > >=20
> > > Ben
> > >=20
> >=20
> > So in other words the suggestion is to optimise the number of readdir
> > records that we return from NFS to whatever value that papers over the
> > known telldir()/seekdir() tmpfs bug that is re-revealed by this particu=
lar
> > test when run under these particular conditions?
>=20
> Yes.  It's a terrible suggestion.  Its only merit may be that it meets th=
e
> letter of the no regressions law.  I hate it, and I after I started poppi=
ng
> out patches that do it I've found they've all made the behavior far more
> complex due to the way we dynamically optimize dtsize.
>=20
> > Anyone who tries to use tmpfs with a different number of files, differe=
nt
> > file name lengths, or different mount options is still SOL because that=
=E2=80=99s
> > not a =E2=80=9Cregression"?
>=20
> Right. :P
>=20
> Ben
>=20

I may be missing something, but would it be possible to move to a more
stable scheme for readdir cookies for tmpfs?

It is tmpfs, so we don't need to worry about persisting these values
across reboots. Could we (e.g.) hash dentry pointers to generate
cookies?
--=20
Jeff Layton <jlayton@kernel.org>
