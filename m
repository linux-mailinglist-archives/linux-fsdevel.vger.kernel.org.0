Return-Path: <linux-fsdevel+bounces-67669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2EBC4615D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E0A3A78EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29868306D48;
	Mon, 10 Nov 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTcqSOx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A447305E08
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772303; cv=none; b=GOSDs441d9qzlaVydJMWw/LGUqJibO4jpKFJzJH2jtmQqHuHqD4/XR95zLk0mEYFvgF1y3hgt9p0zB+vYanibsguXzmyFRLMWgyPHcsVt/SsAZqtwcz3DkA6MeH+4eJHJbewJ75oNjYykQBBfa4lZsVZnhzc8tkMea88R/uLDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772303; c=relaxed/simple;
	bh=2U4KaUAelMziEmY2ShfzM/dox45MOEZL+6xWWn9Wxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVP/pTwZpUHlaks5InS/vl6BO82eWMldepd5hawzuyHfvO6yxBP0rNOzoh/JuK53EglAiRgkGIoyDO8TIYte83yH9rf0lHLj5jEpBE/y8DL2nzNXV/xSKcA+VBKP9HPD13JQUp8pzkEp2ybJzYVCnqsRb7KxbZ4F112dPEm3KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTcqSOx7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a49389deeso20242721fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 02:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762772300; x=1763377100; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQtUBYgJJUDzd/kGspKY/MZmhkbZxSeoEQPwDEqgRs=;
        b=NTcqSOx7ig9H2EIc158DWbLgS07sNYRKpJfCyIdI4ilhKtbi3USxe7AusiqhwLy/lz
         s9IoLfSktAalSXpMeDil/3umKjgSx13p66KaU6kMidfBkpF0Tpdy6Q3WN5/H0ZWcqBpj
         eV7okqZsfqxG3qI5031IOur+LbphMQzKbw3I4SwwT8rPmMdWiu5yxZxmbM2RtZ24ljY6
         pLerxSAmTuKINtn8SY7iOWpOFoABU8ZJs4FPJL8xE/fS1kj5UWZjHdqZmj4tMotWe/5T
         PM3FzRxkGiHp1ucmmNV7VoJ+OqqFZ48eFc7c+ZYzM5T95gJdzL779itiMaCqaMlnVu+5
         BW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772300; x=1763377100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cQtUBYgJJUDzd/kGspKY/MZmhkbZxSeoEQPwDEqgRs=;
        b=VnybhOlt94/UXe3QgJZcNrlX5YY3QYB8t+d6t+JoEdNx0sbq/GwwnIepwWajVKTWbh
         glh5jgaiqTKpVg8YM+F39ejjEORcjabQ54XWQ3VvGzc+CZJ8jNSCOoXtMhpVHlrOq0mn
         fq9/+Km0UJTyzNWj6ouHCYcNdvvJpVEBo55f09NUUQNZlv15c9fK7DRSLTwTRkmwwHjt
         pjg6LUWsvacBAKnorR5J+nBGYzorqje0LwAUQSmWBBgt8DT7zVkX7eOnS8PS2cf56j0A
         JMgzULVpzEV+YPz81X3bJ3hxmq2GYpPY8KCU/i+jZHqzamF7xRPHLd/uHqMM4jVtJrMh
         CS5w==
X-Gm-Message-State: AOJu0YzakoQeg7NDTlpDGiQxNMUqVE/rpGLBTLoJGF57CE3I2x06Urx0
	fwmDQRKhoPz+Vk1iAjpq03yzdifoO/tvW3ydRBaf9t0+KjiIvi88NYai
X-Gm-Gg: ASbGncu9sjQT2Hb20E6r+LjMnt4DNVbvx//mp2l2UaJ2kIc3i6m0PwdGx2q+DxLebm2
	tDj8tUQ/HbZz8IUHyWNNsdJW7PKie2MOX9jPHSgSMJFwb/2RZ6HKFwE+LyS4dL8Cyu99JOZeHdT
	j9paxqu0saqROVnRtOZMRubc/TknoPDU2KvVJlsSMZUp+dN8yQ0Ur/NFeGmwBP8FznG93XIWzmj
	XNCSQqUa6qDZIU/IS5RvRNBmZR4baYd48ADIei9c4bwt85soNvXnmf4RDQxdyHbnLGIrJLmf6cW
	oNVpzdQ/oEERENpDxIbtlhlXDDd/3EHDEbR5lp8N8f/BPdUnPZlvILqr+02PizMNEzC4ajio29N
	SKcowXqAVQMWfgt8M+bLLk3qPZUEEDJubJGajNABFq5YDcVC8iQZxn8yn4Ni9isZnJrjtum8ZcY
	shFw0IVkTSiXxe
X-Google-Smtp-Source: AGHT+IF7uc05YKR1RuoI0CoWlX07D9z81TzLgbg2o88xiS2GWX+oFbp3ZEM1dvWDPFPIbk1p56pL9Q==
X-Received: by 2002:a2e:7206:0:b0:378:df5b:fbac with SMTP id 38308e7fff4ca-37a7b30c374mr15069891fa.38.1762772299942;
        Mon, 10 Nov 2025 02:58:19 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0ee40csm34451431fa.43.2025.11.10.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:58:19 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 691DA5A0033; Mon, 10 Nov 2025 13:58:18 +0300 (MSK)
Date: Mon, 10 Nov 2025 13:58:18 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRHFSrTxYSOkFic7@grain>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <aRDMNWx-69fL_gf-@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDMNWx-69fL_gf-@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Sun, Nov 09, 2025 at 06:15:33PM +0100, Oleg Nesterov wrote:
..
> static int kill_sub_threads(struct task_struct *tsk)
> {
>  	struct signal_struct *sig = tsk->signal;
> 	int err = -EINTR;
> 
> 	read_lock(&tasklist_lock);
> 	spin_lock_irq(&tsk->sighand->siglock);
> 	if (!((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task)) {
> 		sig->group_exec_task = tsk;
> 		sig->notify_count = -zap_other_threads(tsk);

Hi Oleg! I somehow manage to miss a moment -- why negative result here?

> 		err = 0;
> 	}
> 	spin_unlock_irq(&tsk->sighand->siglock);
> 	read_unlock(&tasklist_lock);
> 
> 	return err;
> }

p.s. i've dropped long CC but left ML intact)

	Cyrill

