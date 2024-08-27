Return-Path: <linux-fsdevel+bounces-27461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172839619DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC5BB22AB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8222476056;
	Tue, 27 Aug 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHlDXKBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BE3C08A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796320; cv=none; b=a93Mo3UQu/no9uTilMsQEbP9jEsrxmSiThHLYahNkS91Wg+PfDhCjls0hp5DZarOURRoBivM+l9fgEAJfylimQUm9quXFxrJF+WiEFRyGtwi7a67TVzEXBZdEtvNfso5rXaQ54HRjm7uJ7o7qK74n+7alkB7YTY9/tFhBi+F8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796320; c=relaxed/simple;
	bh=F2cgUEVt+DPcHVQ0WkUxLONfa3Q2rVbxTf572CVL0L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT0PbwRr6sftJvlQVn6fXoasouMacuEYb3RgsynzyAKOjLSwpL/0K+oyhIwyzOCElss4aHiGPs3ng0lA1KTZ+hg6xr8Q7dWzVCQ4V7sEGDFSZnIRerhocOPYXt3fTIG/NwlPfDuMclx0xM2jnSkqWtpGTVO419lBlTeSTmEsTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHlDXKBI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fe9aa3bfaso34311411cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724796317; x=1725401117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe+bZChRTGfUmn2BOMTA5Z78PNTKA39bN1b8LK4SJdY=;
        b=cHlDXKBID2wacp0/e10DE9rMKFMP7Stj9yRqJa6Tx6e1g7+tKHY9y54rfKtl7HPKXe
         xrSw+K6fHBgrf3/U2J0Lyk3O22LLeIGld4oTszUJ8E//jXGWMXb3MpELrA+3YPuIudTA
         YZaf2MwbDJuUgj1TNSdw5Frc3NygJy9FkeBSx0F8ZAZC9oo5s1gwuMQ6Ri5inPeMU7uE
         SgHi4yXgZbAlRCXUqsD12JgPJ2vtwWosP7mO7i/gMseqjuf5RUKI2L8DcWBD4SCgJS4R
         7qmt0+xOIhfdyRImikcVeKn8hrmUWg6u3WrPTzsmK4SRD7bTG4Fi+wk230t8fTooeJjO
         dzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724796317; x=1725401117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe+bZChRTGfUmn2BOMTA5Z78PNTKA39bN1b8LK4SJdY=;
        b=xPy4s0lfow4dKkob4igX5i8JArpukph0uNBIHM5CyKkRI7utpPpLB5Eqq0ZHGAfBp9
         bShcF/Hz2bVUsuDXykSaOXpf3g7lkg0FhqTT185dlU/RcEIhcr0jaKghhYGODTitBtpE
         AWhvotHzz/pcPZn2Oy2oKi5imoRnlePZsDKfUoyKB/lBZCO1TKof0sSK6v6f6wD6Y1qq
         VyXAjnX1NsxJrfhUVc1UYtVhU4Msuk/V7Nb38Oc+nMmejF8iVxmKhkJfFm4efYnedCHR
         P5sDkFYsDMUIY5LBcwd/s7+DNbc886AVfYhv9/4UTrWmQgYq/coHpEnoGdu3rft2vyal
         Tj3A==
X-Gm-Message-State: AOJu0Yxf8Xe5Z7tShCXRhQtAGk1RmuDHSpo6p8bOfQ7SQas8WMLfyL71
	bUZBSRvvY7M9KGbZXNkEogF300yyTUNh3DCvkPnPneCTGRvsuGawO74boK8p6rdsxn3qNLHYTXS
	FG2y//TYg5AJ5j+ep4YbE4ml4Wx0=
X-Google-Smtp-Source: AGHT+IGVooWfxGRSdHpJFRktNGKbK2QOGd4P6p7Etc5fxXpF4eN23jqW8UygOagpOhGQV5myeOA+LeyjoMVW6nvbOUk=
X-Received: by 2002:a05:622a:4a1b:b0:440:536a:5915 with SMTP id
 d75a77b69052e-455096ce45emr186491541cf.30.1724796317201; Tue, 27 Aug 2024
 15:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724791233.git.josef@toxicpanda.com> <d3cc890dfeefcd79d0217c7f1aab7debe604b395.1724791233.git.josef@toxicpanda.com>
In-Reply-To: <d3cc890dfeefcd79d0217c7f1aab7debe604b395.1724791233.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Aug 2024 15:05:06 -0700
Message-ID: <CAJnrk1au0FGiGu3Nea7M+jstTgPOns5Tg7iDhzyGNrPerUbfQg@mail.gmail.com>
Subject: Re: [PATCH 09/11] fuse: use the folio based vmstat helpers
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	bschubert@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> In order to make it easier to switch to folios in the fuse_args_pages
> update the places where we update the vmstat counters for writeback to
> use the folio related helpers.  On the inc side this is easy as we
> already have the folio, on the dec side we have to page_folio() the
> pages for now.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

LGTM.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3ef6c2f58940..e03b915d8229 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1853,12 +1853,12 @@ static void fuse_writepage_free(struct fuse_write=
page_args *wpa)
>         kfree(wpa);
>  }
>
> -static void fuse_writepage_finish_stat(struct inode *inode, struct page =
*page)
> +static void fuse_writepage_finish_stat(struct inode *inode, struct folio=
 *folio)
>  {
>         struct backing_dev_info *bdi =3D inode_to_bdi(inode);
>
>         dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> -       dec_node_page_state(page, NR_WRITEBACK_TEMP);
> +       node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
>         wb_writeout_inc(&bdi->wb);
>  }
>
> @@ -1870,7 +1870,7 @@ static void fuse_writepage_finish(struct fuse_write=
page_args *wpa)
>         int i;
>
>         for (i =3D 0; i < ap->num_pages; i++)
> -               fuse_writepage_finish_stat(inode, ap->pages[i]);
> +               fuse_writepage_finish_stat(inode, page_folio(ap->pages[i]=
));
>
>         wake_up(&fi->page_waitq);
>  }
> @@ -1925,7 +1925,8 @@ __acquires(fi->lock)
>         for (aux =3D wpa->next; aux; aux =3D next) {
>                 next =3D aux->next;
>                 aux->next =3D NULL;
> -               fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0=
]);
> +               fuse_writepage_finish_stat(aux->inode,
> +                                          page_folio(aux->ia.ap.pages[0]=
));
>                 fuse_writepage_free(aux);
>         }
>
> @@ -2145,7 +2146,7 @@ static void fuse_writepage_args_page_fill(struct fu=
se_writepage_args *wpa, struc
>         ap->descs[page_index].length =3D PAGE_SIZE;
>
>         inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> -       inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
> +       node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
>  }
>
>  static struct fuse_writepage_args *fuse_writepage_args_setup(struct foli=
o *folio,
> @@ -2319,7 +2320,8 @@ static bool fuse_writepage_add(struct fuse_writepag=
e_args *new_wpa,
>         spin_unlock(&fi->lock);
>
>         if (tmp) {
> -               fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[=
0]);
> +               fuse_writepage_finish_stat(new_wpa->inode,
> +                                          page_folio(new_ap->pages[0]));
>                 fuse_writepage_free(new_wpa);
>         }
>
> --
> 2.43.0
>

