Return-Path: <linux-fsdevel+bounces-76842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Iz2BXc3i2neRgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:49:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE111B68C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D58A3055DCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0927FB2D;
	Tue, 10 Feb 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e8Klf4H3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z1Zo/KBR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e8Klf4H3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z1Zo/KBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8EC27B335
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731260; cv=none; b=RvlyjC8I3mHilLiVIokH6PtB526MSKGTgazv60CA5NbuiIQxuELVgtpJUl9iFkJUbMITXVyU66xdjgIpsP/aF3AoaKkZ737HL4nIBrTOkeNfjih7KuAuj86p2ObexD6ZZ1QMQu+Jlj5c6piogC5miS6k3hAEp9C40FyX/ReE/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731260; c=relaxed/simple;
	bh=0THwwROVL+fP4Kuci6TK/6lUhruDSaWkWEreHr5XB0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBXfi+FygONm+DQXEfwZtE1XXOxWKPTb3ibN2NxUu2GUKlzw5QIBk7SHqzdCNDigqRw28k+XN2uvdo7y84GrJH6glTX/ePqd/6R/cfRVvio9P9bc1/57lZ5z7Ca//JKvoygb8N7VxOkhKk8C1ug5kRMPKzvfQ2ql4lmmcRVgQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e8Klf4H3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z1Zo/KBR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e8Klf4H3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z1Zo/KBR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 105A83E71A;
	Tue, 10 Feb 2026 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770731257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YjEW9rY5f+WC+e8I8HcxIvHHp40YBO+UXznndHs1FM=;
	b=e8Klf4H3Wf0REiYrsJ5KDGCefLcZmtsIzkYRYYqlLIPOY5fdMzBQ4u0hPQoEz5wqWsNDKB
	JQYLJqvoaXBHdzoVftKo4DT/1c+WKqX/E7bx+3nC2rZu2WGgLgYmNUD4emRew1GXsYShW7
	aM7zs4M8etINl62m0PYPBjiCP8Eq5AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770731257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YjEW9rY5f+WC+e8I8HcxIvHHp40YBO+UXznndHs1FM=;
	b=z1Zo/KBRSYTQoiDNeqx4bYHpRLjWuIoYwPJ4+iFO4jOOnF8jTMIuUv26I49Su4DfEVKwHl
	s5yKw1c3fiLjWAAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e8Klf4H3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z1Zo/KBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770731257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YjEW9rY5f+WC+e8I8HcxIvHHp40YBO+UXznndHs1FM=;
	b=e8Klf4H3Wf0REiYrsJ5KDGCefLcZmtsIzkYRYYqlLIPOY5fdMzBQ4u0hPQoEz5wqWsNDKB
	JQYLJqvoaXBHdzoVftKo4DT/1c+WKqX/E7bx+3nC2rZu2WGgLgYmNUD4emRew1GXsYShW7
	aM7zs4M8etINl62m0PYPBjiCP8Eq5AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770731257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YjEW9rY5f+WC+e8I8HcxIvHHp40YBO+UXznndHs1FM=;
	b=z1Zo/KBRSYTQoiDNeqx4bYHpRLjWuIoYwPJ4+iFO4jOOnF8jTMIuUv26I49Su4DfEVKwHl
	s5yKw1c3fiLjWAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC4DF3EA62;
	Tue, 10 Feb 2026 13:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nAesOfg2i2kZZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Feb 2026 13:47:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6F82A0A4E; Tue, 10 Feb 2026 14:47:28 +0100 (CET)
Date: Tue, 10 Feb 2026 14:47:28 +0100
From: Jan Kara <jack@suse.cz>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "chrisl@kernel.org" <chrisl@kernel.org>, "clm@meta.com" <clm@meta.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
Message-ID: <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
 <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76842-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,proofpoint.com:url,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91DE111B68C
X-Rspamd-Action: no action

