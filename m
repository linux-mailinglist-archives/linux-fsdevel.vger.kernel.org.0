Return-Path: <linux-fsdevel+bounces-48283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590ABAACD99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 20:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC577AA0AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5B2868B1;
	Tue,  6 May 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI4dIUYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DD284B56;
	Tue,  6 May 2025 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557944; cv=none; b=prZEDbGefdBA+rYOkFO/3YxYKx1PYI2t1AMC9keQoXLl5nTWZsEsCdmXRsdun94XN5hYyGJh1qVYKXujDfXvubuKWC1EE7+fPS7be9id52jwSuL3HtCp5yFnqpm2yvsC2ACdAtIEwga1BPQ+GBtCv0e8m5YRoXAtpvbAJoCzmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557944; c=relaxed/simple;
	bh=sxk+IneFN3iVZKgKHL4IJIHkMqzrdCAeehVRvsrh3jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSBm5ua0F+yRYAbUH/oyAiVoZsRVRhe9yof641cMRgAauLxXaLHdByWidfWJZCnXbSnChWsBTdAPJr2seB/QwzdmY1UrAGyEHNum7tdvUqOOz/YTQLVBySS7iUIl2QUCs1V5bxcB90Cb873BEof0FnczlZCmgsJgbeDGBn1pCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI4dIUYj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b10956398so240850e87.0;
        Tue, 06 May 2025 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746557940; x=1747162740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obfZjG+vSvJH5Cnzhd+H/X6kgWVMpN9AHATdsnwqiek=;
        b=QI4dIUYjDUrvJUGI8ifsCrij+f3D0sPTuT6/QxRueu3teVtCe9Pz4/cNRMWzWmm5Lw
         mho72EGLF0ZsfUCdEuboeMnQhqlvKV/VJBNkjMnQz4ZhetubXc6Eo9LDWCxOHYnIDN5k
         nrT5wMhtrFVX/YOsqcEQuTPj2c+oQBoxNIp0WB19CLq018qdGrNW/GaIU+x/+bY070kE
         0Auv3Zw/IzUFMQ6E9STlMkXpZFkj8GDESrOyjh9IH8wag4C3o+tp0csdXXBjNxwz2JtX
         bIc5cmrHy76gWIt0ecUQoflRSwf/k/DYH2fELrFeiK4Z30NVI4kfd1mKWClcdJWJG6pn
         YKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746557940; x=1747162740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obfZjG+vSvJH5Cnzhd+H/X6kgWVMpN9AHATdsnwqiek=;
        b=rfrxwdCj41YwkUaYAetTups+rLxotTS1H+7cFfYl1qjOMDuvvImcVVdHGkCQ6fKSXR
         V/Pvuw6GumShUd7QvQVrWR9ESu4gEm/jLmcAvtQrxvEg7e41wzv/ix5j/0ED7Rzf+qBU
         o80ug4CeqUrm4+TFR7ef3nlkNj0uVfaYWSIchTHoeUiVK0I5XKqNvVtEzZqXFnzJQc+t
         mGTVwWfYzhafjsL54FT1qNfX+tmBAwapzKJ/wJYlGbxEVwtOoTgdEy4Nx5YrAzZZU9pa
         6P028telyAaS4JjebQrEbMnAdbcbHPDBC/0H0Xnrh/wIHEkl2cViXiy/Go2stslpczp9
         WsWg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3rXeETo4/n1BM+FvjZxCi0OJMIrqhP5ByeubK5Picum8zTRLI8dZLOqq8+CDdv+76xd+u7jwPqqd+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyStXC1IfqWjLnytgDJ4uzYZwjC6vOFuFnWjM7eZL2SbKXLGHSl
	Cndej2H7Gy7iscInW5r8yMI7rkFkkD/Q3FmT7PafpalOOVoK30I1LLGaYw==
