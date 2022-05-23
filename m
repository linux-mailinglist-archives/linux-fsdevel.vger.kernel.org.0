Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64E531983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbiEWSec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiEWSeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 14:34:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF76164;
        Mon, 23 May 2022 11:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91C44B8121F;
        Mon, 23 May 2022 18:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D44C385AA;
        Mon, 23 May 2022 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653329369;
        bh=/MwJ0RsTlhSbXBrwd7tYkz8M733d9H6V2XdJlILNf8Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Phwmp1vEOPEiL7zk1WAEJ3x7VejVumPfRqtUUbrAdO4pELa3BqOFexcE8mqp4qPoC
         GzjR+mZGTyWfWt1TBJ+WOX3zzFcmpDIHXO3I/t41gRd1f3+7D15wRtXYk7H+FRP7mJ
         lDy7jKxHEWamaL2PCEvYXvQ4ieijNd0LGqjq8ajeNb+YfMARbqkqh/qk7/QjAexY9h
         7onAWBv5igv78yM9WwWR9oywFH5Dkk1N4yqJ/fhdDrsaFKmkzipvz/b5Yb7Wm4mpE8
         krRukRocSlP4OVuSHdk1XcMWUBXbqWcVj6owMyz7K2G+RZtdens3Qm3VMpMiBeHSMw
         0xfeFNZWHFSxg==
Message-ID: <cb6bcf221e28deb8dcaf5c02fba6c2257586363e.camel@kernel.org>
Subject: Re: [PATCH v5 1/2] fs/dcache: add d_compare() helper support
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>, Xiubo Li <xiubli@redhat.com>
Cc:     idryomov@gmail.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        vshankar@redhat.com, ceph-devel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 14:09:26 -0400
In-Reply-To: <YovK86vEmOUUoBn6@bombadil.infradead.org>
References: <20220519101847.87907-1-xiubli@redhat.com>
         <20220519101847.87907-2-xiubli@redhat.com>
         <YovK86vEmOUUoBn6@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-23 at 10:57 -0700, Luis Chamberlain wrote:
> On Thu, May 19, 2022 at 06:18:45PM +0800, Xiubo Li wrote:
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > ---
> >  fs/dcache.c            | 15 +++++++++++++++
> >  include/linux/dcache.h |  2 ++
> >  2 files changed, 17 insertions(+)
> >=20
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index 93f4f5ee07bf..95a72f92a94b 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -2262,6 +2262,21 @@ static inline bool d_same_name(const struct dent=
ry *dentry,
> >  				       name) =3D=3D 0;
> >  }
> > =20
> > +/**
> > + * d_compare - compare dentry name with case-exact name
> > + * @parent: parent dentry
> > + * @dentry: the negative dentry that was passed to the parent's lookup=
 func
> > + * @name:   the case-exact name to be associated with the returned den=
try
> > + *
> > + * Return: 0 if names are same, or 1
> > + */
> > +bool d_compare(const struct dentry *parent, const struct dentry *dentr=
y,
> > +	       const struct qstr *name)
> > +{
> > +	return !d_same_name(dentry, parent, name);
>=20
> What's wrong with d_same_name()? Why introduce a whole new operation
> and export it when you the same prototype except first and second
> argument moved with an even more confusing name?
>=20

Agreed. That would be better.

> > +}
> > +EXPORT_SYMBOL(d_compare);
>=20
> New symbols should go with EXPORT_SYMBOL_GPL() instead.
>=20
>   Luis

In the past, Al has pushed back against that since EXPORT_SYMBOL_GPL has
no clear legal meaning. He may have changed his opinion since, but I
haven't heard that that was the case.

--=20
Jeff Layton <jlayton@kernel.org>
