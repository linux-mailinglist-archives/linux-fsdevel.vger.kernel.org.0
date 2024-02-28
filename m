Return-Path: <linux-fsdevel+bounces-13026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E85A86A4AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D99B23E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E761FA3;
	Wed, 28 Feb 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps37R3t6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFDEBB;
	Wed, 28 Feb 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081983; cv=none; b=OJ1Jg+062nGMrCWkSKmkTjdnm2phmKY9a+wJF3dyEOe0lJiUqXQaSmDeBRGipK3PG600UoaRA9BF1irm658FdZeSrheyqZSPgPbgFh4KLRUnNwbjd/PIRL8bKQFoF4YZYiG3Z5ya47ZWFQx3SGtV8hOeRRtG6xqHEgQ5SX6GYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081983; c=relaxed/simple;
	bh=6mAwiUtOknSSutvq0YNFLvWJ9KCKfA9wjlmgNIu1avE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giA/uR0iWTXGj3gevN6CQ5xAdW1U8zWDebMZthUjffkjVppVKjwO3wpmoLnvXxx6ipIdhSEUvhCzMoh9z7LpSMw38/MGxESFUpj7mUvunZoBf0KWSVREW7Pf1BQAjWqtkzB07cPY+eDTTF7c0ohtNPzdHlPwYVUGIRS8CnYfRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps37R3t6; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21fa872dce3so2760214fac.2;
        Tue, 27 Feb 2024 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709081979; x=1709686779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/VJ4ezn4JfkgFtFkFYYYQTXIflXruAY0C3laMtvGzA=;
        b=Ps37R3t60IfbP9rnsIhEOeC39uUcRHWCWlso5hL5yIp7CycH4z7ObGZNRnl3rgrz+V
         q6hSeKHWeC0V9TdPDHNGeGx+X0yXjZYx+aPNwEWJPkPPq7zk4F4aKE3lOGx6ltpWtVmG
         YGA1neRx7vMOd8/3XahVCV7uqecHdNKbameqR7uDA0lXb5Gh+H/17T+DcWfxlY+rV7cK
         SCDS8k/0EgyleXAQdkPxN3myLO51FaidBBg7yDPfoOQRNledV8LuD+pVfX29RVTdo/qO
         FpeXsNypti3QHaYbG8vy00kqq3zQFVZR3D+lxM/kp+4J/SPmken5u/kU6zREaw/pcny2
         FZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709081979; x=1709686779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/VJ4ezn4JfkgFtFkFYYYQTXIflXruAY0C3laMtvGzA=;
        b=ORp14QFxRirn7q7UgyycEZ2nGijb1/EOcufLCxlsKJ68qZytC/tzRAJkEMMFuWjOJJ
         nnGna6vop10cF0Z1XGIDzlK1WKkQLbSnP1ShPsljx9+QC46AF8ofrEu/8R7vkon+thh2
         HwfMUjml7nOewM9XP2b4vj5UVvLjF01Fte1Mgm4UpLHCF4DUb1GlTLN0bNozqM8HO8Vl
         6wSvgyla0SMpl/Exe2Rd5c+4IFbSMrp+7Dtj9KDxhJ2JSYTbb0RQzAdquCq4AO8aMdnp
         V+KQZH1HMBc+wuE72SzuutdKa6wfb1sbg7PU4KSPgOJZdyMZ9gZwKHo7WHP8Tq8tRLK/
         mMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWzGUfKx0wixXxaztnmPSZxNfW11PTgzovkNrIBhDb0tgzFpn3wHwksWWm8DmweDHMlv8yRN7NljRMqEEOwd5QPuy/Wv8AFeI4E7ubbJVjqPGdzzr6ecX1Ar3CYIwlvCvqZyxKMRBogq9t3dv8U8aykiuguS0mm7z+daSkjRjZus5mXcO0wT7bXEoDFAcFBykefXHZO/4Qh4Q+pEYflIpiEmA==
X-Gm-Message-State: AOJu0Yx08tMlYAj/wRoKsWUo0uHyz8fx5W+JaBdQ3ldy2n/lxgRnqo8H
	iw9gNueBeURwHKjxRph/E2b73p4nLl2QJzGbQCdsIoF8Cc/DSeU0
