Return-Path: <linux-fsdevel+bounces-18380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3018B7F44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FEA28447B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AA180A92;
	Tue, 30 Apr 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A21AiO1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5F171671;
	Tue, 30 Apr 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499502; cv=none; b=WY7qDxDUem14A7kIeIc5s9ZlRVgMc1nORgNl3QSt/fiQIcGnwR7h87Bva2/FjNkNBOW7W/lKoHCF8nRbjHxQsbgG+IJygG1SIlHgbCw1oOSE5x60kT3gF5whTuJKgimQ7B3KU0j5tlZNnS9z7Kd2NsJTQARE/no6RgGXnbUgASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499502; c=relaxed/simple;
	bh=kChY10DrjEfvymWbjUuwEc4qL7zqDD0eRdW2a9bvlRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyNGiGqad5V9bxFjeUnHynj0jOILbeu60T0iKm4g+8POJfZepBEmWP/SowQIf59LzA9KClkGeR2C8I23ivkKL0fweJ7fJ67RVRu4Z6kA6kKOZ8aaRkQSPmTiUfCHeGetmR3Mr5qZTLYcEIqI04ok3WioCItN4NmxBXPodmqqJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A21AiO1N; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4daa8e14afbso1763790e0c.3;
        Tue, 30 Apr 2024 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714499500; x=1715104300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ch0ZP/wIDNOHoIpcQYJ40DF6CUTO+9WaioKV6GLsnc=;
        b=A21AiO1NBXW73USvnI9zeXSlSUKuQJ2RBagMJzv376hcaK5KCKwNp2nHaOYLnI8qRV
         8rD7S5pqw/TfGS4RgEUaLceK9fJxJO35KKMJUA0XUsrpSDFnfPAipgMDPwlRPr8gFuCn
         OSVxQF7lIm6/Pa3E13I58nGmhLggaXIuMF8oT7KsTLEq0Dc/oY8EGNRpVJ21tbIyqJxq
         3QsjaSHsRTPia2mOy8mZf0MUQFM1ZFUwJ9z2maxHktIKacldVzb2HhPbrtRJpumof4Xk
         oikilgXFbcfhe/T05LM457D/hAwzRlLweUwYZKby4Dz+rH21o5A/YfOYAVd6/hG28HVi
         WBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499500; x=1715104300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ch0ZP/wIDNOHoIpcQYJ40DF6CUTO+9WaioKV6GLsnc=;
        b=Wrf8Mnw1q5l4jOodchd9lV5aWQKwWGe1rTBZLIlZc688ZPLjillmrVthSOh/ti/ovM
         vyxUqUQI6NUt6I6KZQmHsfh69LXf3zYDhrCSSupUOX+CgWqp6iWJitqIG5IyDUNWnMHi
         1ISP6b8wMdzG+yxTbLNbmjD9CvMCAP9zRxf1wQPSReZIGgPS7AxfsY8ger+R10iyzclB
         ecAPpZYCRyxxfHqqmehUF+8hkzPDm6JXWG7slSFwLf6HX1+bfLSoUorQEFM2DOWj/bks
         akZl40AeRNOpBbe5/Nbddp669z26nPIWr/Vg9hlZtD6WNE0+bBOwadwCEPPP60mz/qym
         KUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1cGhUKueJy17zn81bmYYENsnjWjgl/PfL2wsXc94enEgfgTaUJ8YJdSLfjJIXAh6RQOuUQpUrYLc4VzdH1oUi86sUvB4o5mR84AA8Gg1lSxIo0HmFW5D4ykYYXw4uBoCOtqRYmyLJABAbg==
X-Gm-Message-State: AOJu0YwWpmfzIzxObQMixiAXmaH3G1VToW0S3/ZBtsE9ZaQZceolZ0y9
	d/dnFyrQU36U4sbDEkVW3jJUjywBoX2B8UIWc834UrN6i6YBTGIjyJm/kI27MwkKfsKYdE8xyWi
	54jQHaZrvOSc7hXgQryIne8OscEE=
X-Google-Smtp-Source: AGHT+IHOesElrBTZQXJmEhUcL0IW1CSd29YNggLaSqT6Vs3B7YbGCEpI7540mPCQPnkz5U0H+GaFYB2b1bFh67nKPnY=
X-Received: by 2002:a05:6122:2a09:b0:4d3:3446:6bcb with SMTP id
 fw9-20020a0561222a0900b004d334466bcbmr446028vkb.16.1714499499889; Tue, 30 Apr
 2024 10:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429172128.4246-1-apais@linux.microsoft.com>
 <Zi_pNF0OMgKViIWe@bombadil.infradead.org> <CAOMdWS+u3WkB5yiwTjNKOD1sMSQP-F22FSpkq0R8TCPhihp=2w@mail.gmail.com>
In-Reply-To: <CAOMdWS+u3WkB5yiwTjNKOD1sMSQP-F22FSpkq0R8TCPhihp=2w@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 30 Apr 2024 10:51:29 -0700
Message-ID: <CAOMdWS+jSC5UoO9nqYvRe_rRid_SOSuzK3c8M-NJ9-LKVhoCFg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/coredump: Enable dynamic configuration of max file
 note size
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, ebiederm@xmission.com, 
	keescook@chromium.org, j.granados@samsung.com
Content-Type: text/plain; charset="UTF-8"

>  Will address it in v2.
>
> > If we're gonna do this, it makes sense to document the ELF note binary
> > limiations. Then, consider a defense too, what if a specially crafted
> > binary with a huge elf note are core dumped many times, what then?
> > Lifting to 4 MiB puts in a situation where abuse can lead to many silly
> > insane kvmalloc()s. Is that what we want? Why?
> >
>   You raise a good point. I need to see how we can safely handle this case.
>

Luis,

Here's a rough idea that caps the max allowable size for the note section.
I am using 16MB as the max value.

--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,10 +56,14 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);

+#define MAX_FILE_NOTE_SIZE (4*1024*1024)
+#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024)
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
+unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;

 struct core_name {
        char *corename;
@@ -1060,12 +1064,22 @@ static struct ctl_table coredump_sysctls[] = {
                .mode           = 0644,
                .proc_handler   = proc_dointvec,
        },
+       {
+               .procname       = "core_file_note_size_max",
+               .data           = &core_file_note_size_max,
+               .maxlen         = sizeof(unsigned int),
+               .mode           = 0644,
+               .proc_handler   = proc_core_file_note_size_max,
+       },
 };

+int proc_core_file_note_size_max(struct ctl_table *table, int write,
void __user *buffer, size_t *lenp, loff_t *ppos) {
+    int error = proc_douintvec(table, write, buffer, lenp, ppos);
+    if (write && (core_file_note_size_max < MAX_FILE_NOTE_SIZE
+                        || core_file_note_size_max > MAX_ALLOWED_NOTE_SIZE))
+.       /* Revert to default if out of bounds */
+        core_file_note_size_max = MAX_FILE_NOTE_SIZE;
+    return error;
+}

 Let me know what you think.

Thanks,
- Allen

