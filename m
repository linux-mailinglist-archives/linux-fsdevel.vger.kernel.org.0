Return-Path: <linux-fsdevel+bounces-77352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHexDMxAlGlhBQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:19:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A387814AC88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F27303EFE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924B29D27D;
	Tue, 17 Feb 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4jyZkSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07328C2DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323543; cv=none; b=rK5kzuvnrRMr5lGRK4Sn5Ei2HmsZPZ9WBjS44Fe0reVcw3VeMv0JwFo+6KwYYLDTEgpoU8vJqNIcZC5U+0OR//EUp20C+IhlGBqok1nCMh//TWEfZVB2dTYmVtnkxehxw03Irm03bwQAzQpxYIy1MQYe7t+fJSLoTEWnxbOnfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323543; c=relaxed/simple;
	bh=An+qkp00zi/3Fvy6FJpdQU3yMiHr0exaUtQ1NTdUDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp6egixnn+vvud5foiuKdqmd9+rw1VMevyElZmlVHzOgqjTeXjghJUiQ2aVbqydeEfj5EB6DJll4J3O5H/O9yy6NewqniD22ff0ihqbaezzbemAxlmdwgbIuAzWl8DeFz0JF8EWeOaL/ch7w4YLup9hb/Tdjd+XGwC1+pSOdlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4jyZkSH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43591b55727so4561961f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771323540; x=1771928340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OneVMU3Nk933/k0Ycu663IAy3Qwo+nFvnKMu1gfwVVI=;
        b=H4jyZkSHVi6NxIrNrsvQUIUb4kvFxoR2fxL6QQ5htWwSTydvK21EHnOm5Sc6XTNwyj
         3lIxCQ+bpLUAzZB71gf9O5RwED2pwhYfnr4j0XuauLZQ6sr05bO9wy3tMENdFr/4bfpL
         vaDEaUhytcwtRzbjhMdyyKDGmhKkYDibSPuNL84I2OSyhcCRBGOpI10o8BGS5H7w3jqb
         m9C3tzrkIgAUggl/+NmefUfIsFMzYOxDkgRDczVmpKTnP+PcfwJc6s6GgyYDyisfq4bh
         uNp4SvLwfsRE/i/2KC4+/HIagCX5CLnhBIRvSSZsh0x1CWyn4SMqUWWp8qJpCGZDtr5Z
         ghSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771323540; x=1771928340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OneVMU3Nk933/k0Ycu663IAy3Qwo+nFvnKMu1gfwVVI=;
        b=TZn+2wchy7cGgIEQHQIpf23pNcYTGyAYh0I0S4yLBDkVDnZmKKEahvkwJ2CUrlm9RK
         5qa3iR+G3dhdn8PMxBJSwrq4zc/MAn+15CSxH6ixoN2SEjvpC0VvhXkvZAXvRUIbnn7E
         QjCvXbXuiJ3B35AB5D+pKUStjWHLuL9fetvs7Nj2uSxoJYhG7GBgvBcrBw+QRfuA91MZ
         J5UiERm0P9M2YUpQgjx8id0K4/PXBjdxUi9XIpC/EoH+qIWZxyQ7d0vb3H+ziGgG9CR0
         4wLVTIbBCtdIDZvNuTOt6QFmPohkm9u0npNwYZPfOv+CHDPEyJ8MIbFtbzUtMAtLEF0J
         3VvA==
X-Forwarded-Encrypted: i=1; AJvYcCV/D2a8qZn8FP9km1/4anso5gOWKRCKTcATc8eDWOZY+Uk2Syk2j8NcqDqzIj/Y8tdB5cPrkSB8fnhGGp6o@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvt8pQ38khQ5fVzLpjLRKLg1eg4WH1LSDVxHPEFYFUqA9qeEg
	bbh2hTHHa+zIYkd2r867OAtuyaEfVCZqxY5VhaMUJlRoUJkoBtX75eSY
