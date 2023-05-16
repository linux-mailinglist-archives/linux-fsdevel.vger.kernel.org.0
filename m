Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C597059C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEPVtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPVtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 17:49:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252D4231;
        Tue, 16 May 2023 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=qX3TDBBfnv2uCDmGLS2VPyA+Gh3/+O2HCnmowsbVUmM=; b=SrFhVkf1jeAfDjjib0T2F65uBI
        Cd44jhpuQ6snrn7ie9rBqs6mWj3hRYG1QQKGNYqkiGkvzf63vOtMdZSTlO1VMovCwjvfrK8sZ1lWc
        SBgOiy8oAoiIlwra9wI3fA5KycTIfGmeZ6aCCwzcmZxCF1q7n4Ni1n+97LkFkggN8gPa36EUXT9+S
        MnL5TCTxEoCQVs9xU3V5LSIA+yfZ4T10+7BgaeTr753n7lKReW5sqNPNbkhV6QSNmvPoKo66IMPDV
        sSNjK3HsmCy2OdDqOf9uhIZFwTeHO4QCO/V3kC5m8/0HCwP3mwBsEaOUk+O89CVi+i6A4XPbXneBL
        n4MsqphA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pz2Xx-007Dn0-2I;
        Tue, 16 May 2023 21:49:29 +0000
Date:   Tue, 16 May 2023 14:49:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] parport: Remove register_sysctl_table from
 parport_proc_register
Message-ID: <ZGP6aZJ5b7WOrA07@bombadil.infradead.org>
References: <20230515071446.2277292-1-j.granados@samsung.com>
 <CGME20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8@eucas1p1.samsung.com>
 <20230515071446.2277292-3-j.granados@samsung.com>
 <ZGMD4xMRKS8dZJpU@bombadil.infradead.org>
 <20230516143116.hz6rr6kzsviobx35@localhost>
 <20230516161221.cojocvsre7uhvz7o@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230516161221.cojocvsre7uhvz7o@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 06:12:21PM +0200, Joel Granados wrote:
> On Tue, May 16, 2023 at 04:31:16PM +0200, Joel Granados wrote:
> > On Mon, May 15, 2023 at 09:17:39PM -0700, Luis Chamberlain wrote:
> > > Awesome!
> > >=20
> > > On Mon, May 15, 2023 at 09:14:42AM +0200, Joel Granados wrote:
> > > > +
> > > > +	port_name_len =3D strnlen(port->name, PARPORT_NAME_MAX_LEN);
> > > > +	/*
> > > > +	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parp=
ort/PORT/devices.
> > > > +	 * We calculate for the second as that will give us enough for th=
e first.
> > > > +	 */
> > > > +	tmp_path_len =3D PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
> > > > +	tmp_dir_path =3D kmalloc(tmp_path_len, GFP_KERNEL);
> > >=20
> > > Any reason why not kzalloc()?
> > nope. Will zero it out.
> >=20
> > >=20
> > > > +	if (!tmp_dir_path) {
> > > > +		err =3D -ENOMEM;
> > > > +		goto exit_free_t;
> > > > +	}
> > > > =20
> > > > -	t->port_dir[0].procname =3D port->name;
> > > > +	if (tmp_path_len
> > > > +	    <=3D snprintf(tmp_dir_path, tmp_path_len, "dev/parport/%s/dev=
ices", port->name)) {
> > >=20
> > > Since we are clearing up obfuscation code, it would be nicer to
> > > make this easier to read and split the snprintf() into one line, capt=
ure
> > > the error there. And then in a new line do the check. Even if we have=
 to
> > > add a new int value here.
> > np. Will do something like this:
> >=20
> > num_chars_sprinted =3D snprintf(....
> > if(tmp_path_len <=3D num_chars_sprinted) {
> >   err =3D -ENOENT;
> >   ...
> > }
> >=20
> > >=20
> > > Other than this I'd just ask to extend the commit log to use
> > > the before and after of vmlinux (when this module is compiled in with=
 all
> > > the bells and whistles) with ./scripts/bloat-o-meter.
> > >=20
> > > Ie build before the patch and cp vmlinux to vmlinux.old and then comp=
are
> > > with:
> > >=20
> > > ./scripts/bloat-o-meter vmlinux.old vmlinux
> > >=20
> > > Can you also describe any testing if any.
> > Sure thing. Will add the bloat-o-meter output on the last patch so as to
> > gather the results for all the patches.
> >=20
> > I'll write some testing info on the patches.
> >=20
> >=20
> > >=20
> > > With the above changes, feel free to add to all these patches:
> > >=20
> > > Reviewed-by: Luis Chamberlain
> > Ack
> >=20
> > >=20
> > > > +	if (register_sysctl(tmp_dir_path, t->device_dir) =3D=3D NULL)
> > >=20
> > > BTW, we should be able to remove now replace register_sysctl_base() w=
ith a simple
> > > register_sysctl("kernel", foo), and then one for "fs", and one of "vm"
> > > on kernel/sysctl.c and just remove:
> > >=20
> > >   * DECLARE_SYSCTL_BASE() & register_sysctl_base() & __register_sysct=
l_base()
> > >   * and then after all this register_sysctl_table() completely
> > >=20
> > > Let me know if you'd like a stab at it, or if you prefer me to do tha=
t.
> > I think I can give it a go. Should I just add that to these set of
> > patches? or should we create a new patch set?
> I'll send the V2 of this patch set without this. Will add it to the
> patch set when I finish if it makes sense. Else I'll just create a new
> series.

New series is good.

  Luis
