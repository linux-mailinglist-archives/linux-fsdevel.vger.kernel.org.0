Return-Path: <linux-fsdevel+bounces-26703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F3995B279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A24C281F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0C17B4EC;
	Thu, 22 Aug 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jL3jNWRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A11CF8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320720; cv=none; b=qQ/u0I6rfxCtis54k/yQHbPD5359gpkywZsluU6TavzfuREJT08OzSj6veJepJQRLWOXj/mR8lczgEIA1g8FQ2pjeo1rGw57CwEbd/kjcQzgTd0FfbNgfT/L1BD6z8WW/Td9IBtBiONEhu+srsIqNNMhKKRtPOlKGG5szkpd/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320720; c=relaxed/simple;
	bh=50AcvFP/dKvjehJ4VbdySJ1rkwRAjSt2ld/cePdn1Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhqMIBBQ5XGj7EaoEykPGQyHOGW7WlQrGJ1BzE8HoVbedFy13chyUAXoLIG8WIIB8homx9F+HBNtl3nK0Ef7svSgPgDmstc49rcnEGKFAbbfaf+2TkGynwqGDRMdUo/xEr51wNuBFWJjfz2O0T3cMqo/eKJw0GgyJ5b37MlgMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jL3jNWRe; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so635921276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724320718; x=1724925518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKUAhsCvvZcXbo7ND7fwsh9PHN8viGomUNBGSlHzOqI=;
        b=jL3jNWRe6sHjLN2uoH/Z41kpFw/g8Jpcq43y/42IetRlwjK7N+6EgyFf5QqfwcLqGs
         0V5evTfMqK3PJCSunHE3wk+A0mpwlFbKdByqDRDP9fptSVhWG4iQaaf0Mc2b45MgZkbC
         1i+pppxQLmmIiHAk7z1ePlXU3tVI+e79FJS+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320718; x=1724925518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKUAhsCvvZcXbo7ND7fwsh9PHN8viGomUNBGSlHzOqI=;
        b=nXOmxuRdpdkPEmcNDxgFKhqDMtl4DOGcFruyWjQneZli5/P+L/z41sRIDDVuRCy6xQ
         MS8V/a0NpByKwBonYag2sc70GZfYQDG5sfjaTAqVRfAAZmRIFPEgWIjqF832704QxZ15
         fgIaqq96P3XgU5wk5Z66l9NHFwAeYKGoY3wu6ZACI4CJGH1QBReaSISLnd83oUIyWaEU
         5bid0Xk0kbCndgu5OGBHcs433HOliKC+muKWgqiqkviTu6/3L7hZalB0SJnds4H3l2P2
         w6Djo9Y6HQCuQyW+JMG4Eu8dHQ8mFQLQHf1811AGj4smHzHdN6S8ThtP28KbcXnjZQXy
         0qvQ==
X-Gm-Message-State: AOJu0YzvJ/WIW19qztDa5etX+lQBQ9Z+G+AQVEttZjdYzF39UQ2CZ74w
	5whby/KFHsnk7k2jvb0ZH7NZ93T+BHD3WTSNw68FpjZg7gB7W+RvnjNjwHLsPjR3CyewEPDQW9Y
	63LTen6ga+mxZOhrNlKU/IlWbXWyLmL9cRzmJn3XlyTCc+OzDHeI=
X-Google-Smtp-Source: AGHT+IFqvRvfyYHgi38CCbk+rVO/dKvvHFdwCAWxM3d3C1KpBwMD93KR3djN4kz9EnZjd6c7naDLn/P41z/+PzJ5Jc0=
X-Received: by 2002:a25:9744:0:b0:e16:680f:a67a with SMTP id
 3f1490d57ef6-e16680fb01amr4447839276.42.1724320717986; Thu, 22 Aug 2024
 02:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821232241.3573997-1-joannelkoong@gmail.com> <20240821232241.3573997-9-joannelkoong@gmail.com>
In-Reply-To: <20240821232241.3573997-9-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 11:58:25 +0200
Message-ID: <CAJfpegt6eZrXC6PAa8dvb6duPSTxhSOm3_JzXjzB6hzOnw6z9A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] fuse: refactor out shared logic in
 fuse_writepages_fill() and fuse_writepage_locked()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 01:25, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This change refactors the shared logic in fuse_writepages_fill() and
> fuse_writepages_locked() into two separate helper functions,
> fuse_writepage_args_page_fill() and fuse_writepage_args_setup().
>
> No functional changes added.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 102 +++++++++++++++++++++++++++----------------------
>  1 file changed, 57 insertions(+), 45 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 812b3d043b26..fe8ae19587fb 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1936,7 +1936,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
>
>                 wpa->next = next->next;
>                 next->next = NULL;
> -               next->ia.ff = fuse_file_get(wpa->ia.ff);
>                 tree_insert(&fi->writepages, next);
>
>                 /*
> @@ -2049,50 +2048,78 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
>         rcu_read_unlock();
>  }
>
> +static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
> +                                         struct folio *tmp_folio, uint32_t page_index)
> +{
> +       struct inode *inode = folio->mapping->host;
> +       struct fuse_args_pages *ap = &wpa->ia.ap;
> +
> +       folio_copy(tmp_folio, folio);
> +
> +       ap->pages[page_index] = &tmp_folio->page;
> +       ap->descs[page_index].offset = 0;
> +       ap->descs[page_index].length = PAGE_SIZE;
> +
> +       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> +       inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
> +}
> +
> +static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
> +                                                            struct fuse_file *ff)
> +{
> +       struct inode *inode = folio->mapping->host;
> +       struct fuse_conn *fc = get_fuse_conn(inode);
> +       struct fuse_writepage_args *wpa;
> +       struct fuse_args_pages *ap;
> +
> +       wpa = fuse_writepage_args_alloc();
> +       if (!wpa)
> +              return NULL;
> +
> +       fuse_writepage_add_to_bucket(fc, wpa);
> +       fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
> +       wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
> +       wpa->inode = inode;
> +       wpa->ia.ff = ff;
> +
> +       ap = &wpa->ia.ap;
> +       ap->args.in_pages = true;
> +       ap->args.end = fuse_writepage_end;
> +
> +       return wpa;
> +}
> +
>  static int fuse_writepage_locked(struct folio *folio)
>  {
>         struct address_space *mapping = folio->mapping;
>         struct inode *inode = mapping->host;
> -       struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_inode *fi = get_fuse_inode(inode);
>         struct fuse_writepage_args *wpa;
>         struct fuse_args_pages *ap;
>         struct folio *tmp_folio;
> +       struct fuse_file *ff;
>         int error = -ENOMEM;
>
> -       wpa = fuse_writepage_args_alloc();
> -       if (!wpa)
> -               goto err;
> -
>         tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
>         if (!tmp_folio)
> -               goto err_free;
> +               goto err;
>
>         error = -EIO;
> -       wpa->ia.ff = fuse_write_file_get(fi);
> -       if (!wpa->ia.ff)
> +       ff = fuse_write_file_get(fi);
> +       if (!ff)
>                 goto err_nofile;
>
> -       fuse_writepage_add_to_bucket(fc, wpa);
> -       fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0);
> -
> -       wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
> -       wpa->next = NULL;
> -       wpa->inode = inode;
> +       wpa = fuse_writepage_args_setup(folio, ff);
> +       if (!wpa) {
> +               error = -ENOMEM;
> +               goto err_writepage_args;
> +       }

Please use the following pattern, unless there's a good reason not to:

+       error = -ENOMEM;
+       if (!wpa)
+               goto err_writepage_args;

