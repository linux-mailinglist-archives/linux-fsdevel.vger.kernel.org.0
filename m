Return-Path: <linux-fsdevel+bounces-29821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66797E5FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70461F21522
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A017BCA;
	Mon, 23 Sep 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ycYwNRr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29312E5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073057; cv=none; b=Haw0PhttGyyp2Mz+XvxrpaxF8In1Dg6/kyC1/AQF2YENz61jmgThX0S+bYyd9FhUmhKZDo2r6+9+u+BfYz1nOG15tVf2F9gJ6R7rRuxQnuAePUUoIPqv33U8agn2VdQrJoQeH7y9/gkJjIBgldjMoQhjkWI8wzBNgtYp4CzHRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073057; c=relaxed/simple;
	bh=Y2Rp6Mh3oPRvtUu+mbUcpny+kHYSHTc8zKFDBW+xjFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Bf2jA2odj3QwcRevQja9Hofs/1X17CMNp3Rq8m5A0iWWmTPM/ZvCIEfhI3hYp9TBSGPT2lUdtQ0kfYSvlWuupStyk1p5r22BSEzEIto9DZUUjY1KHj77647evJ4MMMDuBQ691QcGu7wjQeGk8z6JGuOgzq3Nu2Nz3NdqXulYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ycYwNRr4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so2283894f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727073051; x=1727677851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWlE4/jwrvzyvaDVc7QjPWywTucisKenm+tAHehwRbc=;
        b=ycYwNRr4SODDqbZMAhBdARtTdz43vEka58swUadnUWvoKKqvVLAqDomZhhFkm1rO/S
         LmVgL+Sx8Sh+gn22mCHfOGK7+vnflKpb6JeQ1HXUOATLhuB3B56bzGPV+cl3ryG05n+4
         U7s59wzs1AsqmR0i2YRQDEjg/f9M/9PYSzJaxeRwvDDAQHBaZ0Kn3cLZ+fYMxDNV5bnJ
         GopdA/pAszoF1nUL04SoEELegromc8kpYRmZvAf6mZRlULmy8wN5VUCp7eRbPhzPq6iq
         PEVLRZVZndukA0fvIItlD8c1NNpr6SmsC8m5Rl03BUl4ib2n3fJXTYSLeDMljg2IC9fl
         ocuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727073051; x=1727677851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWlE4/jwrvzyvaDVc7QjPWywTucisKenm+tAHehwRbc=;
        b=P+l4vI1FJN6Njd90mez6ApdDyAROfMcFW/n6X9eMJ53U4V7JDwwEyeOaaUVEN5csrm
         lulk0sm78+shXzpMYJFadmgJ2hcp7uUEK7uKKiKTqB3XuYofPjs1E8DTCRJX3btRXGqC
         DxraQLclI3PkU2XQjEyUoZJZ5pUK3Br/1X2fd3udtMTUGXZk6V2Hio1SuTBPvpfusKpD
         3EfeoctpnUk14f+gUej0X4VkfQSgAp5gW0cucPzAO7GwcfxeKlNYA+9wKKLlJtgZwC2z
         FIiDL71swVeI7nkQonbVkj4fxomupEWYxide0eZE1LtppI9AH9rMKuwg7IZsBjTMoO2F
         4q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrBCq5guBwjuPBIdm9O4+rbmjjjFDwexLl9UdySZbFMe6BF+LNdBXYwlhw/j+iAoWOtHMyQoOLY0Dtp65P@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6hjRms9zgAX4Ubg8Ptm2VBEQhIhGyuj802wB+A7E0eYZUrKS
	N63YDIr2Z4KlTFAYAoD+c0Lymh/gstRFLZUf4OfW2MTeYzMJ3fQMkBdhqBEZXGg=
X-Google-Smtp-Source: AGHT+IHANHbriFpVTAnwbXMbE0PKCk1TVwu9FPuVTurP+Z+NrUQCJFCWnlQyTrmM+geMokzP4Ihz4Q==
X-Received: by 2002:a5d:4f0e:0:b0:374:bf97:ba10 with SMTP id ffacd0b85a97d-37a43154b16mr5330447f8f.25.1727073050940;
        Sun, 22 Sep 2024 23:30:50 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800299sm23599632f8f.73.2024.09.22.23.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 23:30:49 -0700 (PDT)
