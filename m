Return-Path: <linux-fsdevel+bounces-33540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037859B9D7D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 07:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205DAB22936
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5B1534EC;
	Sat,  2 Nov 2024 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRswdGJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B018035;
	Sat,  2 Nov 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730529696; cv=none; b=ebR4JgQOMgn2HYwWK2IBk1G20DLdymSD/KhMkO5OZPApdj4cndznMSpQ8Apv1KxUPJ4gxB4vYxva0X7JXIFsKrKLDqgTpWW6REfYF4fz7Ue/77AXj1UteSbtO8TSWAB7UCXLJX1PCpOWEbRHiLD51INqdb1CM0F81ne4j5AS3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730529696; c=relaxed/simple;
	bh=q6koMgHtxWpj12S29izdPMdRIRoyRLsTXC3G5OcaXIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uy3ltDmH9IGmp0+d1xT+hHLczntIa6OAq1t+eVIPImb2jZKZIWeob25h5HadkO2spk3Zy8FS4xqxNMbhztu2qIm/K6b6SyfXfyv1EFkw92FSSUfLSNv/GD5RMgshFLmBsN3/SNB4i5YX8i6zfSfCuM2t1Ru7IrQr9SK3Q38pPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRswdGJW; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db54269325so1869326a12.2;
        Fri, 01 Nov 2024 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730529694; x=1731134494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xrCMcLwfpG79B+Nt/Saq5AW3T1GsSahXes/JtabzUg=;
        b=ZRswdGJWL9Gso8YemKFpnBKQTNBYLlWQn/zSlXIsfwljAJDZnkZ0/J7cW1CG2jEmJ3
         Ydb+o1Fm1qxbk3xgopzRAZ0ymr0mopxn0a05JdJB3zbUWkK/iQQdgwrxmr1J+ax/H270
         T7A+JyWTsncpsyema7JnifK0wGJnRJFaRB8+IFfKW+YA3jkbtoK5Lc0fJAt4jv80BeUV
         cSVq/hY1g4ErNNM4qBSjwNyl8ldqQh5JEpuwoVMhPh+fYMSCloFmte1jXYBkZdLqr6/O
         NSA47wn3nx+pIBBMGkNw288eMP2GkUpscFGG+shRygQgIT1bFIlS2/3Lg9dX0t0EWPsY
         0heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730529694; x=1731134494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xrCMcLwfpG79B+Nt/Saq5AW3T1GsSahXes/JtabzUg=;
        b=ByVsywG3maCFzya+SU3N8xulZmMq+htSBZiDoims2zrjKUfW4be5jdFwEeJaQQ8OVJ
         8Wh3EBmih1IXM8xekevCbxX27JWwc8E114AS7aoM3MapfcaWzm7VInXtlyLrKkcEAJG1
         8XM0ECqF1qicdUMxof9q0h/3HfsehEe7obw4tI9Nu+rqsnnJUQyEeVDFjuljeXML0hy7
         ydRk+UxDvqmkWupyu27GTpIBtvM3KAfVHy5Q3sQKhtcVgPJTX/UMKY5YNC6TRHEBJBk6
         kxgAk+oPx6lNketohRRGncihHTT6G3GBKBYLPqGKKK/9GK9iW7Ee3Os8HOXWiK2tcgYJ
         Yqew==
X-Forwarded-Encrypted: i=1; AJvYcCW510uzFZfOwbk2jn/+/DzILD1rur/0Q9jeCSr0sMe/R7c7YyR64AXA7nzfsOGlEVSkn02DVHREEsuCq3n2@vger.kernel.org, AJvYcCWhvXEC2TtvMxvydCJnhZ4srF8xNo/gcZAArTdXI/0GV9Fvmkm4WOj5WVGyK1GFC8JDHNyIPUq0Hg6LJZ7C@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAEiPs+8k1Rc8xdG+xbcrrNBXlrjow217YZodfxplQnxMfpqL
	CnuhzYgq4s6RP7Cm+bRsO0Opt7qAwVEzGNXq2QOAUvcUyUwIJPab
