Return-Path: <linux-fsdevel+bounces-9349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E18402A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C21283C8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2756454;
	Mon, 29 Jan 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDnlApuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15255E58;
	Mon, 29 Jan 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523446; cv=none; b=Ik7wSbBjpuppV8Ywo+7/JEeebwi/hnSaVMEkdEctIgSHmlk7GRLMq3jUr2aG/OJf6tA1Q13Mah+kPzmMQt02zCjvE24BlIwakbViMKTwnhMUKY/75mrX/5Cd4+9PQy1+pSQ1d7SLNmghE+1P8sXRqvdNcSSXzISE6csMJi3Gtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523446; c=relaxed/simple;
	bh=nqKH6bbr2WgppiD8DlUEz4zjxck74btYqYML3JnXRDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI9XXKf4zVK6KAwH+gnPLhxl17qlpZcg7PvCZTre68//e36BxXRWe7d2600SbO134KLup+44fzAuCg6su1yw6CV43A8Ra8mKw6IwODvEHJhNsLRlZ32/dYSvh1wVxMC3bhMlctQIWfwEtANZA/oaMvxkWGFwUng/zJQfRKjl/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDnlApuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B8FC433F1;
	Mon, 29 Jan 2024 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706523445;
	bh=nqKH6bbr2WgppiD8DlUEz4zjxck74btYqYML3JnXRDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDnlApuKQsuj2iXvZ16VuwVXFWye1O70ANg0fJrFG1pscPav30Jnvp3fU88Pbi33F
	 PqYH+p36YBzzOo7UYlpiASpBeHFKdX/c8V/8Oo9fUsuEDPj7QZJ9OHjgpwBGQSSMfE
	 7UHIqt6Zkyzoe1/s8vCtdFWkFk0AsIaaH0MFKeu72c173vG/lPFyfXZTRO/FvjyIEo
	 dybVs/g47lPX2iWF3c9E+4jf3uiEimBkhy0dL8VoejZRafk3hz5p23PtSmxFWn9oG8
	 9ylIP5k8dMf7p5o4IA3lrKB5h5+ap1pDbPuHOznOBa+4ZU+k120/rnJfxZJrWlIjCb
	 GvMry0Jk6cpRQ==
Date: Mon, 29 Jan 2024 11:17:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240129-haare-einpacken-d73cb64bf524@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240129061707.GC19581@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129061707.GC19581@lst.de>

On Mon, Jan 29, 2024 at 07:17:07AM +0100, Christoph Hellwig wrote:
> Do you have a git tree for this series? 

b4/vfs-bdev-file on vfs.git

