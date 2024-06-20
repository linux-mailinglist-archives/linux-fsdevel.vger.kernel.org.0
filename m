Return-Path: <linux-fsdevel+bounces-21947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934E90FCF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 08:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DF11C224EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191C3D55D;
	Thu, 20 Jun 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="bmspK5ym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AB3BBE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865831; cv=none; b=ahYtYoYsQlBSWOSA8p+FhndK3CDe2rGbYZkG8f52x7fEeM34UgGdoQ2xMqKEXz74VnvmkOVrYDuNlbAKrJEZM/pKxPXvWbDBmz9Xxb3OzChykBp1SmlKSJTwdwPFeiHKYd65/rQm8hO/bdqEwinYZn0CERr8MBNDWLpe97e/jxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865831; c=relaxed/simple;
	bh=uE/uN6UQI8ULkWeXH2hrpTUuDXf9ezQJl6Unmy5CsLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFIyu4wgJr1ZSRjZY6ZEDObJo5giOaKtD5sJJw+Cv5XhynBNEwWSu8NCCWyTrrCabZMoYyWQcKQOS+FWv37VBl3hfbCHhbz6g8s5HrL5qrm2vpE8gqmQef7YtY8PiTEfEr/1F31xdFr97ZWgL+JUvFTeVFaKw+FHrIqgF6PTyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=bmspK5ym; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f70c457823so3994795ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1718865829; x=1719470629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YwiZn1PGDETwbHuEaIKOoV4wrE/8n3ka9pPww3cXT0=;
        b=bmspK5ymTQLkNK1z7Nl4rtUnQUxfSla0LkWomn7dk7ZeL0iCYq82cx46jZGOY/XKx5
         UMkWHfDwBCQJS4pmA5xDEWY8Wut1/FF+AMY5NUU5t2hZ2jOSuHIeA/xNATHNbYLnkp8C
         l7uvy7GA8/gkYh8FgKzjbhdUeDW3gFlwtG6/vA9GRDpCIZNLomIKX0ZDiPS4icIj6l8b
         5cBf5e4ybxkgS7plKNXWJC+KBooPduqr81AzqYfKBD8bBLpXb0ITaEz5X0ET29Gq/g/P
         iU2d/uzl0gG8wecElR1piIe2faaKU7l1EBt47sl5Qn+SCgHMcksxJTO+A2UfU3c2qDth
         rvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865829; x=1719470629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8YwiZn1PGDETwbHuEaIKOoV4wrE/8n3ka9pPww3cXT0=;
        b=CiQhxQ/9mB+DJpKAtbasfHsKpZC+qAVflJYA6D+MI9jT9wkd+Emhux4QRxbQ8leojk
         Qv/wcNK7wm1NwyuORDaYNP4pglLlG0gFZOUqoOyt2cKmoANHtTf/OdptNzF26QanijsD
         KR2NO8Tbv5frG7VEnUhGFh0yA5TmAiNn242yg5owkOgYgra/t22M2iro5URSENI7coUz
         Dh9CJQ3ERJf2zNbRLWhOwc730b2T3sFGmtQxIlQrVQSpFq3p9dqVli5J+aohuF/tOxiW
         lWViQPzjqL3F8C9zN2bg6s1e7WjiH60ao5ppAcPG4PyHIJQE6ZWUIyTCBCEkE69ypN17
         WXgA==
X-Gm-Message-State: AOJu0YxZp4PD4Zpxrotufbkz6Iy+rqzP6xYux2iAEqNkUUDa9tonJFgh
	TQUXLBE9UdRd4Apr8f9HeRXMxmWNdr4ANC9ZPXVmEnKrynRhuCAgOF3o8fJV2N6nY2OrP2u6vrR
	rYWt2pg==
X-Google-Smtp-Source: AGHT+IGd34NqtNaGuPMB/ROhKNjgz2OeNbmesm9iNVtJ7V7/gYkRhinqnM9f3iddiqpR8hP9iR8/yQ==
X-Received: by 2002:a17:903:22d1:b0:1f6:e20f:86ab with SMTP id d9443c01a7336-1f9aa44c98cmr47315875ad.40.1718865829286;
        Wed, 19 Jun 2024 23:43:49 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b000bffdsm26431565ad.107.2024.06.19.23.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:43:48 -0700 (PDT)
