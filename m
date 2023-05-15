Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC4703E90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 22:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbjEOUWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 16:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245004AbjEOUWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 16:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D39022;
        Mon, 15 May 2023 13:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3D8763243;
        Mon, 15 May 2023 20:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81FEC433EF;
        Mon, 15 May 2023 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684182121;
        bh=avYoquvtusn+9RDklwACQBOrzP1xzOowbHsqqK90Dn8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h5Ce/rS8rvo62BQ74ox/7fynHeVPrN8Djk52soa36qfbN8fZMGcw2gKtpl6AInanC
         Y8WSOYua6tGgLTKETvus0jtHa/il25uKmfelAr9sApW5BvcWuE0y7RUOMS3wkzgsk8
         FQlI5ygOZR8CmUL7QspcyQEUIW8tkRvj2Fy0YKm4hqFTk1gKdramrYgppjqgKAYp56
         YYeT304o4hjTUqXy2bo5gm8jBaCq/ZP++yC4ZeErrh8uXK6DT516uR0EcNsEyYq5DW
         1oo879xTSZFWLRXLS2jXXCCUVLCydfTtmOZoIMwwEOA/iV+hp/euMK7CLFntirnG0C
         blmBAV7D3uQBQ==
Message-ID: <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     dai.ngo@oracle.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 15 May 2023 16:21:59 -0400
In-Reply-To: <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
         <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
         <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
         <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
         <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
         <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
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

On Mon, 2023-05-15 at 16:10 -0400, Olga Kornievskaia wrote:
> On Mon, May 15, 2023 at 2:58=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Mon, 2023-05-15 at 11:26 -0700, dai.ngo@oracle.com wrote:
> > > On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
> > > > On Sun, May 14, 2023 at 8:56=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com=
> wrote:
> > > > > If the GETATTR request on a file that has write delegation in eff=
ect
> > > > > and the request attributes include the change info and size attri=
bute
> > > > > then the request is handled as below:
> > > > >=20
> > > > > Server sends CB_GETATTR to client to get the latest change info a=
nd file
> > > > > size. If these values are the same as the server's cached values =
then
> > > > > the GETATTR proceeds as normal.
> > > > >=20
> > > > > If either the change info or file size is different from the serv=
er's
> > > > > cached values, or the file was already marked as modified, then:
> > > > >=20
> > > > >     . update time_modify and time_metadata into file's metadata
> > > > >       with current time
> > > > >=20
> > > > >     . encode GETATTR as normal except the file size is encoded wi=
th
> > > > >       the value returned from CB_GETATTR
> > > > >=20
> > > > >     . mark the file as modified
> > > > >=20
> > > > > If the CB_GETATTR fails for any reasons, the delegation is recall=
ed
> > > > > and NFS4ERR_DELAY is returned for the GETATTR.
> > > > Hi Dai,
> > > >=20
> > > > I'm curious what does the server gain by implementing handling of
> > > > GETATTR with delegations? As far as I can tell it is not strictly
> > > > required by the RFC(s). When the file is being written any attempt =
at
> > > > querying its attribute is immediately stale.
> > >=20
> > > Yes, you're right that handling of GETATTR with delegations is not
> > > required by the spec. The only benefit I see is that the server
> > > provides a more accurate state of the file as whether the file has
> > > been changed/updated since the client's last GETATTR. This allows
> > > the app on the client to take appropriate action (whatever that
> > > might be) when sharing files among multiple clients.
> > >=20
> >=20
> >=20
> >=20
> > From RFC 8881 10.4.3:
> >=20
> > "It should be noted that the server is under no obligation to use
> > CB_GETATTR, and therefore the server MAY simply recall the delegation t=
o
> > avoid its use."
>=20
> This is a "MAY" which means the server can choose to not to and just
> return the info it currently has without recalling a delegation.
>=20
>=20

That's not at all how I read that. To me, it sounds like it's saying
that the only alternative to implementing CB_GETATTR is to recall the
delegation. If that's not the case, then we should clarify that in the
spec.

--=20
Jeff Layton <jlayton@kernel.org>
