Return-Path: <linux-fsdevel+bounces-50421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA96ACC039
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD073A4062
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300D1F4CB6;
	Tue,  3 Jun 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8VP4JxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9313AD05
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932308; cv=none; b=gwLZSwrFZBlzZgGPZ8ezBdXssC/ZU+Blmzes+qawpSI2O4Oxqby4EUCUA/gXzqso4RkbJZbVoUs9/s6fGYrGMRz7CVqAzzGj9/4mHXc2CioCJxkwQD7Q53dd3PFZhMuIDuVT57VbDRthr0n1AZbrhttJpFZ5/MqVs5gRKeds1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932308; c=relaxed/simple;
	bh=DTaWC0NkSXOoT7o1IbYuGBZMUzk4wAoEkhyQa0+uLr4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TU6I66p2wbOyKUpvnNw3pYd0H1gRESMrYyZt6kGckraIN5xaKeo/Xs3boiAkS79eTNXBWGn7hdwvq4mi/pyHXHDA6w/PF1GnF0sT4vVw1PIFOw0lTDbMeH5UkhS4DXVOyGsw0HcGgO5cotgNmriir5oIucBqyhRcaOoF0BcJ/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8VP4JxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85BFC4CEED;
	Tue,  3 Jun 2025 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748932307;
	bh=DTaWC0NkSXOoT7o1IbYuGBZMUzk4wAoEkhyQa0+uLr4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=j8VP4JxBboAEbKbTgrly8bM5XLAapF5NGGbtorH6HwgFbv5ysZHImbiTQ5jv5QbHT
	 S9LB3Q+JMhUHxjaTRyMDz+v5+vHo/ZFTRPR9AQRtVxnBWAbU8EixDZCAeWL9ogoapr
	 n366k8Y1R/cdOZFVKlJj6gkUY3n/N/8phzxRZfi3aIwbFterzLNSbDtFFIAvIRYQMk
	 0GhB24xgrcDZuKZhFZiFRglOgiwIWz9juU2sRk5LaaDUIRG17Vin4YU2mG+VdXeH63
	 VxKCYNq9R1HpwOtAIErJoa7a+adLAem5kZRTCkqWyyOtHBFegfcJrgctGTWpqa/boD
	 iNSdFizGWibcQ==
Message-ID: <f520c234-7b02-4087-a98e-33a51d2feba8@kernel.org>
Date: Tue, 3 Jun 2025 14:31:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Christoph Hellwig <hch@lst.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Fix __write_node_folio() conversion
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20250601002709.4094344-1-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250601002709.4094344-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/6/1 8:26, Matthew Wilcox (Oracle) wrote:
> This conversion moved the folio_unlock() to inside __write_node_folio(),
> but missed one caller so we had a double-unlock on this path.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
> Fixes: 80f31d2a7e5f (f2fs: return bool from __write_node_folio)
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

