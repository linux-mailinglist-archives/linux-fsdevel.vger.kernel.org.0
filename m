Return-Path: <linux-fsdevel+bounces-32490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC89A6BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F43D281DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC31F4721;
	Mon, 21 Oct 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpQB5QA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993B1D173A
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519969; cv=none; b=SPa9PXm6SjwSSQKy05NUCDyoBJCCe5h85LLYokrizwNO4tI1PVApZYiI2ey2dtg59OGLrmdDPWYzUedmMmXXCBeskUrKE/LgSX3c24P7r4aSOeXKq5l9dXilOOQRmmvIq51hD77a3G/3H7m4fZASwhTI8uIUcaCEMzV5kO4aBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519969; c=relaxed/simple;
	bh=IDb9xSpv30TronugRNp8UP4X71cNA9tu/QiV2LOVMjw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=SHxUY/WLKpzNH0fSXovCXiVt/KgFaK7zZJSE//9sGVL2EYZjstRY5rDPk1LhCB5yfvr1lQlUWEuj+xA2N7FkMo0EOQvkc6S3Twbl7rDX2YtxF/n81RxgjdlWuFN7AU80BYJzoZxsEjrmqe7lrX1yjtV6jL0l8TwCXtYOcln3WbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpQB5QA7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729519966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mR3FP/DQ6+Xo+XN1mHGHcTtDN97yFl6gTBeWhnBQuc8=;
	b=RpQB5QA7gBAMR93ESm0rbqXnJa0nVH3nKaR875zMRpzWAqaosUWLjoaA9LSZgJCtDugqlI
	irKtddIbFe8NQPfdzvOHWYkoFY+7xk7gGnZbgdewurkRFIeeNB+e9jqwkSxTrvvu3Cti3h
	sOvqykN+tBOc/K3W7X9WOzwynmJd70I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-Kp1Y8g3kP2GMs3FMX-2NuQ-1; Mon,
 21 Oct 2024 10:12:43 -0400
X-MC-Unique: Kp1Y8g3kP2GMs3FMX-2NuQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2FAC1955F37;
	Mon, 21 Oct 2024 14:12:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61F811955F30;
	Mon, 21 Oct 2024 14:12:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxFQw4OI9rrc7UYc@Antony2201.local>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
To: Antony Antony <antony@phenome.org>
Cc: dhowells@redhat.com, Sedat Dilek <sedat.dilek@gmail.com>,
    Maximilian Bosch <maximilian@mbosch.me>,
    Linux regressions mailing list <regressions@lists.linux.dev>,
    LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2156439.1729519958.1@warthog.procyon.org.uk>
Date: Mon, 21 Oct 2024 15:12:38 +0100
Message-ID: <2156441.1729519958@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Antony Antony <antony@phenome.org> wrote:

> When using the nix testing, I have to force the test to re-run.
> 
> result=$(readlink -f ./result); rm ./result && nix-store --delete $result
> 
> nix-build -v nixos/tests/kernel-generic.nix -A linux_testing

Is there a way to run this on Fedora?

David