Message-ID: <62104de8-6e9a-4566-bf85-f4c8d55bdb36@kernel.dk>
Date: Mon, 23 Sep 2024 00:30:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] struct filename, io_uring and audit troubles
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: audit@vger.kernel.org, io-uring@vger.kernel.org
References: <20240922004901.GA3413968@ZenIV> <20240923015044.GE3413968@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240923015044.GE3413968@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/24 7:50 PM, Al Viro wrote:
> On Sun, Sep 22, 2024 at 01:49:01AM +0100, Al Viro wrote:
> 
>> 	Another fun bit is that both audit_inode() and audit_inode_child()
>> may bump the refcount on struct filename.  Which can get really fishy
>> if they get called by helper thread while the originator is exiting the
>> syscall - putname() from audit_free_names() in originator vs. refcount
>> increment in helper is Not Nice(tm), what with the refcount not being
>> atomic.
> 
> *blink*
> 
> OK, I really wonder which version had I been reading at the time; refcount
> is, indeed, atomic these days.
> 
> Other problems (->aname pointing to other thread's struct audit_names
> and outliving reuse of those, as well as insane behaviour of audit predicates
> on symlink(2)) are, unfortunately, quite real - on the current mainline.

Traveling but took a quick look. As far as I can tell, for the "reuse
someone elses aname", we could do either:

1) Just don't reuse the entry. Then we can drop the struct
   filename->aname completely as well. Yes that might incur an extra
   alloc for the odd case of audit_enabled and being deep enough that
   the preallocated names have been used, but doesn't anyone really
   care? It'll be noise in the overhead anyway. Side note - that would
   unalign struct filename again. Would be nice to drop audit_names from
   a core fs struct...

2) Add a ref to struct audit_names, RCU kfree it when it drops to zero.
   This would mean dropping struct audit_context->preallocated_names, as
   otherwise we'd run into trouble there if a context gets blown away
   while someone else has a ref to that audit_names struct. We could do
   this without a ref as well, as long as we can store an audit_context
   pointer in struct audit_names and be able to validate it under RCU.
   If ctx doesn't match, don't use it.

And probably other ways too, those were just the two immediate ones I
thought it. Seems like option 1 is simpler and just fine? Quick hack:

diff --git a/fs/namei.c b/fs/namei.c
index 891b169e38c9..11263f779b96 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -206,7 +206,6 @@ getname_flags(const char __user *filename, int flags)
 
 	atomic_set(&result->refcnt, 1);
 	result->uptr = filename;
-	result->aname = NULL;
 	audit_getname(result);
 	return result;
 }
@@ -254,7 +253,6 @@ getname_kernel(const char * filename)
 	}
 	memcpy((char *)result->name, filename, len);
 	result->uptr = NULL;
-	result->aname = NULL;
 	atomic_set(&result->refcnt, 1);
 	audit_getname(result);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0df3e5f0dd2b..859244c877b4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2685,10 +2685,8 @@ struct filename {
 	const char		*name;	/* pointer to actual string */
 	const __user char	*uptr;	/* original userland pointer */
 	atomic_t		refcnt;
-	struct audit_names	*aname;
 	const char		iname[];
 };
-static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 
 static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd57053b4a69..09caf8408225 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2240,7 +2240,6 @@ void __audit_getname(struct filename *name)
 
 	n->name = name;
 	n->name_len = AUDIT_NAME_FULL;
-	name->aname = n;
 	atomic_inc(&name->refcnt);
 }
 
@@ -2325,22 +2324,6 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	if (!name)
 		goto out_alloc;
 
-	/*
-	 * If we have a pointer to an audit_names entry already, then we can
-	 * just use it directly if the type is correct.
-	 */
-	n = name->aname;
-	if (n) {
-		if (parent) {
-			if (n->type == AUDIT_TYPE_PARENT ||
-			    n->type == AUDIT_TYPE_UNKNOWN)
-				goto out;
-		} else {
-			if (n->type != AUDIT_TYPE_PARENT)
-				goto out;
-		}
-	}
-
 	list_for_each_entry_reverse(n, &context->names_list, list) {
 		if (n->ino) {
 			/* valid inode number, use that for the comparison */

-- 
Jens Axboe

