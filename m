Return-Path: <linux-fsdevel+bounces-22511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83591822A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8312865C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933A1862AA;
	Wed, 26 Jun 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfkYJ13z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D818628D;
	Wed, 26 Jun 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407780; cv=none; b=XYmKzBswQvblPzKriHlVUEhZsWDEinCAfOs/aIaLJu9rmO+YZyW7F5Ae5Wy0eGt82nOjFQ1BHSxKdYW5lZHe3+GayCceTSGosdljbudH9u2llC37ICrmSxTMR+KWwbiKGhNvxwCzhGu/za9IOou/jduWIIr745pAOTQE/KlRqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407780; c=relaxed/simple;
	bh=V7D5WN39TEPTg1ZX2xRMHcPRu52TjM3lQojgbcFDHjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei4rHHR9L43+lmbrRZHJZa0WLCj//13IVgB1znSvACj3ZoGPsLaujMl/mo1rGNizlznMwr5yTA6tkhmQKeUDIRRU3YDSuyhYxEGJEoUn36bNHGbxDkBn/PImppQ3L67JKF+8tn4G4Ld/d3/olF9AZ6BV5iQOr3irBTFKHg7lwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfkYJ13z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF8C2BD10;
	Wed, 26 Jun 2024 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719407780;
	bh=V7D5WN39TEPTg1ZX2xRMHcPRu52TjM3lQojgbcFDHjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfkYJ13ztwLMcfMlYnYQ8zXya09i11g0JljVaOOsPtuEuAEMaQvpboKR37dmGH0v3
	 S/aV/ukLgGe5HEx0Db1GTN8C9j5nVjPjFLTbE0Db5HMHDmUHsgAPfT/5tWC6upzSEM
	 heWXdMwgYVhS4WaZ1aieD6OCXs8iet+uJDqZC68U40h+WY3HY+DqIoptsdWLdpD5H3
	 tB7Kr0zM/pCXpsPWcgyKYuuNK3f1H7ixhYxqsxAy3Unaib+0+N2fEZFtdQGc4SUY+7
	 cl45cSlKZloFF9WZv6MoRSbHvbp7KkmnnxnD89Xn6POoIlzIK++q5G6rdkKrqYaA10
	 EKdcWGXRECS9g==
Date: Wed, 26 Jun 2024 15:16:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org, 
	hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com, wozizhi@huawei.com, 
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH RESEND 0/5] cachefiles: some bugfixes for withdraw and
 xattr
Message-ID: <20240626-ballungszentrum-zugfahrt-b45c1790ed7b@brauner>
References: <20240522115911.2403021-1-libaokun@huaweicloud.com>
 <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f357745-67a6-4f2e-8d69-2f72dc8a42d0@huaweicloud.com>

On Wed, Jun 26, 2024 at 11:03:10AM GMT, Baokun Li wrote:
> A gentle ping.

Hm? That's upstream in

commit a82c13d29985 ('Merge patch series "cachefiles: some bugfixes and cleanups for ondemand requests"')

