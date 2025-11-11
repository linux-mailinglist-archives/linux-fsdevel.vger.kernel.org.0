Return-Path: <linux-fsdevel+bounces-67873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD7C4CAAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F35234EDAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2442F6563;
	Tue, 11 Nov 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wel3RcIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889702F60D6;
	Tue, 11 Nov 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853432; cv=none; b=jKVHt9873K6bhNsI2smMolLZygaQUAOT+4x4Rc3EZoc4oWlzsQJL48fHX5UbtGkchDqQpE0P4zcBpBXSnGAO8hzzAsLsmlnoqgoR6bS8xzlHEb4twoLFZGw9UbnBkxKwsB80mygEnvKgdT7Fbi9ORpQlmBrwT2P1YrBUfzAp2Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853432; c=relaxed/simple;
	bh=FABYtlEqY2mS5o9frfhx1zgALjceFTO/BSa/J+igp2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teQ4i1GVViJV1EJe+i/j6uB43CNVKdqmABbHJAetswcvh8SSs3gfv5fAbflCj0qtPwCvxKVkI4cw839XZ1sWys7CakRfUbjJCVQcvt/opLNKkt112xTNRzj/OSXhpJkD1dAVfxVh+aktP1qAXXA8eDTQY0bqokXYwzadBTwGGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wel3RcIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B728C19421;
	Tue, 11 Nov 2025 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762853432;
	bh=FABYtlEqY2mS5o9frfhx1zgALjceFTO/BSa/J+igp2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wel3RcIuS5j+o/v6AaFglHplRlVo9sjzdy86FsNvkTS5k7A/kuydEY9YQDtDQNrkU
	 1JCCFOApt8LXWbOxCeqS0vlhGpfcI0c8jf2RAsKomtysjY/RFbLTstpdKXu40yGTYn
	 FLxjdS45rZweVEmhZDxCWOTnPuYWbymg3w5CfiOvkb1Zp/DixWYVSWmBkR6D86LVRS
	 90pZQhDvDQUp5C//Nl5fU0nZLj6njdPQoX9etWjUUWT7zS1p8r3mKbTo7WJJiVw2Eh
	 1ZXIc9VtvUtautgBEOReKPpMqPkOF85M+AtRNgbRjY4ZeYjO80kCfOZdnWtEAjEE0Q
	 TQ0u/1s2TNihQ==
Date: Tue, 11 Nov 2025 10:30:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, borntraeger@linux.ibm.com, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 36/50] functionfs: switch to simple_remove_by_name()
Message-ID: <20251111-verelendung-unpolitisch-1bdcd153611e@brauner>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111092244.GS2441659@ZenIV>

On Tue, Nov 11, 2025 at 09:22:44AM +0000, Al Viro wrote:
> On Tue, Nov 11, 2025 at 07:53:16AM +0000, bot+bpf-ci@kernel.org wrote:
> 
> > When ffs_epfiles_create() calls ffs_epfiles_destroy(epfiles, i - 1) after
> > the first ffs_sb_create_file() call fails (when i=1), it passes count=0.
> > The initialization loop starts at i=1, so epfiles[0].ffs is never
> > initialized.
> 
> Incorrect.  The loop in question is

Are you aware that you're replying to a bot-generated email?

> 
> 	epfile = epfiles;
> 	for (i = 1; i <= count; ++i, ++epfile) {
> 		epfile->ffs = ffs;
> 		mutex_init(&epfile->mutex);
> 		mutex_init(&epfile->dmabufs_mutex);
> 		INIT_LIST_HEAD(&epfile->dmabufs);
> 		if (ffs->user_flags & FUNCTIONFS_VIRTUAL_ADDR)
> 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
> 		else   
> 			sprintf(epfile->name, "ep%u", i);
> 		err = ffs_sb_create_file(ffs->sb, epfile->name,
> 					 epfile, &ffs_epfile_operations);
> 		if (err) {
> 			ffs_epfiles_destroy(epfiles, i - 1);
> 			return err;
> 		}
> 	}
> 
> and invariant maintained through the loop is epfile == epfiles + (i - 1).
> We start with i == 1 and epfile == epfiles, modify neither variable in
> the loop body and increment both i and epfile by the same amount in
> the step.
> 
> In other words, on the first pass through the loop we access epfiles[0],
> not epfiles[1].  Granted, the loop could've been more idiomatic, but
> it is actually correct.

