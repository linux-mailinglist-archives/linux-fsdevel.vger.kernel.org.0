Return-Path: <linux-fsdevel+bounces-63802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB7BCE2F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 20:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D7546C09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB52F1FC4;
	Fri, 10 Oct 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Db1sDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDBC2EA;
	Fri, 10 Oct 2025 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119541; cv=none; b=IOj7KcJ7m8DAvcbVCjyFZhmTBYL2Zy7WnllfQhZEMUEwDAmZsVH2xHcUTRTUUjHWzADoMbSeauUwg2MnddwV14JS8NcPoB9ZVbtb85VxkqzemhwAHj3p8H7EiraDPz/uxQAQ13A6O6Sp4IqBJrjOV3QJ9m1dukmI5NpaYfqIThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119541; c=relaxed/simple;
	bh=bXaAtd0ZAtT3g66t4s1DrZe7nl/S25MHh/OuCmnvSnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu46V9vy87OJfg97ChXIzo2JJgbnoUPCWbi7e7EdqeUfqBC8KUdqaly90JecRJS3+uiLCmFV4LGiSqRhBRYveiNvfBwV3fmM1ux0nsCcVLFX9Zp0Hdt8HesvMIoCLMxjzWEGXgNpeVgFmgwlrTyGIVjYqODSgKXqCJx+Ac3v/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Db1sDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C6BC4CEF1;
	Fri, 10 Oct 2025 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760119540;
	bh=bXaAtd0ZAtT3g66t4s1DrZe7nl/S25MHh/OuCmnvSnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2Db1sDwNDpgB00o01QYKVNREYyMnv61ip//HC1HGaWSaZ5p97cKFfQn23vZ5NwHX
	 pPvaMi3oITNCQIOihRHjgzxjl9z5ANOQK2d2vJTgKAC1+uiCrq5Nkf96s6UGdKB68X
	 ssljcFmuLsUQ0s9OQkNYZ0zkV+QDoua++XRffKP2YTble2bOGzGPU/0XZbQb7zkGkW
	 UzSq2crCL4CGfofdYxiFC1Ja2+DlXPwpllL77bQ45xutQ0tYL26zeatdPQBipEDR3Z
	 Y0rQEvQWjtDNAMY96oBh1Iznk8UIJ0R9eI11CCl8OL7ephE5IGIzQlDITZcLQz8Puy
	 Wgum2S2XB+I/A==
Date: Fri, 10 Oct 2025 11:05:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/memory-failure: improve large block size folio
 handling.
Message-ID: <aOlK89Kd0V4xt5J-@bombadil.infradead.org>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010173906.3128789-3-ziy@nvidia.com>

On Fri, Oct 10, 2025 at 01:39:06PM -0400, Zi Yan wrote:
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
> 
> For soft offline, do not split the large folio if it cannot be split to
> order-0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
> 
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

