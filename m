Return-Path: <linux-fsdevel+bounces-3189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451377F0CF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E051C210E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC4D269;
	Mon, 20 Nov 2023 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhZjDEmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C1DB7;
	Sun, 19 Nov 2023 23:41:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32fd7fc9f19so2671575f8f.2;
        Sun, 19 Nov 2023 23:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700466106; x=1701070906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UcnRCn9RBtyZwzYZjL7Mal3df0TOYaoALw3ajoI8ruo=;
        b=BhZjDEmWA6rMhy2zRLDgfrKFAF8a/S/0etGDujI+e4o+gnbFdJPTUaqIY6ZnnC/B30
         TeI4s+w4PXARxXrma6rn9lLXI/mggcJHvq6m8DRQgJ9csaGCgzDnQjLx4a8SvTw6muwf
         q5HZOe4asiYuZflkKWeKhTZsoSwO5fnMoIiKci2SqpEd71J+smJw0ltd56BvTNk98XdT
         DiLuiOgegCreNJJU1F8T56KVn1Mr4VQbwWfTEAEICGi3Jv+pZhXkp2sHesE1wJPd6w3J
         IaS5KU+x49OeJ92wQm+lv39uwnD3XrP+/v4eyJaCmBvoGhOHx1igMi8TTYuteO3BGri8
         55cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700466106; x=1701070906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcnRCn9RBtyZwzYZjL7Mal3df0TOYaoALw3ajoI8ruo=;
        b=owbAUT75hoLH873t3p7i22kikH65MPqktXNGW0ZnRGYpcYXCEV7G5+oriFcMKpCbjA
         hkZ1Fpq2XFE1EqpQOZkCcpiC+/QWTz9Hj6dBwUXW2bj8ZJWfwEx5p5c/5u2evFd9R7h6
         UGuyOTeITPMP2DYe2ByQKjgeWMM6TC11fIOGYASESQJVFeD7jUe30Zk/b6qoJ7cHcCEc
         tOOARoy4ceO/ICAa3er1RwOlvPiYQz7fqkMGkXqc8+r8uRNog6yp5Vp9DglOQkepmG1e
         Ho3TJ5PtFi40raDrfiw0TtZGzawNPsUjVACGHZOoWeOy+GEy+7VDzXre3IUQxNM9Smfh
         ImUA==
X-Gm-Message-State: AOJu0YzF1SiOipm9gnwkkyvm9TDvSaO6TWcCJOTZVUaNIVlwtA0yZ+up
	JsSU/8J0PueXQ6C9JhO33IlvnGB7WFMctA==
X-Google-Smtp-Source: AGHT+IGLxhKtp3IKpPAJiweTS4UYRDByB4GjdiKC0IaFf2a6rUb8Hh+cAbWkEb3mZscgg4QSavm/EA==
X-Received: by 2002:a5d:48c9:0:b0:331:6ad3:853 with SMTP id p9-20020a5d48c9000000b003316ad30853mr3683767wrs.41.1700466105720;
        Sun, 19 Nov 2023 23:41:45 -0800 (PST)
Received: from f (cst-prg-3-109.cust.vodafone.cz. [46.135.3.109])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b003313426f136sm10142299wrw.39.2023.11.19.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:41:45 -0800 (PST)
Date: Mon, 20 Nov 2023 08:41:06 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, bpf@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [file]  0ede61d858:  will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <ZVsNklEgxi5GkIZ/@f>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202311201406.2022ca3f-oliver.sang@intel.com>

On Mon, Nov 20, 2023 at 03:11:31PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -2.9% regression of will-it-scale.per_thread_ops on:
> 
> 
> commit: 0ede61d8589cc2d93aa78230d74ac58b5b8d0244 ("file: convert to SLAB_TYPESAFE_BY_RCU")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 93faf426e3cc000c 0ede61d8589cc2d93aa78230d74 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
[snip]
>      30.90 ±  4%     -20.6       10.35 ±  2%  perf-profile.self.cycles-pp.__fget_light
>       0.00           +26.5       26.48        perf-profile.self.cycles-pp.__get_file_rcu
[snip]

So __fget_light now got a func call.

I don't know if this is worth patching (and benchmarking after), but I
if sorting this out is of interest, triviality below is probably the
easiest way out:

diff --git a/fs/file.c b/fs/file.c
index 5fb0b146e79e..d8d3e18800c4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -856,14 +856,14 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__get_file_rcu(struct file __rcu **f)
+static __always_inline struct file *__get_file_rcu(struct file __rcu **f)
 {
 	struct file __rcu *file;
 	struct file __rcu *file_reloaded;
 	struct file __rcu *file_reloaded_cmp;
 
 	file = rcu_dereference_raw(*f);
-	if (!file)
+	if (unlikely(!file))
 		return NULL;
 
 	if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
@@ -891,7 +891,7 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	 * If the pointers don't match the file has been reallocated by
 	 * SLAB_TYPESAFE_BY_RCU.
 	 */
-	if (file == file_reloaded_cmp)
+	if (likely(file == file_reloaded_cmp))
 		return file_reloaded;
 
 	fput(file);

