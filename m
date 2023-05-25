Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358467109F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbjEYKVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbjEYKVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45C10C9;
        Thu, 25 May 2023 03:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCF56383E;
        Thu, 25 May 2023 10:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A0C433EF;
        Thu, 25 May 2023 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685009993;
        bh=sNJfs+uXDZb2HNLodP8emInGGRtjoPquqaOu6BISM3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h0qmdyhi+4F9ehNTQFjpHjDpPzhqz7O6tH1sNA6yLLzeZB1pbYjHghxFRnCnLoQXE
         6uHQSxbZHpYN2kv8LK3k2/U1da03miz/YkxVyHfapwBqRv5iG0aqDuNbRzEQn65wJn
         jChc9+Xw2iwqeOp4h7kY8IYI0v+QsHLDvI7pwq94sx1CiDhMMd0UgKtwt7IO9Z9ZHK
         iG44ORIsEwgrB4RaZXX6oErJ+rSzcmp3Riqt2hR0PKU0twcR50iEG00xFNpokrRrwe
         pS2xRDpEMEQK/R6EE2kBugKBsmvayEaLGiCeJ6itKOOj8FX73OPhBBgh/Ig7LjcUhm
         LxGNMBH7fhPRQ==
Message-ID: <7703ca436bb99e1b1e468863720a19e159ef2285.camel@kernel.org>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file
 handles
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Xiubo Li <xiubli@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 25 May 2023 06:19:51 -0400
In-Reply-To: <CAOQ4uxgA-kQOOp69pyKhQpMZZuyWZ0t6ir+nqL4yL9wX5CBNgQ@mail.gmail.com>
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
         <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
         <20230524140648.u6pexxspze7pz63z@quack3>
         <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
         <CAOQ4uxgA-kQOOp69pyKhQpMZZuyWZ0t6ir+nqL4yL9wX5CBNgQ@mail.gmail.com>
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

On Thu, 2023-05-25 at 12:48 +0300, Amir Goldstein wrote:
> On Thu, May 25, 2023 at 12:26=E2=80=AFPM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
> >=20
> > On Wed, May 24, 2023 at 04:06:48PM +0200, Jan Kara wrote:
> > > Yes, I've checked and all ->encode_fh() implementations return
> > > FILEID_INVALID in case of problems (which are basically always only
> > > problems with not enough space in the handle buffer).
> >=20
> > ceph_encode_fh() can return -EINVAL
>=20
> Ouch! thanks for pointing this out
>=20
> Jeff,
>=20
> In your own backyard ;-)
> Do you think this new information calls for rebasing my fix on top of mas=
ter
> and marking it for stable? or is this still low risk in your opinion?
>=20

(cc'ing Xiubo in case he has thoughts here)

It looks like that mainly happens when trying to encode the fh for a
snapshot inode, if you can't find a dentry for it, or if it's not a
directory inode and it has no parent.

The logic of the ceph snapshot code has always escaped me,
unfortunately, and I don't have a good feel for how likely this is. It
seems like it's a non-zero chance though, and this patch is unlikely to
harm anything so marking it for stable might be a good idea.
--=20
Jeff Layton <jlayton@kernel.org>