X-Google-Smtp-Source: AGHT+IE/bq+pbCEPKnDfm3BhnEgfwUEKQIWim6ODi2jvIyHs822SfRjbFVspFukSBnfjmr30t4HikQ==
X-Received: by 2002:a05:6870:55d2:b0:21e:5827:9483 with SMTP id qk18-20020a05687055d200b0021e58279483mr13395251oac.29.1709081978556;
        Tue, 27 Feb 2024 16:59:38 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id xm12-20020a0568709f8c00b0021fb37e33e5sm2322033oab.19.2024.02.27.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 16:59:38 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 27 Feb 2024 18:59:36 -0600
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Message-ID: <6jrtl2vc4dmi5b6db6tte2ckiyjmiwezbtlwrtmm464v65wkhj@znzv2mwjfgsk>
References: <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
 <20240227-mammut-tastatur-d791ca2f556b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-mammut-tastatur-d791ca2f556b@brauner>

On 24/02/27 02:41PM, Christian Brauner wrote:
> On Fri, Feb 23, 2024 at 11:41:55AM -0600, John Groves wrote:
> > This commit introduces the famfs fs_context_operations and
> > famfs_get_inode() which is used by the context operations.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/famfs/famfs_inode.c | 178 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 178 insertions(+)
> > 
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > index 82c861998093..f98f82962d7b 100644
> > --- a/fs/famfs/famfs_inode.c
> > +++ b/fs/famfs/famfs_inode.c

<snip>

