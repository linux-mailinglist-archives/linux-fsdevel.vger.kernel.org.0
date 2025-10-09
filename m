Return-Path: <linux-fsdevel+bounces-63686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D707BCB088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F02148032E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F85283FCE;
	Thu,  9 Oct 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIA3cguL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804601A9FAE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047888; cv=none; b=U5Cy/YgV+XPItlokvzgRA5kM1xv/n+NVZ8KiYsSi082Ob5ZszCaN8c4aafaS6Cqcv4vGcmbvc27HC1lnpp0YRZw5CN62FapTqTFPYLuYc0Jyo4pynhPZf17PJiT66c/8MQsxeAki7ZD6OsY7wfNGLaMjtZjLiuZ6ZtVYSx18TLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047888; c=relaxed/simple;
	bh=MqqZUpeYZBMqSfPQ6qxQ5PVGV7REwBCnvVmc5BhqamI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNJjOCsUio19oiA7/g6ZtSiqM37ha+y8v78aW8yJsGU/2G9co/VsBs5KrYmtcgp/i4+2uMSV/+G9duSrFTo0e1o18KNyjGnBvAHmI9+ZN7JubYP+oUhS8FTRc2WWem1ffpDF9o77+qVqUuagQaPmqAzukyFsaFklE+9aLccE1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIA3cguL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e70609e042so3290391cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760047885; x=1760652685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LdKW+97zJau5CQgIDE2WBiem0spBT4DqjTGzbOcdBg=;
        b=jIA3cguLNfGD6+tWsWm/58z4jN8Og8tUHjIWA/G+9rhuDMHCVV/cLQpPz90RTvz0X8
         WgVn5BK/LfxdX3ZNiCgmyYignQWn5DdxjkKyG220GClFgDQaaqHNx2YsnKsa3NuSDsLn
         dw8eviodvStmSKR/FvjLW0XDgCmRSa0MYlRoHV8nXr0PCDAxOMGvTQR1z02BNdx34ft/
         kovA/ZJK1TJZVgRFTkunqz92XNfkRPNfbZ+1k/zJt40UEN19DUCK++QkmrvtV9w6mpo6
         pjuc1vqwNX4K4P5Uc5rIF8mAbZQEgiwtWa1Bfwkrov3Ce7jF0tnhErapiMNZbicjSbuN
         +0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047885; x=1760652685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LdKW+97zJau5CQgIDE2WBiem0spBT4DqjTGzbOcdBg=;
        b=pQyD1ShzbioRCHvCed9v0utWUKb2SkLXbzCTfEG9cykUb+fF6DorrHgthTz4noanx5
         7bIOCvcXpCBSb849D/Cb4DYwf8e+QnxEyqyUSabp9TRMyOZRNsPuMhAoa+spJYu0uAlv
         5F+/NwDqSjrn5SbUC82hX/TF6diZqvVM5CNu7TdVoWz9yJZgT0xATPOGfUNfM6BZfmOz
         x3eVdYtJFj6ZN9beP2SM4ZnUmD6v7L1iJYqrKZrCA8d0+zBKjBFo8kKLRlL5EXSrwqBO
         72h2qPy64Hvu+OMiipvsxydvlPoRdnToNsyXhfk8FsSa+RXrw46k5Uz0VtTRbFrxd+Ia
         cVOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdzoG60aM1ehbJPgKdWrLdQtx/ngbG5anVj6v/7tuFNE5/thmDMIdrrRDo0EBtE1Gj4PvB3jBp8C+lJenZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd9p9FGw8Bu3Ngq5XSHV3/lzEdcC9jHU3vQaSA5MlEjKaPm/T
	epS+K3F6kRegYdz4HVi1v2QB11zq2q3++A1Zdz+Qj6UOvbEMi5f1IyNVhjgkHM8BtFxpQCoxQUZ
	MGwVtZrOLf9Kh7DYhdznrAyMqyFrHG5s=
X-Gm-Gg: ASbGncu2QGMRaDmkgVS+5Nen6YNNSbE3eR9fl7OjENhGGo7rq9nRGkyVmAmRarwdMJ+
	q13wOMhKJWMw4GfMfo/pUv5GXr5uNklcf5U3pm85MEoIUHFgxYc2p3ArYKwsDi6l6psucxI+s6r
	yS3xyBOe/Wt45zPiCgx/jCEa2cWUCyIL8LyFqNFUY9YVEGkBGXLt/P2tjFCpBcuVE3Em3l1oG03
	YW7QX7yubsaUlILHyRtBW9dVhxi7KXHHhgAl5cCBHC7ihnlRnXqSK9uMMIaHsgWsC1Sa480ly/Y
	dm+yQxvK
