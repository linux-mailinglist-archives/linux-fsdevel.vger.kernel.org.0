Return-Path: <linux-fsdevel+bounces-58689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA9B307EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1710D581F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF417214807;
	Thu, 21 Aug 2025 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GM3OqV9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D1393DE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810000; cv=none; b=sBxN3lSE1VdleL/EKk8VN6OP2U40F2e3xan4NLHRuF0Mnqd1DGtfNVrt7vXGlvEXvU5YiS4sGGQGZLjZAufzyo7ayPn6Pd4XmPvjgTGt8Rq/02h5llurVoAheHCsZDMXrenZQOyiaFxlcVJKSzHcSZJAp84H/+SZZNC64om6/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810000; c=relaxed/simple;
	bh=GpcCxn9GfF5EUrbeHIDHmZBthwjprD4p8VNgAbhXB74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brYqX7rJ41UWQkOKU7TKuo9vkdDIq2baqncWEp4mdw2gMwRMLCzaGrwjx5QD4FDRJISjlLiw5csWlq/IvZ8Lo3GNeS1f5a/2ibF4EvddwktiXfG5jf51LT56N+wOcPsR8LLN55gQK4qRgLMu3U6WhBPIRCslzI/SNrolzlzRvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GM3OqV9w; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-69.bstnma.fios.verizon.net [173.48.113.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57LKxonH010259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 16:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755809992; bh=1UZbu40+NQ+L5f8C12ebvpREaa+BoEnTLmppeBFRg54=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GM3OqV9wnYmT9cWN6othS4pgEltxzdaGFZkj4zsS/P7WuhwQaNtEDNw0Qxsw0awmi
	 DAKCTnSUzenocS30OaAzz6+5glF17HRa5v+vrEAgNjdL2Z4O4f3DBwuyMJAtZBGjwc
	 wo3OHtGbbdxbyS/vgfNMMRB/L8vrchOwjmiWq9mre8iSeigy+CeIhq0jxFecQ5R8Dn
	 m6ZLIgKeduQ0d/tNz3qN1a/mxBHEaPiNyVyZTpzIuVVIGyelsCejACShbcnagcvqgv
	 dV/LCkxIGl81R6EuirgNBJVkM1nXL97//lLmblo9p8UrF/5/e76MxxNVj4WHswTpS2
	 fkGV00vXZl4Rw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC2CF2E00D6; Thu, 21 Aug 2025 16:59:50 -0400 (EDT)
Date: Thu, 21 Aug 2025 16:59:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250821205950.GB1284215@mit.edu>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821203407.GA1284215@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821203407.GA1284215@mit.edu>

On Thu, Aug 21, 2025 at 04:34:07PM -0400, Theodore Ts'o wrote:
> (2) is a very hard problem, and so there is a tendency to focus on
> solving problems (1) and (2).

 "solving problems (1) and (3) instead."

Apologies for the typo.

						- Ted

