Return-Path: <linux-fsdevel+bounces-18521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95698BA184
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DE3B221B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AA181304;
	Thu,  2 May 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5/DmK7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8601802AC
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681438; cv=none; b=F/3O6oM6r0QfIP8aKCyUarPAbioJQ12GvZeTwKNsBfOAbbcV4YV1iNn3R4om5mhFW6OGg2fJsQVJ4eL3tDosbNSPu7ubQXE7wYHx/DzCUkhbcoFioRC06IhmnrDjkg3zpPw36Lt9zE2RYGP5tJdyzDCdgqa9+cqyWCmkRU6QpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681438; c=relaxed/simple;
	bh=BXDra/jVgkX/2Wvgok5nvfrciP+Q1+Pafbzt7wBxwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNquB/r+ApSG728luppfuQKKONSl0EJdWFS4Vv+WZfXiJRjUp2I5N8XiQnaBsVNzuqmec20u1UBUk3XFQUgba8o1Zcf/Haizfof1ChHlW64SFtv3J5eU4V8AhrFuk8gFlmkWok84HWBCop0sXtlW5j1TJ6qtX4EaB29+MI2QF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5/DmK7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714681435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LHgLDkP4yyBOdFGKu9OPn6OdCvVVqlRZUjx/Ngp+3Q=;
	b=h5/DmK7/G2hE5I5w96H8KLCK1ZRnIpI1nSMmJHDe375gYuSNkwQ12+0KY5+GXnOFYpykgl
	PHFHK/8s+3wL/J971Vn+PoPgOJySeFbwehHgfeAVH3g4v4Two4h8CoW69cqnqUhGYCoH6K
	jVqpJ1YIO6VtNALuH6uoewcNKYRbRME=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-2lkm_RTwP5WOzboKkTEAsw-1; Thu, 02 May 2024 16:23:54 -0400
X-MC-Unique: 2lkm_RTwP5WOzboKkTEAsw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e4c75eb382so91202645ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 13:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714681433; x=1715286233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LHgLDkP4yyBOdFGKu9OPn6OdCvVVqlRZUjx/Ngp+3Q=;
        b=ZljGC+TxTRdG7RmQ7fWurqfzRTabgFVkIxzf2aOe2dIdxNHkOylBsFiSmA3ZY99RUw
         ooJiwPuxPw0yN/1qqZXt65mwPPkRsSwKesgAqE/9VmsDls0PLb+XuzPC9KwAxD3/FnYG
         2mb4vjtw11S7TQspw10xMDDUIIzB86QtkX6NbuBX+Xy6SSdq9le1SsTVpISU50JBnSvl
         5cTzQgSzJP7v7TWwzRAlym0dnq8rDEMLWs6eGwwylvSsyY7aVlVUxBYFAW0gJX0uoYl4
         AXGmufMdyaBKGtb8DNqQJh4lJN5zV5SRii/SJWLk1D3Dqf/Psdxs6ZvB4ArLFhK8403l
         gPkg==
X-Gm-Message-State: AOJu0Yz0dT0rJbIN2IBu3CMarrgEbDT4QkuPXltyQLjrWgYX5IdsUWZu
	OXhJqurm5sJRRM/q0E5t7BZQlWkE4YeKLP+0dEPr1cYKYiX/MP/1iC4NHhrzpKtPbp+ObBX3EMl
	5OxnWgH0FnXrA/5Kw8PF7ExeMXtcgA9T+j5a5U64u7IX7baiEWM4F2reBqeLEhJbD7tkVPH+k/s
	cHKlMjEH7iEgGvPY/JLJPEfzHS+IOgavnTbm7Yfasu/p4+W33j
X-Received: by 2002:a17:902:e949:b0:1eb:1fdc:25e7 with SMTP id b9-20020a170902e94900b001eb1fdc25e7mr954276pll.19.1714681433032;
        Thu, 02 May 2024 13:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8E/K6oNgeR6xvb4tN8UeT/4XbrG+/hAf2murt0FLIlcGML5nHLvdF4Kp5fdkbpj47wX1da+qYbWspmQY//jo=