X-Gm-Gg: AZuq6aIoL9nbwWzogGv4j6jCETh0j7cME5V8DSvuMXvNpCOP6g6jD/L4BQ5523fZTSl
	PgY5BhYTjNvXVKUE0f6aFjYJui7TH/pDucOzK0uhpSZI6e4O/8n+oOBi7glupt9Tm4KpW0I56dl
	SqPRqGLxf7fyboX99Q7b8EnYKgOqKD9nbfuziMbCYL3GEQ2R4Fhfe2StaHpi0s7aTrISbPA3fMX
	9xoEchySn/pEBkd5M49uXxjgtokj+xPCzGH60vqgvnNCAgzxijCRAbDsuk5ERnHnka1PCCoUsl4
	5xtTT5OaK26aRxNmrZdQG/EqifEnu1WleIdUybhSY/WzqROdKecFzcjj9ekXZxhSZ82FwRqAaHV
	PsGmiociUG4g/wHFveHvHHPnFN0ejPzIZ3xMSQP6dLLz+pUuVXh9yzZyapcNtllGkwjLes+RJf0
	u4qahKvTl2vLVOCd37Aq0A0KJ0D16DMzoHhW81VOV6b5OUv4soOYuR7IG7hn/Rq7xkng==
X-Received: by 2002:a05:600c:154f:b0:483:3384:a873 with SMTP id 5b1f17b1804b1-48379c15d86mr173389145e9.36.1771323539484;
        Tue, 17 Feb 2026 02:18:59 -0800 (PST)
