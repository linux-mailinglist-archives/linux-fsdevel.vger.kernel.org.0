Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941878C3B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjH2Lz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjH2LzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1019A;
        Tue, 29 Aug 2023 04:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0307647F1;
        Tue, 29 Aug 2023 11:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C40C433C7;
        Tue, 29 Aug 2023 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693310103;
        bh=knrCv4NiqpwHXRsl1DxlDbGxxxwslBypdj1jUPCRAQg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a+7P9nm1JQ1Q0dT9ZCJJ9ttKq8CMEUPJoz3sa0SLRqXP/PyAaTiJiIPqKWRFolVCa
         O5LhLyIeMnv9yd/C1KcV7Dj+ZwO1LiVxw0HVYQa960Pk2ExcMvKOZHAr1n70f5ZaIP
         rzYNY+YJ5MSb0JuEl6XYzM/yqL/u49JS7Id+hDNRMR0Uraf55YeP+mGpJfzvGbrV7j
         cnDYbLlhdCEE9AzMhU56birPH30hnmSKMcjzDpZA3WZFVQD993w8026KgZKwymZrS0
         G1GTdjJwku0pUjGr5Tssm3Bl8TUEz8uYRd0XeZIHa7faQb1WV8OcV/uphDuIJQCkw1
         jg6PSqyU4TvqQ==
Message-ID: <668b6e07047bdc97dfa1d522606ec2b28420bdce.camel@kernel.org>
Subject: Re: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 29 Aug 2023 07:55:01 -0400
In-Reply-To: <2f1e16e5-1034-b064-7a92-e89f08fd2ac1@redhat.com>
References: <20230825201225.348148-1-willy@infradead.org>
         <20230825201225.348148-10-willy@infradead.org>
         <ZOlq5HmcdYGPwH2i@casper.infradead.org>
         <2f1e16e5-1034-b064-7a92-e89f08fd2ac1@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-08-28 at 09:19 +0800, Xiubo Li wrote:
> On 8/26/23 11:00, Matthew Wilcox wrote:
> > On Fri, Aug 25, 2023 at 09:12:19PM +0100, Matthew Wilcox (Oracle) wrote=
:
> > > +++ b/fs/ceph/addr.c
> > > @@ -1608,29 +1608,30 @@ static vm_fault_t ceph_filemap_fault(struct v=
m_fault *vmf)
> > >   		ret =3D VM_FAULT_SIGBUS;
> > >   	} else {
> > >   		struct address_space *mapping =3D inode->i_mapping;
> > > -		struct page *page;
> > > +		struct folio *folio;
> > >  =20
> > >   		filemap_invalidate_lock_shared(mapping);
> > > -		page =3D find_or_create_page(mapping, 0,
> > > +		folio =3D __filemap_get_folio(mapping, 0,
> > > +				FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
> > >   				mapping_gfp_constraint(mapping, ~__GFP_FS));
> > > -		if (!page) {
> > > +		if (!folio) {
> > This needs to be "if (IS_ERR(folio))".  Meant to fix that but forgot.
> >=20
> Hi Matthew,
>=20
> Next time please rebase to the latest ceph-client latest upstream=20
> 'testing' branch, we need to test this series by using the qa=20
> teuthology, which is running based on the 'testing' branch.
>=20

People working on wide-scale changes to the kernel really shouldn't have
to go hunting down random branches to base their changes on. That's the
purpose of linux-next.

This is an ongoing problem with ceph maintenance -- patches sit in the
"testing" branch that doesn't go into linux-next. Anyone who wants to
work on patches vs. linux-next that touch ceph runs the risk of
developing against outdated code.

The rationale for this (at least at one time) was a fear of breaking
linux-next, but that its purpose. If there are problems, we want to know
early!

As long as you don't introduce build breaks, anything you shovel into
next is unlikely to be a problematic. There aren't that many people
doing ceph testing with linux-next, so the risk of breaking things is
pretty low, at least with patches that only touch ceph code. You do need
to be a bit more careful with patches that touch common code, but those
are pretty rare in the ceph tree.

Please change this!
--=20
Jeff Layton <jlayton@kernel.org>
