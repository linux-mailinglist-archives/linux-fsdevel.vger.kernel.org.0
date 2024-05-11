Return-Path: <linux-fsdevel+bounces-19309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7758C3030
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3046E1F22A14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA1D24A0D;
	Sat, 11 May 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3wXGJNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653611190;
	Sat, 11 May 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715415149; cv=none; b=I4Ixya/QWfuXcqQQ0jM5Qsegq4BMK49vcWg5H2GaUFGHyCYyl6InUUkspgvimNU3Ko2CKZ4xg56mOGpuyDkQsnSbYh7KJkz929ALDTzt2T6ln/qPNBFwNskC3pcyAOu3n3sAvZo4CUrj8qV2teNxPmrqNAnsTvwzTzVLIaJpKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715415149; c=relaxed/simple;
	bh=+5Xg93Nnj+GcdyudDCY16biOFb/0HIlATV7kqqR0IP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7GG93dvDbFHLdGtvVUqlw1Bxrr3XJk6NVy6YgYoI8UBST612Zm99AFRBi9shSMNlhhdKrAa0U+q3atUBqz9hidBj9lQulloWcRqUcKsuJhnpxSiBo+2Kllxj6aKvPUEazQO462SsCt0RRgHstmIQ8qsipjzbCkLkmYQKLHHWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3wXGJNL; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso2285528a12.1;
        Sat, 11 May 2024 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715415148; x=1716019948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qBbsDAPUy5FGaDuBuioErI1+pT2h8H+WItqDsVZoLo=;
        b=I3wXGJNLjX1Dr8vRIrA5dUKKjZ2tT+lKamvd9TdKzoiJVa2QB9+W/3SLp5x9rh4G+A
         xq9ZtEqkzOV25/oOGDsqFR7l65gbcazgE04km9LiLA1hxSnPiwzw/kXtwdD2M5NbM1lO
         5j5SKqkowPOLmAfARsPXfS4j8cNwkSCEKrhDcb/tdKQtohF6rE2XXyKzpqXCDyWeBEuO
         P1QYMs753KKjCAav/u0KgTHE5I+k7yGkmTlfuqdn6eH5PXR/XK9EIe/AxUofI/a1k3U5
         w2LIdjU8z7IQgVmlld46as+hzADzlTb3q3JTEGeR5N55ROZbsT1G2UeLncpe9loVIh55
         BNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715415148; x=1716019948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qBbsDAPUy5FGaDuBuioErI1+pT2h8H+WItqDsVZoLo=;
        b=Wg865X0Vcfyr6+tb6/x+zpof6vWVTeykeen1uwsXFAFQwFDRai2ImZGWNfD4Iar6w3
         TxB3X9L3b801jl/Y26oc3mD+VzIGA+Hx+C89NeFepOmxi6cBDbQYsXt1W0puv0iaRcH/
         jr2GovWWXyWoqSIibRHYdVGkWm9Q4bRZ5/kBNj+A4FWqtxiElx5+LAfwrP99GKffpVC8
         V26p8k3bastdY82H6YBEHcYxzbjF38SHBMyqWfC7owqxBaZmoMhhjFPCJBQFt5V+yGUH
         8ragWmkYoAJfaaq4fYzrvGLo5A3bSaaCQx1JyBBVLBkxZLvqfDeg8HT/JwC9sVFrl/RT
         4+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2XHd98f6SHWviT8b1pFRo458bmk5x8K7/zsenl4g7Z88rxfkq43cTWMgPoK6oRpHh3EnkPZcN30NWJZPF+ei541Ho8pkEcsGpZLJb62mCv+3djh20U9Ne70bHOYH8BHOCv275h1Dab/jUfw==
X-Gm-Message-State: AOJu0YyXL7H62lIBZPpZrxU+pQt/FFV8u0vynQa80h2+l0WJDjevkzLw
	pBgjk3kk+I+xXu/famtf260TF18G426yumnJEbypEKwp/ZycHX/d
X-Google-Smtp-Source: AGHT+IFj+AmbXoyzrs6SOrS6H+WnWeXXP/GUqlgiCSGr386jfk1YJXVZaW5eQKEoDtjjDUf9EKr++A==
X-Received: by 2002:a17:903:22cc:b0:1e5:4f00:3751 with SMTP id d9443c01a7336-1ef43c0cf2amr62507595ad.3.1715415147903;
        Sat, 11 May 2024 01:12:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c256a0csm43968605ad.306.2024.05.11.01.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 01:12:27 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shr@devkernel.io,
	si.hao@zte.com.cn,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH linux-next v2] ksm: add ksm involvement information for each process
Date: Sat, 11 May 2024 08:12:24 +0000
Message-Id: <20240511081224.637842-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <bc0e1cdd-2d9d-437c-8fc9-4df0e13c48c0@redhat.com>
References: <bc0e1cdd-2d9d-437c-8fc9-4df0e13c48c0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> @@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>>   		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
>>   		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>>   		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>> +		seq_printf(m, "KSM_mergeable: %s\n",
>> +				test_bit(MMF_VM_MERGEABLE, &mm->flags) ? "yes" : "no");
>
>All it *currently* means is "we called __ksm_enter()" once. It does not 
>mean that KSM is still enabled for that process and that any VMA would 
>be considered for merging.
>
>I don't think we should expose this.
>
>That information can be more reliably had by looking at
>
>"/proc/pid/smaps" and looking for "mg".
>
>Which tells you exactly if any VMA (and which) is currently applicable 
>to KSM.
>
>
>> +		seq_printf(m, "KSM_merge_any: %s\n",
>> +				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
>
>This makes more sense to export. It's the same as reading 
>prctl(PR_GET_MEMORY_MERGE).
>
>The man page [1] calls it simply "KSM has been enabled for this 
>process", so process-wide KSM compared to per-VMA KSM.
>
>"KSM_enabled:"
>
>*might* be more reasonable in the context of PR_SET_MEMORY_MERGE.
>
>It wouldn't tell though if KSM is enabled on the system, though.
>

I agree it. But I hope admistrators can tell if the process enabled KSM-scan
by madvise or prctl. At this point, only "/proc/pid/smaps"  is not enough.

So can we add a item "KSM_enabled" which has three value as follows?

1) "prctl": KSM has been fully enabled for this process.

2) "madvise": KSM has been enabled on parts of VMA for this process.

3) "never": KSM has been never enabled for this process.

Just refer to the semantics of '/sys/kernel/mm/transparent_hugepage/enabled' 

