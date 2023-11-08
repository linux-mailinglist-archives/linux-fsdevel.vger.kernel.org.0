Return-Path: <linux-fsdevel+bounces-2377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289567E52EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437E81C20D38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A0107AA;
	Wed,  8 Nov 2023 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RasriPX1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvkiSVTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E08C12
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 09:56:37 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2981BB;
	Wed,  8 Nov 2023 01:56:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AC2C1F45A;
	Wed,  8 Nov 2023 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699437394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haSY/yaIV/fqYTZuzHRwE6iFrXPdX6sCOgCYcYIKygU=;
	b=RasriPX17pB635D8dXsKwR06/JxRrmOsKBDaPJyRJLetV+VEbuQey9uAYZwsa7GqsZz1Eh
	VFlVNKj4jCMe+54JDQMCjtdI+Es8g4oizMrpjeX4YnNACbz/rLXEHhI+FgYRJFZclW6v65
	xNsxvs2zWz0Yz0XUBWPTwrHmYcLVLsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699437394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haSY/yaIV/fqYTZuzHRwE6iFrXPdX6sCOgCYcYIKygU=;
	b=uvkiSVTfUaO2euHnE8o6Rp1Q3WTapY4QB6I/bsm0zkvjqLGP2+33vDahjFSCFlZsyVoCBM
	exavwRnnW842XEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12DEE133F5;
	Wed,  8 Nov 2023 09:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 04+OBFJbS2VLXwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 08 Nov 2023 09:56:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D4ECA07C0; Wed,  8 Nov 2023 10:56:33 +0100 (CET)
Date: Wed, 8 Nov 2023 10:56:33 +0100
From: Jan Kara <jack@suse.cz>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
	linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	codalist@coda.cs.cmu.edu
Subject: Re: [PATCH 2/4] aio: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <20231108095633.ec6im6btx7hprl6o@quack3>
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>

On Tue 07-11-23 14:44:21, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel elements ctl_table struct. Special attention was placed in
> making sure that an empty directory for fs/verity was created when
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not defined. In this case we use the
> register sysctl call that expects a size.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

