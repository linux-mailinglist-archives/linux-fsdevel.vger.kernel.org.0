Return-Path: <linux-fsdevel+bounces-24697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AE9432B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 17:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824231C213C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FBA14A90;
	Wed, 31 Jul 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QuqzyIQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435C1CAA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438471; cv=none; b=IObezf1WToe0FFmU3qA7AUbgxfzRyICqkPUgvn0fCIztjEOTqay4SX1ZEiGPOKtZCQ6Ln76FL7U73NOXlZm2JRT0f1tVe+QBCtZC02ACwFFTrsu17yWc0ejcI/Y09pkvniKq+yHSq5tmHix1J77uBZhLwvO6c/JGsTk2f9PFEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438471; c=relaxed/simple;
	bh=iP1NxH127btnW50gnvB5w9L+XsSvvMhs2i7Azuvbfpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg0+vNPsf9dy2dwTOMu3aocG2TTxeZKkgvjOjwHVebZSP1vXFiL9fYs1aLiOd/Yck8JaX59PSbGfFhzkS7PH3/FWORZ5kGVt1rxBnfryklYhmOnsncx4qQJxTy3AVwmsjBEcRb28HWynQK6pFYfotSJORhWB50OTZeMUXtKq/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QuqzyIQ3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc346ceso8286800a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722438468; x=1723043268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2eomkWSEfqxmeXJ2mXgbcKL+Gc+ZPskWjvUawS3yh8=;
        b=QuqzyIQ3JCAJ8bAlfw/p+tjsxAXs2D7vWSIW0rSpbngHY6ZfYLZgazKETiwm8mK139
         /kXiJngGJhTw/Q/gKDrwG9uW3AJdDIQ7WhqUAjUcctHiK+XsAdQOGsvUcDfLr33rIv4/
         jtKd/27s5cqLxxqTsZvGRM8w8hek/BynKisxts6yVu/Os6gDeP7WxO7T4ZGpiRXXSa2/
         pwGea7kPpANvRcFnw8kuT0K0Mkobd1ZfrJRYR1jtSQ59sL5F+V66LYnDAoDcJmv2CUn/
         KAQJovRemozANvd1Hkdu9KxWHjCY9vl/DHSqcu8EdF0LPvc3it8g2B2d6yVp82G/nZJw
         VPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438468; x=1723043268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2eomkWSEfqxmeXJ2mXgbcKL+Gc+ZPskWjvUawS3yh8=;
        b=Gg9Smqqc0GE4gd/jDATmPoSAWoyVYbc87c5fTXRJJiYGJvtraVQG1I5PRA/OxDeNSE
         g/8qZus22G8BLugTQbY1QD1Q14lA6pHeH3Hqydvo0IcnaeWrCDfIgi6c/MCJI53C1+En
         kGjAEY8VZLRV9w7fltuJAX155DtaAvpLBFVzCY+L5NpD7tq1q9K6baz/gG+FZIa5pGuM
         fWsytrLn4lnVzJlDp+cmnELs3LBAZ01xvancMH6L3cSGBFtHeAj+4T0gBFXzHgaNi5Gr
         I59kr+KawdFjR4hcD8PHQh9ag9p+R6cbjRJJBGk+vOSrQShZQRdXCWeD661nwIqqd445
         Cfbg==
X-Forwarded-Encrypted: i=1; AJvYcCWfD9Czrj4JWu3BiDQGC/d0BFiI2pmMl1X9hd0Oi8oWRPgSkYuM/bTq6ZDkASMRv3Fy1u/ObYm8VlI+gJLsjvBSSennGuhr+ZdJ7AMUZg==
X-Gm-Message-State: AOJu0YzxJkKgelIRwCWt/E2W2sTXw95O4stHonzXaIEMaFEwPxsSmkf6
	vdKBPB0qAMWEtKekyRZm0yxmDjmuSZwN9CpTuZchiR2hJOLetQrYwEDpwLxlcmQ=
X-Google-Smtp-Source: AGHT+IEwnvtwhfLLeLzn1bYGodP4q9ALIGyImHhEVNjIC7E01AiPuIt2RA3tGW0kOfv7VquTNsoL1A==
X-Received: by 2002:a50:9e4c:0:b0:5b1:433:579b with SMTP id 4fb4d7f45d1cf-5b104335cb3mr7362752a12.37.1722438467640;
        Wed, 31 Jul 2024 08:07:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d1esm8839397a12.27.2024.07.31.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:07:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:07:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v3 15/19] proc: Add nbcon support for
 /proc/consoles
Message-ID: <ZqpTQUSTmuBQbOrJ@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-16-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:35, John Ogness wrote:
> Update /proc/consoles output to show 'W' if an nbcon console is
> registered. Since the write_thread() callback is mandatory, it
> enough just to check if it is an nbcon console.
> 
> Also update /proc/consoles output to show 'N' if it is an
> nbcon console.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

