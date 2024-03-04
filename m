Return-Path: <linux-fsdevel+bounces-13518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3908709E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA42821D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8878B46;
	Mon,  4 Mar 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld6eOT55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961861E487
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578388; cv=none; b=mbfs+6AFchu2XTvVDmfrW/uHuWzekcVTcrqnGrGKBMPqinBBOyHkcBkm4plv3nR1DFa1tFNLYFEd45o6bNPO0E7k5EPhKYYKLdd21qLrD/omWy3PYSfbsYBgDzZGeT/rSFWo0B/vlKCn75n3X5yXhrBnQYO3jabLE8y+BusCNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578388; c=relaxed/simple;
	bh=DFU6RzqGDNaF90mxu50jW2jDbrrzfIefbFjTGNK83Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPA96n3nGi4spZR3veFFvJtWZRll0QhClItsAw0SEXvsVUSXoLwXAMCR8K0MGMAzHRpLMuGl1KzR6E/sYm2CI3LZT4unKzlbZGKght+4feOZFdvktho/n1NUJXNau7uOs4WbKAFwXidceAKEI5vT4+5MameRAIX7HjOPfxdgOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6eOT55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC55EC433F1;
	Mon,  4 Mar 2024 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709578388;
	bh=DFU6RzqGDNaF90mxu50jW2jDbrrzfIefbFjTGNK83Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ld6eOT55UtRwB2mQyhRHLyhBRNPHuufXqKjewSBH37XPVCzq3bOZ2PMACttYYiPb1
	 G34rzqBLS0LgohqGj/5d0cojp5btQYUFvBFXtDN7eFJLeUc0TiGkKHvPfIzAW63jq4
	 SVBLIFzP8VS5xfMCYdanz5UrmfDW447jcp5Hlv9Tgu2rePJRA9A2cb0w+H0cO94a7m
	 SSIrIi2Xi9fgK5kCv4uW36DYIjWo/FNpUkUM/9LqWjtwdPLeYUfZBTy1fit7CGdjRu
	 YnsVHlgyPslRUGmdDFNKIqBl3LFMgOnEPlBFyA7Yya0PJpr/3+eQ8LuX5bxnXAJzwE
	 ZjOhJBH2aaNxA==
Date: Mon, 4 Mar 2024 10:53:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 0/2] Fix libaio cancellation support
Message-ID: <20240304185306.GA1195@sol.localdomain>
References: <20240215204739.2677806-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215204739.2677806-1-bvanassche@acm.org>

On Thu, Feb 15, 2024 at 12:47:37PM -0800, Bart Van Assche wrote:
> [PATCH v4 0/2] Fix libaio cancellation support

libaio is a userspace library (https://pagure.io/libaio).  In the future please
make it clear when actually talking about the kernel.  This patchset didn't
catch my attention quite as much as it should have, because it just said libaio.

- Eric