For fs/*.c, fs/quota/, fs/notify/, fs/ocfs2/ feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Other bits look good to me as well besides fsverify changes which looks odd
and Eric already commented on that.

								Honza

> ---
>  fs/aio.c                           | 1 -
>  fs/coredump.c                      | 1 -
>  fs/dcache.c                        | 1 -
>  fs/devpts/inode.c                  | 1 -
>  fs/eventpoll.c                     | 1 -
>  fs/exec.c                          | 1 -
>  fs/file_table.c                    | 1 -
>  fs/inode.c                         | 1 -
>  fs/lockd/svc.c                     | 1 -
>  fs/locks.c                         | 1 -
>  fs/namei.c                         | 1 -
>  fs/namespace.c                     | 1 -
>  fs/nfs/nfs4sysctl.c                | 1 -
>  fs/nfs/sysctl.c                    | 1 -
>  fs/notify/dnotify/dnotify.c        | 1 -
>  fs/notify/fanotify/fanotify_user.c | 1 -
>  fs/notify/inotify/inotify_user.c   | 1 -
>  fs/ntfs/sysctl.c                   | 1 -
>  fs/ocfs2/stackglue.c               | 1 -
>  fs/pipe.c                          | 1 -
>  fs/proc/proc_sysctl.c              | 1 -
>  fs/quota/dquot.c                   | 1 -
>  fs/sysctls.c                       | 1 -
>  fs/userfaultfd.c                   | 1 -
>  fs/verity/fsverity_private.h       | 2 +-
>  fs/verity/init.c                   | 8 +++++---
>  fs/xfs/xfs_sysctl.c                | 2 --
>  27 files changed, 6 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index a4c2a6bac72c..da069d6b6c66 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -239,7 +239,6 @@ static struct ctl_table aio_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
>  	},
> -	{}
>  };
>  
>  static void __init aio_sysctl_init(void)
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9d235fa14ab9..f258c17c1841 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -981,7 +981,6 @@ static struct ctl_table coredump_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_coredump_sysctls(void)
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 25ac74d30bff..bafdd455b0fe 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -191,7 +191,6 @@ static struct ctl_table fs_dcache_sysctls[] = {
>  		.mode		= 0444,
>  		.proc_handler	= proc_nr_dentry,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_dcache_sysctls(void)
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 299c295a27a0..a4de1612b1db 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -69,7 +69,6 @@ static struct ctl_table pty_table[] = {
>  		.data		= &pty_count,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{}
>  };
>  
>  struct pts_mount_opts {
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 1d9a71a0c4c1..975fc5623102 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -322,7 +322,6 @@ static struct ctl_table epoll_table[] = {
>  		.extra1		= &long_zero,
>  		.extra2		= &long_max,
>  	},
> -	{ }
>  };
>  
>  static void __init epoll_sysctls_init(void)
> diff --git a/fs/exec.c b/fs/exec.c
> index 6518e33ea813..7a18bde22f25 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -2167,7 +2167,6 @@ static struct ctl_table fs_exec_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_exec_sysctls(void)
> diff --git a/fs/file_table.c b/fs/file_table.c
> index ee21b3da9d08..544f7d4f166f 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -137,7 +137,6 @@ static struct ctl_table fs_stat_sysctls[] = {
>  		.extra1		= &sysctl_nr_open_min,
>  		.extra2		= &sysctl_nr_open_max,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_stat_sysctls(void)
> diff --git a/fs/inode.c b/fs/inode.c
> index 35fd688168c5..ce16e3cda7bf 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -129,7 +129,6 @@ static struct ctl_table inodes_sysctls[] = {
>  		.mode		= 0444,
>  		.proc_handler	= proc_nr_inodes,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_inode_sysctls(void)
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 6579948070a4..f784ff58bfd3 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -474,7 +474,6 @@ static struct ctl_table nlm_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  #endif	/* CONFIG_SYSCTL */
> diff --git a/fs/locks.c b/fs/locks.c
> index 76ad05f8070a..6ecfc422fb37 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -111,7 +111,6 @@ static struct ctl_table locks_sysctls[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif /* CONFIG_MMU */
> -	{}
>  };
>  
>  static int __init init_fs_locks_sysctls(void)
> diff --git a/fs/namei.c b/fs/namei.c
> index 567ee547492b..fb552161c981 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1070,7 +1070,6 @@ static struct ctl_table namei_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_namei_sysctls(void)
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e157efc54023..e95d4328539d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5008,7 +5008,6 @@ static struct ctl_table fs_namespace_sysctls[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ONE,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_namespace_sysctls(void)
> diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
> index e776200e9a11..886a7c4c60b3 100644
> --- a/fs/nfs/nfs4sysctl.c
> +++ b/fs/nfs/nfs4sysctl.c
> @@ -34,7 +34,6 @@ static struct ctl_table nfs4_cb_sysctls[] = {
>  		.mode = 0644,
>  		.proc_handler = proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  int nfs4_register_sysctl(void)
> diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
> index f39e2089bc4c..e645be1a3381 100644
> --- a/fs/nfs/sysctl.c
> +++ b/fs/nfs/sysctl.c
> @@ -29,7 +29,6 @@ static struct ctl_table nfs_cb_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  int nfs_register_sysctl(void)
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index ebdcc25df0f7..8151ed5ddefc 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -29,7 +29,6 @@ static struct ctl_table dnotify_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{}
>  };
>  static void __init dnotify_sysctl_init(void)
>  {
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index f69c451018e3..80539839af0c 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -86,7 +86,6 @@ static struct ctl_table fanotify_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO
>  	},
> -	{ }
>  };
>  
>  static void __init fanotify_sysctls_init(void)
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 1c4bfdab008d..3e222a271da6 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -85,7 +85,6 @@ static struct ctl_table inotify_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO
>  	},
> -	{ }
>  };
>  
>  static void __init inotify_sysctls_init(void)
> diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
> index 174fe536a1c0..4e980170d86a 100644
> --- a/fs/ntfs/sysctl.c
> +++ b/fs/ntfs/sysctl.c
> @@ -28,7 +28,6 @@ static struct ctl_table ntfs_sysctls[] = {
>  		.mode		= 0644,			/* Mode, proc handler. */
>  		.proc_handler	= proc_dointvec
>  	},
> -	{}
>  };
>  
>  /* Storage for the sysctls header. */
> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index a8d5ca98fa57..20aa37b67cfb 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -658,7 +658,6 @@ static struct ctl_table ocfs2_nm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dostring,
>  	},
> -	{ }
>  };
>  
>  static struct ctl_table_header *ocfs2_table_header;
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 6c1a9b1db907..6bc1c4ae81d5 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1492,7 +1492,6 @@ static struct ctl_table fs_pipe_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
>  	},
> -	{ }
>  };
>  #endif
>  
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index de484195f49f..4e06c4d69906 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -71,7 +71,6 @@ static struct ctl_table root_table[] = {
>  		.procname = "",
>  		.mode = S_IFDIR|S_IRUGO|S_IXUGO,
>  	},
> -	{ }
>  };
>  static struct ctl_table_root sysctl_table_root = {
>  	.default_set.dir.header = {
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9e72bfe8bbad..69b03e13e6f2 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2949,7 +2949,6 @@ static struct ctl_table fs_dqstats_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -	{ },
>  };
>  
>  static int __init dquot_init(void)
> diff --git a/fs/sysctls.c b/fs/sysctls.c
> index 76a0aee8c229..8dbde9a802fa 100644
> --- a/fs/sysctls.c
> +++ b/fs/sysctls.c
> @@ -26,7 +26,6 @@ static struct ctl_table fs_shared_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_MAXOLDUID,
>  	},
> -	{ }
>  };
>  
>  static int __init init_fs_sysctls(void)
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 56eaae9dac1a..7668285779c1 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -45,7 +45,6 @@ static struct ctl_table vm_userfaultfd_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -	{ }
>  };
>  #endif
>  
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index d071a6e32581..8191bf7ad706 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -122,8 +122,8 @@ void __init fsverity_init_info_cache(void);
>  
>  /* signature.c */
>  
> -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  extern int fsverity_require_signatures;
> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  int fsverity_verify_signature(const struct fsverity_info *vi,
>  			      const u8 *signature, size_t sig_size);
>  
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index a29f062f6047..e31045dd4f6c 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -13,7 +13,6 @@
>  static struct ctl_table_header *fsverity_sysctl_header;
>  
>  static struct ctl_table fsverity_sysctl_table[] = {
> -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  	{
>  		.procname       = "require_signatures",
>  		.data           = &fsverity_require_signatures,
> @@ -23,14 +22,17 @@ static struct ctl_table fsverity_sysctl_table[] = {
>  		.extra1         = SYSCTL_ZERO,
>  		.extra2         = SYSCTL_ONE,
>  	},
> -#endif
> -	{ }
>  };
>  
>  static void __init fsverity_init_sysctl(void)
>  {
> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  	fsverity_sysctl_header = register_sysctl("fs/verity",
>  						 fsverity_sysctl_table);
> +#else
> +	fsverity_sysctl_header = register_sysctl_sz("fs/verity",
> +						 fsverity_sysctl_table, 0);
> +#endif
>  	if (!fsverity_sysctl_header)
>  		panic("fsverity sysctl registration failed");
>  }
> diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
> index fade33735393..a191f6560f98 100644
> --- a/fs/xfs/xfs_sysctl.c
> +++ b/fs/xfs/xfs_sysctl.c
> @@ -206,8 +206,6 @@ static struct ctl_table xfs_table[] = {
>  		.extra2		= &xfs_params.stats_clear.max
>  	},
>  #endif /* CONFIG_PROC_FS */
> -
> -	{}
>  };
>  
>  int
> 
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

