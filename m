Return-Path: <linux-fsdevel+bounces-57028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34659B1E081
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC780720BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44078F4C;
	Fri,  8 Aug 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="V9lVN2pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQ2qTFbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B07645
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619404; cv=none; b=kHHczTO7HjnyUH5hLox85nnkLEVKCYvwHyaxuiVkWB9ttqpTUUSg4/LdX9zm07lf3RxLxb33Xl4+EzKsCnSkYTip2Dvh60RoJhVHt7kBhoUkAAWxR/TzUvIUi9CepA8cqsJORlMRUgWymk72ouhR9lQ5EizUYYsbR5oK0gnwu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619404; c=relaxed/simple;
	bh=CXncHPZzpg8JyoDEAD72ZBy4uj3VY4VfvcJQurXoZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfVe2VZlpCOMMYTPhzXh7dDpNROm9cJIk8rfZdcRTe5vCrA64eJqj6sgv3amMvapr7DtWB2e0EAyd3aBANAsmcpelqlRvhqdwZmQYIdTIY/b4UTUkdLd4O45SVQKzvDL33RLARixZp5yBT5crbL+uhgrrp0xHS6dHhkIXayInGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=V9lVN2pr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQ2qTFbH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 39986EC00DD;
	Thu,  7 Aug 2025 22:16:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 22:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754619401;
	 x=1754705801; bh=NP+M/GMoJvPTmFsuK2bHezKUOJ84Zg13tsjPhI3w5FY=; b=
	V9lVN2prU8Ysza2WrZ6GkeMopm2BtD0U87fg/lix2Hf7lQWDKcC8yfjb4VWVilO2
	mgMOMsshOfP18dvtcX2O8bmiKWZHICPBoT13QA0l7cqVmngPwRlsVbfbLEdHCwFL
	w2McBxZY4JVFjd5dULoQA36E7Cy+hksgkLNeVNuDZa5uHcSYI8xTmL2kus14mif8
	CpMp9JCW2JweizF8B0AERTjGRfTGuIcK+KsspvKk5+GvcSsEBP1Jti0jmFYmu3nF
	aictlG3xmSzGSoruPzpG5qyrc3GTppOnrN3rXyYyUkwPN3Ay2aYQOvMGgUO+fsrX
	b6UthLk/FQn1hrZDFhGQ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754619401; x=1754705801; bh=NP+M/GMoJvPTmFsuK2bHezKUOJ84Zg13tsj
	PhI3w5FY=; b=GQ2qTFbHTrs5K14Sd5spQwizq5tbUMDaakf5XBF56iLb6ucx3Tf
	09dY0OnK6zFqCtuo89Glkw7CQI+3Up8WsG8sMvGvrz0XxFxBLD5TonhNVC9yrkQL
	7IuPuo03GvaxyURD9Ft8CjG3ef8yH3b2n4pyqrb5OLxj3qdoH/kckLw8RXnOdyMW
	iJjvr5GdNJWVncMH5zkPJO+BVCpSQwiDS3lO5qXgrJ9yjyFrD2b4iy05qHKAcBlw
	kiT1AI6rvSMhjSx9PdQQudj9XyygPJI9bhM5UrD1bBq/HWrwfJ5n+CX9UsBVuTfV
	ZR2PpZYTVHXVH7xeDsSeSxBOBAfEEf+5GWA==
X-ME-Sender: <xms:CF6VaGdLUj16SX1isxtsIebZaYdaqKVEyT4dY-bqsBCT2UhXTc9tdQ>
    <xme:CF6VaAabBRVZU96ne5rf-ggfC_y488FJbJM99-Uf37-_A15gd-nsJZwDa5pj16x72
    8vv8u2yTokaDNBNrX8>
X-ME-Received: <xmr:CF6VaJWuDEKYF-95zly9-SfkuGU8v2WVNLHRRK2v82OyarniNfqkv-wjkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhht
    rhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepudeigeehieejuedvtedufe
    evtdejfeegueefgffhkefgleefteetledvtdfftefgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtth
    drohhrghdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptgihphhhrghrsegthihphhgrrhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CF6VaCixYpU7p4Hgr_4Pd0_Y9QnHw5vZsoHg3Nznibk4C0hy3OW1Dw>
    <xmx:CF6VaHVJp-TvQ4fZrVjT9YlqkWH4dS80sckE-YSLrF_OueIJ3wP7TQ>
    <xmx:CF6VaJMXqrBBmuE01fNFj3bNQgDD57MkswGPz0EqzNE96Y0EovaSHQ>
    <xmx:CF6VaDYT8PCu00m6ielSvKH0IqkbfukGGgNYlIPaZDP2VYQzXwKN3Q>
    <xmx:CV6VaDhUszPx5LMuBGQa0NlPijuWDrB9K18hhkSSB_BANlYb-5Lo09P2>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 22:16:40 -0400 (EDT)
Date: Thu, 7 Aug 2025 19:16:38 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: futimens use of utimensat does not support O_PATH fds
Message-ID: <aJVeBt2FBl_cQOIO@localhost>
References: <aJUUGyJJrWLgL8xv@localhost>
 <2025-08-07.1754602716-spare-cyan-roughage-volcano-lW6q7A@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754602716-spare-cyan-roughage-volcano-lW6q7A@cyphar.com>

On Fri, Aug 08, 2025 at 07:51:26AM +1000, Aleksa Sarai wrote:
> On 2025-08-07, Josh Triplett <josh@joshtriplett.org> wrote:
> > I just discovered that opening a file with O_PATH gives an fd that works
> > with
> > 
> > utimensat(fd, "", times, O_EMPTY_PATH)
> 
> I guess you mean AT_EMPTY_PATH? We don't have O_EMPTY_PATH on Linux
> (yet, at least...).

Yes, that was a typo.

> The set of things that are and are not allowed on O_PATH file
> descriptors is a bit of a hodge-podge these days. Originally the
> intention was for all of these things to be blocked by O_PATH (kind of
> like O_SEARCH on other *nix systems) but the existence of AT_EMPTY_PATH
> (and /proc/self/fd/... hackery) slowly led more and more things to be
> allowed.

I do appreciate that. In large part, I'm trying to figure out if it
would be reasonable for this specific case to work, based on the premise
that it doesn't add any new capability, just makes an existing
capability available more consistently.

Having that would make it easier to write portable code with *fewer*
branches for Linux. It'd still be necessary to *open* files with the
Linux-specific O_PATH, but generic library routines that operate on open
files wouldn't have to change.

- Josh Triplett

