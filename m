Return-Path: <linux-fsdevel+bounces-49134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A7AB86B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC7C4E253E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB2299947;
	Thu, 15 May 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wm/+noEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD521FF46
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313143; cv=none; b=V9RV5wSir+x+w7vuGE9Rm2/Hjx+qABb1XBvETT2oYF8C7Bwjhnd7NK65rp6W2EYyf8kiwxC2PtyPR/+pF/mOwDARi+pPICzNDnrt4azyeYYYOx7Erzsn5wR7CNEHfYEgu3vS+nXkXxP7mCEltcDHR2QHMR1O/Dp+2DYG66LvTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313143; c=relaxed/simple;
	bh=fxuz+35EQTkMf7ejlzE+RSoVgvH1bZI25J9SZGConGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYg/5DG8eOO1oP8rQmWHUKCEb9oTp6tAu2bYxOhn3PRZq4Zf4UaauffeAsdxDjYm45k/wukEUkatsunI2dCbTAqVjM+VOH9eNOYdzG78BeXkQjhKb5OA9q/4dOEuPCs4JKwH7m/y2vOS+2biC9rZE7EbQTxRqCH26VGNEv8WmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wm/+noEs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so500274f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747313138; x=1747917938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8ytmU0Ivj0kf+KiGaZmrUJ7Xo2jJQd+tfoIzhI9mb4=;
        b=Wm/+noEsVNxgzAPlYJcP3WNGozLrEJfIv7oMs+JhZlCNpwo+uFEEU+jXyI50L4F2yL
         bQP1rga2qm5HVUgh99uMexhK/sO6mbzYyzfBvPVkyUs9/ySkE92OzKmMm1YnMWyXqiSp
         Xp9cd+cmJR9T83YbrRFYWohHNM/iWoalGDwMa/+dkjTPWZ7sOvt6HCgRTj2LBFq40wUK
         YRpIwfc/a6/QqEu+jeyVRH8R9qCrdAe/T7KUidEqKvsKdOwM+gF8NLn9dKB1Dx1QOeez
         +RPgFcDMg19ItjIT4NhsyrTfUNiTnj6vN+n4UzD/ITVa+hzxqPwsrZGkVujqPQoknJu9
         c7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313138; x=1747917938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8ytmU0Ivj0kf+KiGaZmrUJ7Xo2jJQd+tfoIzhI9mb4=;
        b=F+WCFmpXiDtO+MpeNfWLRJxR3RSIFacyGJzHyamX7iXaw9qG6WB5e1o5OA13T8J8fg
         2AJ9d7jKnlNa/i/sE7K540sp25lZkrn97fsmnkII5SOMII79KFuLO2hu3szIrU/KtW5q
         cfte112hNX49WyV47rCDcSloxiPr13oPyS4SaZTXmLMl9qbpKfkdgy46ZJe9YtOS/nd9
         usGeEMUxaRQO6YtXvdC8XZbSo7KMyxGaf9vNMRLQpzpTNwTJVjVzmQq8ascw/ibakeBq
         TljBmKjoDqTDLoDe+r8wHxkegUbjCgvxlrwGbtSsxxJMr1Tk1vhhLOYIo/385SqMLIfC
         ZzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgJgmolm9NeQxujDFSrc3KkijDDNvYfw+b84fNq9Myc8KKsbUIk+m5qx0oEl3d1soH8vKmDxmxk7JrINeF@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHGi8s+Jg5d2Ulu9/j+i+p8mYGBmb7ofxftSic9AdCI+pu7SA
	YsjR/qyB/CuiqqXspzJDICxg/eKQojoZ7RofIJiPNf2XYDry6ukxY4t1CkZv9hg=
X-Gm-Gg: ASbGnctxfO0fVjbTpNGRuZFMYLvHkVjE9oIQeZ59R4Rwsczivf2ILFk+9Jp9+MjBYu+
	ww9hyvmkSWg6vFi+u6Esjhqbk3lTSELbJx4CHjH5lmQna0ql2GAub48b/ncZuXcYweqt3py/92c
	Q+coXIdYeKaanHtSL5h/jt12yKzv8cMooRV0Kr8NSGbkuFLcN521gvLnzeQaOKLwig8BVxXiyG9
	vcMhMH8MHsygf8vMVkrCELMGhsmte9PaBb6NEIAebBODjlsOK6PMsF5xYJOu9TnltZ+NQi1EfnJ
	p6fSDaNs2ACZvLhSE+YjMbeu77oOQZE/den8fcFdzSASQif9gumD854fzbJ+rG3Z
X-Google-Smtp-Source: AGHT+IF38PL0wzeSj4GvEAu3FCBjnQjz0SXPYCgpQOL/dMJEuls5eMJL3RAbOl92w8KLLIZbHWD67w==
X-Received: by 2002:a5d:404e:0:b0:3a3:5833:c900 with SMTP id ffacd0b85a97d-3a35833cae7mr1136954f8f.8.1747313138119;
        Thu, 15 May 2025 05:45:38 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4df97d76cfcsm658516137.11.2025.05.15.05.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 05:45:37 -0700 (PDT)
Message-ID: <f6058414-e04d-4b7f-b4e6-3ac3613edbc1@suse.com>
Date: Thu, 15 May 2025 14:45:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] module: Move modprobe_path and modules_disabled
 ctl_tables into the module subsys
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
 <e2ebf88d-46a2-4f38-a0c8-940c3d3bee49@suse.com>
 <g3e3ygz4jb73b3zhxexpwacwui3imlwauujzeq2nlopp2i2fjp@lzj33hcwztc2>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <g3e3ygz4jb73b3zhxexpwacwui3imlwauujzeq2nlopp2i2fjp@lzj33hcwztc2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 12:04, Joel Granados wrote:
