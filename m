Return-Path: <linux-fsdevel+bounces-33121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0D9B4CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE63F1C22698
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EB192D91;
	Tue, 29 Oct 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MEL6gOA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91619258A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214206; cv=none; b=H65EPiIF2kCcLhNRJrx3HZUHRXRMkR5L1bvP8fydNW+62q7OHMJkEmiKXGEtWEO9ZZl75lVIuARS+cQBtRINjvArgewMUfzAReAEZ2WDaNXU3PFEU65GidMDIof8AtxHqYDx6B7BYDV1/BRxc1x35ZQl6qysvRVilfyvfwgoA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214206; c=relaxed/simple;
	bh=NBSC41srgKPt9bg/2Qz/7PgkEc3c+cfTUpjZyDXQUXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCMJU7Omv76kyYXWthRhHFmBvcTIyQdJoxPsIsx8SQH54RTpJZADf3NiMtyO2i4NI5oVsTeOsYSLEFfH8Ad/ySFeua9PpNPtGYCLSkHmq0zwDAi5zV4EkyCGXj9WzJsqPnUH8EDcToaqp+4rKNygPgI9z8CvY+9Mwj7wOVB/C3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MEL6gOA5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-208cf673b8dso52259165ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730214204; x=1730819004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agAKt0IT7G723lrXGrtqJgZBhbv7SHC0IN5lHsfmwYg=;
        b=MEL6gOA51kVLII2DrX5XlCZ45ift+ozAjPNP1QUrIAfg+Cscpr79lUtPOwcfK8UHZY
         bcFKwJf9zAK++TP9/IgY1eu1aBWMDsdxjChIfoIpGAJQXRcejE3eshWYuNORz/CfiWVo
         xdwLQiyGHL2X6Sa2uatbuFBEc7LE3UhOWf7+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214204; x=1730819004;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agAKt0IT7G723lrXGrtqJgZBhbv7SHC0IN5lHsfmwYg=;
        b=g+8EdN/JiokfzdeQG7Sx2R0kWmz1PKP2mEJYSd8VPVcV4HAIzBX9DslNgnL3GkqSvb
         iDBuYAGK7PZYGq7KELGNOArboofg8pz53XRONb167jAPCzGKxkt82ZQzbmHaTNpuvleG
         LjNPSSVddkErSo6q6whWB60MwNTqb4YmZcLCy8/ZMTZM5bdBSPypBqKT/hw+PjVX3lkH
         +4f38+qVs2HNSh01uyo8VRaUIv6jg+6JsLAWqJOBsT6/L/h2anP6MqFuxv9fb+DluY5o
         dVM1rt6NclfqGrn7SOIqsC9eX8PXYNNbeUUfiC6YklzqvbnSZ7hrgR9eQU5LfCnUxP8S
         IgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUgwLh/P2OjKbue+Ua3xj+tvHPtGbPbVFLx16WsgxUyNNfkKFUfr0OpwFGNn81iAP0WtEuxPX+boechOMC@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYY7TlMkvBch7dEUqUwASzrwokiB1xAPCZ7cTOZjCLkI40muz
	4117yBeNpVe9ik9SUNQDR3kDKgQ4MyZAKYpi+PqF3+HMYciZIIvSsM9Cn7S7lqs=
X-Google-Smtp-Source: AGHT+IFCKnHDgGtsA90IcNnhxnGU7fXTHsLH84y6r6k1evSEfeb5nttjlUCgjLc1TGCn9mq7Trci/w==
X-Received: by 2002:a17:902:7790:b0:20c:fb47:5c05 with SMTP id d9443c01a7336-210c6c6d996mr123687415ad.46.1730214202479;
        Tue, 29 Oct 2024 08:03:22 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02e941sm66967365ad.204.2024.10.29.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:03:22 -0700 (PDT)
Date: Tue, 29 Oct 2024 08:03:18 -0700
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 0/6] Suspend IRQs during application busy
 periods
Message-ID: <ZyD5Ntx_DwnQj47e@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
 <57a0e1e7-1079-4055-8072-d9105b70103f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a0e1e7-1079-4055-8072-d9105b70103f@redhat.com>

On Tue, Oct 29, 2024 at 11:25:18AM +0100, Paolo Abeni wrote:
> On 10/21/24 03:52, Joe Damato wrote:
> > Greetings:
> > 
> > Welcome to v2, see changelog below.

[...]

> 
> The changes makes sense to me, and I could not find any obvious issue in
> the patches.

Thanks for taking a look.
 
> I think this deserve some - even basic - self-tests coverage. Note that
> you can enable GRO on veth devices to make NAPI instances avail there.
>
> Possibly you could opt for a drivers/net defaulting to veth usage and
> allowing the user to select real H/W via env variables.

Could we send a selftest in a follow up?

I am asking because we've jumped through a number of hoops to get to
this point:
  1. Added support for per-NAPI config settings [1] to address Eric's
     concern in the v1, which took several revisions and was stalled
     due to a merge window.
  2. Added support for netdev-genl to numerous drivers so that this
     would be usable in many different environments (gve, ena, tg3,
     e1000, e1000e, igc...) [2] [3] [4] [5] [6]
  3. We didn't get any feedback about adding a selftest in the RFC
     or v1 [7].

I think all busy poll methods currently in the kernel need selftests
(including the existing busy poll method) and its not clear to me
currently how much work it'll be to get veth or netdevsim working to
a point where we could re-submit this with a selftest that would be
considered reasonable enough.

FWIW, neither my previous series on the epoll ioctl nor the per NAPI
settings were rejected due to lack of selftests, but I did add a
simple selftest for the epoll ioctl later [8].

What do you think?

Could we get this merged without having to get selftests working and
come back with a selftest as separate change (like I did for the
epoll ioctl) ?

[1]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/lkml/20240930210731.1629-1-jdamato@fastly.com/
[3]: https://lore.kernel.org/lkml/20241002001331.65444-1-jdamato@fastly.com/
[4]: https://lore.kernel.org/netdev/20241009175509.31753-1-jdamato@fastly.com/
[5]: https://lore.kernel.org/netdev/20240930171232.1668-1-jdamato@fastly.com/
[6]: https://lore.kernel.org/lkml/20241028195243.52488-1-jdamato@fastly.com/
[7]: https://lore.kernel.org/all/20240823173103.94978-1-jdamato@fastly.com/
[8]: https://lore.kernel.org/netdev/171528362770.20134.14528995105510778643.git-patchwork-notify@kernel.org/T/

