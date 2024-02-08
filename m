Return-Path: <linux-fsdevel+bounces-10731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3016384D8F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F005B24C3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57E3C46E;
	Thu,  8 Feb 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JtHStRyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1FC1E895
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362341; cv=none; b=Cs7bFo/mN4BN6xVGz5FsmXtiw+weFi+1RRSVKGmiC8mPt2pdpnPrMymL4wXJngYLH70WZyX/RtXrhWrMgzF9Sy64/HnSWmmQgzst4sTKet3f6Sq8U3lboKZpk4x87qdJdiYov6jBRE1DkW4FKVAW2M2RSEQYpbbdgKm47JtE/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362341; c=relaxed/simple;
	bh=KQUeyHRjjjfkXBsIEL6L0ca2YK2iVKA66TMwHDEgJLc=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=YN8sKbXyydqWWokUmmlCNIQBudhg7eOkV7afPZbZnZOZNFBvh5G21+F6vDrlvr1BTd+KgNqfHV9Im9S2T8gHyizU+5fY/7Sh5TKDgdQw0N9+TE+jNNtotFAG4Fnn4nqwFxjEBRDEoxxBECKV5iF7yJQNSRWGx7IQdZgBfh1q6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JtHStRyA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783d8dff637so77877485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 19:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362335; x=1707967135; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HbV6n5Xe+U9VQs15xw8hF94WBGgVQ6IqJUpf4t2Cj8=;
        b=JtHStRyArAV6qXTZYie2SEnksCji8DH/VPNUvL9PJbBrnCY5PT5dBlpudfwIqKPyU0
         JSZXEA8+V+Yybsl7AxVJdOxWP/kGIdHaxmxpQRlkL5hDSC290Z2TfN0OkTeIs3MqMm80
         tjV4sSRK/Jd/XPIqvN8ea/JmbEyE2iDQZ2HbcRA1whA2a09LnmEO3H1RrSPwgzobnJUE
         L9fu3EMdTdFzgy0DXJrlCk7+AvWsG6psbyQ1ZwPLZxwi6oN5Sgxpj4wZ1qLkm4t1Fs/l
         SDjNCq7EY+OmtNwJg72N8v+ULxjvZzpXa+dbEGXfasp2+n7zaF6I+qALktENuqaR63AL
         BrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362335; x=1707967135;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HbV6n5Xe+U9VQs15xw8hF94WBGgVQ6IqJUpf4t2Cj8=;
        b=EJEPvjH/JBwlZtljIGNfGTWdsFnqLph0a9vtiWEKewKlpRqBjNleO5KsHRR3Adpgm3
         De38avf++S7tM0KkKPoUJcl8h5fy47N52RBVRdGInDX8t4El36kxKP8iL60J3TRa+Xyx
         w52gnNfidZMUgmTrt+MJAZPbXSgt7m/IblLFmfRGY9Q2xUpoECBV0ODzUyARVs0ZgpkA
         RyC5vJsAWDlfN6+fxhT0/QVPyB5lGFbZKLNWhOhKOx2QB5dXP6uDfp+7HFbGfbrjTj/u
         xwMskvVdYQipMdPfpF5Csz6N1YGvZSqIRJ+W/n2s4o0aMU0Y+zoCwxVAj4UtKm1IxVx3
         c3uw==
X-Forwarded-Encrypted: i=1; AJvYcCUlrmvQweN6PbhaA2dgl4ItMDDLUUXBSYNdsmnMIRWUYiTckCW/ngXIbHfKhd49i0Dm3+FE4uS/CUGlD4hRRqxrAKZLbWFg13KH/QKpJw==
X-Gm-Message-State: AOJu0YzzWeG1fSR8Mjc4exfNv2pPwF641GhADHfCjtmsKYI9B2c0yJTm
	1k7W2ua4LyfwYZQ/b16qq+sdkJJwMshr5iob/GXEo1RpS+wkGL37hrWkFKKHNQ==
