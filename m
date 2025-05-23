Return-Path: <linux-fsdevel+bounces-49752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4BAC1FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44CA1B6824C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3722686F;
	Fri, 23 May 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy8+Abc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DD226CE4
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747993211; cv=none; b=LcRzfQxYMYGulmh8Tc+VpeMyOQPemLODbRmnKIWFjl6jxva5eENTBzltEHYGJdV9ZAuk1NC0A7PmwaDZRnjuzTz8GjgIZMWjyyNFUq8iyHOcmuvCNQRwylQgx4KdxAyuORgQTQkfab2oW4fF7kvFpT/zHBwKU8oCqbeuRI2j628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747993211; c=relaxed/simple;
	bh=EyjIJJ1aJToH0hBOVAR+EF+V4bSXXfa03bGAG1Wq7yc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CGUz6c2QaK2IDqkfSJ1K9NmfaZIzjHDHipELOyfWSeqWCZkqPn0P/3dXmw6bWlGFGs2Is3sLHx8hhDBnz/fhQAlfwdG17Z/cxo7IUp6IjPrHhbAMWPsNHEVMq9UdnFabYYgPqGreK1sphwXeNVO0i/Gpj6YlmjaCbwrocnf3nHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hy8+Abc5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a374f727dbso4037995f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747993208; x=1748598008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmM7wl7FfXANU3+HoiZcpwWBrDC/gYVSs/BA58caBms=;
        b=hy8+Abc5A4/XW+63VgDf3+BNSX2ukieLdkuV5SZTG7uZYGo8cNaF475Ob3Yg+167mZ
         OCB1Mtat+uQYW/1FEhRF9Wx2VkYk40XAzfg7s2LtRbs5ZS2dolfWWECYmjMkol5tcFC8
         lWRfUufY3MRohOJiWmGNB9Wv1Z6Rg69/QpOvnPcHtsG0ixVAX7eYPSsEERb9QJ3o06NT
         /8qin1CEctylI+IqAVU+cxyd8BsDuWycmjKTuLFPv0kCF3tedZL6CzjrW6YOiszwUIoQ
         VZOrdkRJC70DnIIBP51h0tvfi5lFsW23u0p1iVxLJuCOxVJ+fPWA9h+oz9FfahZ7jZK7
         HPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747993208; x=1748598008;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmM7wl7FfXANU3+HoiZcpwWBrDC/gYVSs/BA58caBms=;
        b=L7+O4ob7sH85fNuryYqbW4ssQLeX4nHfru32IMpubrVvMZraY4c2Tza7TO9dUPoM79
         tqsU1bzfjJejWMjk61BFNYHEz3cIW4lgamtO1jMQhnVPj8TcG445WH1fT06z1xqueEWP
         Og0E1r/Zrm38FntEFPiMdTJ/W0/I1WZhqiTYGMd/+rgUeAUsrO+HdadrmPKegmXpNDO6
         PR2qpZlz93KHtPpjiHYDy5pk2LdcClM8J/8U7NOkmBnPf0nOkJpqVMo8QHy3t81jCrm5
         TwNGoA1X6qgtZmE5TBl+l4KQf0yhIey5owkRQV4YzMTf5JaowQdQRmoR0+zL6VHXDvZx
         g1nA==
X-Forwarded-Encrypted: i=1; AJvYcCVztujoaROOxPeu5Ne9W8SAIlDU0iLqb+hNYMLPh88Z8MYXjoonNMLoHyK830mJuBMu1782Y1VMJllNVqYy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgy+ltXcolta/Ymvw4uPalIgKXoDztRMjxzrVOzFg6POKwWJkL
	cH4wwx24byCpmojg0ra4OkpB9dHZQ00ULfKYFTGawRpQHESm5HWI/lP+ccO2GsVB/eI=
X-Gm-Gg: ASbGncupCxoXm8PBvQz9us9x6d8VqZrC7GDcTPt+YN8mN3xs05vaYR6wRaIPhKTTOk6
	ijEQz87JQGrWh99AMwmwlt6+7KOqThz1c/CCVudXOqhN4NrS4n58HEJBPq3YptY/q/3YsZ0PotL
	TDaMSxOybWmLltZxujJShPl+b14hVps8IScBkn7BWbShe4ZCpbbL3KP5BPswDEI0h/IBIpuYJOx
	+lgrBPAYbaBVUOMFHqleXzcRlL91Jm+o+6mBS/eMzPN26YHKXsCi+xLQpecoVVXbOiu1D/OdG09
	14Ls+EI3i0zWE3C3+oSsCZoL7jla3ZYsKzwCZ/kQs07sttW7ErjSz/guKVKLEjwknMw=