X-Received: by 2002:a17:902:e949:b0:1eb:1fdc:25e7 with SMTP id
 b9-20020a170902e94900b001eb1fdc25e7mr954258pll.19.1714681432632; Thu, 02 May
 2024 13:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403172400.1449213-1-willy@infradead.org> <20240403172400.1449213-3-willy@infradead.org>
In-Reply-To: <20240403172400.1449213-3-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 May 2024 22:23:41 +0200
Message-ID: <CAHc6FU6gdBq5+GYqcxUEfvypTokAsoGWSEt19jJUyBpVXW5myw@mail.gmail.com>
Subject: Re: [PATCH 2/4] gfs2: Add a migrate_folio operation for journalled files
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:24=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> For journalled data, folio migration currently works by writing the folio
> back, freeing the folio and faulting the new folio back in.  We can
> bypass that by telling the migration code to migrate the buffer_heads
> attached to our folios.

This part sounds reasonable, but I disagree with the following assertion:

> That lets us delete gfs2_jdata_writepage() as it has no more callers.

The reason is that the log flush code calls gfs2_jdata_writepage()
indirectly via mapping->a_ops->writepage. So with this patch, we end
up with a bunch of Oopses.

Do you want to resend, or should I back out the gfs2_jdata_writepage
removal and add the remaining one-liner?

Thanks,
Andreas


> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 974aca9c8ea8..68fc8af14700 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -116,8 +116,7 @@ static int gfs2_write_jdata_folio(struct folio *folio=
,
>   * @folio: The folio to write
>   * @wbc: The writeback control
>   *
> - * This is shared between writepage and writepages and implements the
> - * core of the writepage operation. If a transaction is required then
> + * Implements the core of write back. If a transaction is required then
>   * the checked flag will have been set and the transaction will have
>   * already been started before this is called.
>   */
> @@ -139,35 +138,6 @@ static int __gfs2_jdata_write_folio(struct folio *fo=
lio,
>         return gfs2_write_jdata_folio(folio, wbc);
>  }
>
> -/**
> - * gfs2_jdata_writepage - Write complete page
> - * @page: Page to write
> - * @wbc: The writeback control
> - *
> - * Returns: errno
> - *
> - */
> -
> -static int gfs2_jdata_writepage(struct page *page, struct writeback_cont=
rol *wbc)
> -{
> -       struct folio *folio =3D page_folio(page);
> -       struct inode *inode =3D page->mapping->host;
> -       struct gfs2_inode *ip =3D GFS2_I(inode);
> -       struct gfs2_sbd *sdp =3D GFS2_SB(inode);
> -
> -       if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state =3D=3D LM_ST_EXC=
LUSIVE))
> -               goto out;
> -       if (folio_test_checked(folio) || current->journal_info)
> -               goto out_ignore;
> -       return __gfs2_jdata_write_folio(folio, wbc);
> -
> -out_ignore:
> -       folio_redirty_for_writepage(wbc, folio);
> -out:
> -       folio_unlock(folio);
> -       return 0;
> -}
> -
>  /**
>   * gfs2_writepages - Write a bunch of dirty pages back to disk
>   * @mapping: The mapping to write
> @@ -749,12 +719,12 @@ static const struct address_space_operations gfs2_a=
ops =3D {
>  };
>
>  static const struct address_space_operations gfs2_jdata_aops =3D {
> -       .writepage =3D gfs2_jdata_writepage,
>         .writepages =3D gfs2_jdata_writepages,
>         .read_folio =3D gfs2_read_folio,
>         .readahead =3D gfs2_readahead,
>         .dirty_folio =3D jdata_dirty_folio,
>         .bmap =3D gfs2_bmap,
> +       .migrate_folio =3D buffer_migrate_folio,
>         .invalidate_folio =3D gfs2_invalidate_folio,
>         .release_folio =3D gfs2_release_folio,
>         .is_partially_uptodate =3D block_is_partially_uptodate,
> --
> 2.43.0
>


