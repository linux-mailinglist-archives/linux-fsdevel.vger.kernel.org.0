Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C903E6D02C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 13:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjC3LPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 07:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjC3LPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:15:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A54EF1;
        Thu, 30 Mar 2023 04:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D950B8277E;
        Thu, 30 Mar 2023 11:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797EC4339B;
        Thu, 30 Mar 2023 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680174938;
        bh=YCSzKhNNBlTSK7z9joSzKOHxtCHi+jqjL1rPXUOpFEQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O1RS3fu9KpGLVFV3Q09UyEqLd5K8DnOi+CchwJ9QUZ+ladJ09I3Zyr2oYDFHJ8GHX
         Tv/0ItAQ/Ah8WDyngHvR0ynJCqRui0N5I7Cr0UsXEBQdEfPf6xsGfNiMAOLMlpOP6k
         6ets9kYdd++JvITISKRdLxyFH/T4TxBq6WzgFOOnIhsrJDCm6YunLPOfqdQOVCkpNi
         P2xxfCUT5V1NyhjGxVkoC7t2iCM0LdpW5FFmGmNDqlDx2GwDT9ajwnupvfOCP3oFJF
         Lc1Dv17vrqZcRK1T5ErSS/0BqBFQdl6yJ1nyPsDmdL3yOwzXYKtyO0Zcc7CS4ClMEj
         xtPdBqTDtaMRA==
Message-ID: <31bd4a176344cd0746f1ec519eb8caca2ef2ba68.camel@kernel.org>
Subject: Re: [PATCH] fs: consolidate duplicate dt_type helpers
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 30 Mar 2023 07:15:36 -0400
In-Reply-To: <ZCVpAyA__NrAOVOg@kroah.com>
References: <20230330104144.75547-1-jlayton@kernel.org>
         <ZCVpAyA__NrAOVOg@kroah.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-03-30 at 12:48 +0200, Greg Kroah-Hartman wrote:
> On Thu, Mar 30, 2023 at 06:41:43AM -0400, Jeff Layton wrote:
> > There are three copies of the same dt_type helper sprinkled around the
> > tree. Convert them to use the common fs_umode_to_dtype function instead=
,
> > which has the added advantage of properly returning DT_UNKNOWN when
> > given a mode that contains an unrecognized type.
> >=20
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Phillip Potter <phil@philpotter.co.uk>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/configfs/dir.c | 9 ++-------
> >  fs/kernfs/dir.c   | 8 +-------
> >  fs/libfs.c        | 9 ++-------
> >  3 files changed, 5 insertions(+), 21 deletions(-)
> >=20
> > v2: consolidate S_DT helper as well
> > v3: switch existing dt_type helpers to use fs_umode_to_dtype
> >     drop v9fs hunks since they're no longer needed
>=20
> You forgot the "v3" in the subject line :(
>=20

Yeah, I noticed, sorry. It's the attention to detail that makes me such
a successful kernel developer! ;)
--=20
Jeff Layton <jlayton@kernel.org>
