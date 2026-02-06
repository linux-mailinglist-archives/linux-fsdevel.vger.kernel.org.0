Return-Path: <linux-fsdevel+bounces-76654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YSD6Ey95hml+NwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 00:28:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDAD104231
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AAA93046AB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74E311956;
	Fri,  6 Feb 2026 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lojftZ5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE91096F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420518; cv=none; b=S/pt5g6WQtQ4d7Fn5dqKFzUgNkXAS9F+358NMfye2VHLLWxwm5aWXyxN2iPmWk9YzAy7QX9QsK1T38GhJzPNXEKbpVXs/jRe0OQN2gs7+3ng2q0w+Nr74ERWVK+11W22LlN5wzurI6Ig/XBFsFJ8IVb5ydrwN5XAzPktIcGGThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420518; c=relaxed/simple;
	bh=iza11KscdRHOTuvDe3hMGkfU3X17vHiGzjO5FKQD14g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if43mo9lCoMTQOtvSpMC+e+e9LW7Yz8AJtGTqHD+4pTJYJhNg4jANuzajgx61CA6w2MqXShK/stfZmK3quZH9sJVXtRlWMu3EZE4AH0Fp0YtntKWJRIxh6yIiPgJWKGNbibeBcD+fmL4fFmhTy4QwemEM7tCOs6cjAFbVCMpNcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lojftZ5m; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1770420516;
	bh=5+q2ZVcAz7bB71SNxE1U3HEq9dQbnKL+GOuYh5D2Ugo=;
	h=From:Subject:Date:Message-ID;
	b=lojftZ5mXw8MYIeFje/RCMVBsBksBwh9EFVf2KsbY7ysZKpspKPJE0DeHoWFSgeJa
	 E80uGfy2TP6RswBl00mWFpViLbZ6MoK9tcYBya75ksta+mcqxQupxQJTBl2EXkatGK
	 MGj5qJBMkQWR2PL5QYyF2is3xU+pdtvINnEEQusU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 6986791A000015B1; Fri, 7 Feb 2026 07:28:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5619754456882
X-SMAIL-UIID: 5FFF89B0442249D792C553FA56B5A095-20260207-072827-1
From: Hillf Danton <hdanton@sina.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: lsf-pc@lists.linux-foundation.org,
	Viacheslav Dubeyko <vdubeyko@redhat.com>,
	linux-mm@kvack.org,
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
Date: Sat,  7 Feb 2026 07:28:11 +0800
Message-ID: <20260206232817.2596-1-hdanton@sina.com>
In-Reply-To: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76654-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sina.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:mid,sina.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFDAD104231
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 19:38:28 +0000 Viacheslav Dubeyko wrote:
> Hello,
> 
> Machine Learning (ML) is approach/area of learning from data,
> finding patterns, and making predictions without implementing algorithms
> by developers. The number of areas of ML applications is growing
> with every day. Generally speaking, ML can introduce a self-evolving and
> self-learning capability in Linux kernel. There are already research works
> and industry efforts to employ ML approaches for configuration and
> optimization the Linux kernel. However, introduction of ML approaches
> in Linux kernel is not so simple and straightforward way. There are multiple
> problems and unanswered questions on this road. First of all, any ML model
> requires the floating-point operations (FPU) for running. But there is
> no direct use of FPUs in kernel space. Also, ML model requires training phase
> that can be a reason of significant performance degradation of Linux kernel.
> Even inference phase could be problematic from the performance point of view
> on kernel side. The using of ML approaches in Linux kernel is inevitable step.
> But, how can we use ML approaches in Linux kernel? Which infrastructure
> do we need to adopt ML models in Linux kernel?
>
Given the short list, eevdf, slab, ext4, IP stack, usb bus and kvm, ML is not
needed before the second half in 2027, because it wastes minutes to make
either liver or pancreas intelligent. By intelligent I mean liver can edit
ppt in Russian. Perhaps Cerebellum is an exception.

Can you build bot to fix syzbot reports before 2028?