X-Google-Smtp-Source: AGHT+IGZNy6iLufcbGr1Cm4vscuZZ5cosVeDu++QGebNauJZVQ9784C5I6lmRFlz/knjxPIF4kXi1w==
X-Received: by 2002:a05:6000:40c9:b0:3a1:fc5c:dec7 with SMTP id ffacd0b85a97d-3a35fe67788mr24039998f8f.21.1747993207620;
        Fri, 23 May 2025 02:40:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca88a34sm25709566f8f.70.2025.05.23.02.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:40:07 -0700 (PDT)
Date: Fri, 23 May 2025 12:40:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Bhupesh <bhupesh@igalia.com>,
	akpm@linux-foundation.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, laoar.shao@gmail.com, pmladek@suse.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl,
	peterz@infradead.org, willy@infradead.org, david@redhat.com,
	viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <202505221104.qV4Iy0rA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521062337.53262-3-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250521-142443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250521062337.53262-3-bhupesh%40igalia.com
patch subject: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
config: powerpc64-randconfig-r071-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221104.qV4Iy0rA-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505221104.qV4Iy0rA-lkp@intel.com/

New smatch warnings:
fs/coredump.c:591 do_coredump() error: buffer overflow 'comm' 16 <= 16
fs/coredump.c:1006 validate_coredump_safety() error: buffer overflow 'comm' 16 <= 16

vim +/comm +591 fs/coredump.c

