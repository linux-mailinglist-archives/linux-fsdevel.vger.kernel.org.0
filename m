Return-Path: <linux-fsdevel+bounces-68039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5163C51BB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D643AA826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215B3054F0;
	Wed, 12 Nov 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjlnRFQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024430216D;
	Wed, 12 Nov 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943600; cv=none; b=roczaZnVi9IWltUdKUoHiw2eQKRn1Zk+lgMhgPzdOimcWIzTwmpE1iN4C/znK3D/FxWeBsFKqUW7/G0UgZBGsPPIHi+JM+miNHgRu45oB21FwsbpmkO4h6vTsSQmjeBNbMwJn1yuaaW9HPn8Z7CiKTkftIxLRnQBQLJH5yogUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943600; c=relaxed/simple;
	bh=r8LK2VJ3Eevnr7BtK0cuny+cLu2D3jhkTg+Q7KLQTHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kdugn3PZrQHshavOLlUou+nT+jS+b6Z9jXeSSIffDET4Yai6q9lm2CGBgIWb6A+cvBwx4ybq9P0DsNaN1nMKuiUttZxW/fNBifeP70g1BmlqhUtYsFEMeUAJ6Sxyp63Q8T+yPomL+ZLSkoL3uSNARtgicGm0bS7xjqeVh6MekqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjlnRFQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09525C16AAE;
	Wed, 12 Nov 2025 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762943599;
	bh=r8LK2VJ3Eevnr7BtK0cuny+cLu2D3jhkTg+Q7KLQTHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OjlnRFQeQ+IwMELnYavNEhHESEYwXPJAEYppqT3sSDWpEx4NwvqI25n7qiSgOHI5w
	 G8O4EAuRm2aEGquzV4ccBm4ZGWCJuMKbQ0iijzZcmYgiejOpcBKKgmFEjpL2Aa06ig
	 hd02NZQEF8zooWQzW0WU0KOvIx48n1zSrFZGcqqBpReqHZmvEBnQQxVjA6UMPaxfrt
	 HPTrse0rQ9PX6l650Fx/TkJNI9d8jn1Dho8F+GP8c3Dia3XBcGJLkk8ts1jjNsHeuB
	 Ckti22IhdzRsyYRHcXxaRJsdNPSaYAI1zZFLYaMn1z6UxnEN5H1ILdZZ0Eb7Ed9gA+
	 GY+Lar3hYOTRA==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031082948.128062-1-hans.holmberg@wdc.com>
References: <20251031082948.128062-1-hans.holmberg@wdc.com>
Subject: Re: [PATCH] xfs: remove xarray mark for reclaimable zones
Message-Id: <176294359763.682626.3489526462052577621.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 11:33:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 31 Oct 2025 09:29:48 +0100, Hans Holmberg wrote:
> We can easily check if there are any reclaimble zones by just looking
> at the used counters in the reclaim buckets, so do that to free up the
> xarray mark we currently use for this purpose.
> 
> 

Applied to for-next, thanks!

[1/1] xfs: remove xarray mark for reclaimable zones
      commit: bf3b8e915215ef78319b896c0ccc14dc57dac80f

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


