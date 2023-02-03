Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4768A714
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 00:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBCXxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 18:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCXxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:53:32 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60135456A
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 15:53:30 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id h12-20020a4a940c000000b004fa81915b1cso660708ooi.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyXSbv+D3GNzzmvEn+3B991hNgm4a05r2z3sYrzcrnA=;
        b=mRN/u3MaOz2aKDgFFtDR1iMJ0EDM16wviXv1ORqlVQqMRi+q5WffP6Vks/Fs/uJqNS
         /hlS9ae84mSWdzkmkXiK9tSVuEiojTyXdJm0ZfzxJngkhIGiU9BOaCHww2Ax+qXDP1Yo
         Gbmhwub9Fs6RNbaSfUVh5vBaren+D8dsheBW15fXcIo2HAdqpRRKJZqI2me2ECPEPBYu
         0FAhlDbanefuKWNY2ZXMq6Qh7XSUGcoL5cw3kscrjLup0mvxih8udwHFVQTsSN/KFluM
         jblXZx/6MOOuitaafobca1yVX7W7iEh21A3fWqHAhnPJmh5SMXsKuFG+Po1f/VhTNRIf
         b7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyXSbv+D3GNzzmvEn+3B991hNgm4a05r2z3sYrzcrnA=;
        b=3yRV37nforScQTbK/BK5ivEWng66g2lAzAp6fmw9LZAAtDlEu2msnD1hEcHBgqvVqV
         C/NCC9vKQIXccGILT8Dhy7jG+wsxA7hzOKFS3I+9R8uMmYeUvotAayaYySqXdwcMEUjY
         t9qRNounFOpoix5zwSvC/KsDmbd6XLwAyPQ2aWlPQVsmXVkd0HjFNZEa83uM1GbJhcRQ
         WdyjQ4x1nYimiVrN46Z1YipnGB3tP0BTaaqo5e1jboz96JLrp72mHYB2L09RKS1k7rKv
         4eKZv67A9JY38374NJ3EqTo2hu1KZRr525WVDqdi1MLzyyyDCymuh+7UP42Vrd6briXs
         7Nhg==
X-Gm-Message-State: AO0yUKXuM7cY7NO0hrJkqyatzerDhEfu8UGBv3Hy2+aUCAlJOQ0N57iG
        VYHboIAAPu0JLUVhTJSkVTsluqXnhQgH+k/Z66E=
X-Google-Smtp-Source: AK7set+v9dS3difWtAWx5KcQkWTaB3aqL3GNGkD9e+8RDgCj+V4wRZt+is4UqGbxfS8Dpb+uENa6wA==
X-Received: by 2002:a4a:146:0:b0:51a:c9a:ee77 with SMTP id 67-20020a4a0146000000b0051a0c9aee77mr2451507oor.0.1675468409829;
        Fri, 03 Feb 2023 15:53:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l6-20020a4a2706000000b004a3527e8279sm1560274oof.0.2023.02.03.15.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:53:29 -0800 (PST)
Date:   Fri, 3 Feb 2023 15:53:20 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Chuck Lever III <chuck.lever@oracle.com>
cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: git regression failures with v6.2-rc NFS client
In-Reply-To: <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
Message-ID: <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com> <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com> <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com> <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com> <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com> <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com> <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com> <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com> <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
 <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com> <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com> <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1450651585-1675468409=:1657"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1450651585-1675468409=:1657
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 3 Feb 2023, Chuck Lever III wrote:
> > On Feb 3, 2023, at 5:26 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
> >> On Feb 3, 2023, at 15:25, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
> >>> On Feb 3, 2023, at 3:01 PM, Benjamin Coddington <bcodding@redhat.com>=
 wrote:
> >>> On 3 Feb 2023, at 13:03, Chuck Lever III wrote:
> >>>> Naive suggestion: Would another option be to add server
> >>>> support for the directory verifier?
> >>>=20
> >>> I don't think it would resolve this bug, because what can the client =
do to
> >>> find its place in the directory stream after getting NFS4ERR_NOT_SAME=
?
> >>>=20
> >>> Directory verifiers might help another class of bugs, where a linear =
walk
> >>> through the directory produces duplicate entries.. but I think it onl=
y helps
> >>> some of those cases.
> >>>=20
> >>> Knfsd /could/ use the directory verifier to keep a reference to an op=
ened
> >>> directory.  Perhaps knfsd's open file cache can be used.  Then, as lo=
ng as
> >>> we're doing a linear walk through the directory, the local directory'=
s
> >>> file->private cursor would continue to be valid to produce consistent=
 linear
