Return-Path: <linux-fsdevel+bounces-41619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC9A332D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63B63A4B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 22:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE6214204;
	Wed, 12 Feb 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LUNIucAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2BB2054E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400319; cv=none; b=iYaR8eHVAg8r8kEcBeeL0uySqlQMfUpjVp0/a+3qjVFKoezDrd3c1sq0xMeKTRKKDP/q5iYyUxTP3msRxvPadc0opftEHxtIyA7KqL6l1ycC2ZkCqmc42rtJrV/4tItUX/2u4sBdcIq6kxtH2uFnFP8v/fTFwd/+SVg54aMtWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400319; c=relaxed/simple;
	bh=TrYhj9YtDhjs2+zWIm8UW+a8Ijj+74m1trvWbyQOCSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKq3Cw7Yai7jk2U2SmQOWhEiSpJ0o7UNoiYWADQE7aHVBpdfDFOvP+kfEiMv329zQdl3pDzS73onnPOzi7AQCbVLSoPc7/Y+mqaZ7tIZIKs1HGoKJDZLFpTsWBUYS+FAjdLn5o0N3oS/G/FrlzEvCRSimOkm58FvCGgz86+dnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LUNIucAr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ca204d04so2717975ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739400317; x=1740005117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxmsI4n3mNC29jNhrwky8mt9Y2e3VkJ4dixbH6NADTc=;
        b=LUNIucArorYsj2QN+oCyqiEc2Od7dBSV+ZjPnevnjEjxbZhfKGMumO2ZzVzkBwu/Ey
         2lInL35zv8oPciwRZn/7czzNrsBg+nlUyMwCvc8zzgRTmklGBobSmcg3iOYgZdCCf16p
         1F3mY7XrLro9P7leQ6T6w4g4vxBH8hqzj8j+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400317; x=1740005117;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxmsI4n3mNC29jNhrwky8mt9Y2e3VkJ4dixbH6NADTc=;
        b=lrAqNv0bZr1DRC2zdwr4EU9beM2k/bj7sXNqhOHl6Q4HHbe6RoD9VrmF7MRESHydNN
         lTnfFliIcopD50H27El3U+GtPor6P1jj+wLox2Smc22hCbUKko0fhicjjrNTUeep3UJj
         YE2xMAtvunGf4PnIcxGjND8N+vXzzXD5OXayROhGfueXYmskLgdGfzPKoelJcth91uiQ
         gxSqabb9slgG4I3ZwjsTu+RKbf/Gs9EtV/rkC7HrY4RBfYLj3Jsjyc2gci1qf2trzsb7
         eqtMVOzPbcuIHlQHVruHjAkNFBvfZUUSZrw0JnUVMFZqhjaPwgKDuuNA9hgnL2ndlFb0
         jrWg==
X-Forwarded-Encrypted: i=1; AJvYcCVoIloCrnqAZ/sFqHPflibabduYtvFzuJ9t4UHjGo9OQoHOU7cT0ubuj9KXu+UWk91AJQntxRfWIsa2lmqL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3S6wh9vsB0iiVCCMrBBVhbA744m1uKiyl2uTHKlGZvG5MtHAn
	r6uxZKQAFQjs63eipsQKnqam4kB2VzMiY6f8+rE8gspRNMLDVN7/ksPI5ICEoNQ=
X-Gm-Gg: ASbGncsBjQLu9Pz33Ysu/hZld9d/Ngg/M0AWzSFJOVUiTKZGXt/iIBF6GpinC2dlkVd
	e0iu6VKURK9R5JlDsnO0QSqOg3fatGrfVnhXgWegdmtl1fIy8AT1BNpR8gzrSqbXehI4Gn2D5tK
	kUaHxHUFjSo5Ae/1+XTEq3WKXEjmYqHLDb1LcZwhQBkK/hQkD/7J7dwJwJTYGDBuL7FyaS8ghJQ
	R66/lX2eSt6gc/iKIOoOk8wWiMS/vIczlL/Z5UtsozSxVn7fjWPzWMmDWPQHtNt++lTY3ZXJgKt
	5fQhoyWC/d1EhK9Pl2RzvDnxkgkf1fqSKWoXZIJNt3Yt2vUaX6zQQjvOgA==
X-Google-Smtp-Source: AGHT+IFUBiyhDYvXIFj3i8/1IXRfWTJGO1CJwO79pTr/N2oVci7/x1idO4rC9J9iW9gid4RM7SPniA==
X-Received: by 2002:a17:902:f682:b0:220:cab1:810e with SMTP id d9443c01a7336-220cab18355mr25527595ad.6.1739400316978;
        Wed, 12 Feb 2025 14:45:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm541515ad.223.2025.02.12.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:45:16 -0800 (PST)
Date: Wed, 12 Feb 2025 14:45:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stefano Jordhani <sjordhani@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: use napi_id_valid helper
Message-ID: <Z60keJDOL_50cGbY@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stefano Jordhani <sjordhani@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
References: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>

On Wed, Feb 12, 2025 at 04:15:05PM -0500, Stefano Jordhani wrote:
> In commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present"),
> napi_id_valid function was added. Use the helper to refactor open-coded
> checks in the source.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Stefano Jordhani <sjordhani@gmail.com>
> ---
>  fs/eventpoll.c            | 8 ++++----
>  include/net/busy_poll.h   | 4 ++--
>  io_uring/napi.c           | 4 ++--
>  net/core/dev.c            | 6 +++---
>  net/core/netdev-genl.c    | 2 +-
>  net/core/page_pool_user.c | 2 +-
>  net/core/sock.c           | 2 +-
>  net/xdp/xsk.c             | 2 +-
>  8 files changed, 15 insertions(+), 15 deletions(-)

Thanks for the cleanup. As far as I can tell, LGTM.

Reviewed-by: Joe Damato <jdamato@fastly.com>

