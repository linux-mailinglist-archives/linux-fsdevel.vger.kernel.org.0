Return-Path: <linux-fsdevel+bounces-10033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C8847333
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EE21C2244A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065B0145B38;
	Fri,  2 Feb 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yslwt4tf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8459210E4
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887930; cv=none; b=kWYEMoKJEEPl7MxLUUPw7g2uLujqa1yLelpEWNE+/S7DFmwUSn8b8QsJGucrH2LtE6VSEmOFrfBQx8r7XmzxqJb6U2q82Isjqd9DwiFfTePllwW126z6KEduTP8qIiUkOoUCw5oZ0pUoeEkbK+e9zVvyiVFf5auOBSeZWNELrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887930; c=relaxed/simple;
	bh=LB2tM7M/vojvvD9pvT8qCxaHqoBfTDEqvLcRwrwirJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DHAZbz8TvFbAAd+DL/vRGaxWdfyFPfVE0G6ELwPsQUfqppBrMAbksTpr6xmkBk8Brl6Qli44FtCMEkI85Q5UIHrkeJEEfEuq3XKw+cLW8rnYc8LJb5FigunJZXF9xyDC1ed+flTcDrERpv8Qzu9ZfQDbq20AtKsKWwDBVzuQoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yslwt4tf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IM5ZcaZa7yAGe/RxsbA0xm4coNhAXOwcBQuiu+U+L9A=;
	b=Yslwt4tfZwWZc07/Y1V2EsIuBfawaHqh8zAxyIkPMe8UZNNdgJ5G0pIWCr3rDMEy2W+5eo
	xtBJUh/U4Eg8W2TyFKEAyyhHL5cCmO9PWLKdRUdOgClvLnEU4DzAvfDW4ltQ7AGKewiQwq
	WDPWGfFGAPcKLNPOVAP8MA3LqQAVP1M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-JWxdHL0vO2WMUAKFld2Snw-1; Fri, 02 Feb 2024 10:32:04 -0500
X-MC-Unique: JWxdHL0vO2WMUAKFld2Snw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-290d09f47daso1972230a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887924; x=1707492724;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM5ZcaZa7yAGe/RxsbA0xm4coNhAXOwcBQuiu+U+L9A=;
        b=lPXM7tDzEVu+lxmsm7i/+7zoo6iF2RDVjUuDF5eOwPBV6JAui1ImVpx6jcO3lFkv/j
         FbqMz/8V2zxgmnAbl9+Cdyoi5aRTJA4RFy1cjzIta9NuC79RRYD6CeZhBasXRxnodI4c
         TmGYRz0zhgDvmINY7owUbKeeT4vAKYL91FR9H2KYflM+Ej19WCmqJLdFkra/cb6Wbfe6
         gZ4cIgWwhP/GaqgTG4/9q/XDEtxHfGGjfmLSNF+zcHCiEQ188zfMUY611BNE0wkwEEX5
         JeM6YuugPJc6Ye4Ywr4xds6RRwt/NvaIACt4xOBC+whjuF8+hOdIxT8hjoToJDFrYwo8
         dUEA==
X-Gm-Message-State: AOJu0YyinVKcDwsP1jSJhIuJOuiIrluskbH1xiZbBAIbPmcuTfijlyJD
	brm9BMjNw/NNLFjUXES7IuHTK1u6coX2Egy+OmyUCZKOeUpCHu6GGfcdVYb4tliW4ryKd2+p1RX
	cN4pSrwJjLZmTxngX5kvtqEEvHVaajb/MuSdQsxKBMjkLKr+3/L8pz5pvNadgIB21FRUqbCfwe+
	LICOqYAzw/GZwUYYz9YAOZ8eUPGKXnST18B7LedA==
X-Received: by 2002:a17:90a:744e:b0:295:e24b:62e with SMTP id o14-20020a17090a744e00b00295e24b062emr7819860pjk.6.1706887923773;
        Fri, 02 Feb 2024 07:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF03sJR3jRWqPFscANuSc2fRI9wXu+W40DwRQn5GP605LFjRa33EKNRS0ysXmGh0QHmT1WpDp6Hp9YV+m8zQC4=
X-Received: by 2002:a17:90a:744e:b0:295:e24b:62e with SMTP id
 o14-20020a17090a744e00b00295e24b062emr7819845pjk.6.1706887923501; Fri, 02 Feb
 2024 07:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 2 Feb 2024 16:31:51 +0100
Message-ID: <CAFqZXNu2V-zV2UHk5006mw8mjURdFmD-74edBeo-7ZX5LJNXag@mail.gmail.com>
Subject: Calls to vfs_setlease() from NFSD code cause unnecessary CAP_LEASE
 security checks
To: linux-nfs <linux-nfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

In [1] a user reports seeing SELinux denials from NFSD when it writes
into /proc/fs/nfsd/threads with the following kernel backtrace:
 => trace_event_raw_event_selinux_audited
 => avc_audit_post_callback
 => common_lsm_audit
 => slow_avc_audit
 => cred_has_capability.isra.0
 => security_capable
 => capable
 => generic_setlease
 => destroy_unhashed_deleg
 => __destroy_client
 => nfs4_state_shutdown_net
 => nfsd_shutdown_net
 => nfsd_last_thread
 => nfsd_svc
 => write_threads
 => nfsctl_transaction_write
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

It seems to me that the security checks in generic_setlease() should
be skipped (at least) when called through this codepath, since the
userspace process merely writes into /proc/fs/nfsd/threads and it's
just the kernel's internal code that releases the lease as a side
effect. For example, for vfs_write() there is kernel_write(), which
provides a no-security-check equivalent. Should there be something
similar for vfs_setlease() that could be utilized for this purpose?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2248830

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


