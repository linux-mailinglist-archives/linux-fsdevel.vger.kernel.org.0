Return-Path: <linux-fsdevel+bounces-15698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048489246D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6422850B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 19:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C1613A244;
	Fri, 29 Mar 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRDABZzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A6320B;
	Fri, 29 Mar 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741558; cv=none; b=p20Nm8cdQ0ery7CqshKpGACoPNYDkKEmrj/k74RbYG84sviQeI5ID3/eZHOXcGA0ok0cuTO5RnrcBBGcTUf0XZ6pJT4fYMSMOyAHBjSYudBKnjbuCRdBiuXugmRFARnpApgCdo5D9xkImksmj0Z453iabbVxxAITk/Jp42hxwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741558; c=relaxed/simple;
	bh=7Q/uR5u3a6udkS9T32AT5v07UrQLmk4VHuNcOa+WmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJHJbtJ3pazUA6c+qr1ipcWleOfencRIlGM/5A80xczgmvlG6DJI9oRguoHq8L04bqG/NldD3QAQVj3efOC28ayG5zhtjUVmi/vdTA1B0XNDGgQX8A7bbV5aPdRtcXoISQg5bfsMbtmnQ19mYw1svpZRVC20MLQDDKhBcnitSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRDABZzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D9DC433F1;
	Fri, 29 Mar 2024 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741558;
	bh=7Q/uR5u3a6udkS9T32AT5v07UrQLmk4VHuNcOa+WmAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRDABZzn5UclH8ho/JxpYmHrX032RifvU+jPFKc7+zjlcMbBkwrqKOAGHEUPQmxr1
	 UnBb4xEi1q55D+XPmIKqDZwk7n1IfwXjfureK5ktdon5luc95K5sJWWRMEUDpIu8GZ
	 TuYwuGqTPXUxsGdZAeO6usytOFMaMyhu+M4t5dEjzB58CvNfclAATFOkzj7Tg6Xx3b
	 VuQzIKOuem9v1qiRTNEQoq4ZkaXHCw8OSmHr0JCcJP4x/F96dhnAdb3KbTFCn4VD9Z
	 4/tfGGSmqaRYQS3abZVvq+mCAbakCr5oymMXKRjBxbxX5HPVDwwzRHzn0/e2+NdWuH
	 u1C1eW3+iHXkA==
Date: Fri, 29 Mar 2024 12:45:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] vfs: export remap and write check helpers
Message-ID: <20240329194557.GM6390@frogsfrogsfrogs>
References: <171150380628.3216674.10385855831925961243.stgit@frogsfrogsfrogs>
 <171150380682.3216674.8890477329517035702.stgit@frogsfrogsfrogs>
 <ZgP99DN7v9NVJhPs@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgP99DN7v9NVJhPs@infradead.org>

On Wed, Mar 27, 2024 at 04:07:32AM -0700, Christoph Hellwig wrote:
> 
> Seems like this is the only patch Cc'ed to the fsdevel list.  Which
> makes it really hard for anyone not on the XFS list to actually
> review this properly as they won't see the caller.

Oops, I forgot to add fsdevel to the cc list for this series.  I'll
resend the series.

--D