On Mon 09-02-26 22:28:59, Viacheslav Dubeyko via Lsf-pc wrote:
> On Mon, 2026-02-09 at 02:03 -0800, Chris Li wrote:
> > On Fri, Feb 6, 2026 at 11:38 AM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > > 
> > > Hello,
> > > 
> > > Machine Learning (ML) is approach/area of learning from data,
> > > finding patterns, and making predictions without implementing algorithms
> > > by developers. The number of areas of ML applications is growing
> > > with every day. Generally speaking, ML can introduce a self-evolving and
> > > self-learning capability in Linux kernel. There are already research works
> > > and industry efforts to employ ML approaches for configuration and
> > > optimization the Linux kernel. However, introduction of ML approaches
> > > in Linux kernel is not so simple and straightforward way. There are multiple
> > > problems and unanswered questions on this road. First of all, any ML model
> > > requires the floating-point operations (FPU) for running. But there is
> > > no direct use of FPUs in kernel space. Also, ML model requires training phase
> > > that can be a reason of significant performance degradation of Linux kernel.
> > > Even inference phase could be problematic from the performance point of view
> > > on kernel side. The using of ML approaches in Linux kernel is inevitable step.
> > > But, how can we use ML approaches in Linux kernel? Which infrastructure
> > > do we need to adopt ML models in Linux kernel?
> > 
> > I think there are two different things, I think you want the latter
> > but I am not sure
> > 
> > 1) using ML model to help kernel development, code reviews, generate
> > patches by descriptions etc. For example, Chris Mason has a kernel
> > review repo on github and he is sharing his review finding the mailing
> > list:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_masoncl_review-2Dprompts_tree_main&d=DwIFaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=vvrDPxyw_JXPrkC8BjzA2kEtwdPfwV2gBMEXG7ZveXM4LhS01LfoGwqhEyUZpPe4&s=rqNez5_rmiEuE7in5e_7MfyUzzqzaA6Gk46WWvmN3yk&e= 
> > It is kernel development related, but the ML agent code is running in
> > the user space. The actual ML computation might run GPU/TPUs. That
> > does not seem to be what you have in mind.
> > 
> > 2) Run the ML model computation in the kernel space.
> > Can you clarify if this is what you have in mind? You mention kernel
> > FPU usage in the kernel for ML model. It is only relevant if you need
> > to run the FP in the kernel CPU instructions. Most ML computations are
> > not run in CPU instructions. They run on GPUs/TPUs. Why not keep the
> > ML program (PyTorch/agents) in the user space and pass the data to the
> > GPU/TPU driver to run? There will be some kernel instructure like
> > VFIO/IOMMU involved with the GPU/TPU driver. For the most part the
> > kernel is just facilitating the data passing to/from the GPU/TPU
> > driver then to the GPU/TPU hardware. The ML hardware is doing the
> > heavy lifting.
> 
> The idea is to have ML model running in user-space and kernel subsystem can
> interact with ML model in user-space. As the next step, I am considering two
> real-life use-cases: (1) GC subsystem of LFS file system, (2) ML-based DAMON
> approach. So, for example, GC can be represented by ML model in user-space. GC
> can request data (segments state) from kernel-space and ML model in user-space
> can do training or/and inference. As a result, ML model in user-space can select
> victim segments and instruct kernel-space logic of moving valid data from victim
> segment(s) into clean/current one(s). 

To be honest I'm skeptical about how generic this can be. Essentially
you're describing a generic interface to offload arbitrary kernel decision
to userspace. ML is a userspace bussiness here and not really relevant for
the concept AFAICT. And we already have several ways of kernel asking
userspace to do something for it and unless it is very restricted and well
defined it is rather painful, prone to deadlocks, security issues etc.

So by all means if you want to do GC decisions for your filesystem in
userspace by ML, be my guest, it does make some sense although I'd be wary
of issues where we need to writeback dirty pages to free memory which may
now depend on your userspace helper to make a decision which may need the
memory to do the decision... But I don't see why you need all the ML fluff
around it when it seems like just another way to call userspace helper and
why some of the existing methods would not suffice.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

