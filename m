Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B608D704127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 00:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbjEOWx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjEOWx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 18:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15076A5EB;
        Mon, 15 May 2023 15:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66F760FE1;
        Mon, 15 May 2023 22:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C90C433D2;
        Mon, 15 May 2023 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684191204;
        bh=GBaQ1sAKGrLcIEZ/rTFluRQF8TNRDTUiTMsnceckBXo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YyvnlAe8VGrjgmqfOyuSOQ7gkM5fUa5VpMCs6Wt/isKkx1s72XHO2zEU0X+HnQ+se
         a4hg1IQIY7erboXDO0+8TeMwqb1eIJK2UoJx3fjhZ6W08AphrwVo+6P3RkpxEHNyNi
         ICzsbPDv4jld4silkU+8oX3JpZWatpObpruYcXQXWTB+Fvqdw+7IR3bcZU2jl9dF9J
         IbnXw5fnNK7Wjv6/SLI0hwbF7FOu24FhWOn4vAahNlt3O2lRFDvnfohDpCE7iXOFjV
         mN8fYFxCq7OzeD1mEhHyFSYJBKxtO75wiGjQDKTkDRAHuL9PH5Qs9bSV1I/D8gFzHI
         Y80m5rrgKMooQ==
Message-ID: <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 15 May 2023 18:53:22 -0400
In-Reply-To: <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
         <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
         <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
         <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
         <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
         <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
         <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
         <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2023-05-15 at 21:37 +0000, Chuck Lever III wrote:
>=20
> > On May 15, 2023, at 4:21 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2023-05-15 at 16:10 -0400, Olga Kornievskaia wrote:
> > > On Mon, May 15, 2023 at 2:58=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > >=20
> > > > On Mon, 2023-05-15 at 11:26 -0700, dai.ngo@oracle.com wrote:
> > > > > On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
> > > > > > On Sun, May 14, 2023 at 8:56=E2=80=AFPM Dai Ngo <dai.ngo@oracle=
.com> wrote:
> > > > > > > If the GETATTR request on a file that has write delegation in=
 effect
> > > > > > > and the request attributes include the change info and size a=
ttribute
> > > > > > > then the request is handled as below:
> > > > > > >=20
> > > > > > > Server sends CB_GETATTR to client to get the latest change in=
fo and file
> > > > > > > size. If these values are the same as the server's cached val=
ues then
> > > > > > > the GETATTR proceeds as normal.
> > > > > > >=20
> > > > > > > If either the change info or file size is different from the =
server's
> > > > > > > cached values, or the file was already marked as modified, th=
en:
> > > > > > >=20
> > > > > > >    . update time_modify and time_metadata into file's metadat=
a
> > > > > > >      with current time
> > > > > > >=20
> > > > > > >    . encode GETATTR as normal except the file size is encoded=
 with
> > > > > > >      the value returned from CB_GETATTR
> > > > > > >=20
> > > > > > >    . mark the file as modified
> > > > > > >=20
> > > > > > > If the CB_GETATTR fails for any reasons, the delegation is re=
called
> > > > > > > and NFS4ERR_DELAY is returned for the GETATTR.
> > > > > > Hi Dai,
> > > > > >=20
> > > > > > I'm curious what does the server gain by implementing handling =
of
> > > > > > GETATTR with delegations? As far as I can tell it is not strict=
ly
> > > > > > required by the RFC(s). When the file is being written any atte=
mpt at
> > > > > > querying its attribute is immediately stale.
> > > > >=20
> > > > > Yes, you're right that handling of GETATTR with delegations is no=
t
> > > > > required by the spec. The only benefit I see is that the server
> > > > > provides a more accurate state of the file as whether the file ha=
s
> > > > > been changed/updated since the client's last GETATTR. This allows
> > > > > the app on the client to take appropriate action (whatever that
> > > > > might be) when sharing files among multiple clients.
> > > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > From RFC 8881 10.4.3:
> > > >=20
> > > > "It should be noted that the server is under no obligation to use
> > > > CB_GETATTR, and therefore the server MAY simply recall the delegati=
on to
> > > > avoid its use."
> > >=20
> > > This is a "MAY" which means the server can choose to not to and just
> > > return the info it currently has without recalling a delegation.
> > >=20
> > >=20
> >=20
> > That's not at all how I read that. To me, it sounds like it's saying
> > that the only alternative to implementing CB_GETATTR is to recall the
> > delegation. If that's not the case, then we should clarify that in the
> > spec.
>=20
> The meaning of MAY is spelled out in RFC 2119. MAY does not mean
> "the only alternative". I read this statement as alerting client
> implementers that a compliant server is permitted to skip
> CB_GETATTR, simply by recalling the delegation. Technically
> speaking this compliance statement does not otherwise restrict
> server behavior, though the author might have had something else
> in mind.
>=20
> I'm leery of the complexity that CB_GETATTR adds to NFSD and
> the protocol. In addition, section 10.4 is riddled with errors,
> albeit minor ones; that suggests this part of the protocol is
> not well-reviewed.
>=20
> It's not apparent how much gain is provided by CB_GETATTR.
> IIRC NFSD can recall a delegation on the same nfsd thread as an
> incoming request, so the turnaround for a recall from a local
> client is going to be quick.
>=20
> It would be good to know how many other server implementations
> support CB_GETATTR.

> I'm rather leaning towards postponing 3/4 and 4/4 and instead
> taking a more incremental approach. Let's get the basic Write
> delegation support in, and possibly add a counter or two to
> find out how often a GETATTR on a write-delegated file results
> in a delegation recall.
>=20
> We can then take some time to disambiguate the spec language and
> look at other implementations to see if this extra protocol is
> really of value.
>=20
> I think it would be good to understand whether Write delegation
> without CB_GETATTR can result in a performance regression (say,
> because the server is recalling delegations more often for a
> given workload).
>=20


Ganesha has had write delegation and CB_GETATTR support for years.

Isn't CB_GETATTR the main benefit of a write delegation in the first
place? A write deleg doesn't really give any benefit otherwise, as you
can buffer writes anyway without one.

AIUI, the point of a write delegation is to allow other clients (and
potentially the server) to get up to date information on file sizes and
change attr when there is a single, active writer.

Without CB_GETATTR, your first stat() against the file will give you
fairly up to date info (since you'll have to recall the delegation), but
then you'll be back to the server just reporting the size and change
attr that it has at the time.

--=20
Jeff Layton <jlayton@kernel.org>
