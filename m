Return-Path: <linux-fsdevel+bounces-29218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E08977340
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D6D2867A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC61C232D;
	Thu, 12 Sep 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwSk6H6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AB1BF7F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174791; cv=none; b=KdA1NTeD29ilMc6sz35KN4Nzyo797P/rqXoEzezS0J13FYNvxhgQdf9c/iHiGe26+CJoU4aDDRVD9glRhDgrWzUUXI6hy2nnSEfr8Yfdw9n5Z4LQgD07lPk9gyX/5MlXmcbJd4Fv3ejvwU4MXYwv8nL76Rd+PVFuebjuhR4DpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174791; c=relaxed/simple;
	bh=cAbAdJfAWvXcMGzLQXEJz8mvDAf9C94T25Rumz8sqaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOk/l/W83oDakBUlq0+ZNZMlOd+vXzmcKej3N8uE0pZFJz7NPTOjtRoQ4W4MoNtt7m9qZRDqqvEjFdqbLjzivNqgQE253A1d/9YXAUObfYU2MimHwBHO39k6DPD5JSXaXWqXBCeBCdNaNzQE96eHPjbuD/YFHsUfrQJaEZCPmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwSk6H6F; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277cfd3f07aso627196fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174788; x=1726779588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mM5Z0KLUO8efTiZgA6ECQxJ5r+uA/1F2hapQlso44M=;
        b=fwSk6H6FwFSImla2JI4db2pKAihE3YGTsdT6hM7GiyLo8SRYVdzhLPUrn5lI0G4KXC
         bKOqdpt9tLhJkQoG9TJfdFqctjoJXVjK+WS4grWX2SGXuPat7AvL/3nTrGb9ZU1e5pTk
         8wsnnRYD0GJAqvSAq7s0OHt8leWJKpEMZvvtvTBK5bvZmBROM1v0Lzt30OoCjXXDqiCj
         RuOdhh8EBGO+/mX+EJN8eT99KItxRnyvsgtua7OzQ0XEftb2ryV6PFR9a1oi6UO8TshT
         H+H2WCqRy/z3JHygHgUcpjaDm3rt7rHd3EMcEeuuVKkk55Vd97MD1X4vqC+qVKehiOC2
         cHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174788; x=1726779588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mM5Z0KLUO8efTiZgA6ECQxJ5r+uA/1F2hapQlso44M=;
        b=GMVb4VP8DfIsTsldsmwLuQr99jzk+bUravZVuPtNf6xP0sYI9TuD7zdlvLsdKVDrQB
         oDM7Q+Ln/feBiF4aqNZ1xXteAeC0xIRtvo7ntOj7HpPwmqQtV0bbM7gudD9UnXDbuiMB
         OCNRO4iIvK4gzhRSXY9WgYtfwd4mimIr3Uk0ij5WPjlMdZThhr09VJOWO2n6r0CP+ax4
         6V0sIjvacNjADTYBUfTaRsnAJfFtebeOnWB+s1Bs/K1loR8NDIQixNiojC2uZxEj3aZC
         BZAGyYGlbc0XdHgc8O3DCCiKVAfIdy3YUHnxZ7ApSHNkZEsZ0k2XWf5i4i5hS1EOdGp2
         Z4iA==
X-Forwarded-Encrypted: i=1; AJvYcCU4ETPK9V3pyCyem70S0Pp/qkY4NvV0CU+tAzixs7N7TGt0/PIZgTr8qEdnSB7TVDpdniMYprW9nX+cRRVi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8w4hfoOOXxIUVi+NOPzRYxGsSu34pggr+pbQFvRzQag3GUeyp
	+RHqgEXdOcAVAPqQkytltm8Tyd31vDaTq8/1Fb+sRvANI1jNlrdqWk4Mvx7kcZUdt42vOsqqhvX
	O1g==
X-Google-Smtp-Source: AGHT+IFM1AXJ051IzPPqsl49dRXV3EAPdU7MADRa2Tisd07EWLACnR0AfN41J2K91Abg++8l1F9PzA==
X-Received: by 2002:a05:6870:610c:b0:27b:6267:61b0 with SMTP id 586e51a60fabf-27c3f603118mr3165118fac.32.1726174787877;
        Thu, 12 Sep 2024 13:59:47 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3f3f125sm3276542fac.25.2024.09.12.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:59:47 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:59:42 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v8 2/8] auditsc: Replace memcpy() with strscpy()
Message-ID: <u42f2oneitzqmzh2tvwokzjxawj6utitu7rongurqeiglkvkvc@ryjktmvutysi>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-3-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:15AM GMT, Yafang Shao wrote:
> Using strscpy() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach also
> facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> ---
>  kernel/auditsc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6f0d6fb6523f..e4ef5e57dde9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
>  	security_task_getsecid_obj(t, &context->target_sid);
> -	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
> +	strscpy(context->target_comm, t->comm);
>  }
>  
>  /**
> @@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
>  		security_task_getsecid_obj(t, &ctx->target_sid);
> -		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
> +		strscpy(ctx->target_comm, t->comm);
>  		return 0;
>  	}
>  
> @@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
>  	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
> -	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
> +	strscpy(axp->target_comm[axp->pid_count], t->comm);
>  	axp->pid_count++;
>  
>  	return 0;
> -- 
> 2.43.5
> 

Good usage of two-argument strscpy(). This helps towards [1].

Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://github.com/KSPP/linux/issues/90

Thanks
Justin

