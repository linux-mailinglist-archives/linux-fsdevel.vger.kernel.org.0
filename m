Return-Path: <linux-fsdevel+bounces-13745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BC87359E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB641C20E29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2737FBA1;
	Wed,  6 Mar 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH+mS0gB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420D5FDDC;
	Wed,  6 Mar 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724694; cv=none; b=AviepM7fSW+ON6W9RPysOGqCMI93Tx1YIQ+KgsOEV8CM43hg/z+XgJULyRZGWj4ZWpTWOWmtGeZrALmTZGYCuqW2/lyV4HkzC+2O9+R20ooqXT6Y6Mt+1LJ0W8KIymmpcLzj1CfwHim79oR+v+VPfzQ2P8ijOKGcDnZKI9DmuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724694; c=relaxed/simple;
	bh=aJcchhPDrnKR3KgE99GNHWAsCMEHMndLQcciOchRCvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIMRzUyF01mXNEYJr4Q9bbxCbA2gQrXXsLs53lA9+tskei7Cl/3ajAJQJwiLXHklOPvpw2KArKzKDXaSET1qa3LJlovkh49alwo7+0bpwewnB/PYA+Tbf2IhIik30TCsbvUbCIdm45UmDjJYyUjJPjA/UcXLBzsNsOgtmk4VQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH+mS0gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37877C433C7;
	Wed,  6 Mar 2024 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709724693;
	bh=aJcchhPDrnKR3KgE99GNHWAsCMEHMndLQcciOchRCvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RH+mS0gBvQPVWVay9H6DBDBuZw1Exk07YrxmES9SR3IrtpHq5BXSFQ3hcju6mMpZO
	 dxYc9hY4FZtYiGmCPthZPvSfVU0ZVwtnh3IxIv/P1LXUUXgdo0yZiTFNPGtcnVxKjk
	 kSL+isDmSykPxN8DZ7K8ypTbbJ5I3Oq1L3wuS3boVveMeRs8oqKeKSImlxbKww4hKc
	 zMNoJ6456G+55eD9SZf32feEL//oTYrWNjugUpMUDHlEqZ0cDDnhpAADHjAXcerLwk
	 EtdY7KlB4J35xOUH0We3xrww4jycfoRGPGS85CftV/krMo7nvNedBwgmg7HCFuiC8x
	 Kt9XPN429+61g==
Date: Wed, 6 Mar 2024 12:31:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 4/9] bpf: add new acquire/release based BPF
 kfuncs for exe_file
Message-ID: <20240306-zeitumstellung-darben-7857ca9817c0@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <6a5d425e52eb4d8f7539e841494eac36688ab0da.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a5d425e52eb4d8f7539e841494eac36688ab0da.1709675979.git.mattbobrowski@google.com>

On Wed, Mar 06, 2024 at 07:40:00AM +0000, Matt Bobrowski wrote:
> It is rather common for BPF LSM program types to perform the struct
> walk current->mm->exe_file and subsequently operate on fields of the
> backing file. At times, some of these operations involve passing a
> exe_file's field on to BPF helpers and such
> i.e. bpf_d_path(&current->mm->exe_file->f_path). However, doing so
> isn't necessarily always reliable as the backing file that exe_file is
> pointing to may be in the midst of being torn down and handing
> anything contained within this file to BPF helpers and such can lead
> to memory corruption issues [0].
> 
> To alleviate possibly operating on semi-torn down instances of
> current->mm->exe_file we introduce a set of BPF kfuncs that posses
> KF_ACQUIRE/KF_RELEASE based semantics. Such BPF kfuncs will allow BPF
> LSM program types to reliably get/put a reference on a
> current->mm->exe_file.
> 
> The following new BPF kfuncs have been added:
> 
> struct file *bpf_get_task_exe_file(struct task_struct *task);
> struct file *bpf_get_mm_exe_file(struct mm_struct *mm);
> void bpf_put_file(struct file *f);
> 
> Internally, these new BPF kfuncs simply call the preexisting in-kernel
> functions get_task_exe_file(), get_mm_exe_file(), and fput()
> accordingly. From a technical standpoint, there's absolutely no need
> to re-implement such helpers just for BPF as they're currently scoped
> to BPF LSM program types.
> 
> Note that we explicitly do not explicitly rely on the use of very low
> level in-kernel functions like get_file_rcu() and get_file_active() to
> acquire a reference on current->mm->exe_file and such. This is super
> subtle code and we probably want to avoid exposing any such subtleties
> to BPF in the form of BPF kfuncs. Additionally, the usage of a double
> pointer i.e. struct file **, isn't something that the BPF verifier
> currently recognizes nor has any intention to recognize for the
> foreseeable future.
> 
> [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

get_mm_exe_file() and get_task_exe_file() aren't even exported to
modules which makes me a lot more hesitant.

>  kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 801808b6efb0..539c58db74d7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1518,12 +1518,68 @@ __bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
>  	mmdrop(mm);
>  }
>  
> +/**
> + * bpf_get_task_exe_file - get a reference on the exe_file associated with the
> + * 	       		   mm_struct that is nested within the supplied
> + * 	       		   task_struct
> + * @task: task_struct of which the nested mm_struct's exe_file is to be
> + * referenced
> + *
> + * Get a reference on the exe_file that is associated with the mm_struct nested
> + * within the supplied *task*. A reference on a file pointer acquired by this
> + * kfunc must be released using bpf_put_file(). Internally, this kfunc leans on
> + * get_task_exe_file(), such that calling bpf_get_task_exe_file() would be
> + * analogous to calling get_task_exe_file() outside of BPF program context.
> + *
> + * Return: A referenced pointer to the exe_file associated with the mm_struct
> + * nested in the supplied *task*, or NULL.
> + */
> +__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
> +{
> +	return get_task_exe_file(task);
> +}
> +
> +/**
> + * bpf_get_mm_exe_file - get a reference on the exe_file for the supplied
> + * 			 mm_struct.
> + * @mm: mm_struct of which the exe_file to get a reference on
> + *
> + * Get a reference on the exe_file associated with the supplied *mm*. A
> + * reference on a file pointer acquired by this kfunc must be released using
> + * bpf_put_file(). Internally, this kfunc leans on get_mm_exe_file(), such that
> + * calling bpf_get_mm_exe_file() would be analogous to calling get_mm_exe_file()
> + * outside of BPF program context.
> + *
> + * Return: A referenced file pointer to the exe_file for the supplied *mm*, or
> + * NULL.
> + */
> +__bpf_kfunc struct file *bpf_get_mm_exe_file(struct mm_struct *mm)
> +{
> +	return get_mm_exe_file(mm);
> +}
> +
> +/**
> + * bpf_put_file - put a reference on the supplied file
> + * @f: file of which to put a reference on
> + *
> + * Put a reference on the supplied *f*.
> + */
> +__bpf_kfunc void bpf_put_file(struct file *f)
> +{
> +	fput(f);
> +}

That's probably reasonable because this is already exported to modules.
But that's not a generic argument. So there'll never be kfuncs for
__fput_sync(), flushed_delayed_fput() and other special purpose file put
or get helpers.

Conditio sine qua non is that all such kfunc definitions must live in
the respective file in fs/. They won't be hidden somewhere in
kernel/bpf/.