X-Gm-Gg: ASbGnculnK+d700Qi/hg3K0+g3lghoXUe9FJ0RngfB9S3EgSLdG+IQtq52p9cGI5nAi
	as/KwAs7JqT+RSKZJVe19jx8DII6HxsrWFru967il/ksmG5o3qFXQ4mUZp7dm+BAodTj5RdVo51
	vpCsJGwz9IlB1oB+oHmQ9/OT98k6CY1qiuB8fSeV4Av7pSDDiP9HI4Z/UssecfXzMqSA52LN8Z3
	gjKtnRNnUBdwQBvtG93/sldABtUu0T50K/QvkPugpv32s1IAi1r2Unw7GyKxR6hiVf03eXP4wdP
	WMQhvJ1vS5SN5jr5mXROik+iBXFdHQRpemThTwe7pN6NOfnIrQkUAiw=
X-Google-Smtp-Source: AGHT+IGBaaFIJaTuAwyAPdWvI4xizjJDyTkthvKMkb6nwb4VO51zNT2pnrGBdOb28p+xinZWFzuoMQ==
X-Received: by 2002:a05:6512:10c9:b0:549:8ff1:e0f3 with SMTP id 2adb3069b0e04-54fb990f935mr84197e87.5.1746557940270;
        Tue, 06 May 2025 11:59:00 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-54ea94c8c41sm2123008e87.97.2025.05.06.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 11:58:59 -0700 (PDT)
Date: Tue, 6 May 2025 20:58:59 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <usokd3dnditdgjf772khf76rwjczn3qfd2qtxgxyvmqxpf5wmb@yfb66jhpnwtd>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506181604.GP2023217@ZenIV>

On 2025-05-06 19:16:04 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 07:54:32PM +0200, Klara Modin wrote:
> 
> > > > Though now I hit another issue which I don't know if it's related or
> > > > not. I'm using an overlay mount with squashfs as lower and btrfs as
> > > > upper. The mount fails with invalid argument and I see this in the log:
> > > > 
> > > > overlayfs: failed to clone upperpath
> > > 
> > > Seeing that you already have a kernel with that thing reverted, could
> > > you check if the problem exists there?
> > 
> > Yeah, it works fine with the revert instead.
> 
> Interesting...  That message means that you've got clone_private_mount()
> returning an error; the thing is, mount passed to it has come from
> pathname lookup - it is *not* the mount created by that fc_mount() of
> vfs_create_mount() in the modified code.  That one gets passed to
> mount_subvol() and consumed there (by mount_subtree()).  All that is returned
> is root dentry; the mount passed to clone_private_mount() is created
> from scratch using dentry left by btrfs_get_tree_subvol() in its fc->root -
> see
>         dentry = mount_subvol(ctx->subvol_name, ctx->subvol_objectid, mnt);
>         ctx->subvol_name = NULL;
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
> 
>         fc->root = dentry;
>         return 0;
> in the end of btrfs_get_tree_subvol().
> 
> What's more, on the overlayfs side we managed to get to
>         upper_mnt = clone_private_mount(upperpath);
>         err = PTR_ERR(upper_mnt);
>         if (IS_ERR(upper_mnt)) {
>                 pr_err("failed to clone upperpath\n");
>                 goto out;
> so the upper path had been resolved...
> 
> OK, let's try to see what clone_private_mount() is unhappy about...
> Could you try the following on top of -next + braino fix and see
> what shows up?  Another interesting thing, assuming you can get
> to shell after overlayfs mount failure, would be /proc/self/mountinfo
> contents and stat(1) output for upper path of your overlayfs mount...

	ret = vfs_get_tree(dup_fc);
	if (!ret) {
		ret = btrfs_reconfigure_for_mount(dup_fc);
		up_write(&dup_fc->root->d_sb->s_umount);
	}
	if (!ret)
		mnt = vfs_create_mount(fc);
	else
		mnt = ERR_PTR(ret);
	put_fs_context(dup_fc);


I tried replacing fc with dup_fc in vfs_create_mount and it seems to
work.