X-Google-Smtp-Source: AGHT+IGNH1feXJP0DJ+JPnOsuq4mybHzaxFmAymHvgierHheOER6khY51HdCmh4Tyb565RU/8TBQvQ==
X-Received: by 2002:a17:90b:3d87:b0:2e2:af6c:79b2 with SMTP id 98e67ed59e1d1-2e94c51c61bmr8811240a91.29.1730529693865;
        Fri, 01 Nov 2024 23:41:33 -0700 (PDT)
Received: from xqjcool.lan (d209-121-228-72.bchsia.telus.net. [209.121.228.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbdfc25sm5927735a91.42.2024.11.01.23.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 23:41:33 -0700 (PDT)
From: Qingjie Xing <xqjcool@gmail.com>
To: adobriyan@gmail.com
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	christophe.jaillet@wanadoo.fr,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org,
	xqjcool@gmail.com
Subject: Re: [PATCH] proc: Add a way to make proc files writable
Date: Fri,  1 Nov 2024 23:41:32 -0700
Message-ID: <20241102064132.73443-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <978cbbac-51ad-4f0b-8cb2-7a3807e6c98d@p183>
References: <978cbbac-51ad-4f0b-8cb2-7a3807e6c98d@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your feedback.

The motivation for this change is to simplify the creation and management of writable proc files. Many existing parts of the kernel codebase require writable proc files and currently need to set up a proc_ops struct with both read and write methods, which introduces redundancy and boilerplate code.

By providing proc_create_single_write_data() and the associated macro proc_create_single_write, we reduce the need for each caller to explicitly set up write methods, making the code simpler and more maintainable. This can benefit areas where writable proc files are commonly used, as it streamlines the implementation and improves readability.

In the future, we foresee potential use cases where other components of the kernel may need to adopt this approach for their writable proc files, thus justifying the addition of this interface.

for example:
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..e6fb61505e51 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -513,26 +513,13 @@ static int pgctrl_show(struct seq_file *seq, void *v)
        return 0;
 }

-static ssize_t pgctrl_write(struct file *file, const char __user *buf,
-                           size_t count, loff_t *ppos)
+static int pgctrl_write(struct file *file, char *data, size_t count)
 {
-       char data[128];
        struct pktgen_net *pn = net_generic(current->nsproxy->net_ns, pg_net_id);

        if (!capable(CAP_NET_ADMIN))
                return -EPERM;

-       if (count == 0)
-               return -EINVAL;
-
-       if (count > sizeof(data))
-               count = sizeof(data);
-
-       if (copy_from_user(data, buf, count))
-               return -EFAULT;
-
-       data[count - 1] = 0;    /* Strip trailing '\n' and terminate string */
-
        if (!strcmp(data, "stop"))
                pktgen_stop_all_threads(pn);
        else if (!strcmp(data, "start"))
@@ -542,22 +529,9 @@ static ssize_t pgctrl_write(struct file *file, const char __user *buf,
        else
                return -EINVAL;

-       return count;
-}
-
-static int pgctrl_open(struct inode *inode, struct file *file)
-{
-       return single_open(file, pgctrl_show, pde_data(inode));
+       return 0;
 }

-static const struct proc_ops pktgen_proc_ops = {
-       .proc_open      = pgctrl_open,
-       .proc_read      = seq_read,
-       .proc_lseek     = seq_lseek,
-       .proc_write     = pgctrl_write,
-       .proc_release   = single_release,
-};
-
 static int pktgen_if_show(struct seq_file *seq, void *v)
 {
        const struct pktgen_dev *pkt_dev = seq->private;
@@ -3982,7 +3956,7 @@ static int __net_init pg_net_init(struct net *net)
                pr_warn("cannot create /proc/net/%s\n", PG_PROC_DIR);
                return -ENODEV;
        }
-       pe = proc_create(PGCTRL, 0600, pn->proc_dir, &pktgen_proc_ops);
+       pe = proc_create_single_write(PGCTRL, 0600, pn->proc_dir, pgctrl_show, pgctrl_write);
        if (pe == NULL) {
                pr_err("cannot create %s procfs entry\n", PGCTRL);
                ret = -EINVAL;