a78282e2c94f4c Linus Torvalds               2024-09-26  524  void do_coredump(const kernel_siginfo_t *siginfo)
10c28d937e2cca Alex Kelly                   2012-09-26  525  {
10c28d937e2cca Alex Kelly                   2012-09-26  526  	struct core_state core_state;
10c28d937e2cca Alex Kelly                   2012-09-26  527  	struct core_name cn;
10c28d937e2cca Alex Kelly                   2012-09-26  528  	struct mm_struct *mm = current->mm;
10c28d937e2cca Alex Kelly                   2012-09-26  529  	struct linux_binfmt * binfmt;
10c28d937e2cca Alex Kelly                   2012-09-26  530  	const struct cred *old_cred;
10c28d937e2cca Alex Kelly                   2012-09-26  531  	struct cred *cred;
a78282e2c94f4c Linus Torvalds               2024-09-26  532  	int retval = 0;
10c28d937e2cca Alex Kelly                   2012-09-26  533  	int ispipe;
315c69261dd3fa Paul Wise                    2019-08-02  534  	size_t *argv = NULL;
315c69261dd3fa Paul Wise                    2019-08-02  535  	int argc = 0;
fbb1816942c044 Jann Horn                    2015-09-09  536  	/* require nonrelative corefile path and be extra careful */
fbb1816942c044 Jann Horn                    2015-09-09  537  	bool need_suid_safe = false;
acdedd99b0f3bf Oleg Nesterov                2013-04-30  538  	bool core_dumped = false;
10c28d937e2cca Alex Kelly                   2012-09-26  539  	static atomic_t core_dump_count = ATOMIC_INIT(0);
10c28d937e2cca Alex Kelly                   2012-09-26  540  	struct coredump_params cprm = {
5ab1c309b34488 Denys Vlasenko               2012-10-04  541  		.siginfo = siginfo,
10c28d937e2cca Alex Kelly                   2012-09-26  542  		.limit = rlimit(RLIMIT_CORE),
10c28d937e2cca Alex Kelly                   2012-09-26  543  		/*
10c28d937e2cca Alex Kelly                   2012-09-26  544  		 * We must use the same mm->flags while dumping core to avoid
10c28d937e2cca Alex Kelly                   2012-09-26  545  		 * inconsistency of bit flags, since this flag is not protected
10c28d937e2cca Alex Kelly                   2012-09-26  546  		 * by any locks.
10c28d937e2cca Alex Kelly                   2012-09-26  547  		 */
10c28d937e2cca Alex Kelly                   2012-09-26  548  		.mm_flags = mm->flags,
95c5436a488384 Eric W. Biederman            2022-03-08  549  		.vma_meta = NULL,
8603b6f58637ce Oleksandr Natalenko          2022-09-03  550  		.cpu = raw_smp_processor_id(),
10c28d937e2cca Alex Kelly                   2012-09-26  551  	};
10c28d937e2cca Alex Kelly                   2012-09-26  552  
5ab1c309b34488 Denys Vlasenko               2012-10-04  553  	audit_core_dumps(siginfo->si_signo);
10c28d937e2cca Alex Kelly                   2012-09-26  554  
10c28d937e2cca Alex Kelly                   2012-09-26  555  	binfmt = mm->binfmt;
a78282e2c94f4c Linus Torvalds               2024-09-26  556  	if (!binfmt || !binfmt->core_dump)
10c28d937e2cca Alex Kelly                   2012-09-26  557  		goto fail;
a78282e2c94f4c Linus Torvalds               2024-09-26  558  	if (!__get_dumpable(cprm.mm_flags))
10c28d937e2cca Alex Kelly                   2012-09-26  559  		goto fail;
10c28d937e2cca Alex Kelly                   2012-09-26  560  
10c28d937e2cca Alex Kelly                   2012-09-26  561  	cred = prepare_creds();
a78282e2c94f4c Linus Torvalds               2024-09-26  562  	if (!cred)
10c28d937e2cca Alex Kelly                   2012-09-26  563  		goto fail;
10c28d937e2cca Alex Kelly                   2012-09-26  564  	/*
10c28d937e2cca Alex Kelly                   2012-09-26  565  	 * We cannot trust fsuid as being the "true" uid of the process
10c28d937e2cca Alex Kelly                   2012-09-26  566  	 * nor do we know its entire history. We only know it was tainted
10c28d937e2cca Alex Kelly                   2012-09-26  567  	 * so we dump it as root in mode 2, and only into a controlled
10c28d937e2cca Alex Kelly                   2012-09-26  568  	 * environment (pipe handler or fully qualified path).
10c28d937e2cca Alex Kelly                   2012-09-26  569  	 */
e579d2c259be42 Kees Cook                    2013-02-27  570  	if (__get_dumpable(cprm.mm_flags) == SUID_DUMP_ROOT) {
10c28d937e2cca Alex Kelly                   2012-09-26  571  		/* Setuid core dump mode */
10c28d937e2cca Alex Kelly                   2012-09-26  572  		cred->fsuid = GLOBAL_ROOT_UID;	/* Dump root private */
fbb1816942c044 Jann Horn                    2015-09-09  573  		need_suid_safe = true;
10c28d937e2cca Alex Kelly                   2012-09-26  574  	}
10c28d937e2cca Alex Kelly                   2012-09-26  575  
5ab1c309b34488 Denys Vlasenko               2012-10-04  576  	retval = coredump_wait(siginfo->si_signo, &core_state);
10c28d937e2cca Alex Kelly                   2012-09-26  577  	if (retval < 0)
10c28d937e2cca Alex Kelly                   2012-09-26  578  		goto fail_creds;
10c28d937e2cca Alex Kelly                   2012-09-26  579  
10c28d937e2cca Alex Kelly                   2012-09-26  580  	old_cred = override_creds(cred);
10c28d937e2cca Alex Kelly                   2012-09-26  581  
315c69261dd3fa Paul Wise                    2019-08-02  582  	ispipe = format_corename(&cn, &cprm, &argv, &argc);
10c28d937e2cca Alex Kelly                   2012-09-26  583  
10c28d937e2cca Alex Kelly                   2012-09-26  584  	if (ispipe) {
315c69261dd3fa Paul Wise                    2019-08-02  585  		int argi;
10c28d937e2cca Alex Kelly                   2012-09-26  586  		int dump_count;
10c28d937e2cca Alex Kelly                   2012-09-26  587  		char **helper_argv;
907ed1328d2a74 Lucas De Marchi              2013-04-30  588  		struct subprocess_info *sub_info;
10c28d937e2cca Alex Kelly                   2012-09-26  589  
10c28d937e2cca Alex Kelly                   2012-09-26  590  		if (ispipe < 0) {
c114e9948c2b6a Roman Kisel                  2024-07-18 @591  			coredump_report_failure("format_corename failed, aborting core");
e7fd1549aeb83e Oleg Nesterov                2013-07-03  592  			goto fail_unlock;

>               /* This will always be NUL terminated. */ \
> -             memcpy(comm, current->comm, sizeof(comm)); \
> +             memcpy(comm, current->comm, TASK_COMM_LEN); \
> +             comm[TASK_COMM_LEN] = '\0'; \
                     ^^^^^^^^^^^^^^
This was supposed to be "TASK_COMM_LEN - 1".  Also the comment says
it's not required...

10c28d937e2cca Alex Kelly                   2012-09-26  593  		}
10c28d937e2cca Alex Kelly                   2012-09-26  594  
10c28d937e2cca Alex Kelly                   2012-09-26  595  		if (cprm.limit == 1) {
10c28d937e2cca Alex Kelly                   2012-09-26  596  			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


