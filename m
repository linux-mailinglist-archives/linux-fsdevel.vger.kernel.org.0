Return-Path: <linux-fsdevel+bounces-14682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA2F87E1BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDF8B20D4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151191E894;
	Mon, 18 Mar 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q4Uns/tv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530741E862;
	Mon, 18 Mar 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725629; cv=none; b=kMJuj09FMO7LTEEOugtfCPPe+Uetmup4UzPS2uFtYNvbTX9PTXCrvXRWth2m5rLMjMgjnx3l/qF+Limqb6voDjmrksKuyH5aI8rjKn+Owt9vsG8uPaGOtENOf1lCCzT8YDMKyzQnNjGGlpwtWIqZr1FlIumIqQrUWLvpN2Jur00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725629; c=relaxed/simple;
	bh=Z/Zha0VMB2Cj4m7MSuJUO2ntZzzgDHD/pa9eAZE3wic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceUh/zeqTl1joXDbF+yitA5ZWqbwZ0+Xi9GOBEZOd1uS0Z3iHLSmy34dFSprS7QW9gEOzkDO3D/oN4Pua3zLPqZ7ousXeQqzgsrZV0WIkFLimreRrTxq02prFArTJlps4UlcxXjT+1RxG2rCGnUvTG1LxFOn602uWZXeDptoy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q4Uns/tv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z/Zha0VMB2Cj4m7MSuJUO2ntZzzgDHD/pa9eAZE3wic=; b=Q4Uns/tvaHN/tGJxVnmLgIg4f1
	s/nbTcMJHwvbY9ZZsKVHoX1smYbDDVjR5cogxjI0ES7KglbWAZ+pISplCetwfrcy+87J6kCrYQX5q
	B6mYer6t+HWG7UEYUVuHO6NA8STA9EoV3hS1whuyC3dB6XCBsJRmGvvTPLumLUHfaUbE3ZZAA2kSz
	30/3YdHDwcdaoBW0SJ2mKp82473zeuDuwY5vq71srXeNpnxX5ak0I8YIygBvjD+7bJ1oa+/+H13Dx
	7Z5zDfCymwyUrx66lPlOXlilOfdDY8Pw8y4aCBdkRCRxSiPkGgAgKvALPG5t5mV63d9Lyizof6kaB
	ElNBy30Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1sp-00000006w9F-0jgj;
	Mon, 18 Mar 2024 01:33:47 +0000
Date: Sun, 17 Mar 2024 18:33:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 04/10] xfs: drop xfs_convert_blocks()
Message-ID: <ZfeZ-yyPaUYFa8ot@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-5-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Maybe just fold this into the previous patch?

Otherwise this looks good to me.

