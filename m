Return-Path: <linux-fsdevel+bounces-21814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3677C90ACD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 13:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEED1287017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0008194A7F;
	Mon, 17 Jun 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXLqEEdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE419194A6C;
	Mon, 17 Jun 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623425; cv=none; b=BT30CFDPTvoM/TIBh1StwK8rUHbYjCCtx3DG5gplCoCWnjM+XeyHQ3ZFQGSvzARb9+n7jATJXRxAKo6QJomEzHQAkqaeOtdCqD4NBQrCOpTCMfNv4OpORaH8r7XnGvy5Q4g083A4Nt4mJsLy8D2mLUvLXbV+TmAZuqlKqRzMg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623425; c=relaxed/simple;
	bh=uxut/VKniq7Xv3BBMUvRa/bj7ZQEeeWaT4NmlF4fEn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5UGY/tjsQ7Z51vmlioYDybJmvOmJnpmEW6Jwjt2Z+5gznER9c+fjeSqN091a/EwkCyx02L7bQEacSCp45pzNs1VgrbVNSRk/Fy33Kubg8H+QCbShA1Gbf1ATfPutcaX4phoKpmGtd8cAwLvaVtkC+99dlM67CMGwiCBMKFku6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXLqEEdA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so35378095e9.0;
        Mon, 17 Jun 2024 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718623422; x=1719228222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLjaJql39nOUd+8mDmxJM45dfY7Mw8T6CJxgtFascNk=;
        b=ZXLqEEdAdeFcLTvKwyBbfiLxjLAluHNepY2MU2EGrA3uXTWxiAicXr2nVT6i/NLsFG
         DKnLd3V/lT0IjugzCT1PlUlaObVDt42vOxN0BUmlW8SSl+/l51GRKrGq2JoGiBm7CLYN
         NPprLZaTh6IDRY81BOZtKGJxmrgPw+WRe2nsA5eOPsois/iVSNe7/w6Fatbc3y1luAgS
         q4uVMi4saOpntq+rhVF+f4H4sEXJKBNGsK5SDyvj6HHtYf1KSeYohI1zIoHgVXPBZ9PN
         nJUb0jtjcZ2wa4EOtroHUaLFKiikYrA/8DL1xsvxei3ZOlRJsh6AJ9g2Yvg6otX8I2A8
         F6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623422; x=1719228222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLjaJql39nOUd+8mDmxJM45dfY7Mw8T6CJxgtFascNk=;
        b=irKMABmQKilcDxBxt8MZCVIvZHweadhiWmWvgIVJolF+DYo1f7eXLvVpYnDy685vlJ
         wTrfgkrcCBJVqgzaS+x7aiS3SUeB9cN84f+8aNgKUOS+yzWWNlDXuoC962yXAd5k+hKA
         EJugFww1VqCr8iBML+1KphYnS3LSMqm+rFcglh+OlyQsN8CKW1xibgc/+CSsBtAjLv7y
         O1z+B8hmOMfZHuVr7i9Ycu/AGBlryRWKRBQHS7LKHZipt6jcZAWw78tkkg4UjlaEZ28G
         vnPXcYkSO1igOaGR2hgogt99WGapqmHlK/1PbFjZdxxtBOfuN97n7rhghdrFA91kNpQB
         QJ6g==
X-Forwarded-Encrypted: i=1; AJvYcCU6GZCcx0FhoYCHCGvB4DpmSxTx3pr9sarPugwcP32X2gpfo5mXQONMnlodGYwu7fFNzgRJPtKKilTliJrXXKkPNk76AO6nDiKZEu7Bhsfn4lTWVmEmuhjdkJAHf8oMMVaFVlPllkUhUK65rQ==
X-Gm-Message-State: AOJu0Yy5xZ5E6Gfp12Qek9R01D2nxai+IkqJV0lT8nDWEdcO7SkdESi+
	NktWza7qVqnLdrDKQ/vCxiax9w7uCAZNAaKShfW88ZYYVD5tOVzH
