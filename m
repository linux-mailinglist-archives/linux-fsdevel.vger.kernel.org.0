Return-Path: <linux-fsdevel+bounces-22869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2F91DE85
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914F8B2371B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEC14AD0D;
	Mon,  1 Jul 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="G5aEq+jm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qft2T1tm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01C84D02;
	Mon,  1 Jul 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835109; cv=none; b=umiKsA6HpgnC4qANi4JSV8GtqK0rRA1PcvBVYBeGWf1p1mS7IItduvTA2SDRKJCN7gwmyfcp+mOj3f6w1dRSvqXH/nrkrEUZBSTvfFSIPRgXpMJbvJwjjfc/AYk/JUKD+x3ilQwkdTPIb0rgHTzuJq2ri4Mle5a8t1tdquOV6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835109; c=relaxed/simple;
	bh=WaV/uifT+ewSSQQt4FXzBE5fi9386OXucSBJ4NdlHxg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YrBL5Hw5ginkdT2LT/ScunyEh91N2vjBgME0wq2AuhCrMGtlBDF4+NCy/Q8F75Ci+ZzZIgWxVhom2Zd9NShc5aE6vsdr31oLsIWmWeDsqlH64AzoDLjUQ7MZySqOdBy/8DMryrzye7eitMKK/+2VHpDPmySsxGP6mGRqBoW0mIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=G5aEq+jm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qft2T1tm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7AF251380463;
	Mon,  1 Jul 2024 07:58:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 01 Jul 2024 07:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719835106; x=1719921506; bh=xTKFbyMCes
	YSqTGV3kNBw9DLS4BP7bP5n2sMbxKcREk=; b=G5aEq+jmJLeuDeV0mrL7Ml8cY7
	9nWyr1HK4KhJYfPTaqFVqA4+bUYJObJisUcDybkcPMermDTU868P+bbZmyc0ghuw
	R5DLJeJMdWWiaKci/VBvBSWxs4hy5ZW1qcmI9iZca3edwpUovEf/vhql9fSaFmiS
	D1h3BrjoaE2X+s0SsUnxAYNflon6tnTQeOWY3nupbgWEkGzLjmS8SIJkdXbf8zR2
	SFVFPSMMA3db5jkzqnSXH4c3q2zaB/r+gzBO01A+qj82aAdG8je7072ZmDRi/msd
	Vvobyeocvxx+/UP1ZV86CXlhHGWA8qascKYcnIImd3UpyQXNRGop0o0cRP4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719835106; x=1719921506; bh=xTKFbyMCesYSqTGV3kNBw9DLS4BP
	7bP5n2sMbxKcREk=; b=qft2T1tmF0gPXJxQcjqJ+4qMDmqirl2p6B6IORadaZ1D
	pWI+i0TQJQkbGIODQmkDqEn0Z+ZWmIWrGruBUAE/qdvn4asyC9XSyTsB9dOdqoQJ
	XgpJgkbxIPTfYqHwtPxv8l7KfkGpZb1st22hLpk7BCyNjCsxdyHsNVOlUW2ocXWl
	XpuWmyTyhdZrfeMn0XMua3OlsWsmKq40vxBmQU2LrNTYWx0kjPBwKkWJC6ck5Y8C
	ZpjBxfdfb7Wbzz88KTv8Ow3dcYG0zZHTFhYEJurQoggIbTvhKYyVMYQuZrctBqKR
	Aef1ki5U5uQl2EXfTzXtWBkCGXZmKi4YIg1UXZhfrQ==
X-ME-Sender: <xms:4ZmCZtUsbU2QX-zvIyWPJNmWEyzOzwCQ0_2vrxkGXVlPDBGY7Bcmxg>
    <xme:4ZmCZtmQFWA4lE0IfzLNO97EeT5K7aGQE8mh1-AhB4j99UwA8ItqGQ51NolRDB7jJ
    B3oz-uA60J0vx31SSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:4ZmCZpb6vfZ-oV3D0qYPBc5RdopwhTRFByt7c6FNhRIE7e0I8jZ1lw>
    <xmx:4ZmCZgXiMRn0_cjj35lltXsOr7swBAekdVNWy8iU9529ZQij8gNmfA>
    <xmx:4ZmCZnl-LXr2HnkGZcIv-6hSFxVSSjA7elFAR9bOwl2hyDhBYIdWOg>
    <xmx:4ZmCZtcrcuuz67vXwTxThdxLypZczJdZrQIGWr9jTBvBJXZF4M3yHg>
    <xmx:4pmCZgehxJ9HzZqzR2KYamrvGgKCzJG7XJxoFR5Q5BHDLP3M75K3-9vU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C1BE1B6008D; Mon,  1 Jul 2024 07:58:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f1f44be-80ad-4b4e-90a0-c2e4e8cd3dbf@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYsk85UOsa0ijXcYRvvZLXEMQKe4phWhND+0qSNP36N5Tw@mail.gmail.com>
References: 
 <CA+G9fYsk85UOsa0ijXcYRvvZLXEMQKe4phWhND+0qSNP36N5Tw@mail.gmail.com>
Date: Mon, 01 Jul 2024 13:58:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 lkft-triage@lists.linaro.org
Cc: "Jan Kara" <jack@suse.cz>, "Christian Brauner" <brauner@kernel.org>,
 "Hugh Dickins" <hughd@google.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
 different size
Content-Type: text/plain

On Mon, Jul 1, 2024, at 12:19, Naresh Kamboju wrote:
> fs/proc/task_mmu.c: In function 'do_procmap_query':
> fs/proc/task_mmu.c:598:48: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>   598 |         if (karg.vma_name_size && copy_to_user((void __user
> *)karg.vma_name_addr,
>       |                                                ^
> fs/proc/task_mmu.c:605:48: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>   605 |         if (karg.build_id_size && copy_to_user((void __user
> *)karg.build_id_addr,
>       |                                                ^
> cc1: all warnings being treated as errors
>

There is already a fix in linux-next:

@@ -595,14 +595,14 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
        query_vma_teardown(mm, vma);
        mmput(mm);
 
-       if (karg.vma_name_size && copy_to_user((void __user *)karg.vma_name_addr,
+       if (karg.vma_name_size && copy_to_user((void __user *)(uintptr_t)karg.vma_name_addr,
                                               name, karg.vma_name_size)) {
                kfree(name_buf);
                return -EFAULT;
        }


This could be expressed slightly nicer using u64_to_user_ptr(),
but functionally that is the same.

I also see a slight issue in the use of .compat_ioctl:

 const struct file_operations proc_pid_maps_operations = {
        .open           = pid_maps_open,
        .read           = seq_read,
        .llseek         = seq_lseek,
        .release        = proc_map_release,
+       .unlocked_ioctl = procfs_procmap_ioctl,
+       .compat_ioctl   = procfs_procmap_ioctl,
 };
 

Since the argument is always a pointer, this should be

       .compat_ioctl = compat_ptr_ioctl,

In practice this is only relevant on 32-bit s390
tasks to sanitize the pointer value.

     Arnd

