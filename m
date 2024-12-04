Return-Path: <linux-fsdevel+bounces-36400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D20B9E353E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 09:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333F5282194
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42A192D91;
	Wed,  4 Dec 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwmlboSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF0136338;
	Wed,  4 Dec 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300856; cv=none; b=Se2grQLGcVgH1EeR+K4oXCIcJm8fEGAwuAy313lDwEB2lwaeTIGrVBkV+UfHiOxRaXbneTsmp6iweUUbg2xTBf8+sUZeWj6VpaHzZsAykDTvH0S14if/C3xHI2uqFotnxwLD3JN7SzgK4Y1WYxb89+6dLFFbObsHMPAm5DVbzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300856; c=relaxed/simple;
	bh=ucfBwFNm0ABhHUXqA9vCNAbh5NsOj2dYkGl7XgX6DzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAXzvWQAT52bbwU3octDhNaAL5NJBklHIQb+LG3+OJ/t8Ff6+adKas+yz8vGxxokbYP3sbs0Zwwlt2on8G4wjN2/DYv6dtyJ+pqrOn0mnp3zy/g7SLfsWyZrOt5IpikF4y8WFFCuCOX9WEtDVcGCLLTNPmBn1CpF+/ER/k59ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwmlboSm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso335722366b.3;
        Wed, 04 Dec 2024 00:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733300853; x=1733905653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yzShrViHPdCPjMWdlFTiNS/QjPXPWPOzuyMGv4WSxU=;
        b=hwmlboSmT8T72ukGkExGl3tCHWJEHfj5Sb75hbgJNqk4JvsL4QuDy66TTecCOQLcvn
         zQ4Iq1GdjuabR6LoEp/tjS8korsRg00tb/uJMREDmpPsdty2z4AmIDchzg76mXIYqsiu
         FpO3tCkfGHUVAo0H1unUFSHgbTJ+UqYoDnGn1f0248XyL2WKjyKFJFHVoFmKdq6tOvRZ
         Ujft6yUAiykL/pdk8FQzgwSujgl4a1o/8hB0z8P17PCyjsB9Npleye9C1ZHnFgJRtPrU
         4OSOsMIfKyDBMqVTQrVdSkH3fCut+FMZiBcIDPf41d1oy5yAl7mUnyM1xD7ERt3RzWun
         8GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300853; x=1733905653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yzShrViHPdCPjMWdlFTiNS/QjPXPWPOzuyMGv4WSxU=;
        b=J1N6g02mqW6BjMMgL0rI2pt5w9zcuegDQ3ed20/QVkeU/PaA/s+V2mBAFVMDqNjYhv
         5E6XwLdUwiSaZ2CDfydBYfoyh8K0wVqEgdVLzrPUAUiDA+5qwi/cRuqudbiqLYetuvbb
         Fi+3ByGLUDREmR8VJNVXCKTL2eBZsCaNaXi3Ps9zPen27O/vGN9Z2Nvsmv5MXy71RK5D
         ufpvvpdkafwh+GCUK5LVcVVntByXkRRnT7WVR0g6IycVSJ6+0SOWOIgI4n8ETQbxhaoQ
         MCFQem6jlob442JYgNF0onekGGFK33+Af7CzHokxcNX9UBm9aQFBNPRjjuw8ouf9mX4r
         ODuw==
X-Forwarded-Encrypted: i=1; AJvYcCXnP6riKMtRONNmg3q5nzC/F4LCOVMhIDtf3SSSF1ZCo5isJiAU0zNwGg0OC4NBelvUKdJoF7naQLlDV11Q@vger.kernel.org, AJvYcCXwukdGcHhWZJqjMEh4BokJZ30MwwXLYxCE7M/lfNtZFFJCwvlrYUyFcR2lLC16xgQvvhkourMl3G9GgyzV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6yR/9F4BJsMF5TAF+kYfCQuGIVgMHGAEJJCNdWXpLUCGtuOt
	Q7ACtoM3dvL36XWl4Dqs3QMAYMhKXaT+QR2Z+2NaMT8YgzV9l2qo
X-Gm-Gg: ASbGnctMG7+6lZYzROlCEBB34BzLu7I5zQPmEmfQW6v9/+JJ5ISm5i26TlH/T0fIhxW
	oq4dTZh/HjsJMg5fUfarZ0DV0ZIvzizNTxYLCBIc3uyIZbO3ZxHPwivj48Q//eE8KejbYbVU9RN
	SKNlL9nbUjmfG48k2FZS9wLwR1GPsyW0/DQj1UKSLoECqZHGoE2Jhhmik7XdEktdzoUt0UVUNgO
	fiutaN077XJxnQ3+chMOhlC+MArExA6K0h4sIN+6jE66tzSK6Y69nCxUa6G
X-Google-Smtp-Source: AGHT+IEo+659fUpkUFFkpxGn3gIqjDDx/wXNSC5AVajmYgifn/7dCNbegBe0YK6GdEfvUasEaSSYhA==
X-Received: by 2002:a17:907:6eab:b0:a9a:3e33:8d9e with SMTP id a640c23a62f3a-aa5f7dab9d4mr596771966b.28.1733300852808;
        Wed, 04 Dec 2024 00:27:32 -0800 (PST)
Received: from f (cst-prg-22-5.cust.vodafone.cz. [46.135.22.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6f99sm704374666b.131.2024.12.04.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:27:32 -0800 (PST)
Date: Wed, 4 Dec 2024 09:27:22 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, xujianhao01@gmail.com
Subject: Re: [QUESTION] inconsistent use of smp_mb()
Message-ID: <ulg54pf2qnlzqfj247fypypzun2yvwepqrcwaqzlr6sn3ukuab@rov7btfppktc>
References: <20241204064818.2760263-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204064818.2760263-1-zilin@seu.edu.cn>

On Wed, Dec 04, 2024 at 06:48:18AM +0000, Zilin Guan wrote:
> Hello,
> 
> I have a question regarding the use of smp_rmb() to enforce 
> memory ordering in two related functions.
> 
> In the function netfs_unbuffered_write_iter_locked() from the file 
> fs/netfs/direct_write.c, smp_rmb() is explicitly used after the 
> wait_on_bit() call to ensure that the error and transferred fields are 
> read in the correct order following the NETFS_RREQ_IN_PROGRESS flag:
> 
> 105	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
> 106		    TASK_UNINTERRUPTIBLE);
> 107	smp_rmb(); /* Read error/transferred after RIP flag */
> 108	ret = wreq->error;
> 109	if (ret == 0) {
> 110		ret = wreq->transferred;
> 111		iocb->ki_pos += ret;
> 112	}
> 
> However, in the function netfs_end_writethrough() from the file 
> fs/netfs/write_issue.c, there is no such use of smp_rmb() after 
> the corresponding wait_on_bit() call, despite accessing the same filed 
> of wreq->error and relying on the same NETFS_RREQ_IN_PROGRESS flag:
> 
> 681	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS, 
> 		    TASK_UNINTERRUPTIBLE);
> 682	ret = wreq->error;
> 
> My question is why does the first function require a CPU memory barrier 
> smp_rmb() to enforce ordering, whereas the second function does not?

The fence is redundant.

Per the comment in wait_on_bit:
 * Returned value will be zero if the bit was cleared in which case the
 * call has ACQUIRE semantics, or %-EINTR if the process received a
 * signal and the mode permitted wake up on that signal.

Since both sites pass TASK_UNINTERRUPTIBLE this will only ever return
after the bit is sorted out, already providing the needed fence.

