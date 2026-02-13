Return-Path: <linux-fsdevel+bounces-77158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APyNILRjj2n6QgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:47:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DECB6138BA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B959D303DD09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15966247295;
	Fri, 13 Feb 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6AxjJvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400922FF22
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004848; cv=none; b=QmNNH693hah4WzOx6i1AHyUGrLVvDd+Lkp3lP8q49X+bKKr09rpnAr3mLq1BPGaPIq6a7tNZIOOSSx2K1I6kHydd8MS4ooK67eyr9c/qqQMpVRTru4WB8y/1FSfP50A2e8rZfz23IPtrnIbzDnmgu9vi3DokwOmH+4QwgYkqAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004848; c=relaxed/simple;
	bh=cVUP1khg9y77f5SqQCygYm8i6x45YeX2k4zXUc1LA5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te81Hu0L98xPA7xrElSSuk0Ozi+t9MMffYtNVkR2Frhsa6KdO1ACz3ArgKikLhQXEeZBdW2WoRRuPiSO/3nynjml3qb6AbQQ/5odtzS+xhUIqMuxOHes4iQoribrR+G/DHGaILjDeQsQ3msYFA+AIDYfPQXYvogF0RDbG6BzpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6AxjJvM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43767807da6so741417f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771004846; x=1771609646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PosW/YBGoUIFQFPUNvEYuUV8ta1niybZBwavkBZhlcg=;
        b=P6AxjJvMA0wR9t9G2Jt/o+X79XY6HP2gB4U/n7IgJ13/IqSe2sw4ri4czwETbvzR2q
         YKfQdn3/hIz1k6WJ6Phy1Mz8ubpEF0KaRYLc7m7tZRq7/8esaCGgqQ38iuLwxjOcwK+X
         M3a7gNpBSMP2xlap+lZuc2EndjPD60+q5qKPC7VlozgZSBllhXW9JAAmfyOB5/WBtg+P
         nvnXKABA99hpdZZjptAEyvG8AjgH1ZHw0jojBaCdC5rb8k+n9I4dTdBcMHCrcDQ6bQIa
         eJIPhqMRjJR/KS8fZk4igx7di5mb5NCZ9Upg/esqFu+Byc5w+spKxuAW67uZBzyMFV3I
         AohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004846; x=1771609646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PosW/YBGoUIFQFPUNvEYuUV8ta1niybZBwavkBZhlcg=;
        b=joQJaZ1ZiLY9ezEBVaa4qMJHfdfmLvnn5zMi7yxKCwa5Pjnip0xg4uLUuQJuMLSSLy
         cmlGsgzFL4SUi0PKZxOySlBaQ3VRwzVcFmjdUsGg6JmMGEg9K/sz12kjT+QAxhYy7Pdw
         xEd7c0+TeydwXE7r/v91gi6pNYRSVMmKHl9PS5NNzMuslE6WYWRl8ELXMexxciDeizTB
         XmJITd8u8r7bwiiIf2NfZ8NdEQwHP1el2hfPDty8h8y17e4F8Jxgdu7rpshEeXwbqJxl
         AGVHJFYoL0QENlyJUEo5LZqYf9mhAaBiOwyKqfa8EqsJ6sPEc5fk+zG8nOoOyjC440VX
         38cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN3BqJx8aRbVhD2ROqefTMax0drY0TgDveAKne8ah5j/kHXXb8h0TQ4VmzdPJn+pwHHYgWgI/JFK1HDzbr@vger.kernel.org
X-Gm-Message-State: AOJu0YypdT4fI/kFA/q665XNKfMkEkfF1HNJNsgVm8itKYiV6L83uk/W
	S3M9WUSlg6+AVZ8A5bMJeEI23tDNYf+FX+0HuXZp2aONVNgBUX/di/sB
X-Gm-Gg: AZuq6aIig1+rR0oZgtXTkp9z8NC8GByRNWJPj8X+fEhbC5QIvFqcF5r8uaqxogbPVXz
	aDgB2vWsm76IVOdBmEeGuQwe4L/UoIzkm6WanwmSjYWihZsboQoPL/7VTF2p+37hhpOUqd3Fgyw
	6b/JiayvKgRboU0MzQ3n5yv5EFvDuit1f+jjFmwwaPxiJBcA7BlcXmGac6Ssj+I1OHx09E8XpzL
	262d1I62kjO+LW2G6mC7WX3kNXPSWpSUOVxCgIODuAOnn1s3cLPKeLuWTfXZlvII1McOgzAHp+3
	xOvntnrvGSOdcgTzS/w2zS1HEG4BVAMyyha1P+4Iklso1B0uRtP98x7i9FtlECkR7MWo2LHv4V9
	w8EpCFECFoKFxj7Ri01DeQn2cCDRJyUmpovdzY9OAEauftmARkKJgd/MJQZ4f8Ovd1aoU4UCWEi
	dhTMIeE8DQiRuLGZSnB2o=
X-Received: by 2002:a05:6000:238a:b0:435:e520:d1d7 with SMTP id ffacd0b85a97d-4379793f0d7mr5204850f8f.63.1771004845710;
        Fri, 13 Feb 2026 09:47:25 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796ac8d82sm7274389f8f.31.2026.02.13.09.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 09:47:25 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: hpa@zytor.com
Cc: christian@brauner.io,
	cyphar@cyphar.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Date: Fri, 13 Feb 2026 20:47:21 +0300
Message-ID: <20260213174721.132662-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[brauner.io,cyphar.com,suse.cz,vger.kernel.org,gmail.com,linux-foundation.org,zeniv.linux.org.uk,almesberger.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77158-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DECB6138BA1
X-Rspamd-Action: no action

"H. Peter Anvin" <hpa@zytor.com>:
> It would be interesting to see how much would break if pivot_root() was restricted (with kernel threads parked in nullfs safely out of the way.)

As well as I understand, kernel threads need to follow real root directory,
because they sometimes load firmware from /lib/firmware and call
user mode helpers, such as modprobe.

-- 
Askar Safin

