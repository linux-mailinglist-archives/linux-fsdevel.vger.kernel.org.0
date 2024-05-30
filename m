Return-Path: <linux-fsdevel+bounces-20500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B68D43BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92AD1C2195E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99B1C698;
	Thu, 30 May 2024 02:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F9BvcxNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E117545;
	Thu, 30 May 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717036715; cv=none; b=NYiAcVCYjNHDZYHssIbkx+J3E2BsvtGk+T7UZH4OivS/Kwt7xxWiM5AgL5VS3OZXgJUxM/ld8wREKnQHzimvFZSUgZ9uOfnMBPuspT3+ouqyZHiUy3DH1JxL/sIFjMUdaRbWtm3ni/M3jKqQoTvTt5tVlZMb2WzkD/J+zwv70eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717036715; c=relaxed/simple;
	bh=TNoVU3TtSf6bcIdcXsfbZYo/x8ibozTXW6/eh8jkNaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNBsBZHXjrYQCvEmSeDKtY69i/yFiFkJaGyciKrgNGPacsuCuDttf7xrTITZS3sXc1batEvTrdzVSH4VMQ4M80tSPoQ0S1KImnyxHw7tm2RvVKyKWcohu74CD5OncxP3eNkUyjwe97/l1CToCLyIzueilATYSDkYQ5fjJf+2o3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; dkim=fail (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F9BvcxNL reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.174; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id A879C7C012C;
	Thu, 30 May 2024 10:33:09 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ANTISPAM-LEVEL:2
X-SKE-CHECKED:1
X-ABS-CHECKED:1
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1860752T281471823376752S1717036388286019_;
	Thu, 30 May 2024 10:33:09 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:liuwei09@cestc.cn
X-RCPT-COUNT:9
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<ab71a20c679e9c04ec8ec16fdd219dda>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: liuwei09@cestc.cn
Cc: akpm@linux-foundation.org,
	hch@lst.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rgoldwyn@suse.com,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when io with IOCB_NOWAIT
Date: Thu, 30 May 2024 10:33:04 +0800
Message-ID: <c66ca795-da93-437c-bb11-718801f8114a@kernel.dk>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240527100908.49913-1-liuwei09@cestc.cn>
References: <024b9a30-ad3b-4063-b5c8-e6c948ad6b2e@kernel.dk> <20240527100908.49913-1-liuwei09@cestc.cn>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493717E8E2 for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4c043d2f6so35095ad.2 for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716824187; x=1717428987; darn=vger.kernel.org; h=content-transfer-encoding:in-reply-to:from:content-language :references:cc:to:subject:user-agent:mime-version:date:message-id :from:to:cc:subject:date:message-id:reply-to; bh=FGMRKGoSYUA5y3/8ZCfrZ1xp7rqzMx12hKUQWEXXdwY=; b=F9BvcxNLHbFCL5XfHLnGTxQs/kbGpALZnSl2DYjNA/21xx0FBmmySwAJN/5dtkPhZV IwwKjcqRB9pV10OOLL6wHdu5znp/6PE86Vas57cBS/wuAbBw2UZndM8t2ducr7YYWm6Y qK9hMREyXKjeBhZWSjTI2InCbzAtbz3PLAwXmX2LUbmD27CV84Ld62XttJh+nGQRapAs b070pptuUluTj7BrbyTY7tkobVJKFo/9qxvErZHnOMlm8wItNpZuLUNC8RDdtzThAB2N KMJsW+YN/2uWpInjYvnpvDqSoW6Kn8DylQoMu4CqVNrueusLUWYFZNSZk1pdxY03zMc1 k2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1716824187; x=1717428987; h=content-transfer-encoding:in-reply-to:from:content-language :references:cc:to:subject:user-agent:mime-version:date:message-id :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to; bh=FGMRKGoSYUA5y3/8ZCfrZ1xp7rqzMx12hKUQWEXXdwY=; b=CPhMhbHOK9YffoFiKDtV0Khpu+NfyscXGdbauR7ikW2SVhyGiJpw4+uaH2oTdxcQJp 8n4PLLZijcpA7uhY6eSngYbNg9W0N8GVCb0k+Es5NqFIDwRGN5hQ53IWyAuavf8MxoPQ gyf/CMAUI2l4mRd6ebTUPSgYTPvl+YPTsWJWI6RVFTvYrWMlXaDm72KLOUADWEQhAvtZ wIQt3RivAEe6aaeIkaFXSlkvu3/TkmFqvry2kOWIMCJuavmmBTFM+6Jm8zt1wOhuvRDX KeT9zlF1L0CSx7G6Eu0CQqpNUPji9HMjieOGHhgPLFFXAc1685CBAslFxHZSSIx3CZi6 rypw==
X-Forwarded-Encrypted: i=1; AJvYcCUMOG1hqfcAj8O+U8OYJhDCzufVhCbdgAbARsyGquOUCPGzb4/qlUWfi1GmEWjyNPXVWjcnOAIwkpkfqK1b0Rr2kWyMri0yOsSYAgLj
X-Gm-Message-State: AOJu0YzKpYHq7uA5B37LhUsrmqqOlmSrPE30ly9kbznTlXurSaloSBil CUW6yqJdNri6W8/hPsAPPODhw+jVKov//aV6VQLQxPVoTmgOmj9khDGcyWUQ8lk=
X-Google-Smtp-Source: AGHT+IHTxIPNAK3HsNoC9uItVsCnZCK8MD3ThRKVvVNi4TwdQa2YRFJqyU+MaLPmqStXfF6Dl3dotQ==
X-Received: by 2002:a17:902:e810:b0:1f2:fd9a:dbf8 with SMTP id d9443c01a7336-1f449907a09mr116945035ad.5.1716824186842; Mon, 27 May 2024 08:36:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194]) by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c970058sm64280955ad.121.2024.05.27.08.36.25 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128); Mon, 27 May 2024 08:36:26 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

On 5/27/24 4:09 AM, Liu Wei wrote:
> > I am a newer, thanks for the reminder.
> > 
> >>
> >> I don't think WB_SYNC_NONE tells it not to block, it just says not to
> >> wait for it... So this won't work as-is.
> > 
> > Yes, but I think an asynchronous writex-back is better than simply
> > return EAGAIN. By using __filemap_fdatawrite_range to trigger a
> > writeback, subsequent retries may have a higher chance of success. 
> 
> And what's the application supposed to do, just hammer on the same
> IOCB_NOWAIT submission until it then succeeds? The only way this can
> reasonably work for that would be if yo can do:
> 
> 1) Issue IOCB_NOWAIT IO
> 2) Get -EAGAIN
> 3) Sync kick off writeback, wait for it to be done
> 4) Issue IOCB_NOWAIT IO again
> 5) Success
> 
> If you just kick it off, then you'd repeat steps 1..2 ad nauseam until
> it works out, not tenable.
> 
> And this doesn't even include the other point I mentioned, which is
> __filemap_fdatawrite_range() IO issue blocking in the first place.
> 
> So no, NAK on this patch.
>

I know, thanks for your patient explanation.