X-Google-Smtp-Source: AGHT+IFyYZlKpO2lommicvAdahrc9RQXhi3i8rPIWbE/EksLzQ314FLmZu/bL/GJF9HoEnRCShMEdA==
X-Received: by 2002:a05:600c:5492:b0:421:d8d4:75e3 with SMTP id 5b1f17b1804b1-4230485bac2mr61488035e9.40.1718623421648;
        Mon, 17 Jun 2024 04:23:41 -0700 (PDT)
Received: from f (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bf2sm156110645e9.31.2024.06.17.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:23:40 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:23:31 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: "Ma, Yu" <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
Message-ID: <suehfaqsibehz3vws6oourswenaz7bbbn75a7joi5cxi6komyk@3fxp7v3bg5qk>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
 <e316cbe9-0e66-414f-8948-ba3b56187a98@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e316cbe9-0e66-414f-8948-ba3b56187a98@intel.com>

On Sun, Jun 16, 2024 at 11:47:40AM +0800, Ma, Yu wrote:
> 
> On 6/15/2024 12:41 PM, Mateusz Guzik wrote:
> > So you are moving this to another locked area, but one which does not
> > execute in the benchmark?
> 
> The consideration here as mentioned is to reduce the performance impact (if
> to reserve the sanity check, and have the same functionality) by moving it
> from critical path to non-critical, as put_unused_fd() is mostly used for
> error handling when fd is allocated successfully but struct file failed to
> obtained in the next step.
> 

As mentioned by Christian in his mail this check can just be removed.

>         error = -EMFILE;
>         if (fd < fdt->max_fds) {

I would likely() on it.

>                 if (~fdt->open_fds[0]) {
>                         fd = find_next_zero_bit(fdt->open_fds,
> BITS_PER_LONG, fd);
>                         goto fastreturn;
>                 }
>                 fd = find_next_fd(fdt, fd);
>         }
> 
>         if (unlikely(fd >= fdt->max_fds)) {
>                 error = expand_files(files, fd);
>                 if (error < 0)
>                         goto out;
>                 if (error)
>                         goto repeat;
>         }
> fastreturn:
>         if (unlikely(fd >= end))
>                 goto out;
>         if (start <= files->next_fd)
>                 files->next_fd = fd + 1;
> 
>        ....
> 

This is not a review, but it does read fine.

LTP (https://github.com/linux-test-project/ltp.git) has a bunch of fd
tests, I would make sure they still pass before posting a v2.

I would definitely try moving out the lock to its own cacheline --
currently it resides with the bitmaps (and first 4 fds of the embedded
array).

I expect it to provide some win on top of the current patchset, but
whether it will be sufficient to justify it I have no idea.

Something of this sort:
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 2944d4aa413b..423cb599268a 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -50,11 +50,11 @@ struct files_struct {
    * written part on a separate cache line in SMP
    */
        spinlock_t file_lock ____cacheline_aligned_in_smp;
-       unsigned int next_fd;
+       unsigned int next_fd ____cacheline_aligned_in_smp;
        unsigned long close_on_exec_init[1];
        unsigned long open_fds_init[1];
        unsigned long full_fds_bits_init[1];
-       struct file __rcu * fd_array[NR_OPEN_DEFAULT];
+       struct file __rcu * fd_array[NR_OPEN_DEFAULT] ____cacheline_aligned_in_smp;
 };

 struct file_operations;

(feel free to just take)

All that said, I have to note blogbench has numerous bugs. For example
it collects stats by merely bumping a global variable (not even with
atomics), so some updates are straight up lost.

To my understanding it was meant to test filesystems and I'm guessing
threading (instead of separate processes) was only used to make it
easier to share statistics. Given the current scales this
unintentionally transitioned into bottlenecking on the file_lock
instead.

There were scalability changes made about 9 years ago and according to
git log they were benchmarked by Eric Dumazet, while benchmark code was
not shared. I suggest CC'ing the guy with your v2 and asking if he can
bench.  Even if he is no longer in position to do it perhaps he can rope
someone in (or even better share his benchmark).

