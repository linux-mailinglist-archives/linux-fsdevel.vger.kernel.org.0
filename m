Return-Path: <linux-fsdevel+bounces-63320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E62BB4BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1835424825
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CE2749E5;
	Thu,  2 Oct 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3wLJxkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880A433A6;
	Thu,  2 Oct 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427029; cv=none; b=iFIbY5xBBYnfR03HM/tBEeDGquAEDpuZV2So+isYVL5lpRUbZHIus7Gq68kQ2hjliY41la8Ykfe1OpO8dib+Jl8Fq84sts6Todd/rEdOXpvaX0WXiXZWP6catvWfM9Fuv6CsaHnbGg2wKx36U7bF+XCmE4ffs5tQR7Ma4SCJRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427029; c=relaxed/simple;
	bh=ZZ8PWqi6cNje4lj3U2qSrTAVGZuCb8id8xvf5O0tM38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOkv9+Qv+7XwzoNYIZbe353aYZ1tmRtxrV2cVFV3H7g7wlNqU7spVxoAzqrUVsmYGvkDchY0J/CTbTA+N8g5tHQDga1SeYLceqzsY9LCAEsZpSBJmN0cvyyXNLfk4QQ5HqykS3f2Xs0Xn8SQT1m3C4xobffVJOwRaMgWx7CZ+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3wLJxkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FFAC4CEF5;
	Thu,  2 Oct 2025 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759427028;
	bh=ZZ8PWqi6cNje4lj3U2qSrTAVGZuCb8id8xvf5O0tM38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3wLJxkGI6ANEihThS37BGeLsyUU7xCe+x0PnrtQJywurVoGVOqnvhPDXg5wpmtf3
	 sN1brSBoA3jHnSHeX1JmyTeu/gx/4b9rs78oMI979cGBVYaxigUlVZRJJ1Uc5jwDNu
	 tUmU3Gj5RyUc1niSe8x2RaZ+c9Q0b92rBT1WxQa5LxNXP2eQlUSIBGV+Nc9f/CRlzQ
	 8Nz+4CUEdP+6WhgxKGNZpO3WRLV4FNM9fIt2SDMfz7Ixorbjalpvs7eJbQs1t30Hau
	 hBR2C5oQLTSr7rKDbut9IC3RaE3eTg56ua4NN5+NWLU7Mm4Vhr27WRFfcwdKrFT+0K
	 uBNYki/jmbFBA==
From: SeongJae Park <sj@kernel.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: SeongJae Park <sj@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: redefine VM_* flag constants with BIT()
Date: Thu,  2 Oct 2025 10:43:44 -0700
Message-Id: <20251002174345.58777-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002075202.11306-1-acsjakub@amazon.de>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Oct 2025 07:52:02 +0000 Jakub Acs <acsjakub@amazon.de> wrote:

> Make VM_* flag constant definitions consistent - unify all to use BIT()
> macro.
> 
> We have previously changed VM_MERGEABLE in a separate bugfix. This is a
> follow-up to make all the VM_* flag constant definitions consistent, as
> suggested by David in [1].
> 
> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> 
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

