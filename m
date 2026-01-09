Return-Path: <linux-fsdevel+bounces-73088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F12A7D0C107
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 20:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19EC30C3BE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE92E7650;
	Fri,  9 Jan 2026 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBWlQ1S8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D12DA759
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986588; cv=none; b=L6oItvnVKVm42eN9hsgR3ZYD6q2WRf2b9UfjPwbO7hpf6UiTcbuRfd2KnAFM1FoFtpe//1AB7CCHkrJqQqakSWDnHL2WsqIZq1S0mS/0HXb5tmgag/goUVozkmNq3bJgQZqATBmwBlisYkKWu9Mtm44Qx9fQprMlJLhG25LoKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986588; c=relaxed/simple;
	bh=hyhcrfWORTgCNDP6xiuZJwFfuxrQ4yrVaSNorHGwlzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8fm/PHFI0b0e8sM1FS4IWy6YX6/E2QTWlgvVKRnY1XnPI/QqBPRac3E5rjkd+jNIQFBW5GFhM1wmDsCYwTfADzN8MTtDbhR47VcRp75XCKLMytiWsxeYVMJFaUHGtT9CEZZpVp3He2ykyA1AneRRwkqdwcgbLGgZkGVsIMJ77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBWlQ1S8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso48703321cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767986585; x=1768591385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCCI6AH9kmfmVGOh8hpebLIabzKroctTdTDjM1D004k=;
        b=jBWlQ1S8cBG1UzByrB0YQoo7EAKE9ep69HgE26MIBQ6lWVcHeF5yUlnqiIexZlO+PW
         4PD4v1v3X03HNJdWVo5ptPERHRW+mLfDBlWlS1JdQW2IjrfHt7DIs7J5EOqmZEpwAUi6
         jSoFceN+dBaR1Yt0D6XcJbs+rlCASKLBqVuPjQ7NsSduglckml1FhDbqLJ0VSnF8tVeC
         arR4jP0g4mJrrT+qqIqrJ/2RLhiaLCJJ6LrieTizYoKLeUHSoZo3zL1mzlPC8e0jmtsx
         s/umIOJlJeyNgHxh+1KsWWCZ8ARmdhruWngtSFzcup3JTu5rZYBA+ZFQJ9gDuLcQIV/T
         31bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767986585; x=1768591385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XCCI6AH9kmfmVGOh8hpebLIabzKroctTdTDjM1D004k=;
        b=whyTmk0rjGvMcd2RMJfDtN6PM/9FwGf/kNi7nj2WtVVfJBhY7XcgZB2QMrX4Nn8QmF
         4Pq3pA3r70e2yaBTk16QTdZPcGo2ipiKxq525OHeXmL6R4Tzkw0r2Q4u2x0LT4SUOMGp
         jCZkwjHCqo7ibIEI5dzkin/tmgHUpWf5p1488S94L1IaLGdGmFeiADKMgy6Mr6WEzSnR
         iHXH14BFmjIygRneI3cEgny2R8Cr60f+iXqZqY6eL0AF0JdkOKPtzAzWkFYpaMFm4BmV
         Nel2KGfaiakmvlk+xsKN5cp9gaFx0Y3xkYjKuF03254+PdWCTz3f02w9RAbZMZpS7Czx
         MehA==
X-Forwarded-Encrypted: i=1; AJvYcCXFpTV9GJyWkBVXz0Pl+yMDG8PgxEZto6FBBbknpXBRGNtcNnx/OLhdFvkdU32jb0i4fJFpeyNtUDM7zuj+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1BO5P5RSA/k+9ioqDB7+EKc6fmJmHYJHHBgEO43azi7IqhSU
	d+aw31X9xIBUB3XcbGouDLAkD41unpUpmJkyAEYSaCvtODtBmLmOQrcICYWP43WizR4R2tg2OWK
	54xm8JQ8kkET+adtOZcwkManGID5SToY=
X-Gm-Gg: AY/fxX69cK9CHal+mQgtnx9YWVJKU02Wlqq5Lp9Za1fLlJ7baL0lnEioQ0W/Ktj32gs
	FVAQ0UUeUiobPzgTdzJgw3TbHEjgwllNDVGYQhNmkZVWc0z/jHIjr6ndcl1tzsxyLAaqRzqVQEb
	ayAMqtU/pc+94j/OgR8bNLwhA20pMTFR3krd82JvrISCygTpb+Zh4gilypNzCLDLIXZV5Rj1Cko
	e/3V/2+qI+Jbcy+3EgoNAMrDGGniiS+mX8rgw9HZ4p6os0Z/y+mFRjYgrd/LiJJx5g7kg==
X-Google-Smtp-Source: AGHT+IHXBBtwZwuNKfERTrjisYp/XnmieRQ5My9C+JrAHATrgCrXm7TflEfTXXV29gcs7jnr0aRwPcIqZnBnn30OGtI=
X-Received: by 2002:ac8:584b:0:b0:4ed:af7b:69cf with SMTP id
 d75a77b69052e-4ffb4891d94mr151346051cf.37.1767986584758; Fri, 09 Jan 2026
 11:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107153244.64703-1-john@groves.net> <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-14-john@groves.net>
