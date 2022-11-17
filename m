Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940A962E72F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 22:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiKQVmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 16:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQVme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:42:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BD5697C3;
        Thu, 17 Nov 2022 13:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 503B8620D7;
        Thu, 17 Nov 2022 21:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85243C433D6;
        Thu, 17 Nov 2022 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668721352;
        bh=ygZwGFjUkC7Rz5wjaDVu71+tbo9xeU4lasrhJDoAnzo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lIm1xgoOQpYszISSV+cFUtxMlZumPlo0m9QTzFwK9R5RDpuMzwfzNWfo/X7E/Hxom
         LmS/nCXR7mcGQIqiIQKONfcfEaqrQxTbpyDqXuBKYc2hrw/kLCcsuz8L1DndxZuxzC
         /LL7GAPB2mlPt5JwgeHNFd8236oX10PMNTlu3mjZcW5KSk3tEQX0w2NEIihtk8GFKU
         w+F7SGvKs5DFJP25IDum+fTHPLHbxby/bF+C0mEEVGFSorwL1W2P0v2uWbU04FUXRn
         cv+2Hi448fFwL0MnSVdQsAMD+I2pGjscseuGa0BnDUkktfUFKrsp+xyldreummHQfS
         ISHsboua8JywA==
Message-ID: <29d007755c6066552ac2a1b5bc498ce1ce28ab3b.camel@kernel.org>
Subject: Re: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto
 mounts
From:   Jeff Layton <jlayton@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        chuck lever <chuck.lever@oracle.com>, anna@kernel.org,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>
Date:   Thu, 17 Nov 2022 16:42:30 -0500
In-Reply-To: <1805608101.252119.1668719538854.JavaMail.zimbra@nod.at>
References: <20221117191151.14262-1-richard@nod.at>
         <20221117191151.14262-3-richard@nod.at>
         <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
         <1805608101.252119.1668719538854.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-11-17 at 22:12 +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Jeff Layton" <jlayton@kernel.org>
> > What happens when CROSSMOUNT isn't enabled and someone tries to stroll
> > into an automount point? I'm guessing the automount happens but the
> > export is denied?=20
>=20
> Exactly.
>=20
> On the other hand, why should knfsd not trigger automounts?
> Almost any userspace interaction would also do so.
>=20

I have no issue with knfsd activity triggering an automount, but I think
it'd be best if we don't do that when knfsd can't do anything with the
resulting filesystem. Automounts can be expensive.

> > It seems like LOOKUP_AUTOMOUNT ought to be conditional
> > on the parent export having CROSSMOUNT set.
> >=20
> > There's also another caller of follow_down too, the UNIX98 pty code.
> > This may be harmless for it, but it'd be best not to perturb that if we
> > can help it.
> >=20
> > Maybe follow_down can grow a lookupflags argument?
>=20
> So, in nfsd_cross_mnt() the follow_down() helper should use LOOKUP_AUTOMO=
UNT only
> if exp->ex_flags & NFSEXP_CROSSMOUNT is true?
> Sounds sane, thanks for the pointer.
>=20

Yeah, I think so. I do wonder if we ought to make any provision for
"nohide" exports, but since you have to enumerate those explicitly, it
shouldn't be a huge problem for someone to just ensure that they're
mounted beforehand.

--=20
Jeff Layton <jlayton@kernel.org>
