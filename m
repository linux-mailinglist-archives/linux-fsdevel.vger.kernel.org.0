Return-Path: <linux-fsdevel+bounces-7127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE7E821F31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0FD2837F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FE14F69;
	Tue,  2 Jan 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXCRF1Z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D714F62
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Jan 2024 11:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704211562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfBSIcri6gvRT1pMgWG+pIwCoQ0ekq61NfBifzBCZVU=;
	b=vXCRF1Z/FWzUW4N5OGNmiHEKvwZyzdT3+1J8P3ZO6hx43S12CDxCrbMOYp3+WrmeobPtT7
	XExCwT7RZ3mdBrIebl5SwCUCpLGollYRHMgxXayWXgCKsr4APLunvwl638XQvLcp5GA48S
	JxZNtGq0LHmop6gjeCjtxTFNMSL8Wqw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <mpvktfgmdhcjohcwg24ssxli3nrv2nu6ev6hyvszabyik2oiam@axba2nsiovyx>
References: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
 <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 02, 2024 at 11:02:59AM +0300, Viacheslav Dubeyko wrote:
> 
> 
> > On Jan 2, 2024, at 1:56 AM, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > LSF topic: bcachefs status & roadmap
> > 
> 
> <skipped>
> 
> > 
> > A delayed allocation for btree nodes mode is coming, which is the main
> > piece needed for ZNS support
> > 
> 
> I could miss some emails. But have you shared the vision of ZNS support
> architecture for the case of bcachefs already? It will be interesting to hear
> the high-level concept.

There's not a whole lot to it. bcache/bcachefs allocation is already
bucket based, where the model is that we allocate a bucket, then write
to it sequentially and never overwrite until the whole bucket is reused.

The main exception has been btree nodes, which are log structured and
typically smaller than a bucket; that doesn't break the "no overwrites"
property ZNS wants, but it does mean writes within a bucket aren't
happening sequentially.

So I'm adding a mode where every time we do a btree node write we write
out the whole node to a new location, instead of appending at an
existing location. It won't be as efficient for random updates across a
large working set, but in practice that doesn't happen too much; average
btree write size has always been quite high on any filesystem I've
looked at.

Aside from that, it's mostly just plumbing and integration; bcachefs on
ZNS will work pretty much just the same as bcachefs on regular block devices.

