Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4502055F1C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiF1XJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 19:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiF1XJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:09:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F432CC89;
        Tue, 28 Jun 2022 16:09:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E8151FD8B;
        Tue, 28 Jun 2022 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656457796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3EDuY+Ya/PyFfjJ28NCPihRwor6RW8Z8zdG/gLgK3Q=;
        b=Sv4Z/Ucqnzxl9V2xY3v4TjVTDL8wkk7iSPL5afSMenPwWpDR7POZyGarhs2fXPNhsQeqpm
        zDkbN8MGW5V5Di8+n+a064ETw+AytqpYlziiNOz7eSFn2y0AqN28Hw5eP26y0fn6JkFSyj
        jJzG0KCLtjt+aG8F/C/TZIWrVaLMUAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656457796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3EDuY+Ya/PyFfjJ28NCPihRwor6RW8Z8zdG/gLgK3Q=;
        b=GO9X1yOdSv5OwL9cdYiokZIrPweeF5p+CR/f+Pb49OnwqA0q5O/dAcmfxYsoJCnkjt9YdZ
        WHVQvfSTvSDl0YDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC530139E9;
        Tue, 28 Jun 2022 23:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PYCQIUGKu2KUJAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 28 Jun 2022 23:09:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Daire Byrne" <daire@dneg.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] nfsd: allow parallel creates from nfsd
In-reply-to: <CF45DA56-C7C7-434C-A985-A0FE08703F8D@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>,
 <165516230200.21248.15108802355330895562.stgit@noble.brown>,
 <CF45DA56-C7C7-434C-A985-A0FE08703F8D@oracle.com>
Date:   Wed, 29 Jun 2022 09:09:50 +1000
Message-id: <165645779028.15378.2009203210771986783@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022, Chuck Lever III wrote:
>=20
> > On Jun 13, 2022, at 7:18 PM, NeilBrown <neilb@suse.de> wrote:
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index c29baa03dfaf..a50db688c60d 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -616,7 +616,7 @@ fh_update(struct svc_fh *fhp)
> >  * @fhp: file handle to be updated
> >  *
> >  */
> > -void fh_fill_pre_attrs(struct svc_fh *fhp)
> > +void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic)
>=20
> Hi Neil, just noticed this:
>=20
>   CC [M]  fs/nfsd/nfsfh.o
>   CHECK   /home/cel/src/linux/linux/fs/nfsd/nfsfh.c
> /home/cel/src/linux/linux/fs/nfsd/nfsfh.c:621: warning: Function parameter =
or member 'atomic' not described in 'fh_fill_pre_attrs'

Thanks.  I"ll address that, and also the other issues that you raised in
your patch-by-patch review.  Thanks for those.

>=20
> And... do you intend to repost this series with the supplemental
> fixes applied?

I've been a bit distracted this week, but my current plan is to
reorganise the patches to put as many of the NFS and NFSD patches as
possible before the VFS patches.  There should then just be one each for
NFS and NFSD after the VFS changes.  I hope to post that series early
next week.

>=20
> Should we come up with a plan to merge these during the next
> window, or do you feel more work is needed?

I think it would be reasonable to merge the preliminary NFS and NFSD
patches in the next window.  I'd really like to hear from Al before
pushing the rest too hard.  Probably after rc1 I'll post the remainder
of the series and include Linus if we haven't heard from Al.  I'd be
perfectly happy if the main content of the series landed in the
subsequent merge window.

Thanks,
NeilBrown
