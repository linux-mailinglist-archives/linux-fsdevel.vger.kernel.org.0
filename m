Return-Path: <linux-fsdevel+bounces-9876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905C845A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8EE1C26D12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5365F46A;
	Thu,  1 Feb 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSCvLhgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BC5B66E;
	Thu,  1 Feb 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798033; cv=none; b=Jtmo1sNpvxEPoiEQtdC0VqTp51/aX9jfhgYUoNpY4BztHT+YG1rThw+RkWVHcF56LMqN7lpAu55m23QzGcNTC7gV1pLkhB7hw/nUjO7UPv9vTd1AFSm9HZ2ZtIVi4CNPExfjotNOmqlSkETE5WFizE8HB95rqJi5j0bN4cSeMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798033; c=relaxed/simple;
	bh=bIxYFsiQc3bXj3z5Nrgy2V+4LcYCWsj6oFu1pWwJn1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjlV0qBA4sBqDKTjXm+TMjgT50lg0pQaa4Q1FPoS882C9qaRFdMnPfUcCH/ybD/MoKrhdA4bL5M3ieeiGdrqvUObjUTrf/cfxyLuc/6rbClEaVbSVRL/OE7vz2T1KTboGLbS7cKO56+7IAqDWzb2/2JZb6tPbX0S9TrYfODHwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSCvLhgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAE8C433C7;
	Thu,  1 Feb 2024 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706798033;
	bh=bIxYFsiQc3bXj3z5Nrgy2V+4LcYCWsj6oFu1pWwJn1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSCvLhgipY/PQ1zd3DV/KxAx3gyok4VBHSeonXF41j8iylS5wM7VgDM0UJHFv2kvf
	 Zs21lsGtahA0H0ycDQUYNv89DcqHHg0uL5HmhzPTi20T5xfjS2pXVGCBA3iIMEF46E
	 pZ5iwHRywRwNR4OgoDvi+Hxk7TAbb3x6/rGbW50uwTQdmLMBQHyEcK5mAGt87jNuvF
	 btCahHpG/h3ohg5TJfJCR5CLKACWCiVgT+UbtFzx4j0z9n5kJ+6VOpq6rQ/uA0Llg1
	 +IdMCPdakfkzibsxAXKcEsgQHED5LyJuNevFbqMQYtx1yaPAG8WdNfmuvCdhvF7ZSj
	 6RIQD0TZLvuqQ==
Date: Thu, 1 Feb 2024 15:33:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 07/34] xfs: port block device access to files
Message-ID: <20240201-bemisst-wurfgeschosse-557646cb8ebe@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-7-adbd023e19cc@kernel.org>
 <20240129161714.GF3416@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129161714.GF3416@lst.de>

> Please avoid the overly long line here.

Done.

