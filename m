Return-Path: <linux-fsdevel+bounces-5911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B2811600
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E41F21B37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA031726;
	Wed, 13 Dec 2023 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn6rKtS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880C30D16;
	Wed, 13 Dec 2023 15:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162BDC433C8;
	Wed, 13 Dec 2023 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702480779;
	bh=pMtUBj05O3xnZhF2ttw0Mf4amdHOwRt7CuvwhZpH3fQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vn6rKtS7/KfSV5+0DYrZqGoz6ey4lzaNe32sk/UuXK0msaGnc5XmzC8l9tA9+o/Qa
	 VJ1ivSpYqLFt2TYZDIfSUOI0Q9eHjP3S2+AIafkRN9QDkO3cy9slP4Rlbf9uYoUzo/
	 6povymLP+sbrplx8ePyv1OLIJA7z7ODeZ5oLel/W6C3MMqcR4OQpEHc56uAqWFMCWf
	 VCXsJxjgd4SQOONIO92fIXVXXLWm8vBl3mpnjeQ+4q1JCoA3ROzy2ZGH4Ekno76ds9
	 YJAUmrVzlWR8XXsaY8aSc8HlxRfeK5iY+oSkj7Jr8HP1sPR+xhwBURTxE2Wzliuqa0
	 o81ff4WsakQNQ==
Message-ID: <3bf4a5126f84b56a28dbc5e8e643b24945578bbd.camel@kernel.org>
Subject: Re: [PATCH v3 04/59] netfs, fscache: Move /proc/fs/fscache to
 /proc/fs/netfs and put in a symlink
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Christian Brauner
 <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Dec 2023 10:19:35 -0500
In-Reply-To: <20231207212206.1379128-5-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
	 <20231207212206.1379128-5-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 21:21 +0000, David Howells wrote:
> Rename /proc/fs/fscache to "netfs" and make a symlink from fscache to tha=
t.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Christian Brauner <christian@brauner.io>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-cachefs@redhat.com
> ---
>  fs/netfs/fscache_main.c  |  8 ++------
>  fs/netfs/fscache_proc.c  | 23 ++++++++---------------
>  fs/netfs/fscache_stats.c |  4 +---
>  fs/netfs/internal.h      | 12 +++++++++++-
>  fs/netfs/main.c          | 34 ++++++++++++++++++++++++++++++++++
>  fs/netfs/stats.c         | 13 +++++++------
>  include/linux/netfs.h    |  1 -
>  7 files changed, 63 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
> index 00600a4d9ce5..42e98bb523e3 100644
> --- a/fs/netfs/fscache_main.c
> +++ b/fs/netfs/fscache_main.c
> @@ -62,7 +62,7 @@ unsigned int fscache_hash(unsigned int salt, const void=
 *data, size_t len)
