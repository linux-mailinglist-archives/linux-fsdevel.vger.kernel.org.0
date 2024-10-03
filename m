Return-Path: <linux-fsdevel+bounces-30856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D234098EE73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E129B23E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95877154458;
	Thu,  3 Oct 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9O8YLmC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308741487D5;
	Thu,  3 Oct 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956083; cv=none; b=BVIRBZRPTEOStQ3iNHDntY7rEndBmT9D0m2YHCdMitn+BRxd55jbJ/yO3zFYhx9BWl/i5z81AwH7f6pRaOIlmUyHllIPX34hRVx2SWKJ1NOydOj57eSZUrr+7xQQF3kcT6DIde9tfspUfveYatoIUlxTSosIyye3llXUgfJA8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956083; c=relaxed/simple;
	bh=679JULyQ0Lgk2IP/sOrpDLiKJg1kCsRdixf915ql8yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+0N4E7tILegFTLFLuJO7R029EZ3xOWFpePutfq39NgAREvF8HFYgftUZhWjbl0gCsObiqqBcr+5iu5Vw9IED60meSQwDXcJ5/w3nmcHk4u013UDI1MAnev8w4SpQxxa6kK2t8JNhvxLZLKqDbZ9wH3UMx41VGbUka3brGO/KHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9O8YLmC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so1100833e87.1;
        Thu, 03 Oct 2024 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956079; x=1728560879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUC85ZpiQ8kiNmmBVcA942s4Vwz+b8UvBsX7XvYIGVc=;
        b=j9O8YLmCQEZDMvRdrhHIFtiy01rqKbz0GnRfHOSC26aX78H7GYIBTXv9dOfLR+/qNd
         fOYzqNzTa2TIi/z1CF4qn9G6WHpFKR7ACDyT/ggso2F0JJEaprQwG7rx7dT4mPiNAg//
         vYZWz7p7FtUM/KHAMgvje2QNQNUNRmFNNy67n705ehCvQ6JV3RHEj7QgJ0VACctfT2Os
         qvHk4+Y8MLZTJZfr6vKniC0p82NKJIgO1m7NUzpBwh7uEMR9R0Df80jKWH7mlQ5j37Ow
         B31j/btZ2njT6lVOrdNMYmjLyFUtlgwnlHH6XuNd1QKdnbdAYVL6JhAMTYr4aUTe3gxB
         p7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956079; x=1728560879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUC85ZpiQ8kiNmmBVcA942s4Vwz+b8UvBsX7XvYIGVc=;
        b=rhCnmUVHRWksqTlvm8WLcgMbtza9qcjaMawB3t9frEzBJFF6MTtHZKTaieBGOaBbet
         DJeUFd313k6betq7QiqJZc50flsNfd9ObEtTn+swSYqUPQ3tvBZCAellslHwnwuwJ/xz
         o3JjR8qlsl5sf5vm0BLdzrAqK0rgW4kzlPCJEnfub5PpFRy36X3aNFn4WxTfU9nMXzEM
         srMnE24r5VXK0T6CwG0jUB/NFzyp2d2ZsnAK2wzD2xVohU06NLTEbbzBW8gKCDENwdSj
         R9MKM2XWrFh5VqhErj8qbWUTk3qqRHocYqg9Qm5E4d/Pi3RLXKF5b70bsJBlXEZsUF2D
         ae8w==
X-Forwarded-Encrypted: i=1; AJvYcCVTh2xS6jdSx1+zPCRHHvUDkdk7qrQA0zDjFDY2TkKe5qEoPBmK/9AD0cPcptTp3CeFvrAXYaXhItLCLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQpU0/cSPmPVu1u1pTz73jHXXMxYj+PcbzD6jvI5SXkzfA0QF
	ESfTtZ/gM4LZmnvOHv6+8hP07ST9aFOTugx2XLHBaFmvZhvH3YbjYca3QfAX7eT1SUtvOzaOPMx
	pIFlGNWzeqFHYZjpoVTfbmfxb54Y=