In-Reply-To: <20260107153332.64727-14-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Jan 2026 11:22:54 -0800
X-Gm-Features: AQt7F2oIq_lbeLb-ti51MNdkm6hgKAY7P2Khn6XIMSk8J8fS6psInx9PeK2DpaQ
Message-ID: <CAJnrk1bJ3VbZCYJet1eDPy0V=_3cPxz6kDbgcxwtirk2yA9P0w@mail.gmail.com>
Subject: Re: [PATCH V3 13/21] famfs_fuse: Famfs mount opt: -o shadow=<shadowpath>
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:34=E2=80=AFAM John Groves <John@groves.net> wrote:
>
> The shadow path is a (usually in tmpfs) file system area used by the
> famfs user space to communicate with the famfs fuse server. There is a
> minor dilemma that the user space tools must be able to resolve from a
> mount point path to a shadow path. Passing in the 'shadow=3D<path>'
> argument at mount time causes the shadow path to be exposed via
> /proc/mounts, Solving this dilemma. The shadow path is not otherwise
> used in the kernel.

Instead of using mount options to pass the userspace metadata, could
/sys/fs be used instead? The client is able to get the connection id
by stat-ing the famfs mount path. There could be a
/sys/fs/fuse/connections/{id}/metadata file that the server fills out
with whatever metadata needs to be read by the client. Having
something like this would be useful to non-famfs servers as well.

>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h | 25 ++++++++++++++++++++++++-
>  fs/fuse/inode.c  | 28 +++++++++++++++++++++++++++-
>  2 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ec2446099010..84d0ee2a501d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -620,9 +620,11 @@ struct fuse_fs_context {
>         unsigned int blksize;
>         const char *subtype;
>
> -       /* DAX device, may be NULL */
> +       /* DAX device for virtiofs, may be NULL */
>         struct dax_device *dax_dev;
>
> +       const char *shadow; /* famfs - null if not famfs */
> +
>         /* fuse_dev pointer to fill in, should contain NULL on entry */
>         void **fudptr;
>  };
> @@ -998,6 +1000,18 @@ struct fuse_conn {
>                 /* Request timeout (in jiffies). 0 =3D no timeout */
>                 unsigned int req_timeout;
>         } timeout;
> +
> +       /*
> +        * This is a workaround until fuse uses iomap for reads.
> +        * For fuseblk servers, this represents the blocksize passed in a=
t
> +        * mount time and for regular fuse servers, this is equivalent to
> +        * inode->i_blkbits.
> +        */
> +       u8 blkbits;
> +

I think you meant to remove these lines?

> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       char *shadow;

Should this be const char * too?
> +#endif
>  };
>
>  /*
> @@ -1631,4 +1645,13 @@ extern void fuse_sysctl_unregister(void);
>  #define fuse_sysctl_unregister()       do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +/* famfs.c */
> +
> +static inline void famfs_teardown(struct fuse_conn *fc)
> +{
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       kfree(fc->shadow);
> +#endif
> +}
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index acabf92a11f8..2e0844aabbae 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -783,6 +783,9 @@ enum {
>         OPT_ALLOW_OTHER,
>         OPT_MAX_READ,
>         OPT_BLKSIZE,
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       OPT_SHADOW,
> +#endif
>         OPT_ERR
>  };
>
> @@ -797,6 +800,9 @@ static const struct fs_parameter_spec fuse_fs_paramet=
ers[] =3D {
>         fsparam_u32     ("max_read",            OPT_MAX_READ),
>         fsparam_u32     ("blksize",             OPT_BLKSIZE),
>         fsparam_string  ("subtype",             OPT_SUBTYPE),
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       fsparam_string("shadow",                OPT_SHADOW),

nit: having the spacing for ("shadow", align with the lines above
would be aesthetically nice

> +#endif
>         {}
>  };
>
> @@ -892,6 +898,15 @@ static int fuse_parse_param(struct fs_context *fsc, =
struct fs_parameter *param)
>                 ctx->blksize =3D result.uint_32;
>                 break;
>
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       case OPT_SHADOW:
> +               if (ctx->shadow)
> +                       return invalfc(fsc, "Multiple shadows specified")=
;
> +               ctx->shadow =3D param->string;
> +               param->string =3D NULL;
> +               break;
> +#endif
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -905,6 +920,7 @@ static void fuse_free_fsc(struct fs_context *fsc)
>
>         if (ctx) {
>                 kfree(ctx->subtype);
> +               kfree(ctx->shadow);
>                 kfree(ctx);
>         }
>  }
> @@ -936,7 +952,10 @@ static int fuse_show_options(struct seq_file *m, str=
uct dentry *root)
>         else if (fc->dax_mode =3D=3D FUSE_DAX_INODE_USER)
>                 seq_puts(m, ",dax=3Dinode");
>  #endif
> -
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       if (fc->shadow)
> +               seq_printf(m, ",shadow=3D%s", fc->shadow);
> +#endif
>         return 0;
>  }
>
> @@ -1041,6 +1060,8 @@ void fuse_conn_put(struct fuse_conn *fc)
>                 WARN_ON(atomic_read(&bucket->count) !=3D 1);
>                 kfree(bucket);
>         }
> +       famfs_teardown(fc);

imo it looks a bit cleaner with

if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
     famfs_teardown(fc);

which also matches the pattern the passthrough config below uses

> +
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_backing_files_free(fc);
>         call_rcu(&fc->rcu, delayed_release);
> @@ -1916,6 +1937,11 @@ int fuse_fill_super_common(struct super_block *sb,=
 struct fuse_fs_context *ctx)
>                 *ctx->fudptr =3D fud;
>                 wake_up_all(&fuse_dev_waitq);
>         }
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +       fc->shadow =3D kstrdup(ctx->shadow, GFP_KERNEL);

Is a shadow path a must-have for a famfs mount? if so, then should the
mount fail if the allocation here fails?

Thanks,
Joanne
> +#endif
> +
>         mutex_unlock(&fuse_mutex);
>         return 0;
>
> --
> 2.49.0
>

