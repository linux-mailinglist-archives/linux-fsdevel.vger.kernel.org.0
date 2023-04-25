Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC356EE712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjDYRpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9239022;
        Tue, 25 Apr 2023 10:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08B4D616EA;
        Tue, 25 Apr 2023 17:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086B6C433EF;
        Tue, 25 Apr 2023 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682444722;
        bh=UetGMwdP/tJrV8Yar8w3RMh5cMJTojk25/r7z2kcvRU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HvLIP+2XBMjvYn4QXFyN8ilV9wqrHd8tSi2COur0+kfILmSIGtIutF9kne4MM5yjY
         G5hUsYOpqizVtkL9O9FT3G8B1OGIe8ep4V3SfdGBLLEkEmgYUSedAc81RFyFbryW3c
         f5z+iilG2EcmnGH6LaChNt21Wm8OlGjUw8J1P5JcowZAZjVi8wF1czTA8JxvXsoDSM
         XZt+K3PB/fgOG7oktH+1iCZrVeOazyhiekMbfQkA7NWiovV4ugbexbSHZ88n7acfWl
         KC4Y5PvwicwYLcAbql/jy0qtE34PWuU9tiyDRD/OWzCEjHIJTz2DFzg+Axj3tkl0fv
         V7nFvWGdknCSQ==
Message-ID: <aa60b0fa23c1d582cfad0da5b771d427d00c4316.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 25 Apr 2023 13:45:19 -0400
In-Reply-To: <168237601955.24821.11999779095797667429@noble.neil.brown.name>
References: <20230424151104.175456-1-jlayton@kernel.org>
        , <20230424151104.175456-2-jlayton@kernel.org>
        , <168237287734.24821.11016713590413362200@noble.neil.brown.name>
        , <404a9a8066b0735c9f355214d4eadf0d975b3188.camel@kernel.org>
         <168237601955.24821.11999779095797667429@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-25 at 08:40 +1000, NeilBrown wrote:
> On Tue, 25 Apr 2023, Jeff Layton wrote:
> > On Tue, 2023-04-25 at 07:47 +1000, NeilBrown wrote:
> > > On Tue, 25 Apr 2023, Jeff Layton wrote:
> > > > +	/*
> > > > +	 * Warn if someone sets SB_MULTIGRAIN_TS, but doesn't turn down t=
he ts
> > > > +	 * granularity.
> > > > +	 */
> > > > +	return (sb->s_flags & SB_MULTIGRAIN_TS) &&
> > > > +		!WARN_ON_ONCE(sb->s_time_gran =3D=3D 1);
> > >=20
> > >  Maybe=20
> > > 		!WARN_ON_ONCE(sb->s_time_gran & SB_MULTIGRAIN_TS);
> > >  ??
> > >=20
> >=20
> > I'm not sure I understand what you mean here.
>=20
> That's fair, as what I wrote didn't make any sense.
> I meant to write:
>=20
>  		!WARN_ON_ONCE(sb->s_time_gran & I_CTIME_QUERIED);
>=20
> to make it explicit that s_time_gran must leave space for
> I_CTIME_QUERIED to be set (as you write below).  Specifically that
> s_time_gran mustn't be odd.=20
>  =20

Erm...it may be an unpopular opinion, but I find that more confusing
than just ensuring that the s_time_gran > 1. I keep wondering if we
might want to carve out other low-order bits too for some later purpose,
at which point trying to check this using flags wouldn't work right. I
think I might just stick with what I have here, at least for now.

--=20
Jeff Layton <jlayton@kernel.org>