> >>> results even if the dentries are removed in between calls to READDIR.
> >>>=20
> >>> .. but that's not how the verifier is supposed to be used - rather it=
's
> >>> supposed to signal when the client's cookies are invalid, which, for =
tmpfs,
> >>> would be anytime any changes are made to the directory.
> >>=20
> >> Right. Change the verifier whenever a directory is modified.
> >>=20
> >> (Make it an export -> callback per filesystem type).
> >>=20
> >>>> Well, let's not argue semantics. The optimization exposes
> >>>> this (previously known) bug to a wider set of workloads.
> >>>=20
> >>> Ok, yes.
> >>>=20
> >>>> Please, open some bugs that document it. Otherwise this stuff
> >>>> will never get addressed. Can't fix what we don't know about.
> >>>>=20
> >>>> I'm not claiming tmpfs is perfect. But the optimization seems
> >>>> to make things worse for more workloads. That's always been a
> >>>> textbook definition of regression, and a non-starter for
> >>>> upstream.
> >>>=20
> >>> I guess I can - my impression has been there's no interest in fixing =
tmpfs
> >>> for use over NFS..  after my last round of work on it I resolved to t=
ell any
> >>> customers that asked for it to do:
> >>>=20
> >>> [root@fedora ~]# modprobe brd rd_size=3D1048576 rd_nr=3D1
> >>> [root@fedora ~]# mkfs.xfs /dev/ram0
> >>>=20
> >>> .. instead.  Though, I think that tmpfs is going to have better perfo=
rmance.
> >>>=20
> >>>>> I spent a great deal of time making points about it and arguing tha=
t the
> >>>>> client should try to work around them, and ultimately was told exac=
tly this:
> >>>>> https://lore.kernel.org/linux-nfs/a9411640329ed06dd7306bbdbdf251097=
c5e3411.camel@hammerspace.com/
> >>>>=20
> >>>> Ah, well "client should work around them" is going to be a
> >>>> losing argument every time.
> >>>=20
> >>> Yeah, I agree with that, though at the time I naively thought the iss=
ues
> >>> could be solved by better validation of changing directories.
> >>>=20
> >>> So.. I guess I lost?  I wasn't aware of the stable cookie issues full=
y
> >>> until Trond pointed them out and I compared tmpfs and xfs.  At that p=
oint, I
> >>> saw there's not really much of a path forward for tmpfs, unless we wa=
nt to
> >>> work pretty hard at it.  But why?  Any production server wanting perf=
ormance
> >>> and stability on an NFS export isn't going to use tmpfs on knfsd.  Th=
ere are
> >>> good memory-speed alternatives.
> >>=20
> >> Just curious, what are they? I have xfs on a pair of NVMe
> >> add-in cards, and it's quite fast. But that's an expensive
> >> replacement for tmpfs.
> >>=20
> >> My point is, until now, I had thought that tmpfs was a fully
> >> supported filesystem type for NFS export. What I'm hearing
> >> is that some people don't agree, and worse, it's not been
> >> documented anywhere.
> >>=20
> >> If we're not going to support tmpfs enough to fix these
> >> significant problems, then it should be made unexportable,
> >> and that deprecation needs to be properly documented.
> >>=20
> >>=20
> >>>>> The optimization you'd like to revert fixes a performance regressio=
n on
> >>>>> workloads across exports of all filesystems.  This is a fix we've h=
ad many
> >>>>> folks asking for repeatedly.
> >>>>=20
> >>>> Does the community agree that tmpfs has never been a first-tier
> >>>> filesystem for exporting? That's news to me. I don't recall us
> >>>> deprecating support for tmpfs.
> >>>=20
> >>> I'm definitely not telling folks to use it as exported from knfsd.  I=
'm
> >>> instead telling them, "Directory listings are going to be unstable, y=
ou'll
> >>> see problems." That includes any filesystems with file_operations of
> >>> simple_dir_operations.
> >>=20
> >>> That said, the whole opendir, getdents, unlink, getdents pattern is m=
aybe
> >>> fine for a test that can assume it has exclusive rights (writes?) to =
a
> >>> directory, but also probably insane for anything else that wants to r=
eliably
> >>> remove the thing, and we'll find that's why `rm -rf` still works.  It=
 does
