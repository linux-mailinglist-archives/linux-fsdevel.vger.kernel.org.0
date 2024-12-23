Return-Path: <linux-fsdevel+bounces-38076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974B9FB612
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6531883F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D84192B69;
	Mon, 23 Dec 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zmXDaq3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACC38F82
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734989504; cv=none; b=utafGgLaAa0fxLsH0iEIG6p+vEFdkRjn625jHpyDfbSVa7+013dm3SoyEROfqPqUeBQ5GAL01QLq4TnB5/NPhTNAts1Y/12cDDIFr2WpgR+/u1sR70X2fBijGBDzZ7LpBFjGUyoTn04wFKSmF7kDE5mZURD1nZwOu+U3I20zPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734989504; c=relaxed/simple;
	bh=TEnNTsSmLhFVQj50TC12c6YUNdCsbs8cAvPfuK/Yy64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwG4bu49gVkd6CivIRiVqnInUlFXieGCwn0uw+DmVhbnZ+6/gFjVOLPdTaPY2zpB6MiupYs3Tx/OPGTpt6DFadYheT5LQIN3lWJ9Txalttnjpm5jPES6JVLOeEnWCLk0P1/vnHRJ82Y38SJAy4wPCWGDIMBQz3g1qyJeemJN+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zmXDaq3D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21631789fcdso37633605ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734989500; x=1735594300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3+PaDeyweM37bDhC+3lxFg5MmixID8o8YT3d4o1+ls=;
        b=zmXDaq3Di1qICeUidHS+6Dn9Qzp3GcKkTo8xoNqNobxuCHLrTVNx4M5zLwJrSeYE73
         WQUt/6RyjmLfDdpN0qFngfMSkSpbHMC1pRvZ3gPgkr6IddiWD3SiIEY1lhhqCZBgm6AG
         FI7gdGKevuLTOnz1q6yH5StQ2VpKcIz1zoSGL8tDI0Q15QqSfPlTpNqmyvMsk3uVZ7xG
         nHCvosxn2P/RCXM0b5wzjLzO5lRmwDqPBn4lelzm5qa5qj8VK230i86QvKOYi5tRp+PE
         M7+rsWJRNizaQse0Hu7CduSMF7rmunILuhzlK5cxRyos3aSiqJZbM3GNzsw4+kzPXOD0
         IHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734989500; x=1735594300;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3+PaDeyweM37bDhC+3lxFg5MmixID8o8YT3d4o1+ls=;
        b=isDShrUvUz5lGrDEzhQYzc6/WcuGIc3+SFSAmGXXNUCTh8s3vo79a+CdoKtHiVgFzD
         1mBE9k2H/+4VP5UYk81hhw9k67fYpyEI51qQMPYwCQI/fj7Uy/+YsNRIhsUVp89UX3Df
         yGP3CQnKNAcgp+IHV+rJD2UJxMCchj3onEjEGPrDp3nRrEtMBw1TxmaBusQqnSpX/rjb
         6KlUKsVBOM108F/33GhUjlor8aNi7PuRApAxKDHYyjT1JhBTmIG2+ox477uUFCP3EuxQ
         pMEHgy7FlB/dHR/D3+p+hj4TKU0E/STHgIU3Iugsn2+otxLH/jRL0h1HEqIR8+tOqAOt
         IP4Q==
X-Gm-Message-State: AOJu0YzU3saqcdnWfrabQvSV0aDlGr33H33Q5t197vpR9jpWtxlHznuY
	QG7rHNJQBREeguCUjBFgLFBJJfApHHrBklUX3tS5461ZtdNUq6pDMuPSBLBZsTY=
X-Gm-Gg: ASbGncs84YVRVfGQNnnWzpdyq7MLUESEkE/TCCLsNgHH482focVLgzaRkIC8BNYdxiT
	xeZa6wep/bIfaJD3a3xkufqEroHt+sOXwE6bnrVpzZsoeXDDGBygVCAuk0aT6pCzqxGAtV3sT5m
	HaVhh28lf5c0fu0yn1O6VNc5nDD/8hAIHqQBndL6OWnDB4SVPy57gNLm9OSWMNIvLi2dqhFW4Mz
	lMnaEky5VIKs9dH2Oz1J6TL5/cqq3ZRfyIOscg2nvpD1xeOHvq4kg==