X-Google-Smtp-Source: AGHT+IElqELFO0VA7BIZxFa5YGNoDX7mRmi5A1CyRb8rWuHqNJrGzMnezbCPfoYfZ01B6tGXseDVH5GVVT/Ve9+UETQ=
X-Received: by 2002:a05:6512:e8c:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-539a065d3bbmr3802054e87.6.1727956079122; Thu, 03 Oct 2024
 04:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002150036.1339475-1-willy@infradead.org> <20241002150036.1339475-2-willy@infradead.org>
In-Reply-To: <20241002150036.1339475-2-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 3 Oct 2024 20:47:42 +0900
Message-ID: <CAKFNMonzrHj=o2LfPfR00+fvyVLV_Tojq1nSqwKw0MRVw7PD5Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] nilfs2: Remove nilfs_writepage
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:00=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Since nilfs2 has a ->writepages operation already, ->writepage is only
> called by the migration code.  If we add a ->migrate_folio operation,
> it won't even be used for that and so it can be deleted.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/inode.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
>
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index be6acf6e2bfc..f1b47b655672 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -170,37 +170,6 @@ static int nilfs_writepages(struct address_space *ma=
pping,
>         return err;
>  }
>
> -static int nilfs_writepage(struct page *page, struct writeback_control *=
wbc)
> -{
> -       struct folio *folio =3D page_folio(page);
> -       struct inode *inode =3D folio->mapping->host;
> -       int err;
> -
> -       if (sb_rdonly(inode->i_sb)) {
> -               /*
> -                * It means that filesystem was remounted in read-only
> -                * mode because of error or metadata corruption. But we
> -                * have dirty pages that try to be flushed in background.
> -                * So, here we simply discard this dirty page.
> -                */
> -               nilfs_clear_folio_dirty(folio);
> -               folio_unlock(folio);
> -               return -EROFS;
> -       }
> -
> -       folio_redirty_for_writepage(wbc, folio);
> -       folio_unlock(folio);
> -
> -       if (wbc->sync_mode =3D=3D WB_SYNC_ALL) {
> -               err =3D nilfs_construct_segment(inode->i_sb);
> -               if (unlikely(err))
> -                       return err;
> -       } else if (wbc->for_reclaim)
> -               nilfs_flush_segment(inode->i_sb, inode->i_ino);
> -
> -       return 0;
> -}
> -
>  static bool nilfs_dirty_folio(struct address_space *mapping,
>                 struct folio *folio)
>  {
> @@ -295,7 +264,6 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *=
iter)
>  }
>
>  const struct address_space_operations nilfs_aops =3D {
> -       .writepage              =3D nilfs_writepage,
>         .read_folio             =3D nilfs_read_folio,
>         .writepages             =3D nilfs_writepages,
>         .dirty_folio            =3D nilfs_dirty_folio,
> @@ -304,6 +272,7 @@ const struct address_space_operations nilfs_aops =3D =
{
>         .write_end              =3D nilfs_write_end,
>         .invalidate_folio       =3D block_invalidate_folio,
>         .direct_IO              =3D nilfs_direct_IO,
> +       .migrate_folio          =3D buffer_migrate_folio,
>         .is_partially_uptodate  =3D block_is_partially_uptodate,
>  };
>

After applying this patch, fsstress started causing kernel panics.

Looking at the patch, I realized that migrate_folio needs to use
buffer_migrate_folio_norefs, which checks for buffer head references.

I was able to eliminate the kernel panic by setting migrate_folio as follow=
s:

+ .migrate_folio =3D buffer_migrate_folio_norefs,

I would like to continue load testing to avoid side effects of reclaim
by completely eliminating nilfs_writepage (calling
nilfs_flush_segment). So far, no problems have occurred even in tests
with different block sizes or architectures, as long as I make the
above changes.

Thanks,
Ryusuke Konishi

