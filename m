Return-Path: <linux-fsdevel+bounces-63094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C47BABD7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31025188AC69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBFB2BD016;
	Tue, 30 Sep 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTDbrtiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333B22EE5;
	Tue, 30 Sep 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217692; cv=none; b=e/dVZhAfv7xWtT0hTFPI7QwUln9DkfOdyyrld8CbePVYYjFZnHnd/t7KKztrgI5UJCZIExTiuXvfcYpTI//x/Y39EVAtoiM6xuwDwCcopZSe+FPg1vnM0ZoXO8ovL71H4x8JB49a+/kPytT5v/uwdm6NbXgwWWIWy21fZ8PN+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217692; c=relaxed/simple;
	bh=xyMCZ0DmVoh2j331NzXRy+v1+TC8o4J8u66Uk6VAjyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+qbt2BPbIYZ8CXQtvsncpZcdSUWRevFz4ylmm+whGZ869uTESbjh5ZyM2wunygggM54A6sJIfkKsDXeTnh9rJxiSXDpE4KopAS10+SfyIM3ZO6B0v/xEM5g4wEaL03T6WN19zRtsZCl3s1+zY5nxWyrDC8eXea/MulNI6pZjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTDbrtiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF5AC4CEF0;
	Tue, 30 Sep 2025 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759217692;
	bh=xyMCZ0DmVoh2j331NzXRy+v1+TC8o4J8u66Uk6VAjyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTDbrtizxlxY+K5TiLoPLdPXV8VDSRBK597kknM3dVj37ChSeljgL3QvfP8FYX/oM
	 vnoWhd97qLMrt+fG/XFe6UIEiSeO1w3pNHqAUrgXQshDXBXC6putUhps9ryC3V9I5H
	 yprwo1SH2LC2799q+S+kveUMPDUTCQ2v+60G89U8=
Date: Tue, 30 Sep 2025 09:34:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, stable@vger.kernel.org, jack@suse.cz,
	sashal@kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 6.6.y] loop: Avoid updating block size under exclusive
 owner
Message-ID: <2025093029-clavicle-landline-0a31@gregkh>
References: <20250930064933.1188006-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930064933.1188006-1-zhengqixing@huaweicloud.com>

On Tue, Sep 30, 2025 at 02:49:33PM +0800, Zheng Qixing wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> From: Jan Kara <jack@suse.cz>
> 
> [ Upstream commit 7e49538288e523427beedd26993d446afef1a6fb ]

This is already in the 6.6.103 release, so how can we apply it again?

thanks,

greg k-h