>  /*
>   * initialise the fs caching module
>   */
> -static int __init fscache_init(void)
> +int __init fscache_init(void)
>  {
>  int ret =3D -ENOMEM;
> =20
> @@ -94,12 +94,10 @@ static int __init fscache_init(void)
>  return ret;
>  }
> =20
> -fs_initcall(fscache_init);
> -
>  /*
>   * clean up on module removal
>   */
> -static void __exit fscache_exit(void)
> +void __exit fscache_exit(void)
>  {
>  _enter("");
> =20
> @@ -108,5 +106,3 @@ static void __exit fscache_exit(void)
>  destroy_workqueue(fscache_wq);
>  pr_notice("FS-Cache unloaded\n");
>  }
> -
> -module_exit(fscache_exit);
> diff --git a/fs/netfs/fscache_proc.c b/fs/netfs/fscache_proc.c
> index dc3b0e9c8cce..ecd0d1edafaa 100644
> --- a/fs/netfs/fscache_proc.c
> +++ b/fs/netfs/fscache_proc.c
> @@ -12,41 +12,34 @@
>  #include "internal.h"
> =20
>  /*
> - * initialise the /proc/fs/fscache/ directory
> + * Add files to /proc/fs/netfs/.
>   */
>  int __init fscache_proc_init(void)
>  {
> - if (!proc_mkdir("fs/fscache", NULL))
> - goto error_dir;
> + if (!proc_symlink("fs/fscache", NULL, "../netfs"))
> + goto error_sym;
> =20

   1. Are there known userland tools that rely on this path? I suppose
      this is harmless either way though, and /proc is supposedly part
      of the ABI.

> - if (!proc_create_seq("fs/fscache/caches", S_IFREG | 0444, NULL,
> + if (!proc_create_seq("fs/netfs/caches", S_IFREG | 0444, NULL,
>  &fscache_caches_seq_ops))
>  goto error;
> =20
> - if (!proc_create_seq("fs/fscache/volumes", S_IFREG | 0444, NULL,
> + if (!proc_create_seq("fs/netfs/volumes", S_IFREG | 0444, NULL,
>  &fscache_volumes_seq_ops))
>  goto error;
> =20
> - if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
> + if (!proc_create_seq("fs/netfs/cookies", S_IFREG | 0444, NULL,
>  &fscache_cookies_seq_ops))
>  goto error;
> -
> -#ifdef CONFIG_FSCACHE_STATS
> - if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
> - fscache_stats_show))
> - goto error;
> -#endif
> -
>  return 0;
> =20
>  error:
>  remove_proc_entry("fs/fscache", NULL);
> -error_dir:
> +error_sym:
>  return -ENOMEM;
>  }
> =20
>  /*
> - * clean up the /proc/fs/fscache/ directory
> + * Clean up the /proc/fs/fscache symlink.
>   */
>  void fscache_proc_cleanup(void)
>  {
> diff --git a/fs/netfs/fscache_stats.c b/fs/netfs/fscache_stats.c
> index fc94e5e79f1c..aad812ead398 100644
> --- a/fs/netfs/fscache_stats.c
> +++ b/fs/netfs/fscache_stats.c
> @@ -52,7 +52,7 @@ EXPORT_SYMBOL(fscache_n_culled);
>  /*
>   * display the general statistics
>   */
> -int fscache_stats_show(struct seq_file *m, void *v)
> +int fscache_stats_show(struct seq_file *m)
>  {
>  seq_puts(m, "FS-Cache statistics\n");
>  seq_printf(m, "Cookies: n=3D%d v=3D%d vcol=3D%u voom=3D%u\n",
> @@ -96,7 +96,5 @@ int fscache_stats_show(struct seq_file *m, void *v)
>  seq_printf(m, "IO : rd=3D%u wr=3D%u\n",
>  atomic_read(&fscache_n_read),
>  atomic_read(&fscache_n_write));
> -
> - netfs_stats_show(m);
>  return 0;
>  }
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index dc764b98c7f0..3e6e6a2c0375 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -76,6 +76,7 @@ extern atomic_t netfs_n_rh_write_done;
>  extern atomic_t netfs_n_rh_write_failed;
>  extern atomic_t netfs_n_rh_write_zskip;
> =20
> +int netfs_stats_show(struct seq_file *m, void *v);
> =20
>  static inline void netfs_stat(atomic_t *stat)
>  {
> @@ -168,6 +169,13 @@ static inline void fscache_see_cookie(struct fscache=
_cookie *cookie,
>  extern unsigned fscache_debug;
> =20
>  extern unsigned int fscache_hash(unsigned int salt, const void *data, si=
ze_t len);
> +#ifdef CONFIG_PROC_FS
> +int __init fscache_init(void);
> +void __exit fscache_exit(void);
> +#else
> +static inline int fscache_init(void) { return 0; }
> +static inline void fscache_exit(void) {}
> +#endif
> =20
>  /*
>   * fscache-proc.c
> @@ -218,12 +226,14 @@ static inline void fscache_stat_d(atomic_t *stat)
> =20
>  #define __fscache_stat(stat) (stat)
> =20
> -int fscache_stats_show(struct seq_file *m, void *v);
> +int fscache_stats_show(struct seq_file *m);
>  #else
> =20
>  #define __fscache_stat(stat) (NULL)
>  #define fscache_stat(stat) do {} while (0)
>  #define fscache_stat_d(stat) do {} while (0)
> +
> +static inline int fscache_stats_show(struct seq_file *m) { return 0; }
>  #endif
> =20
>  /*
> diff --git a/fs/netfs/main.c b/fs/netfs/main.c
> index 068568702957..c9af6e0896d3 100644
> --- a/fs/netfs/main.c
> +++ b/fs/netfs/main.c
> @@ -7,6 +7,8 @@
> =20
>  #include <linux/module.h>
>  #include <linux/export.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
>  #include "internal.h"
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/netfs.h>
> @@ -18,3 +20,35 @@ MODULE_LICENSE("GPL");
>  unsigned netfs_debug;
>  module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
> +
> +static int __init netfs_init(void)
> +{
> + int ret =3D -ENOMEM;
> +
> + if (!proc_mkdir("fs/netfs", NULL))
> + goto error;
> +
> +#ifdef CONFIG_FSCACHE_STATS
> + if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
> + netfs_stats_show))
> + goto error_proc;
> +#endif
> +
> + ret =3D fscache_init();
> + if (ret < 0)
> + goto error_proc;
> + return 0;
> +
> +error_proc:
> + remove_proc_entry("fs/netfs", NULL);
> +error:
> + return ret;
> +}
> +fs_initcall(netfs_init);
> +
> +static void __exit netfs_exit(void)
> +{
> + fscache_exit();
> + remove_proc_entry("fs/netfs", NULL);
> +}
> +module_exit(netfs_exit);
> diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
> index 5510a7a14a40..6025dc485f7e 100644
> --- a/fs/netfs/stats.c
> +++ b/fs/netfs/stats.c
> @@ -28,31 +28,32 @@ atomic_t netfs_n_rh_write_done;
>  atomic_t netfs_n_rh_write_failed;
>  atomic_t netfs_n_rh_write_zskip;
> =20
> -void netfs_stats_show(struct seq_file *m)
> +int netfs_stats_show(struct seq_file *m, void *v)
>  {
> - seq_printf(m, "RdHelp : RA=3D%u RP=3D%u WB=3D%u WBZ=3D%u rr=3D%u sr=3D%=
u\n",
> + seq_printf(m, "Netfs : RA=3D%u RP=3D%u WB=3D%u WBZ=3D%u rr=3D%u sr=3D%u=
\n",
>  atomic_read(&netfs_n_rh_readahead),
>  atomic_read(&netfs_n_rh_readpage),
>  atomic_read(&netfs_n_rh_write_begin),
>  atomic_read(&netfs_n_rh_write_zskip),
>  atomic_read(&netfs_n_rh_rreq),
>  atomic_read(&netfs_n_rh_sreq));
> - seq_printf(m, "RdHelp : ZR=3D%u sh=3D%u sk=3D%u\n",
> + seq_printf(m, "Netfs : ZR=3D%u sh=3D%u sk=3D%u\n",
>  atomic_read(&netfs_n_rh_zero),
>  atomic_read(&netfs_n_rh_short_read),
>  atomic_read(&netfs_n_rh_write_zskip));
> - seq_printf(m, "RdHelp : DL=3D%u ds=3D%u df=3D%u di=3D%u\n",
> + seq_printf(m, "Netfs : DL=3D%u ds=3D%u df=3D%u di=3D%u\n",
>  atomic_read(&netfs_n_rh_download),
>  atomic_read(&netfs_n_rh_download_done),
>  atomic_read(&netfs_n_rh_download_failed),
>  atomic_read(&netfs_n_rh_download_instead));
> - seq_printf(m, "RdHelp : RD=3D%u rs=3D%u rf=3D%u\n",
> + seq_printf(m, "Netfs : RD=3D%u rs=3D%u rf=3D%u\n",
>  atomic_read(&netfs_n_rh_read),
>  atomic_read(&netfs_n_rh_read_done),
>  atomic_read(&netfs_n_rh_read_failed));
> - seq_printf(m, "RdHelp : WR=3D%u ws=3D%u wf=3D%u\n",
> + seq_printf(m, "Netfs : WR=3D%u ws=3D%u wf=3D%u\n",
>  atomic_read(&netfs_n_rh_write),
>  atomic_read(&netfs_n_rh_write_done),
>  atomic_read(&netfs_n_rh_write_failed));
> + return fscache_stats_show(m);
>  }
>  EXPORT_SYMBOL(netfs_stats_show);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index d294ff8f9ae4..9bd91cd615d5 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -294,7 +294,6 @@ void netfs_get_subrequest(struct netfs_io_subrequest =
*subreq,
>  enum netfs_sreq_ref_trace what);
>  void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
>  bool was_async, enum netfs_sreq_ref_trace what);
> -void netfs_stats_show(struct seq_file *);
>  ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
>  struct iov_iter *new,
>  iov_iter_extraction_t extraction_flags);
>=20

--=20
Jeff Layton <jlayton@kernel.org>