Received: from localhost (109-186-143-15.bb.netvision.net.il. [109.186.143.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm157792255e9.5.2026.02.17.02.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:18:59 -0800 (PST)
Date: Tue, 17 Feb 2026 12:18:57 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on
 file deletion
Message-ID: <aZRAkalnJCxSp7ne@amir-ThinkPad-T480>
References: <20260212215814.629709-1-tjmercier@google.com>
 <20260212215814.629709-3-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212215814.629709-3-tjmercier@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77352-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: A387814AC88
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:58:13PM -0800, T.J. Mercier wrote:
> Currently some kernfs files (e.g. cgroup.events, memory.events) support
> inotify watches for IN_MODIFY, but unlike with regular filesystems, they
> do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> removed.
> 
> This creates a problem for processes monitoring cgroups. For example, a
> service monitoring memory.events for memory.high breaches needs to know
> when a cgroup is removed to clean up its state. Where it's known that a
> cgroup is removed when all processes die, without IN_DELETE_SELF the
> service must resort to inefficient workarounds such as:
> 1.  Periodically scanning procfs to detect process death (wastes CPU and
>     is susceptible to PID reuse).
> 2.  Placing an additional IN_DELETE watch on the parent directory
>     (wastes resources managing double the watches).
> 3.  Holding a pidfd for every monitored cgroup (can exhaust file
>     descriptors).
> 
> This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
> This allows applications to rely on a single existing watch on the file
> of interest (e.g. memory.events) to receive notifications for both
> modifications and the eventual removal of the file, as well as automatic
> watch descriptor cleanup, simplifying userspace logic and improving
> resource efficiency.

This looks very useful,
But,
How will the application know that ti can rely on IN_DELETE_SELF
from cgroups if this is not an opt-in feature?

Essentially, this is similar to the discussions on adding "remote"
fs notification support (e.g. for smb) and in those discussions
I insist that "remote" notification should be opt-in (which is
easy to do with an fanotify init flag) and I claim that mixing
"remote" events with "local" events on the same group is undesired.

However, IN_IGNORED is created when an inotify watch is removed
and IN_DELETE_SELF is called when a vfs inode is destroyed.
When setting an inotify watch for IN_IGNORED|IN_DELETE_SELF there
has to be a vfs inode with inotify mark attached, so why are those
events not created already? What am I missing?

Are you expecting to get IN_IGNORED|IN_DELETE_SELF on an entry
while watching the parent? Because this is not how the API works.

I think it should be possible to set a super block fanotify watch
on cgroupfs and get all the FAN_DELETE_SELF events, but maybe we
do not allow this right now, I did not check - just wanted to give
you another direction to follow.

> 
> Implementation details:
> The kernfs notification worker is updated to handle file deletion.
> fsnotify handles sending MODIFY events to both a watched file and its
> parent, but it does not handle sending a DELETE event to the parent and
> a DELETE_SELF event to the watched file in a single call. Therefore,
> separate fsnotify calls are made: one for the parent (DELETE) and one
> for the child (DELETE_SELF), while retaining the optimized single call

IN_DELETE_SELF and IN_IGNORED are special and I don't really mind adding
them to kernfs seeing that they are very useful, but adding IN_DELETE
without adding IN_CREATE, that is very arbitrary and I don't like it as
much.

> for MODIFY events.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  fs/kernfs/dir.c             | 21 +++++++++++++++++++++
>  fs/kernfs/file.c            | 16 ++++++++++------
>  fs/kernfs/kernfs-internal.h |  3 +++
>  3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 29baeeb97871..e5bda829fcb8 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/fs.h>
> +#include <linux/fsnotify_backend.h>
>  #include <linux/namei.h>
>  #include <linux/idr.h>
>  #include <linux/slab.h>
> @@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool show)
>  	up_write(&root->kernfs_rwsem);
>  }
>  
> +static void kernfs_notify_file_deleted(struct kernfs_node *kn)
> +{
> +	static DECLARE_WORK(kernfs_notify_deleted_work,
> +			    kernfs_notify_workfn);
> +
> +	guard(spinlock_irqsave)(&kernfs_notify_lock);
> +	/* may overwite already pending FS_MODIFY events */
> +	kn->attr.notify_event = FS_DELETE;
> +
> +	if (!kn->attr.notify_next) {
> +		kernfs_get(kn);
> +		kn->attr.notify_next = kernfs_notify_list;
> +		kernfs_notify_list = kn;
> +		schedule_work(&kernfs_notify_deleted_work);
> +	}
> +}
> +
>  static void __kernfs_remove(struct kernfs_node *kn)
>  {
>  	struct kernfs_node *pos, *parent;
> @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  			struct kernfs_iattrs *ps_iattr =
>  				parent ? parent->iattr : NULL;
>  
> +			if (kernfs_type(pos) == KERNFS_FILE)
> +				kernfs_notify_file_deleted(pos);
> +
>  			/* update timestamps on the parent */
>  			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>  
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index e978284ff983..2d21af3cfcad 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -37,8 +37,8 @@ struct kernfs_open_node {
>   */
>  #define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
>  
> -static DEFINE_SPINLOCK(kernfs_notify_lock);
> -static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
> +DEFINE_SPINLOCK(kernfs_notify_lock);
> +struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
>  
>  static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
>  {
> @@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
>  	return ret;
>  }
>  
> -static void kernfs_notify_workfn(struct work_struct *work)
> +void kernfs_notify_workfn(struct work_struct *work)
>  {
>  	struct kernfs_node *kn;
>  	struct kernfs_super_info *info;
> @@ -959,15 +959,19 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  			if (p_inode) {
>  				fsnotify(notify_event | FS_EVENT_ON_CHILD,
>  					 inode, FSNOTIFY_EVENT_INODE,
> -					 p_inode, &name, inode, 0);
> +					 p_inode, &name,
> +					 (notify_event == FS_MODIFY) ?
> +						inode : NULL, 0);
>  				iput(p_inode);
>  			}
>  
>  			kernfs_put(parent);
>  		}
>  
> -		if (!p_inode)
> -			fsnotify_inode(inode, notify_event);
> +		if (notify_event == FS_DELETE)
> +			fsnotify_inoderemove(inode);
> +		else if (!p_inode)
> +			fsnotify_inode(inode, FS_MODIFY);

Didn't you mean notify_event?

Thanks,
Amir.