X-Google-Smtp-Source: AGHT+IFkUnx02oG/6hTXREpH0MziN7J8SUpf5guAivLpdpDvUD9M+E4KD/7DFm5//ZyuUYGXQXw7Gg==
X-Received: by 2002:a05:6a20:43ac:b0:1e1:e2d8:fd4a with SMTP id adf61e73a8af0-1e5e1e04618mr21987521637.5.1734989500329;
        Mon, 23 Dec 2024 13:31:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb7dbsm8332466b3a.133.2024.12.23.13.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 13:31:39 -0800 (PST)
Message-ID: <41e481e9-6e7f-4ce0-8b2d-c12491cce2dc@kernel.dk>
Date: Mon, 23 Dec 2024 14:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV> <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV> <20241210024523.GD3387508@ZenIV>
 <20241223042540.GG1977892@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241223042540.GG1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/24 9:25 PM, Al Viro wrote:
> On Tue, Dec 10, 2024 at 02:45:23AM +0000, Al Viro wrote:
>> On Mon, Dec 09, 2024 at 11:12:37PM +0000, Al Viro wrote:
>>>
>>> Actually, grepping for DNAME_INLINE_LEN brings some interesting hits:
>>> drivers/net/ieee802154/adf7242.c:1165:  char debugfs_dir_name[DNAME_INLINE_LEN + 1];
>>> 	cargo-culted, AFAICS; would be better off with a constant of their own.
>>>
>>> fs/ext4/fast_commit.c:326:              fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
>>> fs/ext4/fast_commit.c:452:      if (dentry->d_name.len > DNAME_INLINE_LEN) {
>>> fs/ext4/fast_commit.c:1332:                     fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
>>> fs/ext4/fast_commit.h:113:      unsigned char fcd_iname[DNAME_INLINE_LEN];      /* Dirent name string */
>>> 	Looks like that might want struct name_snapshot, along with
>>> {take,release}_dentry_name_snapshot().
>>
>> See viro/vfs.git#work.dcache.  I've thrown ext4/fast_commit conversion
>> into the end of that pile.  NOTE: that stuff obviously needs profiling.
>> It does survive light testing (boot/ltp/xfstests), but review and more
>> testing (including serious profiling) is obviously needed.
>>
>> Patches in followups...
> 
> More fun with ->d_name, ->d_iname and friends:
> 
> 87ce955b24c9 "io_uring: add ->show_fdinfo() for the io_uring file descriptor"
> is playing silly buggers with ->d_iname for some reason.  This
>         seq_printf(m, "UserFiles:\t%u\n", ctx->file_table.data.nr);
>         for (i = 0; has_lock && i < ctx->file_table.data.nr; i++) {
>                 struct file *f = NULL;
> 
>                 if (ctx->file_table.data.nodes[i])
>                         f = io_slot_file(ctx->file_table.data.nodes[i]);
>                 if (f)
>                         seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
>                 else
>                         seq_printf(m, "%5u: <none>\n", i);
>         }
> produces user-visible data.  For each slot in io_uring file table you
> show either that it's empty (fine) or, for files with short names, the
> last component of the name (no quoting, etc. - just a string as-is) or
> the last short name that dentry used to have.
> 
> And that's a user-visible ABI.  What the hell?
> 
> NOTE: file here is may be anything whatsoever.  It may be a pipe,
> an arbitrary file in tmpfs, a socket, etc.
> 
> How hard an ABI it is?  If it's really used by random userland code
> (admin tools, etc.), we have a problem.  If that thing is cast in
> stone, we'll have to emulate the current behaviour of that code,
> no matter what.  I really hope it can be replaced with something
> saner, though.
> 
> Incidentally, call your file "<none>"; is the current behaviour
> the right thing to do?
> 
> What behaviour _is_ actually wanted?  Jens, Jann?

It's not really API, it's just for debugging purposes. Ideal behavior -
show the file name, if possible, if not it can be anything like "anon
inode" or whatever.

IOW, we can change this however we want.

-- 
Jens Axboe

