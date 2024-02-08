Return-Path: <linux-fsdevel+bounces-10714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6E84D87D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FF1C212E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 03:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DCB2576A;
	Thu,  8 Feb 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S84Rrlwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777A23769
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362322; cv=none; b=P3QjWj0Y36wf2h6UyXh/EFp2JNLdikwaNSPNIA63iXL8smPBz3FqmYwoJIMBnz27x5hkRVd9WdSgsijoamS9mSgqb2e8N4GfMcGZDTZz+lme2PJRAmBC3LGCGOPCwqVyJdD/VlDTsYDR99gcajOuckwZBOJ1o51ZjULvGIsVPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362322; c=relaxed/simple;
	bh=YzvPq98fcc53KPXN3o/EOZSLK+Tq38l7lseskpy4Be4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=eaTosLTQcR+WVp/jEJgoLg/TDUJNMVO54xnrKnFz9r1JNT9i6HoDs5dw3w0UVfTzDfZ3jSPQm8mj/HjgFbZb/Z6GmDR3pqQGCKxrmTU+lTUEaiMniBWqv9nfiKoh5D5l+hCkXkvV7+S+IO8RxaI7n03TSFjywJS8O7QzMIIrzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S84Rrlwr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42c3925edebso11343121cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362318; x=1707967118; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akq55Qa8ArVpFdym0liNQv3sXRyyD/vcw1QWZK89bEA=;
        b=S84RrlwrV+fIH3LACjE71r/jhGquzoF71sKc5NlngPDwaH5QmPbR0/CEeaSHtKeVzo
         Vo6ESeoYxPGUK5valfMurk/ol0KIO07lIlUaeObvzsvNYuM406LymhOCvSRSg9CnZPEL
         wvivhg0CHKPn6rICYFdLTRDm5wzWeIlY32CqrsSW5GRMYABuqcNMra1cyaABFXJbK8lo
         rkxFj4+vwVAR9HyiUYPBcJYqwIG923Aj6Q1vW2Zb5euGf8pugaEjov6GheUMVWmHldfV
         dwo95k3snMNobqyAVKlnI7IPtdQofD/Rxb8k9f3t4u7+83QMLjS2rp4TbVZ05QelWBAr
         ZXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362318; x=1707967118;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akq55Qa8ArVpFdym0liNQv3sXRyyD/vcw1QWZK89bEA=;
        b=vBMFhyTaQknnt1jPY9VvyoUuAa6WdffLSun5NW3GCgbajEtVB6VuaCkz+YRkqnTbNf
         mSv6W7+rBbQkEbzcL7/64FcGa62LQyG8Dgmywy9YIA6voYJ2yOXczpGeo0NCWuJ9YqwQ
         EEhmCHWfJCup2l8Ogig99Z8mAKsRABN33wArttOykuaDKWjy38nPS+1nX61Ihk/G2tW7
         Mz6CgSV8bCuaUxMabQWB6So98aZjcxm7mRVjjGLaqesebNMieARLLuRysfY49yZKeX2K
         De0pSrXDx+iUzMcVyGUO4qjxuUfKJU57gARIz2sb5Q+QQ4tBFhZ7Kca0sfeZxkT3+Mgw
         66CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF5XEG+p5C6UlC+x7EKr+qRjImJ7Hj+HO/BK+tu+Y6ZnfyYX6HaaK9fRBa8GisraLQ2iLxb9G5Cote4Z/M7F1pz4AC+Goilu5ReqfuqA==
X-Gm-Message-State: AOJu0YxFGO3fy35Xuue1elYLy2mQdoY0eUYKXHJ2Bka9Dbux14CwNuep
	3EWsLfG0lEzA/upn4JBtqlPojmvd9+ybckmnk/wvhPuId2a8y0sKoTOC3HNESA==
X-Google-Smtp-Source: AGHT+IEcyq0GMBWXKVAYE9r+x2SOx0/uk+ns91BJCj2ArpBhVCymlH8RmtfxiAXBQZvVcY3rijO/QA==
X-Received: by 2002:a05:622a:1806:b0:42b:eee7:b33b with SMTP id t6-20020a05622a180600b0042beee7b33bmr9964311qtc.28.1707362317532;
        Wed, 07 Feb 2024 19:18:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSJf1UfUoVB+Q0MWO6Mxbq6AozXyARonbqfOmwIIr2TTxJqM3V/Vze3yCs5JcfuHykv6JkPpemjyywNo309jKw0TZsoiLD/beYhms5e9ORCbfehu7EdPYqGzVzr0N5xNRN1t9+T4VHRJMs0yRjp35/Fbuwj9+xZsAugF4tTCHH6IlmOT8DKWaZxE+7iJQmaiI6M4qhciyGHjPkCVIEURclyCz+aChtG3pdR5+GxYAa0vmvQ4HrXiVYVNimYCM9lmeaPUpHQyo7S2KhPUVQLLxCgzBAIlrnSbR1pO6qN4DQDEWxMmm26CJ3ArEV+UkdnzQfOmmBv3xSv81ReQ7fQXyyLst2wE4BvHhJRFGY2HXX5r2Wsn99NcLrwo87IBoQQztJVsy5Em4Y6zjzi6wfwNp9ZDo+5u7BJuxFYJ1+nvRjdpecB2tYFvkuqfLBrfhNyuHyiY8gVFWiWOH3q2ETkNt6CCk/fy+r8ixV4ZfbZ93X15BTkxh+1vheg1nIQfQwF8xCFVvasqtcoAWm1d57oF0yHWb0wCNvHe2wiJ9GC5+QOO4lplSpkcIdwfRuCi0uOr5fAfdLgPZqqHL8GeN9ud0Gh9+gCk+6TcZdgJgbibqCOULdvuCu3qHYPSevR7iUzx7+TPca8QLLaGJGx6FIfQUwJwsiVe/ob294/HiUZNASufA+n9YRGcboOuk2fXxcToshd5I15bH980Vya7bExPFrAU8IrM+/C/asOoR/iId6JQWcoaECutZSYMXsbaSPknAPuy8q4yqkOUU7rfbAO3sEb9crO6GPomVlg26HXhmVv66+4Xi0OZWnlcUsBu+6le1mmLloe5QLZX6nJMCpGWN5mljdTkstxxa7qIsXAH8uDrmJp2S4Aq5dAkR8c6K6QaiwBE0LUnR2c+81cAyAqLHYdnXXqzW3+PwQ9O+0n7IIZvIo9LNWOR12Cfxf0oZqsiaUak
 ZyY33lbQTNRcc=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g22-20020ac87d16000000b0042c45717dbesm669434qtb.53.2024.02.07.19.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:37 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:36 -0500
Message-ID: <9edf46c0c2060564bc4a52db6fbf54cc@paul-moore.com>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 5/25] ima: Align ima_post_read_file() definition with  LSM infrastructure
References: <20240115181809.885385-6-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-6-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change ima_post_read_file() definition, by making "void *buf" a
> "char *buf", so that it can be registered as implementation of the
> post_read_file hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/ima.h               | 4 ++--
>  security/integrity/ima/ima_main.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

