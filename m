Return-Path: <linux-fsdevel+bounces-38853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9733AA08D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976313A3DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8220A5C5;
	Fri, 10 Jan 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyk3jzbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88D17F4F2;
	Fri, 10 Jan 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503057; cv=none; b=KDt4+DobehneNSH29c95Z96B88TWtClUXFW4v5jtcS5f8cUhuX4x/liy3Xs6BlqboGk0YORGaoGakfKEnhc3rL2tAhIrg+OPDX0IZodbkv5jM5l9IjVocBea3hMSTttAjfADO0Rv1pRyUdOEnAuUAnZqem0GuwJsjAO4OCT+VNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503057; c=relaxed/simple;
	bh=rgV487CnbslRTZhg0qn2dmf39AD1jlzPkLoug1tuyvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZxhuseSI28MFgVd335M/drDS/Rg75nONyrn5fyNiKxe8OpTfPmDc4WCj9gUJzqdqKukov7nV6CNbJbyubKqqmHUscZyyHANgeqeLtOWWK264ZAroRp4Q/b7tnOPDHg9I/8HWNkNPZU5C4Et7PSuu4LU0wOoSbZwd7yzUQIF9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pyk3jzbz; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2156e078563so26511545ad.2;
        Fri, 10 Jan 2025 01:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736503055; x=1737107855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duw3/ndnY86PXGNZcla5r5A2fqGgkDUfYOYJe+kw63M=;
        b=Pyk3jzbzqwNK+uKxeEMUDJEuhh5YdF3hkRLShYqSJSoy9owSycLHgKMFtNwhVs0Bui
         1iqfel52BU2XpAjOUBZ/U5d1089pjUQXOVEcK4KYZkql7FHO3lx33jdCX8oP3sM1xxp9
         jDpwE7E6+D2mke8VZPZFAfP46WgmYcaGo5foJclQHR7Ie4UQHgbymCARtz1Vi5FCFtWv
         FQvoVf9uj0SuIITWwZtOLC5KmEHyG1JfVh7MUvB+JNmVUVzItp7HuOKnA8sC1RPrNp0w
         Ciz08GEz+Ej1/mLWyd7sdwKBknHtDbKdrL0BaQtIL0Slwa/4K4iz9Fj0pkkkrguyPEwi
         PXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503055; x=1737107855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Duw3/ndnY86PXGNZcla5r5A2fqGgkDUfYOYJe+kw63M=;
        b=qUwSxzfi04a8ZVXUHzOuIKIW8Pa3jCYBc5DPweebB2Y1OEFrd/OwAnvaErZdDaCojy
         MvNWXoprjfmOatMtwvMLk7+S7moMl259sfCWqXOFb2TkfXHxpx4grQlclxKEU5XlboCG
         Q3arSTHQ/z2DWNf8g22ed7xD2qhSyGPOGI06L1ZoeB5mc2dw3EeqPTWzZHmfseCPoQo8
         O2ypEwNlinO7cQTkaZd23ekN9nFlhU1G0trDmDIC8Et//KsfMoSZfiJYispVVbRjsvt+
         uYYtwjtspTpdyKzc1lNaeFuBqd8vde15dcIFMlkMBuzCr3w+pV4+McXxO6J8Q6Yg0qOU
         5y3w==
X-Forwarded-Encrypted: i=1; AJvYcCUrop05ckHNSLPBgCUB43IF8ALfa2N4QHnVEWR3rpxt92w6Ed6W3eDyE8VueFM4hFUdRKPo2/+HLwEDq1SI@vger.kernel.org, AJvYcCV23D+kNh4A8CWI/wic0FJvhdHLbclp28rohF0IjLWv8uT3Lm8FsXvGgss4JRttgRLdEOieONah8VI1tz4Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6toMlmeT/euRMZZ2VecIPXrzbcfDZNVtXEhvBo9VwEUJBBjF
	FqD9HqGK8dh160UWp3zbEva4wUf9ULsat36aEY3FEAiHXF7PUCNy
X-Gm-Gg: ASbGncvS++LtR2kyXEdlpFGtJumaH0nF4ENX/x3VBvYGUgBZEWoffFuenSaSuUqKYt9
	K66dZ4XFK/BthPfF0hiVh4IB5u1L70cDrf8znqfaJ9iQ5vBn9Od4Yz1TpjQ0Hs/od2OFnbINDJD
	Cg5aZEAi6PrEtG9Ngms1lceYN5FSaG2wGN8Oq6xbKHagTj7dq9/bADokC0v+jutigqbVBJL7Tyn
	r8h4K1QKCjLQauH+BMwG4uniYKF6k1mASKwclkqqE4pQSHK1ak9yIP82gl+rDrE17mztw==
X-Google-Smtp-Source: AGHT+IGl6aE5kXky5funQPPsyrxK3u5IW4Ixiegbwcy9K/RE1uERz2BkbNp8fNXWE8zBM39xrb41KA==
X-Received: by 2002:a17:903:1109:b0:216:48f4:4f1a with SMTP id d9443c01a7336-21a83f4bfa8mr152077135ad.16.1736503055232;
        Fri, 10 Jan 2025 01:57:35 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2178ddsm10767775ad.157.2025.01.10.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:57:34 -0800 (PST)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH linux-next v4] ksm: add ksm involvement information for each process
Date: Fri, 10 Jan 2025 09:57:30 +0000
Message-Id: <20250110095730.665478-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
References: <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: xu xin <xu.xin16@zte.com.cn>
>>
>> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
>> KSM_mergeable and KSM_merge_any. It helps administrators to
>> better know the system's KSM behavior at process level.
>
>It's hard for me to judge the usefulness of this.  Please tell us more:
>usage examples, what actions have been taken using this information, etc.

Thank you.

They are just simply to improve the observability of KSM at process level,
so that users can know if a certain process has enable KSM.

For example, if without these two items, when we look at
/proc/<pid>/ksm_stat and there's no merging pages found, We are not sure
whether it is because KSM was not enabled or because KSM did not
successfully merge any pages.

>
>> KSM_mergeable: yes/no
>>      whether any VMAs of the process'mm are currently applicable to KSM.
>
>Could we simply display VM_MERGEABLE in /proc/<pid>/maps?

Althrough "mg" in /proc/<pid>/smaps indicate VM_MERGEABLE, it's opaque
and not very obvious for non professionals. 


>>
>>  fs/proc/base.c      | 11 +++++++++++
>>  include/linux/ksm.h |  1 +
>>  mm/ksm.c            | 19 +++++++++++++++++++
>
>Documentation/admin-guide/mm/ksm.rst will require an update please.

Yes, okay. Thank you.

>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3269,6 +3269,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>                              struct pid *pid, struct task_struct *task)
>>  {
>>      struct mm_struct *mm;
>> +    int ret = 0;
>>
>>      mm = get_task_mm(task);
>>      if (mm) {
>> @@ -3276,6 +3277,16 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>              seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
>>              seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>>              seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>> +            seq_printf(m, "ksm_merge_any: %s\n",
>> +                            test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
>> +            ret = mmap_read_lock_killable(mm);
>
>Could do the locking in ksm_process_mergeable()?

Well, the reason why it's not placed inside is to prevent future deadlocks caused by someone using
this function incorrectly under lock already held.

Thanks.


