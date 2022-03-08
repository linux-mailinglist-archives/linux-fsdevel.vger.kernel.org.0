Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC024D1F16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 18:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiCHR2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 12:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349154AbiCHR2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:28:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FF2F7B;
        Tue,  8 Mar 2022 09:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCA1B61306;
        Tue,  8 Mar 2022 17:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E63C340EB;
        Tue,  8 Mar 2022 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760455;
        bh=Wyo7DT2LJqEn+VENd6dCx837uI7HnqAB2NMm453HARc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dM3LX4E3Qz2mCJs1OHF05HvFyJsXPwfK12g/YyBr9000rhGAq4e5fs4GHZ+vYJO2I
         iEwMLBkTqGImqGhmTWvmELXgLU+flvjC5qVaCuNSk/SK+MH5cCDLcdW0RrKLIydWEq
         Ls62QOa+hahmahJmMj7KACEMhGwO914/OtLqbj4y5OJzW4Ca5QgUBpvGjTerxD7siH
         pm3Dw4DPbIHgD1T2kHs+MopokIKVssFgGej0bi8qrRsidue/qdjNoCprDzjFt6oBlW
         dMgPF+Wa2U1E0QNV4/m43xQ1xonN/sTGRRy7u8wtDI3F3QXmt4WSCEgws4AztjIefd
         9Qca7ysLr1XOQ==
Date:   Tue, 8 Mar 2022 09:27:34 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm v2] tmpfs: do not allocate pages on read
Message-ID: <20220308172734.GC1479066@magnolia>
References: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com>
 <20220306092709.GA22883@lst.de>
 <90bc5e69-9984-b5fa-a685-be55f2b64b@google.com>
 <20220307064434.GA31680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307064434.GA31680@lst.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:44:34AM +0100, Christoph Hellwig wrote:
> On Sun, Mar 06, 2022 at 02:59:05PM -0800, Hugh Dickins wrote:
> > Mikulas asked in
> > https://lore.kernel.org/linux-mm/alpine.LRH.2.02.2007210510230.6959@file01.intranet.prod.int.rdu2.redhat.com/
> > Do we still need a0ee5ec520ed ("tmpfs: allocate on read when stacked")?
> > 
> > Lukas noticed this unusual behavior of loop device backed by tmpfs in
> > https://lore.kernel.org/linux-mm/20211126075100.gd64odg2bcptiqeb@work/
> > 
> > Normally, shmem_file_read_iter() copies the ZERO_PAGE when reading holes;
> > but if it looks like it might be a read for "a stacking filesystem", it
> > allocates actual pages to the page cache, and even marks them as dirty.
> > And reads from the loop device do satisfy the test that is used.
> > 
> > This oddity was added for an old version of unionfs, to help to limit
> > its usage to the limited size of the tmpfs mount involved; but about
> > the same time as the tmpfs mod went in (2.6.25), unionfs was reworked
> > to proceed differently; and the mod kept just in case others needed it.
> > 
> > Do we still need it? I cannot answer with more certainty than "Probably
> > not". It's nasty enough that we really should try to delete it; but if
> > a regression is reported somewhere, then we might have to revert later.
> > 
> > It's not quite as simple as just removing the test (as Mikulas did):
> > xfstests generic/013 hung because splice from tmpfs failed on page not
> > up-to-date and page mapping unset.  That can be fixed just by marking
> > the ZERO_PAGE as Uptodate, which of course it is: do so in
> > pagecache_init() - it might be useful to others than tmpfs.
> > 
> > My intention, though, was to stop using the ZERO_PAGE here altogether:
> > surely iov_iter_zero() is better for this case?  Sadly not: it relies
> > on clear_user(), and the x86 clear_user() is slower than its copy_user():
> > https://lore.kernel.org/lkml/2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com/
> > 
> > But while we are still using the ZERO_PAGE, let's stop dirtying its
> > struct page cacheline with unnecessary get_page() and put_page().
> > 
> > Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> > Reported-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> I would have split the uptodate setting of ZERO_PAGE into a separate,
> clearly documented patch, but otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I've long wondered (for my own nefarious purposes) why tmpfs files
didn't just grab the zero page, so:

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