> On Thu, May 15, 2025 at 10:04:53AM +0200, Petr Pavlu wrote:
>> On 5/9/25 14:54, Joel Granados wrote:
>>> Move module sysctl (modprobe_path and modules_disabled) out of sysctl.c
>>> and into the modules subsystem. Make the modprobe_path variable static
>>> as it no longer needs to be exported. Remove module.h from the includes
>>> in sysctl as it no longer uses any module exported variables.
>>>
>>> This is part of a greater effort to move ctl tables into their
>>> respective subsystems which will reduce the merge conflicts in
>>> kernel/sysctl.c.
>>>
>>> Signed-off-by: Joel Granados <joel.granados@kernel.org>
>>> [...]
>>> --- a/kernel/module/kmod.c
>>> +++ b/kernel/module/kmod.c
>>> @@ -60,7 +60,7 @@ static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
>>>  /*
>>>  	modprobe_path is set via /proc/sys.
>>>  */
>>> -char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
>>> +static char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
>>>  
>>>  static void free_modprobe_argv(struct subprocess_info *info)
>>>  {
>>> @@ -177,3 +177,33 @@ int __request_module(bool wait, const char *fmt, ...)
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL(__request_module);
>>> +
>>> +#ifdef CONFIG_MODULES
>>> +static const struct ctl_table kmod_sysctl_table[] = {
>>> +	{
>>> +		.procname	= "modprobe",
>>> +		.data		= &modprobe_path,
>>> +		.maxlen		= KMOD_PATH_LEN,
>>> +		.mode		= 0644,
>>> +		.proc_handler	= proc_dostring,
>>> +	},
>>> +	{
>>> +		.procname	= "modules_disabled",
>>> +		.data		= &modules_disabled,
>>> +		.maxlen		= sizeof(int),
>>> +		.mode		= 0644,
>>> +		/* only handle a transition from default "0" to "1" */
>>> +		.proc_handler	= proc_dointvec_minmax,
>>> +		.extra1		= SYSCTL_ONE,
>>> +		.extra2		= SYSCTL_ONE,
>>> +	},
>>
>> This is minor.. but the file kernel/module/kmod.c contains the logic to
>> request direct modprobe invocation by the kernel. Registering the
>> modprobe_path sysctl here is appropriate. However, the modules_disabled
>> setting affects the entire module loader so I don't think it's best to
>> register it here.
>>
>> I suggest keeping a single table for the module sysctl values but moving
>> it to kernel/module/main.c. This means the variable modprobe_path must
>> retain external linkage, on the other hand, modules_disabled can be made
>> static.
> 
> Like this?:
> [...]

Let's also move the KMOD_PATH_LEN definition and the modprobe_path
declaration from include/linux/kmod.h to kernel/module/internal.h, as
they are now fully internal to the module loader, and use "module"
instead of "kmod" in the sysctl registration to avoid confusion with the
modprobe logic.

The adjusted patch is below.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr


diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 68f69362d427..9a07c3215389 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -14,10 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/sysctl.h>
 
-#define KMOD_PATH_LEN 256
-
 #ifdef CONFIG_MODULES
-extern char modprobe_path[]; /* for sysctl */
 /* modprobe exit status on success, -ve on error.  Return value
  * usually useless though. */
 extern __printf(2, 3)
diff --git a/include/linux/module.h b/include/linux/module.h
index 8050f77c3b64..f4ab8d90c475 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -304,7 +304,6 @@ struct notifier_block;
 
 #ifdef CONFIG_MODULES
 
-extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 626cf8668a7e..0954c8de00c2 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -58,6 +58,9 @@ extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const u32 __start___kcrctab[];
 extern const u32 __start___kcrctab_gpl[];
 
+#define KMOD_PATH_LEN 256
+extern char modprobe_path[];
+
 struct load_info {
 	const char *name;
 	/* pointer to module in temporary copy, freed at end of load_module() */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2859dc3eea6..a336b7b3fb23 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -126,9 +126,37 @@ static void mod_update_bounds(struct module *mod)
 }
 
 /* Block module loading/unloading? */
-int modules_disabled;
+static int modules_disabled;
 core_param(nomodule, modules_disabled, bint, 0);
 
+static const struct ctl_table module_sysctl_table[] = {
+	{
+		.procname	= "modprobe",
+		.data		= &modprobe_path,
+		.maxlen		= KMOD_PATH_LEN,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
+	{
+		.procname	= "modules_disabled",
+		.data		= &modules_disabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
+static int __init init_module_sysctl(void)
+{
+	register_sysctl_init("kernel", module_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_module_sysctl);
+
 /* Waiting for a module to finish initializing? */
 static DECLARE_WAIT_QUEUE_HEAD(module_wq);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9b4f0cff76ea..473133d9651e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -19,7 +19,6 @@
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
  */
 
-#include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
 #include <linux/printk.h>
@@ -1616,25 +1615,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_MODULES
-	{
-		.procname	= "modprobe",
-		.data		= &modprobe_path,
-		.maxlen		= KMOD_PATH_LEN,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
-	{
-		.procname	= "modules_disabled",
-		.data		= &modules_disabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		/* only handle a transition from default "0" to "1" */
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_UEVENT_HELPER
 	{
 		.procname	= "hotplug",


