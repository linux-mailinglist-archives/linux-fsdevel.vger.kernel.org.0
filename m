Return-Path: <linux-fsdevel+bounces-55257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4CB08CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 14:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A971AA2FAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E22BE7B5;
	Thu, 17 Jul 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PLo8BVzw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844982BE059;
	Thu, 17 Jul 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755325; cv=none; b=LVT71SkDOem8xqur/dkqPxUqQoVoxyjL55PiiMZS8n/oPMq17D2wUa86DwOWzcEXoqhxsa0NApQFGA2BseWSphK49bmQ0BO3JGk9QTHwQzrdw9T9MRN6K3pjA0Uy/D6Z7DxY6YF01ZH1stO5vtfabhO+/Hgqx9ZWsYVoeEqqW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755325; c=relaxed/simple;
	bh=d5GPY6+EZ6mRgYrdpPs1ynD/OAn2P08khg8Ba4H8drc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4N5ape4hNcvNNbJIDqvUNFko+MKvNQ8IUhHLhAePgO4CBJ0BMKoonO7uzkjpyAHE59tn2uF69cqPf/22NoPTPCrWwq41NFyoKswSvkN5vuXeTuo4XQi07TgwnxHa/Gk6h1n0J2rJIbxwLnlnfD/RqqLYDrluuWQrt4Yho6Grts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PLo8BVzw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=37Vi48YRWVQmb3VFgSH/G8+DqwhfUKL8oBiryR95q34=; b=PLo8BVzwVn5DIdBozq4OecFnNX
	rPvVXa9ejJOnHJre58M0AW0VBM4mltchSkHeHPOgDkPyezh4l+uqj+9axkjVYDM/b35+SPjcMjckb
	YJLjb+5bIYo1hEvupPIGTN6+5jmN+6rSTjqSGZs9UQoejLGzOpQkC643sUcszpB+tmDjn4+E2kR2L
	9VNviXLofH647XvNHB12NqkJoBqa03Kl0zmgXYqwShYLgBOJ6cmO8LhnBcSJH9L9s1ASh7fPXqdTL
	LxTT4HHxubarP5+NJB4wtNW4L5f72rK1wqwxFDnVc2ffTKx0dlzu6OboDENIPjrurLtLsXoo8DEzk
	0HclvwKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucNj5-00000002rZy-35s4;
	Thu, 17 Jul 2025 12:28:39 +0000
Date: Thu, 17 Jul 2025 13:28:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Darshan Rathod <darshanrathod475@gmail.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/aio: Use unsigned int instead of plain unsigned
Message-ID: <aHjsdy3LDpkzIgJG@casper.infradead.org>
References: <20250717115138.31860-1-darshanrathod475@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115138.31860-1-darshanrathod475@gmail.com>

On Thu, Jul 17, 2025 at 11:51:37AM +0000, Darshan Rathod wrote:
> All instances of the shorthand type `unsigned` have been replaced with the more explicit `unsigned int`.
> 
> While functionally identical, this change improves code clarity and brings it into alignment with the preferred Linux kernel coding style.

says who?  i prefer plain 'unsigned'

