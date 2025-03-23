Return-Path: <linux-fsdevel+bounces-44842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BCFA6D0FF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382ED7A40EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98B19D8BE;
	Sun, 23 Mar 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTiEB3AX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF52F4A;
	Sun, 23 Mar 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742760198; cv=none; b=GbUG9o7cM5mzyUeByX0whEtUlW6PcdsFeKQXLTYNZ9azKgwWvz87+t3XrcQhtieLk5ig3cOAxod0enDMkYcSIQZYX51V01+Tp+rvrmsmKLaRF+6nwcoC/XQf3gNHv1VO3xD83b9iQ1AfyWjRCmiCTTXaCDtJFYrDjZsDLGPV9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742760198; c=relaxed/simple;
	bh=rwZPZTwPS4r7v6W5+VAKtKZSDLHg9y/9IgIloVL6og4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bnv8yDKMZpeU4+DkIgO8SdOHuUNqOKvW+xHFI1VD4IEsevPxUiKr7ccQiVOqOHgKP3mGaZ6sd/e09XVtwaB390O602BnHnZe/l2eMtf2Tge+Xd4Xf/QkEgrBhhcxVrLzUVuBMuEUHpZgS8KPOWqxN6p4+EvkKP5rcLbcQb+M7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTiEB3AX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so29732265e9.2;
        Sun, 23 Mar 2025 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742760194; x=1743364994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGft5Et35KBhKNEX4bnKsS2M813r08vXuvkuA76ff7I=;
        b=BTiEB3AXXKnOdJO/f3x+QkaT1Irtpe2ETMvkAoSe/BhYEx4ZHa9b/v8Fq9QopQ3acd
         efaUP3IRRAvNJSNbdbQQ5GDyol1rq5D+XuxJbkaGgNROD69FVptS2Fnur7edIbDIXFs6
         JETCUB3eKpPadq/+Zucb/P9DXsphwL5D2ggUXYClEA4nT9/yys+ncu4N5Lp1vEuOJQFc
         KNbN+bBEzOVBVHFBUH/lIsmYGKkL9q/qptA6iIxBssqgj40addirxrr4xQqsl+dOqhRF
         nZ7rTRJny+Z/UfDuh1ZRWgWeBU93+fZXfrbVWVCP3R3EXGrKu8zSE8THEHscyeBJF96x
         MoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742760194; x=1743364994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGft5Et35KBhKNEX4bnKsS2M813r08vXuvkuA76ff7I=;
        b=HylwCxO+O1GO/YSQHhQRkBWbkDz0Fnm+eXDsWgUyCtFb+Vv0Bb02xaG0kSqAjMfvOA
         OG0wQGamis7+Y4hrRXyGJ63709cEyBOOQBhys8XTNhD52koYVdMtC6tHCbTNbg8VBFba
         SNSATYJPn1ypesgT+jHsfBHH2eG8srdxquZRT/PDQiqSirYBwEFAmkHIrPSX/rhuKHRp
         1hQLejj4wPDsHiKuMzVbyRfpDE0DneHdyCd350i/PLsD6WOgMRTyo83N+C3AKr/Wn5Wg
         jAK0D7zvMtPI/nF62W2YZmJQckUyMRWGftwb6X6S1gJpJWGB+/8dBkA/zFKikB5nKBvk
         e29g==
X-Forwarded-Encrypted: i=1; AJvYcCV17OMOsttTHDgWkEbHZvUTETpVSdJr5Cm3jGwMhXe+CLfT+r0a92Zh7rH53QlLCjBI7svS3fPYcsrtNcl+@vger.kernel.org, AJvYcCVXPElVMKX169g/IRQrO9jrvePku/50k3de2VYlJNW/FGnlCTs8fzVAh3IpmqbzHtNMWmtV4OeUwoXaTo3+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8w+CzwltjwwST2B5s+PxO30tiq74xA/NpAWcpmaC//hrZksD
	co0IKi9N92S9ltZ4l7VzgHHqlpAIX4ohnM9Wqx+xC+z2LeYl5O10
