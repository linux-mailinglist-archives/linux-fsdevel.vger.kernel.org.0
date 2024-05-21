Return-Path: <linux-fsdevel+bounces-19913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A880F8CB1E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD641F21F41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9031CAB7;
	Tue, 21 May 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Db7NzW+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810E2D7A8
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307504; cv=none; b=DWxmII5xcmoOlN8SRXNK3wgovwghWoDi1eQfcsyCmNuFVIi6jVF75f5CL9JrPZhzdKPaH8w2+pyrcLPIzmFVav8exz8xG5pTsfG9oKGoVxfrIlvfQvXXjCh3S21dw7zUf/DoxzDegyWSsF7Gyn3AQz7wjuNBs5TZDkPVtMPVltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307504; c=relaxed/simple;
	bh=bKdqkY8H9wTw5y+8oj6M+om12H9BkqcMweVk8ln1A/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGLD4pkRk9dcTfn/7YiMixsXwPJISUZSJUFKnF0u1Ft7rq+tXkrZOfN4rk67Z1k5A467XaRRCLsEGrgZeUyf5UFeK2x1jbbRa4JEca9/ONZepk08Vi9ukR47pvnpkS4GQEPBmNp44snm5uwQCtJPAbVFMsuZ4amO4FdDha+5ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Db7NzW+E; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36d92f4e553so1585355ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716307502; x=1716912302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nt4NT2eZ7AdGPqZ8UIZ+5/ykmoqBj7Ymiyz5OlxoaQ=;
        b=Db7NzW+EBXUhuNcDgbMNrT0eqz5RlvT2kO+XlAGZeQ8CNgE6YmV9nXVVBFUF0l2nQ0
         7LVd6iNvRiDF5d5PkB5C57dAw6cPoYQWZyhafZ2v8H57HMHWmRUlEzhu/QtU5EhgaUOZ
         fZxkXJVQ11OKQZDKkwQIHk8HH8fFhPUYUU7Enn6/BKUNxm66nKrfSaYaohwAOZiGvtdI
         vtumnXT1wRh2KNTjhizQpoUuviH3xoqBfWL19ml0+S60lpIJ1saiEuWzNo8DZEJZanHr
         DeuIwZFUty3mkIib9nEAYcIrfFY4VJXCt+B1/sEgz7IbjaF8Mvz0pC74VGtKWalbduX8
         Mrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307502; x=1716912302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nt4NT2eZ7AdGPqZ8UIZ+5/ykmoqBj7Ymiyz5OlxoaQ=;
        b=quzw53o2bnTNNlbXkAq9c/DCZSzVSUdpiWL2vK2I+3Ke3Nwv0ugtHvWnLeqeg0gPu6
         mX/U4r7Rl1cYYstOpiqnbaNNwKlGuLnEwljFEspHnuR+oa0kjOETVFhq+1riPiE4TSjO
         lBckY/SyyZ3DLalKvwXq8LH+zVLRyRrXpwNRcyv9xTvG0wnUOcWRUzg6Oaqp5rCTA+GY
         Y1L2e9G2Rkr4yXqSKLZTCC62a9FMs3eNha8p4ydxs0fRuVWz2wR1mOyOmSxHmKAKONSp
         s8lDbQmcztTlg7RfuymMy3QhoBjXR6J4Jr7sPgK6XESpJdJzSfR6l3EqIx89mD+INTEZ
         JyZA==
X-Forwarded-Encrypted: i=1; AJvYcCVt48vqyYkUxvUxbIL/InsB2+LoYbuwcGE/5ggU9sAyxyoeu7VsSRrscDZ7gjF5ALZO5Srtuh7s/RpaMbIMVlHYkRV53pBoHx640Lj/fQ==
X-Gm-Message-State: AOJu0YwiV2kqNmjgz/tcAv3ufgNBLU7ueOieAx37glVzfrmUPdImOTQ5
	KXlUKMiL9Jco6xKUBml3Tg0EwHnA2U2GJvX4cvhfSRT2HD5CMJMrVnr8b1bwWOI=
X-Google-Smtp-Source: AGHT+IENbxbCIveBfU+56Mh8grD6M5RzWxhN7Hek5IRjzUTl0X8SyhHShX4YeSl1RmBxMd1Vsijtiw==
X-Received: by 2002:a92:d3d1:0:b0:36c:5440:7454 with SMTP id e9e14a558f8ab-36cc1444bedmr308848125ab.1.1716307501743;
        Tue, 21 May 2024 09:05:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d9c943sm64565475ab.49.2024.05.21.09.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 09:05:01 -0700 (PDT)
Message-ID: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk>
Date: Tue, 21 May 2024 10:04:59 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>,
 Enzo Matsumiya <ematsumiya@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
 <316306.1716306586@warthog.procyon.org.uk>
 <316428.1716306899@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316428.1716306899@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:54 AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> However, I'll note that BDP_ASYNC is horribly named, it should be
>> BDP_NOWAIT instead. But that's a separate thing, fix looks correct
>> as-is.
> 
> I thought IOCB_NOWAIT was related to RWF_NOWAIT, but apparently not from the
> code.

It is, something submitted with RWF_NOWAIT should have IOCB_NOWAIT set.
But RWF_NOWAIT isn't the sole user of IOCB_NOWAIT, and no assumptions
should be made about whether something is sync or async based on whether
or not RWF_NOWAIT is set. Those aren't related other than _some_ proper
async IO will have IOCB_NOWAIT set, and others will not.

-- 
Jens Axboe