Message-ID: <2cf34c6b-4653-4f48-9a5f-43b484ed629e@shopee.com>
Date: Thu, 20 Jun 2024 14:43:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
 <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
 <20240617-vanille-labil-8de959ba5756@brauner>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20240617-vanille-labil-8de959ba5756@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/6/17 15:25, Christian Brauner wrote:
> On Fri, Jun 14, 2024 at 12:01:39PM GMT, Miklos Szeredi wrote:
>> On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>>> So why the client doesn't get woken up?
>>
>> Need to find out what the server (lxcfs) is doing.  Can you do a
>> strace of lxcfs to see the communication on the fuse device?
> 
> Fwiw, I'm one of the orignal authors and maintainers of LXCFS so if you
> have specific questions, I may be able to help.

Thanks. All server threads of lcxfs wokrs fine now.

So can we add another interface to abort those dead request?
If the client thread got killed and wait for relpy, but the fuse sever didn't 
send reply for some unknown reason，we can use this interface to wakeup the client thread.


diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 97ac994ff78f..b171d03171e7 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -44,6 +44,17 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
 	return count;
 }

+static ssize_t fuse_abort_dead_requests_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+	if (fc) {
+		fuse_abort_dead_requests(fc);
+		fuse_conn_put(fc);
+	}
+	return count;
+}
+
 static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
 				      size_t len, loff_t *ppos)
 {
@@ -186,6 +197,12 @@ static const struct file_operations fuse_ctl_abort_ops = {
 	.llseek = no_llseek,
 };

+static const struct file_operations fuse_ctl_abort_dead_requests_ops = {
+	.open = nonseekable_open,
+	.write = fuse_abort_dead_requests_write,
+	.llseek = no_llseek,
+};
+
 static const struct file_operations fuse_ctl_waiting_ops = {
 	.open = nonseekable_open,
 	.read = fuse_conn_waiting_read,
@@ -274,7 +291,10 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
 				 S_IFREG | 0600, 1, NULL,
-				 &fuse_conn_congestion_threshold_ops))
+				 &fuse_conn_congestion_threshold_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "abort_dead_requests",
+				 S_IFREG | 0200, 1, NULL,
+				 &fuse_ctl_abort_dead_requests_ops))
 		goto err;

 	return 0;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5fb830ad860d..77b54c5ea9bd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2249,6 +2249,49 @@ void fuse_abort_conn(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_abort_conn);

+void fuse_abort_dead_requests(struct fuse_conn *fc)
+{
+	spin_lock(&fc->lock);
+	if (fc->connected) {
+		struct fuse_dev *fud;
+		struct fuse_req *req, *next;
+		LIST_HEAD(to_end);
+		unsigned int i;
+
+		list_for_each_entry(fud, &fc->devices, entry) {
+			struct fuse_pqueue *fpq = &fud->pq;
+
+			spin_lock(&fpq->lock);
+
+			for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+				list_for_each_entry_safe(req, next, &fpq->processing[i], list) {
+					if (test_bit(FR_INTERRUPTED, &req->flags)) {
+						struct list_head *head = &req->waitq.head;
+						struct wait_queue_entry *wq;
+
+						list_for_each_entry(wq, head, entry) {
+							if (__fatal_signal_pending(wq->private)) {
+								list_move_tail(&req->list, &to_end);
+								break;
+							}
+						}
+
+					}
+
+				}
+			}
+
+			spin_unlock(&fpq->lock);
+		}
+
+		spin_unlock(&fc->lock);
+		end_requests(&to_end);
+	} else {
+		spin_unlock(&fc->lock);
+	}
+
+}
+
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..fc8b5a7d1d0a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -45,7 +45,7 @@
 #define FUSE_NAME_MAX 1024

 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6

 /** List of active connections */
 extern struct list_head fuse_conn_list;
@@ -1167,6 +1167,9 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);

+/* Abort dead requests */
+void fuse_abort_dead_requests(struct fuse_conn *fc);
+
 /**
  * Invalidate inode attributes
  */

