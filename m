Return-Path: <linux-fsdevel+bounces-78820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Zm8JNTm5omnZ5AQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 10:45:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 308391C1CB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97DA1302947C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88AC40FDA9;
	Sat, 28 Feb 2026 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdcpCQ1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D840B6D4
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271910; cv=none; b=NDB/UInDBjttqpQF4VvsrlOEYl1/A1AN/jYvgVPsjaCtTNOA8gwFns9RLT9gk9PSYQSAjzBhFV36GOa18z24viCuqhmm9hCnWKXHjUK93AS6WCyMpPk/aPiERUXQyAUuhcQG5GFHRZw5XDCwmGilEWrXGyKenbUMftd3twdXhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271910; c=relaxed/simple;
	bh=JgQA6hF7V00oqmceoz3jXS3oNgydjZ5loRNyQ6eLhVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOhyeG5mANGAXjbIl68lBp34bshAdNLrT9TqSAoIqHcjeFSxBMaksWUJ6WAvOnjANK1flPLlz5m1mqvw2tWcvWqLwDlfZXYn9i4JjWQ36YrDJQwpoN9eD4zY+uQPJD9iSo7JzgiCK4LNB+PLn4l6iukb3GjKsxGb6V5yOGhBBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdcpCQ1k; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-437711e9195so2131123f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 01:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772271907; x=1772876707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e93FpEpTqD7Xqu0LewCf9chrUomQqmlqNIwnzg6ALeU=;
        b=AdcpCQ1kaK5jYq2keccwMa0F+pKDNE8W/7uUmQ2R7k/lLkMQI7iPnBYHTcmszkc92s
         achyHsbCICttp14pZ9CR/IsoH3lPeiSNE3tMyCO926M1Xd8JMnnMaWdiR3PhjWmb8T06
         cVYjDxN7ntaKIZNTA5LBSk9tqjBxqPsuyC9WuoNvEzJ/ND2A6mismKbQEO1FR6xDWbRH
         r5XrX14CAmv0f8WTjG3GspZxBi96KG5eIlJso0YgSLRXia3an/pV6MuQVkZCmKo6Q97k
         IWaj74cxtLrxjsARHGOafRzc2mex90PMR8lMHF4cox63FOiwymX+4EuLPsHewnmu6zge
         G5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772271907; x=1772876707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e93FpEpTqD7Xqu0LewCf9chrUomQqmlqNIwnzg6ALeU=;
        b=xCXsm3JJ+gh39JgfY/xilYsjZdKw5KeBPMp+H1DVJEaZU9QkvqWWywY/Sz8YOb9688
         TM82n2MxBWRM/K871vZ1bVKr//HVp0qI9Pac9FHY5CnKV2O8rd0irAitxQB892is4Rkt
         9ViFWZyXKvIEoPJIpysHnZy27glZ/MG9r8XcuyfROS2ALuFZkBior/VzeTawG/3S+u8l
         GQqwMSJvsnCN/VDDji1zoPwr/Pmsix1peGAJntd2GPrWT4uOsEE3yUNX5Ko1SkhSai1v
         ncv5zNFx1UgqICbDsRh7nXJGAlgFKGkzpD7OSDBgCzbtSWYU3vyrVemF6eKY3futFbk2
         iOKg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZXdmFYDTLJMOJ2Mly1OKIOwjO9b/zyHePXtra6rSnkGc3gAse4vwroZzGdExftOp+Nej9gkRkqj8qhvT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ugvseb+Yud+TtGkcgBF4YMnxWDAnKQr1sUPto/Nj/sNy4lRz
	fpjz4M3+kp5rFnVj2Q1xZcqnrr0SZTO6sLbsKNHZUAbNC174sjowMoSG
X-Gm-Gg: ATEYQzwbHVUn/Qtvrt8B1N8jEMZDO2kbKrInoiU3Q8tGp8bpp1ummWovrzmFUnjE8v0
	RwSjdMfUgNnCTorJt1QeObtbnjmGeKAuZANxc3Vw1NnF87SR0OSKMfJHZ1sS2ApllTE38P4wbTx
	pmLryehm97kFyqWhlprhZndUXBPHpuV56B4ldF95xFyQOwSes3XDkot3hZ6HLq49DWQFwAqvDB0
	jspQG0o1+ccRUsjMUIv0neqOfnhSwEQRym9X2MQxpsnyurCJR2ZrIDhvfDGZKRH7QSmrUZf5cxv
	muH4095tmatjUB9SCl9SX4S+pwLoDcttal5ab/92cBGfGZmt+/6TBMU9lJ1TpF01hehncsO+3eY
	mVZyWv/k/yCKMsTz5GHRND1xk4nHMiU8mQeY9Ex9Y9jTLRb6xZ2EC/KY3AI+pubqg5Zu7gN5apE
	DExo9ef2xYff4LS+dZJH32Y7BikPLjPxhW5U23CAKLayDX1YSIHg==
X-Received: by 2002:a05:6000:2388:b0:435:9690:f056 with SMTP id ffacd0b85a97d-4399de282edmr9551622f8f.35.1772271907005;
        Sat, 28 Feb 2026 01:45:07 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c763e78sm14173521f8f.26.2026.02.28.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:45:06 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: wangqing7171@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] INFO: task hung in filename_rmdir
Date: Sat, 28 Feb 2026 17:44:57 +0800
Message-Id: <20260228094457.2253079-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228082942.1853224-1-wangqing7171@gmail.com>
References: <20260228082942.1853224-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78820-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,512459401510e2a9a39f];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 308391C1CB2
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 at 16:29, Qing Wang <wangqing7171@gmail.com> wrote:
> #syz test
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 58f715f7657e..34a5d49b038b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5383,7 +5383,7 @@ int filename_rmdir(int dfd, struct filename *name)
>  	if (error)
>  		goto exit2;
>  
> -	dentry = start_dirop(path.dentry, &last, lookup_flags);
> +	dentry = __start_dirop(path.dentry, &last, lookup_flags, TASK_KILLABLE);
>  	error = PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto exit3;

Using interruptible locks [0] did not resolve the issue and it only improved
reliability.
 [0] __start_dirop(..., TASK_KILLABLE) -> down_write_killable_nested()

The root cause of this hung task may be a deadlock, and I've found a recent
patchset [1] that may be related. Further analysis of this patch would be
helpful.
 [1] ff7c4ea11a05 - VFS: add start_creating_killable() and start_removing_killable()
     4037d966f034 - VFS: introduce start_dirop() and end_dirop()
     5c8752729970 - VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
     ac50950ca143 - VFS/ovl/smb: introduce start_renaming_dentry()
     833d2b3a072f - Add start_renaming_two_dentries()

--
Qing

