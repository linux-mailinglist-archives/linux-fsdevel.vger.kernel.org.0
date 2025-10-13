Return-Path: <linux-fsdevel+bounces-63936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FFBBD2066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37284EEE77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2772F5472;
	Mon, 13 Oct 2025 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7GUKc0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF752F28EE;
	Mon, 13 Oct 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343801; cv=none; b=jAVwih47rS2C6Jfd+EeT/O4v3/646Rm9CpCP8dyi7/lEBSsEGslLY8v7tf8X3U/d/wk/ZtrIlIh77I7TU0RZtzzbcOHv8wRLOzMlrEgDHw9uyKv/whwYUwol6UHQZbbXTbA7Hy05vPmmmndpxljlvFh47RBmkBz+hHUcBvw20tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343801; c=relaxed/simple;
	bh=cnSh8W6jhFCAzaT940CS+TKEufGQdg5GaKndRn4BVvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nchLc5pKhk1DEgbQItYu8VVB+x6+nDcgCYKHwsaUS7bhBeE9TFxArHffrc/47RHSUTbCSG0tpkOTslddGqyyq5ZB9aasiQfP0bGSTqmZwIqcpgFZUJw8a3BN+rzZVueUZzc/7ghvglNOR2Prm+kY4M3B6EYcf/+IUjGLCPRyq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7GUKc0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29EDC4CEE7;
	Mon, 13 Oct 2025 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760343800;
	bh=cnSh8W6jhFCAzaT940CS+TKEufGQdg5GaKndRn4BVvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z7GUKc0pKniE7mLAPZ/6pqdvN6WS2EGnlbQRlV7qxincVQQUZa2U3P7ChEwKeVC4x
	 SlEKS8xSrHY3CnyD3YbWDRS/kA0K60YGo053lr62M+geB650bwBSwyC8aQjQLkzuKk
	 kHFlR90vbfuxBpdkKSCdFPB8lmMCQ0ustwXMoTx+EvvSGfl74gubOnvcn+Vd+uQzft
	 dOtpQMN8sqT4KxQxAVE+mkkL349M6U9ZIrsk7THwobYeYosNK80tQEvOXdrX4Swmgj
	 iFt3eWBkG9Ar/XnxgL5APEFIX+GCqgi2thNRqaBVBW/tJDHGT8OJLVYu9/UXd4+e7s
	 660G6HX+IccMQ==
Message-ID: <6f7e9453-de4e-4f43-ac1c-aaf9322cc6a4@kernel.org>
Date: Mon, 13 Oct 2025 17:23:15 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: rename filemap_flush to filemap_fdatawrite_kick
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, v9fs@lists.linux.dev,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-11-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251013025808.4111128-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/13 11:58, Christoph Hellwig wrote:
> Make the naming consistent with the other helpers and get away from
> the flush terminology that is way to overloaded.

s/to/too

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

