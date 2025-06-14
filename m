Return-Path: <linux-fsdevel+bounces-51664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DEDAD9C3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909723B55A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C523F403;
	Sat, 14 Jun 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a52VfmRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991919F480
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898334; cv=none; b=EbxAstE3mFPk3JZPO89olZSsh5xuoAeEuhunr3siIXn1m/AGF/ct9zrmRdRXQgornsW0y0OCqtbiwDzQlk/lP6GHCMl17v93H+7m1NSD6vIK8XRfxxy6CGhdB+Hq2E0OZpt2MCyZunCybJt495rff3om9KbTnUAyho6SPpSPoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898334; c=relaxed/simple;
	bh=14gwjrOeXtb8u0Cnaerb5nBPFIZpfFL9Y3UwWbfLZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KypN8Oop+VcFEDcP+63u6L456Ofvbf4+wV+4jfkqsnbha25xbk+sChtr9cms8GABA3bC61YjfQm9Re2UC4HANVmRw+CI4a1LUtzQ59BNvpt2IDYJ01NkO7+EPuzzbyWdu+AUS0RQUCa0LhBx1jqXR0FDTokr50rlHVuk76IWswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a52VfmRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749898331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWzYhD2/GR8ozkj47UTChqmR+8CXVFHGIsH6IPnyH6s=;
	b=a52VfmRb4PSnraVBlOa0QZdYXv2X65rq34FQYuGzvfhYgk929kDW+YEl5zV+9uXN68MSiT
	1LKGyPJKtSFdbITHMwy05s+YUdjDpMLypiY8CLRXZsdbDIyfpEe7yKtJahStzXj+i399BG
	v5+mLtxL/FQwlchXLSE6ezDdbHmTGoA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-fOY6FmpjPwOE4tGdTX91kA-1; Sat,
 14 Jun 2025 06:52:07 -0400
X-MC-Unique: fOY6FmpjPwOE4tGdTX91kA-1
X-Mimecast-MFC-AGG-ID: fOY6FmpjPwOE4tGdTX91kA_1749898326
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC6719560B7;
	Sat, 14 Jun 2025 10:52:06 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FE9530044CC;
	Sat, 14 Jun 2025 10:52:05 +0000 (UTC)
Date: Sat, 14 Jun 2025 06:55:40 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [BUG] fuse/virtiofs: kernel module build fail
Message-ID: <aE1VLOtagir-EyRM@bfoster>
References: <aEq4haEQScwHIWK6@bfoster>
 <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
 <aEwPNxjEaFtnmsuR@bfoster>
 <CAJnrk1ZOP60By0XozFy+6zXYzbkEznye6rGSet16-g-JQoGfTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZOP60By0XozFy+6zXYzbkEznye6rGSet16-g-JQoGfTw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jun 13, 2025 at 04:42:00PM -0700, Joanne Koong wrote:
> On Fri, Jun 13, 2025 at 4:41 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Thu, Jun 12, 2025 at 02:56:56PM -0700, Joanne Koong wrote:
> > > On Thu, Jun 12, 2025 at 4:19 AM Brian Foster <bfoster@redhat.com> wrote:
...
> 
> You didn't mess up the bisect, I was able to verify that it is that
> commit that causes the issue. I misunderstood the error message and
> thought it was complaining about alignment in a struct being broken
> somewhere.
> 
> This fixes the commit:
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct
> fuse_io_args *ia,
>  static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>                                      struct address_space *mapping,
>                                      struct iov_iter *ii, loff_t pos,
> -                                    unsigned int max_pages)
> +                                    unsigned int max_folios)
>  {
>         struct fuse_args_pages *ap = &ia->ap;
>         struct fuse_conn *fc = get_fuse_conn(mapping->host);
> @@ -1157,12 +1157,11 @@ static ssize_t fuse_fill_write_pages(struct
> fuse_io_args *ia,
>         int err = 0;
> 
>         num = min(iov_iter_count(ii), fc->max_write);
> -       num = min(num, max_pages << PAGE_SHIFT);
> 
>         ap->args.in_pages = true;
>         ap->descs[0].offset = offset;
> 
> -       while (num) {
> +       while (num && ap->num_folios < max_folios) {
>                 size_t tmp;
>                 struct folio *folio;
>                 pgoff_t index = pos >> PAGE_SHIFT;
> 
> 
> The bug is that I incorrectly assumed that I could use max_pages <<
> PAGE_SHIFT as the upper limit for how many bytes to copy in, but
> there's the possibility that the copy_folio_from_iter_atomic() call
> that we do can copy over bytes from the iov_iter that are less than
> the length of the folio, so using max_pages << PAGE_SHIFT as the bound
> for max_pages is wrong.
> 
> I ran the fix locally on top of origin/master (commit 27605c8c0) as
> well and verified that it fixes the issue. I'll send this fix
> upstream.
> 

Ah, great thanks. That makes sense.. I'll give it a try.

> Sorry for the inconvenience. Hope this bug didn't waste too much of
> your time. Thanks for reporting it.
> 

No worries at all, thanks for tracking it down!

Brian

> >
> > Brian
> >
> > > >
> > > > ... and ends up spitting out link time errors like this as of commit
> > > > 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):
> > > >
> > > > ...
> > > >   CC [M]  xfs.mod.o
> > > >   CC [M]  .module-common.o
> > > >   LD [M]  xfs.ko
> > > >   BTF [M] xfs.ko
> > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
> > > > error decoding cu i_mmap_rwsem
> > > > error decoding cu
> > > > ...
> > > > error decoding cu
> > > > pahole: xfs.ko: Invalid argument
> > > > make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko] Error 1
> > > > make[3]: *** Deleting file 'xfs.ko'
> > > > make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
> > > > make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
> > > > make[1]: Leaving directory '/root/repos/linux/fs/xfs'
> > > > make: *** [Makefile:248: __sub-make] Error 2
> > > >
> > > > ... or this on latest master:
> > > >
> > > > ...
> > > >   LD [M]  fs/xfs/xfs.o
> > > > fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 2145964924 for .rela.text
> > > > make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
> > > > make[4]: *** Deleting file 'fs/xfs/xfs.o'
> > > > make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
> > > > make[2]: *** [scripts/Makefile.build:554: fs] Error 2
> > > > make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
> > > > make: *** [Makefile:248: __sub-make] Error 2
> > > >
> > > > The latter failure is what I saw through most of a bisect so I suspect
> > > > one of the related followon commits alters the failure characteristic
> > > > from the former, but I've not confirmed that. Also note out of
> > > > convenience my test was to just recompile xfs.ko out of the same tree I
> > > > was bisecting from because the failures were consistent and seemed to be
> > > > a runtime kernel issue and not a source tree issue.
> > > >
> > > > I haven't had a chance to dig any further than this (and JFYI I'm
> > > > probably not going to be responsive through the rest of today). I just
> > > > completed the bisect and wanted to get it on list sooner rather than
> > > > later..
> > > >
> > > > Brian
> > > >
> > >
> >
> 