X-Google-Smtp-Source: AGHT+IGcbY8Bh7krjq8EwlBLvFauQa8pByY3xiTpfvFw0r06RiRjXK13ug/KVQzQSyNfWzMu0BkEv9VuA04u8w5OKXM=
X-Received: by 2002:ac8:7f49:0:b0:4d6:173a:8729 with SMTP id
 d75a77b69052e-4e6eaccc88bmr123422781cf.10.1760047885327; Thu, 09 Oct 2025
 15:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
In-Reply-To: <20251009110623.3115511-1-giveme.gulu@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 9 Oct 2025 15:11:13 -0700
X-Gm-Features: AS18NWAYbFuwvCbuPMb0wo4vq0kp-E4e277WXBQ-3_-ui-3GP7chGs5RpZnm9Z8
Message-ID: <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: "guangming.zhao" <giveme.gulu@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:09=E2=80=AFAM guangming.zhao <giveme.gulu@gmail.co=
m> wrote:
>

Hi Guangming,

> The race occurs as follows:
> 1. A write operation locks a page, fills it with new data, marks it
>    Uptodate, and then immediately unlocks it within fuse_fill_write_pages=
().
> 2. This opens a window before the new data is sent to the userspace daemo=
n.
> 3. A concurrent read operation for the same page may decide to re-validat=
e
>    its cache from the daemon. The fuse_wait_on_page_writeback()
>    mechanism does not protect this synchronous writethrough path.
> 4. The read request can be processed by the multi-threaded daemon *before=
*
>    the write request, causing it to reply with stale data from its backen=
d.
> 5. The read syscall returns this stale data to userspace, causing data
>    verification to fail.

I don't think the issue is that the read returns stale data (the
client is responsible for synchronizing reads and writes, so if the
read is issued before the write has completed then it should be fine
that the read returned back stale data) but that the read will
populate the page cache with stale data (overwriting the write data in
the page cache), which makes later subsequent reads that are issued
after the write has completed return back stale data.

>
> This can be reliably reproduced on a mainline kernel (e.g., 6.1.x)
> using iogen and a standard multi-threaded libfuse passthrough filesystem.
>
> Steps to Reproduce:
> 1. Mount a libfuse passthrough filesystem (must be multi-threaded):
>    $ ./passthrough /path/to/mount_point
>
> 2. Run the iogen/doio test from LTP (Linux Test Project) with mixed
>    read/write operations (example):
>    $ /path/to/ltp/iogen -N iogen01 -i 120s -s read,write 500k:/path/to/mo=
unt_point/file1 | \
>      /path/to/ltp/doio -N iogen01 -a -v -n 2 -k
>
> 3. A data comparison error similar to the following will be reported:
>    *** DATA COMPARISON ERROR ***
>    check_file(/path/to/mount_point/file1, ...) failed
>    expected bytes:  X:3091346:gm-arco:doio*X:3091346
>    actual bytes:    91346:gm-arco:doio*C:3091346:gm-
>
> The fix is to delay unlocking the page until after the data has been
> successfully sent to the daemon. This is achieved by moving the unlock
> logic from fuse_fill_write_pages() to the completion path of
> fuse_send_write_pages(), ensuring the page lock is held for the entire
> critical section and serializing the operations correctly.
>
> [Note for maintainers]
> This patch is created and tested against the 5.15 kernel. I have observed
> that recent kernels have migrated to using folios, and I am not confident
> in porting this fix to the new folio-based code myself.
>
> I am submitting this patch to clearly document the race condition and a
> proven fix on an older kernel, in the hope that a developer more
> familiar with the folio conversion can adapt it for the mainline tree.
>
> Signed-off-by: guangming.zhao <giveme.gulu@gmail.com>
> ---
> [root@gm-arco example]# uname -a
> Linux gm-arco 6.16.8-arch3-1 #1 SMP PREEMPT_DYNAMIC Mon, 22 Sep 2025 22:0=
8:35 +0000 x86_64 GNU/Linux
> [root@gm-arco example]# ./passthrough /tmp/test/
> [root@gm-arco example]# mkdir /tmp/test/yy
> [root@gm-arco example]# /home/gm/code/ltp/testcases/kernel/fs/doio/iogen =
-N iogen01 -i 120s -s read,write 500b:/tmp/test/yy/kk1 1000b:/tmp/test/yy/k=
k2 | /home/gm/code/ltp/testcases/kernel/fs/doio/doio -N iogen01 -a -v -n 2 =
-k
>
> iogen(iogen01) starting up with the following:
>
> Out-pipe:              stdout
> Iterations:            120 seconds
> Seed:                  3091343
> Offset-Mode:           sequential
> Overlap Flag:          off
> Mintrans:              1           (1 blocks)
> Maxtrans:              131072      (256 blocks)
> O_RAW/O_SSD Multiple:  (Determined by device)
> Syscalls:              read write
> Aio completion types:  none
> Flags:                 buffered sync
>
> Test Files:
>
> Path                                          Length    iou   raw iou fil=
e
>                                               (bytes) (bytes) (bytes) typ=
e
> -------------------------------------------------------------------------=
----
> /tmp/test/yy/kk1                               256000       1     512 reg=
ular
> /tmp/test/yy/kk2                               512000       1     512 reg=
ular
>
> doio(iogen01) (3091346) 17:43:50
> ---------------------
> *** DATA COMPARISON ERROR ***
> check_file(/tmp/test/yy/kk2, 116844, 106653, X:3091346:gm-arco:doio*, 23,=
 0) failed
