Return-Path: <linux-fsdevel+bounces-39302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26D2A12674
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB82162E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707498635E;
	Wed, 15 Jan 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="SfdfFSXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662624A7FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952487; cv=none; b=DUScyYXcsvOhiMoswrMO1dr0gomHLPqlNtANHVfwSox1FoiCtl47OI4hDihQq6Dz1bIxHmFovya+f2XOJ7948I3qUNdFSERvAByrbvC2T5Iv+eHzAmiW4UBE4O/Wpe6YNDEP3YlKMV9ZsGan7AFELYQuUIxKjxyK2lUi0BdA1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952487; c=relaxed/simple;
	bh=rbMytknc3TiRLkmbEfTXok3cGmZUKWcYKEuelb56Dt0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=m5DBuB07q8qdFc3qMlbMnArJmIXeC2qq3gVN56Bi+QraaeHzYhgJ0VPgeKqGItin6WxYUIlQTsLSocmVOYPa+bcToTIM6lG3wtXP62QnRUYa2DTSkOnIUD/BUd4V3/emjWgg958W5e5CE+UNbwiBhZ1rQ9n6zTkTt54k60es9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=SfdfFSXk; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <ea554f398a1d263ea06c02c8601cbb1b@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1736952482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbMytknc3TiRLkmbEfTXok3cGmZUKWcYKEuelb56Dt0=;
	b=SfdfFSXkrhveSJn4zx9uJx1EkyGBCUYeCsZuRoKnSRel4TT1PocIdDtsBInvJd6O4gzgMr
	B1M+nTAyy8QlAgQEHPSUR3szQhrmIL5aCd7r6oDkV1RAIECrC8iTseKfxkhzAIr3ZqtoMM
	UPvEwTVrko/hGqyNR2Q27pyZg31wHCuunSl3S9yCfdi5oWaqtlLJCFK0nzn0kTNmYl4nSe
	6O0ed8V+wXOKIG+oEnqIM32Kt7qNXNAqW5HT0WmnPOgaoUNtrrY35utUVx6evTz1ZQ6heX
	n8RLAYtgaQd2e5Pt10kCl2JNx9loesn0SL60MJUjwwTex0uyV1A2M5vmEDQfwQ==
From: Paulo Alcantara <pc@manguebit.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, Amir Goldstein
 <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org,
 Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>,
 trondmy@kernel.org, Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
In-Reply-To: <CANT5p=r1t5hG9jQ8Py1VkvkNFxLJpGUXimxVBTR=ApqEFWL6hA@mail.gmail.com>
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
 <460E352E-DDFA-4259-A017-CAE51C78EDFC@redhat.com>
 <dbc41d4c3113c0e3a7915d463ddcb322@manguebit.com>
 <CANT5p=r1t5hG9jQ8Py1VkvkNFxLJpGUXimxVBTR=ApqEFWL6hA@mail.gmail.com>
Date: Wed, 15 Jan 2025 11:47:58 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shyam Prasad N <nspmangalore@gmail.com> writes:

> We load the dentry cache with results of QueryDirectory. But what I'm
> proposing here is a read ahead, even before the next readdir is done
> by the application. i.e. the idea is that the data necessary to emit
> dentries is already in the cache before it is even called. That should
> speed up the overall directory reads.

Thanks for the explanation.

We'd need to be careful as in CIFS we could end up with several
automounts (DFS links) by doing these readdirs in advance, especially on
slow connections and when failover happens when mounting them.

