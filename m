Return-Path: <linux-fsdevel+bounces-41428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF59A2F5F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FFA18803A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7125B68B;
	Mon, 10 Feb 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="mX7KiW8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nADWn/nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BA25B680;
	Mon, 10 Feb 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210027; cv=none; b=h0o/yovoXedNHN+7buyRqC0fMUfQE0kWuY2Wlof4Pvd3mtjQZkjEkipwEDXKDSgrNq8QaB6xMn3wTjpdMjcC7mJ1dGnbymnrAoJQt0Io7OUATD8pCQ/oWDqXxRD/vFF2EdljFFvc79nkJsZGqMnRjIboMcPwA43DFs+QlXnQo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210027; c=relaxed/simple;
	bh=g4hD9FU044pQJDiMUw+fFqeYHEj1TgqWTXH3iBwJrkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+Yiz3vqZHy2yed6/nEUiP2PfGHfVu/k7o9WpeEHz/UL4bM44YNzX7LYS4J149poFRTYE2oICMwlGwWiL7w6geS3E/ayyvGuJU8cTiYvtUocf/YpL231aevXLFQlBPudlSf4+rHqlvfwCV5u1GlQ4Kj/mYbjwZjmCWsgjjXwc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=mX7KiW8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nADWn/nf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83DD72540135;
	Mon, 10 Feb 2025 12:53:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 12:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739210023; x=
	1739296423; bh=9YNp4mbohM/7lWf7uXTJa3pcrFvbaYJczil0eE5s/Tc=; b=m
	X7KiW8eJ7fsz9er8oiEGA9j2sthF2lsHF4fw5aoI4VXRGIskHsAboyuX4Ya3aX6z
	O32CcGTn625nzZ1dMroVnJ6D+yrcadUws74AXu3snihjbTwr6Fy27C5fdEV2WMR5
	8pDYeZHHLMKpZbUWzzmhnI743b4Ke6Ly9FKGAdh4QY/UrtgufpySQQxzMUy5eU7K
	u5gK2Yljp0LbY8wBuIRfQcVtY31x2c6uSBdD+1YeLIAVIbnlpjCd6feZF1zTPWEJ
	4ZWlP196DIeg+h3VTRN5sEzBoG7QVtnRvNvo2G+SxtmP0svKOJZ7h0lXwT59VZiF
	EG4tYS0fEDrQDYq5+yxiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739210023; x=1739296423; bh=9YNp4mbohM/7lWf7uXTJa3pcrFvbaYJczil
	0eE5s/Tc=; b=nADWn/nf34RFQ9hy1ns2O4bHDiVhrzes1ytP9wbOur331SzhB4G
	Og/M5rML1fKw5H9cyXtQaRvIUNSsb+ol2IEcOrhVSJaPdrZ6IJripYlQ4iHh2Bg+
	rOTO8zo4yLoluvfdR8mSaGMTNRLL91kU8DL9mL/p6SsynwuNYSu8v4NwL47e7mLH
	aOtF/C9j4otTDXLO7fHcUKPrY0LsG0qDqj2xhPQAAX/qSD2h0NkYslg577TWUR87
	Q0qNB7TWsZ/B//IPqOTdFVfr1tdL7wLLYrLPzSfaB0JZ+l+5md0kosDGsbx3UoGg
	kF3l8NNXCgFhEpejrxZwSXckywTpiO3AvpQ==
X-ME-Sender: <xms:Jj2qZ1X5QKiMIF0WMtUUADbP5bcq1w5C5zKLehz8QAURUcdKRToDcA>
    <xme:Jj2qZ1mj_ts1e6D9lU1YmLYC1A2BCwDT_45Ej62PDFsWr-yc37q-fKm-q9Pp1hUjf
    vEoZfDig-FZJs3N8NQ>
X-ME-Received: <xmr:Jj2qZxbbmS21-RUUGPaxp7K8MZnyQ-iGdlx8p7Og7aVp2Mh21V-VGh61WdMRfqqAxz1erae_eERKeOTgM5FyRqsIc3Jy1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehi
    nhhrihgrrdhfrhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:Jj2qZ4V4g_a7bgpbXcYypZhG0TuLqtlIA1S8isTJzLz5FcgS5JUEOQ>
    <xmx:Jj2qZ_mSIcEpsNEmdPdxMqccuGjkJHDIs3LQzOtfBm7yYaYdXPuBlA>
    <xmx:Jj2qZ1fmyVFc6QOSJgLFG_rKewDiC4ib-orj-s1YhZ0qUhhYGZSnQg>
    <xmx:Jj2qZ5HOunSPNAw0Ife39dI5YEfkaSSSTdy9WVxumpzJ6JRT08Fwhw>
    <xmx:Jz2qZ4jEqzdgQ8PgV_S73J_t6e9k_R9_PZpCp0lL3IR-qMLFKd6eo8LW>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 12:53:41 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  cocci@inria.fr,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] debugfs: Manual fixes for incomplete Coccinelle
 conversions
In-Reply-To: <20250210114531.20ea15cf@gandalf.local.home> (Steven Rostedt's
	message of "Mon, 10 Feb 2025 11:45:31 -0500")
References: <20250210052039.144513-1-me@davidreaver.com>
	<20250210052039.144513-6-me@davidreaver.com>
	<20250210114531.20ea15cf@gandalf.local.home>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 09:53:40 -0800
Message-ID: <86cyfp3cuz.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:
>
> Why are you adding these defines?
>
> All files should be just including <linux/debugfs.h>
>
> so that they can use either "dentry" or "debugfs_node" while you do he
> conversion.
>
> Then the last patch should just modify debugfs and debugfs.h and no other
> file should be touched.
>
> I'll comment on the last patch to explain what I was expecting to be done
> that should satisfy Al.
>
> -- Steve

Hey Steve, there are two reasons for the temporary defines:

1. There are a few files touched in this series where replacing the
   define or later forward declaration with an include <linux/debugfs.h>
   caused errors related to circular includes.

2. The heuristic of adding a define or forward declaration wherever a
   struct dentry declaration existed was far easier to automate than
   conditionally adding an #include <linux/debugfs.h>. It is harder for
   Coccinelle figure out where to put the #include if there multiple
   #include blocks, no #includes in the file, etc.

However, I'm having trouble reproducing point 1. I'd be happy to use
#include <linux/debugfs.h> instead of forward declarations. I'll see if
I can find a way to mostly automate that. There are "only" 56 additions
of struct dentry forward declarations so far in this patch series, so
even if I have to eyeball these #includes by hand that might be okay.

Thanks,
David Reaver

