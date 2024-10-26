Return-Path: <linux-fsdevel+bounces-32996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AD9B13F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 03:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4D428344C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4470B67E;
	Sat, 26 Oct 2024 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgBxMOEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B595217F20;
	Sat, 26 Oct 2024 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729904471; cv=none; b=MPBb5dWzotSaTqdfR83r6AaTt3l60kIAUd22MYnBFcVUrKZcUuS+WX65dWM5ZJABf2xCCUFU11YagmRTLOs4PZAau2DRYaU60kARBNmgoqchFwPFPUGMzzZ5AIzaYfbnchRSSNgRAXLilfNneamrlRuona6mVJYvcZml3AzZcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729904471; c=relaxed/simple;
	bh=74naCgbzblilLVmg2wQT4pdyCk+BiN3JSv/pOpMQSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj7iOyICwrKvZcSiS9Onavzf5r+ZAAuUFL3K5ux8cqoUVkaC48WfGVzesU07D6+bKQOemimc9AzxJ1fVXjJ7OQJn+QE03G4wdKnhxn0Ok+PZwXt3QAPRuCBqD6wcptB8JYcYq6XJZKcowPSfk2BiKbbMNFoeMhHHZ48Z8dFCUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgBxMOEX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e67d12d04so1933050b3a.1;
        Fri, 25 Oct 2024 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729904469; x=1730509269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kp+8rpGshAmIc76TzwqKIgLwwjDzh58oBtEsaBWEayc=;
        b=QgBxMOEXXlvZ0kMR2U+z7d4GQQPw01+kdn/hNkZRNV5xFBAX76T28VoFCfGDJCqFu2
         mNMA9rnfpB7vcrStHAbv9aQ1SRj7W3X6rRqFfn60c0blcg3a8oEjPTZ/K2frMkO/PXP7
         ALHcaOg3Q7rc22lB2zjNaXbAVm//t7rT9h1SSIU6fijoh2xzfYGklzr4ZojHxZYCyN0x
         ckbD17388GG7woigE0Zf/iqGvCQVOmunxzIKYxXcZt4mAJzQ/cbf/m/e2I6mSnv/j4Co
         OXNIEt0lgVJcKjMgLiUDDFqY56Hv/8ysi/nRfIUhzhXLlNzQn8QPHKWyylM1TZn+7aFa
         mJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729904469; x=1730509269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp+8rpGshAmIc76TzwqKIgLwwjDzh58oBtEsaBWEayc=;
        b=cR+ONOwMeLIzcCrVFwnfZPTDcnnx/qlqVvyVLld3WFwCh0k4p0fYr05sulX96BoG3V
         zNGpQt9iN97Vna8F0iw419HLcPia6gu0uaiksrNkgxx/B4qEd8DbqJJytecjzftvwQ27
         EwnUZz/Kh7rfjfjUodsz4azbLXY7Hs+xd8i9lew2aH0/TCPPZAykF/JE9SrnVSIweuaq
         seiaOWn2QI3oTjNEgW73Va31rCkC3JMZkRVdO7Joa6aovjNKIvQkeJ8VOUqsszaWrYDn
         q2VWVZlE7+/IuOZKaRWu55arymWnBnzdnUgbK9l+q/GrTwLIkkctqzy1aTJnylyRW1qL
         fsuA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHA8hWn4UiQvztdFHrS1SECJpXMpbja/J0EELDmM9UazzAi8u5Z9y+iC8aY4qB+zjJP849RwxFLeJrHsb@vger.kernel.org, AJvYcCV258bPPYXpoZvkyziuTsTbSfKpXYPYtjQgBZizqMX+AKIcAdu2o2gKHsjwTVCGedUQ/ykCpx2NRADYvGqh@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWSC0ta5OwlRFMBeWMB5zTO4S6j+d+GfC2RyOInBnF6ys1dQ1
	w/9wstE3FaSf56mfaoueRBddf1473DEkVBGB3UmD8b3Fs+gOpL6L5VnOAt1m
X-Google-Smtp-Source: AGHT+IFS9p5Ie6Pnt4Z3FtjjRose2pRphMsKXMbqemvY6B1XjtckJ8+MzcaKx5TFNSfJKuhYpk67oQ==
X-Received: by 2002:aa7:870d:0:b0:71e:7604:a76 with SMTP id d2e1a72fcca58-72062f865a6mr1796148b3a.1.1729904468749;
        Fri, 25 Oct 2024 18:01:08 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89ffb51sm1734781a12.63.2024.10.25.18.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 18:01:08 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:01:06 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, jlayton@kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Add a check for NULL folioq in
 netfs_writeback_unlock_folios
Message-ID: <Zxw_UgtVWOHHfkoD@gmail.com>
References: <ZxshMEW4U7MTgQYa@gmail.com>
 <3951592.1729843553@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3951592.1729843553@warthog.procyon.org.uk>

On Fri, Oct 25, 2024 at 09:05:53AM +0100, David Howells wrote:
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > syzkaller reported a null-pointer dereference bug
> > (https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
> > netfs_writeback_unlock_folios caused by passing a NULL folioq to
> > folioq_folio. Fix by adding a check before entering the loop.
> 
> And, of course, the preceding:
> 
> 	if (slot >= folioq_nr_slots(folioq)) {
> 
> doesn't oops because it doesn't actually dereference folioq.
> 
> However... if we get into this function, there absolutely *should* be at least
> one folioq in the rolling buffer.  Part of the rolling buffer's method of
> operation involves keeping at least one folioq around at all times so that we
> don't need to use locks to add/remove from the queue.
> 
> Either the rolling buffer wasn't initialised yet (and it should be initialised
> for all write requests by netfs_create_write_req()) or it has been destroyed
> already.
> 
> Either way, your patch is, unfortunately, just covering up the symptoms rather
> than fixing the root cause.  I suggest instead that we patch the function to
> detect the empty rolling buffer up front, dump some information about the bad
> request and return.
> 
> David
> 
I see. This might be a stupid question, but is it ever possible that we have
exactly one folioq and at the same time

        slot >= folioq_nr_slots(folioq)

is true? Then I imagine netfs_delete_buffer_head would return NULL and
cause the bug to trigger as well?