> > +enum famfs_param {
> > +	Opt_mode,
> > +	Opt_dax,
> > +};
> > +
> > +const struct fs_parameter_spec famfs_fs_parameters[] = {
> > +	fsparam_u32oct("mode",	  Opt_mode),
> > +	fsparam_string("dax",     Opt_dax),
> > +	{}
> > +};
> > +
> > +static int famfs_parse_param(
> > +	struct fs_context   *fc,
> > +	struct fs_parameter *param)
> > +{
> > +	struct famfs_fs_info *fsi = fc->s_fs_info;
> > +	struct fs_parse_result result;
> > +	int opt;
> > +
> > +	opt = fs_parse(fc, famfs_fs_parameters, param, &result);
> > +	if (opt == -ENOPARAM) {
> > +		opt = vfs_parse_fs_param_source(fc, param);
> > +		if (opt != -ENOPARAM)
> > +			return opt;
> 
> I'm not sure I understand this. But in any case add, you should add
> Opt_source to enum famfs_param and then add
> 
>         fsparam_string("source",        Opt_source),
> 
> to famfs_fs_parameters. Then you can add:
> 
> famfs_parse_source(fc, param);
> 
> You might want to consider validating your devices right away. So think
> about:
> 
> fd_fs = fsopen("famfs", ...);
> ret = fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/definitely/not/valid/device", ...) // succeeds
> ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_1", ...) // succeeds
> ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_2", ...) // succeeds 
> ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_3", ...) // succeeds 
> ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_N", ...) // succeeds 
> ret = fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...) // superblock creation failed
> 
> So what failed exactly? Yes, you can log into the fscontext and dmesg
> that it's @source that's the issue but it's annoying for userspace to
> setup a whole mount context only to figure out that some option was
> wrong at the end of it.
> 
> So validating
> 
> famfs_parse_source(...)
> {
> 	if (fc->source)
> 		return invalfc(fc, "Uhm, we already have a source....
> 	
>        lookup_bdev(fc->source, &dev)
>        // validate it's a device you're actually happy to use
> 
>        fc->source = param->string;
>        param->string = NULL;
> }
> 
> Your ->get_tree implementation that actually creates/finds the
> superblock will validate fc->source again and yes, there's a race here
> in so far as the path that fc->source points to could change in between
> validating this in famfs_parse_source() and ->get_tree() superblock
> creation. This is fixable even right now but then you couldn't reuse
> common infrastrucute so I would just accept that race for now and we
> should provide a nicer mechanism on the vfs layer.

I wasn't aware of the new fsconfig interface. Is there documentation or a
file sytsem that already uses it that I should refer to? I didn't find an
obvious candidate, but it might be me. If it should be obvious from the
example above, tell me and I'll try harder.

My famfs code above was copied from ramfs. If you point me to 
documentation I might send you a ramfs fsconfig patch too :D.

> 
> > +
> > +		return 0;
> > +	}
> > +	if (opt < 0)
> > +		return opt;
> > +
> > +	switch (opt) {
> > +	case Opt_mode:
> > +		fsi->mount_opts.mode = result.uint_32 & S_IALLUGO;
> > +		break;
> > +	case Opt_dax:
> > +		if (strcmp(param->string, "always"))
> > +			pr_notice("%s: invalid dax mode %s\n",
> > +				  __func__, param->string);
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static DEFINE_MUTEX(famfs_context_mutex);
> > +static LIST_HEAD(famfs_context_list);
> > +
> > +static int famfs_get_tree(struct fs_context *fc)
> > +{
> > +	struct famfs_fs_info *fsi_entry;
> > +	struct famfs_fs_info *fsi = fc->s_fs_info;
> > +
> > +	fsi->rootdev = kstrdup(fc->source, GFP_KERNEL);
> > +	if (!fsi->rootdev)
> > +		return -ENOMEM;
> > +
> > +	/* Fail if famfs is already mounted from the same device */
> > +	mutex_lock(&famfs_context_mutex);
> > +	list_for_each_entry(fsi_entry, &famfs_context_list, fsi_list) {
> > +		if (strcmp(fsi_entry->rootdev, fc->source) == 0) {
> > +			mutex_unlock(&famfs_context_mutex);
> > +			pr_err("%s: already mounted from rootdev %s\n", __func__, fc->source);
> > +			return -EALREADY;
> 
> What errno is EALREADY? Isn't that socket stuff. In any case, it seems
> you want EBUSY?

Thanks... That should probaby be EBUSY. But the whole famfs_context_list
should probably also be removed. More below...

> 
> But bigger picture I'm lost. And why do you keep that list based on
> strings? What if I do:
> 
> mount -t famfs /dev/pmem1234 /mnt # succeeds
> 
> mount -t famfs /dev/pmem1234 /opt # ah, fsck me, this fails.. But wait a minute....
> 
> mount --bind /dev/pmem1234 /evil-masterplan
> 
> mount -t famfs /evil-masterplan /opt # succeeds. YAY
> 
> I believe that would trivially defeat your check.
> 

And I suspect this is related to the get_tree issue you noticed below.

This famfs code was working in 6.5 without keeping the linked list of devices,
but in 6.6/6.7/6.8 it works provided you don't try to repeat a mount command
that has already succeeded. I'm not sure why 6.5 protected me from that,
but the later versions don't. In 6.6+ That hits a BUG_ON (have specifics on 
that but not handy right now).

So for a while we just removed repeated mount requests from the famfs smoke
tests, but eventually I implemented the list above, which - though you're right
it would be easy to circumvent and therefore is not right - it did solve the
problem that we were testing for.

I suspect that correctly handling get_tree might solve this problem.

Please assume that linked list will be removed - it was not the right solution.

More below...

> > +		}
> > +	}
> > +
> > +	list_add(&fsi->fsi_list, &famfs_context_list);
> > +	mutex_unlock(&famfs_context_mutex);
> > +
> > +	return get_tree_nodev(fc, famfs_fill_super);
> 
> So why isn't this using get_tree_bdev()? Note that a while ago I
> added FSCONFIG_CMD_CREAT_EXCL which prevents silent superblock reuse. To
> implement that I added fs_context->exclusive. If you unconditionally set
> fc->exclusive = 1 in your famfs_init_fs_context() and use
> get_tree_bdev() it will give you EBUSY if fc->source is already in use -
> including other famfs instances.
> 
> I also fail to yet understand how that function which actually opens the block
> device and gets the dax device figures into this. It's a bit hard to follow
> what's going on since you add all those unused functions and types so there's
> never a wider context to see that stuff in.

Clearly that's a bug in my code. That get_tree_nodev() is from ramfs, which
was the starting point for famfs.

I'm wondering if doing this correctly (get_tree_bdev() when it's pmem) would
have solved my double mount problem on 6.6 onward.

However, there's another wrinkle: I'm concluding
(see https://lore.kernel.org/linux-fsdevel/ups6cvjw6bx5m3hotn452brbbcgemnarsasre6ep2lbe4tpjsy@ezp6oh5c72ur/)
that famfs should drop block support and just work with /dev/dax. So famfs 
may be the first file system to be hosted on a character device? Certainly 
first on character dax. 

Given that, what variant of get_tree() should it call? Should it add 
get_tree_dax()? I'm not yet familiar enough with that code to have a worthy 
opinion on this.

Please let me know what you think.

Thank you for the serious review!
John