> >>> opendir, getdents, getdents, getdents, unlink, unlink, unlink, .. rmd=
ir.
> >>> This more closely corresponds to POSIX stating:
> >>>=20
> >>>  If a file is removed from or added to the directory after the most r=
ecent
> >>>  call to opendir() or rewinddir(), whether a subsequent call to readd=
ir()
> >>>  returns an entry for that file is unspecified.
> >>>=20
> >>>=20
> >>>> If an optimization broke ext4, xfs, or btrfs, it would be
> >>>> reverted until the situation was properly addressed. I don't
> >>>> see why the situation is different for tmpfs just because it
> >>>> has more bugs.
> >>>=20
> >>> Maybe it isn't?  We've yet to hear from any authoritative sources on =
this.
> >>=20
> >>>>> I hope the maintainers decide not to revert
> >>>>> it, and that we can also find a way to make readdir work reliably o=
n tmpfs.
> >>>>=20
> >>>> IMO the guidelines go the other way: readdir on tmpfs needs to
> >>>> be addressed first. Reverting is a last resort, but I don't see
> >>>> a fix coming before v6.2. Am I wrong?
> >>>=20
> >>> Is your opinion wrong?  :)  IMO, yes, because this is just another ro=
und of
> >>> "we don't fix the client for broken server behaviors".
> >>=20
> >> In general, we don't fix broken servers on the client, true.
> >>=20
> >> In this case, though, this is a regression. A client change
> >> broke workloads that were working in v6.1.
> >=20
> > No. We=E2=80=99ve had this discussion on the NFS mailing list every tim=
e someone invents a new filesystem that they want to export and then claims=
 that they don=E2=80=99t need stable cookies because the NFS protocol doesn=
=E2=80=99t bother to spell that part out. The NFS client cannot and will no=
t claim bug-free support for a filesystem that assigns cookie values in any=
 way that is not 100% repeatable.
>=20
> Nor should it. However:
>=20
> A. tmpfs is not a new filesystem.
>=20
> B. Ben says this is more or less an issue on _all_ filesystems,
> but others manage to hide it effectively, likely as a side-effect
> of having to deal with slow durable storage. Before the optimization,
> tmpfs worked "well enough" as well.
>=20
> C. If we don't want to fully support tmpfs, that's fine. But let's
> document that properly, please.
>=20
> D. If you guys knew beforehand that this change would break tmpfs
> exports, there should have been a warning in the patch description.
>=20
>=20
> The guidelines about regressions are clear. I don't agree with
> leaving the optimization in place while tmpfs is not working well
> enough. And actually, these issues in tmpfs should have been
> addressed first. There's loads of precedent for that requirement.
>=20
> But it appears that as usual I don't have much choice. What I can
> do is file some bugs and see if we can address the server side
> pieces.
>=20
> So far no one has said that the tmpfs cookie problem is irreparable.
> I'd much prefer to keep it in NFSD's stable of support.
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D405
>=20
> And, if it helps, our server should support directory verifiers.
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D404
>=20
>=20
> > Concerning the claim that it was unknown this is a problem with tmpfs, =
then see https://marc.info/?l=3Dlinux-kernel&m=3D100369543808129&w=3D2
> > In the years since 2001, we=E2=80=99ve =E2=80=9Cfixed=E2=80=9D the beha=
viour of tmpfs by circumventing the reliance on cookies for the case of a l=
inear read of a tmpfs directory, but the underlying cookie behaviour is sti=
ll the same, and so the NFS behaviour ends up being the same.
> >=20
> > The bottom line is that you=E2=80=99ve always been playing the lottery =
when mounting tmpfs over NFS.
>=20
> I'm not debating the truth of that. I just don't think we should
> be making that situation needlessly worse.
>=20
> And I would be much more comfortable with this if it appeared in
> a man page or on our wiki, or ... I'm sorry, but "some email in
> 2001" is not documentation a user should be expected to find.

I very much agree with you, Chuck.  Making something imperfect
significantly worse is called "a regression".

And I would expect the (laudable) optimization which introduced
that regression to be reverted from 6.2 for now, unless (I imagine
not, but have no clue) it can be easily conditionalized somehow on
not-tmpfs or not-simple_dir_operations.  But that's not my call.

What is the likelihood that simple_dir_operations will be enhanced,
or a satisfactory complicated_dir_operations added?  I can assure
you, never by me!  If Al or Amir or some dcache-savvy FS folk have
time on their hands and an urge to add what's wanted, great: but
that surely will not come in 6.2, if ever.

More likely that effort would have to come from the NFS(D) end,
who will see the benefit.  And if there's some little tweak to be
made to simple_dir_operations, which will give you the hint you need
to handle it better, I expect fsdevel would welcome a patch or two.

Hugh
---1463760895-1450651585-1675468409=:1657--
