Return-Path: <linux-fsdevel+bounces-29707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A897C94E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F581F23B9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7019DF4B;
	Thu, 19 Sep 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3mQpnlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A219D894
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749409; cv=none; b=T3oowLHGZamHcLGcvZkOUApR4hsZN2JXJllEYX1yEqkPJ/SRblL09qaXbI06GkGGl1g6uSSU4M2EgJBdmx609QPm4JK0wz5D5OC81NI0co+b4cZ4FMkKCW8WYHocfRKdgh4ko9mL1efs+7S3EBoYx5cL6nIu/lp7VX7Meb+qdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749409; c=relaxed/simple;
	bh=I32E8pYQ0rfeWgsg9XefZezWxlj4OBRnTN/JIdQ4QSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/szADHnnggjEmcltSI+KihbBOaM6OcBIBumP1FORGNR5tHIC/wE3ZuAOue7yj6Rm8DVWLu6it3/GQ0aZbtk9leVnaTUrNDQHO6y1ktwturvMl1WqvIAZ8+wNhIMdgCK/Z9BuMCye+Uzk748rlvUbLlxbr9ws0Mz7hOOk2UoJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3mQpnlR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a74f824f9so1492534276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726749407; x=1727354207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzaj+6YGcmRSff/H/YAZ07htkUtQu64GS68v/+lW6g0=;
        b=E3mQpnlR4r3g/SvRk6Ys3g2WHVR9COJ6CByq3gsfrVSU9bFpjvwjoKdhhjsu4itczE
         wHedIVETzvsDatwkDzth3Sf2l6GvCn0K9L6V57R3yGyvkPEndI2i+CIAqvucO+HmmKrp
         9Zzi1sac42mgRB0wOb0Chy9/3/LD8nPEpcoKJGlPhlUWJOyCEBTPpJNxkIlezfaXW73F
         +h9Tg35CXUL74xszhE0X/u3H39lUIuoLkgnfzIpbuXMUQDPbS3Rte8YHkINjgCesQQJX
         2Mgc8/+5gH590HkTd9CwKLoTxH9pbePZ8n5MVAKKMFeJhluKn8Cj0RL7eW3axkpLhZep
         kZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726749407; x=1727354207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzaj+6YGcmRSff/H/YAZ07htkUtQu64GS68v/+lW6g0=;
        b=AtxP1hA9UtO8/KHQkWT4TgrNKlkO/RLQWFHf5D2fauPTmKxbGE1P37GAtCqRXYmpNO
         LxoOl+DQIprv3I7KVQ2fVwovpvXSpDwQvzseyhzXd6guDbLB2k6mVrlNj39rCDk03zz4
         anujEvsd59qe1PXZ/tgZdY6rf1ptT5NvTToCRm5hpdTMngwa2FZHL/k3YOmtKmtVKEJ8
         +EtNw/gB/BuOcfEvegKFcZkglpK1uSq7Fus5pnhmuuqW9ml3d6M8zPgUNBzJzLvJDgTz
         9zAT0lX2gp+Lvd1kzO3VfRiUeOkb/Blxgk//QwBwZ1EHpkku6rXHj9z/V8dRxD3T86cK
         u15g==
X-Forwarded-Encrypted: i=1; AJvYcCVcR26FgOmemtde1Wcv0VHp+AdZ0u2kI4IFw+V6QCHHmo52nxTmgYbmoMQ/8FEJ/Wj5tyHZ3MnXJUY08DNS@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8ZQYo10LO+6ao+zuQmrD2X0f0ojqqsyS4gW7EB3F4NuAy0vL
	gsWfoNKs8iiQsi7qOJrIjTASAkrG3HxR2Bl8dA8DJGSbvBnKXkTMZjxRl1C1nUB1bafqTf5aUAy
	1Fu3qzw==
X-Google-Smtp-Source: AGHT+IEA40YdHj4gpye91yNHURgx0FJvF7H/BpoJ6+xQTdlg5edN+y+6vJInbKIAEeqzvlJ6CwAi3KfYWklw
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a25:d884:0:b0:e02:c06f:1db8 with SMTP id
 3f1490d57ef6-e1d9dba6fcamr31379276.4.1726749406694; Thu, 19 Sep 2024 05:36:46
 -0700 (PDT)
Date: Thu, 19 Sep 2024 08:36:35 -0400
In-Reply-To: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240919123635.2472105-1-bgeffon@google.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
From: Brian Geffon <bgeffon@google.com>
To: brauner@kernel.org
Cc: bristot@redhat.com, bsegall@google.com, cmllamas@google.com, 
	dietmar.eggemann@arm.com, ebiggers@kernel.org, jack@suse.cz, 
	jing.xia@unisoc.com, juri.lelli@redhat.com, ke.wang@unisoc.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	xuewen.yan94@gmail.com, xuewen.yan@unisoc.com, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

We've also observed this issue on ChromeOS, it seems like it might long-standing epoll bug as it diverges from the behavior of poll. Any chance a maintainer can take a look?

Thanks
Brian

On Fri, Apr 26, 2024 at 04:05:48PM +0800, Xuewen Yan wrote:
> Now, the epoll only use wake_up() interface to wake up task.
> However, sometimes, there are epoll users which want to use
> the synchronous wakeup flag to hint the scheduler, such as
> Android binder driver.
> So add a wake_up_sync() define, and use the wake_up_sync()
> when the sync is true in ep_poll_callback().
> 
> Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  fs/eventpoll.c       | 5 ++++-
>  include/linux/wait.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 882b89edc52a..9b815e0a1ac5 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  				break;
>  			}
>  		}
> -		wake_up(&ep->wq);
> +		if (sync)
> +			wake_up_sync(&ep->wq);
> +		else
> +			wake_up(&ep->wq);
>  	}
>  	if (waitqueue_active(&ep->poll_wait))
>  		pwake++;
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 8aa3372f21a0..2b322a9b88a2 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
>  #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
>  #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
>  #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
> +#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
>  
>  #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
>  #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
> -- 
> 2.25.1
> 


