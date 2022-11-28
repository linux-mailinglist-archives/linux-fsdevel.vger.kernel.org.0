Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D74363A75D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiK1Ltx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 06:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiK1Ltr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:49:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8715A17E26;
        Mon, 28 Nov 2022 03:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3385BB80D63;
        Mon, 28 Nov 2022 11:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD20C433C1;
        Mon, 28 Nov 2022 11:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636178;
        bh=nUD6wWWFNxtPNb8m2y9VRRA9H42MmowlBVJDxx/RGsE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E18jd0HflNEVZ2ajShDHJJIkNA7E1IMhsfwD6zt+nnk/NTjZ2PMgO045Q58aVDBG1
         uALGlHvnNiBnfY2x6LcAwG8ge6e8nRo1MwLr5AVv9XbYuSyeylEiXRnfeb8nY60w5P
         ONLqwxmOpb/ykHrj+Xv7KSbSrFkvNvLSNOC1oK/bqRF6I3iGE41jkrXS5L2Y6PWfEE
         N1hVuh9fPwygFYJgT/RnquEf0vlW3MluQpzLXeSfrcGFwLitmKf+EYhti3I/xrrZ7Y
         ZnVhWk9heRFqfpVir+FWvoRUcn7LaMxvx+DPgmBBzee8LLmvTeX1hE4kZtsjVGj+60
         b5jwKV6k8w+kQ==
Message-ID: <8ca382fa391a08313ba8dc5ce115e1832e32aebb.camel@kernel.org>
Subject: Re: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto
 mounts
From:   Jeff Layton <jlayton@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        chuck lever <chuck.lever@oracle.com>, anna <anna@kernel.org>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven <raven@themaw.net>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>
Date:   Mon, 28 Nov 2022 06:49:36 -0500
In-Reply-To: <1045320558.283423.1669584585412.JavaMail.zimbra@nod.at>
References: <20221117191151.14262-1-richard@nod.at>
         <20221117191151.14262-3-richard@nod.at>
         <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
         <1805608101.252119.1668719538854.JavaMail.zimbra@nod.at>
         <29d007755c6066552ac2a1b5bc498ce1ce28ab3b.camel@kernel.org>
         <1045320558.283423.1669584585412.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-11-27 at 22:29 +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Jeff Layton" <jlayton@kernel.org>
> > > So, in nfsd_cross_mnt() the follow_down() helper should use LOOKUP_AU=
TOMOUNT
> > > only
> > > if exp->ex_flags & NFSEXP_CROSSMOUNT is true?
> > > Sounds sane, thanks for the pointer.
> > >=20
> >=20
> > Yeah, I think so. I do wonder if we ought to make any provision for
> > "nohide" exports, but since you have to enumerate those explicitly, it
> > shouldn't be a huge problem for someone to just ensure that they're
> > mounted beforehand.
>=20
> TBH, I didn't invest much into the nohide feature wrt. NFS re-exporting.
> What problem do you have in mind?
>=20

nohide is sort of complimentary to crossmnt. You can achieve the same
effect as crossmnt by adding explicit exports for all the children and
marking them "nohide".

The point here is that you have to explicitly create exports for the
child mounts in that case, and if you're doing that then it's not a
burden for the admin to make sure they're mounted before exporting.

So, I don't think we need to worry about nohide here after all.

> I wonder also what NFS client folks think about my changes before I send
> the next revision (with Jeff's comments addressed).
--=20
Jeff Layton <jlayton@kernel.org>