X-Google-Smtp-Source: AGHT+IFe+/APvbCWtvo7N2W3i0NQXu9Gs9w9JTuWRhznOkmr7yr1wYV203/mfil2cu0WaHv52vgoUQ==
X-Received: by 2002:ae9:f409:0:b0:785:5f32:740 with SMTP id y9-20020ae9f409000000b007855f320740mr7838921qkl.39.1707362335378;
        Wed, 07 Feb 2024 19:18:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtN17sT+I6NFUtc9YVAcwA/4nOIepBd/awHURKOWvyqf2iOPCRYu/xZo61LlW3PhbEnlpAugC7HczUqpDrtk7am8fPE2Qoc5nUQ/6krZlIkRXgGvestiiELaxdSTnxpfY7nBv24MWpdo9LxdvsHoRbn8snPMxGOyo4EzhJs0Ev5wJS8M+DiT8VE351BE0VKs06oc2/yjcqOnsOSLj6KjmoDDeTj8lUpEdr7an/glsFlcSjYyEL/ngVvYhDUNGKR6TUV6IAqV7mw3eDfvEXjHgxYrqHvuKKUAvkJcp/Ojp/bygVXNunH7dJpdbB0YDqnpAMJV/yaOwMtvbJ2bNW4gPy5lOQk9kgFht9tMCzxHQ3t+tzVrUa/25LWHWShk38RB2KhRiH6xgBvVDhiQpBo8fep5YrMciQ7PJpD2xyPvZTVML727aa90umcYe9FqvbFUkT819euC3EJDsTAvLMSol6Y5wbdlHEV71uop/E/lKZ1d0wKYDJWQX7med93AHe46EgaqBdlUjnY+KVJNrXqeCJAvq88LIbQj3Isw2126nGqSvPEizprgpxphO27igaPJIkrb30HQh6o2NpsUjQJkRaC7/0kQ3uWs2iQgvmvO4PU/IcsqmoWquKh5yixMCUMbg5G60hQHVfedFGwQW0T/xAcE5jXAem2FFxcjPydtdiPVMIg3Ej2QZQA8XWwdGCxV/RrgX11tPEtYE9ZvPRl+9o2HzhNz4DqR+aK4ksKhL3uH9B9I8pSDMywMm7ZZDagJnrCwoa5nZaR8rAtjyS6O4FZl7+Ui8h48ysagamh/D4PPjMshNo8+GiKPGTEs3Kws9tsJTyMh1v1rnIy4J8BqmOy1fR6DlauNkcSi7uFhxBZ71752s7HaHMNzB4pm0Xpknb8R0PGYWGzhsbX2KQ44GvfMXWEs6gdD4csl2jHSmhmAc19LlA
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l5-20020ae9f005000000b00783d75b2335sm1071913qkg.11.2024.02.07.19.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:54 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:54 -0500
Message-ID: <1c6b3d9d21242d63937668e8cbfb3c75@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 23/25] evm: Make it independent from 'integrity' LSM
References: <20240115181809.885385-24-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-24-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Define a new structure for EVM-specific metadata, called evm_iint_cache,
> and embed it in the inode security blob. Introduce evm_iint_inode() to
> retrieve metadata, and register evm_inode_alloc_security() for the
> inode_alloc_security LSM hook, to initialize the structure (before
> splitting metadata, this task was done by iint_init_always()).
> 
> Keep the non-NULL checks after calling evm_iint_inode() except in
> evm_inode_alloc_security(), to take into account inodes for which
> security_inode_alloc() was not called. When using shared metadata,
> obtaining a NULL pointer from integrity_iint_find() meant that the file
> wasn't in the IMA policy. Now, because IMA and EVM use disjoint metadata,
> the EVM status has to be stored for every inode regardless of the IMA
> policy.
> 
> Given that from now on EVM relies on its own metadata, remove the iint
> parameter from evm_verifyxattr(). Also, directly retrieve the iint in
> evm_verify_hmac(), called by both evm_verifyxattr() and
> evm_verify_current_integrity(), since now there is no performance penalty
> in retrieving EVM metadata (constant time).
> 
> Replicate the management of the IMA_NEW_FILE flag, by introducing
> evm_post_path_mknod() and evm_file_release() to respectively set and clear
> the newly introduced flag EVM_NEW_FILE, at the same time IMA does. Like for
> IMA, select CONFIG_SECURITY_PATH when EVM is enabled, to ensure that files
> are marked as new.
> 
> Unlike ima_post_path_mknod(), evm_post_path_mknod() cannot check if a file
> must be appraised. Thus, it marks all affected files. Also, it does not
> clear EVM_NEW_FILE depending on i_version, but that is not a problem
> because IMA_NEW_FILE is always cleared when set in ima_check_last_writer().
> 
> Move the EVM-specific flag EVM_IMMUTABLE_DIGSIG to
> security/integrity/evm/evm.h, since that definition is now unnecessary in
> the common integrity layer.
> 
> Finally, switch to the LSM reservation mechanism for the EVM xattr, and
> consequently decrement by one the number of xattrs to allocate in
> security_inode_init_security().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/evm.h                   |  8 +--
>  security/integrity/evm/Kconfig        |  1 +
>  security/integrity/evm/evm.h          | 19 +++++++
>  security/integrity/evm/evm_crypto.c   |  4 +-
>  security/integrity/evm/evm_main.c     | 76 ++++++++++++++++++++-------
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/integrity.h        |  1 -
>  security/security.c                   |  4 +-
>  8 files changed, 83 insertions(+), 32 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