>
> Comparison fd is 3, with open flags 0
> Corrupt regions follow - unprintable chars are represented as '.'
> -----------------------------------------------------------------
> corrupt bytes starting at file offset 116844
>     1st 32 expected bytes:  X:3091346:gm-arco:doio*X:3091346
>     1st 32 actual bytes:    91346:gm-arco:doio*C:3091346:gm-
> Request number 13873
> syscall:  write(4, 02540107176414100, 106653)
>           fd 4 is file /tmp/test/yy/kk2 - open flags are 04010001
>           write done at file offset 116844 - pattern is X:3091346:gm-arco=
:doio*
>
> doio(iogen01) (3091344) 17:43:50
> ---------------------
> (parent) pid 3091346 exited because of data compare errors
>
>  fs/fuse/file.c | 36 ++++++++++--------------------------
>  1 file changed, 10 insertions(+), 26 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5c5ed58d9..a832c3122 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1098,7 +1098,6 @@ static ssize_t fuse_send_write_pages(struct fuse_io=
_args *ia,
>         struct fuse_file *ff =3D file->private_data;
>         struct fuse_mount *fm =3D ff->fm;
>         unsigned int offset, i;
> -       bool short_write;
>         int err;
>
>         for (i =3D 0; i < ap->num_pages; i++)
> @@ -1113,26 +1112,21 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
>         if (!err && ia->write.out.size > count)
>                 err =3D -EIO;
>
> -       short_write =3D ia->write.out.size < count;
>         offset =3D ap->descs[0].offset;
>         count =3D ia->write.out.size;
>         for (i =3D 0; i < ap->num_pages; i++) {
>                 struct page *page =3D ap->pages[i];
>
> -               if (err) {
> -                       ClearPageUptodate(page);
> -               } else {
> -                       if (count >=3D PAGE_SIZE - offset)
> -                               count -=3D PAGE_SIZE - offset;
> -                       else {
> -                               if (short_write)
> -                                       ClearPageUptodate(page);
> -                               count =3D 0;
> -                       }
> -                       offset =3D 0;
> -               }
> -               if (ia->write.page_locked && (i =3D=3D ap->num_pages - 1)=
)
> -                       unlock_page(page);
> +        if (!err && !offset && count >=3D PAGE_SIZE)
> +            SetPageUptodate(page);
> +
> +        if (count > PAGE_SIZE - offset)
> +            count -=3D PAGE_SIZE - offset;
> +        else
> +            count =3D 0;
> +        offset =3D 0;
> +
> +        unlock_page(page);
>                 put_page(page);
>         }
>
> @@ -1195,16 +1189,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_i=
o_args *ia,
>                 if (offset =3D=3D PAGE_SIZE)
>                         offset =3D 0;
>
> -               /* If we copied full page, mark it uptodate */
> -               if (tmp =3D=3D PAGE_SIZE)
> -                       SetPageUptodate(page);
> -
> -               if (PageUptodate(page)) {
> -                       unlock_page(page);
> -               } else {
> -                       ia->write.page_locked =3D true;
> -                       break;
> -               }

I think this will run into the deadlock described here
https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwh9Eu-gNHzqgfvUAAiO=3DvJ+pWnz=
xkv+tX55xhGPFy+cOw@mail.gmail.com/,
so I think we would need a different solution. Maybe one idea is doing
something similar to what the fi->writectr bias does - that at least
seems simpler to me than having to unlock all the pages in the array
if we have to fault in the iov iter and then having to relock the
pages while making sure everything is all consistent.

Thanks,
Joanne

>                 if (!fc->big_writes)
>                         break;
>         } while (iov_iter_count(ii) && count < fc->max_write &&
> --
> 2.51.0
>
>