X-Gm-Gg: ASbGncu/a6Dd1Z6TR/ydmFD9YadeNlBgJC6cWUMTIMIWdbas3NaE4+9RQPj2JYX/WhN
	gpUGjAfz3+TtGFJvJ3pAPVGAXEe63iTB+jFfRVIbZNaHUwqd3Siu78x76gWsrVXD25wSpGwmufU
	D1WWVcx5MBJqB4oeow/c2T5bueGCpDKtF7Ev+VDILZZM5iYlTOnCye3cNPAfk/aQxDi4oV+pFU7
	1nx2/82jgR4++pJuOfzYdl/1FlW4HiD1CNUeUvZOFlJAgK352vTw7+l1W35IKfmTc3JXYDZPgII
	r2OOV0meKzwacAKXG+38TQHdXINRJBRcbEuuXpyaozQIAs8GFXC0Ilsukddi
X-Google-Smtp-Source: AGHT+IHxC8eJ61S2vO5ZLyASbUzR3esC5aD0WxTSRyk1ncB2aHbentG4dmbxdka8YNFZsKOSN1yAkw==
X-Received: by 2002:a05:600c:5742:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-43d510fff60mr71296195e9.19.1742760193891;
        Sun, 23 Mar 2025 13:03:13 -0700 (PDT)
Received: from f (cst-prg-82-128.cust.vodafone.cz. [46.135.82.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm98053895e9.25.2025.03.23.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 13:03:13 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:03:00 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, 
	jlayton@kernel.org, kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <cqyyq5vbtxbz3cpvgdy4hupy3eykhv5fzc46aehgjnk2lifda4@w3jnwtvigvoh>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e05e30.050a0220.21942d.0003.GAE@google.com>

> Tested on:
> 
> commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=169ac43f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
> dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17803c4c580000
> 

Here is a "just in case" by me: the patch which made sure to only look
at head + tail with the lock held.

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7

diff --git a/fs/pipe.c b/fs/pipe.c
index 82fede0f2111..7eedcef2811e 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -210,11 +210,20 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_readable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
-	unsigned int writers = READ_ONCE(pipe->writers);
+	return !READ_ONCE(pipe->isempty) || !READ_ONCE(pipe->writers);
+}
+
+static inline void pipe_recalc_state(struct pipe_inode_info *pipe)
+{
+	pipe->isempty = pipe_empty(pipe->head, pipe->tail);
+	pipe->isfull = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
+}
 
-	return !pipe_empty(head, tail) || !writers;
+static inline void pipe_update_head(struct pipe_inode_info *pipe,
+				    unsigned int head)
+{
+	pipe->head = ++head;
+	pipe_recalc_state(pipe);
 }
 
 static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
@@ -244,6 +253,7 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	 * without the spinlock - the mutex is enough.
 	 */
 	pipe->tail = ++tail;
+	pipe_recalc_state(pipe);
 	return tail;
 }
 
@@ -417,12 +427,7 @@ static inline int is_packetized(struct file *file)
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
-	unsigned int max_usage = READ_ONCE(pipe->max_usage);
-
-	return !pipe_full(head, tail, max_usage) ||
-		!READ_ONCE(pipe->readers);
+	return !READ_ONCE(pipe->isfull) || !READ_ONCE(pipe->readers);
 }
 
 static ssize_t
@@ -524,7 +529,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * it, either the reader will consume it or it'll still
 			 * be there for the next write.
 			 */
-			pipe->head = head + 1;
+			pipe_update_head(pipe, head);
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
@@ -549,10 +554,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 			if (!iov_iter_count(from))
 				break;
-		}
 
-		if (!pipe_full(head, pipe->tail, pipe->max_usage))
 			continue;
+		}
 
 		/* Wait for buffer space to become available. */
 		if ((filp->f_flags & O_NONBLOCK) ||
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..d4b7539399b5 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -69,6 +69,8 @@ struct pipe_inode_info {
 	unsigned int r_counter;
 	unsigned int w_counter;
 	bool poll_usage;
+	bool isempty;
+	bool isfull;
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif

