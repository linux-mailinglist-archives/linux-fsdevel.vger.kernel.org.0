Return-Path: <linux-fsdevel+bounces-27507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5242961D4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AB31F2413B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92369145A0F;
	Wed, 28 Aug 2024 04:05:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171C3FEC;
	Wed, 28 Aug 2024 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817932; cv=none; b=fBQr5GHsmsfHL9zBuwThiJRa17AtBMSGLlVvu/g6WrvK6yYHtwN98+OzlrwQeCndbyHk9s+jMgyFEjRm606xmmQHNzaaNc6dDjC27//l/j5JTBp7tz3veDjqpf994dZjkHaBHyStcERppzdDzSWNuwuiE1rBftoFPjLxNjRpfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817932; c=relaxed/simple;
	bh=831rvJ/eAdtgU+iT/jKaDUEXZIFTHfRT0pflZ0pDUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcNI9uJ2JUWNVcGwqZGgusni22SNBP4DRoA9oncUBHmKsNTOjbnoJ0eNVbaOe0BJqqMJkza6xvQYtg9A/HzMkGlSIP5EHpI/XlNrCOloqzHEF6HIUC8DkLWHohpwZvsu+MTR7DoBjVxGs4ZxSDzKJDfrffgx8pxG/h/qKjnG3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4641227A88; Wed, 28 Aug 2024 06:05:26 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:05:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: sort out the fallocate mode vs flag mess
Message-ID: <20240828040526.GB30409@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-4-hch@lst.de> <20240827145502.GP865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827145502.GP865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 07:55:02AM -0700, Darrick J. Wong wrote:
> For a brief moment I wondered if it were possible to set more than one
> mode bit but it looks like none of the implementations support that kind
> of wackiness (e.g. COLLAPSE|INSERT_RANGE for magicks!) so we're good:

Yes, we check for all possible mode combinations and reject them already,
just in had to read an not extensible way.


